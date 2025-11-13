Return-Path: <linux-kselftest+bounces-45533-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AD721C5737B
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Nov 2025 12:36:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 223F64E672D
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Nov 2025 11:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E03D9346FDB;
	Thu, 13 Nov 2025 11:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KXmZr9PC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 150532FFFA7
	for <linux-kselftest@vger.kernel.org>; Thu, 13 Nov 2025 11:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763033647; cv=none; b=GK98kN2ruO3MzjEzQKLGNM3iTobWLbrYwzRpeQeZWlLYrYZQjE9H48fijdGVnRvCsWAXryJla9+A2odRzntWyDZrHLSyn/LkSkVjgB9wscuoy8VioAzhe+Kv036hUz/niB/rTbJTiDT8xoK7ft8AkC4aeFeqYGY5hYFQSeRLQjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763033647; c=relaxed/simple;
	bh=szEfWU/bVV1zSB98g0M2rX9bxqlQLQNTUONjL2LW8Zc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O4UAtA5vm95gimY2zLi3Q3Jy8clb6GEk2BUYdc2IhycOkq5bd9I1cg8NXyQXM16RkMwyIRTjCv3/cu3ybQVPgsIz5qgzwCNUvu5aj7R8Ubzg12OSp0tkcrbtFCkzC/xOVCbNNrGQ8aJ60c7VjXxKK3WfKpEW74IxQ8tN/fXkgo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KXmZr9PC; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-42b3c965cc4so353244f8f.0
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Nov 2025 03:34:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763033642; x=1763638442; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=itNJjGbKr9hOTSLlNwiZZOpbJXSs/2p7rVNvrCzyP+Y=;
        b=KXmZr9PCoa5qVa/VigcWhfxfx/iX5li6bYSwjGXHmogvrt2cWOIpg478NOtVVxdxBj
         /jXumxsJKNow4QDerDNsenR2F0LxGPCyqD5JmZBbarDqZRuMWxgMsqkD8ODXpFUIZk8A
         EzRGweoKnCNAdpp7C38a0AQRGyu25vHEw/uRMwNS6Aaoln63QtFFfpnVhelLalAOrDZ/
         wxqyDN+ggNMK98uGVsrecBi9WGZwB5XAKpI40mREtOLK8L1ntAH7Um2j7nOLfxSuDban
         rTL8hPO2dl3WhMgnM3x7xT5Ma2eaFb6AxyldwMo3Q0+yNZKb4NapWQ4SzJpbK+Ua8NSC
         LPzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763033642; x=1763638442;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=itNJjGbKr9hOTSLlNwiZZOpbJXSs/2p7rVNvrCzyP+Y=;
        b=DCxuiogrprkQoc5BNZZMfhD3nqLisV59jtBq9KeP35IS2xRzdBuv3h+vK50JznMRoK
         iL2wKZtEGvO8a3c4rf7KyF6SxWBmdgjKipFuyYaL8W52ikStoKVCtgngXE9D3bAwjFMq
         Wznvv3al8SK6TUIZepObJbXvankZEzgd3C7SNmPLP/7MKSWZ74bq17mwZPP/bz3rlmO9
         k+L7qoDQlmc7gs8t9AffFjf+cD10xtzyzoNcwJFchlOWxAlY4XPgmupePS2+FA6QPk+q
         XTDEuGOMoWRm90qQXwgsNRClTbijc3Fae2u7dUTgm88DHqBFkEtqNhsNOKf1Flbs8Tr2
         XpQg==
X-Forwarded-Encrypted: i=1; AJvYcCVTnqVsY2bwk6aPHu/pzazpGTlHPKfIlFxBkwgJH1WbTYYS0ryiQH7XA7L8P2F3TlLAEtBrJqlaNhz7U4QoNxs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAqH20Pio6G7OdiABc6E/DZmCtksUn/amJxjsKk4aJygiVluDo
	CL+A1ukR0bn1r4ptKWSqU9yf8joCrnVZiqxo/iQLEJPVKuYV3g2PnJyQ
X-Gm-Gg: ASbGncvlDZbLtKu4WARLuXhZcS8iTwhDCzyMvP5X7QDo7ql0BiSyHkK6FC9bcq82JcI
	tViF3i4jn4E+ecQ+uUaWdHzitucA1UnLn8MZhMcSM/6D1MSdnmeUVh7aqX1K5FnvtsF5wzLGX7u
	rqJIK4CrmXK+3BPpZd11A49Vkr7GCCUJueSnIeTwls/qKLlMri+S6fo2PQyRnbfsy5KQwhto4Zt
	roiHCOiPOvZ6Tyo/k3tdKcFeqnpmzd08ga0O8jLuc+nBFdvcNrmlFJpUPnVgIFUWzFGBwxK46KI
	vjYiU2Z5xYdeKilk0SLxMJRWw2xi6yo7c2ka8wVVxcHEsWvpmO0gKHd1oZ072C0B/JLwhtGfJLM
	lMc+COXZDXmYA8DgepR52iwop6ZCimh+MW2lrOYO2Fs8yMOf7QRyDqFwUtp4lcaEiraABSBQnZk
	o5U1RsYmYxfrNeUUou9DqiSlJkQkU=
