Return-Path: <linux-kselftest+bounces-32440-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C684AA9D6A
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 22:41:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8051A1763B6
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 20:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A85D5270ED4;
	Mon,  5 May 2025 20:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Owhl5LDL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ECF5270EB9
	for <linux-kselftest@vger.kernel.org>; Mon,  5 May 2025 20:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746477677; cv=none; b=RMpAd34ioSjC2cuGNgritJmDOrO2jEBysDJLQVuP5VyUAX502GB8+7DfCVW9LdVxrLjvU96Zwv7UOCjtP3hk4wbzndLvg6JbSwv4V5of2SQH3ZlVARyZKABTR85gRxz+2+uj4zlnq3ODkXLniu4ZhYcofs7mg24byaIHv33Q81k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746477677; c=relaxed/simple;
	bh=d8LfDvKjYkgCUCdFIUw90/ekiXyN5J8SQRenxzuFPN0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e9mth9pJ0npqoXBr9GARc56RkNmDc1T3x+CWobI+sii59TGLyEJfbYSA/Kc+ALC3W4llAobDdmhnGOsiJ8NDIHi9ZZrWg4XWsQeglPItJaO5o1fL3i8dprVTee/+faR7IZJOcw1C3x1rZmOiex3wuFRS9pqlsDolUiuhAoqrc5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Owhl5LDL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AA53C4CEFA
	for <linux-kselftest@vger.kernel.org>; Mon,  5 May 2025 20:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746477677;
	bh=d8LfDvKjYkgCUCdFIUw90/ekiXyN5J8SQRenxzuFPN0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Owhl5LDLXkQNX7x4a0Z1G/aYlPwj725dS3lGDTCV+pR8BnaB+NmYGY89SDeQF3QeH
	 QMcVS3pTVG7yr2bHdU7lOtM3GpgOBxthge8YONACDjcAlhOe4HTfIekToeKwPz3N+F
	 SCvS1XUDNBQ9JydjTGHjI6amf0i1/NdehRIliJtQfQsIDhOYJyq9LDTsKQRHtbU2Kp
	 VJmnHLfuSDXWtz/sjL8WEX+OzJduJRaezfIl3m0tVpYtQRnTmvcqfk+BJYCfe69Lou
	 ij+YIV+P9kP38iUmIsVH/8hUm/82tum1XfYpsYxGLZYH5aF361BOrdowd6cGN/CkIz
	 DWjJWz4Jh2/JQ==
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5f7ec0e4978so4119515a12.1
        for <linux-kselftest@vger.kernel.org>; Mon, 05 May 2025 13:41:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUlJ5QT/asRkdb3g3JBV53UDAbptPEKx4KfMR6ojX669c/vOAaZH7YTWnhwv08u8dilKnnq1lXAKUPjsv1NuNA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJp7+pryOqrQ9gqnVIQp4Kmu8BuEA+bafs87gEJd5lUHhNMuR+
	3lvWJoY7PrrJP1RByYT08tp3GlFX770nvEqOREs51HruZj8hIE0paxL7nAmFtgL1XDcm/6k+y0i
	lnLWIYrrbvBfkkJ7C6eCAQMGhw+DWoBpDEGCA
X-Google-Smtp-Source: AGHT+IFfJkERYqcbzT4YQQTS+Mj+93sXv0WPP/4xBqB2yT0tfFb61yLhT9GQEjqTDYpKCZHUl0y2flUvtx0O/XgDMu4=
X-Received: by 2002:a05:6402:280d:b0:5f9:dbc6:d363 with SMTP id
 4fb4d7f45d1cf-5fb70d52af5mr319781a12.32.1746477675536; Mon, 05 May 2025
 13:41:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250502184421.1424368-1-bboscaccy@linux.microsoft.com>
 <20250502210034.284051-1-kpsingh@kernel.org> <87o6w7ge3o.fsf@microsoft.com>
In-Reply-To: <87o6w7ge3o.fsf@microsoft.com>
From: KP Singh <kpsingh@kernel.org>
Date: Mon, 5 May 2025 22:41:04 +0200
X-Gmail-Original-Message-ID: <CACYkzJ7Ur4kFaGZTDvcFJpn0ZwJ9V+=3ZefUURtkrQGfa68zLg@mail.gmail.com>
X-Gm-Features: ATxdqUF8uthsI1M39wdVx3o5QcABchfWwSxBzLmXfLY2I-_y9VLmlQgWs2T9bB0
Message-ID: <CACYkzJ7Ur4kFaGZTDvcFJpn0ZwJ9V+=3ZefUURtkrQGfa68zLg@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] Introducing Hornet LSM
To: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
Cc: James.Bottomley@hansenpartnership.com, bpf@vger.kernel.org, 
	code@tyhicks.com, corbet@lwn.net, davem@davemloft.net, dhowells@redhat.com, 
	gnoack@google.com, herbert@gondor.apana.org.au, jarkko@kernel.org, 
	jmorris@namei.org, jstancek@redhat.com, justinstitt@google.com, 
	keyrings@vger.kernel.org, linux-crypto@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-security-module@vger.kernel.org, llvm@lists.linux.dev, 
	masahiroy@kernel.org, mic@digikod.net, morbo@google.com, nathan@kernel.org, 
	neal@gompa.dev, nick.desaulniers+lkml@gmail.com, nicolas@fjasle.eu, 
	nkapron@google.com, paul@paul-moore.com, roberto.sassu@huawei.com, 
	serge@hallyn.com, shuah@kernel.org, teknoraver@meta.com, 
	xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 5, 2025 at 7:30=E2=80=AFPM Blaise Boscaccy
