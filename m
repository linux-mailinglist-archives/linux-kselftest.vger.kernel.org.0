Return-Path: <linux-kselftest+bounces-37959-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9446CB1134C
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Jul 2025 23:54:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 969D31CE5EA7
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Jul 2025 21:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5AFD23B612;
	Thu, 24 Jul 2025 21:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WqAYOTFG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E25F9217F31
	for <linux-kselftest@vger.kernel.org>; Thu, 24 Jul 2025 21:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753394039; cv=none; b=EudNGP7RqKObtrWh3VaORM7wvfo/2SXEVhwGayIlmu/3VUxroXcaxbj+g6JhDm9WpHyR5iGPrSlvy85JuFdfiSIPm4gAo/PByt2iZveoTdHGhDGdcArZUwwo8zirTvxyv40kS2cw+7K1FUzYFWkq2CClkHxvrmkYBrg1+tl4hWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753394039; c=relaxed/simple;
	bh=cONpRMMRR0j8+5IMSCW+w3Dv5UbjFMlpzxjvfBz12sE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jq5qZ2a/bwsSJWPPcpXFunJJOjOujP1JpW/E5bFY24qPxY+DuGzgVK/Rsm7rhwVa7XJwA9/P2GZH68maTJiISJGXQh993datPubTZu5DH8onC9dexKQqugaAc1TTnXS9rmFff/Up2cNqsj+SbvtpT4fclhd8RmOz+x7A6bm3FXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WqAYOTFG; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-302fdd379faso501455fac.1
        for <linux-kselftest@vger.kernel.org>; Thu, 24 Jul 2025 14:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1753394037; x=1753998837; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ec+I/bNfYceVzsyoj94ElkmRmpTwfXXUO1soT24vA9Y=;
        b=WqAYOTFG5W0pBbtUTx1mY5uINZDOF3UvPO27BIGeBgYRA1RzZMeHHCsX+4BGWhWnKi
         ZDTt7FYgHtI1sCw9Lwl5SfsPwRjTV16l/2vXS4FJAj/Apoy0XiJLKr4xHsTdIUJ+a8we
         wUNBYdkI0c7BOjn3NoIko9W0ws5jxZTjr6Z3Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753394037; x=1753998837;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ec+I/bNfYceVzsyoj94ElkmRmpTwfXXUO1soT24vA9Y=;
        b=aALnps7tn9FFDt6UtK+qRS9TAsW8fWkVC+Uj2lKFbisR3MThZfU1T0ksCW1+C56J+q
         nS9rPtmGTPlUlASs5l3SzoRIyI8NYebtx+ycIzjL96C20ImpkyLx5LRWBGJmpU8oPyWO
         dEu7QTNUwHFPc4EyYIXEfnlJYIZW7qingELH29Sghrm7WL2sZWpMAiUexUycvvtq/C/A
         oboSm/zMrAr2HPxLyEkW6n+DU8A1u8XYxCaxEV9dYIyJ8PR0YSMqGhj8R58jMWdz49Ls
         3CVcbzMqGPl16iFQbsP3dIFeHJomhHaGwHWBi4S6l+N9Ap2bMgkBttRsCSmx/PHFMDiY
         /0MQ==
X-Forwarded-Encrypted: i=1; AJvYcCWI/Ny5H4TydVBql63wSfUifG4se1bntBK+RPNPy9fg3nzHqBvmIGp/t9KH8czFY46dU+/gAc9+ojAsDqQl8Eg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmVVjQh5JyG9mT0ePjw40U+SZL6oFR321gti+wcN3XbYDx+edP
	Qvov8+nq4UTUntecTmCV6thA49l1NAIyWMaR+KBxBHsp34K34+eeuvlZgYh99mdJYJs=
X-Gm-Gg: ASbGncvAp8QAosLLL1SOVPf98EIA/qWE+CF4ynyMldqKW7atfhKorg4HlxC+FlGWOgp
	L56WmCSK/BVO/AOWI408znq9XLpbMNMLy3VmWXH0VTztFs3/MVAY+X6SuInlL1v1JoxQaIRod3I
	lVONyC/s1Mn8Tp2MDnHGbkADddcXTUYE5dYy6III/dTvoDO3cj7cGddzLb8+nOidyY9l/g5LzZk
	87QLhWZMNtrlUshtZGqNC2H+s2bkkafBSZHC5s54mZBs61PXewwcnhaRCaYIKE7aeZ+BMQLzhSn
	vw46MpIh8rqGXvqH1i4UNyaky15BGbfcF1OivxnF5yJXh1NpcfL7TSbWfc7Cai5vDiRYv/XpJ4k
	UqUbpLjMjE8zp5DrgmrZdChWTzwPCXRMRCw==
X-Google-Smtp-Source: AGHT+IEjVIBgoKwU7JAUm1idxYByEHXiDmed8r9RKzj3gIzufCwMdyKungjHAWAI3Qak8OLj+PIjsA==
X-Received: by 2002:a05:6870:a550:b0:2e8:7953:ece7 with SMTP id 586e51a60fabf-306c72032afmr5665997fac.24.1753394036875;
        Thu, 24 Jul 2025 14:53:56 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7412cf44fa9sm424813a34.0.2025.07.24.14.53.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Jul 2025 14:53:56 -0700 (PDT)
Message-ID: <94813f6a-e789-460c-a898-7c7fdfdfad2f@linuxfoundation.org>
Date: Thu, 24 Jul 2025 15:53:55 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/tracing: Fix false failure of subsystem event
 test
To: Steven Rostedt <rostedt@goodmis.org>, LKML
 <linux-kernel@vger.kernel.org>,
 Linux trace kernel <linux-trace-kernel@vger.kernel.org>,
 linux-kselftest@vger.kernel.org, Shuah Khan <shuahkhan@gmail.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Tengda Wu <wutengda@huaweicloud.com>, Shuah Khan <skhan@linuxfoundation.org>
References: <20250721134212.53c3e140@batman.local.home>
 <20250724095309.480882c8@batman.local.home>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250724095309.480882c8@batman.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/24/25 07:53, Steven Rostedt wrote:
> Shuah,
> 
> Can you take this patch?

Done.

> 
> Thanks,
> 
> -- Steve
> 
> 
> On Mon, 21 Jul 2025 13:42:12 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
>> From: Steven Rostedt <rostedt@goodmis.org>

Applied to linux-kselftext next for Linux 6.17-rc1.

thanks,
-- Shuah

