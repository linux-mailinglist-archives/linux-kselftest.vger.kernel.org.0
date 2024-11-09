Return-Path: <linux-kselftest+bounces-21729-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D0F59C2F07
	for <lists+linux-kselftest@lfdr.de>; Sat,  9 Nov 2024 19:21:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABB051F218FB
	for <lists+linux-kselftest@lfdr.de>; Sat,  9 Nov 2024 18:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24CD119F127;
	Sat,  9 Nov 2024 18:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EwrGPzN4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C01229CF4
	for <linux-kselftest@vger.kernel.org>; Sat,  9 Nov 2024 18:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731176456; cv=none; b=Xjxqf2Ke1wcQiUfQG5YJ0mhEx2bk0xbjSxSJzkBPHwz4eZZ68hwRZ746hA7XHTCpED2H8ydq5K12elQwPjj7GKSE6B4w/yE26+a69SKlX7BHh1D8DxtJ9633ZJFw9zB2aqKvxnZIJNaxrxrdXeJiQTmHhmWFBDyIN8UT8P1hRkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731176456; c=relaxed/simple;
	bh=YCMwbpsFyRLAdV/bw10MildrjIRT4dIrC9ujwxX7bXA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NLUaynLRRkTyEWPEr28n7uWm2T14FhIiWmzZXGNUtGPKVezwysC1BZ0m8yrGmHls1gW5dk49IZpEa1DVnnIHqcFnQtUxGtvyudsGX/m5HYAJmgfsD7rzf918lKtN2OJ0YAgRxEW0YHQDttCtdDXzVR52lHz6SD/81IPKtFHLOXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EwrGPzN4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731176452;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=/cEcWgbcH3Td+fgTFflN55jyWC3FiR+ZVdjGy0yqdFI=;
	b=EwrGPzN44LKCRk2J7zEE6tcgw8XpZQjdKVpSjYcWBWw01J7NDxnespRBeyQatj+UKc+rwY
	boFjwpdmmYY9wWwAhJ88DHQB8dQi1VKPWMNntrz3vra3XYWsVlrJfcbUGBEjATIrx+Yfmn
	ALBpg1SeGJrS98ZjscPiWIG0IWBTnVo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-582-euwjw-n_NZu6Q3y0VwNT_g-1; Sat, 09 Nov 2024 13:20:51 -0500
X-MC-Unique: euwjw-n_NZu6Q3y0VwNT_g-1
X-Mimecast-MFC-AGG-ID: euwjw-n_NZu6Q3y0VwNT_g
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4314c6ca114so24181045e9.1
        for <linux-kselftest@vger.kernel.org>; Sat, 09 Nov 2024 10:20:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731176450; x=1731781250;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/cEcWgbcH3Td+fgTFflN55jyWC3FiR+ZVdjGy0yqdFI=;
        b=g68mhMpVV8FmXtWfoxDpy5ZX+OC9ZMwI0RbCkf/iLxBFI144Debkv6B4h7Qu9Z06Dl
         HhohQj3ESBXixuzJRpO9KLKIXHgWlt61s61abvyM6WUqY49bzxyB4p7SBvnsaOdF0tGy
         57TbUG7+KG1ZZ84SjOAF0rt72IiCIJBOOvCfohxJsZ6rNZocTMM0TdPa+ihnpb5ryQgc
         m7u4w4Va5kDa5BWmCKqrLtq2VLQU2b7DmX8a/DdXbgmUHfQ3ZWhWskODParJSkaGK820
         uBCdaqmMIpRYXJD7s00+aLDcgu8USnuPSy1ljReDoLY95Q+Pws9qRhPxPBwb3xxD0v43
         Q+Ng==
X-Forwarded-Encrypted: i=1; AJvYcCXsvy/wrPepwova/zGqnB4kYxJEUKSNM+bpM5R56qBwFdHdzfLku+A1G3UIbQpYPix6Gazd6K7JNehu9rr4zJs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKaF3UZWVWm87X78YIcJGpSp7Bc2S31cYQujIbUjeUBTg1fz/F
	WECSwVf6draYmVsoB4WhcGu+kbbwPG0VvROB3gP5nN3Ut6Qz86+6dUTSMuQZZe6oNvQCogemZIf
	bKGUxO1apaUoUPoxg8L0jhbW85dSpUfwI5nFhbR3lD79bTwnl+NmPQRNncNn8tZMl/A==
