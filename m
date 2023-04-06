Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80B3D6DA5DB
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Apr 2023 00:35:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231597AbjDFWf3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 6 Apr 2023 18:35:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjDFWf2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 6 Apr 2023 18:35:28 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76B1E8A7D
        for <linux-kselftest@vger.kernel.org>; Thu,  6 Apr 2023 15:35:27 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id ja10so38743832plb.5
        for <linux-kselftest@vger.kernel.org>; Thu, 06 Apr 2023 15:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680820527; x=1683412527;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q2S3D1pZbFjzSQGr6ymBjndZ14Ty5JYYwZq/s9YKUYw=;
        b=NC/P+NUjLIH9ceTT5aAOEi4oKo521K55RNY3eFC1ntQyuCPpqCbfOPkdSm9tjhUjmo
         a3Br3WG0YiOIMINK170lf0Szcn+iT324gVFvydToNPxee1A+ug6gigKmLyG8XF6E72ll
         xJ1m8oJzEuToFZvcVhlMMlwz1sxmQd4wgxcqL9LTWf4E/Rag6Th1DMqV0bjP8ld/M55r
         SpEiNoOst7nyscQYC/8DrrUXoeRvF7qIKTEcOXs7z/FYkIIrUx/LvkoVxsBw+CZxh+c7
         /uGWbsjECm913JmXGBkgenfkpjw5t/YW2bqnZ6vJXQ7awkoXgBDuOyzPs1DCAIUWVnCL
         LUHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680820527; x=1683412527;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q2S3D1pZbFjzSQGr6ymBjndZ14Ty5JYYwZq/s9YKUYw=;
        b=uIzq5kF/PccYFop0ntCaE0rNuaU0XjSaeeCoysswz9nnRAHzGp/7mCI4eq90komfl0
         7MEEcoCxQVYm3wIDFtDfL7XaWykn+BYbZIRnmlV4oORZyHgBsCAOsrdFEPnvOl/evAwy
         J/nxdZy5SOmr70xACmk2DKVGRkNnCF8dWpOa9Eju5kKFsHIz4U4qNegS0pIx2dHGhpq2
         vabjq5Jf1Ab7NXXvfFG3mreUR+FkpK+dheI3NGyAwXHCpY+uC0XOody637WDsKRbtFKZ
         jis4ulaxRjiDIa1JHxC5OFZGZ7zSFUWcjr46pzU6WfJeioZtBTvXosycQFrc9nm8Hl7E
         z3tg==
X-Gm-Message-State: AAQBX9fAmMh/yLzgPPMbjOCEvhkzkU1N28V8Ghch9vndHd8UH5MFORxE
        r4rDQzpQGL2kK7URPnTenhgmvlnfyNHvSJO+NzK3yg==
X-Google-Smtp-Source: AKy350ah2O8qYURR1sUGonwB93ZBhpzt1TblHI7jb/4F+Y4ShGWiAjdHhab88q75Bq27Kx1cNZs015oX4B64nE556dE=
X-Received: by 2002:a17:902:ab93:b0:19a:7bd4:5b0d with SMTP id
 f19-20020a170902ab9300b0019a7bd45b0dmr262103plr.8.1680820526770; Thu, 06 Apr
 2023 15:35:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230406004018.1439952-1-drosen@google.com> <20230406004018.1439952-2-drosen@google.com>
 <CAEf4BzbyX3i6k5eL6D-5enU+u58nVn_fK28zNBJ4w_Vm-+RiMQ@mail.gmail.com>
In-Reply-To: <CAEf4BzbyX3i6k5eL6D-5enU+u58nVn_fK28zNBJ4w_Vm-+RiMQ@mail.gmail.com>
From:   Daniel Rosenberg <drosen@google.com>
Date:   Thu, 6 Apr 2023 15:35:15 -0700
Message-ID: <CA+PiJmQXcgWD3Uu-pRCU6OfkRepeqwr7qi1uO2rfmy0FPm_sOQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] bpf: verifier: Accept dynptr mem as mem in helpers
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
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
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Apr 6, 2023 at 1:55=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> Something feels off here. Can you paste a bit of verifier log for the
> failure you were getting. And let's have a selftest for this situation
> as well.
>
> ARG_PTR_TO_MEM shouldn't be qualified with the DYNPTR_TYPE flag, it's
> just memory, there is no need to know what type of dynptr it was
> derived from. So if that happens, the problem is somewhere else. Let's
> root cause and fix that. Having a selftest that demonstrates the
> problem will help with that.
>
>
This label is added by dynptr_slice(_rdwr)

if (meta.func_id =3D=3D special_kfunc_list[KF_bpf_dynptr_slice] ||
   meta.func_id =3D=3D special_kfunc_list[KF_bpf_dynptr_slice_rdwr]) {
enum bpf_type_flag type_flag =3D
get_dynptr_type_flag(meta.initialized_dynptr.type);
...
regs[BPF_REG_0].type =3D PTR_TO_MEM | type_flag;

That extra flag was causing the type to be unexpected later on.
I'll add a selftest for this as well.
