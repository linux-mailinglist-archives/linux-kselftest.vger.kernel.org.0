Return-Path: <linux-kselftest+bounces-20543-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E6959AE6FB
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Oct 2024 15:48:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4C44281847
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Oct 2024 13:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 902BD1DD88B;
	Thu, 24 Oct 2024 13:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hQMbYTxZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A803E1BFE00;
	Thu, 24 Oct 2024 13:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729777732; cv=none; b=kpbcCw028xggy6SV0uDMSSIZbcF+pK4o4JkxLSE21Rm868rAdtr3zepkXQDsKRyhutZ+8vzEeuu9BTlbp/A4ve+jn4S+Y5dVxNe65m/zfLvbdYI+xDUPuXTbQC7uUYWG4F/oxP7gfIcEt1U7otBzUn81ayuwzYFiDsV+UCrp+dY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729777732; c=relaxed/simple;
	bh=3myP44Gfgp7TWDQVK9qQgIFcWGayxiKS6l53Uoqwyyg=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=Wdqm0RK4aA1E0dlG3l1X5g1cPhMeYm0JHxdIQ171nXviWPe529sE/+IikGmTYHVVQRV4Ghqs12Ab1nQ0UEsxoofpicQs5lez+vnOt9mC5EVea43TmBciI/R0H3kVr5RiTXVA2mCE9oTjxI+nEZX4hDX/IpX3oMzr1loQwkK5TVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=hQMbYTxZ; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:MIME-Version:Message-ID:References:In-Reply-To:Subject:CC:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=3myP44Gfgp7TWDQVK9qQgIFcWGayxiKS6l53Uoqwyyg=; b=hQMbYTxZAJvskYeOC5cLMCanyS
	3P6RaVvSJPhOA1/TNYfJuxxrMXtg9GO7HWHc+cXqLhRcVvz5QiqgWZyCGsVFtNXE3TAnECjUK0jiA
	sFZIlbqZQ1uzuasOTU3MjY+tDRyRdC97DlvmZJoC7/w9kzYH/w+LK9FBZ734NEJ6dscM9hxwG4wWz
	QgyK0Gqm8jJsNlwR/QhlhC6Sp1bPLez8AsjhXSo3ZIM/jLHJ//1XlNRBUwJh4adIMAq7Oe/E6rfy/
	UD/KLHRJVIKSWThlt/4pLbjGmBzSS/oB3DLbwCiPe7gH3kEiwARIpmE2UW8NdAfMOXIVhcSswP082
	CcrO0D3Q==;
Received: from [31.94.13.30] (helo=[127.0.0.1])
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t3yCW-00000008ft3-3b4H;
	Thu, 24 Oct 2024 13:48:33 +0000
Date: Thu, 24 Oct 2024 15:48:26 +0200
From: David Woodhouse <dwmw2@infradead.org>
To: Miguel Luis <miguel.luis@oracle.com>
CC: Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
 Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>,
 James Morse <james.morse@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>,
 Zenghui Yu <yuzenghui@huawei.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>,
 Len Brown <len.brown@intel.com>, Shuah Khan <shuah@kernel.org>,
 David Woodhouse <dwmw@amazon.co.uk>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
 Francesco Lavra <francescolavra.fl@gmail.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v6_6/6=5D_arm64=3A_Use_SYSTEM=5FOF?=
 =?US-ASCII?Q?F2_PSCI_call_to_power_off_for_hibernate?=
User-Agent: K-9 Mail for Android
In-Reply-To: <23C91005-7304-4312-A5E0-F5E6C05B3209@oracle.com>
References: <20241019172459.2241939-1-dwmw2@infradead.org> <20241019172459.2241939-7-dwmw2@infradead.org> <23C91005-7304-4312-A5E0-F5E6C05B3209@oracle.com>
Message-ID: <ECD0CA58-2C3B-48F3-AF12-95E37CB0FC48@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by desiato.infradead.org. See http://www.infradead.org/rpr.html

On 24 October 2024 14:54:41 CEST, Miguel Luis <miguel=2Eluis@oracle=2Ecom> =
wrote:
>Perhaps spec=2E F=2Eb=2E could be accommodated by first invoking SYSTEM_O=
FF2 with
>PSCI_1_3_OFF_TYPE_HIBERNATE_OFF and checking its return value in case of =
a
>fallback to an invocation with 0x0 ?

I wasn't aware there was any point=2E Are there any hypervisors which actu=
ally implemented it that way? Amazon Linux and Ubuntu guests already just u=
se zero=2E

We could add it later if such a hypervisor (now in violation of F=2Eb) tur=
ns up, I suppose?

