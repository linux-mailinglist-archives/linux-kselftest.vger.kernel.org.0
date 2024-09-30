Return-Path: <linux-kselftest+bounces-18685-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BECC498AD65
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 21:53:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 809722825FE
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 19:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C793519DF49;
	Mon, 30 Sep 2024 19:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GNlG8G6l"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 258A719D8A8
	for <linux-kselftest@vger.kernel.org>; Mon, 30 Sep 2024 19:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727726019; cv=none; b=MWaS0f6/bE2tmWN0Y8kG/yl9ZWmSYjEl6K16XNpKwVG78Sb/2pevPVLlXzm2IEPE9gfLj2YlODQTnxS9SeDQSkao1o+otoD7cohf4xrD1gST/B1sMmq8YVFJbw5j/Rxy4Ovg8D8hOLOK7g/9Q4pkE0kukUjUwlj56gKW8c8BHR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727726019; c=relaxed/simple;
	bh=EQ3niX/K3BJ+aOU+MibJwldr/HNSkC3v9ilvWwnJ/gU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U3OSZNdyT4hFuAqbJvWWdMly+CvrHXNCbi567w+5MzYkiAREjP4FoRmC5Lxf3Iw+yJzC2SSCu7qwIQVL3crY1PRqGiPYLhaUMMn0PXkJqXsaiT4r2maCfqMq31XmVWRdizC61MrwuQdffHTfGcy/K/hCluYMwImd0Cq8J1H1AaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GNlG8G6l; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-3a340f9dd8aso26416995ab.2
        for <linux-kselftest@vger.kernel.org>; Mon, 30 Sep 2024 12:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1727726017; x=1728330817; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y0c1OSnjeq19GYf4nlM2ePALyEZ+IQYTBspuIuHRqiA=;
        b=GNlG8G6lzaF+5ZzhNF1V2xcsFIQhSDyHc8Vyk6O2HZHnL5hhv0UXvuU94U8XWa9rxs
         UAoFGgutfAw2uMxImhPexHwhWUOgX/FQMEpd9Mb5GZ2oIGy/J3HFNf6UFPSbqOud34iK
         RvJmok9ja8rwubTV58T3k8u/7KnY4idSkko8E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727726017; x=1728330817;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y0c1OSnjeq19GYf4nlM2ePALyEZ+IQYTBspuIuHRqiA=;
        b=IzsmokuSoimQcVs00u2IWzdIEDGGbakEERRPz7LRnN+isqMnUkT4141BJjF6oBEvjs
         0TwSxowKW/5y1TOaRF3jCElrjv1wjokZeOys0+yRk0MDzltzlV60h13STg8QH3tWagqS
         e+7EQYfZY+TwOv+unYy6oQDgZfSpkT3HbspPlk6r5ogX8cOFjf0jRmUAOo6h46F2ADUj
         4vnfqWw4lc6DWea29SO3qpQUqsy1uekKzSp3uk+YhzBlEw0xEhBxdgNwN9+gNFHQZ/7I
         xLTLJjhaFMRZshONBpYHnwnMHfDjZRHjIZjnkmv7VW8JnvGDvuqn6r/jZRtED7Zlu1sq
         WjWg==
X-Forwarded-Encrypted: i=1; AJvYcCXiHE5hy68BAy9j3e73ey9WAgrQRDbJ2qkcXUiP1UIRCl25nk1tKvEdBGMIoMyqeC8ugUcRzC8K+gIXluIewwA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzv7u7Fqfi5OeTXHu2UcrB3V+RwzaINvOnzTdZrPrxxhthawiIG
	jWYO/xphAAsu+jlyEWGFK1Au8umZN7HBJ8uwbyRMeobqQ4AhTG6hYB/9ywjLUc0=
X-Google-Smtp-Source: AGHT+IEA40pmYmtY4M1k1g7RDrzT3qGarF+EhIg0WflDAvUWrmq7VmoGREawyq0GRW4ud7ur3WComw==
X-Received: by 2002:a92:ca08:0:b0:3a0:c23f:9647 with SMTP id e9e14a558f8ab-3a34514afc2mr121503965ab.1.1727726017160;
        Mon, 30 Sep 2024 12:53:37 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a344d925d8sm26298575ab.44.2024.09.30.12.53.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Sep 2024 12:53:36 -0700 (PDT)
Message-ID: <121f3d6f-bc4e-4366-9282-8fda40184e3f@linuxfoundation.org>
Date: Mon, 30 Sep 2024 13:53:35 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: timers: improve timer_create failure message
To: John Stultz <jstultz@google.com>
Cc: Gianfranco Trad <gianf.trad@gmail.com>, tglx@linutronix.de,
 sboyd@kernel.org, anna-maria@linutronix.de, frederic@kernel.org,
 shuah@kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <877cbz9x8t.ffs@tglx> <20240829153725.4437-1-gianf.trad@gmail.com>
 <54d1bcb6-b817-4ab5-be0e-aea34cfe0d5f@linuxfoundation.org>
 <CANDhNCrzWz0=5az1a9_-rzCYo42ex0aNbXgdso9sx55BAEp_jg@mail.gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <CANDhNCrzWz0=5az1a9_-rzCYo42ex0aNbXgdso9sx55BAEp_jg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/30/24 13:19, John Stultz wrote:
> On Mon, Sep 30, 2024 at 11:49 AM Shuah Khan <skhan@linuxfoundation.org> wrote:
>>

>> Jon, Does this look good to you? I can pick this up if you
>> okay with this change.
> 
> No objection from me, sorry this slipped by me.
> 
> Acked-by: John Stultz <jstultz@google.com>

Thank you. Applied to linux-kselftest next for Linux 6.13-rc1

thanks,
-- Shuah

