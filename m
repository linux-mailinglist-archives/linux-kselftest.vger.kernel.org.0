Return-Path: <linux-kselftest+bounces-3253-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 66C08832EFB
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Jan 2024 19:35:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 686261C24787
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Jan 2024 18:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2439129CF0;
	Fri, 19 Jan 2024 18:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="NRPwmz8K"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D4DB20B10
	for <linux-kselftest@vger.kernel.org>; Fri, 19 Jan 2024 18:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705689315; cv=none; b=BtnS0edIztqtNQ16+CJQ0tP80jU+Lo6n8A7G71ktHJ8xkv9AUE3XEbGaWxnIVxRvZG50MgGK3ROFPQ/62imctY/DQw9/DBEUpcuUB8hhZf000zGzi/m+RBWoIZGQdQA5pCYt4S8/auBqa4ejV1td3igq93rJeIY0T8dh0sTXwio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705689315; c=relaxed/simple;
	bh=xuCFgyn4cz0wIPZBSCrD3dL2scimn4xxXHNjvci2OOE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZfpediIjz0ecls+31mgdMl1QPakuiqSQdnwItLfgNjvgite1g3Tq/WwtSmO+KhdFYWPqQSDAJKW7ZlhwtUxTjzPMNKvP3vXzLFmEawfKsW6ud0YQtB4BXo7EqKN0I2D1MSu8FAIVEcoflj2gRcpl7SsPOUmAFIBeEv5iuEOmIak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com; spf=pass smtp.mailfrom=arista.com; dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b=NRPwmz8K; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-337b583453bso990033f8f.2
        for <linux-kselftest@vger.kernel.org>; Fri, 19 Jan 2024 10:35:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1705689311; x=1706294111; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0bAylKPD/2AUXEJVvzIJSovCcFzQteP7UpA1x2mx61w=;
        b=NRPwmz8KWOGYdUHpGk74fx2fq9BfCUYTrQq/A3zT1adsIaHy0p1Nt2xBEp3V2XCq66
         M9kp5FhgJ58/LorqW9IrGhk2pRnnLHwh5ontQq5sEcC0A7VxxkoR/H9qeXP6rWrsT1I4
         HhFFP2PLjl3qSdrwW8XBgRuD0piEPjTlSl7dZ1+o49PuiLNPLcuIEyWr0YNW2W+gWxYZ
         dX1SK7Mhw6PTaBj7izRtM77xgDkAnrVsmspsPdm0PsDQFpd7t4lBXeepLyLnpxzaNJQO
         blWV9q2U+C1tWnzx3lQ2ngoby6vA8NUXEeWUGLDFug1A21I9Ar88eFcyPIOZQMQD9YnL
         ZoUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705689311; x=1706294111;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0bAylKPD/2AUXEJVvzIJSovCcFzQteP7UpA1x2mx61w=;
        b=l7VTH0aKrIiRVIQbCNFX3YfpxbZe706W0COJU3iX1esO5diSDQG1ym0w+T6iLITWZJ
         JQbw50Q4k+K4mwRyIebsi2LRkdo1Kkw2E6fWqyDM8snmCbhBvtxwrxbZT+Vu4pmQkE2K
         0rBmRrllDxmDpFYCvM/8SFxoB94uJAIse6wng6pZSZKyTXfAmtQomMjlb8r/qcwP1Jyf
         nar6mziTm0T8jt8sTbiOLFSEtQaY4wkoxwWukE1mg+B8Mupf6sQrjeRm2cT6MSLVyyJD
         2oz6uBo9d7ucGTfXATzgVGY+PbJOr2Z/c3Ff63ged4KRH2HTFLvlMabGY3lEIuxTQxDa
         PtXQ==
X-Gm-Message-State: AOJu0YyDQWoBbrNriBEe2BxnxPrlDfWOV7E9rhxB89g2tOoCJF4Qpa1b
	ZctZdwY2lQGi6Z6D6Ym8JDIkOqGmMhGyrRiqBcEfTjFkDIT/3vQortgFvOdxtA==
X-Google-Smtp-Source: AGHT+IEmz4Ekqul2zRazQSdNgWFThds0DWXDzxgiZCKOmZLx0ze57Ay8hIE45e6h7me09fPjGggnIg==
X-Received: by 2002:adf:f20e:0:b0:336:c4c1:2d7d with SMTP id p14-20020adff20e000000b00336c4c12d7dmr63401wro.60.1705689311453;
        Fri, 19 Jan 2024 10:35:11 -0800 (PST)
Received: from [10.83.37.178] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id u11-20020adfa18b000000b00337d2d1e0ecsm4362582wru.104.2024.01.19.10.35.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jan 2024 10:35:10 -0800 (PST)
Message-ID: <f66f4de0-8ed7-4c23-937b-fc29527835bf@arista.com>
Date: Fri, 19 Jan 2024 18:35:08 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] selftests/net: Argument value mismatch when calling
 verify_counters()
To: Simon Horman <horms@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>,
 Dmitry Safonov <0x7f454c46@gmail.com>, Mohammad Nassiri
 <mnassiri@ciena.com>, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240118-tcp-ao-test-key-mgmt-v1-0-3583ca147113@arista.com>
 <20240118-tcp-ao-test-key-mgmt-v1-1-3583ca147113@arista.com>
 <20240119162652.GG89683@kernel.org>
Content-Language: en-US
From: Dmitry Safonov <dima@arista.com>
In-Reply-To: <20240119162652.GG89683@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Simon,

On 1/19/24 16:26, Simon Horman wrote:
> On Thu, Jan 18, 2024 at 02:51:34AM +0000, Dmitry Safonov wrote:
>> From: Mohammad Nassiri <mnassiri@ciena.com>
>>
>> The end_server() function only operates in the server thread
>> and always takes an accept socket instead of a listen socket as
>> its input argument. To align with this, invert the boolean values
>> used when calling verify_counters() within the end_server() function.
> 
> Hi Dmitry,
> 
> I see that this is correct, but I am wondering
> if it fixes a user-visible bug. If so, could
> some text about that go here?

Yep. The test as the result doesn't correctly check tcp counters for
non-symmetrical scenario, where peer-A uses a key <a:a2> to send data,
but peer-B uses <b:b2> key to send its data. So, in simple terms,
different keys for TX and RX on peers.

I'll send v2 with an improved patch message.

>> Fixes: 3c3ead555648 ("selftests/net: Add TCP-AO key-management test")
>> Signed-off-by: Mohammad Nassiri <mnassiri@ciena.com>
>> Link: https://lore.kernel.org/all/934627c5-eebb-4626-be23-cfb134c01d1a@arista.com/
>> [amended 'Fixes' tag and carried-over to lkml]
>> Signed-off-by: Dmitry Safonov <dima@arista.com>
> 
> ...

Thanks,
           Dmitry


