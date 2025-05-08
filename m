Return-Path: <linux-kselftest+bounces-32661-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 48F80AAFE91
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 May 2025 17:12:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0399C7BE85D
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 May 2025 15:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58A732868A5;
	Thu,  8 May 2025 15:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NfLBT26c"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B26CE27A441
	for <linux-kselftest@vger.kernel.org>; Thu,  8 May 2025 15:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746716807; cv=none; b=Bm7joXlCNBvo3IWvcA08sPXrtM8T4/WvBz7PiEUeS1Ml+JEPA5tTYF76NwyzSjsyPX0DGGpfsPGjTRvDubWzmwY6FE+lcK5BvNFZBcGJxxC5DS8ffBOyDcj65HjnWvz9FNrb4+ZAawgDaGMUbEfpblaFVMAyxylShANjHGxd0sM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746716807; c=relaxed/simple;
	bh=0SRez/e73G2FWCDWOJtPCRgCBM6jPJuo3QCvOOny7xY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Spqf51rlnt8AUmxs9ln4f4nluvkQ2f7h9krhhYkrkkM0opOe1MQuEugfu31qrBvVtW1y4or9vqnHvnCVYd4MnBhcBN6lRG/L/5aWbHOWji6/w6C2KWd9K/5mCR4ZYlZYQAnwKD1L84B4wTWVjJ4mGlLt2RR0G1pcwwDhxnK7PYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NfLBT26c; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3da7642b5deso7570415ab.2
        for <linux-kselftest@vger.kernel.org>; Thu, 08 May 2025 08:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1746716803; x=1747321603; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6/7ueoYgZ3OR3TB39uAN4klcPC2fDyaTwTbVZ+ISQok=;
        b=NfLBT26cWoUnPaR0yFh1zqkNyNnsreY+95p72f4SP56MmloVqLGwrYfwrL+3PDba0o
         xNtq3jUejD88CFJ1nLFpsNCxefT072YHV1FHOh7lP7eYJHsKIKhRzA+vf0YdlFYFdNrM
         2w62fNH9swYal1mfkzkiGMvVhNcfi+hppo0hs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746716803; x=1747321603;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6/7ueoYgZ3OR3TB39uAN4klcPC2fDyaTwTbVZ+ISQok=;
        b=oQWDjZ+SCw3bwTB5jB30hD2NvhaoPIWBoxnronPurItKxa60AhKa162OmlhWgIX0rH
         kf+Adeq3rlyTEHjY2BRYSIcLXFowqctD/9OCJHKHQE03M2kRljnS/BBL/Qhst4ByBCNB
         d227OUID/XoxtYNFgQp/MhEeirozMh/CUjcD+BcK6uLE4AXUhSWpyEeOc1wcoS+hjO48
         n+dQh6YYbgMT0s5E/42aV3F1uAVRQ3PtSmxz1WjMxUmgmbnt55iOWrRfRlaLVxVkNcpa
         2ygiDSX8AIp/dzOqKQnzwPylEbCgHO6Yd44v5JSMW66B4Lkm1ZvuxY6ETqSr5434k+lG
         tr+w==
X-Forwarded-Encrypted: i=1; AJvYcCXg1l0DqyB5Ussc17eaoEkTrm1mxXdAzlXRS+dRLXXclfWbhBS+9EndqHxvW4gaSSr+i8CEJbFVyDYHmYwe1js=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1srlGDyXVM1NTvRa4ffw54oJjI9L4JrPHj8YKNVAz6+rhJWWv
	b2RC9ps3l4VAFb0/PFQRtu1sJdmZs3BJc/nYIHUmHbx/iQBVTT4a21DjhD3HedA=
X-Gm-Gg: ASbGncuoFTnl6WS5TW7RoKiFRPB6/GYoSSHyyqTSKUl+4tF10M8R5HUikiozCENN97R
	ogHnBWWmKlLvsfIwsW7nXFH5RtJCYHu7/HVa6Bobilrzfu0W4D9XXUUASdrLNanNYpqrNolbHCD
	Ad7WpjcRMYu/jp+vJlPL2U2u+hRGZw+4ap+ywr3T+MJayWiEnl1Z4TqTzXSf7PePivJHiDlaanI
	zUr+IvaZIk77xai7Shy6ycxG8vTEb7bumHhDTN/AP7D8HDeBt/8QPrx5/rXhF0Hzp+4zNECZNZJ
	PagjTUk9li4vbTMtK7KyxzTLzN3Ul08aJZThnSQu7UuqOQ3+TfI=
X-Google-Smtp-Source: AGHT+IEmzmvQ4SB42hghmafdzG3t4YyXDL1hlYw77sgyCL2ktMv/2tM0lwmDTfO/AIM4bcI7oMIiEw==
X-Received: by 2002:a05:6e02:3cca:b0:3d8:1bd0:9a79 with SMTP id e9e14a558f8ab-3da785ae55fmr54026135ab.21.1746716802693;
        Thu, 08 May 2025 08:06:42 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3d975e7d0c6sm38491925ab.27.2025.05.08.08.06.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 May 2025 08:06:42 -0700 (PDT)
Message-ID: <b547d83f-6e9d-4b11-9207-aca8fd575794@linuxfoundation.org>
Date: Thu, 8 May 2025 09:06:41 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: The "make headers" requirement, revisited: [PATCH v3 3/3]
 selftests: pidfd: add tests for PIDFD_SELF_*
To: Sean Christopherson <seanjc@google.com>
Cc: John Hubbard <jhubbard@nvidia.com>, Peter Zijlstra
 <peterz@infradead.org>, Shuah Khan <shuah@kernel.org>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>,
 pedro.falcato@gmail.com, linux-kselftest@vger.kernel.org,
 linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
 linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
 Oliver Sang <oliver.sang@intel.com>, Christian Brauner
 <christian@brauner.io>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <cover.1729073310.git.lorenzo.stoakes@oracle.com>
 <c083817403f98ae45a70e01f3f1873ec1ba6c215.1729073310.git.lorenzo.stoakes@oracle.com>
 <a3778bea-0a1e-41b7-b41c-15b116bcbb32@linuxfoundation.org>
 <6dd57f0e-34b4-4456-854b-a8abdba9163b@nvidia.com>
 <e0b9d4ad-0d47-499a-9ec8-7307b67cae5c@linuxfoundation.org>
 <3687348f-7ee0-4fe1-a953-d5a2edd02ce8@nvidia.com>
 <e87bbc68-0403-4d67-ae2d-64065e36a011@linuxfoundation.org>
 <aBy5503w_GuNTu9B@google.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <aBy5503w_GuNTu9B@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/8/25 08:04, Sean Christopherson wrote:
> On Wed, May 07, 2025, Shuah Khan wrote:
>> The issues Peter is seeing regarding KHDR_INCLUDES in the following
>> tests can be easily fixed by simply changing the test Makefile. These
>> aren't framework related.
>>
>> kvm/Makefile.kvm:    -I ../rseq -I.. $(EXTRA_CFLAGS) $(KHDR_INCLUDES)
> 
> ...
> 
>> You can make the change to remove the reference to KHDR_INCLUDES.
>> If don't have the time/bandwidth to do it, I will take care of it.
> 
> Please don't remove the KHDR_INCLUDES usage in KVM's selftests, KVM routinely
> adds tests for new uAPI.  Having to manually install headers is annoying, but
> IMO it's the least awful solution we have.

Thank you for confirming that KHDR_INCLUDES customization is necessary
for some tests such as kvm.

thanks,
-- Shuah

