Return-Path: <linux-kselftest+bounces-21208-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D984E9B7B3A
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Oct 2024 14:00:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D74F283184
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Oct 2024 13:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB1B819CD1D;
	Thu, 31 Oct 2024 13:00:15 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9660A19D890
	for <linux-kselftest@vger.kernel.org>; Thu, 31 Oct 2024 13:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730379615; cv=none; b=bby3VyxrEtzdbJM8gYaj2goZto3Wes4vFc36+jWy0zV5c/F3kc35miqby+wYFNpky8YKFPHOP0AEMthgu+KDINvAxugyMms2uOeqeL10nKWRnxzWPI1KAqFV9csKvURWqMnwjdUTBiA710KTXpZWgmxbH15rjgyrJ8AFdHU2Yi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730379615; c=relaxed/simple;
	bh=2xr31Zy1IrkBa+8XfjcFkPW9UQ4uakQD2/Cx+3CMTug=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PCyFqYQ1hnuFc/oazYrnRCLLlOWMchg2ZSPCQNXP92YZGVul5SNLFJ9ZZCVZltAqC28QMi/zPpbj4C2sFlEZ0KjWrE9Bik6b92drefa0PYTaJ+eRZC8dm+B9Bk53YhjHDdZu4V2LJxugEHe4i1qchC0NDrgPtjTz086Kg9PipjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 771CA1063;
	Thu, 31 Oct 2024 06:00:41 -0700 (PDT)
Received: from [10.44.160.105] (e126510-lin.lund.arm.com [10.44.160.105])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 98ACC3F528;
	Thu, 31 Oct 2024 06:00:06 -0700 (PDT)
Message-ID: <8dcc7e49-ec95-4d7d-8ded-d4f7202d623d@arm.com>
Date: Thu, 31 Oct 2024 14:00:04 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/5] Improve arm64 pkeys handling in signal delivery
To: Jeff Xu <jeffxu@chromium.org>
Cc: linux-arm-kernel@lists.infradead.org, akpm@linux-foundation.org,
 anshuman.khandual@arm.com, aruna.ramakrishna@oracle.com, broonie@kernel.org,
 catalin.marinas@arm.com, dave.hansen@linux.intel.com, Dave.Martin@arm.com,
 joey.gouly@arm.com, keith.lucas@oracle.com, pierre.langlois@arm.com,
 shuah@kernel.org, sroettger@google.com, tglx@linutronix.de, will@kernel.org,
 yury.khrustalev@arm.com, linux-kselftest@vger.kernel.org, x86@kernel.org,
 Kees Cook <keescook@chromium.org>,
 Jorge Lucangeli Obes <jorgelo@chromium.org>, Jann Horn <jannh@google.com>
References: <20241029144539.111155-1-kevin.brodsky@arm.com>
 <CABi2SkW4Utuo3qGKodTQn7VuFrRa4hpwrik7WaorS4=wm_cS2g@mail.gmail.com>
Content-Language: en-GB
From: Kevin Brodsky <kevin.brodsky@arm.com>
In-Reply-To: <CABi2SkW4Utuo3qGKodTQn7VuFrRa4hpwrik7WaorS4=wm_cS2g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 30/10/2024 22:59, Jeff Xu wrote:
> Apologize in advance that I'm unfamiliar with ARM's POR, up to review
> this patch series, so I might ask silly questions or based on wrong
> understanding.

That's no problem, your input is very welcome! There is no fundamental
difference between POR and PKRU AFAIK - the encoding is different, but
the principle is the same. The main thing to keep in mind is that POE
(the arm64 extension) allows restricting execution in addition to
read/write.

> It seems that the patch has the same logic as Aruna Ramakrishna
> proposed for X86, is this correct ?

Yes, patch 1 aims at aligning arm64 with x86 (same behaviour). Going
forward I think we should try and keep the arm64 and x86 handling of
pkeys as consistent as possible.

> In the latest version of x86 change [1], I have a comment if we want
> to consider adding a new flag SS_PKEYALTSTACK (see SS_AUTODISARM as an
> example) in sigaltstack, and restrict this mechanism (overwriting
> PKRU/POR_EL0 and sigframe)  to sigaltstack() with SS_PKEYALTSTACK.
> There is a subtle difference if we do that, i.e. the existing
> signaling handling user might not care or do not use PKEY/POE, and
> overwriting PKRU/POR_EL0 and  sigframe every time will add extra CPU
> time on the signaling delivery, which could be real-time sensitive.

From a purely functional perspective, resetting POR to allow access to
all pkeys before writing the signal frame should be safe in any context,
and allows keeping the handling simple (no conditional code). The
performance aspect is a fair point though, as we are adding an ISB
(synchronisation barrier) on the signal delivery path if POE is supported.

> Since I raised this comment on X86, I think raising it for ARM for
> discussion would be ok,
> it might make sense to have consistent API experience for arm/x86 here.

And indeed this is what I think is most important at this point.
Considering that Aruna's series resets PKRU unconditionally (sigaltstack
or not) and has already been pulled into mainline during 6.12-rc1 [2], I
still believe that patch 1 is doing the right thing, i.e. aligning arm64
with x86. If the concern with performance is confirmed, and there is an
agreement to reset POR/PKRU less eagerly on both architectures, this
could potentially be revisited.

- Kevin

[2]
https://lore.kernel.org/lkml/172656199227.2471820.13578261908219597067.tglx@xen13/

> [1] https://lore.kernel.org/lkml/CABi2SkWjF2Sicrr71=a6H8XJyf9q9L_Nd5FPp0CJ2mvB46Rrrg@mail.gmail.com/


