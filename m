Return-Path: <linux-kselftest+bounces-37867-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 183D2B0ED0E
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Jul 2025 10:21:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E75E67B3B97
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Jul 2025 08:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04E9E279DB5;
	Wed, 23 Jul 2025 08:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZeM2Gzb7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D7C42798F0
	for <linux-kselftest@vger.kernel.org>; Wed, 23 Jul 2025 08:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753258839; cv=none; b=fgnABpEA9pAUREXLjP3Yz3EvehqpcorLPA8vZEsNF/iLjIMiKEZjr87E3ebIpmr2qPSBA1pIqMSec/0joBp0jJmHWYPF9EMpANm9QLbDQypetreTFJ9uh8HgR6T/eRnSaPkdoD0hBmf1z4wDAcpCHT1MtmNfQnrXNV5jc7DlsnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753258839; c=relaxed/simple;
	bh=hsczvWWZZK+zZzVF7FiOuyFbg4D8AetCUGPHyHYX1wY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P/b3hDdmTB/iAVrs6n5w9RfdckVLwzyuTO8spQ5KV8ki5J/QZe6x+ZspqRqsANYDB0pzddiZPkQVofp8E+hFR90h3r6hHDf5CuPDmYnyYLy/yepXFlQmLSWlS4693nVm14KFDOL+YVqqthqTtQs1Pf4+dEqiKXp48vR74MrsPkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZeM2Gzb7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753258837;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ArrbP6ULmISQTAdQsbfYfBJ/dfwnESI5dLXQURXYbWQ=;
	b=ZeM2Gzb79SjUckNly7CfOFvAjReMMKT/e1iqf0P+aBDYH3MUBdNzblCz2ud+dqn0gxNVd3
	vvKpu5M9q9zaV8++nNftE0UFRVGoIjCKpd7MsKxLYXPxTG7rETOvcBtJVgBxwEhiaxs9jZ
	QBnN2lfjDgtKB8DKvA5HPIi6rb74lVY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-474-58sLPuFtNbOxN3mOiTgMgg-1; Wed, 23 Jul 2025 04:20:35 -0400
X-MC-Unique: 58sLPuFtNbOxN3mOiTgMgg-1
X-Mimecast-MFC-AGG-ID: 58sLPuFtNbOxN3mOiTgMgg_1753258835
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3a4fabcafecso2965761f8f.0
        for <linux-kselftest@vger.kernel.org>; Wed, 23 Jul 2025 01:20:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753258834; x=1753863634;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ArrbP6ULmISQTAdQsbfYfBJ/dfwnESI5dLXQURXYbWQ=;
        b=JOPhhoB9gLFOkzQbmQFsg186TLPfd6lHsR4Gigq8Dr8FVEuXXkjW1v727WdDhgr+z5
         m7W8H3HHaMLz9SHUbSMzVcCcn1YVJ893qSM14gEeHvNt6t1ET6YcTNBgIApVd9GndvmT
         IfxVGEe0RFipOBO9O9TqjdQP+OJcLXeS4m5hT8eMvnYGVBpufm3o924ByxRROG5Qvt1O
         yEpO8NqMBiJhfQ0KO5KknEV086DaYUTK7GCU62Rl0ECwXUP/Tek5B00SIHtPzyM0BNA3
         uQ+XrfYrlWFmo5LvLeX0jELrRBPb4ByySJDQXU/aZ1fFfns88f8gFpyUz590tZh94rX2
         EIoA==
X-Forwarded-Encrypted: i=1; AJvYcCXgCZwS1c8xIisQKfAifMIoPBjuqDVzdDlZvCyf3XxM9fv9vc/hzUiMbrQuiRhdk9+8/gJCfpO18j/E5lx5tfI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnuofswiXqtPIr6mpunS0PyCPxVtngjicmXJiKu0M0T4tXPF6J
	dwT7neCj6qtNaY1koU5ItVtycb6o5WutwAA5IMp6s11+mj8hozyI2YUxQ0hGFF4ieK1EOdB+8sl
	aFxJrUkthJ4YNRESxwENi3pdSVKSwPWCFWWwn6PQ16qEV0l/17BK5s1qKoXNLV7l7VVjnQQ==
X-Gm-Gg: ASbGncvANNCrfOqmU5MvfSMdQbU6VX182F3ivHGN/dYlvOLT9CYzNBd/xWvv3SY3MYn
	nhgS0qKDa4Ioysf9dP81ue/s5nV2p4pXmum/gsVauKczCRxDEBDBQYkkMw6luJprdRUM8qeTKpU
	ad8a3XHjN8l0epl+YAglHx+bGC6MqMZmlZoGHdJp2TGVyGYX24Nn6q5MVS7sNOK/OPP5lBC1Nfc
	1JwlrIMV48zEErMEDC5JjbRvpeQpFfvbknfp4/0UjWn0vt9dLNelajJcLEv+DUqp4UgIjgJZvgY
	lY6bJ3Wn0lkFzehryyKZlNBBhorfJIkDa4eJCAa8W2Xnu3t1v+U7UuJie6tFgez3aME44fKQMY+
	vywCjaS8IpkWnESZF6nHL0X1EYXPOZecFlEPfC0LlPUgkyLcvc6j2XXoLdQOk0kMQFl8=
