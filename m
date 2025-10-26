Return-Path: <linux-kselftest+bounces-44061-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C498BC0A502
	for <lists+linux-kselftest@lfdr.de>; Sun, 26 Oct 2025 09:58:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83AEC3ADBDD
	for <lists+linux-kselftest@lfdr.de>; Sun, 26 Oct 2025 08:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AC3828750C;
	Sun, 26 Oct 2025 08:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KMon76BZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E01C223D7E4
	for <linux-kselftest@vger.kernel.org>; Sun, 26 Oct 2025 08:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761469134; cv=none; b=Q9JOaLOxkIDK0rvgiswlfwKtEboOOq8KBr+0aOGl+6HuNTgcFFI5N4+4jabii/DPV3kui2YTbRRsqMvYd6THzFB2yFtxwNzo94/qXZ7N/AzY124K78JhEuYMlsYqcNNk11jgHvWBSLw/Qdc8Bjys9BomY08KMlcp9uu9zuj31s4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761469134; c=relaxed/simple;
	bh=5K4B7s96EMwwaDVEBzoytBv7iE1q9RzEsf4agH12XZM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DJJJADYjCYhh8yE/inm4egSO+Dt7uDGLu2t9AIbH2RMCAuPEJCIAfMC1VeJmcvIvNdoTJ5hNxEnghOvBTNsa9YHFlVpF5JQcm+YLefXVlucgEGe7RtOkC0Ib6HVjH+oIMemD5GHcspmv1PIu8AQV7lgprmWKBgX/L8VIqNlBpdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KMon76BZ; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b6a73db16efso3383311a12.3
        for <linux-kselftest@vger.kernel.org>; Sun, 26 Oct 2025 01:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761469132; x=1762073932; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5K4B7s96EMwwaDVEBzoytBv7iE1q9RzEsf4agH12XZM=;
        b=KMon76BZA7iezln/XZHUxCJhQZRX9NLslCTWfW4lw5hmD2wCcGtMu4pKPaJ3VsdD9M
         7uhj9fYLjxEBKBiZNR+C0qvElKvses1AxCRZv8V4LpiK5vB08UyCWdW8Oxmh1m1ybR9J
         P4YbBSK5ZSr5ncBRV9s7d4eKpTIfWE4k4aLg6b8jphC+6CzzEXXM/lSjT5KN4j7ZGCma
         NvUp/jOhal7A3Of8+GF3/TAdI0o7Z199/l9hqgBQLODggg164fypvwuZlBEZGYP6P5Py
         qfb5tfmvzCWLni/vQ0rKyWlrQJIVtNJkXpJx2tYZrUyu0VZbtigNn/cEbgnAnZ9PM+/1
         GOCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761469132; x=1762073932;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5K4B7s96EMwwaDVEBzoytBv7iE1q9RzEsf4agH12XZM=;
        b=xH20udaFt/lPZAXfw3NO9ciZjmxZv+ToGC+/COeymQAXlUYX4pWDXAhaTO1SbRoFCo
         TQ5ZxuRpmfkJTNsWrrCUDQBQ5z4Vw69jl4RITAGl4D8EoNhXXa7DUQd8yroj8jWN6Yee
         7qpoyeLfcq/44/goxAdwGsIrs/HTTb6sC2VIx9UOETXn58qcmeQZbJXhXSXn0jt5nfj/
         JtwGSoEa4WteW9azHou+sPAPLD/q2clvFb5gCmrxuRRdiBnjoU9C24e1KQJFSmwv60wj
         g7udv/A2YZM9zfkK33ztjqJohSb8YNqAizYSSxmGsyWwp091iB7tau1oLSHwqzLiv8z7
         HxQQ==
