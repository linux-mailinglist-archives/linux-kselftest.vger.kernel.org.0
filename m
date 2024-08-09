Return-Path: <linux-kselftest+bounces-15088-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 974B394D59A
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Aug 2024 19:43:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F044280D79
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Aug 2024 17:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C54817E59A;
	Fri,  9 Aug 2024 17:43:54 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D40E60DCF;
	Fri,  9 Aug 2024 17:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723225434; cv=none; b=AlOzw1P2T1XFeQQNzb+9uPS0iiuNW+Jc13cNM5cbqRObZuF/bxlE67EuLcw8lyZDWpqtoNSW1ahEZ/inHm2DVdiy8jPVuYPukicqFXlAYup+6csxFRAC/geoxo/2kXXCUt6hyriNxqNH+Ut3yHhztko5tmAryascre7LnlVDqJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723225434; c=relaxed/simple;
	bh=cM/0CrQLED8CsE5zqK/fBlp7UuuJHwRTMRWCvCDrJxk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rO+vItfaagGelcXB2HLAB35MhI4W11k8qBDCJUPHHgGX4dLerg2ic0yK93TRBBCtzqa81S8rmiO0LmQawiUHpP9fSMkpcp8t+aK/Dva7Wz6r8mQKz7Iyd25zaiUnRK6nGicovzqQzD0Zc8oFD6Qjs7kSL/Yi8+2izM6+RVrpbUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BBA3A13D5;
	Fri,  9 Aug 2024 10:44:17 -0700 (PDT)
Received: from [10.57.46.232] (unknown [10.57.46.232])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 35A9B3F6A8;
	Fri,  9 Aug 2024 10:43:50 -0700 (PDT)
Message-ID: <f4c4a142-d0bb-44c5-8bb9-56136c8f7cf2@arm.com>
Date: Fri, 9 Aug 2024 18:43:47 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] iommu/dma: Support MSIs through nested domains
To: "Tian, Kevin" <kevin.tian@intel.com>, Nicolin Chen <nicolinc@nvidia.com>
Cc: "jgg@nvidia.com" <jgg@nvidia.com>, "joro@8bytes.org" <joro@8bytes.org>,
 "will@kernel.org" <will@kernel.org>, "shuah@kernel.org" <shuah@kernel.org>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
References: <cover.1722644866.git.nicolinc@nvidia.com>
 <b1b8ff9c716f22f524be0313ad12e5c6d10f5bd4.1722644866.git.nicolinc@nvidia.com>
 <BN9PR11MB5276E59FBD67B1119B3E2A858CBF2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <6da4f216-594b-4c51-848c-86e281402820@arm.com>
 <ZrVN05VylFq8lK4q@Asurada-Nvidia>
 <BN9PR11MB5276D9387CB50D58E4A7585F8CBA2@BN9PR11MB5276.namprd11.prod.outlook.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <BN9PR11MB5276D9387CB50D58E4A7585F8CBA2@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-08-09 9:00 am, Tian, Kevin wrote:
>> From: Nicolin Chen <nicolinc@nvidia.com>
>> Sent: Friday, August 9, 2024 7:00 AM
>>
>> On Thu, Aug 08, 2024 at 01:38:44PM +0100, Robin Murphy wrote:
>>> On 06/08/2024 9:25 am, Tian, Kevin wrote:
>>>>> From: Nicolin Chen <nicolinc@nvidia.com>
>>>>> Sent: Saturday, August 3, 2024 8:32 AM
>>>>>
>>>>> From: Robin Murphy <robin.murphy@arm.com>
>>>>>
>>>>> Currently, iommu-dma is the only place outside of IOMMUFD and
>> drivers
>>>>> which might need to be aware of the stage 2 domain encapsulated
>> within
>>>>> a nested domain. This would be in the legacy-VFIO-style case where
>> we're
>>>>
>>>> why is it a legacy-VFIO-style? We only support nested in IOMMUFD.
>>>
>>> Because with proper nesting we ideally shouldn't need the host-managed
>>> MSI mess at all, which all stems from the old VFIO paradigm of
>>> completely abstracting interrupts from userspace. I'm still hoping
>>> IOMMUFD can grow its own interface for efficient MSI passthrough, where
>>> the VMM can simply map the physical MSI doorbell into whatever IPA (GPA)
>>> it wants it to appear at in the S2 domain, then whatever the guest does
>>> with S1 it can program the MSI address into the endpoint accordingly
>>> without us having to fiddle with it.
>>
>> Hmm, until now I wasn't so convinced myself that it could work as I
>> was worried about the data. But having a second thought, since the
>> host configures the MSI, it can still set the correct data. What we
>> only need is to change the MSI address from a RMRed IPA/gIOVA to a
>> real gIOVA of the vITS page.
>>
>> I did a quick hack to test that loop. MSI in the guest still works
>> fine without having the RMR node in its IORT. Sweet!
>>
>> To go further on this path, we will need the following changes:
>> - MSI configuration in the host (via a VFIO_IRQ_SET_ACTION_TRIGGER
>>    hypercall) should set gIOVA instead of fetching from msi_cookie.
>>    That hypercall doesn't forward an address currently, since host
>>    kernel pre-sets the msi_cookie. So, we need a way to forward the
>>    gIOVA to kernel and pack it into the msi_msg structure. I haven't
>>    read the VFIO PCI code thoroughly, yet wonder if we could just
>>    let the guest program the gIOVA to the PCI register and fall it
>>    through to the hardware, so host kernel handling that hypercall
>>    can just read it back from the register?
>> - IOMMUFD should provide VMM a way to tell the gPA (or directly +
>>    GITS_TRANSLATER?). Then kernel should do the stage-2 mapping. I
>>    have talked to Jason about this a while ago, and we have a few
>>    thoughts how to implement it. But eventually, I think we still
>>    can't avoid a middle man like msi_cookie to associate the gPA in
>>    IOMMUFD to PA in irqchip?
> 
> Probably a new IOMMU_DMA_MSI_COOKIE_USER type which uses
> GPA (passed in in ALLOC_HWPT for a nested_parent type) as IOVA
> in iommu_dma_get_msi_page()?

No, the whole point is to get away from cookies and having to keep track 
of things in the kernel that can and should just be simple regular 
user-owned S2 mappings.

>> One more concern is the MSI window size. VMM sets up a MSI region
>> that must fit the hardware window size. Most of ITS versions have
>> only one page size but one of them can have multiple pages? What
>> if vITS is one-page size while the underlying pITS has multiple?
>>
>> My understanding of the current kernel-defined 1MB size is also a
>> hard-coding window to potential fit all cases, since IOMMU code in
>> the code can just eyeball what's going on in the irqchip subsystem
>> and adjust accordingly if someday it needs to. But VMM can't?

The existing design is based around the kernel potentially having to 
stuff multiple different mappings for different devices into the MSI 
hole in a single domain, since VFIO userspace is allowed to do wacky 
things like emulate INTx using an underlying physical MSI, so there may 
not be any actual vITS region in the VM IPA space at all. I think that 
was also why it ended up being a fake reserved region exposed by the 
SMMU drivers rather than relying on userspace to say where to put it - 
making things look superficially a bit more x86-like meant fewer changes 
to userspace, which I think by now we can consider a tasty slice of 
technical debt.

For a dedicated "MSI passthrough" model where, in parallel to IOMMU 
nesting, the abstraction is thinner and userspace is in on the game of 
knowingly emulating a GIC ITS backed by a GIC ITS, I'd imagine it could 
be pretty straightforward, at least conceptually. Userspace has 
something like an IOAS_MAP_MSI(device, IOVA) to indicate where it's 
placing a vITS to which it wants that device's MSIs to be able to go, 
the kernel resolves the PA from the IRQ layer and maps it, job done. If 
userspace wants to associate two devices with the same vITS when they 
have different physical ITSes, either we split the IOAS into two HWPTs 
to hold the different mappings, or we punt it back to userspace to 
resolve at the IOAS level.

Or I guess the really cheeky version is the IRQ layer exposes its own 
thing for userspace to mmap the ITS, then it can call a literal IOAS_MAP 
on that mapping... :D

Thanks,
Robin.

