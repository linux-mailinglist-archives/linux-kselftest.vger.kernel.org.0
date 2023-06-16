Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C001733620
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jun 2023 18:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344869AbjFPQe1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 16 Jun 2023 12:34:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244776AbjFPQeY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 16 Jun 2023 12:34:24 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 480983592;
        Fri, 16 Jun 2023 09:34:11 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2b4470e1500so13043871fa.1;
        Fri, 16 Jun 2023 09:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686933249; x=1689525249;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ciLmmISBnAmBNpL57ZkiVLZdSgI5RvZx0KnVLxEMLQA=;
        b=rZLz4t1BzNZQb2SDswJNFyGKJ8WIjGulQ96rA0XoBDm4CuASgdXM+yqAoyEvUyqtHT
         HQWx1TQ+0gU2JHhVssNB+mTm91uyQi9uuNjL+RXBTzL2nZbUgpD2W8KqgnSGCWQx6lfw
         7Pl0ZXWHfB796z+BD7TlgijK0JO2Di1hrwUCddN/eAihOU9J7fWczr35jdc6zE790oiB
         XPFOD+noWYH9QUkPeCRdEpHxFKrmZEXzbZD6Sve+moKkU1bsgRsLXeFPntmOZ9EOQhrM
         Co/guy3EFea7xzzxX/oJT+42XAeaPS0tKXNAB+jSEQzhDW4YSmkv6iro7T8Fb7uBEPZE
         WvFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686933249; x=1689525249;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ciLmmISBnAmBNpL57ZkiVLZdSgI5RvZx0KnVLxEMLQA=;
        b=QjkhlluKxFXFalHT1yyj3JpXGfaT/Z/FuSlQOiS245TrUuB0dSnnceCsInm9T4bQIx
         2cYWX1gNgZL9qpBApISC9FpXxP42ih446Q8gvFmUnOmZAKqvfodpHfvSovNKX1JpXy2A
         5qfK2L7XC0mWl/rOFqLHof6FBORt9BnAYFL4NC5ZVel5OQEfmVcqkldi9RaKTfqfPSR0
         +FiPqjd/RBf+g491P7uiN+jFDgdlo83+wzPTAQFSp2JNd3uUtQs/CXXcQBHhyU3lWToO
         YJmMvUluynlgyocpShQRftdgFYPO61BO9tn8BuSAEwj9A810NMIol5eMg08LYcqUuVl0
         VvjA==
X-Gm-Message-State: AC+VfDyb49F18n9U3XqJmyS4EnoSq0fTfLsUssVg/FHVN3Dyzz7tabMV
        KqokagEMZlVEY+Kj0N/3Z8Gmz4AK2qcgqcsSQAo=
X-Google-Smtp-Source: ACHHUZ5J3J6BmXsqJ/ro7uibmi2MV6S2YWYrzOXs8CKYMYul39VCGUXxT/xgg7e42mm0CbGF5mxSq8p5ebcL5iOaLn4=
X-Received: by 2002:a2e:8756:0:b0:2b1:ae75:2781 with SMTP id
 q22-20020a2e8756000000b002b1ae752781mr2023912ljj.27.1686933249196; Fri, 16
 Jun 2023 09:34:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230614073443.4894-1-zhanglibing@cdjrlc.com> <7f34bd3ce377d9d89626c2df8fa584e0@208suo.com>
 <0b12a94a-e3e9-e2a2-389e-48a588d5ad6b@meta.com>
In-Reply-To: <0b12a94a-e3e9-e2a2-389e-48a588d5ad6b@meta.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 16 Jun 2023 09:33:57 -0700
Message-ID: <CAEf4BzZYF=WMuhPTdRaDEhrhR10gu-G_U-=9keq+pimoGq41EQ@mail.gmail.com>
Subject: Re: [PATCH] selftests/bpf: Fix the address is NULL
To:     Yonghong Song <yhs@meta.com>
Cc:     wuyonggang001@208suo.com, andrii@kernel.org, shuah@kernel.org,
        bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Jun 14, 2023 at 7:09=E2=80=AFAM Yonghong Song <yhs@meta.com> wrote:
>
>
>
> On 6/14/23 12:42 AM, wuyonggang001@208suo.com wrote:
> > Fix the following coccicheck error:
> >
> > tools/testing/selftests/bpf/progs/test_ksyms_weak.c:53:6-20: ERROR: tes=
t
> > of a variable/field address
>
> I didn't see clang/gcc compiler warns about this. Maybe need some
> additional flags beyond what current selftest/bpf already has
> in order to trigger this warning?
> If you feel this warning has some merit, could you propose
> it to gcc/llvm community?

bpf_link_fops2 is a weak symbol, this check is totally valid and reasonable=
.

There are two problems here, though:

a) coccicheck shouldn't warn about "test of a variable/field address"
for weak symbols, because they can be NULL.

b) this patch is not even fixing that warning, it does a no-op change
from implicit non-NULL check to explicit non-NULL check. And the
former is actually the preferred style.

So this patch is doubly wrong.

>
> >
> > Signed-off-by: Yonggang Wu <wuyonggang001@208suo.com>
> > ---
> >   tools/testing/selftests/bpf/progs/test_ksyms_weak.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/tools/testing/selftests/bpf/progs/test_ksyms_weak.c
> > b/tools/testing/selftests/bpf/progs/test_ksyms_weak.c
> > index d00268c91e19..768a4d6ee6f5 100644
> > --- a/tools/testing/selftests/bpf/progs/test_ksyms_weak.c
> > +++ b/tools/testing/selftests/bpf/progs/test_ksyms_weak.c
> > @@ -50,7 +50,7 @@ int pass_handler(const void *ctx)
> >       /* tests non-existent symbols. */
> >       out__non_existent_typed =3D (__u64)&bpf_link_fops2;
> >
> > -    if (&bpf_link_fops2) /* can't happen */
> > +    if (&bpf_link_fops2 !=3D NULL) /* can't happen */
> >           out__non_existent_typed =3D
> > (__u64)bpf_per_cpu_ptr(&bpf_link_fops2, 0);
> >
> >       if (!bpf_ksym_exists(bpf_task_acquire))
> >
