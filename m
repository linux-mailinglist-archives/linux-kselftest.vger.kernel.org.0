Return-Path: <linux-kselftest+bounces-21797-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CE1F9C4554
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Nov 2024 19:53:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C8ED2810AF
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Nov 2024 18:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52F9F178368;
	Mon, 11 Nov 2024 18:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QIBs8QBY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB6A1ADFE8
	for <linux-kselftest@vger.kernel.org>; Mon, 11 Nov 2024 18:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731350976; cv=none; b=KTFPDYDWGqA5r6qC3iPJu3XRMiU1YeK6d9D0rUibACFpsLhL/Ci2CftYLtCyjN6SnQ56aV7xfwx+wbuQYk4JtBhslqWOyZaUTKzLCEIXG/MGZHhUnUudigL9vCtdCQUHJhYyJE3KL/1/1GnAL48QNHKK6JsmexsJoGhf36zRvg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731350976; c=relaxed/simple;
	bh=vmqvMMlYZbRYRYpVz0+HMgCuMUW6n5MeHUAax6tFUdU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t85nF6gepv4W42z1jHOdof0P8ykcyJNT7N+Ym4LWyjwAv1zxdQpgN3c9FoNAQtIaqkIm2WyzqAvRJG8yvtoJVqvdX0QQPBHAiTi+ZxDakk9hwnkKF4WniKscjclkLI/B6u1+vzg03BLVERavDPEMlj2FeMbqN8BCBNHVucbzdi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QIBs8QBY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731350973;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=sRgpTcRh/sWqL8fC18qdS0cRcwsz13IiRQs+/0nN2yA=;
	b=QIBs8QBYHqbtsrLa1RuO4YcBJNYfX65cdgcjPQ3b0awwfNr0VMQKzcU+ClbME3hnlWl4m4
	MkvgSQdPneyXRQdM2ckOcfx8mTB98B+MsT3tT1ZQUjYMrkFZ+V7E0SrXVREQ8o6L8HI1Wg
	jyTDEiJ981FE+B+JhcCSNVimhREuxfU=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-45-0hSXtgt3OhSE0XghMC9oNA-1; Mon, 11 Nov 2024 13:49:32 -0500
X-MC-Unique: 0hSXtgt3OhSE0XghMC9oNA-1
X-Mimecast-MFC-AGG-ID: 0hSXtgt3OhSE0XghMC9oNA
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a9a1b872d8bso374075266b.1
        for <linux-kselftest@vger.kernel.org>; Mon, 11 Nov 2024 10:49:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731350971; x=1731955771;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sRgpTcRh/sWqL8fC18qdS0cRcwsz13IiRQs+/0nN2yA=;
        b=HAou//Cfi+E+hMDBW6HHvbJOP5KDiu0x/+VRMNBibrDuoRN9tQujw7y30VQrdM92An
         Datf9CO3XpW+a8Ndtbd7EDvc6bzdanJ5wVtZu/PZA/qtFHOn1Xi/vY3S8DRnIahTMj4A
         wvJ98MfBbQC2o//DQmTKF0vZC5ZV79K1V9hClKg5Z3L9uIa8m9ABabBXS8c/t51MbTjP
         cl2CRI5TDPbxKAZWFxdFn6VGHIUQ/6Vouo37+O1UpK8BorcdcEnbEupa5iYm7lgJTihC
         ISJd7jCXNgjE1hIGtov6752pH4rsdnLx8HYGtnQZ5I52NHaUFj3VEnLoj5TUtqwhcRmR
         NdaA==
X-Forwarded-Encrypted: i=1; AJvYcCXsgGDEbtbhgk9IaZNoPV9LnT9Q1DFdla5XIy68+lTDTEDGcF6zlZWkghcAu2zw90ck8tl+NrVxzfwdDVJrSx8=@vger.kernel.org
X-Gm-Message-State: AOJu0YymS4WPXiBJ1YEI0tSlZL24UCxEenH6KAyf8RFFhl5MY46IaLmm
	ulzE7DhdCqFlvWKiLiNy59ckgsWKgg2R5beDaQ6x1uFcL11w43D03T51ww70aq1ve5RmWr9TL54
	NN55FHLb4EEv45/8CjII8e2S90fqRAu1kYV/8nlqJzm4ugszb8G9g5+K6Uwql/CIC/w==
X-Received: by 2002:a17:907:86a9:b0:a9a:183a:b84e with SMTP id a640c23a62f3a-a9eeffe9e07mr1366625866b.40.1731350970738;
        Mon, 11 Nov 2024 10:49:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFRB5mUKwnTh/Ish/I5bDvt5zkTOW/ynBhRbC+M/vMDzXxCphKshJrwxBicGk5x8P73OyHB+A==
X-Received: by 2002:a17:907:86a9:b0:a9a:183a:b84e with SMTP id a640c23a62f3a-a9eeffe9e07mr1366622266b.40.1731350970249;
        Mon, 11 Nov 2024 10:49:30 -0800 (PST)