X-Received: by 2002:a05:600c:40c4:b0:42f:4f6:f8bc with SMTP id 5b1f17b1804b1-432bb9b0f81mr43198165e9.9.1731176449752;
        Sat, 09 Nov 2024 10:20:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFubGlLMdjd2I3mx7KYYfgMPITOIb/JRV/spZbe/6nKuqaW2CVUVRFUH6zUq4al1k6l/DrkZQ==
X-Received: by 2002:a05:600c:40c4:b0:42f:4f6:f8bc with SMTP id 5b1f17b1804b1-432bb9b0f81mr43197985e9.9.1731176449292;
        Sat, 09 Nov 2024 10:20:49 -0800 (PST)
Received: from [192.168.10.3] ([151.49.84.243])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-381ed97e4d2sm8398626f8f.32.2024.11.09.10.20.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Nov 2024 10:20:48 -0800 (PST)
Message-ID: <e3f943a7-a40a-45cb-b0d9-e3ed58344d8b@redhat.com>
Date: Sat, 9 Nov 2024 19:20:46 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] KVM: x86: Add support for VMware guest specific
 hypercalls
To: Zack Rusin <zack.rusin@broadcom.com>,
 Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, Doug Covelli <doug.covelli@broadcom.com>,
 Jonathan Corbet <corbet@lwn.net>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, Shuah Khan <shuah@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>,
 Arnaldo Carvalho de Melo <acme@redhat.com>,
 Isaku Yamahata <isaku.yamahata@intel.com>, Joel Stanley <joel@jms.id.au>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20241030033514.1728937-1-zack.rusin@broadcom.com>
 <20241030033514.1728937-3-zack.rusin@broadcom.com>
 <CABgObfaRP6zKNhrO8_atGDLcHs=uvE0aT8cPKnt_vNHHM+8Nxg@mail.gmail.com>
 <CABQX2QMR=Nsn23zojFdhemR7tvGUz6_UM8Rgf6WLsxwDqoFtxg@mail.gmail.com>
 <Zy0__5YB9F5d0eZn@google.com>
 <CABQX2QNxFDhH1frsGpSQjSs3AWSdTibkxPrjq1QC7FGZC8Go-Q@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <CABQX2QNxFDhH1frsGpSQjSs3AWSdTibkxPrjq1QC7FGZC8Go-Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/8/24 06:03, Zack Rusin wrote:
>>> There's no spec but we have open headers listing the hypercalls.
>>> There's about a 100 of them (a few were deprecated), the full
>>> list starts here:
>>> https://github.com/vmware/open-vm-tools/blob/739c5a2f4bfd4cdda491e6a6f6869d88c0bd6972/open-vm-tools/lib/include/backdoor_def.h#L97
>>> They're not well documented, but the names are pretty self-explenatory.
>>
>> At a quick glance, this one needs to be handled in KVM:
>>
>>    BDOOR_CMD_VCPU_MMIO_HONORS_PAT
>>
>> and these probably should be in KVM:
>>
>>    BDOOR_CMD_GETTIME
>>    BDOOR_CMD_SIDT
>>    BDOOR_CMD_SGDT
>>    BDOOR_CMD_SLDT_STR
>>    BDOOR_CMD_GETTIMEFULL
>>    BDOOR_CMD_VCPU_LEGACY_X2APIC_OK
>>    BDOOR_CMD_STEALCLOCK
>
> I'm not sure if there's any value in implementing a few of them.

The value is that some of these depend on what the hypervisor does, not 
on what userspace does.  For Hypervisor.framework you have a lot of 
leeway, for KVM and Hyper-V less so.

Please understand that adding support for a closed spec is already a bit 
of a tall ask.  We can meet in the middle and make up for the 
closedness, but the way to do it is not technical; it's essentially 
trust.  You are the guys that know the spec and the userspace code best, 
so we trust you to make choices that make technical sense for both KVM 
and VMware.  But without a spec we even have to trust you on what makes 
sense or not to have in the kernel, so we ask you to be... honest about 
that.

One important point is that from the KVM maintainers' point of view, the 
feature you're adding might be used by others and not just VMware 
Workstation.  Microsoft and Apple might see things differently (Apple in 
particular has a much thinner wrapper around the processor's 
virtualization capbilities).

