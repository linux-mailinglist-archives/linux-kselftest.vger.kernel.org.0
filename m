Return-Path: <linux-kselftest+bounces-28678-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EF28A5AB0B
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Mar 2025 00:07:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCFB617265A
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Mar 2025 23:07:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6310421ADCC;
	Mon, 10 Mar 2025 23:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HC4R/bVg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29605215178;
	Mon, 10 Mar 2025 23:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741648036; cv=none; b=lq58Lsi5YrdP/YYexMsfofgz7B4G4wbfdSUn82ubf20q3nugRws4b5Q3NeZj3wNgbtKC98IjkyWn3TRBOGwpP5ux7xpg+VtwMVbhlA56dFPGtf5ml3IvJZ1uz97dpT4HPgwBDgmZMehEUqPRZaRkfbheqvnVfuGRqDk3tmt41pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741648036; c=relaxed/simple;
	bh=JzhS4McBCXjeRJuYeYTZgfxnWCyjSgVLpimnfD+mmyE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bZYH012fFrljRxBz95dKYfZeYM40Dh4PS44R4iHwM7Q6ozgixt1ugXj7ZZ89ObQXwRXHirtlpKmKQCpoRIVIgbccEaohVtE+RKoZx/yR28GwH4H4DDtbxhe9LZ6/cQUgJo3w7muJwNcghc409ahJIXHMbhdbXvf0PcRWyjt1lf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HC4R/bVg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DE7FC4CEEE;
	Mon, 10 Mar 2025 23:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741648035;
	bh=JzhS4McBCXjeRJuYeYTZgfxnWCyjSgVLpimnfD+mmyE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=HC4R/bVgS04ua943xHOA3HnT1R36+PVPLwCxfIJ/A2Qa4uUpf/lcl8O4Fh/9ofcwt
	 lEtXgTCbZRzVc8P6/OmDCikU1PJMvs1EKJCrIAkUuk7wvl71xRnn8wc3p5C/zKdN3z
	 SO2Oj5eqNdEZIWAxGLV2oqJ07h1BGZj0IgnMqFFxRRnOAtOmZsuFvU5jAw1Oe4/iHU
	 smHhU3vmFG5OpKlBNPw5nBvQ+9VX/ryY+IPkTAtEAUXDIH/tX0L18L3pnoEt18PyMl
	 y/MKiHyFttCrWCJ5uWhKvyAE8E+prNN7airBvfEpM9gSZZ7SUmJfj2yUlLGWdaI87s
	 HHEunfdnj3FXA==
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3ce886a2d5bso37033675ab.1;
        Mon, 10 Mar 2025 16:07:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV//8YCSuoc0E6flup9mbWe19qesP+WVFDnVit7xUNH0in+5oN1GPZsjmYBGLyVFToavtZmOU9d9GQ8b46u@vger.kernel.org, AJvYcCVVLLu1ND1EjLXVKKnCpE6gDkYNSFhRiFXCsTTzfblxYBP8VFp+LvF/35A3zxKV3kSAFS45Xr5S+v5i3ZDzL4f/@vger.kernel.org, AJvYcCW5h26k5NhnumwAgvuLGBDeSMRItXwy6KTc7cgajgwpBKcMSo6VAXig2gidYwbORtxOc87CXNf8sA==@vger.kernel.org, AJvYcCWEHJhPO/l2AKMTtELbgPC36Bnd/xVHHwQB0R0LiJ6mOU0Sp4u1dlJlTuHzItqwiWz5e6A=@vger.kernel.org, AJvYcCXrSCTfYllbnOZIWtxZNdPu3Or8nJlyqvv2Py+GWRqQPomFsWvX7WQmYU0Obadb4+IaWlqDwuYkP2P1EEqrfJWrWcqLvyvh@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5qbPGzL8DnMpJPEwa+AVR9mfXXN7sVU3PR3dI82faf6BfLIko
	9AgfE+0sO8Vqxm8cBofilW9fWPQ/7W8CB95AUQjX+rXaQhccQhZFlxP/F64057MMxojgaBt1FNA
	DZ7oZzQFEPYFfTXw3QrIOi5Y/81Q=
X-Google-Smtp-Source: AGHT+IFrFz33eGKzI6s8UK47W59xeivzvMS0xnZMkw/8Y5TyTKHEvMj13/Tm3Rsh4y/BtKJnusgx8XmIFiJNB7O3RjI=
X-Received: by 2002:a05:6e02:219c:b0:3d0:10a6:99aa with SMTP id
 e9e14a558f8ab-3d44187c249mr177397255ab.4.1741648034716; Mon, 10 Mar 2025
 16:07:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250310221737.821889-1-bboscaccy@linux.microsoft.com> <20250310221737.821889-3-bboscaccy@linux.microsoft.com>
In-Reply-To: <20250310221737.821889-3-bboscaccy@linux.microsoft.com>
From: Song Liu <song@kernel.org>
Date: Mon, 10 Mar 2025 16:07:03 -0700
X-Gmail-Original-Message-ID: <CAPhsuW4cCkWGnJfxJvBd498iTd3-hMXLg=s7S68vdgPVhdtqCA@mail.gmail.com>
X-Gm-Features: AQ5f1JpWun0dhnGTqBIlLHHy-G5NiP7iX2I9xNN_D-pdziA3qrPPEBFmfrg3y98
Message-ID: <CAPhsuW4cCkWGnJfxJvBd498iTd3-hMXLg=s7S68vdgPVhdtqCA@mail.gmail.com>
Subject: Re: [PATCH v7 bpf-next 2/2] selftests/bpf: Add a kernel flag test for
 LSM bpf hook
To: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Yonghong Song <yonghong.song@linux.dev>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Matt Bobrowski <mattbobrowski@google.com>, 
	Xu Kuohai <xukuohai@huawei.com>, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, bpf@vger.kernel.org, 
	selinux@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 10, 2025 at 3:18=E2=80=AFPM Blaise Boscaccy
<bboscaccy@linux.microsoft.com> wrote:
>
> This test exercises the kernel flag added to security_bpf by
> effectively blocking light-skeletons from loading while allowing
> normal skeletons to function as-is. Since this should work with any
> arbitrary BPF program, an existing program from LSKELS_EXTRA was
> used as a test payload.
>
> Signed-off-by: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
[...]
> +
> +       /* Test with skel. This should pass the gatekeeper */
> +       skel =3D kfunc_call_test__open_and_load();
> +       if (!ASSERT_OK_PTR(skel, "skel"))
> +               goto close_prog;
> +
> +       /* Test with lskel. This should fail due to blocking kernel-based=
 bpf() invocations */
> +       lskel =3D kfunc_call_test_lskel__open_and_load();
> +       if (!ASSERT_ERR_PTR(lskel, "lskel"))
> +               goto close_prog;

This goto is not necessary. But I don't think we need v8 just for this.

Acked-by: Song Liu <song@kernel.org>

> +
> +close_prog:
> +       if (skel)
> +               kfunc_call_test__destroy(skel);
> +       if (lskel)
> +               kfunc_call_test_lskel__destroy(lskel);

[...]

