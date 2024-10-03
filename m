Return-Path: <linux-kselftest+bounces-18984-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF9A398F912
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Oct 2024 23:41:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 908622822C4
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Oct 2024 21:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 766951C4606;
	Thu,  3 Oct 2024 21:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NGbAhFyY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C74D1BD01F
	for <linux-kselftest@vger.kernel.org>; Thu,  3 Oct 2024 21:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727991683; cv=none; b=OIMVJ7xfqtaEictQEhNDWtPWCPz2kRUYoqkXLclChkMcWGf+oKpJzaKcrJEVU24u1Pkw5T5/f6AAjYUKJYOK09Ne7yofvQFU58+s/NacnLB88aO0GYX8LUdvnPgEk/76l1XagWwBzE6B9LAcEVG+dEdAZv9zOghtTlOV2v/lUog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727991683; c=relaxed/simple;
	bh=U3jI55LYF4f1QL7Iz9Tn/+ivZTTA7wcXjkL2Ry8cnJY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tNOQo4j+MmGQ+f0hNcuPAr2c4XwbOTp9c0oGJxmDYQWDzG/OAd/ENQDOOin0utGa54doLpIHgeFseU+3lmiOg1RMuSVj+G6HtSX+0nwE9oKGVHDjMiUq5uNMzDGIykCoB/qYkGqG/HtTY7Gomo2xXCQ01BBjlw/FQyva1YwF6yQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NGbAhFyY; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3a2761f1227so4685395ab.0
        for <linux-kselftest@vger.kernel.org>; Thu, 03 Oct 2024 14:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1727991679; x=1728596479; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=16ODzNekwQkzCd2X6LG7F9NAs3ABPkRxl2t0mavCzOA=;
        b=NGbAhFyYu2Zr4iYHD0JPnZtEZoKb+OH9VYLDN7kl9dKtaJrvqNYPmiryNVFBoSXA+Q
         ioGAJ9//McNfJ7VuTh2s/hJBjc8ErHsM/nvl5LYxCB0PQyWzyz2iMOzH3m5jevxeBXiC
         z95olLDubZp8A9UZlPIXX+Sxc4orlCYZuwUUs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727991679; x=1728596479;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=16ODzNekwQkzCd2X6LG7F9NAs3ABPkRxl2t0mavCzOA=;
        b=ssbETF9Kh8Hoe+Ot1aIUu24IKyiC1MH7uTmBeA1HrK2e5kUqQSw0xegAcNtweX5WtB
         Goc/phn9774vJogZkzGBpQi8iFkVwp3Cx4azBegvIgSrohybme+Pj3xj3+VioSAqbfTT
         u+Ka7JFxGR/NO3vk6GPNazktjPXTMpUtqmzE20ILV1kED9fcUqZIG5sCQs5bu34kp8LY
         c2hrhIgqbE+Ay6vCFECsp2nD172j2A7Q//gxD/qFkHRQjT1xWf/6a38IMtSbPRpwAowI
         sZ+34AoHb6t/RZnr6/F3EHhzJUWRNtWP/gbM1+ZnrzX60U8YdjZdgAlrugfW76oWtpsJ
         FD2A==
X-Forwarded-Encrypted: i=1; AJvYcCUxjLkTEB/8NBNRJi+7qtW8J3gofsh2BHD1G1C8BKk6Yn+zFUto20dfxRazEgajQ02PlowVM5361u/mofs98Zo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyu+5YNU5bmYhuh1MAicqrCAcy6LAGCqoG0wQ2cElRf/beginD7
	6+U+CvUs6P3qdq/u0aLY+jkIV3Tju0mA3FUWDNwsAXb6GltuZ/wc7iD20fAhDKE=
X-Google-Smtp-Source: AGHT+IGhUXX1dOTI9CaPOgZqIoNBcNAM+IEVoCm2oGQ2NBH9fhl6ZhTI8PMx/s/seudoGkIb3tuLGw==
X-Received: by 2002:a92:c269:0:b0:3a0:92e5:af68 with SMTP id e9e14a558f8ab-3a375b9aba9mr5251055ab.15.1727991679320;
        Thu, 03 Oct 2024 14:41:19 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4db55969139sm442308173.55.2024.10.03.14.41.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Oct 2024 14:41:18 -0700 (PDT)
Message-ID: <2767f7da-355c-4abf-9eb7-b409e0c9ccab@linuxfoundation.org>
Date: Thu, 3 Oct 2024 15:41:18 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/1] Add KUnit tests for kfifo
To: Vinicius Peixoto <vpeixoto@lkcamp.dev>,
 Diego Vieira <diego.daniel.professional@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 Brendan Higgins <brendan.higgins@linux.dev>, David Gow
 <davidgow@google.com>, Rae Moar <rmoar@google.com>,
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
Cc: n@nfraprado.net, andrealmeid@riseup.net, vinicius@nukelet.com,
 ~lkcamp/patches@lists.sr.ht, Shuah Khan <skhan@linuxfoundation.org>
References: <20240903213649.21467-1-diego.daniel.professional@gmail.com>
 <04b041a2-d38c-4399-b4a5-1506b5a23e55@lkcamp.dev>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <04b041a2-d38c-4399-b4a5-1506b5a23e55@lkcamp.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/21/24 17:15, Vinicius Peixoto wrote:
> Hi all,
> 
> On 9/3/24 18:36, Diego Vieira wrote:
>> Hi all,
>>
>> This is part of a hackathon organized by LKCAMP [1], focused on writing
>> tests using KUnit. We reached out a while ago asking for advice on what would
>> be a useful contribution [2] and ended up choosing data structures that did
>> not yet have tests.
>>
>> This patch series depends on the patch that moves the KUnit tests on lib/
>> into lib/tests/ [3].
>>
>> This patch adds tests for the kfifo data structure, defined in
>> include/linux/kfifo.h, and is inspired by the KUnit tests for the doubly
>> linked list in lib/tests/list-test.c (previously at lib/list-test.c) [4].
>>
>> [1] https://lkcamp.dev/about/
>> [2] https://lore.kernel.org/all/Zktnt7rjKryTh9-N@arch/
>> [3] https://lore.kernel.org/all/20240720181025.work.002-kees@kernel.org/
>> [4] https://elixir.bootlin.com/linux/latest/source/lib/list-test.c
>>
>> ---
>> Changes in v2:
>>      - Add MODULE_DESCRIPTION()
>>      - Move the tests from lib/kfifo-test.c to lib/tests/kfifo_kunit.c
>>
>> Diego Vieira (1):
>>    lib/tests/kfifo_kunit.c: add tests for the kfifo structure
>>
>>   lib/Kconfig.debug       |  14 +++
>>   lib/tests/Makefile      |   1 +
>>   lib/tests/kfifo_kunit.c | 224 ++++++++++++++++++++++++++++++++++++++++
>>   3 files changed, 239 insertions(+)
>>   create mode 100644 lib/tests/kfifo_kunit.c
>>
> 
> Gentle ping, is there any chance could we get some opinions on this? :-)
> 
> I know that this patch is quite big, plus LPC just ended and people are probably very busy, but we would really appreciate some feedback on this one. Thanks in advance!
> 

Which repo is this based on?

thanks,
-- Shuah



