Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 668AF7DA8DB
	for <lists+linux-kselftest@lfdr.de>; Sat, 28 Oct 2023 21:18:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229448AbjJ1TSB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 28 Oct 2023 15:18:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjJ1TSA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 28 Oct 2023 15:18:00 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FCCCEB;
        Sat, 28 Oct 2023 12:17:58 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D21AAC433C8;
        Sat, 28 Oct 2023 19:17:55 +0000 (UTC)
Date:   Sat, 28 Oct 2023 15:17:53 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Arnd Bergmann" <arnd@arndb.de>
Cc:     "Naresh Kamboju" <naresh.kamboju@linaro.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        linux-trace-kernel@vger.kernel.org,
        "open list" <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, lkft-triage@lists.linaro.org,
        "Masami Hiramatsu" <mhiramat@kernel.org>,
        "Mark Rutland" <mark.rutland@arm.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Oleg Nesterov" <oleg@redhat.com>, "Dave Jones" <davej@redhat.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Paul McKenney" <paulmck@linux.vnet.ibm.com>,
        "Alan Stern" <stern@rowland.harvard.edu>,
        "Sasha Levin" <sasha.levin@oracle.com>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Ingo Molnar" <mingo@kernel.org>,
        "Dan Carpenter" <dan.carpenter@linaro.org>,
        "Ajay Kaher" <akaher@vmware.com>,
        Beau Belgrave <beaub@linux.microsoft.com>
Subject: Re: selftests: ftrace: RIP: 0010:__lock_acquire
 (kernel/locking/lockdep.c:5005)
Message-ID: <20231028151753.1df27654@rorschach.local.home>
In-Reply-To: <8f86f22a-e182-4ddf-b533-b4ae8b088dd4@app.fastmail.com>
References: <CA+G9fYt6pY+tMZEOg=SoEywQOe19fGP3uR15SGowkdK+_X85Cg@mail.gmail.com>
        <8f86f22a-e182-4ddf-b533-b4ae8b088dd4@app.fastmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, 27 Oct 2023 14:55:14 +0200
"Arnd Bergmann" <arnd@arndb.de> wrote:


> This lock is part of the dentry passed to d_invalidate()
> 
> > [ 1402.609170] ? lock_release (kernel/locking/lockdep.c:5429
> > kernel/locking/lockdep.c:5773)
> > [ 1402.612923] ? create_dir_dentry.part.0 (fs/tracefs/event_inode.c:387)
> > [ 1402.617803] _raw_spin_lock (include/linux/spinlock_api_smp.h:134
> > kernel/locking/spinlock.c:154)
> > [ 1402.621467] ? d_invalidate (fs/dcache.c:1725 (discriminator 1))
> > [ 1402.625126] d_invalidate (fs/dcache.c:1725 (discriminator 1))
> > [ 1402.628619] create_dir_dentry.part.0 (fs/tracefs/event_inode.c:390)  
> 
> Which is called by create_dir_dentry(). I don't see a bug
> in that function, but maybe Steve has an idea.
> 
>

I see a bug ;-)

Can you test this patch?

Thanks!

-- Steve

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index 4d2da7480e5f..ef003149e4d3 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -234,6 +234,10 @@ create_file_dentry(struct eventfs_inode *ei, struct dentry **e_dentry,
 	bool invalidate = false;
 
 	mutex_lock(&eventfs_mutex);
+	if (ei->is_freed) {
+		mutex_unlock(&eventfs_mutex);
+		return NULL;
+	}
 	/* If the e_dentry already has a dentry, use it */
 	if (*e_dentry) {
 		/* lookup does not need to up the ref count */
@@ -333,6 +337,10 @@ create_dir_dentry(struct eventfs_inode *ei, struct dentry *parent, bool lookup)
 	struct dentry *dentry = NULL;
 
 	mutex_lock(&eventfs_mutex);
+	if (ei->is_freed) {
+		mutex_unlock(&eventfs_mutex);
+		return NULL;
+	}
 	if (ei->dentry) {
 		/* If the dentry already has a dentry, use it */
 		dentry = ei->dentry;
-- 
2.42.0