Received: from [192.168.10.47] ([151.49.84.243])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-a9ee0a43967sm615792366b.44.2024.11.11.10.49.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Nov 2024 10:49:29 -0800 (PST)
Message-ID: <c3026876-8061-4ab2-9321-97cc05bad510@redhat.com>
Date: Mon, 11 Nov 2024 19:49:26 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] KVM: x86: Add support for VMware guest specific
 hypercalls
To: Doug Covelli <doug.covelli@broadcom.com>
Cc: Zack Rusin <zack.rusin@broadcom.com>,
 Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org,
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
 <e3f943a7-a40a-45cb-b0d9-e3ed58344d8b@redhat.com>
 <CADH9ctD1uf_yBA3NXNQu7TJa_TPhLRN=0YZ3j2gGhgmaFRdCFg@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 xsEhBFRCcBIBDqDGsz4K0zZun3jh+U6Z9wNGLKQ0kSFyjN38gMqU1SfP+TUNQepFHb/Gc0E2
 CxXPkIBTvYY+ZPkoTh5xF9oS1jqI8iRLzouzF8yXs3QjQIZ2SfuCxSVwlV65jotcjD2FTN04
 hVopm9llFijNZpVIOGUTqzM4U55sdsCcZUluWM6x4HSOdw5F5Utxfp1wOjD/v92Lrax0hjiX
 DResHSt48q+8FrZzY+AUbkUS+Jm34qjswdrgsC5uxeVcLkBgWLmov2kMaMROT0YmFY6A3m1S
 P/kXmHDXxhe23gKb3dgwxUTpENDBGcfEzrzilWueOeUWiOcWuFOed/C3SyijBx3Av/lbCsHU
 Vx6pMycNTdzU1BuAroB+Y3mNEuW56Yd44jlInzG2UOwt9XjjdKkJZ1g0P9dwptwLEgTEd3Fo
 UdhAQyRXGYO8oROiuh+RZ1lXp6AQ4ZjoyH8WLfTLf5g1EKCTc4C1sy1vQSdzIRu3rBIjAvnC
 tGZADei1IExLqB3uzXKzZ1BZ+Z8hnt2og9hb7H0y8diYfEk2w3R7wEr+Ehk5NQsT2MPI2QBd
 wEv1/Aj1DgUHZAHzG1QN9S8wNWQ6K9DqHZTBnI1hUlkp22zCSHK/6FwUCuYp1zcAEQEAAc0j
 UGFvbG8gQm9uemluaSA8cGJvbnppbmlAcmVkaGF0LmNvbT7CwU0EEwECACMFAlRCcBICGwMH
 CwkIBwMCAQYVCAIJCgsEFgIDAQIeAQIXgAAKCRB+FRAMzTZpsbceDp9IIN6BIA0Ol7MoB15E
 11kRz/ewzryFY54tQlMnd4xxfH8MTQ/mm9I482YoSwPMdcWFAKnUX6Yo30tbLiNB8hzaHeRj
 jx12K+ptqYbg+cevgOtbLAlL9kNgLLcsGqC2829jBCUTVeMSZDrzS97ole/YEez2qFpPnTV0
 VrRWClWVfYh+JfzpXmgyhbkuwUxNFk421s4Ajp3d8nPPFUGgBG5HOxzkAm7xb1cjAuJ+oi/K
 CHfkuN+fLZl/u3E/fw7vvOESApLU5o0icVXeakfSz0LsygEnekDbxPnE5af/9FEkXJD5EoYG
 SEahaEtgNrR4qsyxyAGYgZlS70vkSSYJ+iT2rrwEiDlo31MzRo6Ba2FfHBSJ7lcYdPT7bbk9
 AO3hlNMhNdUhoQv7M5HsnqZ6unvSHOKmReNaS9egAGdRN0/GPDWr9wroyJ65ZNQsHl9nXBqE
 AukZNr5oJO5vxrYiAuuTSd6UI/xFkjtkzltG3mw5ao2bBpk/V/YuePrJsnPFHG7NhizrxttB
 nTuOSCMo45pfHQ+XYd5K1+Cv/NzZFNWscm5htJ0HznY+oOsZvHTyGz3v91pn51dkRYN0otqr
 bQ4tlFFuVjArBZcapSIe6NV8C4cEiSTOwE0EVEJx7gEIAMeHcVzuv2bp9HlWDp6+RkZe+vtl
 KwAHplb/WH59j2wyG8V6i33+6MlSSJMOFnYUCCL77bucx9uImI5nX24PIlqT+zasVEEVGSRF
 m8dgkcJDB7Tps0IkNrUi4yof3B3shR+vMY3i3Ip0e41zKx0CvlAhMOo6otaHmcxr35sWq1Jk
 tLkbn3wG+fPQCVudJJECvVQ//UAthSSEklA50QtD2sBkmQ14ZryEyTHQ+E42K3j2IUmOLriF
 dNr9NvE1QGmGyIcbw2NIVEBOK/GWxkS5+dmxM2iD4Jdaf2nSn3jlHjEXoPwpMs0KZsgdU0pP
 JQzMUMwmB1wM8JxovFlPYrhNT9MAEQEAAcLBMwQYAQIACQUCVEJx7gIbDAAKCRB+FRAMzTZp
 sadRDqCctLmYICZu4GSnie4lKXl+HqlLanpVMOoFNnWs9oRP47MbE2wv8OaYh5pNR9VVgyhD
 OG0AU7oidG36OeUlrFDTfnPYYSF/mPCxHttosyt8O5kabxnIPv2URuAxDByz+iVbL+RjKaGM
 GDph56ZTswlx75nZVtIukqzLAQ5fa8OALSGum0cFi4ptZUOhDNz1onz61klD6z3MODi0sBZN
 Aj6guB2L/+2ZwElZEeRBERRd/uommlYuToAXfNRdUwrwl9gRMiA0WSyTb190zneRRDfpSK5d
 usXnM/O+kr3Dm+Ui+UioPf6wgbn3T0o6I5BhVhs4h4hWmIW7iNhPjX1iybXfmb1gAFfjtHfL
 xRUr64svXpyfJMScIQtBAm0ihWPltXkyITA92ngCmPdHa6M1hMh4RDX+Jf1fiWubzp1voAg0
 JBrdmNZSQDz0iKmSrx8xkoXYfA3bgtFN8WJH2xgFL28XnqY4M6dLhJwV3z08tPSRqYFm4NMP
 dRsn0/7oymhneL8RthIvjDDQ5ktUjMe8LtHr70OZE/TT88qvEdhiIVUogHdo4qBrk41+gGQh
 b906Dudw5YhTJFU3nC6bbF2nrLlB4C/XSiH76ZvqzV0Z/cAMBo5NF/w=
