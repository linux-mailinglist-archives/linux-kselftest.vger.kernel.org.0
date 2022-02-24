Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 148CC4C313E
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Feb 2022 17:29:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbiBXQ3O (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 24 Feb 2022 11:29:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbiBXQ3N (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 24 Feb 2022 11:29:13 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E3D1198EC1
        for <linux-kselftest@vger.kernel.org>; Thu, 24 Feb 2022 08:28:43 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id p3-20020a17090a680300b001bbfb9d760eso6155061pjj.2
        for <linux-kselftest@vger.kernel.org>; Thu, 24 Feb 2022 08:28:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3Hf6hDQrQo0yd5FSyKmljwnxvf8/XZ/eZW/Rsy8Pb3E=;
        b=SJh8VmSGNPM8i914U4IL5W11hEVk7xkedBBZONGXzjOC6560xZvMOJkpfeolMJ92Zl
         ZP9/K/VdsKyM8xZPPbrf0bj6qepIRXNWVFeGJLF7RsAtfqo58iollilxF4vzM1B4XxtJ
         Or7TSY1FvQufMpUss+lezrloJdGxS8Sduhgso=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3Hf6hDQrQo0yd5FSyKmljwnxvf8/XZ/eZW/Rsy8Pb3E=;
        b=DmQkFdymtjsFoCbi/V8QoGB5ElVETZu1j1sLQrFh5Lozi5Dp/SvnGUcFUd8xXdvyua
         VTVBFrMbB/dggJMCisajgsUBrV8R18CFYpI8kMY9fwaxQqwTyIXz3vxVjlc91QntZxGF
         v9UCy8ud+QfZGBWS9Zb2ppWjvdgQe+a//9+RIUeupNmJoaydO45kpo2BbBHTQZIdyUD9
         JyDlzfNN7OzUbTNh2I5TYY87TKclI/pzE04LdXrQAMAD/4bwRe+YKBTlDGH7vE5ukJQl
         AWaUXjyFVaWuL+9ULd1bJQNNB+iW9JvsEbzNMnw0HRBHcAvXVo3vPFGF5yLXg5gIn7Xr
         /Z4A==
X-Gm-Message-State: AOAM533jbLr8bz1SkDeKJvaJOFM/edgbjBbjHvbad5wVL5vSCiBd1Ylj
        mkGLACJZnNwldPrKXgJ7h1NsfA==
X-Google-Smtp-Source: ABdhPJzFvsbmftUHydPBy9R5fPRTPY62oQgsGm5jW/ELzdyMzVTadiHu6ZBikJMyMP1IKW1w+1tp1g==
X-Received: by 2002:a17:902:c405:b0:14f:dff5:92a0 with SMTP id k5-20020a170902c40500b0014fdff592a0mr3633520plk.61.1645720122728;
        Thu, 24 Feb 2022 08:28:42 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h34-20020a635322000000b003651e1ecb34sm44603pgb.25.2022.02.24.08.28.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 08:28:42 -0800 (PST)
Date:   Thu, 24 Feb 2022 08:28:41 -0800
From:   Kees Cook <keescook@chromium.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org,
        Linux API <linux-api@vger.kernel.org>,
        Etienne Dechamps <etienne@edechamps.fr>,
        Alexey Gladkov <legion@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Solar Designer <solar@openwall.com>,
        Ran Xiaokai <ran.xiaokai@zte.com.cn>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Security Officers <security@kernel.org>,
        Neil Brown <neilb@cse.unsw.edu.au>, NeilBrown <neilb@suse.de>,
        "Serge E. Hallyn" <serge@hallyn.com>, Jann Horn <jannh@google.com>,
        Andy Lutomirski <luto@kernel.org>, Willy Tarreau <w@1wt.eu>,
        Linus Torvalds <linus@torvalds.org>
Subject: Re: [PATCH] ucounts: Fix systemd LimigtNPROC with private users
 regression
Message-ID: <202202240826.E31BADF@keescook>
References: <20220207121800.5079-1-mkoutny@suse.com>
 <e9589141-cfeb-90cd-2d0e-83a62787239a@edechamps.fr>
 <20220215101150.GD21589@blackbody.suse.cz>
 <87zgmi5rhm.fsf@email.froward.int.ebiederm.org>
 <87fso91n0v.fsf_-_@email.froward.int.ebiederm.org>
 <CAHk-=wjX3VK8QRMDUWwigCTKdHJt0ESXh0Hy5HNaXf7YkEdCAA@mail.gmail.com>
 <878ru1qcos.fsf@email.froward.int.ebiederm.org>
 <CAHk-=wgW8+vmqhx4t+uFiZL==8Ac5VWTqCm_oshA0e47B73qPw@mail.gmail.com>
 <87tucpko7d.fsf@email.froward.int.ebiederm.org>
 <87sfs8jmpz.fsf_-_@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87sfs8jmpz.fsf_-_@email.froward.int.ebiederm.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

typo: Subject's LimigtNPROC -> LimitNPROC

On Thu, Feb 24, 2022 at 09:41:44AM -0600, Eric W. Biederman wrote:
> 
> Long story short recursively enforcing RLIMIT_NPROC when it is not
> enforced on the process that creates a new user namespace, causes
> currently working code to fail.  There is no reason to enforce
> RLIMIT_NPROC recursively when we don't enforce it normally so update
> the code to detect this case.
> 
> I would like to simply use capable(CAP_SYS_RESOURCE) to detect when
> RLIMIT_NPROC is not enforced upon the caller.  Unfortunately because
> RLIMIT_NPROC is charged and checked for enforcement based upon the
> real uid, using capable() wich is euid based is inconsistent with reality.

typo: wich -> which

> Come as close as possible to testing for capable(CAP_SYS_RESOURCE) by
> testing for when the real uid would match the conditions when
> CAP_SYS_RESOURCE would be present if the real uid was the effective
> uid.
> 
> Reported-by: Etienne Dechamps <etienne@edechamps.fr>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=215596
> Link: https://lkml.kernel.org/r/e9589141-cfeb-90cd-2d0e-83a62787239a@edechamps.fr
> Fixes: 21d1c5e386bc ("Reimplement RLIMIT_NPROC on top of ucounts")
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
> ---
> 
> The previous conversation has given me enough clarity that I can see
> which tests I am comfortable with use for this pending regression fix.
> 
> I have tested this and it works for me.  Does anyone have any concerns
> with this change?

I'd really love some kind of selftest that exercises the edge cases; do
you have your tests in some form that could be converted?

But otherwise, yes, this looks like the best option here.

Reviewed-by: Kees Cook <keescook@chromium.org>

> 
>  kernel/user_namespace.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
> index 6b2e3ca7ee99..5481ba44a8d6 100644
> --- a/kernel/user_namespace.c
> +++ b/kernel/user_namespace.c
> @@ -58,6 +58,18 @@ static void set_cred_user_ns(struct cred *cred, struct user_namespace *user_ns)
>  	cred->user_ns = user_ns;
>  }
>  
> +static unsigned long enforced_nproc_rlimit(void)
> +{
> +	unsigned long limit = RLIM_INFINITY;
> +
> +	/* Is RLIMIT_NPROC currently enforced? */
> +	if (!uid_eq(current_uid(), GLOBAL_ROOT_UID) ||
> +	    (current_user_ns() != &init_user_ns))
> +		limit = rlimit(RLIMIT_NPROC);
> +
> +	return limit;
> +}
> +
>  /*
>   * Create a new user namespace, deriving the creator from the user in the
>   * passed credentials, and replacing that user with the new root user for the
> @@ -122,7 +134,7 @@ int create_user_ns(struct cred *new)
>  	for (i = 0; i < MAX_PER_NAMESPACE_UCOUNTS; i++) {
>  		ns->ucount_max[i] = INT_MAX;
>  	}
> -	set_rlimit_ucount_max(ns, UCOUNT_RLIMIT_NPROC, rlimit(RLIMIT_NPROC));
> +	set_rlimit_ucount_max(ns, UCOUNT_RLIMIT_NPROC, enforced_nproc_rlimit());
>  	set_rlimit_ucount_max(ns, UCOUNT_RLIMIT_MSGQUEUE, rlimit(RLIMIT_MSGQUEUE));
>  	set_rlimit_ucount_max(ns, UCOUNT_RLIMIT_SIGPENDING, rlimit(RLIMIT_SIGPENDING));
>  	set_rlimit_ucount_max(ns, UCOUNT_RLIMIT_MEMLOCK, rlimit(RLIMIT_MEMLOCK));
> -- 
> 2.29.2
> 

-- 
Kees Cook
