Return-Path: <linux-kselftest+bounces-48035-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id EBE22CEC828
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Dec 2025 20:50:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 77EC830049E4
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Dec 2025 19:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B07F830C601;
	Wed, 31 Dec 2025 19:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BeZkhH6q"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3EF926F46E
	for <linux-kselftest@vger.kernel.org>; Wed, 31 Dec 2025 19:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767210641; cv=none; b=ApOnQlMyolZKMDu3sWeF/BEsw+xUs7zLJaAnsKSKhSlPRt9Y8wmKqwuDSVTWaWVjhldFdryhzBpZtWaTAfxJXzpgajJBSdZEgLHpnbOuwWX6/jlGTfrumRv5pez5AV8aU3V09ys9NNh0LSEwZuw6HR4ovMMQfhtkP40lcaUi3J0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767210641; c=relaxed/simple;
	bh=ix6A3xdAGgEPcZZuGLAVhngUGZhbtrZp0DZi4eRO/0s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bo3vpi7+/68o4TV+JC9sTtZuTOrQC9mLxY/Kh9SmnXnkmJ/UkfxCJytOq+qJVbKNO1mrA1e2BRSjja5rv/MAMSkRoMz3R7kpAkUlaFgEfvMpPlLJ/ekyey1QwIYG5sZu7KTPHQO1bJfAUkr0EKZn/hN/iJLaruDApuaLdQ91YOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BeZkhH6q; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-3ed151e8fc3so7145361fac.2
        for <linux-kselftest@vger.kernel.org>; Wed, 31 Dec 2025 11:50:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1767210639; x=1767815439; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t935BcvfZIHJZaYpgjJ/I78hG7hwYxgpYQ+T3oH/9z8=;
        b=BeZkhH6qiaEJaA5k0LcnYn4x8jaeyS5CKVF2tLAv3s1fxb/NNi9a5csweCJ9/moZ3t
         KhbGrlMPwEDL+yxT+etn4V+YD9i2FWLbqxRli7wd33inDwbRjKtfCytAdR/VAFSyOpr8
         Jv46gpwYmwva6oAHA8QK8ijXml9Q5c0b64WjU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767210639; x=1767815439;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t935BcvfZIHJZaYpgjJ/I78hG7hwYxgpYQ+T3oH/9z8=;
        b=sKSFxFw/qOb6EvuW1dqeqb1ekrY8wtwoPB4G9x/YNWi2Zhk+b6FqBYbX0Y+ff0vTiR
         7/3XSvJ8YDcu6xymWDcvmunujLC9CvbrlFkpXup6F4P/H6QpXlxzJsb1+HqKyuS+SGmS
         d4qjo8vDfYNNFqPaMtfvNZpkwIwlhPccws/4vnzawzjWx8k7dvWlQ114rlBYwddS40g1
         AGBGSqwwJQm3j98zlsLvWAAWLVFjdkW0FV9nucGDzto75m/qkBclHFz9UnYSwrkVXoBn
         BD5vlAC750RpcGH4AWYHC3ACI1LlvEotzd7bqhLheW+3gmxSEVxyT8KjoThkbbskwKFZ
         8AAw==
X-Forwarded-Encrypted: i=1; AJvYcCW3GeTSP4bVy5Ugs987iMPPgkyV3WwlIEp9eOLd22e63KRZ589KJFUYqhX2NwC5YoRSq437vJV+E5tnSlfl6Sg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9YqwOQF926/gnqhXcUf2ZU4zZjlgXzy2oxD2nAPW36/G8PgjY
	5biqErURVNEevqVvxVbzb6oFbUnuYRxaWsJ5z1DViNPzIL0KudSacuIuUe2O79FpOrE=
X-Gm-Gg: AY/fxX6GhDAZhAUAzBL+kuf6Gs0KzD/jwt8wUV2VnwClJOzu9fn+tNuK5PRTrFAsmQq
	5TyRP3JSv5vIE6SDSbk/WWIC29fFm40i2ctj8KKugt5qKAjl7oTUW7U8DctWswXvxpDBUTtu2Dn
	1ZrU5WSAxyrCNR5u420SwPu7ziuHBLqNvPwhnxAuQFb2/YKVQzaPS0waE8KJtxvwgF7GL5I2lxF
	9q3vGybZBv+6XMqQtxa2EHPqYM5hjbyEAGsMyeOr8vIi1MWXpRoN1+FXbqwwZOAueg0aanAzA6d
	gkZ9U7gu+28HsJIG+cNQgC0gliovVC/8ZrDviSz/1U2Cs33T2arC+UQ/TZRuViAbeV7axSJjz5d
	NeQhv7zmlKYyQligGNsXIFw0bkHxf6RjLpp3nbfqRk9oogwQagZ4cBVC0c3zHxtqVLeNnwOZ/eT
	lrbAXUwU1brZS9MT49CO0RHoE=
X-Google-Smtp-Source: AGHT+IExsHsLtfTSkxkO6eeVI5nXS93B+/uuZEmfne0eSd3+gbCVOw19HkivC6xibbumsjNLB697KQ==
X-Received: by 2002:a05:6871:6c12:b0:3f5:4172:22 with SMTP id 586e51a60fabf-3fda599f1e2mr19924623fac.59.1767210638842;
        Wed, 31 Dec 2025 11:50:38 -0800 (PST)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3fdaac145bcsm20594782fac.22.2025.12.31.11.50.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Dec 2025 11:50:37 -0800 (PST)
Message-ID: <0d357c41-239b-4750-ae65-4c2c3734950f@linuxfoundation.org>
Date: Wed, 31 Dec 2025 12:50:36 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/ftrace: Test toplevel-enable for instance
To: Steven Rostedt <rostedt@goodmis.org>,
 Zheng Yejian <zhengyejian1@huawei.com>
Cc: mhiramat@kernel.org, shuah@kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20230509203659.1173917-1-zhengyejian1@huawei.com>
 <20230609174626.66659892@gandalf.local.home>
 <20230710175415.2ec0061f@gandalf.local.home>
 <20230907214020.34981ffd@gandalf.local.home>
 <20251218183040.0f652a64@gandalf.local.home>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20251218183040.0f652a64@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/18/25 16:30, Steven Rostedt wrote:
> On Thu, 7 Sep 2023 21:40:20 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
>> On Mon, 10 Jul 2023 17:54:36 -0400
>> Steven Rostedt <rostedt@goodmis.org> wrote:
>>
>>> Hi Shuah,
>>>
>>> I think this dropped through the cracks. Can you take this through your
>>> tree?
>>
>> ping?
> 
> Found another one that never got applied.

Thanks for digging these up and others. It got buried deep
in my Inbox.

Applied to linux-kselftest fixes for the next rc

thanks,
-- Shuah

