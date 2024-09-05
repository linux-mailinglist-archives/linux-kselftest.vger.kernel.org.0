Return-Path: <linux-kselftest+bounces-17300-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9786696E0E0
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 19:11:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EAD88B25306
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 17:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E5FE1A0AFB;
	Thu,  5 Sep 2024 17:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="Td++fBf9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD9D19DFB8;
	Thu,  5 Sep 2024 17:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725556299; cv=none; b=E4/eY2OL129i3KxTv36k5/EHAOCzC3n/Ca29BP2ljo+gNnlAFcPdBbXcYRe5qcsopWnXbeONhL9iEAQwo8DFRn+mEUK+KqKWEuDpuCnUWiiYS8XINjZDAc1NcS4JNpdY4lGfLQYnOqwtj+1CX+7qLDc7zi3KWnTJhwSFsjm1mf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725556299; c=relaxed/simple;
	bh=UgUKwC+htmQ64BydR+9gR8Mz2CbId2/rj3nOjpSfpeU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H8Ym/6fV69Ahj2TIEudMvxOBQ5SWaFzsIldfItGMqStFyrT2+x1lPganEo3TzD+D5e8YO1ul6PTZyevJpjitn5SFqX7ij8/PGtjsmykMgS5sEMn8tW8BqsvXymbzB8R+D/HSgllfrgMlizw1wy05RLoGq5NHwSG53CD1ELaWiCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=Td++fBf9; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [192.168.7.205] ([71.202.166.45])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 485H9en23712765
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Thu, 5 Sep 2024 10:09:41 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 485H9en23712765
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024081601; t=1725556182;
	bh=UP5S89Q8T/Q5EsxqhRyQ8f9BJnQqaRl+80CV7+1PjiY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Td++fBf985x/z0uESDRnIoaMDjnC8j2FiRd+xXLy9mgYmLI6IS7D9wTqmPYaqaHlR
	 CA6x65DAFqM/8/iAXlI4b1xOn6nIRFQscrXw96TKLvIsbBXCTRSPGpxTKTZ4Z3HwFo
	 +fd0hZCtR2Bj4UZwYnuaIcC3UhRgfQkTTpdq7rPVs+lJME38yR3Bi5WwhJ57q/XwJG
	 KT+7olRlKhg72DbQtiWMwkZgRt196aqOoA4Czaj3FCPe0lpNVOeXIop54h2KOWBeS+
	 D/gSJtiyZUhaHa/S6CaWMU6BFRndwWJZ2ZqVnqkDiT9LnpSbPHJk5WEnRwRELNIYpr
	 82B5itYZvyvuA==
Message-ID: <feefa9d1-f266-414f-bb7b-b770ef0d8ec6@zytor.com>
Date: Thu, 5 Sep 2024 10:09:39 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/25] KVM: VMX: Set intercept for FRED MSRs
To: Sean Christopherson <seanjc@google.com>, Chao Gao <chao.gao@intel.com>
Cc: Xin Li <xin3.li@intel.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, pbonzini@redhat.com, corbet@lwn.net,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        shuah@kernel.org, vkuznets@redhat.com, peterz@infradead.org,
        ravi.v.shankar@intel.com
References: <20240207172646.3981-1-xin3.li@intel.com>
 <20240207172646.3981-8-xin3.li@intel.com> <ZiJzFsoHR41Sd8lE@chao-email>
 <ZmoT0jaX_3Ww3Uzu@google.com>
