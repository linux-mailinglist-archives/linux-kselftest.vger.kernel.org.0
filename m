Return-Path: <linux-kselftest+bounces-32777-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24D78AB1D35
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 May 2025 21:16:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96ABF501872
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 May 2025 19:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E95F25CC40;
	Fri,  9 May 2025 19:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lh+k1ppi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43DD5212B28;
	Fri,  9 May 2025 19:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746818190; cv=none; b=iX9bmCG4o0wS1ZDlzRSUAnONhViNS1ikOMsmBiFKiL3xeEOSjLwVHAufzikllMxVli2oindko5/WwGMucZkjZH6ls8IvQ5Nih12M8pfRwYk5iRHFvXnU3gARrKxib8VAEtQ9wF2pP3vgQiuBl4VJk8yfNnP3eWf0zThp/jep+o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746818190; c=relaxed/simple;
	bh=4stlKX/83Q4EY8i5ZFMh+ViL8xviByY1kZE3MhlaMI8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Pyt+u0+ta+Q6p2sgVQ7/w31zWVBwKnt4gvrz4GKVd2r10kojuKAs1JcDOkgXmgMWBnbQ/TkwUH8BA2hl+Q9GJc5UQEwqds/COvPKzH1m0VD053yTclg1QE7+gPWaAPTXwnvPq0bH7dZ2LsSRcLJNryU4old/r1Epe0d4vCtoMEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lh+k1ppi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF3D1C4CEE4;
	Fri,  9 May 2025 19:16:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746818189;
	bh=4stlKX/83Q4EY8i5ZFMh+ViL8xviByY1kZE3MhlaMI8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Lh+k1ppii6AbpYp7LHhwBuucJagTEuB9iaG/kMbgnapUX9loCYK7XNCXJ++MYJJbJ
	 8NklUMXOOuF7KgpXCib7m9yHFbvrExIStwq5SZI3oivBB3BTuKkkO0vsGKN32Zfn4q
	 GoQKAGJhNH0S3ZMVtuI7TGrfT4vR7r+VaALMkSofjzfzpxqq/eJOlW7rsuD8GD3FDX
	 RT8LNKkolKB4eRG4IKUxQdsMV3eCKtT+3P7Sst8ijTZvlzqMk7QmIYzLXkMycrxbdn
	 Npoz3+afQJJMiR90XeULqGjeIDrmgowfOTtoc4nxiGBe/89P+rptYVUDAh9XWpQ5s7
	 dXoGeepoy4i5g==
From: Kees Cook <kees@kernel.org>
To: Andy Lutomirski <luto@amacapital.net>,
	Will Drewry <wad@chromium.org>,
	Shuah Khan <shuah@kernel.org>,
	Terry Tritton <terry.tritton@linaro.org>
Cc: Kees Cook <kees@kernel.org>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/seccomp: fix negative_ENOSYS tracer tests on arm32
Date: Fri,  9 May 2025 12:16:18 -0700
Message-Id: <174681817502.2378444.17294454871668140127.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250509115622.64775-1-terry.tritton@linaro.org>
References: <20250509115622.64775-1-terry.tritton@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 09 May 2025 12:56:22 +0100, Terry Tritton wrote:
> TRACE_syscall.ptrace.negative_ENOSYS and TRACE_syscall.seccomp.negative_ENOSYS
> on arm32 are being reported as failures instead of skipping.
> 
> The teardown_trace_fixture function sets the test to KSFT_FAIL in case of a
> non 0 return value from the tracer process.
> Due to _metadata now being shared between the forked processes the tracer is
> returning the KSFT_SKIP value set by the tracee which is non 0.
> 
> [...]

Ooh yes, nice catch!

Applied to for-next/seccomp, thanks!

[1/1] selftests/seccomp: fix negative_ENOSYS tracer tests on arm32
      https://git.kernel.org/kees/c/73989c998814

Take care,

-- 
Kees Cook


