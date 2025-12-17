Return-Path: <linux-kselftest+bounces-47623-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 096EFCC5918
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Dec 2025 01:13:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 05ABE302E2C9
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Dec 2025 00:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 422F63BBF0;
	Wed, 17 Dec 2025 00:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PjMR02Ze"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08ADE288A2;
	Wed, 17 Dec 2025 00:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765930400; cv=none; b=MiKCD0Ueqoti67tPqXxFwUVbWZ9ICBL2lrI4aptkfL9vHgWUR0o/zyEt4c+uH1qLhaGNMrzsqhNQP9KpMqN1VokTQ8xIgYvCGjoRYjB8SN+7XbZ+nNe3rsJe4ZamUMeHCp4lEkHVF4GeGGuV2aIcqlTbm4ccYXsBoiBgOGy29N8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765930400; c=relaxed/simple;
	bh=p8kOKXRClvsn0/nZCAyBb0kv36JqoCmhi5ZmrnAFXtw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W5KwuuN3/ZEUwiIr4WiDLqWFfld83nCiCODGHxC8R0prU3NsRihrOogYtqwuMI72iK200r/w1VOaD6WAMITdBR0Qmoe7cOennqt76Zotid7MtGBSkt+JkOKFi3picmCs1m9UFjCUNKCs1LQa7LWBgD0fpkspUBZET/gOLhe9azw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PjMR02Ze; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34297C4CEF1;
	Wed, 17 Dec 2025 00:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765930399;
	bh=p8kOKXRClvsn0/nZCAyBb0kv36JqoCmhi5ZmrnAFXtw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PjMR02ZebL/kAinz2ZnNojcM8bhDXzlCUTEnMESUsr0FLDRKPOXkj7bjCZ3xFh5iG
	 cYT43D+u/SWqm80L4VdT1hLqQ3kyAsjOJ4d4emHJ3dNdKjKk91dFBeXpQ7/DhAQxaj
	 CwMoMqR43DG8q8lKdFq8HkJd0RcVYjv2Ok/Mg2DaDhv/v7Gs3PFXXXZBTVrWUFOZtr
	 fgN0ioyTXURjMW06EepYwDbLIDdUcF4DinO3P0WxREFcCxtxku4w/u7gwOxCu1Acrv
	 sA1lwdqBz6KarrP+iuTBg/FFS9Zo30sWJjzyZuAr1WR4Yx1TQ+rPZS8349dLW6uKVU
	 6lwWpPcMMXhRQ==
Date: Tue, 16 Dec 2025 16:13:17 -0800
From: Oliver Upton <oupton@kernel.org>
To: Colton Lewis <coltonlewis@google.com>
Cc: kvm@vger.kernel.org, pbonzini@redhat.com, corbet@lwn.net,
	linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org,
	maz@kernel.org, oliver.upton@linux.dev, mizhang@google.com,
	joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com,
	mark.rutland@arm.com, shuah@kernel.org,
	gankulkarni@os.amperecomputing.com, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev, linux-perf-users@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v5 10/24] KVM: arm64: Set up FGT for Partitioned PMU
Message-ID: <aUH1nZB83m62kkUH@kernel.org>
References: <aTiPvS49uMOJEBrf@kernel.org>
 <gsnty0n72zl5.fsf@coltonlewis-kvm.c.googlers.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <gsnty0n72zl5.fsf@coltonlewis-kvm.c.googlers.com>

On Fri, Dec 12, 2025 at 08:51:34PM +0000, Colton Lewis wrote:
> > The other reason for doing this is kvm_pmu_fgt_bits() assumes a
> > 'positive' trap polarity, even though there are several cases where FGTs
> > have a 'negative' priority (i.e. 0 => trap).
> 
> For the bits I was concerned with they all had positive polarity, except
> for the dedicated instruction counter. (Side note: Why would ARM do
> this?)

Old software on new hardware, you don't want the guest to magically get
access to things it shouldn't.

> IIRC the FGT setup I plugged into in previous versions of the patch had
> some icky macros that accounted for polarity. They were confusing and I
> didn't like the effort to understand them.

I'm guessing you're referring to the undef infrastructure (FGUs), which
is a meaningfully load-bearing part of KVM.

> Is there a good reason not to adopt a convetion that 1 => trap for
> kernel code? Reversing the negative polarities immediately before write
> could be easy: Have a bitmap of the negative polarity bits to xor with
> the traps we actually want.

This *significantly* muddies the water around FGTs. I quite like that the
current representation matches the architecture. NV forces KVM to deal
with the native representations anyway.

Thanks,
Oliver

