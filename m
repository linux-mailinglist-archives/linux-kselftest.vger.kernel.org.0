Return-Path: <linux-kselftest+bounces-29332-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B030A66817
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Mar 2025 05:11:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3094A7A6CBE
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Mar 2025 04:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 178F118EFD1;
	Tue, 18 Mar 2025 04:11:04 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F19864A07;
	Tue, 18 Mar 2025 04:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=163.172.96.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742271064; cv=none; b=QVOlJT/n3wtmE33vIFe6TM/DafJvav0IXQS7a0LeGNlGu1ry3EoUCtnzqvK/D76+IgIt9r6uRFCvUgW38sm6dxnu/2HJpAcMYFJpxqRzq21dKOXkcf9O8Hk4XApIyPikdjcUwIAd4TUqcyaLe1HMoj6E+bQd/WTBk7uuI9NJe2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742271064; c=relaxed/simple;
	bh=6KRbAsPOhlMIgfs+E2bEO69NL+WDT2EK46o7XLtLGrE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=howVGJhbFMpGB26ExZr3tdzIsmTehn0KPTGj6iwznIPLzm9uqEi09S8TpFR9n6KChaquOE0ISZZ1bp3qrlgxQoI64xl2vUTTW+iNSXBFZ+0S+mSa7s/8+hA1dNqV3Yuli3mk6MsOGcbkeX5z2BAAvWL/2qJAKv7g4DreeN0pDE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; arc=none smtp.client-ip=163.172.96.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
Received: (from willy@localhost)
	by pcw.home.local (8.15.2/8.15.2/Submit) id 52I4AmfF011310;
	Tue, 18 Mar 2025 05:10:48 +0100
Date: Tue, 18 Mar 2025 05:10:48 +0100
From: Willy Tarreau <w@1wt.eu>
To: Chris Torek <chris.torek@gmail.com>
Cc: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
        Shuah Khan <shuah@kernel.org>, "David S. Miller" <davem@davemloft.net>,
        Andreas Larsson <andreas@gaisler.com>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, sparclinux@vger.kernel.org
Subject: Re: [PATCH] tools/nolibc: Add support for SPARC
Message-ID: <20250318041048.GA11294@1wt.eu>
References: <20250316-nolibc-sparc-v1-1-2e97022d5e2c@weissschuh.net>
 <20250317073746.GB5114@1wt.eu>
 <dacaa712-08a8-4fd6-ad47-2226040f02aa@t-8ch.de>
 <20250317181402.GB8377@1wt.eu>
 <CAPx1Gvd5JHE6c_de+ZGY4BLPw25Rn1jTd-G9XMhK9xn+cAfbJA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPx1Gvd5JHE6c_de+ZGY4BLPw25Rn1jTd-G9XMhK9xn+cAfbJA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Mon, Mar 17, 2025 at 06:57:01PM -0700, Chris Torek wrote:
> On Mon, Mar 17, 2025 at 11:38 AM Willy Tarreau <w@1wt.eu> wrote:
> > OK thanks, but that remains quite strange to me. How can we end up
> > here with such an unaligned stack ? At the very minimum I'd expect
> > all offsets to be multiple of 8.
> 
> It's a peculiar feature of the version 9 SPARC architecture and runtime.
> This also ties into your window save area question.  Let's start with these:
> 
>  * There are 16 save-able registers in a window.
>  * Before V9, registers were 32 bits wide.
>  * V9 and later, registers are 64 bits wide.
>  * Each stack frame must provide an area for register data.
> 
> Now 32 bits = 4 bytes, times 16 regs = 64 bytes. So for V8 and lower, the
> register save area is  [%sp+0] through [%sp+63] inclusive.
> 
> Now V9 comes along and we need 128 bytes. But we're going to
> run old V8 code in compatibility mode! How will we tell that some
> function f() is running in V8 mode instead of V9 mode? [footnote]
> 
> Someone decided that the way to tell would be to use a deliberate
> weird alignment of the stack pointer. If the stack pointer was 7 mod 8,
> then we're in 64 bit V9 mode and [%sp+2047+0] through
> [%sp+2047+127] inclusive are the register save area. If not, it
> must be 0 mod 8 and we're in V8 mode and things are as before.
> 
> Why 2047? Well, by observation, it's more common to need negative
> offsets from the stack pointer (for a large stack-area array for instance)
> than it is to need positive ones (register window save area and
> overflow function argument area beyond that). But the instruction
> set is more or less symmetric, with a 13-bit immediate constant
> offset of -4096 to +4095.  Solution: add some offset to the stack
> pointer so that function-stack memory is [%sp-4096] through [%sp+2046],
> a 6 kilobyte range instead of a 4k one.
> 
> The stack offset therefore helps solve both problems: the offset
> indicates whether to use V8 or V9 register dump conventions
> and, at the same time, increases the amount of easily-accessed
> stack memory.
> 
> [footnote] This provides the ability to dynamically link V8 and V9
> code together.  As far as I know this was never used, so that a per
> process mode bit suffices just as well. Still, the offset went in.

Super clear, thank you Chris! I think a short comment saying
"2047: 7 mod 8 = v9 mode" or so would then help and remind that
it's not a mistake.

Cheers,
Willy

