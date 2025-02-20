Return-Path: <linux-kselftest+bounces-27110-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F6C1A3E5AC
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Feb 2025 21:19:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D35B27AAD5B
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Feb 2025 20:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C80D1E633C;
	Thu, 20 Feb 2025 20:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HsJ392q/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FAF61D5160
	for <linux-kselftest@vger.kernel.org>; Thu, 20 Feb 2025 20:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740082743; cv=none; b=Ztv6Vb2rJvXqNIHHN0DK9qdas9lR+ETdrACMrFcUVyiWpqGEmVQ8ATO5ll6QjvJVQoO0l1hBZnrs9lSS1u8Ygwd3akrGrKwDptl33F+lC6lh9pt61IEq0drLOhW6lW/UUSKqllnTPevbyVy+c55CmM0gjUq0PQWV1kEhJMLocPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740082743; c=relaxed/simple;
	bh=ufNNg2rNOkDICBHFg0h+S6poNghZSgivhHBZkJrRIyE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BXqBRsge3IR7TFAjq+1q8ZJmq6sU3/ncfEPnnhalTL5SPRP7nUEaDCKMrIGr7sIgJ+dI0kdXBJGG1VQFlfnexVQl0aFIk9xw/Z5SAdNEZM2Rto0Vvvu7wCI2/YrrE0Tq/mOBkQolW2ipM0RyN7P+6mhMr7pPwJhJe8fClaWdetU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HsJ392q/; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-855a8c1ffe9so41435039f.1
        for <linux-kselftest@vger.kernel.org>; Thu, 20 Feb 2025 12:19:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1740082740; x=1740687540; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g/Ezzc0bR8B+p/byl9E3hgmtjeFWLzb0FMiOjqIXu3M=;
        b=HsJ392q/wkvDvLQmauQAj8II+0R2/QAaYU27Crjm/FAnRmhN1cW1bI+7iMGZOgSnJz
         HDH2HupVeUndve4vs45NEbAOrLG2iRQEnYWZPwdCUWtvTaeLpZPBW8efug5CFFh29/2s
         J9mOMu2vKMts9wrnk8t1TwTk2YBAWAM7Nij9g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740082740; x=1740687540;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g/Ezzc0bR8B+p/byl9E3hgmtjeFWLzb0FMiOjqIXu3M=;
        b=eywVhvAXJ9a3hJKjkU1El9TWz0IGt0kXLZROobE7uJnRzXmK0A42MBQNwpcpuhr7el
         rusqaupZm25LKn3bbzJvHtz5Q+jMZx0PcXYiVrYQlQYdoJnCDHGh0og4NtNmC7H5hI5M
         wU8oaiiOxsK74YdWxAmkdEkECFowM9ojJhzyuiWK0DEHLpdNYCb4cQQrTiqBa5hf7ut7
         S3Zu2fn+0dapCW7PDMoxp1jEGcyZSuDd2/zh4sErq1cfFLUVKwRZxl2qR7rcUVPL5gc7
         gSzMBTzg8Ls3SO/qUT5AjodSuA+mw6KkJbmaFH5zKsak7ELH8WHd1Om2x8rnnxUPKtea
         p7PA==
X-Forwarded-Encrypted: i=1; AJvYcCW9iaJBypkfBl5CGZHcA2ltgcIdRZzbsno62g6ocaoHkD/FH2GD1VFtjFcsLoeKR4JBv6SOwbPj3wUh7Z+76UQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8KRGGYiWkwc6RneK3zvbctG4LGsJWP43k8shNkyFW/A1KEz9f
	cZYs3uKPObMmR199yrM9TjfxWQrQJA+SCS7axh+oYwP/JCUAVNU4ECfCKAcl0rY=
X-Gm-Gg: ASbGncuA6pgXt3fylnm0WLR8v6uxWyXm9O7EcpqIOWxHykAuuk/PUcDv1bYmATUDocy
	nSvoXkc+Ux/4kDNjSUVbStxcRL2/XAAdFzrXgJ7QZ4I/wo6vYdlWjvJiRdRKi7zQOsRMufKU7gy
	eL+eKVVQFfJm6E85bqhjQs6eUlXqoINnFlB3yYknylN1y8wjlEgRMcKPuk3ralOoNWozKkYMa+Z
	dbjZYs3JW1XFXi55EpJKAPVGlgQVHawdA9Xc5IqTve+pAECFeDH1YtLjHX6v7A0dJ4vAgFrQ71A
	J/MeTwdGBIHavq3zesTLBfc05g==
X-Google-Smtp-Source: AGHT+IF79ckeVt665lYdXJU7VJLqlE8Q15fFZXr1QkP6ouOQoPFieWVNlE/ofs7NRQPHbTbqq2wz5Q==
X-Received: by 2002:a05:6e02:378c:b0:3d0:d0d:db8e with SMTP id e9e14a558f8ab-3d2cae49deemr4900315ab.1.1740082740482;
        Thu, 20 Feb 2025 12:19:00 -0800 (PST)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4eea680c803sm1719151173.14.2025.02.20.12.18.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2025 12:18:59 -0800 (PST)
Message-ID: <16def228-662d-4db5-bb1f-7d79c4ed3ae6@linuxfoundation.org>
Date: Thu, 20 Feb 2025 13:18:59 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND][PATCH 0/3] selftests/tracing: Test only toplevel README
 file not the instances
To: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>
References: <20250220185759.811830333@goodmis.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250220185759.811830333@goodmis.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/20/25 11:57, Steven Rostedt wrote:
> Allow some more tests to run in instances. There's a few tests that
> require something in README to be present to run. But currently README
> can't be used for instance tests. Fix that and then allow 4 more tests
> to run in instances.
> 
> [ RESEND to include selftest maintainers and lists:
>    original: https://lore.kernel.org/linux-trace-kernel/20250116012009.840870709@goodmis.org/ ]
> 
> 
> Steven Rostedt (3):
>        selftests/tracing: Test only toplevel README file not the instances
>        selftests/ftrace: Clean up triggers after setting them
>        selftests/tracing: Allow some more tests to run in instances
> 
> ----
>   tools/testing/selftests/ftrace/test.d/functions                   | 8 +++++++-
>   .../test.d/trigger/inter-event/trigger-action-hist-xfail.tc       | 1 +
>   .../test.d/trigger/inter-event/trigger-onchange-action-hist.tc    | 3 +++
>   .../test.d/trigger/inter-event/trigger-snapshot-action-hist.tc    | 3 +++
>   .../selftests/ftrace/test.d/trigger/trigger-hist-expressions.tc   | 1 +
>   5 files changed, 15 insertions(+), 1 deletion(-)

Thanks - applied for Linux 6.15-rc1

thanks,
-- Shuah

