Return-Path: <linux-kselftest+bounces-48634-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 07679D0C7E2
	for <lists+linux-kselftest@lfdr.de>; Fri, 09 Jan 2026 23:51:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 406D430090BB
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Jan 2026 22:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4CC23469E3;
	Fri,  9 Jan 2026 22:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ajACC4zp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F3E34678D
	for <linux-kselftest@vger.kernel.org>; Fri,  9 Jan 2026 22:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767999099; cv=none; b=ef/ghVMWDZpQstHAS2Pkq2KETnBFBC62wJZE7y7uFRr5c1SgeFN967m9EfLb+DB6ENVynNGa6WKUTmo6k0L1IEzh/q/qTr0XYJisdex2SGJ+Cxq1ZdEjDP5DK7sFB5MnakQnnzoM+qhbUQO/0pcyuuy9cOU1xiXb37itoqRDgJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767999099; c=relaxed/simple;
	bh=FxBy4FZqdwNrjXp7kUgNP2DTPQwGCA11DgvPugnUAQk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nMTY/Xc+KUsenykaHcN2vWcxraYW+qyydUHi8zcZ64hrbvOdBNH5uPZrvDM2B6XRuvEo+TYkAPHNQj3aKkvB34NR1aojXI4GmG5ZrOjaREhxwuWoLq79pE1vC9BCGSGsSDaW37nocSjwFx/GaJLdEyuaw+z8pVanvN2oEMhxePU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ajACC4zp; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-459fa8b6044so3141770b6e.2
        for <linux-kselftest@vger.kernel.org>; Fri, 09 Jan 2026 14:51:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1767999096; x=1768603896; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Qqxdc3iSw1oDJtxQ6sPbrPeu0O6MQwhvX4RqMc6t0PE=;
        b=ajACC4zpVV8JO2n5ZkWe0gZIvLd5YBX2/c+xd7zOxHqhaooazmFovM4mPHeAMh/oud
         mwaEVf6k7QyUOzDjvRj8I6tixhlgtfKVadoyQO0EWhUQ5BJ7xfIdz/d/CNL9Nv0tNDKK
         r0t/ErVQopgSjHf+Ut29aDcVfq2wa6RYPykkI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767999096; x=1768603896;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qqxdc3iSw1oDJtxQ6sPbrPeu0O6MQwhvX4RqMc6t0PE=;
        b=qq6sEjtYwGpbzUae0HIc5mPIuLOCY6Psmt/MSlXyq7DbSatfVvF5z0SBF6DEe5VewO
         9eO4CC10Bx0gdeABLR3K8+RYN6mWdc0U16nDD4HRbce8nKNUaBOEBfQrvQ0o/NVaa04W
         nq0B8SE1SgYP2tMK1Ul03oeDLMA7Q29YBXqGIerbXfgvWgMQeaMk+5hYE3JFR/YZqvFs
         ViCHCPOft5oCss5HeFu0YE0wHTjl/IyVDXs8n9iGve7dgfqQo6GNDHOy3y6MzTQ4Lu2u
         U1pfrEWWpW/e3Rpw7Jwbm9pHqjsj6M9v45yESqkjfluxcJIjchPRHBEZRcn2JEI8TpZX
         Hm3w==
X-Forwarded-Encrypted: i=1; AJvYcCW3sbk2sr5Zzt5TXIBOsr/gsYFN8fztGociZuHC6W3NyOipEnLMN0ah8P6io5R8yDDfhz0CKEniEcRDkQktMLY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOLDHByepvk+3n2+Cn0J7BQ7RjUBglP47H5UJwnrDtIzCGSeus
	YC3c/4I6Xo1X9rLIoB5hGvzHsjhW6j7ErR8ErLHBa860x1geHGV9CDvaEy5H8aSYsGo=
X-Gm-Gg: AY/fxX43j180gzjhUGqale43hpWqGiARma87wL9VH3rFW/6IVmYBfdcm0D26bOKpik2
	6GWktVgYKs0TtqpKjCVYU8/e35B6gP59Ga42maql+UbA/5wdyib13dN6/KWBtCN/tHtSEe1kW7a
	fif7ByvatDjjH28JuIWo4PrJkr0b1JmZUpH/8yp4S9yI8KHsllxRI77WrwPok4PhP4dJP3qc3W/
	8cEyl0KmAwwPMfO6xNGvr8kIu6rWfBFeC0anp2FzRlQrM9Hx4qW+P2fhfh+0pf1coD20kJaxwbE
	ef2CwobvDozXjBfiGDyMuNKHASkCwneyHj65TXd+LyjNywJQKerbxyriOVqzfKZE7HCkrUuD9La
	sYIVqgnkprOgPG3gCaO5iaKS1J6IbmbeTAERrTTPEqVhD5cN+fE/xaLgDpXVEETwBLczi5lJO03
	ToQr4qe6aSLdB6FQ/Xffh4Lv8=
X-Google-Smtp-Source: AGHT+IHHPWtAASdfA2cFXKfe0WnH9UpvIrOeltbh6InlGG6D5LTffSmeRA6Rg1LT0cGbIBcuXn49rQ==
X-Received: by 2002:a05:6808:158e:b0:442:82:3efd with SMTP id 5614622812f47-45a6bd690b2mr6631377b6e.18.1767999096215;
        Fri, 09 Jan 2026 14:51:36 -0800 (PST)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-45a5e2e8fb1sm5117059b6e.21.2026.01.09.14.51.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Jan 2026 14:51:35 -0800 (PST)
Message-ID: <1d52f1ee-0f60-410e-8c7e-c5fee0a92402@linuxfoundation.org>
Date: Fri, 9 Jan 2026 15:51:34 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] selftests/tracing: Fix test_multiple_writes stall
To: Fushuai Wang <fushuai.wang@linux.dev>, rostedt@goodmis.org,
 mhiramat@kernel.org, mathieu.desnoyers@efficios.com, shuah@kernel.org,
 wangfushuai@baidu.com
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20260109033620.25727-1-fushuai.wang@linux.dev>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20260109033620.25727-1-fushuai.wang@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/8/26 20:36, Fushuai Wang wrote:
> From: Fushuai Wang <wangfushuai@baidu.com>
> 
> When /sys/kernel/tracing/buffer_size_kb is less than 12KB,
> the test_multiple_writes test will stall and wait for more
> input due to insufficient buffer space.
> 
> Check current buffer_size_kb value before the test. If it is
> less than 12KB, it temporarily increase the buffer to 12KB,
> and restore the original value after the tests are completed.
> 
> Fixes: 37f46601383a ("selftests/tracing: Add basic test for trace_marker_raw file")
> Suggested-by: Steven Rostedt <rostedt@goodmis.org>
> Signed-off-by: Fushuai Wang <wangfushuai@baidu.com>
> Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
> V2 -> V3: Make the From and SoB match.
> V1 -> V2: Restore buffer_size_kb outside of awk script.

Thank you. Applied to linux-kselftest fixes branch.
I will send this up for the next rc.

thanks,
-- Shuah

