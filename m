Return-Path: <linux-kselftest+bounces-43069-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E5AFBD7028
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Oct 2025 03:52:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CAC894E334A
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Oct 2025 01:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7345D2609DC;
	Tue, 14 Oct 2025 01:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DhO0hF6g"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E671CEACB;
	Tue, 14 Oct 2025 01:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760406716; cv=none; b=h5QfhYH21j373uLqmpSac5KEePTB39m3oyb1YVtdJJmds5feeYGaYV+uTnKLnJSUSb7jDz6D5o8pW5U96XAtFNNrHDB3DSKDAEhNFcvm8eWsjwHBhXWmoBdVjeqad4yjhPqzxYsumLpGfqZnwP5eCEgnw68G8hcW2LlXXEVzV5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760406716; c=relaxed/simple;
	bh=D5pq7pWAQYFwhyzSZxyrhL2+MSp19sOiqhoesc+kuCg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q8tal22yz/gOiwBhSJ2lCQ0H7mMhSjy54WW2c3uzK0y8uNOxZ8mSI9MF29HGmrAOrwPvi8xxbflAjlRNED53KG42JxSQZ0Rvg3JnbW+1J72yS/MKScfmjHbqdvdebHRRxQxPPfqcWtvTTNnspWfZJZB8cy+yhk15eKeyed2RE08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=DhO0hF6g; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=GdHHVHX1eK4OumztheWLpvPpWCbLWAPVj4gP9BXPPI8=; b=DhO0hF6gqhy8rmkGEl7on7+oJv
	VtSUYvYuPcOlDu5fO8rCTFa2F1N/jdAP20m8Nb67fTrBo/fW7xZkTs3E4kNWHnFynKs20G0xEsolC
	MqH/ufxF3g2GzV+W64oAUH6OPetfyV6FPMJEqWTE/ij6PONb6v3EHCJOmal94Lc0Bi4hK+35ayHKR
	mt+8n05mNcD2DsFYZBume6lwYieckkKHhLNsYjifIvTzRXNk9td5Pk/x3BSq6HPF1OGCgGKUidim1
	8H0TuKmkhlQR6ai4NxMDf9cGRmyXPY/ia4v6vaMJvdCXmK4AZRsHC3b9HHij78SAmfr3e1ZC9jXim
	CxkRoeLg==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v8UCc-0000000EvJR-1Gkr;
	Tue, 14 Oct 2025 01:51:50 +0000
Message-ID: <3efcf624-58f1-4390-b6e2-a0aa5e62a9a3@infradead.org>
Date: Mon, 13 Oct 2025 18:51:49 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] Documentation: kvm: new UAPI for handling SEA
To: Jiaqi Yan <jiaqiyan@google.com>, maz@kernel.org, oliver.upton@linux.dev
Cc: duenwen@google.com, rananta@google.com, jthoughton@google.com,
 vsethi@nvidia.com, jgg@nvidia.com, joey.gouly@arm.com,
 suzuki.poulose@arm.com, yuzenghui@huawei.com, catalin.marinas@arm.com,
 will@kernel.org, pbonzini@redhat.com, corbet@lwn.net, shuah@kernel.org,
 kvm@vger.kernel.org, kvmarm@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20251013185903.1372553-1-jiaqiyan@google.com>
 <20251013185903.1372553-4-jiaqiyan@google.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20251013185903.1372553-4-jiaqiyan@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/13/25 11:59 AM, Jiaqi Yan wrote:
