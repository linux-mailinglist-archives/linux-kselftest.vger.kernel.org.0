Return-Path: <linux-kselftest+bounces-12886-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD21C91B0F7
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Jun 2024 22:52:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19BF91C24DB6
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Jun 2024 20:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF1B41A0B13;
	Thu, 27 Jun 2024 20:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M6+VZ4C+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B8C41A0B07;
	Thu, 27 Jun 2024 20:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719521482; cv=none; b=Tu/SyYyKRJVgQBMgpfAWQO9DvPiarWn29jhsUmYnYF2UV0QxbZV8be+mVQxotdneXabnqicaLxDFIRZRjIhyf1FEb9hnxpwHaofxVezxusMQcXnw9/KG8yye1UZAB/UJ4CKKsIsKJdpxAw0E4UK0at6YNAn60YADChpfObYWTIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719521482; c=relaxed/simple;
	bh=/ALIBjOWtxJbVr9Wkw8mNnbXWL9/xNtOF34R9g/tscU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZDn2MpC2QTlFQ8DZKAmdv8yEJvZV3NNA5Plkecm/KyRHSmdH4KWQDPC3C3qVPxFRSWCzqMyoNFnosGfJsUtuabf722zHrGXJPReVCllfEfCRwf8wAvSiPvSjAXcQvO7OZYa5we3S9Wi0Z3W6gQuE01zGx95wbbz3NfkaxhescXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M6+VZ4C+; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-364fee5051fso290588f8f.1;
        Thu, 27 Jun 2024 13:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719521479; x=1720126279; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vbEIoELyueCCfotJl73Oz/mTbEWy5/7CioUiOn+VD/E=;
        b=M6+VZ4C+lVKUkIjA/UKhb9v0t6EbvwUZtY0aZvesG9eh0Djt8IW0U0AMUZ85Xkom/i
         XMlx4Wbl6QMkEnp29XVwTpiW3lQJO1QUjfidyfRP6HYsLX8M9kfRe7Wfebx8o2wgTnpr
         b0Zr/ZCADAG3b25BQMyu6iC9vJTYY9weNX/hZbNyclfXksC7AXsZLoZSsXyghBbG+SKY
         diqdmZnrBV/hOdMzj26gJAw3/4C9qfVOAEGr9nmC++D8mx6wB1YygR4MfNIdBWuKF4h7
         7PveDb4PHD16oLe3aa6+N1+Q1kvn2Lc6wrA3oLmoKt1wDvre5EPMpwqnERLrHXXSvWI6
         Q5Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719521479; x=1720126279;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vbEIoELyueCCfotJl73Oz/mTbEWy5/7CioUiOn+VD/E=;
        b=Po809PJZlvmdCw4dH02gfLTzUdxHWBgGIdM0hvqRr1gMZdYTeSAS7RUtw4mvQGbbZR
         p8sm1hcZOZKQ/gNWrrbsvNW/8lEtj4e/bryeoTMai3OIs14+Az+TcTJbcc1yM3faL4yN
         aXbwkS1QglfcrOS8toi7S70Ch/0JOHUMzPJqhNlAn3ijqFN7FIt3NGFwc/odb9bzqfIz
         njp7l2hU2hc7iKPfrQ9vfZ0wUbOrAsxa+82jwJrYcHjWh4cCK5a7PrmpdncTzqStYyql
         JGKJQfQ4jQdprj4nSj7AMtFLO0oG9HkGIkcNNnxeJv5UoNMmz1TpIxXalZzuWL1Yejux
         Y84w==
X-Forwarded-Encrypted: i=1; AJvYcCWaWLctSVrOtnfV9MUDnsnZM+UFVaJwgh2iMoVfX1msIrm6eGq7CbkiRES0ysUQV4hqOWqRV78YRw46AfuveT5TE56iW+yKICl+xfA0rMR+z6D4d/9oq+7nrcKSmBo0Y2HpDccytjHwAGbfWa15
X-Gm-Message-State: AOJu0YxMtG26zagOWdXofA0ZqQoKbNUNhD8zgs+j2fi7Mumzr4NimR/J
	40YQPmupFtfLX8AyQzl3BSXMctcr/OK33az8zRd0ydDlp2Viq8FW
X-Google-Smtp-Source: AGHT+IEtsBEK1OfkxAv6NipqhDZf23Ovj4cFZnsL2HIo5HHdI8+D9tpAI79mV/nIag0B6hUd2YkVLw==
X-Received: by 2002:a05:600c:3c9d:b0:424:8b08:26aa with SMTP id 5b1f17b1804b1-42491783f09mr93113315e9.3.1719521479436;
        Thu, 27 Jun 2024 13:51:19 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:d20e:7300:8731:b664:1f4a:5ab4? ([2a01:4b00:d20e:7300:8731:b664:1f4a:5ab4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256b0971d2sm6820465e9.31.2024.06.27.13.51.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jun 2024 13:51:19 -0700 (PDT)
Message-ID: <f76aac0d-4f46-41b4-8379-d6397272e5f0@gmail.com>
Date: Thu, 27 Jun 2024 21:51:18 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] kunit: string-stream-test: Make it a separate
 module
To: Rae Moar <rmoar@google.com>
Cc: brendan.higgins@linux.dev, davidgow@google.com,
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
 linux-kernel@vger.kernel.org, skhan@linuxfoundation.org
References: <20240618170331.264851-1-ivan.orlov0322@gmail.com>
 <20240618170331.264851-4-ivan.orlov0322@gmail.com>
 <CA+GJov6NBkPUmPSW6ir1Z0Gc9gFXP6dP-GhnoQU7nCRW0yXTLQ@mail.gmail.com>
Content-Language: en-US
From: Ivan Orlov <ivan.orlov0322@gmail.com>
In-Reply-To: <CA+GJov6NBkPUmPSW6ir1Z0Gc9gFXP6dP-GhnoQU7nCRW0yXTLQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/21/24 22:07, 'Rae Moar' via KUnit Development wrote:
> On Tue, Jun 18, 2024 at 1:03 PM Ivan Orlov <ivan.orlov0322@gmail.com> wrote:
>>
>> Currently, the only way to build string-stream-test is by setting
>> CONFIG_KUNIT_TEST=y. However, CONFIG_KUNIT_TEST is a config option for
>> a different test (`kunit-test.c`).
>>
>> Introduce a new Kconfig entry in order to be able to build the
>> string-stream-test test as a separate module. Import the KUnit namespace
>> in the test so we could have string-stream functions accessible.
>>
>> Reviewed-by: David Gow <davidgow@google.com>
>> Signed-off-by: Ivan Orlov <ivan.orlov0322@gmail.com>
> 
> Hello!
> 
> This is looking good to me other than the module description as noted
> by Jeff. That could be a separate patch since the rest of the series
> is looking good.
> 
> There is the checkpatch warning on the module description. But as
> David mentioned, the description looks ok to me. If there is a new
> version of this patch, it may be worth trying to get rid of the
> warning by lengthening the description.
> 
> But I am happy with this patch as is.
> 
> Reviewed-by: Rae Moar <rmoar@google.com>
> 
> Thanks!
> -Rae

Hi Rae,

Thank you for the review. I believe I'm going to send the V3 and add the 
module description there, to make the whole series as good as possible 
before it gets merged :)

Thank you so much for reviewing the series once again.

-- 
Kind regards,
Ivan Orlov


