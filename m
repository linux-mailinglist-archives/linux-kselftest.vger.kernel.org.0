Return-Path: <linux-kselftest+bounces-30326-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4840FA7F30D
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Apr 2025 05:09:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E88E917554F
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Apr 2025 03:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C10422DFA0;
	Tue,  8 Apr 2025 03:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="ZqsvqY7H"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D20243FB1B
	for <linux-kselftest@vger.kernel.org>; Tue,  8 Apr 2025 03:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744081755; cv=none; b=FqI3dN3iQ5DW/jFzHBv5Nm4bJsSXyF1okGJ//wWwXOI0TcE5m2/Ws5KXc9jSceYIwq6qZ3+3dqnedajYqiGAFOicHCKB0tL4hr/R2BBlQNHoFJFEjEKiNEZ0v7AL3GxBlV+nl46Di4qmqdEhygl3dmiHlnJeygYFK+y8iLntY9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744081755; c=relaxed/simple;
	bh=9bXBAqjwsMH7aUBaipURQXJeh98g4OYHsd+AsP53j/A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kN4cOYB0UKNNjYPv+PQ3IOKmd8QHEVtfOZT3lqTYwXqtnn5R4gYclUkVWUvFwpPGhaxVAVECc8kEwD2LmUm+P2gwpapu/LiFA8PqM+mwP1dzXPyssv5bH4dFZhbzOqWaNvZbr4rK5RHXJt6qbGdnERhY7YSGQXWSVjf0vlR/p1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=ZqsvqY7H; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7399838db7fso4452863b3a.0
        for <linux-kselftest@vger.kernel.org>; Mon, 07 Apr 2025 20:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1744081753; x=1744686553; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sPuw2Ymw6aEL6CjIynPBldeAGkGLHtU6wbCawr07JKA=;
        b=ZqsvqY7HC4fmkSX78/ef4WpQ3vQ4sg63ljJB3Uns60qwKxL1vSwCy4ZQ198CHUw1IW
         foVqCnqA8ZYL6w1RymGCEvECGt3CPQgZofwgQCS195DSyvJUzmD0pgIDLcQVK2Yn3Eo8
         uefs1d4lqnG/YI3KqZ7Mb1G7oypi2rQ7BDgNlp12Z6PPCnurJ02z0hC+S5wjKs0Ldfk4
         r2tcuM+ezjRHjCeGY6BGN6S5Ka2M9ZiT1Dgd3IOTVrzjCI/HxXzxSPgWiuHz/N9n616j
         AWWCl+00hFBEj1/gmS2sr9iybrtR815AQIIo/9KgvinLM0BV6BjU6LsaFdBVJ2OR6VwJ
         70zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744081753; x=1744686553;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sPuw2Ymw6aEL6CjIynPBldeAGkGLHtU6wbCawr07JKA=;
        b=BwmUl3L8+aKh1fMqagrbiEN0Uy1GmQf9QX2TahygfufRuvk0Yqi7gUdYpKA3rjZtBZ
         cVuopeGNcjdspl1CXePbjBy6/HTznKT/m/ZTuJnLx3eem2YIj6MM/VdPsgfyjy1B/e2h
         z9lsRBJp44arWghrYvUw33C4B2i6wL+jkANQIfwj/m7ucFKZ2xbsxsF4xtFi9wzfUEIo
         FApcYZ8KX+Hr5XIXCx9kSSOYT2rwNMycuqDuFUecnLhm8ch+6D3gS5yRjY1HyVYduym4
         oH/brMNErGR93cCcTrIRTRz2fSynv242EQEgAG/ii9cumc/KNVuv7X4GuC1nCJ/+X9E8
         yUtg==
X-Forwarded-Encrypted: i=1; AJvYcCWz//INiqSwKB7QQwV0RDOzuzIBJMZZOe89YkR7NW5S2CGa/Xd0K/s0+7h1NLjBr0ybcYCU2UBq0gMJsa6O2Y0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwY+BFtLafn1kAaDQAOknYI2ydnms1ZiL4gC0O4gs37VsZRZ6I
	LDDSpBMk7uZT5gPF8J6stSgl5EZi+MNoAfuxd10h8PvduEpgd0LX+9Luc9PPg+E=
