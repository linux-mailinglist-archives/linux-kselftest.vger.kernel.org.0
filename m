Return-Path: <linux-kselftest+bounces-30384-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C48B1A8190C
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Apr 2025 00:52:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 249263A776C
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Apr 2025 22:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AD5C2561AB;
	Tue,  8 Apr 2025 22:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="A44knuwY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84DCC239095
	for <linux-kselftest@vger.kernel.org>; Tue,  8 Apr 2025 22:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744152734; cv=none; b=nSWJRjn1d7OYSZPFGg+QO5kdPd4vxpCMdlm0iXae88gnl1KZv5z3gx2FubejRz7Opqgyu7d/wWZ2xa/XpNyC8QTa9aX7QV1SipnAua9REhF5C9a0tmRqOSU4cnZ3wK26+kV0LRf+gm+l/oABuk4KIMu/zaaiB76yhP5WKZOHIqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744152734; c=relaxed/simple;
	bh=e9O6r7WBMkbrnM7cL6R0E7aAYYGL6jDY6+Tvjvz3x64=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XWJ2vMq5+3wAR/WJSVNs/mTNDpAVcdKZnK01/DvXvIQLJP7jsnHLceLzJZ5AsczVumU8cGoGUblZjiZk7ftan3oIEGSoOpdTGaMUwnuXrqWt5gJ6JwqIQsqx4RWnE/cgwuT8wzUIocQsE19L+0nmKCIKZImLbeOXAHov1woeGII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=A44knuwY; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3ce868498d3so26288115ab.3
        for <linux-kselftest@vger.kernel.org>; Tue, 08 Apr 2025 15:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1744152730; x=1744757530; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NnsXRXmmbGuN9Dqq/Cq/ea8ifh5rsWszcEVlGPkNAcw=;
        b=A44knuwYzZypecvkv9s/0IC/g40R6pe3fvp6AaprCo1ehe6ry+Qbqr+gFWk01I2Ojm
         SAwvJUkYGhV+M9PZbOOekhTasqWF5k/Wn/1JGZPM1Y6UNfRrhOYP3BgYg0JAAtGgHT5h
         fjhJAP8i8U2Hdvq0CQ+gL/76iC/HEwKRLhFNM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744152730; x=1744757530;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NnsXRXmmbGuN9Dqq/Cq/ea8ifh5rsWszcEVlGPkNAcw=;
        b=nhNTHsmUsClCb0M0DQRXPG4zLItKaH+A8UedSw+dOEIndKSRGobAvzn1C5Q/+Kkr81
         5pJLtej6VEm/UlivGrHJETsRnzjuLTTVJRncFk8Epuaf/oRs3mRJhs/yjyH0/typpTwr
         vCx9nzclGBMItAORSFQWzfBNO5L1TkS/132q/eZLv9AZEsBLuPfPMnzWEX1rnyu3d5Er
         Zgguo5W9E+cFiLihTTLtKcPvac8JmoAaVJOdlSR8+ESE0f3QJV04U1PIF3kRTDLD7+Za
         UuQZ7eo0kSxqYtYEhvKeErIc7+uagOJ3xVvrc/olE9CxjfivHliZndgKVTjVg4hifR6d
         F2IQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZocFptoL8mMvsd6GArbjUrGh0zW3osNfnJc/pz6zJw9FLglEBGcoGADWJ3BCQ14kubmNBiUejx3PVFx1YJAs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKuqCnJA9V3ayln6deZWHGSsEpJ3HZMdght5ElJ2QkCfGh9MzS
	N8WehR5EdqCtP2qU+4D3RjfUXBTOCwBrF/VlYnBqRbcaS+iC0KLJ+nh/tiT4F5E=
X-Gm-Gg: ASbGncuwoP1RvdOMe6sQGCyY7JJGWBWatOOa0TWWzumjtOeBvTHPkok2nTEwHTqrOSi
	yU438asxWxIH03EaaqBHhsiE8apzbL7JzQ/g8shHO79TqXkvdFqy/lJJUckgixCDosr0YQMicwJ
	UTmqeuQa/ZuT0VcsCBufvHgsG+00pP7fz++To9dn6mf+0tyF+dAxChGIBoFMSgNcucx02Mkf+g6
	1UbYXvqlj4TR5OKvhsyNFZ4lCV41hj1F+mIHtXj+hMO0lDxFojW9uUeTX68XPCTB4Er9iY4U42X
	JPdXq+sDB7HTWvYlFt8arlTPWN3kgS8xhb98+4t7rSW6oA9/DSLXkAI=
X-Google-Smtp-Source: AGHT+IEDubc+Cph3R//87AbVKudlcynmCvgm9qI5f/27qmc3UzlvpkD9tcbb5GRPBu/+prD7dm7+eg==
X-Received: by 2002:a05:6e02:1607:b0:3d6:d01e:7314 with SMTP id e9e14a558f8ab-3d77c2adf5amr6642145ab.16.1744152730610;
        Tue, 08 Apr 2025 15:52:10 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f4f43d5580sm725736173.47.2025.04.08.15.52.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Apr 2025 15:52:10 -0700 (PDT)
Message-ID: <b9a14ded-f0f8-4b15-b1dc-4052ec0a7d3f@linuxfoundation.org>
Date: Tue, 8 Apr 2025 16:52:09 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/futex: futex_waitv wouldblock test should fail
To: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>,
 Edward Liaw <edliaw@google.com>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
 Darren Hart <dvhart@infradead.org>, linux-kselftest@vger.kernel.org,
 Shuah Khan <shuah@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 kernel-team@android.com, Davidlohr Bueso <dave@stgolabs.net>,
 Thomas Gleixner <tglx@linutronix.de>, Shuah Khan <skhan@linuxfoundation.org>
References: <20250404221225.1596324-1-edliaw@google.com>
 <2b254cf0-7b55-4db6-a80c-e81377405fde@igalia.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <2b254cf0-7b55-4db6-a80c-e81377405fde@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4/8/25 08:21, André Almeida wrote:
> Thank you Edward,
> 
> Em 04/04/2025 19:12, Edward Liaw escreveu:
>> Testcase should fail if -EWOULDBLOCK is not returned when expected value
>> differs from actual value from the waiter.
>>
>> Fixes: 9d57f7c79748920636f8293d2f01192d702fe390 ("selftests: futex: Test sys_futex_waitv() wouldblock")
>> Signed-off-by: Edward Liaw <edliaw@google.com>
> 
> Reviewed-by: André Almeida <andrealmeid@igalia.com>
> 

Thank you. Applied for Linux 6.15-rc2

https://web.git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git/log/?h=fixes

thanks,
-- Shuah

