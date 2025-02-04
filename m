Return-Path: <linux-kselftest+bounces-25696-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15125A275E4
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Feb 2025 16:32:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7A361887136
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Feb 2025 15:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D65DA211A27;
	Tue,  4 Feb 2025 15:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k3GatPAW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A999F2C181;
	Tue,  4 Feb 2025 15:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738683137; cv=none; b=RoYt7GIewpnyBMzWokzui1teqaec9CtFoNmJGSkcNjAiJTQBugFNmSY/Rs5gGGu5kp57cRucaNYq2Z8Jot9pq20POkEil1vY2LAKeqzldkr8OQH6Amnw8vtDd/OoEydxCGWwdDWfFpjwSCoqXt3BEp018rqTZfp0Tbao0lvc5hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738683137; c=relaxed/simple;
	bh=lB6OvlDcA1DjkCRpW2o82kIiiXZLmOPFTXUyGT8+KkQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W5vxefGQbSfVgk1haRpC3UkaLduuApU+sZR950tISofSOyqNx1Gkz7KiBrd3Mz42v7jpyKI+GLfP073JcRzccSACY+vz26Khsb4wB7uJvYtxKkGDLen1iJTryFpREvZ6w+NDXurj79QvdgDQ9vQfopmv5xPX+aK10XUXshJNHEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k3GatPAW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14A08C4CEDF;
	Tue,  4 Feb 2025 15:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738683137;
	bh=lB6OvlDcA1DjkCRpW2o82kIiiXZLmOPFTXUyGT8+KkQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k3GatPAW8DAmRoCF/yYbTBkS//29CtNtQiMM1q+sH7579KGGy+H+hBJJ1itEHnMmd
	 qmAeMO4OJOPXW1tBObo2hytfnpECAAzu/ozSsw+oagpWk8wwWdu1TvXa+B9/6L9GUp
	 2ARcrWMDPjIepldiYc5yJ5Ndm2U1tSZUo8ws917v/YeKBuqy9E5/OFpImcYi0DOIw1
	 MFi9txFw5IMkdIqujPEi+hlNlpQYzXJKKc8s3Dp2tI6q4/uRN68qivxnP2FJ3m8nIJ
	 ESNJWFBq36iV82J95BumlhNjZ9gntiK/UhvtTLFi52RIR0iKh4XNM0LcLHEmjDzp5R
	 u6RxuCh6Hw2Zg==
Date: Tue, 4 Feb 2025 07:32:14 -0800
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
Message-ID: <202502040731.4EE9CCBB@keescook>
References: <20250203-parse_vdso-nolibc-v1-0-9cb6268d77be@linutronix.de>
 <20250203-parse_vdso-nolibc-v1-4-9cb6268d77be@linutronix.de>
 <202502040708.6E9CF77@keescook>
 <20250204161210-b788ff6b-9c77-4a9c-8ab8-8b727b0b2003@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250204161210-b788ff6b-9c77-4a9c-8ab8-8b727b0b2003@linutronix.de>

On Tue, Feb 04, 2025 at 04:17:03PM +0100, Thomas Weißschuh wrote:
> On Tue, Feb 04, 2025 at 07:10:00AM -0800, Kees Cook wrote:
> > On Mon, Feb 03, 2025 at 10:05:05AM +0100, Thomas Weißschuh wrote:
> > > The definitions are used by tools/testing/selftests/vDSO/parse_vdso.c.
> > > To be able to build the vDSO selftests without a libc dependency,
> > > add the definitions to the kernels own UAPI headers.
> > 
> > For all the UAPI changes, where are the defines "normally" found? i.e.
> > how does adding these to UAPI not break something that already has them?
> > Or have these never been defined before? I'm confused about how removing
> > the libc dependency exposes the lack of these defines. Are they defined
> > in a non-exported libc header somewhere?
> 
> They are normally defined directly in libc <elf.h>, which does not use
> UAPI headers. Libc elf.h and Linux UAPI elf.h can not be used at the
> same time because they define the same symbols.
> In theory some user of UAPI elf.h could have defined these new symbols
> on their own without ifdef guards. However UAPI elf.h is regularly
> updated with new symbols.

Okay, great. As long as the collision risk is low, I'm fine with all the
UAPI additions. Thanks for doing this!

-- 
Kees Cook

