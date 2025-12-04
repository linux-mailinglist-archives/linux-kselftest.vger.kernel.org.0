Return-Path: <linux-kselftest+bounces-47088-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C0DADCA5B4E
	for <lists+linux-kselftest@lfdr.de>; Fri, 05 Dec 2025 00:47:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7E97C30C8838
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Dec 2025 23:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 505C92D7DCE;
	Thu,  4 Dec 2025 23:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ME5YJKGE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C2812652AF
	for <linux-kselftest@vger.kernel.org>; Thu,  4 Dec 2025 23:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764892048; cv=none; b=r87HrTEArc7f2jl2qHbETRV+0fevfH21A6eGBleiqX4ixdgVSxqiW0OKtSW5vffR3WuvpWE6phYTBxcmjnNmvwG+yJOpFcYPPqXhk4ik/f5l+1eMaktVNsDT3Svmqiy4B7Vs4kMZ5nKnLgWq+2zhkWUYkepSH+H7YktCVbKrje0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764892048; c=relaxed/simple;
	bh=hT0jXf06Hg5ool75lEaoEWofWJySQUZ8WtvApgiHkN0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KGm8CWzZRr+R2QVtjNIbDhOk2FZwPN8SSPaMw57oFtErY8l4Gz/elbDNykOopivLhK386fPxYGh+fOPDaaV8PvQqRCBNyIbNxnUQLBVglqXp+vKZc1v6tFkvpK2i5ASFBB0xWpDYXn/wcKq48l7mNlJ+0idv6ExHQAWZqpBUkeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ME5YJKGE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDF3EC2BCB0
	for <linux-kselftest@vger.kernel.org>; Thu,  4 Dec 2025 23:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764892047;
	bh=hT0jXf06Hg5ool75lEaoEWofWJySQUZ8WtvApgiHkN0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ME5YJKGEk2b9InbXuEwPf7J2oFPviMCOFkZh64+VVU/1krdz4hTGuFZ98Ufi24UpV
	 GxFSj1jzz//v1DxgAR359Hi9M3kdgasEvm8KgasmlHwM/csGGU7Oo8FCqgliZ8iEAR
	 t3eN6IvppGgEbSZZws2LXH/BUqZANnr+IrebNK+L7EJ4KvimOvty3FUoHsYn1Gbvxb
	 FnU95pwIxYx0KH58UwBiHhSYCXboT7tKayHVhv1XzIhd+W00WFj1uMD73QH49WvlD8
	 jbm1MGKJaXkQp77vX02qKvBc57Ke4mVNT8RfwhA/f4Jn1THWBj7SipRcGm9MailYk8
	 ptrSd1nZJa8Uw==
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-8804650ca32so14622546d6.0
        for <linux-kselftest@vger.kernel.org>; Thu, 04 Dec 2025 15:47:27 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVAPi/aIPDT6cfE4PreO8fQaPLrwQ0al2DIEKoLm2qlg0jMwxMUPNug3br8FbtWDknw0X43opA7ZloWcn5+Zpc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxiEZ2xWdsLd7k1ODoko7MnBLDyQ5dVm7/08bOE78u9aQkgMN5
	/Ei0eDmEp1R37VsLqAQ/Nrr+hMI2AdbYFBHyU3BqTUqg4xXQ/JWOiYVXzUXhzI3itYhiWVwZPzb
	VVRrScXnEWAKMRG5rc1UczBIUaKizr5E=
X-Google-Smtp-Source: AGHT+IHlYceJ+78Ee5LmrFn+z38HMUOm3BWzCrPr+rKE1ybXEBOtgJ9kjc+BlrGXKlBKVHUQAdpFfABa0MPeaqftb/I=
X-Received: by 2002:a05:622a:4c9:b0:4ee:24b8:2275 with SMTP id
 d75a77b69052e-4f017544b24mr102701051cf.1.1764892046793; Thu, 04 Dec 2025
 15:47:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251204074632.8562-3-electronlsr@gmail.com> <20251204123853.1235-1-electronlsr@gmail.com>
In-Reply-To: <20251204123853.1235-1-electronlsr@gmail.com>
From: Song Liu <song@kernel.org>
Date: Thu, 4 Dec 2025 15:47:15 -0800
X-Gmail-Original-Message-ID: <CAPhsuW7NTGkbVD97DQddwPEQR6PZgYQJ6c-JcEsNUg6ddnh3rA@mail.gmail.com>
X-Gm-Features: AWmQ_bnotTlFAEtAAQMuSQAceWybvk9o2x2DWPS9H0GjvjWvvnpQfTra6YlnUzo
Message-ID: <CAPhsuW7NTGkbVD97DQddwPEQR6PZgYQJ6c-JcEsNUg6ddnh3rA@mail.gmail.com>
Subject: Re: [PATCH bpf v4 2/2] selftests/bpf: add regression test for bpf_d_path()
To: Shuran Liu <electronlsr@gmail.com>
Cc: mattbobrowski@google.com, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	eddyz87@gmail.com, yonghong.song@linux.dev, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, 
	rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	dxu@dxuuu.xyz, linux-kselftest@vger.kernel.org, shuah@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 4, 2025 at 4:39=E2=80=AFAM Shuran Liu <electronlsr@gmail.com> w=
rote:
>
> Hi,
>
> I looked into the CI failure and it=E2=80=99s caused by the test assuming
> /tmp is on tmpfs, which is not true in the CI environment, so
> fallocate() fails there. Since /dev/shm is mounted as tmpfs on that
> setup, would it be acceptable to change the test to use a file under
> /dev/shm instead of /tmp?

You can use mkstemp. There are a few examples in prog_tests.

Thanks,
Song

