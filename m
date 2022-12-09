Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE07A648873
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Dec 2022 19:29:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbiLIS3W (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 9 Dec 2022 13:29:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbiLIS3V (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 9 Dec 2022 13:29:21 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDF2A4876F
        for <linux-kselftest@vger.kernel.org>; Fri,  9 Dec 2022 10:29:20 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id s7so5749887plk.5
        for <linux-kselftest@vger.kernel.org>; Fri, 09 Dec 2022 10:29:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=r2PSJMZNi7Lx3K9QcpxGsYdFe40hPnGOZyUy1ujyzNA=;
        b=tfI4xAi74SE707QKT/mlAJrn1WsRQMKi7foG6V+hJ3/ZeeH4mn18qk1TNdC36Ofusg
         ux9dVwjH+WeN8+ll50wN/ZVU3fRCV4j51jzLF1QBiKy3L9UcnDNWfvJFpdXUVutD6LSX
         B+nJJ/Z+4pMPkiKT5aQXAVSXC5gZy5nkHgjxcvcgJaZh4I2OJC7oMP//CIrni2xl0jSV
         Mmw/ny6WvzljNwb3mAlZHa2O41ZhCD7YCeG0EvMDL4eX3mZ4scebmz0Nk9VnZxQOhYOB
         3LvxaClg/ESU/pP7naEJRn8Pv2TZh2Wrj3eyhM2yqtbeuzCfNRyNSicIITnV7GFt+P1e
         tuXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r2PSJMZNi7Lx3K9QcpxGsYdFe40hPnGOZyUy1ujyzNA=;
        b=NS83D649RK0wVR9aWeVmhE4Su5nQjDGjRn44l9+SUcBYI3UDms4Zas0O2iBHQ43WvB
         517DSUkRwMlcMhAxCAh4UK4rPAAJIbPSgluQ22UFAwf91E4XRxcQNjCuM+VMKAsCdP78
         NyuGWKpwLd1OiJT9jifOHv9ldMiewXngIYvo+EqYIvGDTqsY/QtAji45RpC5hmEY2htL
         gHQDmVmybKcTO8F/4zy2zA8NS/VcqJ7MeDLkA6xOPTumRQAoxAeAf1ZkIlW+G0U6zXF2
         fHv6BVUWdEyqzd8Sl4C1gvK3QZCUNr0jxQCmpN+qL4i6JMY5tVgM2R+fPuVjF51nZGq6
         fBxw==
X-Gm-Message-State: ANoB5pl0Hdae2FCs3U1nl4Rd+wEGRds2oUzo+fsgpMoBq1AhQ6tSnu6g
        IT5SJiZfw9tCfCkGBgGKX0pOmzv7WuT1gRvdV2Ed
X-Google-Smtp-Source: AA0mqf4pAFPz9IcBXP3Ikc3/BIQ2Fh9HTUyem6n1RTDDoggYxub8h7ftdTIbBK+SxRWviGCqD0xcosbYz5JA2HpPsTg=
X-Received: by 2002:a17:90b:2743:b0:20d:4173:faf9 with SMTP id
 qi3-20020a17090b274300b0020d4173faf9mr108649177pjb.147.1670610559976; Fri, 09
 Dec 2022 10:29:19 -0800 (PST)
MIME-Version: 1.0
References: <20221209160453.3246150-1-jeffxu@google.com> <20221209160453.3246150-7-jeffxu@google.com>
In-Reply-To: <20221209160453.3246150-7-jeffxu@google.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 9 Dec 2022 13:29:08 -0500
Message-ID: <CAHC9VhRBMTQvnBdSwMbkOsk9eemYfvCmj9TRgxtMeuex4KLCPA@mail.gmail.com>
Subject: Re: [PATCH v7 6/6] mm/memfd: security hook for memfd_create
To:     jeffxu@chromium.org
Cc:     skhan@linuxfoundation.org, keescook@chromium.org,
        akpm@linux-foundation.org, dmitry.torokhov@gmail.com,
        dverkamp@chromium.org, hughd@google.com, jeffxu@google.com,
        jorgelo@chromium.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        jannh@google.com, linux-hardening@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Dec 9, 2022 at 11:05 AM <jeffxu@chromium.org> wrote:
>
> From: Jeff Xu <jeffxu@google.com>
>
> The new security_memfd_create allows lsm to check flags of
> memfd_create.
>
> The security by default system (such as chromeos) can use this
> to implement system wide lsm to allow only non-executable memfd
> being created.
>
> Signed-off-by: Jeff Xu <jeffxu@google.com>
> Reported-by: kernel test robot <lkp@intel.com>
> ---
>  include/linux/lsm_hook_defs.h | 1 +
>  include/linux/lsm_hooks.h     | 4 ++++
>  include/linux/security.h      | 6 ++++++
>  mm/memfd.c                    | 5 +++++
>  security/security.c           | 5 +++++
>  5 files changed, 21 insertions(+)

We typically require at least one in-tree LSM implementation to
accompany a new LSM hook.  Beyond simply providing proof that the hook
has value, it helps provide a functional example both for reviewers as
well as future LSM implementations.  Also, while the BPF LSM is
definitely "in-tree", its nature is such that the actual
implementation lives out-of-tree; something like SELinux, AppArmor,
Smack, etc. are much more desirable from an in-tree example
perspective.

-- 
paul-moore.com
