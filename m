Return-Path: <linux-kselftest+bounces-47500-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7467CCB8737
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Dec 2025 10:27:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0077A3048080
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Dec 2025 09:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64B9E311C3D;
	Fri, 12 Dec 2025 09:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="eBZ7zu2o"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D665299952;
	Fri, 12 Dec 2025 09:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765531332; cv=none; b=ERj9rAS4Jd8fqjnEbVqCDjwYbOEL4ZtPjumqA//vcUWLwTlSo9b5B0WRQsoaKXBkz8tc7cv5XZyCqT9obUO/eaerVVeA4zbRkq+TXcLdFvJiR8WaDySBSdM+C7OL8pmO2z1MnsK8zUYN2K4JdpbFavp02UqT4gBtvGVFAbbpqtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765531332; c=relaxed/simple;
	bh=04tB4MdBbE3k8czrCSAhdUggbwlMaR9/T03/le8K7gY=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=gMGYrgG+z0omjYDxbfUaLN64AUvVbiDh1tcUfBM6ttFwVR3tUpju8kAGDisIWTQrD4mhaKsITrefCwiTRRIRgyA1RMwTGL2lstvOe6b8SIQhyGwcMiVM0Q/Wg+qfUPFomBlyayrkt7YZp0sbfnAGLiHwEEz9wZVnw49P2jVbu30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=eBZ7zu2o; arc=none smtp.client-ip=113.46.200.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=z4vPaiUk9n/GpIxutnAk0NTSeMO9iODdip7MeYu98yA=;
	b=eBZ7zu2ox8ryH+r6AugMOCYGdskTgvt4HVyTB0sNWJZuu6AwqpHtUJ674NWi8oVHhZqLLb8Fe
	9+6XJ13bHSi7juapcNkdSCOlj5bwH+XCJogKs9+MppIMgyb9nZajKcNlh/7ZzT71idEJ7zWb7e1
	gwacD2hwUuyP493g1H7y+vg=
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4dSP686k3Dzcb0J;
	Fri, 12 Dec 2025 17:19:12 +0800 (CST)
Received: from kwepemk200017.china.huawei.com (unknown [7.202.194.83])
	by mail.maildlp.com (Postfix) with ESMTPS id 3634E180BD0;
	Fri, 12 Dec 2025 17:21:57 +0800 (CST)
Received: from [10.174.178.219] (10.174.178.219) by
 kwepemk200017.china.huawei.com (7.202.194.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 12 Dec 2025 17:21:55 +0800
Subject: Re: [PATCH v4 2/3] KVM: selftests: Test for KVM_EXIT_ARM_SEA
To: Jiaqi Yan <jiaqiyan@google.com>
CC: <maz@kernel.org>, <oliver.upton@linux.dev>, <duenwen@google.com>,
	<rananta@google.com>, <jthoughton@google.com>, <vsethi@nvidia.com>,
	<jgg@nvidia.com>, <joey.gouly@arm.com>, <suzuki.poulose@arm.com>,
	<catalin.marinas@arm.com>, <will@kernel.org>, <pbonzini@redhat.com>,
	<corbet@lwn.net>, <shuah@kernel.org>, <kvm@vger.kernel.org>,
	<kvmarm@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>
References: <20251013185903.1372553-1-jiaqiyan@google.com>
 <20251013185903.1372553-3-jiaqiyan@google.com>
 <3061f5f8-cef0-b7b1-c4de-f2ceea29af9a@huawei.com>
 <CACw3F51mRXCDz7Hd4Vve98NoskhB2cSc88zAGfd6Hwr4uCBxPA@mail.gmail.com>
From: Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <dbcfb853-5853-5967-1bf9-76c6b3839717@huawei.com>
Date: Fri, 12 Dec 2025 17:21:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CACw3F51mRXCDz7Hd4Vve98NoskhB2cSc88zAGfd6Hwr4uCBxPA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemk200017.china.huawei.com (7.202.194.83)

On 2025/12/12 9:53, Jiaqi Yan wrote:
> On Thu, Dec 11, 2025 at 5:02 AM Zenghui Yu <yuzenghui@huawei.com> wrote:
> >
> > I can also hit this ASSERT with:
> >
> > Random seed: 0x6b8b4567
> > # Mapped 0x40000 pages: gva=0x80000000 to gpa=0xff80000000
> > # Before EINJect: data=0xbaadcafe
> > # EINJ_GVA=0x81234bad, einj_gpa=0xff81234bad, einj_hva=0xffff41234bad,
> > einj_hpa=0x2841234bad
> > # echo 0x10 > /sys/kernel/debug/apei/einj/error_type - done
> > # echo 0x2 > /sys/kernel/debug/apei/einj/flags - done
> > # echo 0x2841234bad > /sys/kernel/debug/apei/einj/param1 - done
> > # echo 0xffffffffffffffff > /sys/kernel/debug/apei/einj/param2 - done
> > # echo 0x1 > /sys/kernel/debug/apei/einj/notrigger - done
> > # echo 0x1 > /sys/kernel/debug/apei/einj/error_inject - done
> > # Memory UER EINJected
> > # Dump kvm_run info about KVM_EXIT_MMIO
> > # kvm_run.arm_sea: esr=0xffff90ba0040, flags=0x691000
> > # kvm_run.arm_sea: gva=0x100000008, gpa=0
> > ==== Test Assertion Failure ====
> >   arm64/sea_to_user.c:207: exit_reason == (41)
> >   pid=38023 tid=38023 errno=4 - Interrupted system call
> >      1  0x0000000000402d1b: run_vm at sea_to_user.c:207
> >      2  0x0000000000402467: main at sea_to_user.c:330
> >      3  0x0000ffff9122b03f: ?? ??:0
> >      4  0x0000ffff9122b117: ?? ??:0
> >      5  0x00000000004026ef: _start at ??:?
> >   Wanted KVM exit reason: 41 (ARM_SEA), got: 6 (MMIO)
> >
> > Not sure what's wrong it..
> 
> Does your test machine have SDEI or SCI enabled for host APEI? Do you
> see any kernel log from "Memory failure:" saying hugetlb page
> recovered, and recovered significant earlier than the KVM exit here.
> It maybe the kernel has already unmapped hugepage in response to SDEI
> or SCI before this test actually consumes memory error, so no SEA is
> actually triggered.

No kernel log was printed when I saw this failure.

Thanks,
Zenghui

