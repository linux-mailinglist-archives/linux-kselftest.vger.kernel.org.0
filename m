Return-Path: <linux-kselftest+bounces-41043-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 518BAB4A8D5
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Sep 2025 11:53:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 21A404E23C8
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Sep 2025 09:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67ECD2D1932;
	Tue,  9 Sep 2025 09:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="T9bxLVfO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A66FA29B77E
	for <linux-kselftest@vger.kernel.org>; Tue,  9 Sep 2025 09:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757411478; cv=none; b=a7cBzFifovRPwAnrSPSu5KALGxnegJPK9EuM0FCwUcjpUCdrT7iuYQiY6lpXR1cmU7t8pdymPV/UYnCIDjfNG9lw5s1uDnJ9j9ITq3jQt5zzuVNpqdhJWrPwjKhlWJD//LtKf9rbvdprq7e5xLyEIU4uYHusChyMf9W+XFJ9zwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757411478; c=relaxed/simple;
	bh=EJa7vuO9thKOOMPB5lAnUhOysFC9tBG1PWSpmUvUADI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dERhOaQ/RoNbPJi+rsUn7TRjhj2zuQ7Oxj4QLR36dat2YvWNZR1Z/PVdWzXxUT8aIY2h4G93OZgrb5/4MYwp0UXboGO9BTz/3VmJLe4tQm7E1kTnoSe7TA7NctL4yFGyGls6/B78YGwcRWyUdgLpa9jyKWsTYNb2jpX5nz9B+Yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=T9bxLVfO; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6188b5b113eso2235184a12.0
        for <linux-kselftest@vger.kernel.org>; Tue, 09 Sep 2025 02:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1757411475; x=1758016275; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ttnhzG/W0udtzRhzi90XxZcALtTq/DsFRIfwgo9QFeM=;
        b=T9bxLVfO9qnla7gK+DQ6KnfEp9PcZPfMI0juxYwKkIN8L+U0/9QtiM/MaP1IfBGXn8
         H/t/poqrtPaoVd4v2pI5jPApbip5ymqBzo/QXB6oTPWTU6l6ehGqMurm/j0ueGzYk1mp
         UyN+Uqryq1Qioo4GayF6F3vwegkDxolKkUImHyHMIVOwTPddFrkha991ZSM3WSt7vqwb
         6WhCG4a7HJKgPKlUbtM3xtDrctarDG4ZK1XEWbvk9kgpP0lF/IQztL9vefue+4jinXqt
         CKv+I23mTrBPw7hAgNBaBC6AhvSOMOgx/mxm5aQFarcQEUmOV8+uvi7loHgjHQzEjuyE
         sUlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757411475; x=1758016275;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ttnhzG/W0udtzRhzi90XxZcALtTq/DsFRIfwgo9QFeM=;
        b=d8aK/L8k0SJImCuTA8gZKFRYLJN9U7arZumTTKy5eDVilq07+wMMwotijeahbnkkaT
         8tdXc+w8Y3/8nDK0WohL1JTWNVMGQvB/C5FraCuvifLZZbfP9KeokAcB564twfXkwtA1
         ikHOoKNXIuIkV2JQjgDMMSetwHzwsEaxGmm39Vg9K3YkhEhr4o1f8/IrR6/rrHBFpS+T
         94XPsOyISJPtRCDXVtKf9BCjSVsifFxPwdPnjy/0SuruIkr5luUWCtRhXTajAyAJLGx9
         WyZ3IKcHaxWQgaDbN3/KZOZQKN3pihdupDIpL0tKslhLbdWZUjXbA5Fr1jEv73TJ7BQO
         CV4g==
X-Forwarded-Encrypted: i=1; AJvYcCVYYuD2PSg1MqrOwueg3c3KxTakx9dygE7a5vDSbd0nV5FByCe9ZG6uGrw1qDRFfk+a1tWDy/9L0iplaQ6s1bc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2pOI263ernbwEjWsOtsZgIumCoq+7n0EyGOaJVuF+Rp2simyL
	pN0qIJT9igUeLVWWvkPkScDiGOfGvadH8Q5f7JHg28luigPSoPWBH0bE+BDjeooSC3o=
X-Gm-Gg: ASbGncuSRx3vWcTeU7e8ncGwu7rjOhiGHBSk9MDbGIC1KEWSKsFiP94eT8nyD9oASEb
	ZiZ8XcXpLT2qmTdXw5pgfcFax7G74Ydm3AY8fMo+AmF+0U3MwqaD0fpOhIbHAaluPpMcJVJiTqa
	s7Ay7wTloXRF04Q/2P5E1njbQEwxHJlFsUr2w4TNB/dCXI3oVlajNUKvneScBvt1U2xUlCeUWzb
	mV8oz+7DKyit3rTAoABCe7EYeP21FgT3RZ5imbcCq4fu5zLjeS/ho56oxZud+ljHcVPiTPoe8yj
	ijKk9k2+/wFsYrRUHOBH84s6F4rUYSx+tYxRrL5pGLRSMquRn1C5oVubMtggR7LkaAYIBnEmXgm
	+XybOYXiUDEEU27fEobdJ/GsQ
