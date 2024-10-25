Return-Path: <linux-kselftest+bounces-20609-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D70A9AF9A7
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Oct 2024 08:13:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 780211C21997
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Oct 2024 06:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F41F18F2F2;
	Fri, 25 Oct 2024 06:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="M3Fp92Mp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DBDE18BC2A;
	Fri, 25 Oct 2024 06:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729836815; cv=none; b=U+3EA062kKZvP8s4yr8H60fGySs9RLCS+VYu13c/QLMjeeAEDLOry5PrDXyv/9yBP2BRxbpEhiZJrE7m0mCToQOjsH9eVggJvP9N64VmLtGQEni8cnDpqMbqVYQEAMq+uXbSkcZ0WVaES/eYHdXsQNo8JmqS/DzFxDbaLu8vnX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729836815; c=relaxed/simple;
	bh=6d0jNOYm8+UX1GI3ORK1fHvZg2kELwsSG52v2C5UXhY=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=XpJfaPadzMut+GCOSchaAslbucElZQQfTFyK4Ws50Pfkf9ZYp7OdsNL4R/JlieuFubfLq6QKG7IE8+MGwqEUMMAgNyr4XdpeOONPs+o0SX0Nc6JoOWl3Ze+5OCuESQEElU/ALrGq9f9P/k0n+TczsF9v2ga/W6Xa48V6EvbIbiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=M3Fp92Mp; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:MIME-Version:Message-ID:References:In-Reply-To:Subject:CC:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=Yqhk9X0Hpv5XLgEFxivgetJ23tlmLhIvDHYvaF3/RF0=; b=M3Fp92MpdZcnNiNxDY5LYNlsfQ
	IkV4ivBXpPQQRb3Ck3yLPwIJm36djIj9TL9qKmD/XDH9tEQtYFPQ5pQ1MBDYjweS5LOEXo45X+W+W
	XuUcsZlVdUzZxT02yjYXjUP92vURayFIJZyNhHMoDAzZ6PMapzGiqmnRWFEbDEPsXEk/AEAkBDPy/
	6za1uQZx/Z5J3OQytaJImBEv5X5h7O6XY9Ha1/cI0wSOPo/EHJFlwUuPeKtdO+Z/jhp3n/mSnyi3l
	VkzFd3rYSufi9c937pkpMPCKAOSGu8PsMbT4Abnk4wjqduo8ISrlISGdJK1tkVdEr86/BQT8CdEvL
	kbF4CIbA==;
Received: from [69.6.35.226] (helo=[127.0.0.1])
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t4DZI-00000008qB8-1qL8;
	Fri, 25 Oct 2024 06:13:06 +0000
Date: Fri, 25 Oct 2024 08:13:03 +0200
From: David Woodhouse <dwmw2@infradead.org>
To: Oliver Upton <oliver.upton@linux.dev>
CC: Miguel Luis <miguel.luis@oracle.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Jonathan Corbet <corbet@lwn.net>, Marc Zyngier <maz@kernel.org>,
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
In-Reply-To: <ZxqmsiXV6ZYTANKY@linux.dev>
References: <20241019172459.2241939-1-dwmw2@infradead.org> <20241019172459.2241939-7-dwmw2@infradead.org> <23C91005-7304-4312-A5E0-F5E6C05B3209@oracle.com> <ECD0CA58-2C3B-48F3-AF12-95E37CB0FC48@infradead.org> <ZxprcWDe2AXuLhD_@linux.dev> <691447A1-8F3F-4890-B00F-8068A14CA126@infradead.org> <ZxqmsiXV6ZYTANKY@linux.dev>
Message-ID: <627769A8-AF84-47A1-B4F9-5F44C75A8058@infradead.org>
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

On 24 October 2024 21:57:38 CEST, Oliver Upton <oliver=2Eupton@linux=2Edev>=
 wrote:
>On Thu, Oct 24, 2024 at 05:56:09PM +0200, David Woodhouse wrote:
>> On 24 October 2024 17:44:49 CEST, Oliver Upton <oliver=2Eupton@linux=2E=
dev> wrote:
>> >IIUC, you're really wanting to 0x0 because there are hypervisors out
>> >there that violate the final spec and *only* accept this value=2E
>> >
>> >That's perfectly fine, but it'd help avoid confusion if the supporting
>> >comment was a bit more direct:
>> >
>> >	/*
>> >	 * If no hibernate type is specified SYSTEM_OFF2 defaults to
>> >	 * selecting HIBERNATE_OFF=2E
>> >	 *
>> >	 * There are hypervisors in the wild that violate the spec and
>> >	 * reject calls that explicitly provide a hibernate type=2E For
>> >	 * compatibility with these nonstandard implementations, pass 0
>> >	 * as the type=2E
>> >	 */
>> >	 if (system_entering_hibernation())
>> >		invoke_psci_fn(PSCI_FN_NATIVE(1_3, SYSTEM_OFF2), 0 , 0, 0);
>>=20
>> By the time this makes it into released versions of the guest Linux ker=
nel, that comment won't be true any more=2E
>
>Then does it even matter? What is the problem you're trying to solve
>with using a particular value for the hibernate type?
>
>Either the goal of this is to make the PSCI client code compatible with
>your hypervisor today (and any other implementation based on 'F ALP1') or
>we don't care and go with whatever value we want=2E
>
>Even if the comment eventually becomes stale, there is a ton of value in
>documenting the exact implementation decision being made=2E
>

Eventually it won't matter and we can go with whatever value we want=2E Bu=
t yes, the goal is to be compatible with the hypervisor *today* until it ca=
tches up the changes to the final versions of the spec=2E I didn't spend mu=
ch time overthinking the comment=2E What was it=2E=2E=2E=2E

	/*
	 * Zero is an acceptable alternative to PSCI_1_3_OFF_TYPE_HIBERNATE_OFF
	 * and is supported by hypervisors implementing an earlier version
	 * of the pSCI v1=2E3 spec=2E
	 */

That seems to cover it just fine, I think=2E

