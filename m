Return-Path: <linux-kselftest+bounces-14671-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E32049451B2
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Aug 2024 19:44:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97FA22870A9
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Aug 2024 17:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A5111B9B3A;
	Thu,  1 Aug 2024 17:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="M4ECSnYT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A87E1B3740
	for <linux-kselftest@vger.kernel.org>; Thu,  1 Aug 2024 17:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722534280; cv=none; b=rLsQeBEgdHhO1Rh63isCLUEEuYPboiOin+jQ4zRPFFOhhDSa5GN2+so2f6WqymcEco1qirXrPjLI0zF2TO2nBB8YDWkryqmiObuoz6BkEfnlK923lzVH6JQBeHAc2q3ORD+uQh99Fj89FdNaeR4a7CnqP5QqkeKtcECa8VWjpX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722534280; c=relaxed/simple;
	bh=I/6BYgXfwD7VTdzMUgfPjpJ/me/7dvxJwjK4+xsmwhs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k6WwpzvSJLuqPeeYaazspyAdKfvNnkCtJXuBEq4ovfmbQ8/MEIA751er4Fa9sksc/nhMsO7KsWy2rZA7kQS3QllFSfMDIv1YX75vgi9ks9WXZ+Ti+Rjn84e3c7aC0of1r1JkYQ2ZkRC/ff74Uk+rBlNzG+IZOzvrXC25isnc8OY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=M4ECSnYT; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-81f86cebca3so45988339f.2
        for <linux-kselftest@vger.kernel.org>; Thu, 01 Aug 2024 10:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1722534277; x=1723139077; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FaYvR43eXSTKGl7sbMAumoztLb3EE60Ut4UBbLOq7Qo=;
        b=M4ECSnYTD18gVGFulWlDJE5vncN9of5pkhbuvU8NJ82sajh5YgssaA13sH/bqnEZAI
         73fZzGoZCQIIX/lT3HZuyxuEjgOy7NnmNdqAvdjVYzUNlx3XxpP3lwWzT/r2H/8C5DdI
         +aZkklwIT4SjHU1h48U6wgtPFkgVDfE8JeODk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722534277; x=1723139077;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FaYvR43eXSTKGl7sbMAumoztLb3EE60Ut4UBbLOq7Qo=;
        b=FFng+BoLy/DhENIp30VYE3V9W8/5Txhh0mqP1zhoC3kVwyOgtmlf38VvRXibepYYSA
         4xby4tJ6tZEBm+o+ReqTcfFChws9OAl9KXENOoEBkQS9Q3+rjg0wQJgGzMdQGdsQVfAn
         tYb4i/xJ3FkJ909HrhfsGwvDBMXuMSlXrlCb+fGLVp1hSL79vq7VjVfZf0QYdN0wL/9R
         GxbyMolPyDjyntWsniw90wYITeYe3TdPWMQnEVLdBCYy55E7ZSE7RDb/pedeMIiMyI9C
         8UkS1cbZmxaTo2MCy3i/AElWS9ycO2lHVh3YLOM8szlEAYiTK6CZJPXaaoG93xkN0w02
         yz0Q==
X-Forwarded-Encrypted: i=1; AJvYcCXEpe+DPoXaCDYcTCu3JPGcHM3ACpHLYRY6VHnWEKDschMnWp6pz0tYef6sF0EnmYy1ZygtAYgqE2iqq5jo5/WoYd7HASJT5BXul90bV5ri
X-Gm-Message-State: AOJu0YwDAihK6JoGFgHHXyNPlNLD7wO6ig5o4sf8rYle+SKRbHWg913p
	MD4saOSkOTWc4YLK7TdxZBUKXQobb2JVed5Yo7OMrTQ/GZppvnenm+symk4w5YQ=
X-Google-Smtp-Source: AGHT+IEAB9vhCdQemJAX2MsHqVWSSoLQnu+LuQK55mgCrY9F3soUgHCABNUjxj/m3bU95iJi5gubwA==
X-Received: by 2002:a5d:8185:0:b0:80a:9c66:3842 with SMTP id ca18e2360f4ac-81fd43d5bf1mr66550239f.3.1722534277575;
        Thu, 01 Aug 2024 10:44:37 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4c8d6a27a68sm28214173.110.2024.08.01.10.44.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Aug 2024 10:44:37 -0700 (PDT)
Message-ID: <f450b365-b30b-412c-b42c-7ce69f61bded@linuxfoundation.org>
Date: Thu, 1 Aug 2024 11:44:36 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] selftest: acct: Add selftest for the acct() syscall
To: Abdulrasaq Lawani <abdulrasaqolawani@gmail.com>,
 Shuah Khan <shuah@kernel.org>
Cc: javiercarrascocruz@gmail.com, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20240801-kselftest-acct-syscall-v4-1-3e072d9b3691@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240801-kselftest-acct-syscall-v4-1-3e072d9b3691@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/1/24 03:29, Abdulrasaq Lawani wrote:
> The acct() system call enables or disables process accounting.
> If accounting is turned on, records for each terminating process
> are appended to a specified filename as it terminates. An argument of NULL
> causes accounting to be turned off.
> 
> This patch will add a test for the acct() syscall.
> 
> Signed-off-by: Abdulrasaq Lawani <abdulrasaqolawani@gmail.com>
> ---
> Changes in v4:
> - Add SPDX License identifier to test Makefile
> - Link to v3: https://lore.kernel.org/r/20240723-kselftest-acct-syscall-v3-1-16f332498a9e@gmail.com
> 

Applied linux-kselftest next for Linux 6.12-rc1

thanks,
-- Shuah


