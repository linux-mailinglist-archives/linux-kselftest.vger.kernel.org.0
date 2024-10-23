Return-Path: <linux-kselftest+bounces-20514-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23B959AD5BB
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Oct 2024 22:45:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4584283614
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Oct 2024 20:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 823C1155757;
	Wed, 23 Oct 2024 20:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="c1qDE7Z8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843E214B946
	for <linux-kselftest@vger.kernel.org>; Wed, 23 Oct 2024 20:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729716333; cv=none; b=DNsUpYtspBpHuQkpCk5YXZHhYh9vV4IDv68PN8uMcRvRjjDWpYUgo9eeBsfJBF/w4Z9EV0XuTTxsJd4cQ7q9+xZEM8eGASuoNDAlr0iCtToq+cnD4jBFODKLA7qSsZwl/l3nFYYb6+77bApABJdWQ3F0Zz/krRc06apsjJPYdK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729716333; c=relaxed/simple;
	bh=+Bh9Eyl1Kk6ceNtvQxz+8fj/4I5t9C1afxJRX7d2cM8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n2BMR13wYS4JLhWPWGPS/ugEJJK7ALraqVZSv6oN5fNXVlngfq+NOEOcRzoKr+dsnnN9KIvu/oNy5gqEb/Y1vTzg2gfgfj2GE4drWxH6SYbvHCkHLlOGBRQO4ThlwT/HKqFwmpUN+m87m+IjfGrTPHazCYaq8U9WvYdhwjgicQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=c1qDE7Z8; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-3a3a03399fbso1243995ab.0
        for <linux-kselftest@vger.kernel.org>; Wed, 23 Oct 2024 13:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1729716330; x=1730321130; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Hxw2krrcH7ZUmQBAO1CfDkO2ErH5VxXyepGE6kvz/2g=;
        b=c1qDE7Z81oEnQQ06Z53SlRgmI5mmBB3c59heCT2xC3iWn8EjUHXDOScX2eMequEApb
         46feXDjBPkVrSWXPOPQA25u3qObJkb55vwnTvcEr4/n9zv9hqwakhePw0XRQ/lcAMGjG
         sRQOn9gZ9002ro2Cg/1pCnkBC7jc7/4Vo8sus=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729716330; x=1730321130;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hxw2krrcH7ZUmQBAO1CfDkO2ErH5VxXyepGE6kvz/2g=;
        b=pY4BRXG4+Fki1RV428fnDnr1PWliUrw78z/bxPtqQm0L08sJYBnCTIS3VYPavOVjdG
         OPcSJ3+hktn7pOB+2aiCfeNx88MeTwvibb4BfkqeXHvbyCoPYdasufs9g/LT/LAPrADN
         n5lI/rZf3wpOvYGOsckOixbucWbMPE/x1ORkX61vkggfp6S2iv7C4DuDw3czbp9OvgVf
         PCnEBCcOhE3YgEEybUMs+sQUrltk91zskiRX8q/TGcK4t59l8+gpbCnhx+2eelu90UaZ
         +j841Pa7yHyWtHg83Bmc4uP+fCJXrSPF8Dc70fA2gkBomavZoPD7NKn2nuJMpSiOXGWq
         F1cQ==
X-Gm-Message-State: AOJu0YwJd3CqHTZ0Srki/LxW1k+3D4dhSQp5GYVog7DkaIHd9v1AeoM4
	RNVYbtZHgDOcrCiE0njGX12PLZGOyZCHRg2rFiml8OY8C3bE8Q0G+oMvFKIMsq8=
X-Google-Smtp-Source: AGHT+IFn8e9HHIZ/GXriE84Z0xFH51o6Xx7zaXLAVrv6QKqK6//mW9gI94nZHpiKiJTu8zM5ee82IA==
X-Received: by 2002:a05:6e02:1c29:b0:3a0:9d62:3b65 with SMTP id e9e14a558f8ab-3a4d5938015mr37923815ab.3.1729716330569;
        Wed, 23 Oct 2024 13:45:30 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a4d91ac676sm4955965ab.59.2024.10.23.13.45.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Oct 2024 13:45:30 -0700 (PDT)
Message-ID: <237ef4e1-786a-41d4-919d-9907bc76263f@linuxfoundation.org>
Date: Wed, 23 Oct 2024 14:45:29 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Add Selftest to test fork() syscall
To: Shivam Chaudhary <cvam0000@gmail.com>, selftests@ellerman.id.au
Cc: linux-kselftest@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20241022204215.61256-1-cvam0000@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241022204215.61256-1-cvam0000@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/22/24 14:42, Shivam Chaudhary wrote:
> This test verifies the correct behavior of the fork() system call,
> which creates a child process by duplicating the parent process.
> 
> The test checks the following:
> - The child PID returned by fork() is present in /proc.
> - The child PID is different from the parent PID.
> - The memory allocated to a variable in the child process is independent
>    of the parent process.

Short log should incude the subsystem:

e.g: selftests: add test for fork() syscall

In anycase, I don't see any value to adding this test.
fork() is a heavily used system call.
  
thanks,
-- Shuah

