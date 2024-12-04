Return-Path: <linux-kselftest+bounces-22799-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CBDD79E303C
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Dec 2024 01:06:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 235FEB26D8F
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Dec 2024 00:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E732B621;
	Wed,  4 Dec 2024 00:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="g0wGDd2n"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B1F8184
	for <linux-kselftest@vger.kernel.org>; Wed,  4 Dec 2024 00:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733270703; cv=none; b=oCMrKNJbqVID8HRZYv6ANEWmGYaeugpfon5NBRu626GCPfShfAwRI+PfsLMVoERaY+0ie1i0FYF18WceMNH2hh972pPwJ83M8eFyN086XJ5YmODUxfpTw48zHP43opQjl8PQwp8NWrjqp3o9SELDISkgzmgop9+6/G4TBtzRHgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733270703; c=relaxed/simple;
	bh=MJz5Q6WP36oLbDCYEDo9s9YkT5LQztLrq5XVv/x2PuM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mdKN+x8QOJFfZ79WfXxXFCfhn4XGoxfXzJ2SLeMNliwV8ntB+701PjQD1eS233A/+Q6TY8NS1oHDbzRFRXGit3fOvAaYYUZUG+y0Fy4eg2OlGx734+5iWuRfi96vdd3TvrpQjjlbbGoAYYoe8/d/VlwCMqJ/EAvk7tDXZsOk3/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=g0wGDd2n; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-841a9366b08so200017339f.1
        for <linux-kselftest@vger.kernel.org>; Tue, 03 Dec 2024 16:05:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1733270701; x=1733875501; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YcQiqQOQOLDzcbxMsNRL6FHp793XZtkKmMGhhmXaiEQ=;
        b=g0wGDd2nq7ATini0lk/TOpiZ00R7XW7bGj47kvOPgT12qTYsiMMUN92WDE/8U4SBv9
         F3zvyJPGKnEeXulPxG58kUB5WPZZfWkLogEV1DY/YKH62DiDJGQfIRB4xmNu3DsGmXX/
         4neE7GVS26cwzGSPE5DKsCVQT9l65pdSdn9UM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733270701; x=1733875501;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YcQiqQOQOLDzcbxMsNRL6FHp793XZtkKmMGhhmXaiEQ=;
        b=kZcAHv77CI9gv50sd6uOVCMEzfgETtdgquWgT8tAiQkRKVIDDu9K6eY8exUnq2o7l2
         VRZMQOlC7RlEo5rYns3tueqUzIN2gFMRTtY6dWtdoqkX5tAa+i9GEvHU+n1g03/2WuYl
         IoHtATP+p1XcQbpZ8f/Y9RNyu31wY8lrRPVyMHan+vDr+QvDsLnqSbbtD6EWvFnDs26x
         ZpCluw+apCU2y5k42r8h2NXVLf0Qipij6vaelbQOQa17EibZIIH6zCJeVSkwXEbMZCyI
         JVYgwuqklI893Km4Ea2VMym2+3gKx1ds3tveAAu8LFWz3i/XugB7L1Be2M5tvXGpK07u
         mwkg==
X-Forwarded-Encrypted: i=1; AJvYcCWw9tieEzk6j10E0gDQpIifYFPjtEyJh543B6IofdM4yK9RmEsBrt2XVZ0CmGW/a//ALO1ZDEfE8PdTcuiOHNY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdWEcXKejzJGDwZQfERiHWFWjahzFYpREXpQdSPB/9Zes50F59
	skRuzyfsnmgtOAWTxQNs0wkDW7tA1DaaGCEGXEeVSnGo4hbk5pYCnZ31IFqsEGY=
X-Gm-Gg: ASbGncsSaqruwvNqE4Iz7ltAuB5Fq+oQDMF/lAlcYLpw1wkuPDpnBdEUieNEjtTgmNc
	lYhxtgVSpsVdMzbWlyW++m6vsgn3v+ur1Y0JPWtU10ogKRD03/x8Qn3jPWi0Ltc2ZkX7cIdC4Ra
	DOH7Rlo20/AJeLGbaI74BKJUxR323pYTa/ztbZWr4qiC62URHE1Sxz+bqD/+3f3mUq54CReWodg
	+l8DbLnl6zX3RL582F1qlDSDvZUEQkeUPLza7XEyRvAUYD1ybvh2hv3wPX3dA==
X-Google-Smtp-Source: AGHT+IEuBsfvLAIn0B2ch1wXp59X/LnGAMGWoWpDRa905GI3J8nxVMtFYz9+kA6MT1Q5jhAPDjlNzw==
X-Received: by 2002:a05:6602:15d0:b0:83b:5221:2a9b with SMTP id ca18e2360f4ac-8445b444229mr637981039f.0.1733270701238;
        Tue, 03 Dec 2024 16:05:01 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4e230dcc3fesm2851291173.61.2024.12.03.16.05.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Dec 2024 16:05:00 -0800 (PST)
Message-ID: <b2723ccd-bf0a-4d9b-a545-f9e3dc336539@linuxfoundation.org>
Date: Tue, 3 Dec 2024 17:04:59 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] selftests/vDSO: support DT_GNU_HASH
To: Xi Ruoyao <xry111@xry111.site>, Fangrui Song <i@maskray.me>,
 Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20240915064944.2044066-1-maskray@google.com>
 <f229fbad-731c-4dd4-8c66-ff8829c2c958@linuxfoundation.org>
 <c828b254fb93bd136b36d3a06ab1d9d29ce13d88.camel@xry111.site>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <c828b254fb93bd136b36d3a06ab1d9d29ce13d88.camel@xry111.site>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/27/24 04:44, Xi Ruoyao wrote:
> On Thu, 2024-09-19 at 09:37 -0600, Shuah Khan wrote:
>> On 9/15/24 00:49, Fangrui Song wrote:
>>> glibc added support for DT_GNU_HASH in 2006 and DT_HASH has been
>>> obsoleted for more than one decade in many Linux distributions.
>>>
>>> Many vDSOs support DT_GNU_HASH. This patch adds selftests support.
>>>
>>> Signed-off-by: Fangrui Song <maskray@google.com>
>>> Tested-by: Xi Ruoyao <xry111@xry111.site>
>>> --
>>> Changes from v1:
>>> * fix style of a multi-line comment. ignore false positive suggestions from checkpath.pl: `ELF(Word) *`
>>> ---
>>>    tools/testing/selftests/vDSO/parse_vdso.c | 105 ++++++++++++++++------
>>>    1 file changed, 79 insertions(+), 26 deletions(-)
>>>
>>
>> Quick note that this will be picked up after the merge window closes.
> 
> Hi Shuah,
> 
> The patch seems forgotten.
> 

Thank for the reminder. I will pick this up now.

thanks,
-- Shuah

