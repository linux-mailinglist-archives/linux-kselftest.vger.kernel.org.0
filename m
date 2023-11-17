Return-Path: <linux-kselftest+bounces-257-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 896077EF6E3
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Nov 2023 18:19:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43FE1280E15
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Nov 2023 17:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFD1A43163;
	Fri, 17 Nov 2023 17:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f2WTvs2M"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17C12AD;
	Fri, 17 Nov 2023 09:18:54 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-507adc3381cso2932417e87.3;
        Fri, 17 Nov 2023 09:18:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700241533; x=1700846333; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U9nuRLJ1S3+EQkuj+oZlqv6qH4dTQ9g11Gi/7PxPR84=;
        b=f2WTvs2MHfUOEmzW1V1KJo9vcmrN/0nXw4u9NNDl9UFpp7jIFsBSVLOpU3g88wE4Jd
         gqYHyKg3EwCloAxy5l2Z6ab+6rCAr3RWQ/CQb/1hj9Z3CpknhrbX/zCq2jeEGWamx7vD
         TL6bExL7k8h83zGSpWR3iB4fYcArJWWBwblNcHbbwPITwQL3VAMPss6yqqxjkDFbWLHk
         Z1lReDrUEih0cKTL7gNUXT2j8HTq4kJZQrUcTkuTOZGEbw91znphVNHiaO1PBeRbYqcP
         jZh9G4s1Mj9Lo9G57JIwtf7EuQeCGuiqOCxxdqHQURacHCAp0wpDNLfznj6QQ+LEZhCE
         E+rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700241533; x=1700846333;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U9nuRLJ1S3+EQkuj+oZlqv6qH4dTQ9g11Gi/7PxPR84=;
        b=Didl+FAHSnpH9Jkwd6Lo794h3SJFndgaos3OC3rPr3KD8MWZckkEv5gMbs8cGAXfgH
         Wkxx3du1E2Ts/TwyGPWluTXmagoUHc5lbQ1g7l4VSsbkrf2AcQgZXNQwdMWRhucyh5Y5
         jBO9YLmgmpif57W62KrUTK+V8+thYlZSZ8UwpYe7usdd+MuiDnm6kB5cfIW0q3VGhrW3
         x1SX3OF5rgwB83UApo1EDMxkZD0MjGWk8VVH/lg0gFwi8FhDH7veSxKFBKvDMPhDPpmC
         +kYpS6gn5idFqJXRz7nkrK5Wp3vIirPRe6UamzlVA+3DK+x8SZMlD3eqc0KAttbo46WC
         Lfig==
X-Gm-Message-State: AOJu0YxI+UPIzOD3nL8bet3t/TijnkLCP/56zNagY3JKL3IFXDpPSErM
	U4iqpoLWxQYmM5eQeGtXmli7PE3jSoSK+8lDaXQ=
X-Google-Smtp-Source: AGHT+IGq1tPI4eYPfs2NVjkrFJlW/fMIxp0l26ixli8xQwPegejmJBL93pwV0xOpLM1ZMIhDqDpLWn+dVDVC1wp/JtI=
X-Received: by 2002:ac2:547c:0:b0:50a:763f:ecf1 with SMTP id
 e28-20020ac2547c000000b0050a763fecf1mr176643lfn.12.1700241532550; Fri, 17 Nov
 2023 09:18:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <GV1PR10MB6563FCFF1C5DEBE84FEA985FE8B0A@GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM>
In-Reply-To: <GV1PR10MB6563FCFF1C5DEBE84FEA985FE8B0A@GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 17 Nov 2023 12:18:40 -0500
Message-ID: <CAEf4Bza4fejyKRCdcq0WwrvZ-p8JbMq0MPQB_BGzaxPGHT2EoQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/4] selftests/bpf: Update multiple prog_tests to
 use ASSERT_ macros
To: Yuran Pereira <yuran.pereira@hotmail.com>
Cc: bpf@vger.kernel.org, andrii@kernel.org, mykolal@fb.com, ast@kernel.org, 
	martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com, 
	haoluo@google.com, jolsa@kernel.org, shuah@kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kernel-mentees@lists.linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 15, 2023 at 10:14=E2=80=AFPM Yuran Pereira
<yuran.pereira@hotmail.com> wrote:
>
> Multiple files/programs in `tools/testing/selftests/bpf/prog_tests/` stil=
l
> heavily use the `CHECK` macro, even when better `ASSERT_` alternatives ar=
e
> available.
>
> As it was already pointed out by Yonghong Song [1] in the bpf selftests t=
he use
> of the ASSERT_* series of macros is preferred over the CHECK macro.
>
> This patchset replaces the usage of `CHECK(` macros to the equivalent `AS=
SERT_`
> family of macros in the following prog_tests:
> - bind_perm.c
> - bpf_obj_id.c
> - bpf_tcp_ca.c
> - vmlinux.c
>
> [1] https://lore.kernel.org/lkml/0a142924-633c-44e6-9a92-2dc019656bf2@lin=
ux.dev
>
> Yuran Pereira (4):
>   Replaces the usage of CHECK calls for ASSERTs in bpf_tcp_ca
>   Replaces the usage of CHECK calls for ASSERTs in bind_perm
>   Replaces the usage of CHECK calls for ASSERTs in bpf_obj_id
>   selftests/bpf: Replaces the usage of CHECK calls for ASSERTs in
>     vmlinux
>
>  .../selftests/bpf/prog_tests/bind_perm.c      |   6 +-
>  .../selftests/bpf/prog_tests/bpf_obj_id.c     | 204 +++++++-----------
>  .../selftests/bpf/prog_tests/bpf_tcp_ca.c     |  48 ++---
>  .../selftests/bpf/prog_tests/vmlinux.c        |  16 +-
>  4 files changed, 105 insertions(+), 169 deletions(-)
>
> --
> 2.25.1
>

It seems like you introduced a few failures in selftests, please take
a look at [0] and fix them, thanks!

  [0] https://github.com/kernel-patches/bpf/actions/runs/6885976657/job/187=
31029901