Content-Language: en-US
From: Xin Li <xin@zytor.com>
Autocrypt: addr=xin@zytor.com; keydata=
 xsDNBGUPz1cBDACS/9yOJGojBFPxFt0OfTWuMl0uSgpwk37uRrFPTTLw4BaxhlFL0bjs6q+0
 2OfG34R+a0ZCuj5c9vggUMoOLdDyA7yPVAJU0OX6lqpg6z/kyQg3t4jvajG6aCgwSDx5Kzg5
 Rj3AXl8k2wb0jdqRB4RvaOPFiHNGgXCs5Pkux/qr0laeFIpzMKMootGa4kfURgPhRzUaM1vy
 bsMsL8vpJtGUmitrSqe5dVNBH00whLtPFM7IbzKURPUOkRRiusFAsw0a1ztCgoFczq6VfAVu
 raTye0L/VXwZd+aGi401V2tLsAHxxckRi9p3mc0jExPc60joK+aZPy6amwSCy5kAJ/AboYtY
 VmKIGKx1yx8POy6m+1lZ8C0q9b8eJ8kWPAR78PgT37FQWKYS1uAroG2wLdK7FiIEpPhCD+zH
 wlslo2ETbdKjrLIPNehQCOWrT32k8vFNEMLP5G/mmjfNj5sEf3IOKgMTMVl9AFjsINLHcxEQ
 6T8nGbX/n3msP6A36FDfdSEAEQEAAc0WWGluIExpIDx4aW5Aenl0b3IuY29tPsLBDQQTAQgA
 NxYhBIUq/WFSDTiOvUIqv2u9DlcdrjdRBQJlD89XBQkFo5qAAhsDBAsJCAcFFQgJCgsFFgID
 AQAACgkQa70OVx2uN1HUpgv/cM2fsFCQodLArMTX5nt9yqAWgA5t1srri6EgS8W3F+3Kitge
 tYTBKu6j5BXuXaX3vyfCm+zajDJN77JHuYnpcKKr13VcZi1Swv6Jx1u0II8DOmoDYLb1Q2ZW
 v83W55fOWJ2g72x/UjVJBQ0sVjAngazU3ckc0TeNQlkcpSVGa/qBIHLfZraWtdrNAQT4A1fa
 sWGuJrChBFhtKbYXbUCu9AoYmmbQnsx2EWoJy3h7OjtfFapJbPZql+no5AJ3Mk9eE5oWyLH+
 QWqtOeJM7kKvn/dBudokFSNhDUw06e7EoVPSJyUIMbYtUO7g2+Atu44G/EPP0yV0J4lRO6EA
 wYRXff7+I1jIWEHpj5EFVYO6SmBg7zF2illHEW31JAPtdDLDHYcZDfS41caEKOQIPsdzQkaQ
 oW2hchcjcMPAfyhhRzUpVHLPxLCetP8vrVhTvnaZUo0xaVYb3+wjP+D5j/3+hwblu2agPsaE
 vgVbZ8Fx3TUxUPCAdr/p73DGg57oHjgezsDNBGUPz1gBDAD4Mg7hMFRQqlzotcNSxatlAQNL
 MadLfUTFz8wUUa21LPLrHBkUwm8RujehJrzcVbPYwPXIO0uyL/F///CogMNx7Iwo6by43KOy
 g89wVFhyy237EY76j1lVfLzcMYmjBoTH95fJC/lVb5Whxil6KjSN/R/y3jfG1dPXfwAuZ/4N
 cMoOslWkfZKJeEut5aZTRepKKF54T5r49H9F7OFLyxrC/uI9UDttWqMxcWyCkHh0v1Di8176
 jjYRNTrGEfYfGxSp+3jYL3PoNceIMkqM9haXjjGl0W1B4BidK1LVYBNov0rTEzyr0a1riUrp
 Qk+6z/LHxCM9lFFXnqH7KWeToTOPQebD2B/Ah5CZlft41i8L6LOF/LCuDBuYlu/fI2nuCc8d
 m4wwtkou1Y/kIwbEsE/6RQwRXUZhzO6llfoN96Fczr/RwvPIK5SVMixqWq4QGFAyK0m/1ap4
 bhIRrdCLVQcgU4glo17vqfEaRcTW5SgX+pGs4KIPPBE5J/ABD6pBnUUAEQEAAcLA/AQYAQgA
 JhYhBIUq/WFSDTiOvUIqv2u9DlcdrjdRBQJlD89ZBQkFo5qAAhsMAAoJEGu9DlcdrjdR4C0L
 /RcjolEjoZW8VsyxWtXazQPnaRvzZ4vhmGOsCPr2BPtMlSwDzTlri8BBG1/3t/DNK4JLuwEj
 OAIE3fkkm+UG4Kjud6aNeraDI52DRVCSx6xff3bjmJsJJMb12mWglN6LjdF6K+PE+OTJUh2F
 dOhslN5C2kgl0dvUuevwMgQF3IljLmi/6APKYJHjkJpu1E6luZec/lRbetHuNFtbh3xgFIJx
 2RpgVDP4xB3f8r0I+y6ua+p7fgOjDLyoFjubRGed0Be45JJQEn7A3CSb6Xu7NYobnxfkwAGZ
 Q81a2XtvNS7Aj6NWVoOQB5KbM4yosO5+Me1V1SkX2jlnn26JPEvbV3KRFcwV5RnDxm4OQTSk
 PYbAkjBbm+tuJ/Sm+5Yp5T/BnKz21FoCS8uvTiziHj2H7Cuekn6F8EYhegONm+RVg3vikOpn
 gao85i4HwQTK9/D1wgJIQkdwWXVMZ6q/OALaBp82vQ2U9sjTyFXgDjglgh00VRAHP7u1Rcu4
 l75w1xInsg==
