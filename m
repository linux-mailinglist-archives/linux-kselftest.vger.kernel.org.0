Return-Path: <linux-kselftest+bounces-18324-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A8422984BD9
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Sep 2024 21:57:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D2731F23D9E
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Sep 2024 19:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6A10132114;
	Tue, 24 Sep 2024 19:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TqOF59tf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5872713B5B4
	for <linux-kselftest@vger.kernel.org>; Tue, 24 Sep 2024 19:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727207859; cv=none; b=KbSZbjVyvFB2xJipLjKlkweTwVPrToc6ETWIE2MFoM/2zfBjoKqMDaMbLObX3HfxqD4PjIbo4cV3VKDSnssWQnOEtEyt/uwyEWAUmZUdLvo3dNOGUtI83WzwtwOStjCYEH0k41dl6+q9Dd5zHtpKODuOViVKUkhbt3Xd1GDQ0Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727207859; c=relaxed/simple;
	bh=jHZptUrDFHCW5uDljoG9Ie0NPBVhxsaB1yzSUmN32AQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AFcbjb2zM7vfGs/V4SUwVxCnWN5ViFQbIhqqJEANt/pV/1Wllsq5pt9qasPCl5zHAK+eQ+UiZuGm8+vji+sMWlTQ0TtE9Ve5BtNYF4Xlza2XnE+JQLdzxmYiFcFat6BHDKpvy8hMi+pGAjBtds1CckJ+bYWFerFKZdP2IfZOnXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TqOF59tf; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-8323b555a68so81132639f.2
        for <linux-kselftest@vger.kernel.org>; Tue, 24 Sep 2024 12:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1727207857; x=1727812657; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AP00aJOmkOz7qelvlZtuzoA5Z0KBPTzvKKtRq+0E+44=;
        b=TqOF59tfotev8N57KO8XGxvq/lfNg+CTGrLRCIW0zkhiqD/H63xMdlneqX9oSLd+Gt
         iAX9uRRCJJaF7PlIkjbT2dMozrRnfNMgu5QJlZKTJQMCl6OeoZLpNbpEB+B7V6tPvvvg
         6yB0Avrg7xa172eWmJkzhDqf/qcUBqygRlLfo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727207857; x=1727812657;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AP00aJOmkOz7qelvlZtuzoA5Z0KBPTzvKKtRq+0E+44=;
        b=fBVhDWe/zslI4eb7V2NQaoFE2u8crxzWWERcRNxlc11CUPbbYq0iM8d9RbGt2Vb77X
         k/DZ9PvPhLKChq6tuK/XS2YKLe2hmWVFjt65TDflagZ0dY6JeGC8sy1gJC2gnEcOaSl2
         UT7btvpbdpqsTLpVRiOH21Egc8+549hE/1Jtzn71eEjfjhj7KEvMRfUx2FvCvPC4g6S1
         T/YXxiDHy3EV9ro+MiMZqKUuBnesFrlbpC1ZdBy8ntnOjc2bDBDrMpWCM6sTPvo6Z+7O
         H5c019jM+jSn51uM5bVnaIHHDhZdjSc04w2I0wdaQv/05CKqYgohEgQzAdJLW0tDF8PT
         XUVg==
X-Forwarded-Encrypted: i=1; AJvYcCUWq7b5pQLPhehVLjxWf1CiTlemXL3Ok4Cj2SRwn7J48+LlHRLEWtuOS1VHHa+i7t9TpdrEM/J1In24TuQRkTk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNDCOmuPKuZWZFo2FtJZDhzGEq5nK5hqTNB769t7LlsG7UNPB+
	Z8PJOqInB2CH7BQwHIivybTYTkojeTS9FRexr7Jtn2eeREIVi9dexCgDXvD/1SA=
X-Google-Smtp-Source: AGHT+IF61ZlLlr3/5Aa9EFYe1ZNIP2Z3uSpRDlFBAO7McwESVMoKIDWo9lW360T/8LcXPnWxdSPjLw==
X-Received: by 2002:a05:6e02:2188:b0:3a1:a57a:40a4 with SMTP id e9e14a558f8ab-3a26d78e6a3mr9090915ab.14.1727207857293;
        Tue, 24 Sep 2024 12:57:37 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a1a5726364sm5806245ab.87.2024.09.24.12.57.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Sep 2024 12:57:36 -0700 (PDT)
Message-ID: <a9e43219-a4a7-4b78-8c03-c8deee36befb@linuxfoundation.org>
Date: Tue, 24 Sep 2024 13:57:35 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] selftest: rtc: Check if could access /dev/rtc0 before
 testing
To: Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Joseph Jang <jjang@nvidia.com>
Cc: "shuah@kernel.org" <shuah@kernel.org>,
 "avagin@google.com" <avagin@google.com>,
 "amir73il@gmail.com" <amir73il@gmail.com>,
 "brauner@kernel.org" <brauner@kernel.org>, Matt Ochs <mochs@nvidia.com>,
 Koba Ko <kobak@nvidia.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
 "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240524013807.154338-1-jjang@nvidia.com>
 <20240524013807.154338-3-jjang@nvidia.com>
 <202406201937464fc96b1c@mail.local>
 <8c92ef18-6648-4348-9008-4f646d8b6956@nvidia.com>
 <05f24dbb-cfe6-4a75-9382-273c9c734b22@linuxfoundation.org>
 <202409241931048861ee5b@mail.local>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <202409241931048861ee5b@mail.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/24/24 13:31, Alexandre Belloni wrote:
> Hello,
> 
> On 24/09/2024 10:05:43-0600, Shuah Khan wrote:
>> On 9/23/24 23:37, Joseph Jang wrote:
>>> Hi Alexandre,
>>>
>>> Thank you for looking at the rtc patch.
>>> I saw you Acked the [PATCH 2/2], not sure when could we see the patch
>>> in kernel master or next branch ?
>>>
>>> Thank you,
>>> Joseph.
>>>
>>
>> Please don't top post. It is hard to follow the thread.
>>
>>> On 2024/6/21 3:37 AM, Alexandre Belloni wrote:
>>>> On 23/05/2024 18:38:07-0700, Joseph Jang wrote:
>>>>> The rtctest requires the read permission on /dev/rtc0. The rtctest will
>>>>> be skipped if the /dev/rtc0 is not readable.
>>>>>
>>>>> Reviewed-by: Koba Ko <kobak@nvidia.com>
>>>>> Reviewed-by: Matthew R. Ochs <mochs@nvidia.com>
>>>>> Signed-off-by: Joseph Jang <jjang@nvidia.com>
>>>>
>>>> Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
>>>>
>>
>> Alexandre, I can take this patch through kselftest. Might have
>> slipped through my Inbox or the assumption that this will go
>> through rtc tree.
> 
> I assumed this would go through your tree, this is why I didn't carry
> it.
> 

I will take it through my tree then. Sorry for the delay.

thanks,
-- Shuah

