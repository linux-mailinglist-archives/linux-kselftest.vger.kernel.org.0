Return-Path: <linux-kselftest+bounces-25699-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D53DA275EB
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Feb 2025 16:33:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 478C41887203
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Feb 2025 15:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 496ED214200;
	Tue,  4 Feb 2025 15:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LSxR2huE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C78F2C181;
	Tue,  4 Feb 2025 15:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738683183; cv=none; b=UgezgVxaHqrRjaVmdu5g0YmzX0Wp1UGKMWV4jPrXUaxF8fpY8RM4qaRw9nezOQ+633cbIn948M+6QT13PNfVERqNHDdU0XILSVw6YOLuMUo0ZPwbiddzG+IjCKs91KxQS7M23uX66FWq5+xJpMRjHiVAHQtMGTnYvM3/VaJSKyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738683183; c=relaxed/simple;
	bh=i/s0OB7Mhq9Pvk3J95cQX/PKqJmn/MkdkvjD21GLInA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IvHFH0USPTnNaB/kz6r/kIa4470Un2OGlCATNVCMNt0xA+qEnfymNKW7cqmPHxOCteQhoYx6oLSC0UyUYpN1CCDmZ0436U4sOQFoBtnqC6j0VlgTh3uDwFLMdJnJK0aKNPBqdQ939u1h7Fx0u1trO6Jwcp4WHQXAdWxW9PENn2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LSxR2huE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C0B3C4CEDF;
	Tue,  4 Feb 2025 15:33:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738683182;
	bh=i/s0OB7Mhq9Pvk3J95cQX/PKqJmn/MkdkvjD21GLInA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LSxR2huED9E2ctHMruH8oWTPP7EKUkgFeaokj084LHJ1UQE/hpU35RTuKcsr+RDDH
	 pmkOLCt7rm6ZBMURXZF2exeLH2hfoy1Gn9fvydDvh5o97H4iDlKqiHR351c8pnin4X
	 MHgC+oukxPqs9ppuOdt0CSZhx5BLpFV+RqdB1Gp+QHZiZ+GmQq27M3oG633toRwthg
	 H+PL2IXlLRSDkGo+PCC6rS6us3ExSC06tq8Cbdp8JpKdAMM0uqImZCt9FSy/SNM+Wy
	 NlSDPtqZJ3BzVeR1Y/Q1p0ieZQ6WuUNeO+Fn95ayguKo7m/ZCahIFLX1OBRgQepsI2
	 9eruOwcFMwBJQ==
Date: Tue, 4 Feb 2025 07:32:59 -0800
From: Kees Cook <kees@kernel.org>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>
Cc: Eric Biederman <ebiederm@xmission.com>, Shuah Khan <shuah@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Andy Lutomirski <luto@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH 05/16] elf, uapi: Add type ElfXX_Versym
Message-ID: <202502040732.E32F6C2@keescook>
References: <20250203-parse_vdso-nolibc-v1-0-9cb6268d77be@linutronix.de>
 <20250203-parse_vdso-nolibc-v1-5-9cb6268d77be@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250203-parse_vdso-nolibc-v1-5-9cb6268d77be@linutronix.de>

On Mon, Feb 03, 2025 at 10:05:06AM +0100, Thomas Weiﬂschuh wrote:
> The types are used by tools/testing/selftests/vDSO/parse_vdso.c.
> To be able to build the vDSO selftests without a libc dependency,
> add the types to the kernels own UAPI headers.
> 
> As documented by elf(5).
> 
> Signed-off-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>

Reviewed-by: Kees Cook <kees@kernel.org>

-- 
Kees Cook