In-Reply-To: <ZmoT0jaX_3Ww3Uzu@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/12/2024 2:32 PM, Sean Christopherson wrote:
> On Fri, Apr 19, 2024, Chao Gao wrote:
>> On Wed, Feb 07, 2024 at 09:26:27AM -0800, Xin Li wrote:
>>> Add FRED MSRs to the valid passthrough MSR list and set FRED MSRs intercept
>>> based on FRED enumeration.
> 
> This needs a *much* more verbose explanation.  It's pretty darn obvious _what_
> KVM is doing, but it's not at all clear _why_ KVM is passing through FRED MSRs.
> E.g. why is FRED_SSP0 not included in the set of passthrough MSRs?
> 
>>> static void vmx_vcpu_config_fred_after_set_cpuid(struct kvm_vcpu *vcpu)
>>> {
>>> 	struct vcpu_vmx *vmx = to_vmx(vcpu);
>>> +	bool fred_enumerated;
>>>
>>> 	kvm_governed_feature_check_and_set(vcpu, X86_FEATURE_FRED);
>>> +	fred_enumerated = guest_can_use(vcpu, X86_FEATURE_FRED);
>>>
>>> -	if (guest_can_use(vcpu, X86_FEATURE_FRED)) {
>>> +	if (fred_enumerated) {
>>> 		vm_entry_controls_setbit(vmx, VM_ENTRY_LOAD_IA32_FRED);
>>> 		secondary_vm_exit_controls_setbit(vmx,
>>> 						  SECONDARY_VM_EXIT_SAVE_IA32_FRED |
>>> @@ -7788,6 +7793,16 @@ static void vmx_vcpu_config_fred_after_set_cpuid(struct kvm_vcpu *vcpu)
>>> 						    SECONDARY_VM_EXIT_SAVE_IA32_FRED |
>>> 						    SECONDARY_VM_EXIT_LOAD_IA32_FRED);
>>> 	}
>>> +
>>> +	vmx_set_intercept_for_msr(vcpu, MSR_IA32_FRED_RSP0, MSR_TYPE_RW, !fred_enumerated);
>>> +	vmx_set_intercept_for_msr(vcpu, MSR_IA32_FRED_RSP1, MSR_TYPE_RW, !fred_enumerated);
>>> +	vmx_set_intercept_for_msr(vcpu, MSR_IA32_FRED_RSP2, MSR_TYPE_RW, !fred_enumerated);
>>> +	vmx_set_intercept_for_msr(vcpu, MSR_IA32_FRED_RSP3, MSR_TYPE_RW, !fred_enumerated);
>>> +	vmx_set_intercept_for_msr(vcpu, MSR_IA32_FRED_STKLVLS, MSR_TYPE_RW, !fred_enumerated);
>>> +	vmx_set_intercept_for_msr(vcpu, MSR_IA32_FRED_SSP1, MSR_TYPE_RW, !fred_enumerated);
>>> +	vmx_set_intercept_for_msr(vcpu, MSR_IA32_FRED_SSP2, MSR_TYPE_RW, !fred_enumerated);
>>> +	vmx_set_intercept_for_msr(vcpu, MSR_IA32_FRED_SSP3, MSR_TYPE_RW, !fred_enumerated);
>>> +	vmx_set_intercept_for_msr(vcpu, MSR_IA32_FRED_CONFIG, MSR_TYPE_RW, !fred_enumerated);
>>
>> Use a for-loop here? e.g.,
>> 	for (i = MSR_IA32_FRED_RSP0; i <= MSR_IA32_FRED_CONFIG; i++)
> 
> Hmm, I'd prefer to keep the open coded version.  It's not pretty, but I don't
> expect this to have much, if any, maintenance cost.  And using a loop makes it
> harder to both understand _exactly_ what's happening, and to search for relevant
> code.  E.g. it's quite difficult to see that FRED_SSP0 is still intercepted (see
> my comment regarding the changelog).


I owe you an explanation; I have been thinking about figuring out a way
to include FRED SSP0 in the FRED KVM patch set...

MSR_IA32_FRED_SSP0 is an alias of the CET MSR_IA32_PL0_SSP and likely to
be used in the same way as FRED RSP0, i.e., host FRED SSP0 _should_ be
restored in arch_exit_to_user_mode_prepare().  However as of today Linux
has no plan to utilize kernel shadow stack thus no one cares host FRED
SSP0 (no?).  But lets say anyway it is host's responsibility to manage
host FRED SSP0, then KVM only needs to take care of guest FRED SSP0
(just like how KVM should handle guest FRED RSP0) even before the
supervisor shadow stack feature is advertised to guest.

Another question is should KVM handle userspace request to set/get FRED
SSP0?  IMO, it should be part of CET state management.

Your suggestion?

Thanks!
     Xin





