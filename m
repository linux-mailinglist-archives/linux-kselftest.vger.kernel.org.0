Return-Path: <linux-kselftest+bounces-23455-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 757CB9F5598
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Dec 2024 19:08:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94825177385
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Dec 2024 18:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1DCB1F76CB;
	Tue, 17 Dec 2024 18:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="o1alYDL5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D22941F76D4
	for <linux-kselftest@vger.kernel.org>; Tue, 17 Dec 2024 18:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734458462; cv=none; b=r3W25dK9YBXTA+feX82GzUnNCmzQHrSN9/ve8eudNgZvZwA677+zrem/uqJMH72LK5FfYyQ9m9kU4B1VqlW77de0NSdYyVeBAWI5peakWC7Nbm8pv9sU3KLC3+zz18Wt0q1g3zDp/zW/FsXKs9PzqMyJdTRMjae16Lk0QAWS3JQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734458462; c=relaxed/simple;
	bh=jqkqto/wE4TTKCgi/7/Xdmt2B/vG2gmyRNK4LWWebrI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PaCJ1ZQ/iK91wUemN/4C8NsrT7KmZtPXVEe2W8K9TOfVJ5hzcMvQfI/alfJvpny6CrQGT8H8KhZ7GykL52WEEuidOzEau1FcP+V8D7s5ppvfCtPk/uqYsA0LQ24T9vZe4ypblSWaBlh4OuwcJTjHgTNq5jUuZP8omEEQ5ltPEQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=o1alYDL5; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 17 Dec 2024 10:00:44 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1734458457;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PkRrOqmYm8mFGf6ZziFnsHC8gAVb4/Jvhm1aIGMdXpg=;
	b=o1alYDL5oQ4U8aVIN4LJhtvgi4JR5Ey49e8Jt93GpKesUTx0JkYkIFh8FnbUMROwIWNZg6
	lZMsN6urvrxNfEWq3T+ly+eCv55DhHRMSKihuA66VsYN0xym5XSDu1/PWs39zrbZDmKbEN
	P8Tu9j/uueBx7LvvaEsb2L1rCH8Fhq0=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Oliver Upton <oliver.upton@linux.dev>
To: Mark Brown <broonie@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>, Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: arm64: Fix set_id_regs selftest for ASIDBITS
 becoming unwritable
Message-ID: <Z2G8TFw4wg7bnwzB@linux.dev>
References: <20241216-kvm-arm64-fix-set-id-asidbits-v1-1-8b105b888fc3@kernel.org>
 <875xnisocy.wl-maz@kernel.org>
 <53b40aa8-f51c-4c4e-a4ad-e6a9512e5197@sirena.org.uk>
 <86v7viqusg.wl-maz@kernel.org>
 <b13b14df-00ee-4bee-8f65-d2cb7a9bfa6b@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b13b14df-00ee-4bee-8f65-d2cb7a9bfa6b@sirena.org.uk>
X-Migadu-Flow: FLOW_OUT

On Tue, Dec 17, 2024 at 03:10:28PM +0000, Mark Brown wrote:
> On Tue, Dec 17, 2024 at 01:54:39PM +0000, Marc Zyngier wrote:
> > Mark Brown <broonie@kernel.org> wrote:
> 
> > > The selftests are shipped as part of the kernel source and frequently
> > > used for testing the kernel, it's all one source base and we want to
> > > ensure that for example the test fix gets backported if the relevant
> > > kernel patch does.
> 
> > That's not what Fixes: describes. If you want to invent a new tag that
> > expresses a dependency, do that. Don't use these tags to misrepresent
> > what the patches does.
> 
> No, this isn't a new use - a Fixes: tag indicates that the referenced
> commit introduced the problem being fixed and that is exactly what's
> going on here.  Like I say the selftests are not a completely separate
> project, they are a part of the same source release as the rest of the
> kernel and it is helpful to track information like this.

A Fixes tag suggests a bug in the referenced commit, which isn't the
case here.

I agree that having some relation between the two is useful for
determining the scope of a backport, but conveniently in this case the
test failure was introduced in 6.13.

I've taken the fix for 6.13, w/ the tag dropped.

-- 
Thanks,
Oliver

