Return-Path: <linux-kselftest+bounces-19763-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1968D99F440
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Oct 2024 19:41:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33F671C2292B
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Oct 2024 17:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1159F1FAEE2;
	Tue, 15 Oct 2024 17:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=nik.wipper@gmx.de header.b="CSuhhe9O"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE2321FAEE4;
	Tue, 15 Oct 2024 17:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729014061; cv=none; b=PpqSJpQCpEw1WkU6/Q1XLELxUlpJMwr7w1wDLTbKkJC2W/S6o+hVZKVMEEpnoT/k8nIDlnrhM1csQ/RAoF+8BQ23eWVaMAYHYOcd3fvrEGTG+Bi45EK1Nr1NzD/H0fJpcx1gzuG/S62qnC1rj+mZ8nk1aHCxHnX6wRwUZW6190E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729014061; c=relaxed/simple;
	bh=P65KrGxInUdsigESwHX71Bd+xUkP5k3omrZymJxtZTs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nDVgCcMQeEAEkRo5cXPXat4FW1Swbp09kceEC5iYZGpLVRqtdXe0oZqPDlrPCEWxbDgMO9FbVrhpXg3w+uZN1E6/ogNr5LcHBrMDNtiiSMwM9t4IVTW/qpXTPz+s+BjVklB6N8DFNwAdgLtKsfe7/iQueJfvon0j7vdAM+N+yJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=nik.wipper@gmx.de header.b=CSuhhe9O; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1729014029; x=1729618829; i=nik.wipper@gmx.de;
	bh=V4qx0mcm7tJzM+AzBNd3peDvru3R6cfu62ydat0p/as=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=CSuhhe9Oxo09/OS7y7RZNJoqNdA7Vi4HkjHGOf0gBYRxRNizVlA+XBSum20FW9+f
	 NYOiV9o4Q5MNcVqWWQotVaZtB4vZo36/uvd1ORndBabGIRPeWLoRZAVzdQ7WvctVa
	 s0dxppkIpI5iQZ4kAqJIPO/yZalQyT1Pac4TfJw4XKD1mwToVZjmu/9kyAYwmzjO+
	 pb4w1w0m1q+2coVZx2nU/MBOSzeeGlfRDlDf/ksBj/HE0FO2djsxwBA0/Vjk8RIUf
	 6r/uUq7VOqq+YacWI0zJegUQzQywF1ZK0XBZs1dKJqEvlPzDkQ0LZNBhHUPug9H6e
	 J4sLfF5h0EbRTzCtAg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.178.21] ([31.17.149.238]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mv2xO-1trUi51t3o-013DAD; Tue, 15
 Oct 2024 19:40:29 +0200
Message-ID: <058a6302-3444-4fd6-a154-b81f384b63fc@gmx.de>
Date: Tue, 15 Oct 2024 19:40:27 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] KVM: x86: Implement Hyper-V's vCPU suspended state
To: Sean Christopherson <seanjc@google.com>,
 Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: Nikolas Wipper <nikwip@amazon.de>,
 Nicolas Saenz Julienne <nsaenz@amazon.com>, Alexander Graf <graf@amazon.de>,
 James Gowans <jgowans@amazon.com>, nh-open-source@amazon.com,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org, x86@kernel.org, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20241004140810.34231-1-nikwip@amazon.de>
 <20241004140810.34231-3-nikwip@amazon.de> <875xq0gws8.fsf@redhat.com>
 <9ef935db-459a-4738-ab9a-4bd08828cb60@gmx.de> <87h69dg4og.fsf@redhat.com>
 <Zw6PlAv4H5rNZsBf@google.com>