X-Gm-Gg: ASbGnctIcp13lI9heCVeCsSkQ1cGoJzcaR88UNiCf938Zguu/vlEE857eLGakze4dPd
	AZ1FnCLCJAak3+BTdX8RsjKnQf0cxIvTauTmZeEbr/MvEX2V/lsPUcdVJXBnAHSZAIsFI3R5Sdg
	wLA3SGwQzRKqGlyZ5X6bC6WeOdlR2ItLw/CtPW4bYeNnWYXtXyHmPtniIO+e9BvlvO1BpZ7sMgo
	8xOyZkWPsDDgd54HRNSGl/dVi89wV4fxVgKd7TrGGQNpsZW9R8nBxwlKCH4cgzAGxVoOauQcYDP
	K07Bto57/Ejq9GoBhUi2ySgqXj9KwDo6ViSUWA8kHtt42Q9PdBU=
X-Google-Smtp-Source: AGHT+IEwH96uV5EtxaP2ImURK29zECcTWq13GuIUlA74sMLhltZ9xgPDSZDjYcQ7xrW9wkCK0hHxtA==
X-Received: by 2002:aa7:875a:0:b0:736:b3cb:5db with SMTP id d2e1a72fcca58-73b9d4019ddmr2344723b3a.11.1744081752836;
        Mon, 07 Apr 2025 20:09:12 -0700 (PDT)
Received: from [10.3.43.196] ([61.213.176.11])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-739d97d1881sm9372280b3a.3.2025.04.07.20.09.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Apr 2025 20:09:12 -0700 (PDT)
Message-ID: <0de20ab7-9f1c-4a13-a8d2-295f94161c4e@bytedance.com>
Date: Tue, 8 Apr 2025 11:09:07 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Re: [PATCH] selftests: mptcp: add comment for getaddrinfo
To: Geliang Tang <geliang@kernel.org>, linux-kernel@vger.kernel.org,
 mptcp@lists.linux.dev, linux-kselftest@vger.kernel.org,
 netdev@vger.kernel.org
Cc: matttbe@kernel.org, martineau@kernel.org, viktor.soderqvist@est.tech,
 zhenwei pi <zhenwei.pi@linux.dev>
References: <20250407085122.1203489-1-pizhenwei@bytedance.com>
 <ae367fb7158e2f1c284a4acaea86f96a7a95b0c4.camel@kernel.org>
Content-Language: en-US
From: zhenwei pi <pizhenwei@bytedance.com>
In-Reply-To: <ae367fb7158e2f1c284a4acaea86f96a7a95b0c4.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 4/8/25 09:43, Geliang Tang wrote:
> Hi zhenwei,
> 
> On Mon, 2025-04-07 at 16:51 +0800, zhenwei pi wrote:
>> mptcp_connect.c is a startup tutorial of MPTCP programming, however
>> there is a lack of ai_protocol(IPPROTO_MPTCP) usage. Add comment for
>> getaddrinfo MPTCP support.
>>
>> Signed-off-by: zhenwei pi <zhenwei.pi@linux.dev>
>> Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
>> ---
>>   tools/testing/selftests/net/mptcp/mptcp_connect.c | 12 ++++++++++++
>>   1 file changed, 12 insertions(+)
>>
>> diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c
>> b/tools/testing/selftests/net/mptcp/mptcp_connect.c
>> index c83a8b47bbdf..6b9031273964 100644
>> --- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
>> +++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
>> @@ -179,6 +179,18 @@ static void xgetnameinfo(const struct sockaddr
>> *addr, socklen_t addrlen,
>>   	}
>>   }
>>   
>> +/* There is a lack of MPTCP support from glibc, these code leads
>> error:
>> + *	struct addrinfo hints = {
>> + *		.ai_protocol = IPPROTO_MPTCP,
>> + *		...
>> + *	};
>> + *	err = getaddrinfo(node, service, &hints, res);
>> + *	...
>> + * So using IPPROTO_TCP to resolve, and use TCP/MPTCP to create
>> socket.
>> + *
>> + * glibc starts to support MPTCP since v2.42.
>> + * Link:
>> https://sourceware.org/git/?p=glibc.git;a=commit;h=a8e9022e0f82
> 
> Thanks for adding getaddrinfo mptcp support to glibc. I think we should
> not only add a comment for getaddrinfo mptcp here, but also add an
> example of using it in mptcp_connect.c. I will work with you to
> implement this example in v2.
> 
> Thanks,
> -Geliang
> 

Good idea, thank you Geliang!

>> + */
>>   static void xgetaddrinfo(const char *node, const char *service,
>>   			 const struct addrinfo *hints,
>>   			 struct addrinfo **res)
> 


