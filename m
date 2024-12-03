Return-Path: <linux-kselftest+bounces-22734-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54B9B9E1B23
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Dec 2024 12:38:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AE142845B2
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Dec 2024 11:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C43A1E3DFF;
	Tue,  3 Dec 2024 11:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kRq2xUlV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F0BE1E009A;
	Tue,  3 Dec 2024 11:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733225890; cv=none; b=qDBJFmbdcqwSpI47Qcl/M891eD2nR5TUWJGXRf3nVDr1v4N+yGIgDLdxP8ujRnMaU2WSDjBXgY19JyA2Qyh9SZ0Uw8h2Inl2XJVSSM2em5LL8sGyL6AkokBSaJJTl2n6Rbodli0uIf9Y/sgz/iMq7EVHZcrGVFfhySKp/e93+XM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733225890; c=relaxed/simple;
	bh=SOpDD/j8v1BW+RzStopfvCSMdaQOSrVLeT5dQ5ZfMis=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Buv2munsAzDv/2CaR3/CbvTbxHLKw6vZ65KlUf1XX8qUrmACxRgIAODI6G18gAx0lf31rn5Qh6ZuqiOlH5PnMGguchfUFKv/JxI5PuV9hGmBJYqWXxzmv2QeXId2rIqnvWNpJzhDmWR2ye3qe2d1B6vVHBW30Wxw7rENB6vKuwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kRq2xUlV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AA00C4CED6;
	Tue,  3 Dec 2024 11:38:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733225889;
	bh=SOpDD/j8v1BW+RzStopfvCSMdaQOSrVLeT5dQ5ZfMis=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=kRq2xUlVOdU0klRsEqazpye3CHkPfgh2LXRrkUWPFB3qkELHGfIs5bVkdvpey1Ghd
	 +s3wf03Bgx2ShWfjygtnPTlLMWbCFz+8d93V2QT6HjyuodUl77fftQqZqkt8O95L7D
	 FTP33H0gy0q9/1bAEvOyeTaVZaeMQJyZh/FjmcsKnW+eU0bRR8Um69qYjGbySKD9bO
	 A/ojSCiWlKTXmXWjW0INs2UcKSaQ8Cl3brhqFJj4mFJ7c0x8olSECuhhoXfRFvE3pf
	 TgRJ75P5xW//l2rh5hXsoJAlep0r00PPruwKIs6g1PE+FfDCMyqv9Sh6+IUQ6ozKJV
	 s6b38R6PoUcOQ==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Celeste Liu <uwu@coelacanthus.name>, Oleg Nesterov <oleg@redhat.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Eric Biederman
 <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>, Shuah Khan
 <shuah@kernel.org>
Cc: Alexandre Ghiti <alex@ghiti.fr>, "Dmitry V. Levin" <ldv@strace.io>,
 Andrea Bolognani <abologna@redhat.com>, Thomas Gleixner
 <tglx@linutronix.de>, Ron Economos <re@w6rz.net>, Charlie Jenkins
 <charlie@rivosinc.com>, Quan Zhou <zhouquan@iscas.ac.cn>, Felix Yan
 <felixonmars@archlinux.org>, Ruizhe Pan <c141028@gmail.com>, Shiqi Zhang
 <shiqi@isrc.iscas.ac.cn>, Guo Ren <guoren@kernel.org>, Yao Zi
 <ziyao@disroot.org>, Han Gao <gaohan@iscas.ac.cn>,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, stable@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Celeste Liu <uwu@coelacanthus.name>
Subject: Re: [PATCH v2 2/2] riscv: selftests: Add a ptrace test to verify
 syscall parameter modification
In-Reply-To: <20241203-riscv-new-regset-v2-2-d37da8c0cba6@coelacanthus.name>
References: <20241203-riscv-new-regset-v2-0-d37da8c0cba6@coelacanthus.name>
 <20241203-riscv-new-regset-v2-2-d37da8c0cba6@coelacanthus.name>
Date: Tue, 03 Dec 2024 12:38:06 +0100
Message-ID: <878qsxdmjl.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Celeste Liu <uwu@coelacanthus.name> writes:

> From: Charlie Jenkins <charlie@rivosinc.com>
>
> This test checks that orig_a0 allows a syscall argument to be modified,
> and that changing a0 does not change the syscall argument.
>
> Cc: stable@vger.kernel.org
> Co-developed-by: Quan Zhou <zhouquan@iscas.ac.cn>
> Signed-off-by: Quan Zhou <zhouquan@iscas.ac.cn>
> Co-developed-by: Celeste Liu <uwu@coelacanthus.name>
> Signed-off-by: Celeste Liu <uwu@coelacanthus.name>
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>

Nice with a selftest! (Don't think the Cc: stable applies... ;-))

Reviewed-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>

