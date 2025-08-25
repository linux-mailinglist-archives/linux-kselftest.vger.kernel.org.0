Return-Path: <linux-kselftest+bounces-39891-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C136BB34E2D
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Aug 2025 23:38:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD8F81A88416
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Aug 2025 21:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7247229B233;
	Mon, 25 Aug 2025 21:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dKKl258e"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 223D119539F
	for <linux-kselftest@vger.kernel.org>; Mon, 25 Aug 2025 21:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756157928; cv=none; b=SkTeygu0KWA0VuXgVp6o1vdE4iiknaEWYxm1RE89wqX09LWVXfzC6EngYYOpS8B7Jko4I+pcAqOuVaXMMwMyaQnq+KU9kRTy26CxEfzg/svo7e64xbwgHPA5VdgYEMzFS47/iEXcbiHEyLmyx5HfrzI9TeJ0JkNijX/FwJlH7/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756157928; c=relaxed/simple;
	bh=nDzVpC+t1U+7sHNaEIwZiniHiB4Gcj9beJV5ErzYl1w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VslLdK42bQK7kvnpsmAcNWSKA0KOzOHq4T/MEECEvuLlDE/gZ1+Xiie7DzhycqmzX2nOwJkTnjtlpQ8yGX1sO5/9bLzF1AVpoz5YyC8HloBVans/ThMFZ0HLUPwARRPc8tj/FjqGsTBpToxTpfNoEgxhDmNcN+R1GOZVenIZzcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dKKl258e; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 25 Aug 2025 14:38:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756157923;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Svt/1wXouXBpITE7xnGEFoLKgtvLf25+nxzKUnLuc7E=;
	b=dKKl258ebLK0JjJ6bmMPG+Q9KnsfJP84OX4Vb2wogABy/Psyhw6QcqPnO3eDUhaDPxbQbm
	n+2GkQ1imRGLIht5eNvDOSaEso+pt4GQihzHD00PJUSCxKfbQLM/3rGk6MNZQ4rw9yzjpy
	jnjs6mBksPP1oNFazsyPiV16vKR/L2c=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Oliver Upton <oliver.upton@linux.dev>
To: Sean Christopherson <seanjc@google.com>
Cc: Marc Zyngier <maz@kernel.org>, Sebastian Ott <sebott@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
	kvm@vger.kernel.org, kvmarm@lists.linux.dev,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: selftests: fix irqfd_test on arm64
Message-ID: <aKzX152737nAo479@linux.dev>
References: <20250825155203.71989-1-sebott@redhat.com>
 <aKy-9eby1OS38uqM@google.com>
 <87zfbnyvk9.wl-maz@kernel.org>
 <aKzRgp58vU6h02n6@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aKzRgp58vU6h02n6@google.com>
X-Migadu-Flow: FLOW_OUT

On Mon, Aug 25, 2025 at 02:11:30PM -0700, Sean Christopherson wrote:
> On Mon, Aug 25, 2025, Marc Zyngier wrote:
> > On Mon, 25 Aug 2025 20:52:21 +0100,
> > Sean Christopherson <seanjc@google.com> wrote:
> > > Is there a sane way to handle vGIC creation in kvm_arch_vm_post_create()?  E.g.
> > > could we create a v3 GIC when possible, and fall back to v2?  And then provide a
> > > way for tests to express a hard v3 GIC dependency?
> > 
> > You can ask KVM what's available. Like an actual VMM does. There is no
> > shortage of examples in the current code base.
> 
> Right, by "sane" I meant: is there a way to instantiate a supported GIC without
> making it hard/painful to write tests, and without having to plumb in arm64
> specific requirements to common APIs?
> 
> E.g. are there tests that use the common vm_create() APIs and rely on NOT having
> a GIC?

Instead of stuffing a GIC in behind vm_create(), I'd rather we have a
specific helper for creating a VM with an irqchip. There's tests in
arm64 that rely on all this generic infrastructure and also need to
select / dimension a GIC appropriately for the test.

The majority of selftests don't even need an irqchip anyway.

Thanks,
Oliver

