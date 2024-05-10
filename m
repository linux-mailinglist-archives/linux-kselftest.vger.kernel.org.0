Return-Path: <linux-kselftest+bounces-10059-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 712F58C2C6D
	for <lists+linux-kselftest@lfdr.de>; Sat, 11 May 2024 00:06:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47ED01C21B89
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 May 2024 22:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F0AA13CFA4;
	Fri, 10 May 2024 22:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KFBEBZ5g"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B7613B5BB;
	Fri, 10 May 2024 22:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715378757; cv=none; b=uGgVMbJ4ZP6wEldRDAwRfvDLXWj0czdqkex8yIKCFRDGEtMvUKQ7W0saEcL7hWyRchx9ZSngYnkr65APkp5Zl/w3tEy2/u/UFw250sur4voDW8gvynNj1aNc943Xuz+87KmsWXbP+TvQ+jIzbci8kq99Wyohwm2/BBOCvAMn6/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715378757; c=relaxed/simple;
	bh=t3NyXa0BfG7ojc5QL7HlfbFe3C1i4Bv2cdBQeHvPXAM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OBMoGjofb9veAR//frEQDZ99BndKATLmc/6jV4QCnoXWQM73fQ3SA40e0y/Ba7fVEoaQZ1XwUQLuSGB7zrkcfGilaAccfUrnWEDqT941qatE+srldgK+Vr1rG27x49K+tpdF2WNaQpwFrj281jRdbRwnR7+QJwaaRlITglg8/Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KFBEBZ5g; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2b36232fa48so1962544a91.1;
        Fri, 10 May 2024 15:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715378755; x=1715983555; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gw8tdTUu26ntBT3cIpKlEbccxaze+gSWzCQoABlagU0=;
        b=KFBEBZ5g6iKxCt5HxAoTe5APYo+sLx9fRl+jhETbm9NNSbo4VCaHu9ETMxLixAfLpn
         9F5UDH44gx5tbSY/tW5/VumixTjulSkv/mVLyvSBhVNVyrbgVFog5ctcA2RdBLYUnheN
         WzQ0fe0cYntpC+qlh4ttVwK209rbZVsbkaFU/i7KjPaRx+blUVv7z8JA3LfFo2YimKre
         ZTpBkUxVId6sf5mn+OCidB5GsXkjFBc/XfcFUlCHeCRSdhbHqTM18E6GkUCE4q69NE/h
         alQwxGwTlLTGMBeKtDIWBkCnbFMW3Rv6DSqJqrPDYJr7W3UK3f2M3y340qb22uoZq6tE
         gzKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715378755; x=1715983555;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gw8tdTUu26ntBT3cIpKlEbccxaze+gSWzCQoABlagU0=;
        b=FQ0Qgb9YkkJyvBI1NjO+5rxwW2ctKujGEq//3abYykBQ7mCb/hC9q1oZCIHHg54fn+
         pXT33dVRhU5rWFMqx9QQV8BmH35Mcorct2XRllEa83f9KOBPRkbfSzfHzgMxU2dvKguO
         iS60457OfgTW9N+33vMRiFfjt8uG5ZzcNoCKvd1KAih+4cMmQS8ykMImUulNyQ9tR51g
         XI0Z+o3jJ1uGcBH2LzqRyjlCPv1IzqMhs/8DK+YjacYsSLkiLi/cNUirs7mk3BvZNx37
         cb7bmg0unTm23T3hJxzMN8ySNy8VEADS1vRZea6SP1Ckj2BK8Qe1lOSkbc023/otu3Yd
         lnrw==
X-Forwarded-Encrypted: i=1; AJvYcCX5LZJgWsmvb0/QrTm5CykVNjCAbn4aZVXJPT1RoObCeyLCKvzrRdaQGdiQIk3foEzPhrj0yM3AieH4dv1GKW+Cm1FIhN2R2kb/OUS19pFw
X-Gm-Message-State: AOJu0YxC6kFgq3vHU8iz3uMUc3pRD3rjUJnaifhYjOLdknTeBL+8t+ET
	/1SmINWYUA60puJkULfv2TVJeQdfCKp3C2zqqAUPUPpk1xdIM4JcBxpe+CwVq0paAnP4OuwduUk
	0SRdtoyH3454kg/nHw2N+wIS8pq4=
X-Google-Smtp-Source: AGHT+IHBh4GmlBMtNORtj2s/FodEJgl8Bu01+ZnUrn1I5A1juWJ5T64ca8WB0aQgBjiZm90GP/XLesQR2wZ0VX9I5/w=
X-Received: by 2002:a17:90a:fb52:b0:2b2:827f:4652 with SMTP id
 98e67ed59e1d1-2b6cc342827mr3807704a91.6.1715378754975; Fri, 10 May 2024
 15:05:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240510190246.3247730-1-jrife@google.com>
