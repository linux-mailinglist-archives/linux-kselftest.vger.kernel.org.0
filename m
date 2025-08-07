Return-Path: <linux-kselftest+bounces-38494-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E84DB1DD7A
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Aug 2025 21:24:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 893355849AF
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Aug 2025 19:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 814CA2253FF;
	Thu,  7 Aug 2025 19:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fYz35ZHx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D3221E091
	for <linux-kselftest@vger.kernel.org>; Thu,  7 Aug 2025 19:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754594658; cv=none; b=gXv4jfJ3mAhWQQ8YwCELx3zIVviW1PGOdCFYT84Zrozox5eUzCk2pLm1bi9hKsWRp5vHUPoAKxIly6y9aHor/h5gHOSu92GKHU5GK6z77s4C7kShR6tPDVqw/4qJqi83LwzBuM2bOY2/M3k+EmzjPekkrGAlZSOIF/ptGP2mbYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754594658; c=relaxed/simple;
	bh=pzHBDInygcdOKBfQvKEjuYzCE+/IqHTxKAUzOeC7wQc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Krw6GtUh1ZVvpxycSsKae44AxwgixFHkUqTqMXazuKpSYrFsL+Yz3nvjjrDhQz9LDBzdDVErhlTYeP8EJ3+fc1nYADNL352fUmHrk9Ime0+jloDf6V3xDWZ9jVdfpZkqGxqyDP+iigZ3lnAdYNTCfM6yx9OCY0jqOfqOjLJ/920=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fYz35ZHx; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-879c737bc03so42833039f.0
        for <linux-kselftest@vger.kernel.org>; Thu, 07 Aug 2025 12:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1754594656; x=1755199456; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Jl5D6R6RZF9DkicOBmstuJsbsDkcHhXJQHJNQd84i6M=;
        b=fYz35ZHxWe8eSABuh/402btKgpL7hUgl4pkPXmtiIHVNu9nbNl6hLwz/cHbZDoT8LV
         k/86Puos4BC/BbfWjRX2n4zV7iHg+Er0+ld6WIN9YP74bD5kJcSCtHvNKSkY/Npg7IgN
         RJHQfn0cdNMkBQSG6UzHEqX/UmJm0GAT7e06A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754594656; x=1755199456;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jl5D6R6RZF9DkicOBmstuJsbsDkcHhXJQHJNQd84i6M=;
        b=muqV8b3x3mHORYzxRj70sRGgWxoXBmtdTl2ON4TJNoEVIJhKahM0Xj12Y1Z7rMmIMk
         5qK5yZwxMP4ZvFSiBDh/ThqbZOYJDj6OmU+W4JnKFWXJ/Nuy/bSs4f0o06CYE9PLPzkS
         FTg8o8F3pt9J1/7/YosCZvY9xvC2lXQv0EpQjCz1O+Y5tOwXj1XmHsrhtdJXG6roUYkR
         Himgv5pqzTAtgw2xrUv4G7EEfPDXgG2me634bJ4D3kxiryxTl26zu8X8EzLySwewiT0y
         W+S4MhEGGXnqXGJPHVRTBtYw1+DkpYBJUpH9t/A5oj/2HCwJPUKIV5qoobFbZayWRWWJ
         a+zw==
X-Gm-Message-State: AOJu0Yz/jOtyo2lWEIbjObRnhUaaJuuQXk90LkZIgUuGGNvqRf7esEv+
	zjYiCuzYDz8iRGxnzAaB+M8xi2eMdqO9Cqh1QnaX9LDufyw5zjGkEwd15InuwG+xscM=
X-Gm-Gg: ASbGncujMRR+NujzUtD+zIVMHOJ2CAnlMSV2MekMaY6gBdhorB0EGlWJgRs/a1oe9NA
	aheXA056BWI4V054T2OFNYStV9WbyJxNhI1dhNexA9U5T0IvLePghOQolrbjz8p1fVKxYGl2zeK
	Byiwwve5UAh7QzfNgxdTn8Xcna4mRe434gqyX1NQE4q7Kfof2Z64JsrbXJnzmnz8eTVBQrD5Tma
	1mmzSqxsHE+9+JTs++zm4TjN76U9HolTVVV7w623NckKshzNHuLKsCnwyPseAzyYpvzexDHueoN
	uXRaTSfHNeKuUAvTpKMMhvj5+3U2G/3fyEyUAQ2DhLffN57iGreU4QnYspXWjlOUNLW7hO59SI5
	d1yU2EnQ2HdwwUOxrC3r/ReudDEFMOM6PmA==
X-Google-Smtp-Source: AGHT+IGAE1UjB51pwYkcQd9y5uvmXhfe3+scq5aPcFnybQ5b4AuyjT/BKg4xuh+4FQvzaegUS9xSmQ==
X-Received: by 2002:a05:6602:6d11:b0:86c:fdb3:2798 with SMTP id ca18e2360f4ac-883f1255c00mr36334439f.11.1754594655628;
        Thu, 07 Aug 2025 12:24:15 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-8817a0640d0sm348464439f.27.2025.08.07.12.24.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Aug 2025 12:24:14 -0700 (PDT)
Message-ID: <38bbacc3-625d-4071-889c-a5b4d59ec456@linuxfoundation.org>
Date: Thu, 7 Aug 2025 13:24:13 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/filesystems/binderfs: Skip tests if user
 namespaces are unavailable
To: Wake Liu <wakel@google.com>, shuah@kernel.org
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250807134510.1818025-1-wakel@google.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250807134510.1818025-1-wakel@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/7/25 07:45, Wake Liu wrote:
> The binderfs selftests, specifically `binderfs_stress` and
> `binderfs_test_unprivileged`, depend on user namespaces to run.
> 
> On kernels built without user namespace support (CONFIG_USER_NS=n),
> these tests will fail.

Why not add CONFIG_USER_NS to config file instead to indicate the
dependency.

tools/testing/selftests/filesystems/binderfs/config which has these
as dependencies at the moment.

CONFIG_ANDROID_BINDERFS=y
CONFIG_ANDROID_BINDER_IPC=y
> 
> To prevent these failures, add a check for the availability of user
> namespaces by testing for the existence of "/proc/self/ns/user". If
> the check fails, skip the tests and print an informative message.]

Can you try adding the dependency first?

thanks,
-- Shuah

