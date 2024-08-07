Return-Path: <linux-kselftest+bounces-14973-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FDBC94B19A
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Aug 2024 22:49:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBEBB1F22504
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Aug 2024 20:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 087CD14659F;
	Wed,  7 Aug 2024 20:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QGsRVJfv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81257145FED
	for <linux-kselftest@vger.kernel.org>; Wed,  7 Aug 2024 20:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723063765; cv=none; b=QAlcUS8SB/ZElyUsBl2XyzKfPi4P7q6t+QNYTIHwliKPQRnx3+2bzDy6qkboJVE7nzjk94BDrvAycsb3mCKjsoQd6JIG6/ISx6Y1CCswOU1PKw/xYdyCHBpnkJ/E3O9lXpkOI4RlYgvGSXAfd99ZeS6sU7lD1DOwm3SzrxYVgPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723063765; c=relaxed/simple;
	bh=A4ifWneIPuKomiFloatclvYw6Xk4unBhHN3C0QE/lo8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NJg0yqZHvsUE5MaD4tRfxkU63k5pm+OswmwCFeTIKuSIHE6A87PMvNLh0QfcU4fEuqAZ/2ZHzPOSEusaPIyGzhalzF7hlJaCJ3ThIeKUyjY1IEylgOqwbVZNc8KtMsjp3e1//w8lnVUVCWxtrzOIquqeiiXiSXwl3HY5fme8Cyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QGsRVJfv; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-39b37637977so221815ab.1
        for <linux-kselftest@vger.kernel.org>; Wed, 07 Aug 2024 13:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1723063763; x=1723668563; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A35BH8i+y+G8lGp+6rsc8DzC+k6rWSsJ3H+i3Ublu24=;
        b=QGsRVJfvlAFqqJKWctZsP2dz70cnlo8eJllS9ev8pJhI6SjgBxgzem/XDIEI2cC4Fk
         co0UNaudAY3qgDH6T/zXauFZQH0XndgOkHXw4x+7ibbu6I/0ybFMEM0swzJ7okzwcw7q
         Mk7s4/cZuXvVF/vqByZjfRX1JxMGHGBfuvYlE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723063763; x=1723668563;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A35BH8i+y+G8lGp+6rsc8DzC+k6rWSsJ3H+i3Ublu24=;
        b=nVWwCEl3CQWYB8xuCPfdzq2iqp0qfIGGn+9HSCm1/xe9q2ZXVdRP7au/TVf7OqCCDq
         EMifdgsw2eNCMjgYJ3akrA5H9yKiu3Ha/Xme4kHkcsx8SoY9Qz3DjK7Ve6/jAZb0MMS7
         ZWs7nscBpq+15FtFqYEpfW1bYZLbV0xts+bhlv00coKRxnZBtIc6gZLHDEpHKmT3RVBf
         LV2ADfMvP8jflUl9h5aW864MK0v5nyDZaMtoKHaMzOBoxtmoaxGOVuNRvj+6SchPNxk9
         JsFdYWV+4phbUJXB9bq4BE9p9mleTs53qYGKvoMuh5t0rHZO3cBrgjJt/UghlFy4frgl
         Yczw==
X-Forwarded-Encrypted: i=1; AJvYcCVFdaDfi8DkXckeL6fYSyuMuXMWcqjBctEwMo9mr7/rAiyRe7SHqIEgrSILU7nHpsbysKDVbyMRvXkSnCL1OGw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzM3LO5SQX8ACRQdkBsxNHSrpdOdFJQShvYZAsJaMlc8UuE8tCi
	t9N86aXg9OkYRHXDrEk44GhdGRUswS3zTP6g73FehGUT0rIueRkgK06ztzabV9s=
X-Google-Smtp-Source: AGHT+IHC1uRe6tBWqp0tbGMzIoqWnCCrA+bdekxnsQrOQFruZsBen7mj3WNpnf9rnrR3Xd5pZgqJVw==
X-Received: by 2002:a5d:9052:0:b0:81f:9219:4494 with SMTP id ca18e2360f4ac-81fd43e5cdemr1169419239f.2.1723063763601;
        Wed, 07 Aug 2024 13:49:23 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4c8d6a27813sm2969273173.96.2024.08.07.13.49.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Aug 2024 13:49:23 -0700 (PDT)
Message-ID: <81512257-d6ab-4488-b400-aeeda1d38649@linuxfoundation.org>
Date: Wed, 7 Aug 2024 14:49:22 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tracing/selftests: Run the ownership test twice
To: Steven Rostedt <rostedt@goodmis.org>, LKML
 <linux-kernel@vger.kernel.org>,
 Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Ali Zahraee <ahzahraee@gmail.com>, Shuah Khan <shuah@kernel.org>,
 linux-kselftest@vger.kernel.org,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240523124541.7dd4cca9@gandalf.local.home>
 <20240614124151.33ee0dc6@rorschach.local.home>
 <20240807162900.32c8e32f@gandalf.local.home>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240807162900.32c8e32f@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/7/24 14:29, Steven Rostedt wrote:
> On Fri, 14 Jun 2024 12:41:51 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
>> Shuah,
>>
>> Can you take this through your tree?
> 
> Ping!
> 
> -- Steve
> 

Sorry for the delay.

Applied it o linux-kselftest next for Linux 6.12-rc1.

thanks,
-- Shuah