> iirc
> there's 101 of them (as I mentioned a lot have been deprecated but
> that's for userspace, on the host we still have to do something for
> old guests using them) and, if out of those 101 we implement 100 in
> the kernel then, as far as this patch is concerned, it's no different
> than if we had 0 out of 101 because we're still going to have to exit
> to userspace to handle that 1 remaining.
> 
> Unless you're saying that those would be useful to you. In which case
> I'd be glad to implement them for you, but I'd put them behind some
> kind of a cap or a kernel config because we wouldn't be using them -

Actually we'd ask you to _not_ put them behind a cap, and live with the 
kernel implementation.  Obviously that's not a requirement for all the 
100+ hypercalls, only for those where it makes sense.

> besides what Doug mentioned - we already maintain the shared code for
> them that's used on Windows, MacOS, ESX and Linux so even if we had
> them in the Linux kernel it would still make more sense to use the
> code that's shared with the other OSes to lessen the maintenance
> burden (so that changing anything within that code consistently
> changes across all the OSes).

If some of them can have shared code across all OSes, then that's a good 
sign that they do not belong in the kernel.  On the other hand, if the 
code is specific to Windows/macOS/ESX/Linux, and maybe it even calls 
into low-level Hypervisor.framework APIs on macOS, then it's possible or 
even likely that the best implementation for Linux is "just assume that 
KVM will do it" and assert(0).

In yet other cases (maybe those SGDT/SLDT/STR/SIDT ones??), if the code 
that you have for Linux is "just do this KVM ioctl to do it", it may 
provide better performance if you save the roundtrip to userspace and 
back.  If KVM is the best performing hypervisor for VMware Workstation, 
then we're happy, :) and if you have some performance issue we want to 
help you too.

A related topic is that a good implementation, equivalent to what the 
proprietary hypervisor implemented, might require adding a ioctl to 
query something that KVM currently does not provide (maybe the current 
steal clock? IIRC it's only available via a Xen ioctl, not a generic 
one).  In that case you'd need to contribute that extra API.  Doing that 
now is easier for both you guys and the KVM maintainers, so that's 
another reason to go through the list and share your findings.

Anyway, one question apart from this: is the API the same for the I/O 
port and hypercall backdoors?

>> I don't think it addresses Paolo's concern (if I understood Paolo's concern
>> correctly), but it would help from the perspective of allowing KVM to support
>> VMware hypercalls and Xen/Hyper-V/KVM hypercalls in the same VM.
> 
> Yea, I just don't think there's any realistic way we could handle all
> of those hypercalls in the kernel so I'm trying to offer some ideas on
> how to lessen the scope to make it as painless as possible. Unless you
> think we could somehow parlay my piercing blue eyes into getting those
> patches in as is, in which case let's do that ;)

Unlikely :) but it's not in bad shape at all!  The main remaining 
discussion point is the subset of hypercalls that need support in the 
kernel (either as a kernel implementation, or as a new ioctl). 
Hopefully the above guidelines will help you.

>> I also think we should add CONFIG_KVM_VMWARE from the get-go, and if we're feeling
>> lucky, maybe even retroactively bury KVM_CAP_X86_VMWARE_BACKDOOR behind that
>> Kconfig.  That would allow limiting the exposure to VMware specific code, e.g. if
>> KVM does end up handling hypercalls in-kernel.  And it might deter abuse to some
>> extent.
> 
> I thought about that too. I was worried that even if we make it on by
> default it will require quite a bit of handholding to make sure all
> the distros include it, or otherwise on desktops Workstation still
> wouldn't work with KVM by default, I also felt a little silly trying
> to add a kernel config for those few lines that would be on pretty
> much everywhere and since we didn't implement the vmware backdoor
> functionality I didn't want to presume and try to shield a feature
> that might be in production by others with a new kernel config.
We don't have a huge number of such knobs but based on experience I 
expect that it will be turned off only by cloud providers or appliance 
manufacturers that want to reduce the attack surface.  If it's enabled 
by default, distros will generally leave it on.  You can also add "If 
unsure, say Y" to the help message as we already do in several cases.(*)

In fact, if someone wants to turn it off, they will send the patch 
themselves to add CONFIG_KVM_VMWARE and it will be accepted.  So we 
might as well ask for it from the start. :)

Thanks,

Paolo

(*) In fact I am wondering if we should flip the default for Xen, in the 
beginning it was just an Amazon thing but since then David has 
contributed support in QEMU and CI.  To be clear, I am *not* asking 
VMware for anything but selftests to make CONFIG_KVM_VMWARE default to 
enabled.


