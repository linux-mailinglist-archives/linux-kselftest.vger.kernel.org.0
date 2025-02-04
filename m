Return-Path: <linux-kselftest+bounces-25692-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DFBDA27572
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Feb 2025 16:10:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD7F41882179
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Feb 2025 15:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E5FA2147F6;
	Tue,  4 Feb 2025 15:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NC6BYK/E"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 003F021420C;
	Tue,  4 Feb 2025 15:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738681805; cv=none; b=odwznNytPPbWFBeh8P2U6L2Bi+9vqqNlHLavIZqhlQYM/zBTs1M5CeOMMG6OqUHG5NczbvcDdes+rSS2QqoaQQz5eLx74oupbzTIh0e3bvlbLLrHqUBkidd3eIUjMQ+voNLUXJLqZhHk18S/9ic37gh6vzyiLoa7k9PgFpqkio8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738681805; c=relaxed/simple;
	bh=dPaqMGXFHxbZRcSJcvyzJDAjbUeY9Sm4roznV4wyZ+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oTVDCXwuXgNZMZxeNy19R1oK4YQE92zkum3k1qztNo8pBtfj2MnHSZHG4BF1oty/+XhLapIxuLqtAcIkOMoaO+kAxibXVKf3i5HVM3I2YBetVxgWbdm77uasKDfCDQAcq93YKquvHwl9cFJHivt4Ql80OCdZcGPwqDLM0xWGJ3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NC6BYK/E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60248C4CEE2;
	Tue,  4 Feb 2025 15:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738681804;
	bh=dPaqMGXFHxbZRcSJcvyzJDAjbUeY9Sm4roznV4wyZ+M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NC6BYK/EmxHfrJcPawdfG9EeeQ/0DI8DH3NOiBKQnQzSATta2MTPkEDPo7zn7jOH3
	 J34+1auOSlBME+9PW7jTosAbebvdGsE35DCboWbGNygwILlKCMoryWnfODcSP0nkik
	 olVQROu/DXw6gVjoM7Xiet1z2oSQABbuefoOVRAee1b6K2ckSstEkl9UyrVc8e2L3n
	 IaNIE53DsW7fzF3Xcel/uxeCJsHl33/ygT4Xg/8s+rMV3VzA5Nng65fj+aAPKYdqff
	 Zzzwsf8SkObk02d2KL0EQjiUU3pBVt+BNwUyqgsW6AUQllhYNRDNQGB68+Lg/gsmED
	 l1JQzKzQJl+gQ==
Date: Tue, 4 Feb 2025 07:10:00 -0800
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
Message-ID: <202502040708.6E9CF77@keescook>
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

On Mon, Feb 03, 2025 at 10:05:05AM +0100, Thomas Weißschuh wrote:
> The definitions are used by tools/testing/selftests/vDSO/parse_vdso.c.
> To be able to build the vDSO selftests without a libc dependency,
> add the definitions to the kernels own UAPI headers.

For all the UAPI changes, where are the defines "normally" found? i.e.
how does adding these to UAPI not break something that already has them?
Or have these never been defined before? I'm confused about how removing
the libc dependency exposes the lack of these defines. Are they defined
in a non-exported libc header somewhere?

-Kees

-- 
Kees Cook

