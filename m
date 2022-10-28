Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AE736118FD
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Oct 2022 19:11:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231404AbiJ1RLY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 Oct 2022 13:11:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231365AbiJ1RKs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 Oct 2022 13:10:48 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39325190E60;
        Fri, 28 Oct 2022 10:08:39 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id z18so3780564edb.9;
        Fri, 28 Oct 2022 10:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dvfGQP4rEg3Kw5lEX3ZtIQ80dTIYCeCUaIYb9XGpr/k=;
        b=cb7GzC2LOMi2HhBTaPvR5AaOzavwMgVz+NZbfwHKwNRcM6fXi1A80WsbFn7ohk6ixh
         KiBO060pfwirL26Ikmt1dKQKccxlcIiP9n7JiRSByONWP1ZxDKLVJTT8CXKd6a9KxbqE
         lQh8XOD3G8kfyIv586Kqsf6SzQS3m9Qhisr+MHGDV5DI13m/4U29o44v7dK5HnvLnioN
         fK15pRyu5AyHYKoLipfjv/+0WDqMCyKwU3xAVX4WAIxHNh7cbyNGJzObNo1oUrCIgL/p
         fwaaN2n4onbCzWX+qO4vINqOycBfesVQFGRnDnyZiXgvL1Yo3UzskM92p+iMDLvJX73H
         i+Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dvfGQP4rEg3Kw5lEX3ZtIQ80dTIYCeCUaIYb9XGpr/k=;
        b=b9RPD+7Pmya7N0OJSpkm/6vLdCXhyy3xDsBTtvT4i38IraTDzMBy6jkRLFddUdEo1Z
         gVVQjE1mOlqWOtIIiISz22urnrbId0mESSZRfoP5pTykxM3Wk5gzMZjIOKj9rhaoJH2M
         ruVgN0aubnygC2y/AktzGQjMk7KGFIzOLHX4piB+zu7urxlyRpWhT8nmuxZYVD5Uof2R
         EBnggmPicqA53bSFKgtNRM7W/biait2q98jYDg6gRv6CcTPmNr8n+Js0rIX1p87WbHdf
         GtTDi+/cSCZbC49AsIW9uTKx9VRUee/hh7SHVViixxKAvx255YSOn1TX1jWpUggkGoeK
         z9QA==
X-Gm-Message-State: ACrzQf3sKoTfRR5R4bwlFkgN2fP3bis0TnmEZ5OrhGwdlzQpIiF6OKVd
        KD7MZ1PlZ1w7u8bIRltiRTKugryktVTJRTS8RS4=
X-Google-Smtp-Source: AMsMyM73DDBTb/37IgY8U4uAkjDXpD1SHFZ7Pv5EOMO6OVXaecY+4kd0FuaftXvRtchfac9FwrV7biq8VpNfEyCeSq8=
X-Received: by 2002:aa7:c504:0:b0:461:122b:882b with SMTP id
 o4-20020aa7c504000000b00461122b882bmr456141edq.14.1666976917671; Fri, 28 Oct
 2022 10:08:37 -0700 (PDT)
MIME-Version: 1.0
References: <CAEf4Bzbq0PSsc6xCGSF=Af-pcysjt8Lv76-4N65AJMpXOOpOcg@mail.gmail.com>
 <tencent_CD22930180507496CE65B30ACBABC4681506@qq.com>
In-Reply-To: <tencent_CD22930180507496CE65B30ACBABC4681506@qq.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 28 Oct 2022 10:08:25 -0700
Message-ID: <CAEf4BzazYVkVKrKzPD8a7tRZrcWDvvgoVksJHYk3+46V=8kZhw@mail.gmail.com>
Subject: Re: Re: [PATCH] selftests/bpf: Fix strncpy() fortify warning
To:     Rong Tao <rtoax@foxmail.com>
Cc:     andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
        daniel@iogearbox.net, haoluo@google.com, john.fastabend@gmail.com,
        jolsa@kernel.org, kpsingh@kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, martin.lau@linux.dev,
        mykolal@fb.com, rongtao@cestc.cn, sdf@google.com, shuah@kernel.org,
        song@kernel.org, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Oct 27, 2022 at 5:26 PM Rong Tao <rtoax@foxmail.com> wrote:
>
> Thanks for your reply, `enable[0] =3D '\0';` at the beginning and then
> strncat() still has the same compile warning
>
> --- a/tools/testing/selftests/bpf/cgroup_helpers.c
> +++ b/tools/testing/selftests/bpf/cgroup_helpers.c
> @@ -77,7 +77,8 @@ static int __enable_controllers(const char *cgroup_path=
, const char *controllers
>                 enable[len] =3D 0;
>                 close(fd);
>         } else {
> -               strncpy(enable, controllers, sizeof(enable));
> +               enable[0] =3D '\0';
> +               strncat(enable, controllers, sizeof(enable));
>         }
>
> In function =E2=80=98__enable_controllers=E2=80=99:
> tools/testing/selftests/bpf/cgroup_helpers.c:81:17: warning: =E2=80=98str=
ncat=E2=80=99 specified bound 4097 equals destination size [-Wstringop-trun=
cation]
>    81 |                 strncat(enable, controllers, sizeof(enable));
>       |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> tools/testing/selftests/bpf/cgroup_helpers.c:81:17: warning: =E2=80=98str=
ncat=E2=80=99 specified bound 4097 equals destination size [-Wstringop-over=
flow=3D]
>
> So, i think just add '-1' for strncpy() is a good way.

no, it's not, see my previous email about ending up with
non-zero-terminated C string.

check strncat() API, it leaves the dst string zero terminated, and
yes, you need -1 for strncat as well, your compiler is right
