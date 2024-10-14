Return-Path: <linux-kselftest+bounces-19670-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0498799D60D
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Oct 2024 20:03:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C69A28304E
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Oct 2024 18:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09BAB1C6F5F;
	Mon, 14 Oct 2024 18:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=nik.wipper@gmx.de header.b="IlA7C4ga"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 872671AB517;
	Mon, 14 Oct 2024 18:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728928990; cv=none; b=kJUFn5M1BS4h8dWfi5y5XFpbyZv+8+TOdzFqw9M+wwpMAoV/IBEkMLgu+avZL81O+oF4gdb05/S3Q6kr8e46+V6NtSz2J5q+T4agVuqH51RTVQpwYXkLHqoSiSwkE98YqnwD4yBphi8IZVUc5g0XFgQZOywXOm45Rto3YLMfv/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728928990; c=relaxed/simple;
	bh=W8aMkgAZ+Y5ONq7bdlcIziDRwufOGxXYLU6KucxkSdk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cSooSUNVPWd8LncTfgMmXD8i9E24BRWAI2LKX5gGncWHDqwiSC5JuOlRURgfscYi7oH0o6ZSI/D7noQqYoTqyWugHZkJpCo1x1G+tkKlB++dLDZMfLL8NDeBhBJ2ethlMEtU9KsskIBFhIkBL0f3fqqdLY3r/34yonBstnPLI10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=nik.wipper@gmx.de header.b=IlA7C4ga; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1728928941; x=1729533741; i=nik.wipper@gmx.de;
	bh=U0SYz3/j59gLOPkk3ixXiF+VnTvfXVwcR8ulqTsSA3c=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=IlA7C4gaOZ13fVjR6zhXguXmC3ALqk28LnpQVCWF17BvCAiJktxl+EVZZwxhBZ8g
	 AaQtFpfQxdL7/GpZ2ZciM9XLCxJ0ckwp6vtIxleM3IxGRlI1wY+K2WZzZJMdIByRY
	 r0iz2AVtnNfi76rXnTTmpFT2boYSdnShQAa3u1oKvKIoHxsqk6Et884JKcGZ0CMf6
	 ZbTqhx15httRI/N7epR9rGeHQBwzVoS0s/6PZk70rZiV0BpxeHZS08rQXkgilkvtO
	 DFXBwDQRyh0imVExXcIQGu4+Ffv2b3WhE0/y1ciLcjrWfS7MqYq8X+0ODy+RovBu3
	 rf6n9M5vVDpvJAyuKg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.178.21] ([31.17.149.238]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MFbRs-1tAreF1Dji-00DZ1v; Mon, 14
 Oct 2024 20:02:21 +0200
Message-ID: <a5ed763f-beba-43e9-8846-0d140f030b94@gmx.de>
Date: Mon, 14 Oct 2024 20:02:19 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/7] KVM: x86: Implement KVM_HYPERV_SET_TLB_FLUSH_INHIBIT
To: Vitaly Kuznetsov <vkuznets@redhat.com>, Nikolas Wipper <nikwip@amazon.de>
Cc: Nicolas Saenz Julienne <nsaenz@amazon.com>,
 Alexander Graf <graf@amazon.de>, James Gowans <jgowans@amazon.com>,
 nh-open-source@amazon.com, Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org, x86@kernel.org, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20241004140810.34231-1-nikwip@amazon.de>
 <20241004140810.34231-6-nikwip@amazon.de> <878quwgwsh.fsf@redhat.com>