> Document the new userspace-visible features and APIs for handling
> synchronous external abort (SEA)
> - KVM_CAP_ARM_SEA_TO_USER: How userspace enables the new feature.
> - KVM_EXIT_ARM_SEA: exit userspace gets when it needs to handle SEA
>   and what userspace gets while taking the SEA.
> 
> Signed-off-by: Jiaqi Yan <jiaqiyan@google.com>
> ---
>  Documentation/virt/kvm/api.rst | 61 ++++++++++++++++++++++++++++++++++
>  1 file changed, 61 insertions(+)
> 
> diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
> index 6ae24c5ca5598..43bc2a1d78e01 100644
> --- a/Documentation/virt/kvm/api.rst
> +++ b/Documentation/virt/kvm/api.rst
> @@ -7272,6 +7272,55 @@ exit, even without calls to ``KVM_ENABLE_CAP`` or similar.  In this case,
>  it will enter with output fields already valid; in the common case, the
>  ``unknown.ret`` field of the union will be ``TDVMCALL_STATUS_SUBFUNC_UNSUPPORTED``.
>  Userspace need not do anything if it does not wish to support a TDVMCALL.
> +
> +::
> +		/* KVM_EXIT_ARM_SEA */
> +		struct {
> +  #define KVM_EXIT_ARM_SEA_FLAG_GPA_VALID   (1ULL << 0)
> +			__u64 flags;
> +			__u64 esr;
> +			__u64 gva;
> +			__u64 gpa;
> +		} arm_sea;
> +
> +Used on arm64 systems. When the VM capability KVM_CAP_ARM_SEA_TO_USER is
> +enabled, a VM exit is generated if guest causes a synchronous external abort
> +(SEA) and the host APEI fails to handle the SEA.
> +
> +Historically KVM handles SEA by first delegating the SEA to host APEI as there
> +is high chance that the SEA is caused by consuming uncorrected memory error.
> +However, not all platforms support SEA handling in APEI, and KVM's fallback
> +is to inject an asynchronous SError into the guest, which usually panics
> +guest kernel unpleasantly. As an alternative, userspace can participate into

                                                                           in

> +the SEA handling by enabling KVM_CAP_ARM_SEA_TO_USER at VM creation, after
> +querying the capability. Once enabled, when KVM has to handle the guest

                                                                     guest-
> +caused SEA, it returns to userspace with KVM_EXIT_ARM_SEA, with details
> +about the SEA available in 'arm_sea'.
> +
> +The 'esr' field holds the value of the exception syndrome register (ESR) while
> +KVM taking the SEA, which tells userspace the character of the current SEA,
   KVM takes

> +such as its Exception Class, Synchronous Error Type, Fault Specific Code and
> +so on. For more details on ESR, check the Arm Architecture Registers
> +documentation.
> +
> +The following values are defined for the 'flags' field

Above needs an ending like '.' or ':'.
(or maybe "::" depending how it is processed by Sphinx)

> +
> +  - KVM_EXIT_ARM_SEA_FLAG_GPA_VALID -- the faulting guest physical address
> +    is valid and userspace can get its value in the 'gpa' field.
> +
> +Note userspace can tell whether the faulting guest virtual address is valid
> +from the FnV bit in 'esr' field. If FnV bit in 'esr' field is not set, the
> +'gva' field hols the valid faulting guest virtual address.

               holds (or contains)> +
> +Userspace needs to take actions to handle guest SEA synchronously, namely in
> +the same thread that runs KVM_RUN and receives KVM_EXIT_ARM_SEA. One of the
> +encouraged approaches is to utilize the KVM_SET_VCPU_EVENTS to inject the SEA
> +to the faulting VCPU. This way, the guest has the opportunity to keep running
> +and limit the blast radius of the SEA to the particular guest application that
> +caused the SEA. Userspace may also emulate the SEA to VM by itself using the
> +KVM_SET_ONE_REG API. In this case, it can use the valid values from 'gva' and
> +'gpa' fields to manipulate VCPU's registers (e.g. FAR_EL1, HPFAR_EL1).
> +
>  ::
>  
>  		/* Fix the size of the union. */
> @@ -8689,6 +8738,18 @@ This capability indicate to the userspace whether a PFNMAP memory region
>  can be safely mapped as cacheable. This relies on the presence of
>  force write back (FWB) feature support on the hardware.
>  
> +7.45 KVM_CAP_ARM_SEA_TO_USER
> +----------------------------
> +
> +:Architecture: arm64
> +:Target: VM
> +:Parameters: none
> +:Returns: 0 on success, -EINVAL if unsupported.
> +
> +This capability, if KVM_CHECK_EXTENSION indicates that it is available, means
> +that KVM has an implementation that allows userspace to participate in handling
> +synchronous external abort caused by VM, by an exit of KVM_EXIT_ARM_SEA.
> +
>  8. Other capabilities.
>  ======================
>  

-- 
~Randy


