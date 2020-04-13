Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13F8E1A686B
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Apr 2020 17:02:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729524AbgDMPCM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 13 Apr 2020 11:02:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:33174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728537AbgDMPCL (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 13 Apr 2020 11:02:11 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 08E5A20656;
        Mon, 13 Apr 2020 15:02:09 +0000 (UTC)
Date:   Mon, 13 Apr 2020 11:02:07 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Xiao Yang <yangx.jy@cn.fujitsu.com>
Cc:     <mingo@redhat.com>, <linux-kernel@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>,
        <linux-trace-devel@vger.kernel.org>
Subject: Re: [PATCH] tracing: Fix the race between registering 'snapshot'
 event trigger and triggering 'snapshot' operation
Message-ID: <20200413110207.01a48591@gandalf.local.home>
In-Reply-To: <20200413071252.13720-1-yangx.jy@cn.fujitsu.com>
References: <20200413071252.13720-1-yangx.jy@cn.fujitsu.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, 13 Apr 2020 15:12:52 +0800
Xiao Yang <yangx.jy@cn.fujitsu.com> wrote:

> Traced event can trigger 'snapshot' operation(i.e. calls snapshot_trigger()
> or snapshot_count_trigger()) when register_snapshot_trigger() has completed
> registration but doesn't allocate spare buffer for 'snapshot' event trigger.
> 'snapshot' operation always detects the lack of allocated buffer in the rare
> case so make register_snapshot_trigger() allocate spare buffer first.
> 
> trigger-snapshot.tc in kselftest reproduces the issue on slow vm:
> -----------------------------------------------------------
> cat trace
> ...
> ftracetest-3028  [002] ....   236.784290: sched_process_fork: comm=ftracetest pid=3028 child_comm=ftracetest child_pid=3036
>      <...>-2875  [003] ....   240.460335: tracing_snapshot_instance_cond: *** SNAPSHOT NOT ALLOCATED ***
>      <...>-2875  [003] ....   240.460338: tracing_snapshot_instance_cond: *** stopping trace here!   ***
> -----------------------------------------------------------
> 
> Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
> ---
>  kernel/trace/trace_events_trigger.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/trace/trace_events_trigger.c b/kernel/trace/trace_events_trigger.c
> index dd34a1b46a86..00e54cdcef3e 100644
> --- a/kernel/trace/trace_events_trigger.c
> +++ b/kernel/trace/trace_events_trigger.c
> @@ -1088,9 +1088,13 @@ register_snapshot_trigger(char *glob, struct event_trigger_ops *ops,
>  			  struct event_trigger_data *data,
>  			  struct trace_event_file *file)
>  {
> -	int ret = register_trigger(glob, ops, data, file);
> +	int alloc_ret, ret;
>  
> -	if (ret > 0 && tracing_alloc_snapshot_instance(file->tr) != 0) {
> +	alloc_ret = tracing_alloc_snapshot_instance(file->tr);
> +
> +	ret = register_trigger(glob, ops, data, file);
> +
> +	if (ret > 0 && alloc_ret != 0) {
>  		unregister_trigger(glob, ops, data, file);
>  		ret = 0;
>  	}


Why register if the allocation failed? Just switch the logic:

	int ret = tracing_alloc_snapshot_instance(file->tr);

	if (ret != 0)
		return 0;

	return register_trigger(glob, ops, data, file);


-- Steve