Content-Language: en-US
From: Nikolas Wipper <nik.wipper@gmx.de>
In-Reply-To: <878quwgwsh.fsf@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:s60EtNloQQs3KKmPfO5whu58P07Anq3AbqgtpcdlipizmYtJa0L
 gT0TvXEMaOvz2S4B4o+RjZx6i7YOWawKAh1pJZyWynMlUDltaaPLBvZ2uAaUx/oB25WsGv2
 ePiWX/9xkks88BZmYnQGPNwF0zDBHXdHpglHr3IqH1vG8VD4IwLPBnBqrVmwYypDm3zWstq
 CvQEZZxh2QDE2eacuyPcQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:eMD34Z6GK/A=;v3OxGWvUqPcm2kQ2aQWIAg0dzKo
 6ceHpgNH5K4fc0yczDcuBHCMV5mU/UjP1OYjeoZY7XeDm+uGFUzW8v0I9Vzn2vO6UpO4IsclJ
 x1vjI9ZxkpE+d4qXFS2eMd//HPxRMCFTCf7GCFCPIkJOZ29XSAIqQUKSO5+AFO6jka+uIhaxW
 l1eRo/y6jkGJFjUVa+1qpspAydVTb3Stpat0YKpnLyyR39unOUmHgWkTpizgCd97i1B2G7tDV
 9quugeIjEcMEN9hJnnGpTq34xnzUw9AXa18YHjYDBtbiLknat1yaHXbzJk34kq6RJDYZ0eNCX
 vKOi9l7MhlR9OplErxbQqS8Ao7dQQWEa737wafOyMgR3oVpQeedTgy81mY+kPYIpt452bgAFY
 YJ194Oft8SQZfzNfTjahBqZUPNpnzDjdl6+AaAtd+HPAvFkDI+87n0rfqsVv8UjCzNDAgSyNJ
 yWmpxbtfflfGz3LZ0cyucIs/BfD2dBSrP3PC7ypacP0t2mQ1WTkqIbauRRw22a2B/iNpLVAZD
 as13rBjsj/gG8eA5DRGC8ja2YssOMgd10uGvD4ZpoqQzcha2tMbeRWQaOHexE8qoila1dF654
 nGrLrgnEevHKlUBLEiizOQ3g+xQyRvrpO5AEr4xjP45bNtdMMWZeK+8B5zmyPoUJdgMGXvkNf
 3pDrAI8OrMlMyGUd0N9wMk2hsaYxhK3hsPBEoSlkKZ8fE60zUw0HKAQ/OlSOuHMqv51dtyItS
 i7zrUcJXnIla/puuMXc7/K4uq/SooOGHZZhmXIb0M3kgpiT6Vj03RnU42GZmriUvL2GXlV9sh
 wmu7lJsgUcJ3Wj4ZW6YccBEQ==

On 10.10.24 10:57, Vitaly Kuznetsov wrote:
> Nikolas Wipper <nikwip@amazon.de> writes:
>> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm=
_host.h
>> index 7571ac578884..ab3a9beb61a2 100644
>> --- a/arch/x86/include/asm/kvm_host.h
>> +++ b/arch/x86/include/asm/kvm_host.h
>> @@ -698,6 +698,8 @@ struct kvm_vcpu_hv {
>>
>>  	bool suspended;
>>  	int waiting_on;
>> +
>> +	int tlb_flush_inhibit;
>
> This is basically boolean, right? And we only make it 'int' to be able
> to store 'u8' from the ioctl? This doesn't look very clean. Do you
> envision anything but '1'/'0' in 'inhibit'? If not, maybe we can just
> make it a flag (and e.g. extend 'flags' to be u32/u64)? This way we can
> convert 'tlb_flush_inhibit' to a normal bool.
>

Yes, inhibit would always be binary, so incorporating it into the flags
sounds reasonable. Even with the current API, this could just be a bool
(tlb_flush_inhibit =3D inhibit =3D=3D 1;)

>>  };
>>
>>  struct kvm_hypervisor_cpuid {
>> diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
>> index e68fbc0c7fc1..40ea8340838f 100644
>> --- a/arch/x86/kvm/hyperv.c
>> +++ b/arch/x86/kvm/hyperv.c
>> @@ -2137,6 +2137,9 @@ static u64 kvm_hv_flush_tlb(struct kvm_vcpu *vcpu=
, struct kvm_hv_hcall *hc)
>>  		bitmap_zero(vcpu_mask, KVM_MAX_VCPUS);
>>
>>  		kvm_for_each_vcpu(i, v, kvm) {
>> +			if (READ_ONCE(v->arch.hyperv->tlb_flush_inhibit))
>> +				goto ret_suspend;
>> +
>>  			__set_bit(i, vcpu_mask);
>>  		}
>>  	} else if (!is_guest_mode(vcpu)) {
>> @@ -2148,6 +2151,9 @@ static u64 kvm_hv_flush_tlb(struct kvm_vcpu *vcpu=
, struct kvm_hv_hcall *hc)
>>  				__clear_bit(i, vcpu_mask);
>>  				continue;
>>  			}
>> +
>> +			if (READ_ONCE(v->arch.hyperv->tlb_flush_inhibit))
>> +				goto ret_suspend;
>>  		}
>>  	} else {
>>  		struct kvm_vcpu_hv *hv_v;
>> @@ -2175,6 +2181,9 @@ static u64 kvm_hv_flush_tlb(struct kvm_vcpu *vcpu=
, struct kvm_hv_hcall *hc)
>>  						    sparse_banks))
>>  				continue;
>>
>> +			if (READ_ONCE(v->arch.hyperv->tlb_flush_inhibit))
>> +				goto ret_suspend;
>> +
>
> These READ_ONCEs make me think I misunderstand something here, please
> bear with me :-).
>
> Like we're trying to protect against 'tlb_flush_inhibit' being read
> somewhere in the beginning of the function and want to generate real
> memory accesses. But what happens if tlb_flush_inhibit changes right
> _after_ we checked it here and _before_ we actuall do
> kvm_make_vcpus_request_mask()? Wouldn't it be a problem? In case it
> would, I think we need to reverse the order: do
> kvm_make_vcpus_request_mask() anyway and after it go through vcpu_mask
> checking whether any of the affected vCPUs has 'tlb_flush_inhibit' and
> if it does, suspend the caller.
>

