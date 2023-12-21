Return-Path: <linux-kselftest+bounces-2323-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73B2581C06E
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Dec 2023 22:47:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F9BC287267
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Dec 2023 21:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 395937762B;
	Thu, 21 Dec 2023 21:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RPfIoOAo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC06576DCD
	for <linux-kselftest@vger.kernel.org>; Thu, 21 Dec 2023 21:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-35fd4856abbso216605ab.0
        for <linux-kselftest@vger.kernel.org>; Thu, 21 Dec 2023 13:47:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1703195224; x=1703800024; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T5CHLrR4EMTucnMkbYGinuiGUovrY8mvDNYXvJwsxgw=;
        b=RPfIoOAoE6D7eyHYl+GpQz7/QWupIcw/Ed9MePMcu3A0pErf4xCJFLKQ7Q3To7cc8w
         vuL0x47RqXTwRLBYhbTMwBPxL8pjE36ch5aOHHSHecnrxY7A017VOohgcVqbVnUaiRBF
         18saKSseYHoigVk7cKBDJafC5MSXAtEfkwgU4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703195224; x=1703800024;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T5CHLrR4EMTucnMkbYGinuiGUovrY8mvDNYXvJwsxgw=;
        b=MSZxpAltGQ3KT9ExJ64ujqz3dgcth17dGOCrrgMhsYOSpKeHIUH6vok73KTRCM4vJv
         5P/NllfAeK+7PtLmGQBr7a5DFlARn2JvdRkd8Cpst6RK1gFG+sf4vL1YlCgEGDOpR5gW
         lw658U+fbuZlTxVYP62izN7C8Kv3F/Mn6MK7RWL7mnJLisvIQAiAIlTo3DPbrRPBgl08
         cp0qn+pwlDZIwAzOOFYGaBDlCwNNdPFsmUioksenq2JUD4fW+bKk+PSD62eYXbeyQ2Zg
         e0E5sx+p+Go4E8+gMKITgtnZNrerpKvjYqvT5rcv7CKhjuVVfRre/aEMXqc8qIkBgcZZ
         33CQ==
X-Gm-Message-State: AOJu0Yw+PWY6VIdl0aqlTh+UCeknFZD12O4bu3Hwv3G50ESln/5Z+GxJ
	Dii5ZqfnUqFTkwWI2lf2T4ItjKiUlZqIwA==
X-Google-Smtp-Source: AGHT+IEoGSoXva572vluYRiQgTXBokcH749+S1X5DWwWq7246hcPsKVRMkiwq2VvJEFYIoQC+iRBqg==
X-Received: by 2002:a05:6602:2bce:b0:7ba:9b12:35d2 with SMTP id s14-20020a0566022bce00b007ba9b1235d2mr250473iov.0.1703195223820;
        Thu, 21 Dec 2023 13:47:03 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id x6-20020a056638034600b0046b6f096e3bsm677886jap.134.2023.12.21.13.47.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Dec 2023 13:47:03 -0800 (PST)
Message-ID: <a2ef9ea4-00e8-4fa4-bc2e-58fbec306503@linuxfoundation.org>
Date: Thu, 21 Dec 2023 14:47:02 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] Add some more cfg80211 and mac80211 kunit tests
Content-Language: en-US
To: Johannes Berg <johannes@sipsolutions.net>, benjamin@sipsolutions.net,
 linux-wireless@vger.kernel.org, linux-kselftest@vger.kernel.org,
 kunit-dev@googlegroups.com, David Gow <davidgow@google.com>,
 Brendan Higgins <brendanhiggins@google.com>
Cc: Benjamin Berg <benjamin.berg@intel.com>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20231220151952.415232-1-benjamin@sipsolutions.net>
 <fab3c87ea726208cbdec03dfd61230e4c8ceb694.camel@sipsolutions.net>
 <ae651d3d-58f7-40de-a625-4882cf0efc9b@linuxfoundation.org>
 <dbcadbe4430cd314373f15a9f4b814e44662bef6.camel@sipsolutions.net>
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <dbcadbe4430cd314373f15a9f4b814e44662bef6.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/21/23 13:40, Johannes Berg wrote:
> On Thu, 2023-12-21 at 13:06 -0700, Shuah Khan wrote:
>> On 12/21/23 12:39, Johannes Berg wrote:
>>>>
>>>> This patchset adds a couple of helpers for kunit as well as tests for
>>>> cfg80211 and mac80211 that use them.
>>>
>>> I can take this through the wireless tree, but then I'd like to have
>>> ACKs from kunit folks for the kunit patches:
>>>
>>
>> We have run into conflicts in the past with the kunit tree. I take the
>> kunit patches through linux-kselftest tree. I do want to make sure there
>> are no conflicts. I don't mind taking these through my tree.
> 
> OK, fair enough.
> 
> If you can still put it into 6.8, then I think you can also take the
> wireless tests, assuming they pass (I haven't run them in the posted
> version). I don't think we'll have conflicts there, we don't have much
> work in wireless that's likely to land for 6.8.
> 

Sounds good.

David, will you be able to look at these patches and let me know if
I can apply for Linux 6.8-rc1.

thanks,
-- Shuah