In-Reply-To: <CADH9ctD1uf_yBA3NXNQu7TJa_TPhLRN=0YZ3j2gGhgmaFRdCFg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/9/24 22:11, Doug Covelli wrote:
> On Sat, Nov 9, 2024 at 1:20 PM Paolo Bonzini <pbonzini@redhat.com> wrote:
>> On 11/8/24 06:03, Zack Rusin wrote:
>>>>> There's no spec but we have open headers listing the hypercalls.
>>>>> There's about a 100 of them (a few were deprecated), the full
>>>>> list starts here:
>>>>> https://github.com/vmware/open-vm-tools/blob/739c5a2f4bfd4cdda491e6a6f6869d88c0bd6972/open-vm-tools/lib/include/backdoor_def.h#L97
>>>>> They're not well documented, but the names are pretty self-explenatory.
>>>>
>>>> At a quick glance, this one needs to be handled in KVM:
>>>>
>>>>     BDOOR_CMD_VCPU_MMIO_HONORS_PAT
>>>>
>>>> and these probably should be in KVM:
>>>>
>>>>     BDOOR_CMD_GETTIME
>>>>     BDOOR_CMD_SIDT
>>>>     BDOOR_CMD_SGDT
>>>>     BDOOR_CMD_SLDT_STR
>>>>     BDOOR_CMD_GETTIMEFULL
>>>>     BDOOR_CMD_VCPU_LEGACY_X2APIC_OK
>>>>     BDOOR_CMD_STEALCLOCK
>>>
>>> I'm not sure if there's any value in implementing a few of them.
>>
>> The value is that some of these depend on what the hypervisor does, not
>> on what userspace does.  For Hypervisor.framework you have a lot of
>> leeway, for KVM and Hyper-V less so. [..] From the KVM maintainers'
>> point of view, the feature you're adding might be used by others and
>> not just VMware Workstation.  Microsoft and Apple might see things
>> differently (Apple in particular has a much thinner wrapper around
>> the processor's virtualization capbilities).
> 
> [...]
>
> the SGDT/SLDT/STR/SIDT backdoor calls these were added > 20
> years ago for SW that used these instructions from CPL3 which did not
> work well before VT/SVM were introduced.  These are really of no use
> on modern CPUs and will be blocked if the guest OS has enabled UMIP.
> [...]
> 
> For stolen time the backdoor call is [...] currently
> really only supported by ESX (and only currently used by Photon OS) so
> I don't think adding that support to KVM is critical.

Sounds good.  All I want is ensuring that someone with access to the 
spec did the exercise.

Still guessing, but for MMIO_HONORS_PAT we probably want to add a 
separate KVM_CHECK_EXTENSION capability.

Is BDOOR_CMD_VCPU_LEGACY_X2APIC_OK something where you can just return a 
constant?

This leaves just GETTIME and GETTIMEFULL.  If four hypercalls require 
some care in the hypervisor (which may or may not be an in-kernel 
implementation), that's not bad.  Can you share a bit more about these four?

>> Anyway, one question apart from this: is the API the same for the I/O
>> port and hypercall backdoors?
> 
> Yeah the calls and arguments are the same.  The hypercall based
> interface is an attempt to modernize the backdoor since as you pointed
> out the I/O based interface is kind of hacky as it bypasses the normal
> checks for an I/O port access at CPL3.  It would be nice to get rid of
> it but unfortunately I don't think that will happen in the foreseeable
> future as there are a lot of existing VMs out there with older SW that
> still uses this interface.

Yeah, but I think it still justifies that the KVM_ENABLE_CAP API can 
enable the hypercall but not the I/O port.

Paolo


