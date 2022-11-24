Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A5F16379A8
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Nov 2022 14:05:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbiKXNFy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 24 Nov 2022 08:05:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbiKXNFx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 24 Nov 2022 08:05:53 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB3B412D32;
        Thu, 24 Nov 2022 05:05:52 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 874F11F74A;
        Thu, 24 Nov 2022 13:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1669295151; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=v91GzwlaUPjJuAfOTl7gXRikD0EHCncjtrGWvP5ZMD0=;
        b=ZEV0CVRRORp894sCNJUsBfBehybYtMM8av2KmRF6QxawMITaihrqkA/t4sI1kmPp1DCsZr
        K22aZB6FsXl4mOPqIo5OMFA0bEWd1jaBW/hhmrxiXmzt9R+rPF0UQsIjuot51/PQfFHh78
        bXPvMmSBd2Eqcva6nE6EdFZl5Jiz/Aw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1669295151;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=v91GzwlaUPjJuAfOTl7gXRikD0EHCncjtrGWvP5ZMD0=;
        b=kisy9PlKnobjTxadB2sG32zOCmVNrUYaj/d/dEupCkeOMf0Ektuiq43GHvlAOIXNVI0o1O
        FCyqLiqOAy89jJAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 363F713488;
        Thu, 24 Nov 2022 13:05:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id LzyCOyxsf2M6GgAAMHmgww
        (envelope-from <mpdesouza@suse.de>); Thu, 24 Nov 2022 13:05:48 +0000
Date:   Thu, 24 Nov 2022 10:05:45 -0300
From:   Marcos Paulo de Souza <mpdesouza@suse.de>
To:     Joe Lawrence <joe.lawrence@redhat.com>
Cc:     Marcos Paulo de Souza <mpdesouza@suse.com>,
        live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org, jpoimboe@redhat.com, mbenes@suse.cz,
        pmladek@suse.com
Subject: Re: [PATCH v2 2/2] selftests: livepatch: Test livepatching a heavily
 called syscall
Message-ID: <20221124130545.2f7cpc5xkzqiybsw@daedalus>
References: <20220630141226.2802-1-mpdesouza@suse.com>
 <20220630141226.2802-3-mpdesouza@suse.com>
 <Ys2Li9ilYtpmJhN3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ys2Li9ilYtpmJhN3@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jul 12, 2022 at 10:56:11AM -0400, Joe Lawrence wrote:
> On Thu, Jun 30, 2022 at 11:12:26AM -0300, Marcos Paulo de Souza wrote:
...
> nit: no need to init global to 0
> 
> > +static int sig_int;
> > +
> > +void hup_handler(int signum)
> > +{
> > +	stop = 1;
> > +}
> > +
> > +void int_handler(int signum)
> > +{
> > +	stop = 1;
> > +	sig_int = 1;
> > +}
> > +
> > +int main(int argc, char *argv[])
> > +{
> > +	pid_t orig_pid, pid;
> > +	long count = 0;
> > +
> > +	signal(SIGHUP, &hup_handler);
> > +	signal(SIGINT, &int_handler);
> > +
> > +	orig_pid = syscall(SYS_getpid);
> > +
> > +	while (!stop) {
> > +		pid = syscall(SYS_getpid);
> > +		if (pid != orig_pid)
> > +			return 1;
> 
> This test doesn't care about the user program return code, but I wonder
> if the status should be flipped -- this is the desired code path, not
> the one at the end of main(), right?
> 
...
> > +	 */
> > +	mutex_lock(&kpid_mutex);
> > +	list_for_each_entry_safe(kpid, temp, &klp_pid_list, list) {
> > +		if (current->pid == kpid->pid) {
> > +			list_del(&kpid->list);
> > +			kfree(kpid);
> > +			npids--;
> > +			break;
> 
> I think it would be safer to return task_tgid_vnr() here, but ...
> 
> > +		}
> > +	}
> > +	mutex_unlock(&kpid_mutex);
> > +
> > +	return task_tgid_vnr(current);
> 
> task_pid_vnr() here.  That way we're only changing behavior for the
> processes in the list and not all programs across the system.

I believe that these two suggestions can be linked per your answer. First of
all, I didn't write the original test program, but I agree that we can make it
better.

My intent by upstreaming the test was to ensure that test programs
would keep working even when livepatching getpid while having processes calling
getpid nonstop. For the purpose of the test, the test module livepatches getpid,
but keeping the same behavior as before. The only change is to keep track of the
test programs that need to transition to livepatched state.

Per your comment on the test program it seems that we expected to receive a
different value from getpid, but it's not the case here. I believe the chec on
test program is confusing and doesn't bring any benefit, so maybe it's better to
remove it and keep the test even simpler:

  --- a/tools/testing/selftests/livepatch/test_programs/test_klp-call_getpid.c
  +++ b/tools/testing/selftests/livepatch/test_programs/test_klp-call_getpid.c
  @@ -26,18 +26,13 @@ void int_handler(int signum)

   int main(int argc, char *argv[])
   {
  -   pid_t orig_pid, pid;
      long count = 0;

      signal(SIGHUP, &hup_handler);
      signal(SIGINT, &int_handler);

  -   orig_pid = syscall(SYS_getpid);
  -
      while (!stop) {
  -       pid = syscall(SYS_getpid);
  -       if (pid != orig_pid)
  -           return 1;
  +       (void)syscall(SYS_getpid);
          count++;
      }

As as only care about the processes transitioning to the livepatched state, we
really don't care about the getpid return value (as it should be the same from patches
and unpatched state).

I believe this resolves both issues. What do you think?