Content-Language: en-US
From: Nikolas Wipper <nik.wipper@gmx.de>
In-Reply-To: <Zw6PlAv4H5rNZsBf@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1zivSonAStpSsGHYnVHMsVBmjEkzTINSYGgs2NWkcINg4tCsNj1
 zD6pHJyyMycO7tPbCrmYRPvHZBsHLXrbMdIPDtPrEmh6NRHrJzQ9srbdgt4C/pzAcHReUCA
 9AtL5uX5fa5ngHCA4lopdIp8snkr6j97Acx2dB32fcse67aWJMwFNUHEeNrIa95i9qXs61b
 +tpn+SO3uPZnE6R18/Ifw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:nh7tKxMnhz4=;u+7pxe8Y8xr80oAOr9EHe5NryU8
 4fmCVDEyChbl/2c2djCa3+9gd6EdLDVnc97bcboiAbVfG6ATKwdFF0ToJeVhzHj59M4+KrXuT
 iYiM3KF34S/OwnpwvYu0N+LZA4v/U2LOaCw3ppBEp2jrAZCT154D0MO4o0z4hi7lY89Z2wOyS
 saKrPRP981sd3CG9zfRPnuf2xhX8KdjpT58XYcdQ4j8YBckeP1aWrLpTy2aNZn9cUz5sLAIA8
 5Abi4VbrF//XlO3082Byd61i38iJXlvyMwxwLbhbrG0qQ6EH+stYj/8XSJKzlcUhnE7SEQvo9
 Hb27s838UHxPpSGxs6ZQlk4SrCnw3F04LJopXLi1tsyosa3FWuO8m6O8vhoQgokGeJ/XBzp1K
 np6RgNH929Sun9qjQInXR1Ew4F0BwukgSI/Fv52JL+IdKAp4f3wvHUkJrPFn9swK5jY0Zk+Xa
 M9hyaCdMn6JrV1x8aniwM7MUqHed+VJYVpXCMJvGpPkTBQM6GzWmr/DAIZ1VMOehRWSdTalc2
 4+gPGev58sLI997AK7PpxIb+LZN51AwrK2Mc52Wok6i7LQA3VmCFSym3dBqIahfAn51MZLbdr
 f8StLdbsn8UuAHHJZLMp+HL4fj0URNPK4iftIG6MSJF66GdX/l3+Kuv2LH9JM7NeC2jgYmkYd
 I7KWqjetyK9IVgLdLmVmck4rAsmGS4igNOV1T6Ywfmim5LZpHYdI22A4wMgG5aIXMILCLra92
 Z1ukVxJv1l0cyZsAHMkVcrouxLytAm4lR4yc73NwFC3XfB0V9WElxgELX8Dbjh7UPSuS6WoJQ
 1jm6gkkgVdUG4bkmEJshpqZA==

On 15.10.24 17:58, Sean Christopherson wrote:
> ...
>
> And from a performance perspective, synchronizing on kvm->srcu is going =
to be
> susceptible to random slowdowns, because writers will have to wait until=
 all vCPUs
> drop SRCU, even if they have nothing to do with PV TLB flushes.  E.g. if=
 vCPUs
> are faulting in memory from swap, uninhibiting a TLB flushes could be st=
alled
> unnecessarily for an extended duration.
>

This should be an easy fix, right? Just create an SRCU only for the TLB fl=
ushes only.

> Lastly, KVM_REQ_EVENT is a big hammer (triggers a lot of processing) and=
 semantically
> misleading (there is no event to process).  At a glance, KVM_REQ_UNBLOCK=
 is likely
> more appropriate.
>
> Before we spend too much time cleaning things up, I want to first settle=
 on the
> overall design, because it's not clear to me that punting HvTranslateVir=
tualAddress
> to userspace is a net positive.  We agreed that VTLs should be modeled p=
rimarily
> in userspace, but that doesn't automatically make punting everything to =
userspace
> the best option, especially given the discussion at KVM Forum with respe=
ct to
> mplementing VTLs, VMPLs, TD partitions, etc.
>

I wasn't at the discussion, so maybe I'm missing something, but the hyperc=
all
still needs VTL awareness. For one, it is primarily executed from VTL0 and
primarily targets VTL1 (primarily here means "thats what I see when I boot
Windows Server 2019"), so it would need to know which vCPU is the correspo=
nding
VTL (this assumes one vCPU per VTL, as in the QEMU implementation). To mak=
e
matters worse, the hypercall can also arbitrarily choose to target a diffe=
rent
VP. This would require a way to map (VP index, VTL) -> (vcpu_id) within KV=
M.

> The cover letters for this series and KVM_TRANSLATE2 simply say they're =
needed
> for HvTranslateVirtualAddress, but neither series nor Nicolas' patch to =
punt
> HVCALL_TRANSLATE_VIRTUAL_ADDRESS[*] justifies the split between userspac=
e and
> KVM.  And it very much is a split, because there are obviously a lot of =
details
> around TlbFlushInhibit that bleed into KVM.
>
> Side topic, what actually clears HvRegisterInterceptSuspend.TlbFlushInhi=
bit?  The
> TLFS just says
>
>   After the memory intercept routine performs instruction completion, it=
 should
>   clear the TlbFlushInhibit bit of the HvRegisterInterceptSuspend regist=
er.
>
> but I can't find anything that says _how_ it clears TlbFlushInhibit.
>

The register cannot be accessed using the HvSetVpRegisters hypercall, but =
the TLFS
talks about it elsewhere. I'm assuming this is a formatting issue (there a=
re a few
elsewhere). In 15.5.1.3 it says

  To unlock the TLB, the higher VTL can clear this bit. Also, once a VP re=
turns
  to a lower VTL, it releases all TLB locks which it holds at the time.

The QEMU implementation also just uninhibits on intercept exit, and that, =
at least,
does not crash.

Nikolas

