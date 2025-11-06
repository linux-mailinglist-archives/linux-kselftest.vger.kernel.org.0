Return-Path: <linux-kselftest+bounces-44952-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2893EC3AAB9
	for <lists+linux-kselftest@lfdr.de>; Thu, 06 Nov 2025 12:46:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91CA61A46FD7
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Nov 2025 11:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D63F3315D46;
	Thu,  6 Nov 2025 11:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GIWA4qRL";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="XHlRYePd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29316314B8E
	for <linux-kselftest@vger.kernel.org>; Thu,  6 Nov 2025 11:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762429552; cv=none; b=lkjHpCIT7cp245hwIokiAHVRYwtcsAf1jOpgEKXNPZh9fxlJpUguIM6FrV74i+UKJ5jyfQilsqAtx3M3uhd57FJWzWCrYIguvNOGwVrPr+XkstQwNX5E9qdZwwDyeTEzPI5xBWfdSGfJkypEX3MD4DHlntc5VZUBnDrA9gq552g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762429552; c=relaxed/simple;
	bh=jIFC1QZiGfv9alFP7RwEchylh/aQZeL7acaxJFCdZbU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=e81eBBHYwRqAZORwNyK04+3/W5YZ7piDspcDwLlvhVubqSkU9YDz5VWeN9ljJF1TmzqBiQfr3EAsbTy4Hy+qLlsE8OQen+v7w3V8/WwVhAFPwkcDWwe83oKofifflAAN2fcT6Xka8j6eGHNALecnu13lqVRf/Ipn/LaWU2jX0jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GIWA4qRL; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=XHlRYePd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762429550;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KkH7CgwKazWdbtvwueZlrKCpxGFwLdOfsSGfy29m5CI=;
	b=GIWA4qRL1KUeg7j6iQeg7tjqHU1XAynBQ8TiABNUwabzWTRMKveN0XLbvxaZ2jkL39O3Vd
	tPxSLTjjnII/BeuaWWLBRbldq8cyynXSuPWg0OUypxKCs+Pxn/FAiJ7ZHKQxDGLP0illq/
	icYkT+XarCxCqWXHhjx0wejGzbI3RqI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-552-FoAyVHMDNFaWSrn9j_yWdA-1; Thu, 06 Nov 2025 06:45:49 -0500
X-MC-Unique: FoAyVHMDNFaWSrn9j_yWdA-1
X-Mimecast-MFC-AGG-ID: FoAyVHMDNFaWSrn9j_yWdA_1762429548
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-477563e531cso8461445e9.1
        for <linux-kselftest@vger.kernel.org>; Thu, 06 Nov 2025 03:45:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762429548; x=1763034348; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KkH7CgwKazWdbtvwueZlrKCpxGFwLdOfsSGfy29m5CI=;
        b=XHlRYePdKQiZGkomofSZBegEpmEeekrEKFB5SNyGXUWyTG3ZVzFGaQVF28SCrJcAEa
         F64dkisCdQswrFCY9YVEiGo0yS5ZH/lxwVv6pD196/k5SGkBLSIga57guo2SzTcVcqVO
         nbZC5B1/aGqQcG6eCpCtyHsb/5wfRbp0CHHNQkg+UCpP+hDQGbKYuiN4Z+Cf3qs6Fsd1
         UWzKhIPJKQkmM/6RHjBGiX4Xvcsc2wBfYrTNliumxdcqhER/ecTPY+HDhk4cHm/+/zMS
         WyE4WamZ3XmPnta4H767oLrEXWZlv7anmXMUo/IfLIIoxHAAZcx5W3CC9FQHQ3GpEPpM
         yVEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762429548; x=1763034348;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KkH7CgwKazWdbtvwueZlrKCpxGFwLdOfsSGfy29m5CI=;
        b=pTa75IfTVLjg87QZeVfyaEwGiLVeBfLsM9O6K6+7nOdQTiA/jWnqbF4f4s22QYZhWZ
         ILAQPHo3qihMelT6Mvyjz88spfGejAZJOzkGw5Pt7aAYx8MHcAXKdJPMX15KYFbsHp9C
         wGIT8TKFpHNmJp5NR05zHPc3pjNYPphgOhUsAHQO9G1joy6hj3uWG3ResIRXczpueAbM
         3vQy7Iln3dgDDFC9cHCcMfIu7XV1pGvYPu+gaSOfY2bGxPXZEIInr2VX8Q3dYk5Qfroh
         2N/qfWToTTEHO70zeyoEluDpmK2dE+ohMcUg1em6b9GZAcVC8ZAuPFLHsLkJber2OzIj
         cb+A==
