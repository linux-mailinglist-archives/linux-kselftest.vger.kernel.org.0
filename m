Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F77F6C6E83
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Mar 2023 18:16:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbjCWRQc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 23 Mar 2023 13:16:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbjCWRQa (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 23 Mar 2023 13:16:30 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEC4626866;
        Thu, 23 Mar 2023 10:16:29 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id eg48so89793487edb.13;
        Thu, 23 Mar 2023 10:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679591788;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UyfF97kg0OssMdjFthc2Xy3Web7QH9KpQCMnZmHyDZk=;
        b=S1lCXnisFdgkrdmHgl445bKHxAT6H/kvGykTpRQPIo/DybGALPmoPHFCMhfvqOynYp
         rzD6GIf2zaPtL+TULCx3Dwi1MchAMAzmf7ZkwzWxCw09gMLPqDpQwtm5caU48hbfW5TN
         kB3pUQvBupZQpK5kgTQo7JCo7koODxfOvDzmUiUKFPYCt+Y5Z0Tpxh+aRgJ0r9w0EVMG
         rNwCKNsDx4hzQzpq0Co/U0DagdmUiNAzCHCvjSzfFxZswwg0HRaJK7AZNa651M9tHzfj
         kNaeKuPBBzXK66cSq7opPWUNzXYUS55LwVFWHorz3kY8lHYVWpnGasRIHoFrXzapHoqW
         0sGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679591788;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UyfF97kg0OssMdjFthc2Xy3Web7QH9KpQCMnZmHyDZk=;
        b=0mWddD8ayk4PEIsn+tfrbaXsx4Rq74VUg93g25nhVXT9Xvxw35dK9LRcUkd0Qr6rHX
         mwLPhZ3qoqyBdSe3PVZsFTcbFypiPGR9PCbYSo6Jf1GXHOLT45T2VYejt/fRWWWKri/T
         RaAXQaCpYMWO36hygoGd1WUgqZ9d0Yo78uTRcuuGhEnyGQSUhxa1Qdw2IGyqqduhYgaV
         sLrkXKy0KpViUr/dkzxzO3aOmrHW3YGWWcqD7rT/1n76r4R1NhfczbLHZz/T20jI1RVh
         JDH+jNRKA4RuRwrNv/xiHoDWwpby9lSYpeir2NfcfsGQ9gceQcT/rJBK+6xysa12U5e7
         V+Vg==
X-Gm-Message-State: AAQBX9dxXJULrKtejaVkWux76dLMu99m9wh86REjz7wMJNI42SNgyOuK
        eH/i2UF+uUv1IOH48kODDr1VHiFrytSTcRaG5Js=
X-Google-Smtp-Source: AKy350bmZ5vj8yuVcu/t2T1UlfpfQBHXV0sDBGYwZrM4kP7wn4O4dtC7c+SDujPKZRG0TUuff+VqrYDiQCi6iVzFdWk=
X-Received: by 2002:a50:f69e:0:b0:4fc:8749:cd77 with SMTP id
 d30-20020a50f69e000000b004fc8749cd77mr87589edn.3.1679591788153; Thu, 23 Mar
 2023 10:16:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230324045842.729719-1-xukuohai@huaweicloud.com> <20230324045842.729719-2-xukuohai@huaweicloud.com>
In-Reply-To: <20230324045842.729719-2-xukuohai@huaweicloud.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 23 Mar 2023 10:16:17 -0700
Message-ID: <CAADnVQLKxssX1K_CSpbkcOPep2NNnoTRt2bMFzKhCo5AaUzwWA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] bpf: add bound tracking for BPF_MOD
To:     Xu Kuohai <xukuohai@huaweicloud.com>
Cc:     bpf <bpf@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Mar 23, 2023 at 8:59=E2=80=AFAM Xu Kuohai <xukuohai@huaweicloud.com=
> wrote:
>
> From: Xu Kuohai <xukuohai@huawei.com>
>
> dst_reg is marked as unknown when BPF_MOD instruction is verified, causin=
g
> the following bpf prog to be incorrectly rejected.
>
> 0: r0 =3D 0
> 1: r0 %=3D 1   // r0 is marked as unknown
> 2: r1 =3D 0
> 3: r1 +=3D 1
> 4: if r1 < r0 goto pc-2 // verifier treats the loop as unbounded
> 5: exit
>
> To teach verifier to accept the above prog, this patch adds bound trackin=
g
> for BPF_MOD.
>
> The approach is based on the following rules:
>
> 1. BPF_MOD is unsigned;
>
> 2. For an unsigned constant divisor x:
>
>  a. when x !=3D 0, the resulted dst_reg bits are in the range [0, x - 1],
>     and if no wrapping occurs, the result can be further narrowed down
>     to [umin mod x, umax mod x];
>
>  b. when x =3D=3D 0, dst_reg is truncated to 32 bits by mod32 or remains
>     unchanged by mod64.
>
> Signed-off-by: Xu Kuohai <xukuohai@huawei.com>

Same Nack as before.
You haven't answered _why_ anyone needs it.