X-Google-Smtp-Source: AGHT+IHL1A4xOak1CBPxy0OgkkpejE8KlndP1MveZHrFbWUYAt9r14ZZNm1gXyDoH8GW8mDi0O4o2A==
X-Received: by 2002:a05:6402:1d52:b0:626:6ce5:4b8 with SMTP id 4fb4d7f45d1cf-6266ce50670mr9703104a12.32.1757411474932;
        Tue, 09 Sep 2025 02:51:14 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:295f::41f:a])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-62bfe99febdsm923822a12.8.2025.09.09.02.51.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 02:51:14 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: Alexei Starovoitov <ast@kernel.org>,  Daniel Borkmann
 <daniel@iogearbox.net>,  Andrii Nakryiko <andrii@kernel.org>,  Martin
 KaFai Lau <martin.lau@linux.dev>,  Eduard Zingerman <eddyz87@gmail.com>,
  Song Liu <song@kernel.org>,  Yonghong Song <yonghong.song@linux.dev>,
  John Fastabend <john.fastabend@gmail.com>,  KP Singh
 <kpsingh@kernel.org>,  Stanislav Fomichev <sdf@fomichev.me>,  Hao Luo
 <haoluo@google.com>,  Jiri Olsa <jolsa@kernel.org>,  Mykola Lysenko
 <mykolal@fb.com>,  Shuah Khan <shuah@kernel.org>,  bpf@vger.kernel.org,
  linux-kselftest@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next 1/5] selftests/bpf: sockmap_redir: Simplify
 try_recv()
In-Reply-To: <20250905-redir-test-pass-drop-v1-1-9d9e43ff40df@rbox.co> (Michal
	Luczaj's message of "Fri, 05 Sep 2025 13:11:41 +0200")
References: <20250905-redir-test-pass-drop-v1-0-9d9e43ff40df@rbox.co>
	<20250905-redir-test-pass-drop-v1-1-9d9e43ff40df@rbox.co>
Date: Tue, 09 Sep 2025 11:51:13 +0200
Message-ID: <87ikhs54z2.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Sep 05, 2025 at 01:11 PM +02, Michal Luczaj wrote:
> try_recv() was meant to support both @expect_success cases, but all the
> callers use @expect_success=false anyway. Drop the unused logic and fold in
> MSG_DONTWAIT. Adapt callers.
>
> Subtle change here: recv() return value of 0 will also be considered (an
> unexpected) success.
>
> Signed-off-by: Michal Luczaj <mhal@rbox.co>
> ---
>  .../selftests/bpf/prog_tests/sockmap_redir.c       | 25 +++++++++-------------
>  1 file changed, 10 insertions(+), 15 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_redir.c b/tools/testing/selftests/bpf/prog_tests/sockmap_redir.c
> index 9c461d93113db20de65ac353f92dfdbe32ffbd3b..c1bf1076e8152b7d83c3e07e2dce746b5a39cf7e 100644
> --- a/tools/testing/selftests/bpf/prog_tests/sockmap_redir.c
> +++ b/tools/testing/selftests/bpf/prog_tests/sockmap_redir.c
> @@ -144,17 +144,14 @@ static void get_redir_params(struct redir_spec *redir,
>  		*redirect_flags = 0;
>  }
>  
> -static void try_recv(const char *prefix, int fd, int flags, bool expect_success)
> +static void fail_recv(const char *prefix, int fd, int more_flags)
>  {
>  	ssize_t n;
>  	char buf;
>  
> -	errno = 0;
> -	n = recv(fd, &buf, 1, flags);
> -	if (n < 0 && expect_success)
> -		FAIL_ERRNO("%s: unexpected failure: retval=%zd", prefix, n);
> -	if (!n && !expect_success)
> -		FAIL("%s: expected failure: retval=%zd", prefix, n);
> +	n = recv(fd, &buf, 1, MSG_DONTWAIT | more_flags);
> +	if (n >= 0)
> +		FAIL("%s: unexpected success: retval=%zd", prefix, n);
>  }

This bit, which you highlighted in the description, I don't get.

If we're expecting to receive exactly one byte, why treat a short read
as a succcess? Why not make it a strict "n != 1" check?

[...]

