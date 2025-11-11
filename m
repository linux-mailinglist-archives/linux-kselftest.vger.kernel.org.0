Return-Path: <linux-kselftest+bounces-45278-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73B13C4A31C
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Nov 2025 02:06:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 455B83ACA99
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Nov 2025 01:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6F8A261B8D;
	Tue, 11 Nov 2025 01:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WkQYLSwa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CDF8271A94
	for <linux-kselftest@vger.kernel.org>; Tue, 11 Nov 2025 01:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762823053; cv=none; b=K7pYu9MiRRWKz51hZSG14+M1Ebf9jKnz1li93PJ4Sz/pdlS4Amo0QfqpT2jW4/E0IVFoQ4fkCuh7YP7v1DDbQ5sNANm9WxgymwLweZM+bgbgmIEY3Y4Vq9LLzaTzRfRvdz56Ng9onJ3Scw1LEP4jOEUn4jiFFfePYi3W6mjZbPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762823053; c=relaxed/simple;
	bh=DTdn+TVj4y7K+zN2UdZO2AFswxa/7GKErpCpr9EpG1o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e/tok391ccEJMNbW3vm3tLkoq55Qu+PHgYU9zYnWJAlQWoCDFYnQCUY0RwDawgvUTnovjHvkCR8PDk+XpGhLATSfeknBU/15Tl6Rikgp/S+QVre/6RmVOrUzoD8vo1Pi2EcoTduzWzdWMwWeUocJjpeq1dcFOgowFSHTA0HO5R4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WkQYLSwa; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-948a6509f1bso8845539f.1
        for <linux-kselftest@vger.kernel.org>; Mon, 10 Nov 2025 17:04:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1762823051; x=1763427851; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MldjgzoX1SZmnBCXHrYUgqyrT5ShEUH07RGZHBRdusU=;
        b=WkQYLSwa/insdvvaKQLr3wLwer6iZ/ZXyirwn7wVeVwJU0dJ9xouFgHBxgZ3PvXlHf
         CTQuKA0cRcLAXayJu5kHZfvpWLm3dO0WGY4/0uIKI3d0EdjOilYUNOtK2q4RS6l1uG05
         C1RzK8eqMvBla/Z+V2+iYp/WkTBK78ZE+vlqc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762823051; x=1763427851;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MldjgzoX1SZmnBCXHrYUgqyrT5ShEUH07RGZHBRdusU=;
        b=BFbhR9WFklLb1sr7Q5dw0MEUqsQTzVHjQo7Fc4lOGf3p1kEF1pM0h/Y7ABexojff4f
         UDGEBmhja0xehVg8WPvLmAywvnl9Y4UBbYZ5bgOo/vBFInVPTD6oEERUgym991Fj00YK
         qz+6KMrRjEm4R8eehKdyS7pyFH1mDKmaIfsP1asM4h7oXbxhsQQ+71vVtwIIhKoFr0po
         L79Dg2w/VSaVChtBTz0is7WMJL5P+td8hXRGWyp8eTj9zGI3f4uTRdzKchcJwjSEFBaC
         JMHW+KrmFLtdj266IK/+KRkP9XJCXGp7LKiwl/3JgcWMX2uVsT340Enn2FuD32vjqHUK
         L88Q==
X-Forwarded-Encrypted: i=1; AJvYcCXG+1avkGhLR7aBAV/kRTBMIbTAUNp21KQ69fd+s17vTipeLCTJwRhtPxh+L52MSKRCCoasZ2UWlP6MbNl0XsU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9tQ9UbuFjPcGHP88aTbi5TDuEKsqdDlH87x5JlysH7ni/oD8i
	AwRCRortITnq6hIGyIixZTnjMmbwiB2pt2Xzk6YMHfu8xNhiD5uzrDbiH4u4QyQxG+U=
X-Gm-Gg: ASbGncv/GndJ3rcn68CqPd3yNEk+3esjWieS1JzI0NiYt4/B3cq0k2hg6fsecT01dJl
	1rid2djP0d5aNLlyEzXw9gZgLx+XpSSx0fyVAhtK49NSW48lPAmS2b648MAtTwBdeg9nqCb+lSN
	mfx4oIAaRQlzZVN4dhZcnuweswkajaL6u5TduUO0yj20N+HPRccBUb9yafPFT7XK09oOpH1b92/
	M3VMa1ml+fX0/OO3uh43cX0X2iN+KqIX6TGA+DBYhVzLv2T7MnjBgP2GFbgbAGsp+5y4vUSf/vk
	byBbgjkoOsklLWuYLWBNIxmnPuUPVYiFzN5+Xt1Vcz5uo4lJ763uv/6jmFdijXkplggJaQDpd00
	ivGd4EXG9hjRwOu0rvW7BaWfSF1UbtQ1VobAI48qKtS9kGAJrQg3QDPDUhSEfEUIuBt/a1khcNb
	g0tCVi6lc88TBv
X-Google-Smtp-Source: AGHT+IHCAPfObFCTUaFPUpafgOR5ZP0PrhCGHCniJcUGtCxxVGCtpG3U48p6kW/uACwO8atqxsSGWw==
X-Received: by 2002:a05:6e02:1c2d:b0:433:794c:8486 with SMTP id e9e14a558f8ab-4338be50e90mr22249085ab.2.1762823051177;
        Mon, 10 Nov 2025 17:04:11 -0800 (PST)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-4334f457610sm61159575ab.13.2025.11.10.17.04.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Nov 2025 17:04:10 -0800 (PST)
Message-ID: <87d3c405-5cff-48f1-94e5-86e30d29c5e5@linuxfoundation.org>
Date: Mon, 10 Nov 2025 18:04:09 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/tracing: Run sample events to clear page cache
 events
To: Steven Rostedt <rostedt@goodmis.org>, LKML
 <linux-kernel@vger.kernel.org>,
 Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
 linux-kselftest@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20251028122724.4bff9853@gandalf.local.home>
 <20251110171432.51364be9@gandalf.local.home>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20251110171432.51364be9@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/10/25 15:14, Steven Rostedt wrote:
> 
> Shuah,
> 
> Can you take this through your urgent branch?

Applied to linux-kselftest fixes branch. Will send it
in an urgent pr.

thanks,
-- Shuah