X-Google-Smtp-Source: AGHT+IGdopSjDKcZsfNDj50WFrJg2rJWrnZhwNBuCTBSaYL3A3I/G6d2OYwxOSpsfHYEqI44/nAYpQ==
X-Received: by 2002:a05:6000:40dc:b0:429:d3c9:b8af with SMTP id ffacd0b85a97d-42b5282384cmr2499048f8f.25.1763033642106;
        Thu, 13 Nov 2025 03:34:02 -0800 (PST)
Received: from [10.24.67.124] ([15.248.2.24])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53f17cbfsm3172575f8f.35.2025.11.13.03.34.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Nov 2025 03:34:01 -0800 (PST)
Message-ID: <25469f8f-27ea-4d9f-af70-86e320224ec4@gmail.com>
Date: Thu, 13 Nov 2025 11:34:00 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] KVM: selftests: Fix unaligned mmap allocations
To: Sean Christopherson <seanjc@google.com>
Cc: maz@kernel.org, oliver.upton@linux.dev, pbonzini@redhat.com,
 joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com,
 catalin.marinas@arm.com, will@kernel.org, shuah@kernel.org,
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 isaku.yamahata@intel.com, roypat@amazon.co.uk, kalyazin@amazon.co.uk,
 jackabt@amazon.com
References: <20251013151502.6679-1-jackabt.amazon@gmail.com>
 <20251013151502.6679-3-jackabt.amazon@gmail.com>
 <aPpi1c-8EpWuo87B@google.com>
 <c52db7bf-494f-49a8-9829-3805db6dda7c@gmail.com>
 <aQkZtjLt6lIULffA@google.com>
 <0c3db907-7012-43c3-b7fc-36848789da52@gmail.com>
 <aQpfviS-oAmanqpq@google.com>
Content-Language: en-US
From: "Thomson, Jack" <jackabt.amazon@gmail.com>
In-Reply-To: <aQpfviS-oAmanqpq@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 04/11/2025 8:19 pm, Sean Christopherson wrote:
> On Tue, Nov 04, 2025, Jack Thomson wrote:
>> On 03/11/2025 9:08 pm, Sean Christopherson wrote:
>>> On Tue, Oct 28, 2025, Jack Thomson wrote:
>>>>
>>>>
>>>> On 23/10/2025 6:16 pm, Sean Christopherson wrote:
>>>>> On Mon, Oct 13, 2025, Jack Thomson wrote:
>>>>>> From: Jack Thomson <jackabt@amazon.com>
>>>>>>
>>>>>> When creating a VM using mmap with huge pages, and the memory amount does
>>>>>> not align with the underlying page size. The stored mmap_size value does
>>>>>> not account for the fact that mmap will automatically align the length
>>>>>> to a multiple of the underlying page size. During the teardown of the
>>>>>> test, munmap is used. However, munmap requires the length to be a
>>>>>> multiple of the underlying page size.
>>>>>
>>>>> What happens when selftests use the wrong map_size?  E.g. is munmap() silently
>>>>> failing?  If so, then I should probably take this particular patch through
>>>>> kvm-x86/gmem, otherwise it means we'll start getting asserts due to:
>>>>>
>>>>>      3223560c93eb ("KVM: selftests: Define wrappers for common syscalls to assert success")
>>>>>
>>>>> If munmap() isn't failing, then that begs the question of what this patch is
>>>>> actually doing :-)
>>>>>
>>>>
>>>> Hi Sean, sorry I completely missed your reply.
>>>>
>>>> Yeah currently with a misaligned map_size it causes munmap() to fail, I
>>>> noticed when tested with different backings.
>>>
>>> Exactly which tests fail?  I ask because I'm not sure we want to fix this by
>>> having vm_mem_add() paper over test issues (I vaguely recall looking at this in
>>> the past, but I can't find or recall the details).
>>
>> The test failures happened with pre_faulting tests after adding the
>> option to change the backing page size [1]. If you'd prefer to
>> have the test handle with this I'll update there instead.
> 
> Ah, yeah, that's a test bug introduced by your patch.  I can't find the thread,
> but the issue of hugepage aligntment in vm_mem_add() has come up in the past,
> and IIRC the conclusion was that tests need to handle the size+alignment, because
> having the library force the alignment risking papering over test bugs/flaws.
> And I think there may have even been cases where it introduced failures, as some
> tests deliberately wanted to do weird things?
> 
> E.g. not updating the pre-faulting test to use the "correct" size+alignment means
> the test is missing easy coverage for hugepages, since KVM won't create huge
> mappings in stage-2 due to the memslot not being sized+aligned.

Got you, that makes sense I'll update this series to resolve this then.
Thanks for taking a look.

-- 
Thanks,
Jack

