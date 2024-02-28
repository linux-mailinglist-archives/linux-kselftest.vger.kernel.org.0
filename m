Return-Path: <linux-kselftest+bounces-5553-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D29AE86B9E2
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Feb 2024 22:30:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D9251C2533C
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Feb 2024 21:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC7EA70020;
	Wed, 28 Feb 2024 21:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BSVSjaK7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 828DD8627C
	for <linux-kselftest@vger.kernel.org>; Wed, 28 Feb 2024 21:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709155800; cv=none; b=pQ1HU5ubIts8Q9CmsFrqS2FeulZjk0mEWfudTurY6GSwEGjNOX3wI07nwX37hMsbgd9NbEpWCMDbeT+77rAKF3ggMgrvUBD/j+qx7z/a/3GlQerwQX5Ww6HZ4nkFhCsp7UdWvBcA9XkNG6ZWOi015535aSAaNUW+3OQhDErQJhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709155800; c=relaxed/simple;
	bh=tKi61AWnzUSUD+C7vq3Rt69JFAHiy6USDczG1BVy7OU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dXh77pKmuiVqsSkbHQRdnM9BGMFti84UxwxuUuzKiv8ycvIgl864vSIF+wRQpJt3UQJSQAJF2iALNVJ8GzrtGNE0dqvBxzY5lrPGVO3MAAhvOv3Ri6LIg2tRY+kawIGtwX3zVZKpv1QZbpgH92Czp+4dm1Ul59RC6uVb8Z80VAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BSVSjaK7; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 28 Feb 2024 21:29:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1709155796;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LmCqMU+CqRtl1lQzxakvCjnhFpdoPkkukjCHHZwQrbk=;
	b=BSVSjaK74JZWpc6DMeZ09A3GtVKrqWIxjcmYbzS5bocX+hTEZ/h7EnkF8t/3pDmkXIT5Vy
	CuTbcrDeccraoahlrnXpFxIYIT+Le+R1sd8x8Tt/lUH7PR96qNdM/2VB/UGQP3LPoT05oy
	PcAXb0WwO87G3FgZgyi+ASAP4xUVOl0=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Oliver Upton <oliver.upton@linux.dev>
To: Sean Christopherson <seanjc@google.com>
Cc: Mark Brown <broonie@kernel.org>, Thomas Huth <thuth@redhat.com>,
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Marc Zyngier <maz@kernel.org>,
	Aishwarya TCV <aishwarya.tcv@arm.com>
Subject: Re: [PATCH v3 3/8] KVM: selftests: Move setting a vCPU's entry point
 to a dedicated API
Message-ID: <Zd-lzwQb0APsBFjM@linux.dev>
References: <20240208204844.119326-1-thuth@redhat.com>
 <20240208204844.119326-4-thuth@redhat.com>
 <501ac94d-11ab-4765-a25d-75013c021be6@sirena.org.uk>
 <Zd-JjBNCpFG5iDul@google.com>
 <Zd-jdAtI_C_d_fp4@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zd-jdAtI_C_d_fp4@google.com>
X-Migadu-Flow: FLOW_OUT

+cc Raghavendra

Hey,

On Wed, Feb 28, 2024 at 01:19:48PM -0800, Sean Christopherson wrote:
> but due to a different issue that is fixed in the kvm-arm tree[*], but not in mine,
> I built without -Werror and didn't see the new warn in the sea of GUEST_PRINTF
> warnings.
> 
> Ugh, and I still can't enable -Werror, because there are unused functions in
> aarch64/vpmu_counter_access.c
> 
>   aarch64/vpmu_counter_access.c:96:20: error: unused function 'enable_counter' [-Werror,-Wunused-function]
>   static inline void enable_counter(int idx)
>                    ^
>   aarch64/vpmu_counter_access.c:104:20: error: unused function 'disable_counter' [-Werror,-Wunused-function]
>   static inline void disable_counter(int idx)
>                    ^
>   2 errors generated.
>   make: *** [Makefile:278: /usr/local/google/home/seanjc/go/src/kernel.org/nox/tools/testing/selftests/kvm/aarch64/vpmu_counter_access.o] Error 1
>   make: *** Waiting for unfinished jobs....
> 
>   Commit 49f31cff9c533d264659356b90445023b04e10fb failed to build with 'make-clang make-arm make -j128'.
> 
> Oliver/Marc, any thoughts on how you want to fix the unused function warnings?
> As evidenced by this goof, being able to compile with -Werror is super helpful.

Are these the only remaining warnings we have in the arm64 selftests
build?

Faster than me paging this test back in: Raghu, are we missing any test
cases upstream that these helpers were intended for? If no, mind sending
a patch to get rid of them?

> And another question: is there any reason to not force -Werror for selftests?

Nothing comes to mind. We need to bite the bullet and make the switch.
There might be breakage, but we can certainly handle that.

-- 
Thanks,
Oliver

