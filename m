Return-Path: <linux-kselftest+bounces-7210-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A85C0898C29
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Apr 2024 18:32:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 486AB1F248B4
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Apr 2024 16:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0CAB18039;
	Thu,  4 Apr 2024 16:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WfyvAADc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B5471B7F7
	for <linux-kselftest@vger.kernel.org>; Thu,  4 Apr 2024 16:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712248356; cv=none; b=m1zAE/zxIxKtoAnmYte35Q8wzlKo2X5cfTbOoggoutucgyz3gurlUykN0sb6S23iv7c+R0xwoeJqp//it8S2L8vGvR2irclW5IzBzH2DR4jfjiojyp+cwKGHENMoCXCRXO+dYpPOWrO3HWBAThqhDccqnP8euOKmtmLZFODf+Lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712248356; c=relaxed/simple;
	bh=FaRTigCLQPwODumK/uro6tAr7hVUCu4TTcem6firu4w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hNOZSS8GMOQQ/BCfDZxvjs7gKod4Kt1QaZfTFSX0cxnPuZnzMyc4dkw+OP8yq1+Ll9TJEHNW9chEzjNSnG8NCoRu08K0iktebZH5+NLWjG1xlPPdBLRuMnNwUd83p3TvpqoA0zM5fzc3+X208QZUmfQrpDczTz2zocvzo/hy3T8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WfyvAADc; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-7d341631262so20752939f.0
        for <linux-kselftest@vger.kernel.org>; Thu, 04 Apr 2024 09:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1712248354; x=1712853154; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rnzPx7jQfSANKpYvBZUrsn52XLSYl8iVTFuQscI6o9Q=;
        b=WfyvAADcYPjL1OvggdQ94pH3tSeumrxgy0eC1ZC3MgP9VMoKIAz+kCjCDwtFa0gb7/
         VixEh75GgiG0C2rgsc37nwjKXq9utXfCTysSh/uAnWckfVzlC8eqx+6GXe6YSE23ZX4s
         GDmCzwS3+FU4AWA9Yx23yN3pZuEnWNFG8rxMU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712248354; x=1712853154;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rnzPx7jQfSANKpYvBZUrsn52XLSYl8iVTFuQscI6o9Q=;
        b=OR9g/gLN6J/UH8LCcy9vICl2X6ewRQWwnq6TocV7zJFsXuWuz+3k52n0wmj6pikUef
         Wy+u/BLMZZReK1XMnutH+GQrtTy2+mG2OQyZQb+RKoys9N77sqQda8Va56c37YzgwGZv
         bpsqLARN3DmxOU1/Yf3VAJdCI1/IFUaa9/AD6piqmsQfUww0vskhcjgyAYclf/zj2T9j
         AHEfzgLe4mbjBU3hk6wb+qRxMd4E0XApXJLg8ZLFia1w8Ppm/Ehp7HVDCDIxT6KlSjCz
         4kfV0s6xGxUQdKES2o+4OMS4kuamxF+FossH+do56LxGmL5EWvP1Rb+xOXIMFXBxyaPa
         fC0A==
X-Forwarded-Encrypted: i=1; AJvYcCW4qrESVAU6tDaBn5pqmXXeehlxMqK2BUBTfqv83ydJPyNGs2lcYrOFUpZFvis/SSKnLK6ClyxiLfkm9cogGIcYN74+D2UCphmZ5x1RPH7t
X-Gm-Message-State: AOJu0Yya8YEw0UY13kpmcvyyYiVdDZyRwHbczTwVzDjepk+v/fkhmxvz
	dpu4iEVsUnblG+AGmlZTGBTpdJCTWxS1Owepe1gJRkUUedsZfZRgPk0Lo1br7VI=
X-Google-Smtp-Source: AGHT+IG6x3n9pPVk7ZIl/6gWe0CvJfV0aQuqJSosY/xO54MV5MoKOSUCkywMrSzR9EIlLsZzzzQNug==
X-Received: by 2002:a05:6602:21d6:b0:7d0:9f34:9d85 with SMTP id c22-20020a05660221d600b007d09f349d85mr3234193ioc.2.1712248354140;
        Thu, 04 Apr 2024 09:32:34 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id o11-20020a02b80b000000b0047be410bcc5sm4826045jam.27.2024.04.04.09.32.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Apr 2024 09:32:33 -0700 (PDT)
Message-ID: <39f406e4-685e-4371-8726-c7df02299295@linuxfoundation.org>
Date: Thu, 4 Apr 2024 10:32:33 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] tracing/selftests: Verbosity improvements to KTAP
 output
To: Steven Rostedt <rostedt@goodmis.org>, Mark Brown <broonie@kernel.org>,
 Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Shuah Khan <shuah@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Aishwarya TCV <aishwarya.tcv@arm.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240325-kselftest-ftrace-ktap-verbose-v1-0-3785199809da@kernel.org>
 <20240326120809.09574951@gandalf.local.home>
 <e2c68911-9b49-4080-b827-3b139b4f3257@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <e2c68911-9b49-4080-b827-3b139b4f3257@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/26/24 13:11, Shuah Khan wrote:
> On 3/26/24 10:08, Steven Rostedt wrote:
>>
>> Shuah,
>>
>> If Masami is OK with this, can you take this through your tree?
>>
>> Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>
>>
>> -- Steve
>>
>>
> 
> Yes. Will do once Masami gives me the okay
Hi Masami,

Are you okay with this patch?

thanks,
-- Shuah


