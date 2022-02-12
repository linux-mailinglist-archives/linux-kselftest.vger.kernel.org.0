Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAFA44B3855
	for <lists+linux-kselftest@lfdr.de>; Sat, 12 Feb 2022 23:14:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230271AbiBLWOb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 12 Feb 2022 17:14:31 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230236AbiBLWOb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 12 Feb 2022 17:14:31 -0500
Received: from mother.openwall.net (mother.openwall.net [195.42.179.200])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 3279760A80
        for <linux-kselftest@vger.kernel.org>; Sat, 12 Feb 2022 14:14:24 -0800 (PST)
Received: (qmail 11884 invoked from network); 12 Feb 2022 22:14:23 -0000
Received: from localhost (HELO pvt.openwall.com) (127.0.0.1)
  by localhost with SMTP; 12 Feb 2022 22:14:23 -0000
Received: by pvt.openwall.com (Postfix, from userid 503)
        id 44AA3AB88C; Sat, 12 Feb 2022 23:14:12 +0100 (CET)
Date:   Sat, 12 Feb 2022 23:14:12 +0100
From:   Solar Designer <solar@openwall.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Michal Koutn?? <mkoutny@suse.com>,
        Alexey Gladkov <legion@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Shuah Khan <shuah@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Ran Xiaokai <ran.xiaokai@zte.com.cn>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [RFC PATCH 1/6] set_user: Perform RLIMIT_NPROC capability check against new user credentials
Message-ID: <20220212221412.GA29214@openwall.com>
References: <20220207121800.5079-1-mkoutny@suse.com> <20220207121800.5079-2-mkoutny@suse.com> <20220210011405.GA17076@openwall.com> <87h795xhxs.fsf@email.froward.int.ebiederm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h795xhxs.fsf@email.froward.int.ebiederm.org>
User-Agent: Mutt/1.4.2.3i
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Feb 11, 2022 at 02:32:47PM -0600, Eric W. Biederman wrote:
> Solar Designer <solar@openwall.com> writes:
> > https://lore.kernel.org/all/20210913100140.bxqlg47pushoqa3r@wittgenstein/
> >
> > Christian was going to revert 2863643fb8b9, but apparently that never
> > happened.  Back then, I also suggested:
> >
> > "Alternatively, we could postpone the set_user() calls until we're
> > running with the new user's capabilities, but that's an invasive change
> > that's likely to create its own issues."
> 
> Back then you mentioned that apache suexec was broken.  Do you have
> any more details?
> 
> I would like to make certain the apache suexec issue is fixed but
> without a few details I can't do that.  I tried looking but I can't
> find an public report about apache suexec being broken.

I'm not aware of anyone actually running into this issue and reporting
it.  The systems that I personally know use suexec along with rlimits
still run older/distro kernels, so would not yet be affected.

So my mention was based on my understanding of how suexec works, and
code review.  Specifically, Apache httpd has the setting RLimitNPROC,
which makes it set RLIMIT_NPROC:

https://httpd.apache.org/docs/2.4/mod/core.html#rlimitnproc

The above documentation for it includes:

"This applies to processes forked from Apache httpd children servicing
requests, not the Apache httpd children themselves. This includes CGI
scripts and SSI exec commands, but not any processes forked from the
Apache httpd parent, such as piped logs."

In code, there are:

./modules/generators/mod_cgid.c:        ( (cgid_req.limits.limit_nproc_set) && ((rc = apr_procattr_limit_set(procattr, APR_LIMIT_NPROC,
./modules/generators/mod_cgi.c:        ((rc = apr_procattr_limit_set(procattr, APR_LIMIT_NPROC,
./modules/filters/mod_ext_filter.c:    rv = apr_procattr_limit_set(procattr, APR_LIMIT_NPROC, conf->limit_nproc);

For example, in mod_cgi.c this is in run_cgi_child().

I think this means an httpd child sets RLIMIT_NPROC shortly before it
execs suexec, which is a SUID root program.  suexec then switches to the
target user and execs the CGI script.

Before 2863643fb8b9, the setuid() in suexec would set the flag, and the
target user's process count would be checked against RLIMIT_NPROC on
execve().  After 2863643fb8b9, the setuid() in suexec wouldn't set the
flag because setuid() is (naturally) called when the process is still
running as root (thus, has those limits bypass capabilities), and
accordingly execve() would not check the target user's process count
against RLIMIT_NPROC.

> My goal is to come up with a very careful and conservative set of
> patches that fix all of the known issues with RLIMIT_NPROC.

The most conservative fix for this one would be to revert 2863643fb8b9
(preserving other changes that were made on top of it).  I think this
commit did not fix a real issue - it attempted to fix what someone
thought was a discrepancy, but actually made it worse.

However, your recent patch trying to fix that commit looks like it'd
also repair the behavior for suexec.

Thanks,

Alexander
