Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A9456EFE0D
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Apr 2023 01:39:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241400AbjDZXjf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 26 Apr 2023 19:39:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239378AbjDZXje (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 26 Apr 2023 19:39:34 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14CA61FEE;
        Wed, 26 Apr 2023 16:39:33 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-94a34a0b9e2so1153510466b.1;
        Wed, 26 Apr 2023 16:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682552371; x=1685144371;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oONRy5l2JLOJyEo1AeYm19pBhJ3UQG2RW3FoWKC6TsI=;
        b=h2PZfx9252YBjhMtLryYSuzrbcGAljB7L9ewNiOfZlhLJ+zSh7pVKQFYNGo6RwRNNg
         DxbbL/B5ZtqMoxab3wiA0hGrU7wDbXPBWSTlIUYyeCTUndsBJOkVKxGv0M4thC6Kja2e
         /OTnpJVVHhcIy83FfS6kqUUm/8iEJBEVkAQEn8bXyHR0yGhx13PpdrxJfseEVF+LCmfe
         L8rRQuKzKqfcBKNNrPz3YvmjdhwE/xvPP2Ue7Y1Jclhbk7dGmDxs2tC+UmPDPqkt+yie
         9bv0/pZFuqwCa5gNchfmcpR8Cqx12cVhZtAeMdp1A/fly3Q9Qf15nPwDEMYk1MkI+Tj0
         owFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682552371; x=1685144371;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oONRy5l2JLOJyEo1AeYm19pBhJ3UQG2RW3FoWKC6TsI=;
        b=GVv4+Z2ityS91RNEkumW4GrJxHJlItQENQkPwju83A0TErScafVczYvDMeQfh1iHQc
         lWPLbHZa412gUCZZ9mSWh6YpeQ68FbqSFk5RoWYOCGblTdrTYCcjfmwev7M16f3RThaH
         JUpzj2LqK5OgOc6V/M5SJ2WzmpXQY7ZQs5NqXRHZBXCMxvITX0yBCiM+7a/efspBgkcD
         3upQFWqoeK6UC5N6+VS498gscB5UK8lAwLt9VZTZ8dWSlervdFEkun/4BKivbbeIiG/R
         ZSugHKtP5/UXWQZroXqyM879PRbkWefF1k6aX21RFHdzueBH950rF5V+vIK/KihuRumb
         g+xA==
X-Gm-Message-State: AAQBX9cvB5vC2bNG5kSSsxPWb5cs1XAtY01NywrXWJQn4qEwu2hacFGw
        b8wVDCrFNuI7YrBmuB2h4pv/cXAEhV+bvmcjZbI=
X-Google-Smtp-Source: AKy350Z1MS8nZ6TqqFOhSOeHQMwhuHNCsFc5EqpQ0j/N1y3D0WzqBqwVeVHcMT4TKu7NdqndrSkfBJabhLxghswWKQc=
X-Received: by 2002:a17:906:a103:b0:8aa:a9fe:a3fc with SMTP id
 t3-20020a170906a10300b008aaa9fea3fcmr19604988ejy.8.1682552371348; Wed, 26 Apr
 2023 16:39:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230406004018.1439952-1-drosen@google.com> <CAEf4BzZ2zjJKhyUtZKUxbNXJMggcot4MyNEeg6n4Lho-EVbBbg@mail.gmail.com>
 <CA+PiJmTHO3SPM_LvwFYWP+uf_KU4QytBshGzk78CZi8oGJ+rnw@mail.gmail.com>
In-Reply-To: <CA+PiJmTHO3SPM_LvwFYWP+uf_KU4QytBshGzk78CZi8oGJ+rnw@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 26 Apr 2023 16:39:19 -0700
Message-ID: <CAEf4BzZ_4kcM5=Jo3JoWQWugS3wkrtoteyM8YqkykFvYywG+kg@mail.gmail.com>
Subject: Re: [PATCH 0/3] Dynptr Verifier Adjustments
To:     Daniel Rosenberg <drosen@google.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Joanne Koong <joannelkoong@gmail.com>,
        Mykola Lysenko <mykolal@fb.com>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Apr 26, 2023 at 3:07=E2=80=AFPM Daniel Rosenberg <drosen@google.com=
> wrote:
>
> >
> > It is expected that you build the freshest vmlinux image before
> > building selftests, because we generate vmlinux.h from it. In your
> > case we generated vmlinux.h from your system-wide
> > /sys/kernel/btf/vmlinux BTF information, which doesn't yet have latest
> > UAPI enums.
> >
> I'm still unable to build the selftests. I've got it pointed to a
> locally built kernel built using the config/config.x86_64, and have
> tried running the vmtest.sh script, and building just the tests via
> make. I'm using O=3D to direct it to the out directory for the kernel
> build. I've been hitting various errors when trying this. Confusingly
> the error message isn't always the same. Currently from a clean build,
> it complains about "linux/atomic.h" not found via #include
> "../../../include/linux/filter.h"'s in various files. Other times it's
> complained about the various helper functions from bpf_helper_defs.h
> being unused.
>
> I'm not sure if I'm invoking the command wrong, or missing
> dependencies or something. I got past some earlier issues by updating
> clang. Any idea what I'm doing wrong?

Don't know, show the sequence of commands you are running?

I have linux source in ~/linux, and KBUILD_OUTPUT set to
~/linux-build/default. And it only takes this:

$ cd ~/linux
$ make -j90 # build kernel
$ cd tools/testing/selftests/bpf
$ make -j90 # build selftests

And that's it.
