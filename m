Return-Path: <linux-kselftest+bounces-5413-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 487CA8623F8
	for <lists+linux-kselftest@lfdr.de>; Sat, 24 Feb 2024 10:41:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D306C1F22807
	for <lists+linux-kselftest@lfdr.de>; Sat, 24 Feb 2024 09:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82CD01B96E;
	Sat, 24 Feb 2024 09:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="HmdkCEdD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E93F175AA
	for <linux-kselftest@vger.kernel.org>; Sat, 24 Feb 2024 09:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708767667; cv=none; b=JKlzzq3iIb7OS7v7r8JqtDvEiVd8KqJiE31sVIKX9SUoDm2E7ylm74yAbLVH6xp4gIL0bHJJ/UU6HpyXIovCkGNKDqGCDZVpGEiI7ejBDCsD0VjCmRR8vMKWTRFLrI57mkvNlKAhIWJ2ndPfEuQHWX6j+GNUO6FsCrfMQ0vWn9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708767667; c=relaxed/simple;
	bh=UEFxROxE6KP7hbsHlQuKhYmjvKut4tKaZLEG/90dHnY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kLo+9NtE76/xjI5FigUCyJ8dy0Q4DIWxPTMLB+Bx6KnO/Zmhv5KwvkadQ2pfvG2xnYD7T7LvTHCS0BNPTmJvKadP+ewhaYYY4Jt7njmBlsn0qlqPUHzk5k9iHwS2o2E9WGYkTNAGskLOR4WbWNjdm8G7k053gvLn14V/Ul06aE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com; spf=pass smtp.mailfrom=arista.com; dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b=HmdkCEdD; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4129f291fa7so477895e9.0
        for <linux-kselftest@vger.kernel.org>; Sat, 24 Feb 2024 01:41:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1708767663; x=1709372463; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9v4R1LcjkjY5cWdbqRcV+KS7qfSyvUTSBFeDxDIrljY=;
        b=HmdkCEdDBEb0hUoPXbEx8PLuzMUGEp+YK5OOFbuDLvD4AuJz56an7hZApsCef3o7hH
         XR4Q0+Hwt+ARkoS65145mXVm8QpemZUbVvdFURaLbm8KbK4CW+gE+M/gZab8REYL4kWI
         Ja/EGOjPaXDjavbcZDaS310vFcCAUjUlu7Qc9HBYdvzy7eZEmLYu2hKHYiLNeNqsAM/R
         FBq2NY7nNa3OS38RipInsdZ3xPVyY7op8qo+X4ssGXp/URVRWtuOAtM2p+XXDNN44KFo
         lMKq6QdwffH31Wdsof+9MZRO/81LwWE3jNAWPSCcMQ7o1q5xSCKL8aA/0U0WyI22G54o
         RxJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708767663; x=1709372463;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9v4R1LcjkjY5cWdbqRcV+KS7qfSyvUTSBFeDxDIrljY=;
        b=E02VxbwA7xTeaYFl0N4ITsfgvKGhSiiolj9eAtxo2AbQKyATZM9dARTFM31GQBSVf7
         VjEyvm7319ZMXhi6g6jMt5xFOnLuEnriTeBYeIMTeJwF88MaAUtlfA0zDqdBf7hB9vP3
         AEKk1b2v52bR2EtEJIQLqGsHLWgWbkCewEDjgCpy9OWKMZ8rlxtEqVlCRxRir34bbq1L
         C5Cgjp8mtTKV8KRGp61O89ZRkyVQwZwsLmukaxMaM6ZCIAU4s6FJd49Fs6/4ftSLcYH3
         NAZ2Il2nH6NeChllAsowyLF1FqO823YM+sXbk5snYmqjtpAxvhyARArERKbcQ2aDEfVW
         4UVA==
X-Forwarded-Encrypted: i=1; AJvYcCWQBImKd6cdA2fIUNOvMaM+TKF0kbKJ+a1KWgqd+8YLuhdKU9tpGdUvEFZm7jGEVhhrcLRYffhYssddmsPowVxB8PRfVyAfhuM3XrOKrSll
X-Gm-Message-State: AOJu0YxDGITVFOMJTXUmRjE/AYlHZaz/U0GvaDQVFLwnoz/RiC4p5D7e
	j+i/D+Py6V1afXxQcdGtPQcsAIpzidBbI1FIvyu/bo9WcXiz5eKIRBAvS7TONg==
X-Google-Smtp-Source: AGHT+IEyK9H6qTd17qmPlYqNBSh17XoUaXYRRxKBzbl5Zs/nMraTHjuqZ5EBJfQ2dbtVFWQsGALWug==
X-Received: by 2002:a05:600c:1d07:b0:412:6015:3dc5 with SMTP id l7-20020a05600c1d0700b0041260153dc5mr1121291wms.14.1708767662930;
        Sat, 24 Feb 2024 01:41:02 -0800 (PST)
Received: from [10.83.37.178] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id f14-20020adff98e000000b0033cf60e268fsm1509225wrr.116.2024.02.24.01.41.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Feb 2024 01:41:02 -0800 (PST)
Message-ID: <ff642d38-17b8-4b12-b2ff-a819b193b2e6@arista.com>
Date: Sat, 24 Feb 2024 09:40:55 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 03/10] net/tcp: Move tcp_inbound_hash() from
 headers
To: Eric Dumazet <edumazet@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 David Ahern <dsahern@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 Dmitry Safonov <0x7f454c46@gmail.com>
References: <20240224-tcp-ao-tracepoints-v1-0-15f31b7f30a7@arista.com>
 <20240224-tcp-ao-tracepoints-v1-3-15f31b7f30a7@arista.com>
 <CANn89iKB3ov_rthyscWn=h4yxmhReXAJzHu9+dOdpzPA8F=C-w@mail.gmail.com>
Content-Language: en-US
From: Dmitry Safonov <dima@arista.com>
In-Reply-To: <CANn89iKB3ov_rthyscWn=h4yxmhReXAJzHu9+dOdpzPA8F=C-w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2/24/24 09:30, Eric Dumazet wrote:
> On Sat, Feb 24, 2024 at 10:04 AM Dmitry Safonov <dima@arista.com> wrote:
>>
>> Two reasons:
>> 1. It's grown up enough
>> 2. In order to not do header spaghetti by including
>>    <trace/events/tcp.h>, which is necessary for TCP tracepoints.
>>
>> Signed-off-by: Dmitry Safonov <dima@arista.com>
> 
> Okay, but what about CONFIG_IPV6=m ?
> 
> I do not see any EXPORT_SYMBOL() in this patch.

Ouch. I keep forgetting about that case, will fix in v2.

Thanks,
             Dmitry