The case you're describing is prevented through SRCU synchronisation in
the ioctl. The hypercall actually holds a read side critical section
during the whole of its execution, so when tlb_flush_inhibit changes
after we read it, the ioctl would wait for the flushes to complete:

vCPU 0                   | vCPU 1
=2D------------------------+------------------------
                         | hypercall enter
                         | srcu_read_lock()
ioctl enter              |
                         | tlb_flush_inhibit read
tlb_flush_inhibit write  |
synchronize_srcu() start |
                         | TLB flush reqs send
                         | srcu_read_unlock()
synchronize_srcu() end   |
ioctl exit               |

>>  			__set_bit(i, vcpu_mask);
>>  		}
>>  	}
>> @@ -2193,6 +2202,9 @@ static u64 kvm_hv_flush_tlb(struct kvm_vcpu *vcpu=
, struct kvm_hv_hcall *hc)
>>  	/* We always do full TLB flush, set 'Reps completed' =3D 'Rep Count' =
*/
>>  	return (u64)HV_STATUS_SUCCESS |
>>  		((u64)hc->rep_cnt << HV_HYPERCALL_REP_COMP_OFFSET);
>> +ret_suspend:
>> +	kvm_hv_vcpu_suspend_tlb_flush(vcpu, v->vcpu_id);
>> +	return -EBUSY;
>>  }
>>
>>  static void kvm_hv_send_ipi_to_many(struct kvm *kvm, u32 vector,
>> @@ -2380,6 +2392,13 @@ static int kvm_hv_hypercall_complete(struct kvm_=
vcpu *vcpu, u64 result)
>>  	u32 tlb_lock_count =3D 0;
>>  	int ret;
>>
>> +	/*
>> +	 * Reached when the hyper-call resulted in a suspension of the vCPU.
>> +	 * The instruction will be re-tried once the vCPU is unsuspended.
>> +	 */
>> +	if (kvm_hv_vcpu_suspended(vcpu))
>> +		return 1;
>> +
>>  	if (hv_result_success(result) && is_guest_mode(vcpu) &&
>>  	    kvm_hv_is_tlb_flush_hcall(vcpu) &&
>>  	    kvm_read_guest(vcpu->kvm, to_hv_vcpu(vcpu)->nested.pa_page_gpa,
>> @@ -2919,6 +2938,9 @@ int kvm_get_hv_cpuid(struct kvm_vcpu *vcpu, struc=
t kvm_cpuid2 *cpuid,
>>
>>  void kvm_hv_vcpu_suspend_tlb_flush(struct kvm_vcpu *vcpu, int vcpu_id)
>>  {
>> +	RCU_LOCKDEP_WARN(!srcu_read_lock_held(&vcpu->kvm->srcu),
>> +			 "Suspicious Hyper-V TLB flush inhibit usage\n");
>> +
>>  	/* waiting_on's store should happen before suspended's */
>>  	WRITE_ONCE(vcpu->arch.hyperv->waiting_on, vcpu_id);
>>  	WRITE_ONCE(vcpu->arch.hyperv->suspended, true);
>> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
>> index 18d0a300e79a..1f925e32a927 100644
>> --- a/arch/x86/kvm/x86.c
>> +++ b/arch/x86/kvm/x86.c
>> @@ -4642,6 +4642,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm,=
 long ext)
>>  	case KVM_CAP_HYPERV_CPUID:
>>  	case KVM_CAP_HYPERV_ENFORCE_CPUID:
>>  	case KVM_CAP_SYS_HYPERV_CPUID:
>> +	case KVM_CAP_HYPERV_TLB_FLUSH_INHIBIT:
>>  #endif
>>  	case KVM_CAP_PCI_SEGMENT:
>>  	case KVM_CAP_DEBUGREGS:
>> @@ -5853,6 +5854,31 @@ static int kvm_vcpu_ioctl_enable_cap(struct kvm_=
vcpu *vcpu,
>>  	}
>>  }
>>
>> +static int kvm_vcpu_ioctl_set_tlb_flush_inhibit(struct kvm_vcpu *vcpu,
>> +						struct kvm_hyperv_tlb_flush_inhibit *set)
>> +{
>> +	if (set->inhibit =3D=3D READ_ONCE(vcpu->arch.hyperv->tlb_flush_inhibi=
t))
>> +		return 0;
>> +
>> +	WRITE_ONCE(vcpu->arch.hyperv->tlb_flush_inhibit, set->inhibit);
>
> As you say before, vCPU ioctls are serialized and noone else sets
> tlb_flush_inhibit, do I understand correctly that
> READ_ONCE()/WRITE_ONCE() are redundant here?
>

As mentioned before, since tlb_flush_inhibit is shared it needs
these calls.

Nikolas

