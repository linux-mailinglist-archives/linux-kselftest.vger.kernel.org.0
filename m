Return-Path: <linux-kselftest+bounces-32050-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F3D8AA56A8
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Apr 2025 23:22:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EA651C22EDA
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Apr 2025 21:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D88522D1133;
	Wed, 30 Apr 2025 21:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hxNELFf0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA1DF2D1127;
	Wed, 30 Apr 2025 21:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746048083; cv=none; b=oLjTAnR6jQ5MnHsWbRRvliZQjv5qS2DyRkY1Hb46LihACUBfKrHaZkYD0lIhJYES/Rjd0z3GrvuYzRqotD1yIIKa9sC6jUpKV2cRJYwFLyHZ519/5qQ41DjALvXwezyMX6gyeT8ihLCBFwLmj4BM2pnGc1riUqVP1gnfnn6pLD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746048083; c=relaxed/simple;
	bh=fvEvg0QqbaJX89Vajo4QzSvwJVuPTXM4unyyysTAhdc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dqNMlotnqogy2bPc8DoclCNC37ZXaFPqNxJsDjJF2xZye2z0U5l/Ro96l5TPs5l/uf5GVUrzLLVj5JZvXcYXCWjBHA3b3+GB8+8q4qthyKYvGThLNVCdv0p5qvIenW3pEAGUGRngmBsHVEkzEFp6JVBYbjTQaPE3D+RvxaMQChk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hxNELFf0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B3EBC4CEE9;
	Wed, 30 Apr 2025 21:21:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746048083;
	bh=fvEvg0QqbaJX89Vajo4QzSvwJVuPTXM4unyyysTAhdc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hxNELFf03daqzKSn3W3KFbk663mYP5cXn3ducN+JjeQCF5xTgYnNY2oggykfeoCj/
	 /zMrlbZXS8SHP7uvmLAN4Wscr4HttO8yTpIpT8gJdaMLcyqCQIehsRCSfsFSxM5/26
	 uH1nqdjFElWjUmbb2r9wbqABJ2VCg8nNX7c/BdAlaaUt6dejJvOvdWteACp6X4Aqv7
	 nFIZMmBuFnvTlfFXqdveIzqqPUctEkCNGob6PuCRxfr7pUgOicYeK4IgPTqdyA7FCi
	 o0xJG6L0XQw5IaQxneLwBA+tVAzZr3YN/rgLaG9hYgK9mY9yeETi37p1+j4Dax4VJj
	 W3/RA9d5LNiog==
From: Kees Cook <kees@kernel.org>
To: Neill Kapron <nkapron@google.com>
Cc: Kees Cook <kees@kernel.org>,
	Andy Lutomirski <luto@amacapital.net>,
	Will Drewry <wad@chromium.org>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH RESEND] selftests/seccomp: fix syscall_restart test for arm compat
Date: Wed, 30 Apr 2025 14:21:18 -0700
Message-Id: <174604807591.2105045.17581520822514602555.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250427094103.3488304-2-nkapron@google.com>
References: <20250427094103.3488304-2-nkapron@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Sun, 27 Apr 2025 09:40:58 +0000, Neill Kapron wrote:
> The inconsistencies in the systcall ABI between arm and arm-compat can
> can cause a failure in the syscall_restart test due to the logic
> attempting to work around the differences. The 'machine' field for an
> ARM64 device running in compat mode can report 'armv8l' or 'armv8b'
> which matches with the string 'arm' when only examining the first three
> characters of the string.
> 
> [...]

Applied to for-next/seccomp, thanks!

[1/1] selftests/seccomp: fix syscall_restart test for arm compat
      https://git.kernel.org/kees/c/797002deed03

Take care,

-- 
Kees Cook


