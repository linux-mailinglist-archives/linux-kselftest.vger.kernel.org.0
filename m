Return-Path: <linux-kselftest+bounces-36732-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB689AFBD94
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Jul 2025 23:36:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B7163BC9C4
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Jul 2025 21:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0D5A2877FE;
	Mon,  7 Jul 2025 21:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZuhSX/Rm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A2D2877EC
	for <linux-kselftest@vger.kernel.org>; Mon,  7 Jul 2025 21:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751924171; cv=none; b=G091R1vL+RSHzikmRWrXRGOPxRL9oNKW9kuOI73TG/xaKvqxFDXkToxSTHOXaggzAFL7bdpOkEfC80q5/tisTAKfPuyjlsDieO6WCkYeCSq/t2RRGGolv0G2ynVr61yElQlt5mIcW/gR3hWjouv9aKTMPXKTCsPquUrh02jywuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751924171; c=relaxed/simple;
	bh=FoE1yw4PinF8aLsqwiVP49aNTfhL5YfYRDuew1h9slM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QyNSCs3KVdVysl81d7Km8QpQ9UCvwvIhGeeKp+e8xj38X7bAlNvUKV7NFTxRnf5pj/JxVlMbNVbAH8xNo7hKOmJAaS3v+9Fm9Yx06Nh0/yzbJ/AHBs9y+VcTL4MK4mfrB8hlOd7drNMy/6XGLF1/jciGk/zrdTfciLQ9mvlPcoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZuhSX/Rm; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-86d00ae076dso153839539f.0
        for <linux-kselftest@vger.kernel.org>; Mon, 07 Jul 2025 14:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1751924169; x=1752528969; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5Y+/uCDo8Ap/hlxb/YHfGaplN840tpeb83kN5x/Y9MM=;
        b=ZuhSX/RmBiY/WSTlomwxELJK18RRt8o2YaBsq19C+h/8M7Zlqcm88ZN0Z1pWZkUEYq
         x36BN9F9Uqnj0NJTqeXjifoLpCdcuX3wNcM5sEIn3rP+xv2DvJL+0WsfJDD5+pVM191V
         apGnv0fE5VlNtfme18Nc7ZCRU26+jGOppG8CE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751924169; x=1752528969;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5Y+/uCDo8Ap/hlxb/YHfGaplN840tpeb83kN5x/Y9MM=;
        b=PB+yrByT4QV59lRIiUkcnmPl/Wcg5mXQ4Jmr6B2lDHnpPO5PL67pzKEMORsvE9OrtB
         l9BEUddYCxqOURUTOB/0I3ph+YlI7tFrkVNmsbyrFMJmchoOfdGU1SiAjND0+7pLg/Ri
         pyP93NMEoJlkv3rr6Reo6E6YgaeZQj5+LcieVptLMaGiHwPBeV7bS5emL/snf1PHX6ik
         V/vTgjdIsYSK06vrI7WUW6/Frc/KgNvmqL2+A5Y96K4S9Z+8MxR7fPnZRAYL02bQHlgy
         Wc+NPPDXs2n9tpLB0du00+hEiGaxh+7urENYo/jrznC4hPvN+zWZbY1okc+J+hlMnPMG
         WFjA==
X-Forwarded-Encrypted: i=1; AJvYcCXFCWdZxQ+5oYCxt2GoRgswiwEwUvH2pNFU8RSQ0mPIZK/9rUpcuhH4Ab4iTSvJ7HDdsj6zj/ko2skZHU2n+m8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywn611IF1Iw2frCNVUB1BZ7WzlSRMecv0Eo5ik6gfVIL7ean46t
	8RqvKoPW4NjYqY5QrKw4gbp9W/gCPkn9D3kVYj0kHFjACeJpAZUJaGguu40815/gTs4=
X-Gm-Gg: ASbGncuG9PDUJYyr/gUrwz39VnAQZ3WjmsyQ7cGrUSmDcn/tFr+/MuPgVd7EwXCXc0a
	rfGS+pU1EtkrOlwdrjVNmK4cAZgPb9RgmjblX5/GWWUykRA+jFrhCUyWIJ1NcpLbD/T5SRqrRa1
	jGEBe0b7xCxCpvfJKx6EkrvfFSomxrZJqzZZ1hqTbaxaTd1yl/vxqhysjKJVWInjJ50BFMp5Jl0
	SWS2cET0wvcn8SNYZONrxINOn4o/TI7YMNR+xPKYdnul3ks59XiE9L91JhtvjZHV31r3TOMHnC4
	um8i4EA5NHTB1EvHReDCth8QTV5GZ7ULD3Y/P5sivBS2DKsfxL2oLgDvGobHKmcYT51nu9IOFiy
	MY16o/KH+
X-Google-Smtp-Source: AGHT+IF53byRaWgnL2/6PRGJxd7DTJKFA1T8Wjv6k5cGUjcY6U6GoMsR0lJgobtuehyYtbBQa4iQiA==
X-Received: by 2002:a05:6e02:522:b0:3e1:433e:2605 with SMTP id e9e14a558f8ab-3e154e63815mr2132085ab.9.1751924168902;
        Mon, 07 Jul 2025 14:36:08 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-503b59c6d77sm1911718173.32.2025.07.07.14.36.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Jul 2025 14:36:08 -0700 (PDT)
Message-ID: <57f72a27-10b0-49d4-8bd3-39b35f422a95@linuxfoundation.org>
Date: Mon, 7 Jul 2025 15:36:07 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] selftests: tracing: Use mutex_unlock for testing glob
 filter
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
 Shuah Khan <shuah@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <175151678585.2149615.8702513393985992418.stgit@mhiramat.tok.corp.google.com>
 <175151680309.2149615.9795104805153538717.stgit@mhiramat.tok.corp.google.com>
 <20250703103039.3559a7e1@batman.local.home>
 <20250704150425.a8a82c7768e1c99ee272e585@kernel.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250704150425.a8a82c7768e1c99ee272e585@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/4/25 00:04, Masami Hiramatsu (Google) wrote:
> Shuah,
> 
> Can you take this patch (fix) to your tree since this is
> a fix for the selftest?
> 
> Thank you,
> 
> On Thu, 3 Jul 2025 10:30:39 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
>> On Thu,  3 Jul 2025 13:26:43 +0900
>> "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
>>
>>> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>>>
>>> Since commit c5b6ababd21a ("locking/mutex: implement
>>> mutex_trylock_nested") makes mutex_trylock() as an inlined
>>> function if CONFIG_DEBUG_LOCK_ALLOC=y, we can not use
>>> mutex_trylock() for testing the glob filter of ftrace.
>>>
>>> Use mutex_unlock instead.
>>>
>>> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>>
>> Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>
>>
>> -- Steve
> 
> 

Applied to linux-kselftest next

thanks,
-- Shuah

