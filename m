Return-Path: <linux-kselftest+bounces-16769-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4824965A1E
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Aug 2024 10:22:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6BF31C224AD
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Aug 2024 08:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD1B916C685;
	Fri, 30 Aug 2024 08:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Y3a1Cjzw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 006BB16726E;
	Fri, 30 Aug 2024 08:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725006128; cv=none; b=jWoelqLs6aCbcZffnOyjrZa3lQtB9LHDPC3wZUNBf8xfk0nU29yZGkmLR+557AZvUFTiH8ed6Ur5DsWnfKkyM+f46yIq6fxqXiB/IhqfJezu4tgNLuT/EKmWU9PxZxErgHwIW5SnWLuF5aHDmBbT6Lw5LjKKORa1/LERS1V405E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725006128; c=relaxed/simple;
	bh=PIcUkiafZtYG8sEz4v2SqQ0v9H86fyRvpH/0E+z0rJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FCGs9oaAQutf0QxVWBGW8bFgM3WWSAVSB98fTBmixCzET6JSkn6OzN0Pv5Yqx0u4iSkLf55duai1fLA/FCmWhfV2CdLhvwGsBTDT0+YZRXV9/lR6i+eeQEWNwkDMEU59/p4i6sSCY0RpVf3YBEqShxo7mTFsBI/BaYHvrxIPdnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Y3a1Cjzw; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 6712540E0263;
	Fri, 30 Aug 2024 08:21:56 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id xMd7LO7waiqj; Fri, 30 Aug 2024 08:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1725006112; bh=EQylNExq6U1TeXqH5JUwqnWjVDhFHG4+fwK3JYt2zQo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y3a1CjzwrFw+9r4Be8p+BTmNvehFsMEpsg83mYtZ7dJUCC8W0arlziTYPfTctOmQb
	 Pvh0GXtBhU7l4c0LU7i2ReFaEJ6hMozYNELSjTPORX/Zio/q52nIaxYbtAhCVnVZCZ
	 XD5TPUdRiV2/rdG0oEMbjES7i4LnRnU3nBJXVtI0PDecZnC7raQxJgNY2oBPP4/f86
	 v86mxwIpcfniQesE1RkLUOiU3pHXedPLXF5jMQYv/aEli3K7t7CNa13xCedrpjL/UM
	 lrVINq2nwfVj5Qrn9vJERhnyZDUPvHSv7V5VoblslRV/COL7Q18rvXFv3PGGLBoZsG
	 XmoScxQbAVRrVH85xhkwK3wj+oAjRi5b29mGHSRs0IBE9GgQYvM1Y1CcEU150ABEQ2
	 in+YjLo4R336ZirR5PYg3AdVZK5AYZPmQiJDexzXaLcUa2A+Hw1l83IspD2apgUiNo
	 SNNxb5zU+6TEOKKtdeD4bawnu9LpJ4KPB2SGb/kPl5/zlJ6GC5DN7sVhSxZ1urmzmH
	 Hfxdd/db1wGv+VzueP2TxCDwliG3iF13iAWBEIxuZPxLhPT1+lGn8hBKPRSX1Y3fQL
	 tcvVXHL9EDYXojhean9b5Fr9ZSlJgYUAT2X7Tj0sLYLEqidiFraonG2MALaeed7h7X
	 K9AqdTUfq3a+W7GC5cRf5+nM=
Received: from zn.tnic (p5de8e8eb.dip0.t-ipconnect.de [93.232.232.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6032340E0275;
	Fri, 30 Aug 2024 08:21:42 +0000 (UTC)
Date: Fri, 30 Aug 2024 10:21:36 +0200
From: Borislav Petkov <bp@alien8.de>
To: Sean Christopherson <seanjc@google.com>
Cc: Manali Shukla <manali.shukla@amd.com>, kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org, pbonzini@redhat.com,
	shuah@kernel.org, nikunj@amd.com, thomas.lendacky@amd.com,
	vkuznets@redhat.com, babu.moger@amd.com
Subject: Re: [RFC PATCH v1 1/4] x86/cpufeatures: Add CPUID feature bit for
 the Bus Lock Threshold
Message-ID: <20240830082136.GAZtGBEMyF-MbWXrPo@fat_crate.local>
References: <20240709175145.9986-1-manali.shukla@amd.com>
 <20240709175145.9986-2-manali.shukla@amd.com>
 <Zr-qkJirOC_GM9o6@google.com>
 <20240829064811.GAZtAZqzWkmF79VOs7@fat_crate.local>
 <ZtFNwOG5oPwNF2bU@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZtFNwOG5oPwNF2bU@google.com>

On Thu, Aug 29, 2024 at 09:42:40PM -0700, Sean Christopherson wrote:
> Ah, sorry, if the platform+kernel supports the feature, not just raw CPU.

Yeah, that's not always trivial, as I'm sure you know. Especially if it is
a complicated feature like, SNP, for example, which needs fw and platform to
be configured properly and so on.

> And because that utility is not available by default on most targets I care
> about, and having to build and copy over a binary is annoying (though this
> is a minor gripe).

I'm keeping that thing as simple as possible on purpose. So if you wanna make
it available on such targets, I'm all ears.
 
> That said, what I really want in most cases is to know if _KVM_ supports
> a feature.  I'll think more on this, I have a few vague ideas for getting
> a pile of information out of KVM without needing to add more uABI.

That's exactly my pet peeve - making it a uABI and then supporting it foreva.

We have tried to explain what cpuinfo should be:

Documentation/arch/x86/cpuinfo.rst

The gist of it is:

"So, the current use of /proc/cpuinfo is to show features which the kernel has
*enabled* and *supports*. As in: the CPUID feature flag is there, there's an
additional setup which the kernel has done while booting and the functionality
is ready to use. A perfect example for that is "user_shstk" where additional
code enablement is present in the kernel to support shadow stack for user
programs."

So if it is something that has been enabled and is actively supported, then
sure, ofc. What I don't want to have there is a partial mirror of every
possible CPUID flag which is going to be a senseless and useless madness.

Dunno, I guess if we had a

"virt: ..."

line in /proc/cpuinfo which has flags of what the hypervisor has enabled as
a feature, it might not be such a wrong idea... with the above caveats, ofc.
I don't think you want a flurry of patches setting all possible flags just
because.

Or maybe somewhere else where you can query it conveniently...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

