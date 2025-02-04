Return-Path: <linux-kselftest+bounces-25701-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B0789A275FA
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Feb 2025 16:34:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02ED7167BA6
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Feb 2025 15:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D129C2144BB;
	Tue,  4 Feb 2025 15:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GodJeCdC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0CC8214236;
	Tue,  4 Feb 2025 15:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738683220; cv=none; b=LwDK2AhpgqBmZlrOBJ5exjOMTLtxKdrG6G6A5HxFhdTqZ6X+9EnIrnL0gq5rayTFQTAy6jMLoHR/GwHr2ViLzAkXt0t/KIOYBWcQ0PxQJ2tyjLyreQQSfPJdlliGX6pFQCUQI0N2s32h+/uRCaMHRoFHDyvEGkf9uBmn8M2NjFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738683220; c=relaxed/simple;
	bh=A+Jz1v1lLieaNo0+qtah3EPygR7Gez8j9e4aVKCvo14=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rjpNtCPUzIcuv5Q8KXv8nCdpXypCJxWaBA4rWgedHfASN4z/d65HcjcnkqgWT1gxB98kbExN2rCvVYQWkX0qAFX8bJGiiFbHKSHUQD87lteb66TaNZ+q1C7F7aKfjim70PmLnOYr1prBwM+r1GUYYTwbpRBRsVoOG3VC4KtpVt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GodJeCdC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B1F0C4CEDF;
	Tue,  4 Feb 2025 15:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738683220;
	bh=A+Jz1v1lLieaNo0+qtah3EPygR7Gez8j9e4aVKCvo14=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GodJeCdCtYI2xVdlbpMjq2zewZD6M3EjClgeUMRiyQvkyakgB0aJsrvkPWkcLklJ4
	 pz68hVh0YCuVXZif3Nzc9sjKIIfLTshNFSFSEzqRoajJwWCZ6RvVaWJro0yDqRQp+9
	 190IKmtx0j4jN1uJJ0zI3kBm8Y2DfuyYJXsDuhot5NcGjNG9MNrgM8A0Gztn3RMkmV
	 XTvnn4C62uv0Ab90nywqgtZmhFvaea7ixCbV+oEPsUPfaE/+VWr2fEjcMjjHWY1CVA
	 AhzsQe2x2HnHXv2ivh90MwBtLfRPon+C4mZO77L3fNyRi0YIUhnIyUn3hprf5zvwXd
	 3wtOMg30cXNaQ==
Date: Tue, 4 Feb 2025 07:33:37 -0800
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
Subject: Re: [PATCH 04/16] elf, uapi: Add definitions for VER_FLG_BASE and
 VER_FLG_WEAK
Message-ID: <202502040733.D7044581@keescook>
References: <20250203-parse_vdso-nolibc-v1-0-9cb6268d77be@linutronix.de>
 <20250203-parse_vdso-nolibc-v1-4-9cb6268d77be@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250203-parse_vdso-nolibc-v1-4-9cb6268d77be@linutronix.de>

On Mon, Feb 03, 2025 at 10:05:05AM +0100, Thomas Weiﬂschuh wrote:
> The definitions are used by tools/testing/selftests/vDSO/parse_vdso.c.
> To be able to build the vDSO selftests without a libc dependency,
> add the definitions to the kernels own UAPI headers.
> 
> Link: https://docs.oracle.com/cd/E19683-01/816-1386/chapter6-80869/index.html
> Signed-off-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>

Reviewed-by: Kees Cook <kees@kernel.org>

-- 
Kees Cook

