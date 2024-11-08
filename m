Return-Path: <linux-kselftest+bounces-21670-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A8109C1BDA
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Nov 2024 12:07:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4147AB247A5
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Nov 2024 11:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D08A71E230C;
	Fri,  8 Nov 2024 11:07:49 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B83CC47F69
	for <linux-kselftest@vger.kernel.org>; Fri,  8 Nov 2024 11:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731064069; cv=none; b=iLvqUiY8rTxtMWaYN5xlucvrVIXIpz6oiiU4GS7UClo3Lb8ojQH7Obn/vf/VMilwYSe+i9S0NijPuoecdMjlfeLb+uwtF6gLe4goY3Ah4H+zdLq1o7eNWHWW8eWOOewE8K3X1ija65LRKR1PXsIRHnotkvp34V/LcanMK4SGw6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731064069; c=relaxed/simple;
	bh=2K9IYMzsxGZmR/82YvpyPJwI9qABG0YgnMFxcmKAh0c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r3ogx7wu23TD0DELyBJPXNEouxp30Uy65Uoo3jwKG0hSlN2NU3GxPWBW2Dz2HUohqt3zS8eoUVDi7r56A+QG5kx8vQfYhiBx6ybG3f8Erp1fsR+hwUeYdZWXzeY4EiuzQXkygLoa1MIet54/z7ZJHlWdXaL90A231q7G4gtOwhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCE4AC4CECD;
	Fri,  8 Nov 2024 11:07:47 +0000 (UTC)
From: Catalin Marinas <catalin.marinas@arm.com>
To: linux-arm-kernel@lists.infradead.org,
	Kevin Brodsky <kevin.brodsky@arm.com>
Cc: Will Deacon <will@kernel.org>,
	dave.hansen@linux.intel.com,
	yury.khrustalev@arm.com,
	linux-kselftest@vger.kernel.org,
	Aishwarya TCV <aishwarya.tcv@arm.com>
Subject: Re: [PATCH] selftests/mm: Define PKEY_UNRESTRICTED for pkey_sighandler_tests
Date: Fri,  8 Nov 2024 11:07:45 +0000
Message-Id: <173106404267.1187252.14105809855861854022.b4-ty@arm.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241107131640.650703-1-kevin.brodsky@arm.com>
References: <20241107131640.650703-1-kevin.brodsky@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 07 Nov 2024 13:16:40 +0000, Kevin Brodsky wrote:
> Commit 6e182dc9f268 ("selftests/mm: Use generic pkey register
> manipulation") makes use of PKEY_UNRESTRICTED in
> pkey_sighandler_tests. The macro has been proposed for addition to
> uapi headers [1], but the patch hasn't landed yet.
> 
> Define PKEY_UNRESTRICTED in pkey-helpers.h for the time being to fix
> the build.
> 
> [...]

Applied to arm64 (for-next/pkey-signal), thanks!

I also added a FIXME comment to remove this macro once the generic
definition lands upstream.

[1/1] selftests/mm: Define PKEY_UNRESTRICTED for pkey_sighandler_tests
      https://git.kernel.org/arm64/c/db64dfffcad2

-- 
Catalin


