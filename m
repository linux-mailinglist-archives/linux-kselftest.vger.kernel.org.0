Return-Path: <linux-kselftest+bounces-30402-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ECACA820ED
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Apr 2025 11:22:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06B2C1BA2479
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Apr 2025 09:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6FEE259CB8;
	Wed,  9 Apr 2025 09:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="c5FFgxep"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4842505A7;
	Wed,  9 Apr 2025 09:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744190539; cv=none; b=sRwQR98XA1iqCLIG73nrRjtvSi8LuYijTF7jpVH/v7yuthlAYrzFqX7qrpRVOebfIlVZEicC6te644RLIjZNoviNRd3eDgLvtPRFerwBVJLopyCGW6DAVqzU3Cf+s004xk0gwxXsiciMf6qpr+N9+U7mNfHnNga3gx96huykwKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744190539; c=relaxed/simple;
	bh=SncgdFUKtGgoA+PfYueMIKN4OwgVhStA3t9twMm5YF8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hlW7MBlWEIc6RLcFg6UT+dxMz3+qy4Mw2f79INs22fZMFHtLIeo1EBbMdxBVvG0k6cks1HMuR783mQTAAlkhjQv0c6D6CmUfXFmd+taJUoEgomL3c6/3LH6rGylKnSaVp4XscYtEzzHusVxFr8o+X6dFRkJ03VP74x81TUIvtHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=c5FFgxep; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 7FD2E40E021C;
	Wed,  9 Apr 2025 09:22:06 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id tL8gEXyv5BQQ; Wed,  9 Apr 2025 09:22:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1744190522; bh=ly0Dc3pZNm9aM/zn2j4DF8NCX99MdvH+tytnbrQw5Uw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c5FFgxepyjENhJ/RpxtKKyPVrw6nyXnQOt9xhGvK80xiyho0OVUTGMEVCLOfqHW4Q
	 r9VN4JrHkjKpOxb+rtYS/ex66Rz+vn7gzFxDzUg96804upD0TWppgdraqDZxwQIp5c
	 9udlV6liIbOU4eaBpru5cbzXAymTB3gMcwQhfglXs+x9jWCwOZYzvt2bFakS2F54yX
	 55I/rD46X9m8KfeyW5JjOQkUQn6Tvqf5mN7aL6SM8AchMMW7TNeq6bqyEWJExVnGrj
	 2KOGfR2AikEUxZ3fRGn3EXdMpR1Ws3fGkvCPbZu3L9FtY4RW0fNN2RvFNWCJQVZHLy
	 sMB7dXWZLhLM6Bh7MraT6DTEVZZI4w4478rrkVhjON48lfoaUmibu2hjb/ZIHkWqWR
	 fC/1y6OVaLK501+zA/RYsZZqVKx2aACLst4Z52DFZUlTM/sfMr3zIE91NMGIt7a6+b
	 Dw3pkHKDPoLTsTFS98myqc8w6LPuFcxTnm/Czn9XZZ1tmLHG/UF7KzqJiIsqL1nVU/
	 rIULWd8f8B8WftN2LMhLtv08BK29LgTigp1C8TUwHFEN9UXjwg3CuJT97+XvVrwJw/
	 4sYa7pQ5ZKc7BuGuGMGQkGVX8xYyUTvUUU7yXFOp5kO6/HbZgBbm2VHr3Y5XlJl/37
	 +DfQ4KOjztLEqFK5SqsM7DC4=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3A5BA40E01A3;
	Wed,  9 Apr 2025 09:21:55 +0000 (UTC)
Date: Wed, 9 Apr 2025 11:21:47 +0200
From: Borislav Petkov <bp@alien8.de>
To: Manali Shukla <manali.shukla@amd.com>
Cc: kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, seanjc@google.com,
	pbonzini@redhat.com, nikunj@amd.com, thomas.lendacky@amd.com
Subject: Re: [PATCH v4 2/5] x86/cpufeatures: Add CPUID feature bit for the
 Bus Lock Threshold
Message-ID: <20250409092147.GAZ_Y8K52Opcw2X-tg@fat_crate.local>
References: <20250324130248.126036-1-manali.shukla@amd.com>
 <20250324130248.126036-3-manali.shukla@amd.com>
 <20250324215627.GBZ-HVC-KmZiTMxPr3@fat_crate.local>
 <55986a72-1be4-4e96-809c-dd004291df2e@amd.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <55986a72-1be4-4e96-809c-dd004291df2e@amd.com>

On Wed, Apr 09, 2025 at 11:30:56AM +0530, Manali Shukla wrote:
> Do you have concern with the decision to expose the flag to /proc/cpuinfo?
> 
> The decision to expose the flag to /proc/cpuinfo was already discussed in 
> [v1]. As suggested in the discussion [v1], I have added "buslock" to be
> enumerated in /proc/cpuinfo.

If you mean this:

https://lore.kernel.org/kvm/20240709175145.9986-4-manali.shukla@amd.com/T/#m1dc7e08c54dd91d53a6bc5b1ed0a6721b356a756

I don't see any conclusion there.

I see Sean wanting to export information out of KVM to say what it supports
without adding user ABI and I don't know how far that has come but what you're
doing here ain't it.

Just do:

#define X86_FEATURE_BUS_LOCK_THRESHOLD    (15*32+29) /* Bus lock threshold */

and then later KVM can export this however it prefers.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

