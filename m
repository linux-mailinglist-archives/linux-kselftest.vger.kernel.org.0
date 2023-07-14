Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF0C2754412
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Jul 2023 23:06:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235220AbjGNVGp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 14 Jul 2023 17:06:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235609AbjGNVGo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 14 Jul 2023 17:06:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEC6F2735;
        Fri, 14 Jul 2023 14:06:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8950561DEC;
        Fri, 14 Jul 2023 21:06:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D029C433C8;
        Fri, 14 Jul 2023 21:06:40 +0000 (UTC)
Date:   Fri, 14 Jul 2023 17:06:38 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Ajay Kaher <akaher@vmware.com>
Cc:     shuah@kernel.org, mhiramat@kernel.org, chinglinyu@google.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, lkp@intel.com,
        namit@vmware.com, oe-lkp@lists.linux.dev, amakhalov@vmware.com,
        er.ajay.kaher@gmail.com, srivatsa@csail.mit.edu, tkundu@vmware.com,
        vsirnapalli@vmware.com
Subject: Re: [PATCH v4 09/10] eventfs: Move tracing/events to eventfs
Message-ID: <20230714170638.09ef0c76@gandalf.local.home>
In-Reply-To: <1689248004-8158-10-git-send-email-akaher@vmware.com>
References: <1689248004-8158-1-git-send-email-akaher@vmware.com>
        <1689248004-8158-10-git-send-email-akaher@vmware.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, 13 Jul 2023 17:03:23 +0530
Ajay Kaher <akaher@vmware.com> wrote:

> Till now /sys/kernel/debug/tracing/events is a part of tracefs,
> with-in this patch creating 'events' and it's sub-dir as eventfs.
> Basically replacing tracefs calls with eventfs calls for 'events'.

[ note: /sys/kernel/debug/tracing is deprecated. Please avoid referencing it. ]

Up until now, /sys/kernel/tracing/events was no different than any other
part of tracefs. The files and directories within the events directory was
created when the tracefs was mounted, and also created for the instances in
/sys/kernel/tracing/instances/<instance>/events. Most of these files and
directories will never be referenced. Since there are thousands of these
files and directories they spend their time wasting precious memory
resources.

Move the "events" directory to the new eventfs. The eventfs will take the
meta data of the events that they represent and store that. When the files
in the events directory are referenced, the dentry and inodes to represent
them are then created. When the files are no longer referenced, they are
freed. This saves the precious memory resources that were wasted on these
seldom referenced dentries and inodes.

We should also include memory metrics of both improvements from
/proc/slabinfo and /proc/meminfo.

