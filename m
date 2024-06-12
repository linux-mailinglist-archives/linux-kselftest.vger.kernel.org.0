Return-Path: <linux-kselftest+bounces-11739-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80EC1904AE5
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Jun 2024 07:31:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1025A28419E
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Jun 2024 05:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFFB5374D1;
	Wed, 12 Jun 2024 05:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qXr+DAg8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 886A62D03B
	for <linux-kselftest@vger.kernel.org>; Wed, 12 Jun 2024 05:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718170263; cv=none; b=i0tJQOFkRkRm0xAR8N+2b+S9sFbTr0EeybmhK7iW/WsVaYUTuKvp96D3zO23hgQkuOZhC9ifAZ0RqHSLIGg2LJLpmdZu3BYv7AgkHf7/OpWVH3U2FfEPYJ1674tAjLxVzV3waCGRhgRnQ4wTmmxEsDJGHliwNMijjhIbXiO3CQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718170263; c=relaxed/simple;
	bh=M79FP9xawocEU+lriIXIatL6EDmqJHLQLEu2xZP59cE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T/CZv8Zt1IajFVrLAuswSELjIytPtSHoHrzwMXUQjs8XfIX2X3an9yq1d8f/H8ZU+OcugLz4Ed63i5jQ7rcFV6CaTBNHkebHkM3bQevenncggec6nxGv643HfgXXyCBZcvMhdyBBxKGVNIbvJllDqrOF0J98riKTHUTB8mq9prE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qXr+DAg8; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: shahuang@redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1718170259;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/UiRVtVLigMQeE81g8Kpmn0pUJ/eW6cDDy3LoMW/VXc=;
	b=qXr+DAg8cKacFvDiSUke0+CGHdsYkHAmAXVnXnPbCZTIdT4ICUniQacRM8YvMnGHJsOFdY
	diLKnRd3TYks2/vlYheRAZEPOKxV2nCgdMwl21BghyUTzHBFWCzo/zfvIUM+oA0YvNQGpT
	ysoU3sMV2TcI+Fq3yT58ywcIQaau6e8=
X-Envelope-To: maz@kernel.org
X-Envelope-To: kvmarm@lists.linux.dev
X-Envelope-To: eauger@redhat.com
X-Envelope-To: sebott@redhat.com
X-Envelope-To: cohuck@redhat.com
X-Envelope-To: catalin.marinas@arm.com
X-Envelope-To: james.morse@arm.com
X-Envelope-To: kvm@vger.kernel.org
X-Envelope-To: linux-arm-kernel@lists.infradead.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: linux-kselftest@vger.kernel.org
X-Envelope-To: pbonzini@redhat.com
X-Envelope-To: shuah@kernel.org
X-Envelope-To: suzuki.poulose@arm.com
X-Envelope-To: will@kernel.org
X-Envelope-To: yuzenghui@huawei.com
Date: Tue, 11 Jun 2024 22:30:51 -0700
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Oliver Upton <oliver.upton@linux.dev>
To: Shaoqin Huang <shahuang@redhat.com>
Cc: Marc Zyngier <maz@kernel.org>, kvmarm@lists.linux.dev,
	Eric Auger <eauger@redhat.com>, Sebastian Ott <sebott@redhat.com>,
	Cornelia Huck <cohuck@redhat.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	James Morse <james.morse@arm.com>, kvm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Will Deacon <will@kernel.org>, Zenghui Yu <yuzenghui@huawei.com>
Subject: Re: [RFC PATCH v1 0/2] KVM: arm64: Making BT Field in
 ID_AA64PFR1_EL1 writable
Message-ID: <Zmkyi39Pz6Wqll-7@linux.dev>
References: <20240612023553.127813-1-shahuang@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240612023553.127813-1-shahuang@redhat.com>
X-Migadu-Flow: FLOW_OUT

Hi Shaoqin,

On Tue, Jun 11, 2024 at 10:35:50PM -0400, Shaoqin Huang wrote:
> Hi guys,
> 
> I'm trying to enable migration from MtCollins(Ampere Altra, ARMv8.2+) to
> AmpereOne(AmpereOne, ARMv8.6+), the migration always fails when migration from
> MtCollins to AmpereOne due to some register fields differing between the
> two machines.
> 
> In this patch series, we try to make more register fields writable like
> ID_AA64PFR1_EL1.BT. This is first step towards making the migration possible.
> Some other hurdles need to be overcome. This is not sufficient to make the
> migration successful from MtCollins to AmpereOne.

It isn't possible to transparently migrate between these systems. The
former has a cntfrq of 25MHz, and the latter has a cntfrq of 1GHz. There
isn't a mechanism for scaling the counter frequency, and I have zero
appetite for a paravirt interface.

On top of that, erratum AC03_CPU_38 seems to make a migration from
Neoverse-N1 to AmpereOne quite perilous, unless you hide FEAT_HAFDBS on
the source.

These issues are separate, though, from any possible changes to the
writability of ID_AA64PFR1_EL1, which still may be useful to userspace.

-- 
Thanks,
Oliver

