Return-Path: <linux-kselftest+bounces-25698-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48AEFA275E9
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Feb 2025 16:33:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29A94162125
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Feb 2025 15:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE19F2135C3;
	Tue,  4 Feb 2025 15:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k7szBf3V"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B9D2C181;
	Tue,  4 Feb 2025 15:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738683172; cv=none; b=llOTJhqkQcV/ZxtJsbOXvxqfOEXWYE2ALvICofB0pCwAbgoHjCkjAlzlE5uL1qzL+vkrt7XNCAJoG+fA16/Z5BcQEj6OpdxMljP4sUdEqPnlND1YbiiVmiV8fQXRvOHSyS1WPmPCY6BuhKFIljBDuP7m9vjDeGiEwqPCQ/oZWmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738683172; c=relaxed/simple;
	bh=t5Icv/egWFWC1O7kdkqXcuCy+zTPnRHYnBNIpbWlwKU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VmT4CdEeJcDIQiDcnIeVFrsIosoRspLRh6qQ/37qjGVDjc/qHqlhnS2QgJOlNJYBLZ/35PSyw5jkm5zoETAYy5ktGIBUS3WzURMDKMmbUFsOmb7cPOfp7jKJisrtv62R/2HJbdu09tGQn+cTGsEcrC5ax8DNpQmM0AvcJ8aE2u4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k7szBf3V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12F22C4CEDF;
	Tue,  4 Feb 2025 15:32:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738683172;
	bh=t5Icv/egWFWC1O7kdkqXcuCy+zTPnRHYnBNIpbWlwKU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k7szBf3VutI8Zn4KWc/GABlxX69lW22g6d8O0pa33kon7yAq+iVf584YyNVKBl1fD
	 aKvKukH3pOThyOn0pWjWKBGmhAv+F7oxGc/D4zBliZ6KKRTCZ8FA0KCZnGRuUNrum7
	 x4X89ohiyoDzrS+9f9lzZqTy278LnbgW3GsRzCWI+cZXobOXg1bqyAYcv6yrk3FJbu
	 RIm6V65RSqx8HRyz/yMVn9Zsws8eAXrbY/l5qE8NuQNXrcgwdKDTKJnXqBl1mSvy9Z
	 /w5y8hPbtRp5M8C5EPbuRyAa6j1AWjni3f6DoSLI6JTJbxdjPOIjPwRB3T4l7mXDVY
	 IMpWFMB2lS8ZQ==
Date: Tue, 4 Feb 2025 07:32:49 -0800
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
Subject: Re: [PATCH 03/16] elf, uapi: Add definition for DT_GNU_HASH
Message-ID: <202502040732.5C39B05@keescook>
References: <20250203-parse_vdso-nolibc-v1-0-9cb6268d77be@linutronix.de>
 <20250203-parse_vdso-nolibc-v1-3-9cb6268d77be@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250203-parse_vdso-nolibc-v1-3-9cb6268d77be@linutronix.de>

On Mon, Feb 03, 2025 at 10:05:04AM +0100, Thomas Weiﬂschuh wrote:
> The definition is used by tools/testing/selftests/vDSO/parse_vdso.c.
> To be able to build the vDSO selftests without a libc dependency,
> add the define to the kernels own UAPI headers.
> 
> Link: https://refspecs.linuxbase.org/LSB_5.0.0/LSB-Core-generic/LSB-Core-generic/libc-ddefs.html
> Signed-off-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>

Reviewed-by: Kees Cook <kees@kernel.org>

-- 
Kees Cook

