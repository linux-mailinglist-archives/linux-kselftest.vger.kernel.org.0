Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E48C174332E
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Jun 2023 05:27:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbjF3D1o (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 29 Jun 2023 23:27:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjF3D1m (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 29 Jun 2023 23:27:42 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D01C3359C
        for <linux-kselftest@vger.kernel.org>; Thu, 29 Jun 2023 20:27:39 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-516500163b2so3242a12.1
        for <linux-kselftest@vger.kernel.org>; Thu, 29 Jun 2023 20:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688095658; x=1690687658;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YRN6qWsVu0mB1ku4fPTz09e+/lMrKAM1ocX41R6p7Gk=;
        b=soWnwzrTr9hKh0W3aqnqEN2ZcGCbufVtjT17NhzB4wsFdSXzlRDGZgj6fxlukK2MKn
         YsfdXQvKUaTg3JKW/BUM6tobUWXWciOdUv6jl2E9eGPg7EF9YV9WKQTP8f7DKOxvu/9v
         s0rl20ZxzAyL45Vn6SpokC6QcAWuBapLJ+lbzu0NiNjwXKd2V6pthnHll0r/Y//8sStD
         Q3AlCzR1YqBW3ivuGi7BdN4m+7yc8x0Lpugwqq1AcUmogleDxYyjpH+tgbsa3kYkEQUX
         7vuSoyoAL717NLP88dWX6Xdmdf6/O+jP6oRM+a+ef9t+WWGF53lUE1yxazd3gLXJe2yo
         25jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688095658; x=1690687658;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YRN6qWsVu0mB1ku4fPTz09e+/lMrKAM1ocX41R6p7Gk=;
        b=R+pgU0vEAImwG95riiCVBbSALZH9A+tJhB2vQmlvspmRfh2LzG9V7+JDPRTdEALX4L
         uL+F9n8qqJkuyFOyXOnRZMPRXWWRFWRywowEhZLOUE7+hIwu1va+A+u8PowcAPnW2OML
         tIv/xCvk9BwnLMeWcliMv1zdXXIBeSXPY8X+tfv/cJdGBvpuAuY+NtfBPniBPHpNGhjR
         mKm+38E82+aDFhPIQYXgLJQANzl3ceZdLeaAqRj4Zk/mO0wvnCv9lurQprbmakXcDm2W
         +B+yjyL6DrtuZWy+pGLgZ68gmxHJ64RB8JB329m2Le21NR410Z8dq4VjHMiEKyWFWpcO
         PYBQ==
X-Gm-Message-State: AC+VfDx5SeiLOQbE1nPv8O0Vj3GKnXEk7BuegMpArWC5gyBuvWlYvJGf
        8FAKjUcABTV0SQdSvA3CYVcH65Ix/eqzlA6zV8D66w==
X-Google-Smtp-Source: ACHHUZ7ZUJn81AAcrfvyG7dBaqTj3v9qdubJ+SWeC50c+iFxxUBBGPEqwxbk0ZLgn2ugtR9tB/qjhK9XVxx7Es5LYjQ=
X-Received: by 2002:a50:baaf:0:b0:510:b2b7:8a78 with SMTP id
 x44-20020a50baaf000000b00510b2b78a78mr218316ede.5.1688095658215; Thu, 29 Jun
 2023 20:27:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230629233454.4166842-1-jeffxu@google.com>
In-Reply-To: <20230629233454.4166842-1-jeffxu@google.com>
From:   Jeff Xu <jeffxu@google.com>
Date:   Thu, 29 Jun 2023 20:27:02 -0700
Message-ID: <CALmYWFtj1rEwJQmE4nrpCswxWf8TuW9T-p7NVGsA39JoZm+nnA@mail.gmail.com>
Subject: Re: [PATCH v2] Documentation: mm/memfd: vm.memfd_noexec
To:     jeffxu@chromium.org
Cc:     skhan@linuxfoundation.org, keescook@chromium.org,
        akpm@linux-foundation.org, dmitry.torokhov@gmail.com,
        dverkamp@chromium.org, hughd@google.com, jorgelo@chromium.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, jannh@google.com,
        linux-hardening@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Dominique Martinet <asmadeus@codewreck.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Jun 29, 2023 at 4:34=E2=80=AFPM <jeffxu@chromium.org> wrote:
>
> From: Jeff Xu <jeffxu@google.com>
>
Please ignore this, I resent V3 with a cover letter.

> Add documentation for sysctl vm.memfd_noexec
>
> Link:https://lore.kernel.org/linux-mm/CABi2SkXUX_QqTQ10Yx9bBUGpN1wByOi_=
=3DgZU6WEy5a8MaQY3Jw@mail.gmail.com/T/
> Reported-by: Dominique Martinet <asmadeus@codewreck.org>
> Signed-off-by: Jeff Xu <jeffxu@google.com>
> ---
>  Documentation/admin-guide/sysctl/vm.rst | 30 +++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
>
> diff --git a/Documentation/admin-guide/sysctl/vm.rst b/Documentation/admi=
n-guide/sysctl/vm.rst
> index 45ba1f4dc004..621588041a9e 100644
> --- a/Documentation/admin-guide/sysctl/vm.rst
> +++ b/Documentation/admin-guide/sysctl/vm.rst
> @@ -424,6 +424,36 @@ e.g., up to one or two maps per allocation.
>
>  The default value is 65530.
>
> +memfd_noexec:
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +This pid namespaced sysctl controls memfd_create().
> +
> +The new MFD_NOEXEC_SEAL and MFD_EXEC flags of memfd_create() allows
> +application to set executable bit at creation time.
> +
> +When MFD_NOEXEC_SEAL is set, memfd is created without executable bit
> +(mode:0666), and sealed with F_SEAL_EXEC, so it can't be chmod to
> +be executable (mode: 0777) after creation.
> +
> +when MFD_EXEC flag is set, memfd is created with executable bit
> +(mode:0777), this is the same as the old behavior of memfd_create.
> +
> +The new pid namespaced sysctl vm.memfd_noexec has 3 values:
> +0: memfd_create() without MFD_EXEC nor MFD_NOEXEC_SEAL acts like
> +        MFD_EXEC was set.
> +1: memfd_create() without MFD_EXEC nor MFD_NOEXEC_SEAL acts like
> +        MFD_NOEXEC_SEAL was set.
> +2: memfd_create() without MFD_NOEXEC_SEAL will be rejected.
> +
> +The default value is 0.
> +
> +Once set, it can't be downgraded at runtime, i.e. 2=3D>1, 1=3D>0
> +are denied.
> +
> +This is pid namespaced sysctl, child processes inherit the parent
> +process's memfd_noexec at the time of fork. Changes to the parent
> +process after fork are not automatically propagated to the child
> +process.
>
>  memory_failure_early_kill:
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> --
> 2.41.0.255.g8b1d071c50-goog
>
