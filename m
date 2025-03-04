Return-Path: <linux-kselftest+bounces-28229-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99D0AA4EADE
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Mar 2025 19:13:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 558FA1895898
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Mar 2025 18:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B39027EC7F;
	Tue,  4 Mar 2025 17:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NQzlvL4P"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C05208997
	for <linux-kselftest@vger.kernel.org>; Tue,  4 Mar 2025 17:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741110558; cv=none; b=QT6jzEaX1OcTD9If0R2PcvKGCxonUNsj0N/a7EhgVav07XklJCQu0zV8DIwLw6a07UEyXMrdEanvgLA6x7yFto1QYhBR9j6UuVz/StasKZR4Q7rHMoUdDURfyGlAwuPokUanQ1qqSI2e1wu5eqtNQAL2ZVbh3izW+H3dil3qstY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741110558; c=relaxed/simple;
	bh=a/NsExaXFh0brcXTlOrd7Y9Oa2VoHQLFMML8Cnz3x8M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CixMQakYP5lTkO6YOLERkO5xxL45fo6DOfnTU0AYptFszJ5sD3etNgoGKlhcCJ8aW7/zoq9m2rEEK5fWUNAPv+E5ceswBb+meQ2aXIlGRcFFx7feybT1CCiJ3zxoEdz5e/Z9UXYMPtenSfwbRllXFlWzXuHovSjbKPfxkqlz8t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NQzlvL4P; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-85add67e9c1so1799239f.0
        for <linux-kselftest@vger.kernel.org>; Tue, 04 Mar 2025 09:49:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1741110555; x=1741715355; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FIQyE8Y/Wo/k2rg3+kTPzMkjWvoAdVITwTvTECg9USE=;
        b=NQzlvL4P3ffJyregCzibatB6h+EOd/9u2ob2LaC66DSLUJUIY0VqvLWeSBQwpA7Ggh
         DQSZB6HVAAigouET/dQOPg/d3ee4W8vzvujgEeQnJVIrCEH4YfPLzpIhRDoF7VVbD1z/
         vj43j9Lvc5JzmBO513KbcxbUwZIghQsTtThkU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741110555; x=1741715355;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FIQyE8Y/Wo/k2rg3+kTPzMkjWvoAdVITwTvTECg9USE=;
        b=GHAu2EL865Ervjxctz7jsyvUClYJZUaeYzeLuN2Yu5o9qNVlVDE9x397TegdLp0MLm
         HOnITuMUeWlN5asVHwYGus02Ej6lIedAiO3BVNB34qRlUYFWQi703iOkc5a2w0PsC+JV
         WTGYQSrksQvFLf9/8GzkS2hza39xVT8Su6t9hLyJX8rt4B0+Pqwopp4PjHsPPht88Yu0
         xhUnsQUJuBQAmzJvaWTy+YqmWd52ou41zrwkzF1IB4jK1cQ0p/8z1FL3Cqn+bpjomfk1
         NKtHC6zg7wBBPtQP81/QexY+e573cpC6LfK1PIvv+HCKbmm39jlBZ0UBcmWarr1eGP8a
         KHTQ==
X-Forwarded-Encrypted: i=1; AJvYcCW29AkW/kOWluoY3Xj8G6fdySL7WirW0rp87NDa1gtAoeIczftN7HY9lU8SoWk90r5wku7o15PGPDHNtWJgMz0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHZckDqkSAC+GroY3Pwg5y5d1bg8VyBkw0XWMr1+SYLaHUQivW
	OFpGXbDC26GHKPD57BXXqbPYkeSGvYVMeWMG4Q1uVdC4zIdETNoXKQwOEQNZOwU=
X-Gm-Gg: ASbGncuebC7D8qiz/dwUkLS4+4gOrcPiZ/pOOXqG11i6SaquT1b3vI1woOOZdvcsdaW
	QVLwC1SF6VA2YKvUoWbGgqflNSZuNca9r3Bhdk0Itu4umfjHf8v93GXmzGP8T55XApEzMWDXDJM
	/DfYFJ6OaSUTdewiIehXiByWVY3yxEHv0UpQhGmoyQyMBczzjpTSG6uaIhedVlNT+GR5kwR01sR
	6VJROhi8aQY4IQSTLKQuOOX06Y2czTxgNg1/MtKbUdELR58coYZ2VCeHbL6KMcv/70rKkQ+Kv5G
	D8VIGBGxj4CPGsvPoTSWsBl3HzlzsWqhnwcIWIhdpiuGI+fGhXTgHaY=
X-Google-Smtp-Source: AGHT+IFe/EZGXyCyM4u01MW+pkyp+aV9q8tehK9bM2e7HADyRWDjWbe46QsDS+SMYJ3Ljp5Ifn3NgA==
X-Received: by 2002:a05:6602:370f:b0:82a:a4e7:5539 with SMTP id ca18e2360f4ac-85aff6300a8mr5572839f.2.1741110555067;
        Tue, 04 Mar 2025 09:49:15 -0800 (PST)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-85875133ebbsm295183839f.28.2025.03.04.09.49.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Mar 2025 09:49:14 -0800 (PST)
Message-ID: <a9628a00-2bf3-4d86-8e41-c596079cd8f0@linuxfoundation.org>
Date: Tue, 4 Mar 2025 10:49:12 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/ftrace: add 'poll' binary to gitignore
To: Steven Rostedt <rostedt@goodmis.org>,
 Bharadwaj Raju <bharadwaj.raju777@gmail.com>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com, shuah@kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250210160138.4745-1-bharadwaj.raju777@gmail.com>
 <20250303183625.5acc59ec@gandalf.local.home>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250303183625.5acc59ec@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/3/25 16:36, Steven Rostedt wrote:
> On Mon, 10 Feb 2025 21:31:34 +0530
> Bharadwaj Raju <bharadwaj.raju777@gmail.com> wrote:
> 
>> When building this test, a binary file 'poll' is
>> generated and should be gitignore'd.
>>
>> Signed-off-by: Bharadwaj Raju <bharadwaj.raju777@gmail.com>
> 
> Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> 
> Shuah,
> 
> Can you take this for your tree?
> 
> Possibly with:
> 
> Fixes: 80c3e28528ff9 ("selftests/tracing: Add hist poll() support test")
> 
> So it should go into this rc release.
> 

Ooos - I applied it for next for Linux 6.15-rc1 since it is just
a gitignore change and not critical.

If you think it should go into this rc, I can apply to fixes and
send it for this rc.

thanks,
-- Shuah

