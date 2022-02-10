Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB05A4B0289
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Feb 2022 02:57:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233197AbiBJB4f (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 9 Feb 2022 20:56:35 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:33166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233188AbiBJB4B (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 9 Feb 2022 20:56:01 -0500
X-Greylist: delayed 1199 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 09 Feb 2022 17:43:16 PST
Received: from mother.openwall.net (mother.openwall.net [195.42.179.200])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 2998F2B69F
        for <linux-kselftest@vger.kernel.org>; Wed,  9 Feb 2022 17:43:14 -0800 (PST)
Received: (qmail 7392 invoked from network); 10 Feb 2022 01:16:33 -0000
Received: from localhost (HELO pvt.openwall.com) (127.0.0.1)
  by localhost with SMTP; 10 Feb 2022 01:16:33 -0000
Received: by pvt.openwall.com (Postfix, from userid 503)
        id 0E08DAB88C; Thu, 10 Feb 2022 02:14:05 +0100 (CET)
Date:   Thu, 10 Feb 2022 02:14:05 +0100
From:   Solar Designer <solar@openwall.com>
To:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc:     Eric Biederman <ebiederm@xmission.com>,
        Alexey Gladkov <legion@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Shuah Khan <shuah@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Ran Xiaokai <ran.xiaokai@zte.com.cn>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Linux Containers <containers@lists.linux-foundation.org>
Subject: Re: [RFC PATCH 1/6] set_user: Perform RLIMIT_NPROC capability check against new user credentials
Message-ID: <20220210011405.GA17076@openwall.com>
References: <20220207121800.5079-1-mkoutny@suse.com> <20220207121800.5079-2-mkoutny@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220207121800.5079-2-mkoutny@suse.com>
User-Agent: Mutt/1.4.2.3i
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Michal,

On Mon, Feb 07, 2022 at 01:17:55PM +0100, Michal Koutný wrote:
> The check is currently against the current->cred but since those are
> going to change and we want to check RLIMIT_NPROC condition after the
> switch, supply the capability check with the new cred.
> But since we're checking new_user being INIT_USER any new cred's
> capability-based allowance may be redundant when the check fails and the
> alternative solution would be revert of the commit 2863643fb8b9
> ("set_user: add capability check when rlimit(RLIMIT_NPROC) exceeds")
> 
> Fixes: 2863643fb8b9 ("set_user: add capability check when rlimit(RLIMIT_NPROC) exceeds")
> 
> Cc: Solar Designer <solar@openwall.com>
> Cc: Christian Brauner <christian.brauner@ubuntu.com>
> Signed-off-by: Michal Koutný <mkoutny@suse.com>
> ---
>  kernel/sys.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/sys.c b/kernel/sys.c
> index 8ea20912103a..48c90dcceff3 100644
> --- a/kernel/sys.c
> +++ b/kernel/sys.c
> @@ -481,7 +481,8 @@ static int set_user(struct cred *new)
>  	 */
>  	if (ucounts_limit_cmp(new->ucounts, UCOUNT_RLIMIT_NPROC, rlimit(RLIMIT_NPROC)) >= 0 &&
>  			new_user != INIT_USER &&
> -			!capable(CAP_SYS_RESOURCE) && !capable(CAP_SYS_ADMIN))
> +			!security_capable(new, &init_user_ns, CAP_SYS_RESOURCE, CAP_OPT_NONE) &&
> +			!security_capable(new, &init_user_ns, CAP_SYS_ADMIN, CAP_OPT_NONE))
>  		current->flags |= PF_NPROC_EXCEEDED;
>  	else
>  		current->flags &= ~PF_NPROC_EXCEEDED;

Thank you for working on this and CC'ing me on it.  This is related to
the discussion Christian and I had in September:

https://lore.kernel.org/all/20210913100140.bxqlg47pushoqa3r@wittgenstein/

Christian was going to revert 2863643fb8b9, but apparently that never
happened.  Back then, I also suggested:

"Alternatively, we could postpone the set_user() calls until we're
running with the new user's capabilities, but that's an invasive change
that's likely to create its own issues."

The change you propose above is similar to that, but is more limited and
non-invasive.  That looks good to me.

However, I think you need to drop the negations of the return value from
security_capable().  security_capable() returns 0 or -EPERM, while
capable() returns a bool, in kernel/capability.c: ns_capable_common():

	capable = security_capable(current_cred(), ns, cap, opts);
	if (capable == 0) {
		current->flags |= PF_SUPERPRIV;
		return true;
	}
	return false;

Also, your change would result in this no longer setting PF_SUPERPRIV.
This may be fine, but you could want to document it.

On a related note, this comment in security/commoncap.c needs an update:

 * NOTE WELL: cap_has_capability() cannot be used like the kernel's capable()
 * and has_capability() functions.  That is, it has the reverse semantics:
 * cap_has_capability() returns 0 when a task has a capability, but the
 * kernel's capable() and has_capability() returns 1 for this case.

cap_has_capability() doesn't actually exist, and perhaps the comment
should refer to cap_capable().

Alexander
