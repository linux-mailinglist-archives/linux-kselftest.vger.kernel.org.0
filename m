Return-Path: <linux-kselftest+bounces-10961-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 872378D5463
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 May 2024 23:14:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BFF81F220BF
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 May 2024 21:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E3E817E441;
	Thu, 30 May 2024 21:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Csy++LCS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75AA44C86
	for <linux-kselftest@vger.kernel.org>; Thu, 30 May 2024 21:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717103580; cv=none; b=cWAmH0sev7s165/+WqBOOcuH4KFQUdoQVMigTtr+4oXy/OiokKIQlNSA4FjCZZbC/yA2/l7Fc3mJnO/fXHaGfNyG696GtayJ9Vn/oEv/7lfTnPLWNPuZotWkOUQvCJGRZBR9xRI47V+pCcQJJ/8DZs9r3giSjAq+q5InMCLuE8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717103580; c=relaxed/simple;
	bh=nyif9nV5MZxEv61ZzzS4YP56t1CRAFYYagtsWILkqWc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oMNgQjmC7erh5Vg9JpiscN0G0ETr62GXHewnTUO66F23QvfiJ1xpdAsAe96eAx9d2sGPPgJ4J8iFLJRBLDHCUu06NrueOo9CqMgoSs9Mb23kKxPt7IhH14lbPY8cPPZhfDm+Oz+oJ9EgD+Ui0ckkJw8588vIoojaecCrpPecQlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Csy++LCS; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-36dd6cbad62so782895ab.3
        for <linux-kselftest@vger.kernel.org>; Thu, 30 May 2024 14:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1717103578; x=1717708378; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bnFlTPs2pgPgYgNKGfWbxk0F5NtAH0V5NFqN7FXOABc=;
        b=Csy++LCSXYpZrsQoZrxSCF6fYzzfMYlUUzo5etpE9K8p6C6KDeorgH6U/wM7UPRdDQ
         1SJnf4TzLznSBwtRDs5HZJbM+eJ6X9oTzSMyuq2Tq+E4Dfg6P18GfCKscjh7KHvaGMRY
         bB8uu7IQda5IioOinB2FNxCYeYnJ5HJAFJK8Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717103578; x=1717708378;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bnFlTPs2pgPgYgNKGfWbxk0F5NtAH0V5NFqN7FXOABc=;
        b=D+sux+m1Lp/sn9hkfNc2Uvocv/psBwK+BxRYPMAGZiIP/9mexckFSgxsiSkbTiKN89
         pl1eCLKjoS9rJU5PxAepYE/QcsGzMbK2bizTuI6XxaOJMFFuefqZt/UJVVRol1Q0/nHT
         TSMn2fmyqwwbCAmEqhO0XUyENdSAAgiDz7KTwyTe8uA3CmPPJtaXSKeO9FtyWu7Soob7
         WH3xKyFrfOBUzt1OlwHDijdFuys2Qt74m1IurlnCUzt1/yT7VqaZVIv/C69hwGBJCU7/
         Mfy4K+yP86M2+QJytl4QRC7Z0eaR+8V9FD1yzpU7X7s8NsLK61zPwVGmC9pj32bIulcs
         HToQ==
X-Forwarded-Encrypted: i=1; AJvYcCXxeNnoFxLDQO8coJWYd+sRjduQU+NQwvW4WIpjK2Qvfq+Q5w8k3XziSETGwOSJPMleucpDV518gpQKcDoKVBwbzSARgAWxJ2VBKcscKtKw
X-Gm-Message-State: AOJu0YxNmL4VHdcjgJpO5P/gMbXjfF4soBdjtqctFapvyviEYZ7N2Zww
	Ec3Q5qyKrhDjkOHa2oeN4r71YSfmiE/a3HwQcRtjoIKo2t/PFL0ibEJ4KrghlcQ=
X-Google-Smtp-Source: AGHT+IGdrW7VRbsLHIIM7gzHL5CfKiNx8Q+kkXA5ZXqU7ioxsuz8AxYlMvZPYH9q+VjuZBtG61SjrA==
X-Received: by 2002:a05:6e02:1a0a:b0:374:60da:64dd with SMTP id e9e14a558f8ab-3748b96e509mr906225ab.1.1717103577901;
        Thu, 30 May 2024 14:12:57 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3748a27a27bsm1084115ab.87.2024.05.30.14.12.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 May 2024 14:12:57 -0700 (PDT)
Message-ID: <3db9068e-9f95-4ad9-86fa-e24b06da8828@linuxfoundation.org>
Date: Thu, 30 May 2024 15:12:56 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] selftests/futex: don't redefine .PHONY targets
 (all, clean)
To: John Hubbard <jhubbard@nvidia.com>, Shuah Khan <shuah@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Darren Hart <dvhart@infradead.org>,
 Davidlohr Bueso <dave@stgolabs.net>, Edward Liaw <edliaw@google.com>,
 =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>,
 "Nysal Jan K . A" <nysal@linux.ibm.com>, Mark Brown <broonie@kernel.org>,
 Valentin Obst <kernel@valentinobst.de>, linux-kselftest@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>, llvm@lists.linux.dev
References: <20240529022938.129624-1-jhubbard@nvidia.com>
 <20240529022938.129624-2-jhubbard@nvidia.com>
 <ceb9182e-b6d4-4f6d-bb53-87efe5337230@linuxfoundation.org>
 <20ebb3a6-cdbb-4ffc-9ba2-c9eaa4d6ec74@nvidia.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20ebb3a6-cdbb-4ffc-9ba2-c9eaa4d6ec74@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/30/24 13:13, John Hubbard wrote:
> On 5/30/24 12:03 PM, Shuah Khan wrote:
>> On 5/28/24 20:29, John Hubbard wrote:
>>> The .PHONY targets "all" and "clean"  are both defined in the file that
>>> is included in the very next line: ../lib.mk.
>>>
>>
>> What problems are you seeing without this patch?
> 
> Code duplication. It's a sin. :)

Please mention that you are removing duplicate code.

futex Makefile overrides CLEAN - just making sure it
does the cleanup correctly.

thanks,
-- Shuah

