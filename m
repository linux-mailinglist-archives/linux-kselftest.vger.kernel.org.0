Return-Path: <linux-kselftest+bounces-48432-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AB5DCFF279
	for <lists+linux-kselftest@lfdr.de>; Wed, 07 Jan 2026 18:41:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7CB1830019F5
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Jan 2026 17:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E246138BF7C;
	Wed,  7 Jan 2026 17:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cBm3kbg4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oo1-f66.google.com (mail-oo1-f66.google.com [209.85.161.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1EBD38BDC2
	for <linux-kselftest@vger.kernel.org>; Wed,  7 Jan 2026 17:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767806934; cv=none; b=Tv4hcLRr8/Qt7hMpvbsQLKctJK+/BO8gR1GwOdndNM/3cUd9tfg7iOgvYnVG+kMBBPxCSD/9zRbpmYL0QtlZgJG9i2PMk3tlqWogZKCySNOruVWuXYt9idMqQ94ReWvoEos8D2GsdQk2PdYYSTsebo8UbaVJB8lK3Q+NufcIEE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767806934; c=relaxed/simple;
	bh=br6zBcDuLojNVFkIXA8jR8L14Iaj/Gxz90XE4QC1fVM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nKewd8L3YgtZjqg6FszvEe/ZHXDem9c3z1josS3e2WqDS5d7zAHK2BkvRPKtlfjtsPfGL+W7kA3M888W2BW8MGLzLVq1fV0wKPVSdoeHZynVPWRRX6BVx/i9f6WykmHk1aEpWQ69sWhfa1czjwKZD68lpSd1AhuqlRzVzLuLiuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cBm3kbg4; arc=none smtp.client-ip=209.85.161.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-oo1-f66.google.com with SMTP id 006d021491bc7-65e94e128beso611708eaf.0
        for <linux-kselftest@vger.kernel.org>; Wed, 07 Jan 2026 09:28:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1767806929; x=1768411729; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=21eVsWr19rtU1hW9ahUpggNJDprmEQYBoATevC+1CPQ=;
        b=cBm3kbg4vDkcIZkHeydVYRQKuP0SP4giN92ncU716H2lfJfASzAOZQkSBgaKUfqU5p
         Uc6+wt4eWKCixEXqfQkX+OLkpcNaDI32CIGQgEaZ2G69ldleTlCCuEdhgZ0gyzTg6oo4
         oQaIllq5erSgFPRzMkzhDuUfoi4fghBsngpYg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767806929; x=1768411729;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=21eVsWr19rtU1hW9ahUpggNJDprmEQYBoATevC+1CPQ=;
        b=S+X8q7BxivzHn9dVKyo6JylANsMbbm2OKBT8M505Nc6Iuwse9+lsFXUuxm3QrcypbX
         6wGBK7W7hnBefVQQkWCyXHtCFbzd3O5f6/UGvpn03GWIcDLbzopx9I0kBvqE8bww9xq/
         qIRPJq+bh9nyu2u3XZZh+QltFM1irlSOGzVEhXvMYRWF/XUrmGgmjtPayjUt4z+EyyD8
         M/0RbVkqx3zzAfyFrX5KxqZBcU9YeiXBD38rOaQtap3S6vEXjRESxmk+w5bL5gXjOIZo
         hFP9OyGD9LOS5SKFMFduYRYnkZFm2VCknyD+OTWKDXs8yTjFd9e1g+uy7LolK5tUPmYY
         hbRw==
X-Gm-Message-State: AOJu0Yy5Ok10aHWoX8ydgdotdSAujxhxOWbLJJxPqzABXw9Rg/PTicGM
	XAB5bKFqdZrGGP8huuOXXp0f7cpwMrfnuIYVNz3zgIwa5A/2jPHocDEyJzPXLxpB9pk=
X-Gm-Gg: AY/fxX5mS7S1hkvowvCR7gvDW3hcDmDngtMeybe4daxl6eR2PWE/Df9xhtG3LoQzBgP
	gHTu5WyrW5qG2dzhI3LVZvx1kOWiNB3QUGMplbs00mUzP4kK35ScEJCQaZYIZOWtMk9aI20DgmP
	CvcdLNbs9CY2/mWD/6tOnGgwn6uElfglNwzjjYHgoQ4NnTSSxHWYuSwHnYcR5Ee8hniqNgdIOod
	Zk5JxNzjU4XD+nHbjOiKd9v+oQWThHb1DrIpDQPLNcPVazu+vY0ewLhXCl+41hs32FbhoBVenkK
	vpi6s/vKx3VrmH+GQ3Ud9S/6QjdT/hu+z+8PSxYVv9rOuGX1zsjhfgOCvB48cnfUXI8ETB9TK+R
	1IvmH4YGoWW+XoLSzoWfk2p4idKLpgPKivYecXYM0nycQSAw+t8i1jyfqSiV0xmk0NOqEYBJK1U
	RjPwYI7KXgQjCxK5AbdvfXZ+I=
X-Google-Smtp-Source: AGHT+IFWQLMRXy5qr1fY1jc86LpzwmTcJAOQxZ2cxtES6VgjMxi/0uUaSy+pcMGImt5bnmU4h3OBhg==
X-Received: by 2002:a05:6820:125:b0:659:9a49:8edc with SMTP id 006d021491bc7-65f545f5bebmr1037967eaf.16.1767806928854;
        Wed, 07 Jan 2026 09:28:48 -0800 (PST)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-65f48ccff66sm2357694eaf.16.2026.01.07.09.28.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jan 2026 09:28:48 -0800 (PST)
Message-ID: <4efe59a7-5119-453e-a412-fc22ed314fb6@linuxfoundation.org>
Date: Wed, 7 Jan 2026 10:28:47 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] kunit: tool: test: Don't rely on implicit working
 directory change
To: David Gow <davidgow@google.com>, shuah@kernel.org,
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 Brendan Higgins <brendan.higgins@linux.dev>, Rae Moar <raemoar63@gmail.com>
Cc: linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
 linux-kernel@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20260107015936.2316047-1-davidgow@google.com>
 <20260107015936.2316047-2-davidgow@google.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20260107015936.2316047-2-davidgow@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 1/6/26 18:59, David Gow wrote:
> From: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
> 
> If no kunitconfig_paths are passed to LinuxSourceTree() it falls back to
> DEFAULT_KUNITCONFIG_PATH. This resolution only works when the current
> working directory is the root of the source tree. This works by chance
> when running the full testsuite through the default unittest runner, as
> some tests will change the current working directory as a side-effect of
> 'kunit.main()'. When running a single testcase or using pytest, which
> resets the working directory for each test, this assumption breaks.
> 
> Explicitly specify an empty kunitconfig for the affected tests.
> 
> Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
> Reviewed-by: David Gow <davidgow@google.com>
> Signed-off-by: David Gow <davidgow@google.com>
> ---
> 
> Changes since v1:
> https://lore.kernel.org/linux-kselftest/20251230-kunit-pytest-v1-2-e2dae0dae200@linutronix.de/
> - No-op rebase on top of kselftest/kunit
> 

Thank you.

Applied to linux kselftest kunit repo for Linux 6.20-rc1

thanks,
-- Shuah