X-Forwarded-Encrypted: i=1; AJvYcCXeHU9SkAs/C00YOP3q5n4ZDvC+uJBFa1urckejtwMX4FsP1mjBGyRpI7Jni1Vh+vdQ7lLiJKFm0u4FSbM1Hvs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoZXZ2vbu3MG6PT9cZYxxDGACsc/BiNnPvhZdw4VG8mqmB8Hwl
	sfLu9DgFyAVS25iPLhUuvTL1LRpO/wGiP1M3Ax3qy9qFmO2n1DI2zhsE
X-Gm-Gg: ASbGncuGTj17+iX74baz2N5RM4bZhWdtbeV5/k6IQh5VyG/lkmO8P9hf2bOiTHiF+qe
	fj7Th4/IgPLXCelTnd9eBKc6GfyrXNiS7nfdM4eSDu9OM8/aQaSVCwq4F9rTOPn6E1PfNsw7hbP
	CrgLauwBP2LfusO1Bew0f5ypBQ+GkIm5EB4VBu95cXVXSzgaFXmuclyeL++9wIuP4i0ETZ/LdDX
	W3LsUq3joZR1xX+xhIK8a0bSbHutVAvCnUh4XR+VFnhmpXGT5Epv95L3KEaE8f1M2s/nGugbtDF
	UIVmk+1q5mj73SnUc4qZ9WdUxPyTqmcfBEVx2ApfnHKpZPNOu8OmTAp3Lj5FP6mSaHMC4YtenVb
	Zb8mgqhc1slpmMOgMdHSoE3fd3BdmL+gbSxkaqkbLTNltI5KY6+gh8uyMHT0Kjh3ZBCPeJNMWK9
	f7khV8OP7w1agoIronkXwowxg3gQrz/7A6AI7WbUcXzhJDeZh3pLblhWKalVsW0f/oakM52u3OH
	VNJzQmS6/iKe9ceYYtWHMkCCkAd0thR7A==
X-Google-Smtp-Source: AGHT+IHbY4zR+pxQ2HAXsXrhA3W5dSP1Wj+vZRqqpwWFOwc/lu9gHcqd7/GoXq4UV6YsapVAtB9Wiw==
X-Received: by 2002:a17:902:f690:b0:290:ac36:2ed6 with SMTP id d9443c01a7336-2948b97fd44mr101660985ad.14.1761469132156;
        Sun, 26 Oct 2025 01:58:52 -0700 (PDT)
Received: from ?IPV6:2606:4700:110:896a:5f1b:2412:be21:3a45? ([2a09:bac1:36e0:1c0::10c:2f])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33fed70a83csm4611330a91.4.2025.10.26.01.58.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Oct 2025 01:58:51 -0700 (PDT)
Message-ID: <da05d1d1-c241-49af-bed8-7db5e9968396@gmail.com>
Date: Sun, 26 Oct 2025 14:28:46 +0530
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/seccomp: fix pointer type mismatch in UPROBE
 test
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Kees Cook <kees@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, khalid@kernel.org, david.hunter.linux@gmail.com,
 linux-kernel-mentees@lists.linuxfoundation.org
References: <20251025184903.154755-2-nirbhay.lkd@gmail.com>
 <aP0-k3vlEEWNUtF8@krava>
Content-Language: en-US
From: Nirbhay Sharma <nirbhay.lkd@gmail.com>
In-Reply-To: <aP0-k3vlEEWNUtF8@krava>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



Hi Jiri,

Thank you for the review and for catching that inaccuracy!

On 10/26/25 2:48 AM, Jiri Olsa wrote:
> just probed_uprobe right?

Yes, you're absolutely correct. Only probed_uprobe has the
__attribute__((nocf_check)) attribute. I apologize for the confusion
in my original commit message. I'll fix this in v2.

> curious what compiler do you see that with?

I am seeing this error with Clang 19.1.2 on Fedora, which enables
-fcf-protection=full by default. As Sam confirmed, the error occurs
specifically when CFI protection is enabled via -fcf-protection. GCC
without this flag treats it as a warning or ignores the nocf_check
attribute entirely.

I'll send v2 with the corrected commit message.

Thanks again for the review!

Best regards,
Nirbhay