X-Received: by 2002:a05:6000:2088:b0:3b5:e6f2:ab4d with SMTP id ffacd0b85a97d-3b768f0784amr1449503f8f.42.1753258834371;
        Wed, 23 Jul 2025 01:20:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGuehv3n5C5mV94SzfgBIwheXZpqlCTL4RcfpQFRxJyOhldB5Jf2Jv2Nn3bHC1HmTGXwVtUSw==
X-Received: by 2002:a05:6000:2088:b0:3b5:e6f2:ab4d with SMTP id ffacd0b85a97d-3b768f0784amr1449465f8f.42.1753258833789;
        Wed, 23 Jul 2025 01:20:33 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f00:4000:a438:1541:1da1:723a? (p200300d82f004000a43815411da1723a.dip0.t-ipconnect.de. [2003:d8:2f00:4000:a438:1541:1da1:723a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b76773a0e3sm2532813f8f.17.2025.07.23.01.20.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Jul 2025 01:20:33 -0700 (PDT)
Message-ID: <42146bb2-c017-43dd-aee2-1f1a893d3b17@redhat.com>
Date: Wed, 23 Jul 2025 10:20:30 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V9 0/7] Add NUMA mempolicy support for KVM guest-memfd
To: Sean Christopherson <seanjc@google.com>
Cc: Shivank Garg <shivankg@amd.com>, vbabka@suse.cz, willy@infradead.org,
 akpm@linux-foundation.org, shuah@kernel.org, pbonzini@redhat.com,
 brauner@kernel.org, viro@zeniv.linux.org.uk, ackerleytng@google.com,
 paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com, pvorel@suse.cz,
 bfoster@redhat.com, tabba@google.com, vannapurve@google.com,
 chao.gao@intel.com, bharata@amd.com, nikunj@amd.com, michael.day@amd.com,
 shdhiman@amd.com, yan.y.zhao@intel.com, Neeraj.Upadhyay@amd.com,
 thomas.lendacky@amd.com, michael.roth@amd.com, aik@amd.com, jgg@nvidia.com,
 kalyazin@amazon.com, peterx@redhat.com, jack@suse.cz, rppt@kernel.org,
 hch@infradead.org, cgzones@googlemail.com, ira.weiny@intel.com,
 rientjes@google.com, roypat@amazon.co.uk, ziy@nvidia.com,
 matthew.brost@intel.com, joshua.hahnjy@gmail.com, rakie.kim@sk.com,
 byungchul@sk.com, gourry@gourry.net, kent.overstreet@linux.dev,
 ying.huang@linux.alibaba.com, apopple@nvidia.com, chao.p.peng@intel.com,
 amit@infradead.org, ddutile@redhat.com, dan.j.williams@intel.com,
 ashish.kalra@amd.com, gshan@redhat.com, jgowans@amazon.com,
 pankaj.gupta@amd.com, papaluri@amd.com, yuzhao@google.com,
 suzuki.poulose@arm.com, quic_eberman@quicinc.com,
 aneeshkumar.kizhakeveetil@arm.com, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-security-module@vger.kernel.org, kvm@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-coco@lists.linux.dev
References: <20250713174339.13981-2-shivankg@amd.com>
 <bdce1a12-ab73-4de1-892b-f8e849a8ab51@redhat.com>
 <aH-j8bOXMfOKdpHp@google.com>
 <80a047e2-e0fb-40cd-bb88-cce05ca017ac@redhat.com>
 <aIAZtgtdy5Fw1OOi@google.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <aIAZtgtdy5Fw1OOi@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 23.07.25 01:07, Sean Christopherson wrote:
> On Tue, Jul 22, 2025, David Hildenbrand wrote:
>> On 22.07.25 16:45, Sean Christopherson wrote:
>>> On Tue, Jul 22, 2025, David Hildenbrand wrote:
>>>> Just to clarify: this is based on Fuad's stage 1 and should probably still be
>>>> tagged "RFC" until stage-1 is finally upstream.
>>>>
>>>> (I was hoping stage-1 would go upstream in 6.17, but I am not sure yet if that is
>>>> still feasible looking at the never-ending review)
>>>
>>> 6.17 is very doable.
>>
>> I like your optimism :)
> 
> I'm not optimistic, just incompetent.

Well, I wouldn't agree with that :)

> I forgot what kernel we're on.  **6.18**
> is very doable, 6.17 not so much.

Yes, probably best to target 6.18 than rushing this into the upcoming MR.

-- 
Cheers,

David / dhildenb


