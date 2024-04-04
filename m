Return-Path: <linux-kselftest+bounces-7161-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4DF2898114
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Apr 2024 07:47:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6E35289B69
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Apr 2024 05:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EDB63DBBC;
	Thu,  4 Apr 2024 05:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="geWjl5tS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC173FC2;
	Thu,  4 Apr 2024 05:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712209618; cv=none; b=kywkMWYM7F+ywQEBfvaLNwxlpq18PGVia1x4L9b/MKmB972G8r6YhFE/dxR+2BUK/XYE00ERNrEUd5mXxSFNwGflWH065Bn/pMQYVg37gm8AqGSGbDLxBfu7Zem+pwm24vW4qvxc2EZLF1anhkmG4enbGI8TYCWzwIS7X7MaGJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712209618; c=relaxed/simple;
	bh=K/tqV2VTM/YXZvK5fR129QweW8rDAKq13mxK08CxCVI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=awgflM37TEw5LKSMKICXObpl6eI30g5kB+Veoc2RKS0xz5gG+8z55Y1/Pi9Kh0GvZSL+ri0eBi143Ip7Vdaif8lQMEHxnZG4CUIOQPZJrdjPzgTx2oNKE7EPfaOTo9jHmDjOeuNEzMUn+03DglyxJU3JJcvcMI2i36eGPE9dGCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=geWjl5tS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84050C433F1;
	Thu,  4 Apr 2024 05:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712209618;
	bh=K/tqV2VTM/YXZvK5fR129QweW8rDAKq13mxK08CxCVI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=geWjl5tSMnz9aUJQK+7TpVLQiUSN7iC1cxdw0ZaQC9YA3j/G03sy9qjvINPEmn75T
	 wZPApLMjyiOKCSTpDoPw0JMU79iA9mdS8OYzmR9zniOvtb+VBHHtBXGXBXYqZghJTM
	 55xRhLRMfL3tL6cKIgifP/snSoEGo1e58qs4lrmJk9u3FHNujiwVPjS05LRTzOp96Q
	 LPnRWufVEza0Nvje73D5LnffVx3DpO8cPSjc6sFsYfgCFq0niTiv4Fltsjn+9loiLk
	 0BH5HEUOE4pdzTuF9CtR8UKaW29YnnU/fOvjatcmJzyxnFEvHyoaGLO0gUU/qoG2Qh
	 k8IB5X2MZM8iQ==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Charlie Jenkins <charlie@rivosinc.com>, Shuah Khan <shuah@kernel.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Andy Chiu
 <andy.chiu@sifive.com>, Vineet Gupta <vineetg@rivosinc.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-riscv@lists.infradead.org, Charlie Jenkins <charlie@rivosinc.com>
Subject: Re: [PATCH] riscv: selftests: Add signal handling vector tests
In-Reply-To: <20240403-vector_sigreturn_tests-v1-1-2e68b7a3b8d7@rivosinc.com>
References: <20240403-vector_sigreturn_tests-v1-1-2e68b7a3b8d7@rivosinc.com>
Date: Thu, 04 Apr 2024 07:46:54 +0200
Message-ID: <87bk6pof1t.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Charlie Jenkins <charlie@rivosinc.com> writes:

> Add two tests to check vector save/restore when a signal is received
> during a vector routine. One test ensures that a value is not clobbered
> during signal handling. The other verifies that vector registers
> modified in the signal handler are properly reflected when the signal
> handling is complete.
>
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>

Nice!

Reviewed-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>