<bboscaccy@linux.microsoft.com> wrote:
>
> KP Singh <kpsingh@kernel.org> writes:
>
> [...]
>
> > Now if you really care about the use-case and want to work with the mai=
ntainers
> > and implement signing for the community, here's how we think it should =
be done:
> >
> > * The core signing logic and the tooling stays in BPF, something that t=
he users
> >   are already using. No new tooling.
> > * The policy decision on the effect of signing can be built into variou=
s
> >   existing LSMs. I don't think we need a new LSM for it.
> > * A simple UAPI (emphasis on UAPI!) change to union bpf_attr in uapi/bp=
f.h in
> >   the BPF_PROG_LOAD command:
> >
> > __aligned_u64 signature;
> > __u32 signature_size;
>
> I think having some actual details on the various parties' requirements
> here would be helpful. KP, I do look forward to seeing your design;
> however, having code signing proposals where the capabilities are
> dictated from above and any dissent is dismissed as "you're doing it
> wrong" isn't going to be helpful to anyone that needs to use this in
> practice.

Please don't misrepresent the facts, you got feedback from Alexei in
various threads, but you chose to argue on the points that were
convenient for you (i.e. usage of BPF internal APIs) and yet you claim
to "work with the BPF community and maintainers" by arguing instead of
collaborating and paying attention to the feedback given to you.

1. https://lore.kernel.org/bpf/CAADnVQKF+B_YYwOCFsPBbrTBGKe4b22WVJFb8C0PHGm=
RAjbusQ@mail.gmail.com/

  Your solution to address the ELF loader specific issue was to just
allow list systemd? You totally ignored the part about loaders in
golang and Rust that do not use ELF. How is this    "directive from
above?"

2. Alexei suggested to you in
https://lore.kernel.org/bpf/87plhhjwqy.fsf@microsoft.com/

  "A signature for the map plus a signature for the prog
  that is tied to a map might be a better option.
  At map creation time the contents can be checked,
  the map is frozen, and then the verifier can proceed
  with prog's signature checking."

You never replied to this.

3. To signing the attachment points, you replied

> That statement is quite questionable. Yes, IIRC you brought that up. And
> again, runtime policy enforcement has nothing to do with proving code
> provenance. They are completely independent concerns.

The place where the BPF program is attached is a key part of the
provenance of the BPF program and its security (and other) effects can
vary greatly based on that. (e.g. imagine a reject all LSM program
that is attached to the wrong LSM hook). This is why it's not the same
as module loading.

4. https://lore.kernel.org/bpf/CAADnVQKF+B_YYwOCFsPBbrTBGKe4b22WVJFb8C0PHGm=
RAjbusQ@mail.gmail.com/

Programs can still access maps, now if you combine the issue of
ELF-less loaders and that maps are writeable from other programs as
freezing only affects userspace (i.e. when a binary gets an FD to a
map and tries to modify it with syscalls) your implementation fails.

The reply there about trusted user-space still needs to come with
better guarantees from the kernel, and the kernel can indeed give
better guarantees, which we will share. The reason for this is that
your trusted binary is not immune to attacks, and once an attacker
gains code execution as this trusted binary, there is no containing
the compromise.

- KP

>
> Also, I don't think anyone actually cares, at least I don't, who calls
> verify_pkcs7_signature or whatnot. Verifying signed binary blobs with a
> private key is a solved problem and isn't really interesting.
>
> Our requirements for code signing are just an extension of secure boot
> and module signing logic:
>
> * Prove all code running in ring zero has been signed
> * Not trivially defeatable by root
> * Ultimately, no trusted userspace components
> * Secure from and not vulnerable to TOCTOU attacks
> * Shouldn't be overly vulnerable to supply-chain attacks
> * The signature checking logic and control paths should be human-readable
> * Work easily and be backportable to stable kernels
> * There should be a simple kconfig option to turn this on or off
> * This solution needs to be in the mainline kernel
>
> Hornet was implemented to meet those requirements, living in the LSM
> subsystem, written in C. As of today, one cannot accomplish those
> requirements via BPF-LSM, which is why C was chosen.
>
> One can easily realize there is absolutely no way to have a single
> one-size-fits-all signing solution for everything listed in
> https://ebpf.io/applications/.
>
> If you want to go the UAPI route, I would wholeheartedly recommend
> making it extensible and having this data be available to the policy
> LSMs.
>
> enum bpf_signature_type {
>   /* x509 signature check against program instructions only */
>   BPF_SIGNATURE_PROG_ONLY =3D 0,
>   /* x509 combined signature check against program instructions and used =
maps */
>   BPF_SIGNATURE_PROG_USED_MAPS =3D 1,
>   /* more of these to be determined via usage */
>   ...
> };
>
> _aligned_u64 signature;
> __u32 signature_size;
> __u32 signature_type;
>
> The other option for solving this in the general is in-kernel
> loaders. That's gotten pushback as well.
>
> -blaise
>
>
>
>
>