In-Reply-To: <20240510190246.3247730-1-jrife@google.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 10 May 2024 15:05:42 -0700
Message-ID: <CAEf4BzZ+Gymr9hgJog3NddVVhtvcGiYwLHGGUVEruUUy-h8t8Q@mail.gmail.com>
Subject: Re: [PATCH v1 bpf-next 00/17] Retire progs/test_sock_addr.c
To: Jordan Rife <jrife@google.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	Geliang Tang <tanggeliang@kylinos.cn>, Daan De Meyer <daan.j.demeyer@gmail.com>, 
	Shung-Hsi Yu <shung-hsi.yu@suse.com>, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 10, 2024 at 12:08=E2=80=AFPM Jordan Rife <jrife@google.com> wro=
te:
>
> This patch series migrates remaining tests from bpf/test_sock_addr.c to
> prog_tests/sock_addr.c and progs/verifier_sock_addr.c in order to fully
> retire the old-style test program and expands test coverage to test
> previously untested scenarios related to sockaddr hooks.
>
> This is a continuation of the work started recently during the expansion
> of prog_tests/sock_addr.c.
>
> Link: https://lore.kernel.org/bpf/20240429214529.2644801-1-jrife@google.c=
om/T/#u
>
> =3D=3D=3D=3D=3D=3D=3D
> Patches
> =3D=3D=3D=3D=3D=3D=3D
> * Patch 1 moves tests that check valid return values for recvmsg hooks
>   into progs/verifier_sock_addr.c, a new addition to the verifier test
>   suite.
> * Patches 2-5 lay the groundwork for test migration, enabling
>   prog_tests/sock_addr.c to handle more test dimensions.
> * Patches 6-11 move existing tests to prog_tests/sock_addr.c.
> * Patch 12 removes some redundant test cases.
> * Patches 14-17 expand on existing test coverage.
>
> Jordan Rife (17):
>   selftests/bpf: Migrate recvmsg* return code tests to
>     verifier_sock_addr.c
>   selftests/bpf: Use program name for skel load/destroy functions
>   selftests/bpf: Handle LOAD_REJECT test cases
>   selftests/bpf: Handle ATTACH_REJECT test cases
>   selftests/bpf: Handle SYSCALL_EPERM and SYSCALL_ENOTSUPP test cases
>   selftests/bpf: Migrate WILDCARD_IP test
>   selftests/bpf: Migrate sendmsg deny test cases
>   selftests/bpf: Migrate sendmsg6 v4 mapped address tests
>   selftests/bpf: Migrate wildcard destination rewrite test
>   selftests/bpf: Migrate expected_attach_type tests
>   selftests/bpf: Migrate ATTACH_REJECT test cases
>   selftests/bpf: Remove redundant sendmsg test cases
>   selftests/bpf: Retire test_sock_addr.(c|sh)
>   selftests/bpf: Expand sockaddr program return value tests
>   sefltests/bpf: Expand sockaddr hook deny tests
>   selftests/bpf: Expand getsockname and getpeername tests
>   selftests/bpf: Expand ATTACH_REJECT tests
>
>  tools/testing/selftests/bpf/.gitignore        |    1 -
>  tools/testing/selftests/bpf/Makefile          |    4 +-
>  .../selftests/bpf/prog_tests/sock_addr.c      | 1821 +++++++++++++++--
>  .../selftests/bpf/prog_tests/verifier.c       |    2 +
>  .../testing/selftests/bpf/progs/bind4_prog.c  |    6 +
>  .../testing/selftests/bpf/progs/bind6_prog.c  |    6 +
>  .../selftests/bpf/progs/connect4_prog.c       |    6 +
>  .../selftests/bpf/progs/connect6_prog.c       |    6 +
>  .../selftests/bpf/progs/connect_unix_prog.c   |    6 +
>  .../selftests/bpf/progs/getpeername4_prog.c   |   24 +
>  .../selftests/bpf/progs/getpeername6_prog.c   |   31 +
>  .../selftests/bpf/progs/getsockname4_prog.c   |   24 +
>  .../selftests/bpf/progs/getsockname6_prog.c   |   31 +
>  .../selftests/bpf/progs/sendmsg4_prog.c       |    6 +
>  .../selftests/bpf/progs/sendmsg6_prog.c       |   57 +
>  .../selftests/bpf/progs/sendmsg_unix_prog.c   |    6 +
>  .../selftests/bpf/progs/verifier_sock_addr.c  |  331 +++
>  tools/testing/selftests/bpf/test_sock_addr.c  | 1140 -----------
>  tools/testing/selftests/bpf/test_sock_addr.sh |   58 -
>  19 files changed, 2142 insertions(+), 1424 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/progs/getpeername4_prog.c
>  create mode 100644 tools/testing/selftests/bpf/progs/getpeername6_prog.c
>  create mode 100644 tools/testing/selftests/bpf/progs/getsockname4_prog.c
>  create mode 100644 tools/testing/selftests/bpf/progs/getsockname6_prog.c
>  create mode 100644 tools/testing/selftests/bpf/progs/verifier_sock_addr.=
c
>  delete mode 100644 tools/testing/selftests/bpf/test_sock_addr.c
>  delete mode 100755 tools/testing/selftests/bpf/test_sock_addr.sh
>
> --
> 2.45.0.118.g7fe29c98d7-goog
>

This patch set causes BPF CI to fail to build BPF selftests ([0]),
please check and fix. Thanks!

  [0] https://github.com/kernel-patches/bpf/actions/runs/9036931713/job/248=
34899012

