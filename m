Return-Path: <linux-kselftest+bounces-22203-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 071A39D1A03
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Nov 2024 22:02:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8877DB22133
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Nov 2024 21:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 796DF1BE852;
	Mon, 18 Nov 2024 21:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DBwnCjhc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C6C17BA3
	for <linux-kselftest@vger.kernel.org>; Mon, 18 Nov 2024 21:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731963753; cv=none; b=BacBJFOwgetN9Tm596uwr0S7NvhYE9tsC23CbnreopHJMPJXwgvkzvEsrj3khOaPU/mS5dp2qrSemljP8HHY5XZxonPTbVFbNFdGukPc/ZjHePXcFINxqvWSnkgYsb46Vn570pecPR79L8/yjCjOEj98mFLKUjr9PSACh0flbf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731963753; c=relaxed/simple;
	bh=le42+9rIC7jVhHk3YIfqZ0r8CFuKznluHsTDmmkohNU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tGKNCKOcS3eRFVrFUnq1UCtk9933Ee9WBoTaF7wuK8ydl+yNufQJTz9FCHBCFhrTqseVYNHvgeLq8gw5gx45br0sAm9/Zs4F1KhPTXH5BbXyPICxzs+MEhz5RdvUIqbcOznmwymDE3CfSfCgkjuMy88iCkCTJwHH0Cm3bziWtv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DBwnCjhc; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-83aad99d6bfso129686239f.0
        for <linux-kselftest@vger.kernel.org>; Mon, 18 Nov 2024 13:02:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1731963751; x=1732568551; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PPakNa8rDNXMFXl7df49PWizHvmHvh2swC8PsPfcVic=;
        b=DBwnCjhc17xGMj9PjORY0doTpnuoauMa+tnagCTF/TvEGEaR8dZUxjqzVWgUrV/AXO
         wOPaqN9N+LQup8E0+nFv8356OaNqj6UwRcD+fU8I/85KpQrqqyfrp8KeSkRy9vbjNId0
         kjoTi+1/HLNkl/5ldPzNf/rMHfF4ZKa8GFUYo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731963751; x=1732568551;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PPakNa8rDNXMFXl7df49PWizHvmHvh2swC8PsPfcVic=;
        b=MeixEugMR9bF2euFPO8jLb6UyFJjYd/NMg89fL+CyO3qr3wFvctfxLvd9YJWhuFHh1
         XZlDFCe7tFLKEAnwr9gYT+HR0y8XRaSRDvILotCykLx7Yrn96U23bkQ6bvTEpKMi96Wi
         G2ZHITroTa2IrCTXsy4s6dGdPv5M9HaO2yCtBNoNGqKIMDxnVtPONIjH5SDA8JIkIliA
         CyhBe0f/h8vDZcLBwldGlvmnz1+F7pvrtfstOrbgCxU95C0Fq+l41/602qbeHDkQP5Ta
         MF0dhH6KdLN5pCQVnawsr8XZ7SlP7xtPuctakFk5d5pjEzImFJFc+PTbb3CiRP1oJE72
         3kuw==
X-Forwarded-Encrypted: i=1; AJvYcCUcl6UFTUNhkYJ9HtxhSIBTGHiD1Gi/ickD27xY6MbPzSi5vkS4oF33f4FZsygQZh3/o8fPQvJtO7e+ZRRoD/c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaY0iTzVoza+sqWelOcKSXx8Sh0/YEBxeN1luXuPmSJ/Ibg8VM
	IjFK7EnoX7SxSQxE0Y4IAdXldzECZxxdaIWIBc3THYmsuj8Y32QvxxISxdEyZfwRniiZsEoshls
	W
X-Google-Smtp-Source: AGHT+IF+sCKjlMGjaxiRWqQqQ08wQz1xdtaU0837PJltssoRgIjIr8COb5aZYtInwwUQd92ByUOmlg==
X-Received: by 2002:a05:6602:1406:b0:837:7f8e:dfe2 with SMTP id ca18e2360f4ac-83e6c09e713mr1462530639f.2.1731963750734;
        Mon, 18 Nov 2024 13:02:30 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4e06d6ea1c1sm2415897173.21.2024.11.18.13.02.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Nov 2024 13:02:30 -0800 (PST)
Message-ID: <8192e307-b2b9-4c48-87e2-31073c084218@linuxfoundation.org>
Date: Mon, 18 Nov 2024 14:02:29 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2] MAINTAINERS: split kselftest entry into 'framework' and
 'all'
To: Jakub Kicinski <kuba@kernel.org>, shuah@kernel.org
Cc: Tim.Bird@sony.com, linux-kselftest@vger.kernel.org,
 workflows@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20241115200912.1009680-1-kuba@kernel.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241115200912.1009680-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/15/24 13:09, Jakub Kicinski wrote:
> The testing effort is increasing throughout the community.
> The tests are generally merged into the subsystem trees,
> and are of relatively narrow interest. The patch volume on
> linux-kselftest@vger.kernel.org makes it hard to follow
> the changes to the framework, and discuss proposals.
> 
> Create a new ML focused on the framework of kselftests,
> which will hopefully be similarly low volume to the workflows@
> mailing list.
> 
>  From the responses to v1 I gather that the preference is to
> keep the existing list for all (or create an alias to it);
> the framework-only section should be the one to have a new
> list created.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> Sorry for the delay, the responses to v1 weren't super positive
> but I keep thinking this would be very useful :) Or at the very
> least I find workflows@ very useful and informative as a maintainer.
> 
> Posting as an RFC because we need to create the new ML.
I have to repeat the same thing I said when you sent RFC v1
It is going to add the confusion - people don't cc the one mailing list
we have now.

I am going to have to say no. Sorry.

thanks,
-- Shuah