X-Forwarded-Encrypted: i=1; AJvYcCUJoiDWq3JogO5WC4+VLCU50wMWkSNRLH9XTyOpNuDUOw6ZAPh9H93FXzWt6tP1DpPyhl7Y91oaKarTtiDLolw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyycDlaWteybBjSy2PPIO644n+E1ce6gvgBfNI121VzCs88g6pW
	FUyJiUy2opB6ASd5EUDHacVBe9KLG5fyNkuxvpOGc6lqh5l3e8IiX3tMtJkLrWv+daWZnfifMDI
	g4lGNGwilzAxUHd0GQbIgg1kA9WLb6CrQuYkgPYeDwquJVHtvyrm3gUQW1q1l/VqHhq+D2A==
X-Gm-Gg: ASbGnctV6nVq0cvqti1rq9BR0tSE3/HjZ0Gb7K1N4BAQRDkWTMjvvmpjOx7CE6sgtY1
	SBXonKdB21bE+BIFDznJODvxRyAbtRv0GwsQ2j7c2CQURi978FPKdo1RBu6CJr9I/8vt+Hxfb0N
	RyHG20rcilWLfE3CwOnSRwED73COyzPeellcbOTXwHlqLFcMhIy0bhwRr7w2RzWI4iGLPcMB9ts
	YPV+/tBmNBdZf64tGruNtVuv63c45jO6kRtvrfSFCAaYKQQZ9RQ5KzBWB56H/oQGFVo7wy/NA+5
	T5plI+2Le62jzAfwgHFJCwqnHURsybhMniueewNXgtwF7sOhcBoxm1XCyd8NiEgzjo3VmBt7Tut
	fbA==
X-Received: by 2002:a05:600c:530d:b0:477:55ce:f3c2 with SMTP id 5b1f17b1804b1-4775cdc5874mr42667875e9.14.1762429547922;
        Thu, 06 Nov 2025 03:45:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG7RHjlVj/e3xHSWVa2A73ABTLq0Y9BUa6x/aDlpI5jqQq8aKEV1qKIM3qTieemuTqo6foEFg==
X-Received: by 2002:a05:600c:530d:b0:477:55ce:f3c2 with SMTP id 5b1f17b1804b1-4775cdc5874mr42667565e9.14.1762429547516;
        Thu, 06 Nov 2025 03:45:47 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.83])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4775ce20ff3sm99192445e9.10.2025.11.06.03.45.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Nov 2025 03:45:47 -0800 (PST)
Message-ID: <481523a0-58d3-43c6-9e8b-99c2d7ddf55a@redhat.com>
Date: Thu, 6 Nov 2025 12:45:44 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 net-next 07/14] tcp: accecn: handle unexpected AccECN
 negotiation feedback
To: chia-yu.chang@nokia-bell-labs.com, edumazet@google.com, parav@nvidia.com,
 linux-doc@vger.kernel.org, corbet@lwn.net, horms@kernel.org,
 dsahern@kernel.org, kuniyu@google.com, bpf@vger.kernel.org,
 netdev@vger.kernel.org, dave.taht@gmail.com, jhs@mojatatu.com,
 kuba@kernel.org, stephen@networkplumber.org, xiyou.wangcong@gmail.com,
 jiri@resnulli.us, davem@davemloft.net, andrew+netdev@lunn.ch,
 donald.hunter@gmail.com, ast@fiberby.net, liuhangbin@gmail.com,
 shuah@kernel.org, linux-kselftest@vger.kernel.org, ij@kernel.org,
 ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com,
 g.white@cablelabs.com, ingemar.s.johansson@ericsson.com,
 mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at,
 Jason_Livingood@comcast.com, vidhi_goel@apple.com
References: <20251030143435.13003-1-chia-yu.chang@nokia-bell-labs.com>
 <20251030143435.13003-8-chia-yu.chang@nokia-bell-labs.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251030143435.13003-8-chia-yu.chang@nokia-bell-labs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/30/25 3:34 PM, chia-yu.chang@nokia-bell-labs.com wrote:
> From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> 
> According to Section 3.1.2 of AccECN spec (RFC9768), if a TCP Client
> has sent a SYN requesting AccECN feedback with (AE,CWR,ECE) = (1,1,1)
> then receives a SYN/ACK with the currently reserved combination
> (AE,CWR,ECE) = (1,0,1) but it does not have logic specific to such a
> combination, the Client MUST enable AccECN mode as if the SYN/ACK
> confirmed that the Server supported AccECN and as if it fed back that
> the IP-ECN field on the SYN had arrived unchanged.
> 
> Fixes: 3cae34274c79 ("tcp: accecn: AccECN negotiation").
> Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Acked-by: Paolo Abeni <pabeni@redhat.com>