> 
> Signed-off-by: Ajay Kaher <akaher@vmware.com>
> Co-developed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> Tested-by: Ching-lin Yu <chinglinyu@google.com>
> ---
>  fs/tracefs/inode.c           | 18 ++++++++++
>  include/linux/trace_events.h |  1 +
>  kernel/trace/trace.h         |  2 +-
>  kernel/trace/trace_events.c  | 67 +++++++++++++++++++-----------------
>  4 files changed, 55 insertions(+), 33 deletions(-)
> 
> diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
> index 76820d3e97eb..a098d7153498 100644
> --- a/fs/tracefs/inode.c
> +++ b/fs/tracefs/inode.c
> @@ -374,6 +374,23 @@ static const struct super_operations tracefs_super_operations = {
>  	.show_options	= tracefs_show_options,
>  };
>  
> +static void tracefs_dentry_iput(struct dentry *dentry, struct inode *inode)
> +{
> +	struct tracefs_inode *ti;
> +
> +	if (!dentry || !inode)
> +		return;
> +
> +	ti = get_tracefs(inode);
> +	if (ti && ti->flags & TRACEFS_EVENT_INODE)
> +		eventfs_set_ef_status_free(dentry);
> +	iput(inode);
> +}
> +
> +static const struct dentry_operations tracefs_dentry_operations = {
> +	.d_iput = tracefs_dentry_iput,
> +};
> +
>  static int trace_fill_super(struct super_block *sb, void *data, int silent)
>  {
>  	static const struct tree_descr trace_files[] = {{""}};
> @@ -396,6 +413,7 @@ static int trace_fill_super(struct super_block *sb, void *data, int silent)
>  		goto fail;
>  
>  	sb->s_op = &tracefs_super_operations;
> +	sb->s_d_op = &tracefs_dentry_operations;
>  
>  	tracefs_apply_options(sb, false);
>  
> diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
> index 7c4a0b72334e..c6bb74cccea3 100644
> --- a/include/linux/trace_events.h
> +++ b/include/linux/trace_events.h
> @@ -635,6 +635,7 @@ struct trace_event_file {
>  	struct list_head		list;
>  	struct trace_event_call		*event_call;
>  	struct event_filter __rcu	*filter;
> +	struct eventfs_file             *ef;
>  	struct dentry			*dir;
>  	struct trace_array		*tr;
>  	struct trace_subsystem_dir	*system;
> diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
> index 79bdefe9261b..d9a0ec2b918e 100644
> --- a/kernel/trace/trace.h
> +++ b/kernel/trace/trace.h
> @@ -1309,7 +1309,7 @@ struct trace_subsystem_dir {
>  	struct list_head		list;
>  	struct event_subsystem		*subsystem;
>  	struct trace_array		*tr;
> -	struct dentry			*entry;
> +	struct eventfs_file             *ef;
>  	int				ref_count;
>  	int				nr_events;
>  };
> diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
> index 12ed71428939..4058178de682 100644
> --- a/kernel/trace/trace_events.c
> +++ b/kernel/trace/trace_events.c
> @@ -990,7 +990,8 @@ static void remove_subsystem(struct trace_subsystem_dir *dir)
>  		return;
>  
>  	if (!--dir->nr_events) {
> -		tracefs_remove(dir->entry);
> +		if (dir->ef)
> +			eventfs_remove(dir->ef);

Why the if statement? eventfs_remove() has:

void eventfs_remove(struct eventfs_file *ef)
{
	if (!ef)
		return;
	[..]
}

Let's get rid of that.

>  		list_del(&dir->list);
>  		__put_system_dir(dir);
>  	}
> @@ -1011,7 +1012,8 @@ static void remove_event_file_dir(struct trace_event_file *file)
>  
>  		tracefs_remove(dir);
>  	}
> -
> +	if (file->ef)
> +		eventfs_remove(file->ef);

Same here.

>  	list_del(&file->list);
>  	remove_subsystem(file->system);
>  	free_event_filter(file->filter);
> @@ -2297,13 +2299,13 @@ create_new_subsystem(const char *name)
>  	return NULL;
>  }
>  
> -static struct dentry *
> +static struct eventfs_file *
>  event_subsystem_dir(struct trace_array *tr, const char *name,
>  		    struct trace_event_file *file, struct dentry *parent)
>  {
>  	struct event_subsystem *system, *iter;
>  	struct trace_subsystem_dir *dir;
> -	struct dentry *entry;
> +	int res;
>  
>  	/* First see if we did not already create this dir */
>  	list_for_each_entry(dir, &tr->systems, list) {
> @@ -2311,7 +2313,7 @@ event_subsystem_dir(struct trace_array *tr, const char *name,
>  		if (strcmp(system->name, name) == 0) {
>  			dir->nr_events++;
>  			file->system = dir;
> -			return dir->entry;
> +			return dir->ef;
>  		}
>  	}
>  
> @@ -2335,8 +2337,8 @@ event_subsystem_dir(struct trace_array *tr, const char *name,
>  	} else
>  		__get_system(system);
>  
> -	dir->entry = tracefs_create_dir(name, parent);
> -	if (!dir->entry) {
> +	dir->ef = eventfs_add_subsystem_dir(name, parent);
> +	if (IS_ERR(dir->ef)) {
>  		pr_warn("Failed to create system directory %s\n", name);
>  		__put_system(system);
>  		goto out_free;
> @@ -2351,22 +2353,22 @@ event_subsystem_dir(struct trace_array *tr, const char *name,
>  	/* the ftrace system is special, do not create enable or filter files */
>  	if (strcmp(name, "ftrace") != 0) {
>  
> -		entry = tracefs_create_file("filter", TRACE_MODE_WRITE,
> -					    dir->entry, dir,
> +		res = eventfs_add_file("filter", TRACE_MODE_WRITE,
> +					    dir->ef, dir,
>  					    &ftrace_subsystem_filter_fops);
> -		if (!entry) {
> +		if (res) {
>  			kfree(system->filter);
>  			system->filter = NULL;
>  			pr_warn("Could not create tracefs '%s/filter' entry\n", name);
>  		}
>  
> -		trace_create_file("enable", TRACE_MODE_WRITE, dir->entry, dir,
> +		eventfs_add_file("enable", TRACE_MODE_WRITE, dir->ef, dir,
>  				  &ftrace_system_enable_fops);
>  	}
>  
>  	list_add(&dir->list, &tr->systems);
>  
> -	return dir->entry;
> +	return dir->ef;
>  
>   out_free:
>  	kfree(dir);
> @@ -2420,7 +2422,7 @@ event_create_dir(struct dentry *parent, struct trace_event_file *file)
>  {
>  	struct trace_event_call *call = file->event_call;
>  	struct trace_array *tr = file->tr;
> -	struct dentry *d_events;
> +	struct eventfs_file *ef_subsystem = NULL;

Move this around to keep the upside-down-xmas tree order.

-- Steve


>  	const char *name;
>  	int ret;
>  
> @@ -2432,24 +2434,24 @@ event_create_dir(struct dentry *parent, struct trace_event_file *file)
>  	if (WARN_ON_ONCE(strcmp(call->class->system, TRACE_SYSTEM) == 0))
>  		return -ENODEV;
>  
> -	d_events = event_subsystem_dir(tr, call->class->system, file, parent);
> -	if (!d_events)
> +	ef_subsystem = event_subsystem_dir(tr, call->class->system, file, parent);
> +	if (!ef_subsystem)
>  		return -ENOMEM;
>  
>  	name = trace_event_name(call);
> -	file->dir = tracefs_create_dir(name, d_events);
> -	if (!file->dir) {
> +	file->ef = eventfs_add_dir(name, ef_subsystem);
> +	if (IS_ERR(file->ef)) {
>  		pr_warn("Could not create tracefs '%s' directory\n", name);
>  		return -1;
>  	}
>  
>  	if (call->class->reg && !(call->flags & TRACE_EVENT_FL_IGNORE_ENABLE))
> -		trace_create_file("enable", TRACE_MODE_WRITE, file->dir, file,
> +		eventfs_add_file("enable", TRACE_MODE_WRITE, file->ef, file,
>  				  &ftrace_enable_fops);
>  
>  #ifdef CONFIG_PERF_EVENTS
>  	if (call->event.type && call->class->reg)
> -		trace_create_file("id", TRACE_MODE_READ, file->dir,
> +		eventfs_add_file("id", TRACE_MODE_READ, file->ef,
>  				  (void *)(long)call->event.type,
>  				  &ftrace_event_id_fops);
>  #endif
> @@ -2465,27 +2467,27 @@ event_create_dir(struct dentry *parent, struct trace_event_file *file)
>  	 * triggers or filters.
>  	 */
>  	if (!(call->flags & TRACE_EVENT_FL_IGNORE_ENABLE)) {
> -		trace_create_file("filter", TRACE_MODE_WRITE, file->dir,
> +		eventfs_add_file("filter", TRACE_MODE_WRITE, file->ef,
>  				  file, &ftrace_event_filter_fops);
>  
> -		trace_create_file("trigger", TRACE_MODE_WRITE, file->dir,
> +		eventfs_add_file("trigger", TRACE_MODE_WRITE, file->ef,
>  				  file, &event_trigger_fops);
>  	}
>  
>  #ifdef CONFIG_HIST_TRIGGERS
> -	trace_create_file("hist", TRACE_MODE_READ, file->dir, file,
> +	eventfs_add_file("hist", TRACE_MODE_READ, file->ef, file,
>  			  &event_hist_fops);
>  #endif
>  #ifdef CONFIG_HIST_TRIGGERS_DEBUG
> -	trace_create_file("hist_debug", TRACE_MODE_READ, file->dir, file,
> +	eventfs_add_file("hist_debug", TRACE_MODE_READ, file->ef, file,
>  			  &event_hist_debug_fops);
>  #endif
> -	trace_create_file("format", TRACE_MODE_READ, file->dir, call,
> +	eventfs_add_file("format", TRACE_MODE_READ, file->ef, call,
>  			  &ftrace_event_format_fops);
>  
>  #ifdef CONFIG_TRACE_EVENT_INJECT
>  	if (call->event.type && call->class->reg)
> -		trace_create_file("inject", 0200, file->dir, file,
> +		eventfs_add_file("inject", 0200, file->ef, file,
>  				  &event_inject_fops);
>  #endif
>  
> @@ -3638,21 +3640,22 @@ create_event_toplevel_files(struct dentry *parent, struct trace_array *tr)
>  {
>  	struct dentry *d_events;
>  	struct dentry *entry;
> +	int error = 0;
>  
>  	entry = trace_create_file("set_event", TRACE_MODE_WRITE, parent,
>  				  tr, &ftrace_set_event_fops);
>  	if (!entry)
>  		return -ENOMEM;
>  
> -	d_events = tracefs_create_dir("events", parent);
> -	if (!d_events) {
> +	d_events = eventfs_create_events_dir("events", parent);
> +	if (IS_ERR(d_events)) {
>  		pr_warn("Could not create tracefs 'events' directory\n");
>  		return -ENOMEM;
>  	}
>  
> -	entry = trace_create_file("enable", TRACE_MODE_WRITE, d_events,
> +	error = eventfs_add_top_file("enable", TRACE_MODE_WRITE, d_events,
>  				  tr, &ftrace_tr_enable_fops);
> -	if (!entry)
> +	if (error)
>  		return -ENOMEM;
>  
>  	/* There are not as crucial, just warn if they are not created */
> @@ -3665,11 +3668,11 @@ create_event_toplevel_files(struct dentry *parent, struct trace_array *tr)
>  			  &ftrace_set_event_notrace_pid_fops);
>  
>  	/* ring buffer internal formats */
> -	trace_create_file("header_page", TRACE_MODE_READ, d_events,
> +	eventfs_add_top_file("header_page", TRACE_MODE_READ, d_events,
>  				  ring_buffer_print_page_header,
>  				  &ftrace_show_header_fops);
>  
> -	trace_create_file("header_event", TRACE_MODE_READ, d_events,
> +	eventfs_add_top_file("header_event", TRACE_MODE_READ, d_events,
>  				  ring_buffer_print_entry_header,
>  				  &ftrace_show_header_fops);
>  
> @@ -3757,7 +3760,7 @@ int event_trace_del_tracer(struct trace_array *tr)
>  
>  	down_write(&trace_event_sem);
>  	__trace_remove_event_dirs(tr);
> -	tracefs_remove(tr->event_dir);
> +	eventfs_remove_events_dir(tr->event_dir);
>  	up_write(&trace_event_sem);
>  
>  	tr->event_dir = NULL;

