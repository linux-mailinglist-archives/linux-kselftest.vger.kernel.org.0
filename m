Return-Path: <linux-kselftest+bounces-10582-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C7658CC4D3
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 May 2024 18:19:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82DAD1C21A04
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 May 2024 16:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F7C814038F;
	Wed, 22 May 2024 16:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="M+yRx/qJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D15B013FD69
	for <linux-kselftest@vger.kernel.org>; Wed, 22 May 2024 16:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716394777; cv=none; b=jaYMmX52q300XCE+0OguoGPzGYIbS6PQPbIpp2lDiO182c+ATVUlQWTC+enV+yH7hex1NeVOqxQIH77ur25QV65i+06AsBJTL90eJ2On70PqFmYxYPU1FbSb2NbgmKS9JwgtFgej5dTb6ZL9pGFYieTRWNPKTlF/5Nz73amfpGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716394777; c=relaxed/simple;
	bh=gRGdiC32qyMGfj6WpEKPIdOaphnyHadvcat7Ef04QOU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q/B9PfVnUo24H7vbr5owG/jn+bwhgxVBirRYQVJOBe96PJP7DoU362jNU+nS3nFHAb7B4WKd81yQRAHNfcpPVuyMyjIsU3qxo+dkQnYh9QMpg5mc9iusNmX9K4cVjceQCXqKXpVmoWgRpIObIHjE3OSY9BI7ciI4PuP07eNwTZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=M+yRx/qJ; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-36c84c95c23so2291205ab.2
        for <linux-kselftest@vger.kernel.org>; Wed, 22 May 2024 09:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1716394775; x=1716999575; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=26coTTJPMwihRdwvqlxfLCNSgtD/ruUTDG9z4IGxkNE=;
        b=M+yRx/qJyV3krTJFoIJpvzfi5HD9gPOjhWMFsZvS2WRQuzcBNB/hwbz/AHOa4wY+th
         melQpBTsw3k8gyBdsCQAWDwm4ORJZG7qTjNgWuvT9k0e08W5V/6Bbgm1DM3CKge55wHg
         EooZNmGoEJrYgfRZu5Gh0qTVOiGcGlDf3K0y4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716394775; x=1716999575;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=26coTTJPMwihRdwvqlxfLCNSgtD/ruUTDG9z4IGxkNE=;
        b=VIhXXBrBlK47hDw1sbCm7MgQKLN/x0tyLSY8wobzJ+bauSYLskjWaQxhMkn0Dh0Tvr
         2z2eKWIq1BL+C/og0+RZgKgSWGxyBVp1lqdPWyl+iqHi/su/UNaLgp6PY7TG3KTECGZ7
         1KmHgeZQKwFP1bS9rZAJLe5tW3t6akkvE9cEI1e0UuxJoP68Uxn6i2bHp/Q5UVIcKeDm
         9Z5/4LQwBbAIqGWPm+RgyBYhu92sOVCPuPMNi7Uqz0tha7NSD+YisKDf6ZK2wZcEc/++
         PEmGZSBueZtNXDavFICxJ4r1C4h7hzsF7WKgfAoufIOFI45xkRI3GUtqpuRm7bCNWFIh
         3SMw==
X-Forwarded-Encrypted: i=1; AJvYcCUghQsBDAIBuse+apqqPlIvs5SNr106+Yw3lmOQhOANrzKzIRxOiw3aVh8IhAkvQ2pbzANysRCgK+xmmzAjKW3cXWaOpSe/e9tFqtA0UGms
X-Gm-Message-State: AOJu0Yxj37BUMc27V1SvzcWn3DxRMtrZRrzyeZY3PQD5AG58+O7EOEc9
	d1GEMtkDZg0ucTRy1UozoVh2Q6hwsDmou575yzl7lJFgXXNFCCwJ6yTNYbKxRLU=
X-Google-Smtp-Source: AGHT+IH/KZa0o+v3YObJYKHyHITiD47mIwmwbzcFdaePVDylL6T1KHgx+UsgI0x7EBrdYtRJOKeT1w==
X-Received: by 2002:a5e:cb03:0:b0:7e1:d865:e700 with SMTP id ca18e2360f4ac-7e38b2004fbmr274656739f.2.1716394774799;
        Wed, 22 May 2024 09:19:34 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-489376fc6aasm7421787173.174.2024.05.22.09.19.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 May 2024 09:19:34 -0700 (PDT)
Message-ID: <6caf3332-9ed9-4257-9532-4fd71c465c0d@linuxfoundation.org>
Date: Wed, 22 May 2024 10:19:33 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 00/68] Define _GNU_SOURCE for sources using
To: Edward Liaw <edliaw@google.com>, shuah@kernel.org,
 =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
 =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>,
 Christian Brauner <brauner@kernel.org>,
 Richard Cochran <richardcochran@gmail.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 kernel-team@android.com, linux-security-module@vger.kernel.org,
 netdev@vger.kernel.org, linux-riscv@lists.infradead.org,
 bpf@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20240522005913.3540131-1-edliaw@google.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240522005913.3540131-1-edliaw@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/21/24 18:56, Edward Liaw wrote:
> Centralizes the definition of _GNU_SOURCE into KHDR_INCLUDES and removes
> redefinitions of _GNU_SOURCE from source code.
> 
> 809216233555 ("selftests/harness: remove use of LINE_MAX") introduced
> asprintf into kselftest_harness.h, which is a GNU extension and needs

Easier solution to define LINE_MAX locally. In gerenal it is advisable
to not add local defines, but it is desirable in some cases to avoid
churn like this one.

> _GNU_SOURCE to either be defined prior to including headers or with the
> -D_GNU_SOURCE flag passed to the compiler.
> 

This is huge churn to all the tests and some maintainers aren't
onboard to take this change.

Is there an wasier way to fix this instead? Please explore
localized options before asking me to take this series.

thanks,
-- Shuah

