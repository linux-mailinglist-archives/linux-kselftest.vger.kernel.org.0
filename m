Return-Path: <linux-kselftest+bounces-3603-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 622B183CE4B
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jan 2024 22:15:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 143B91F24FF1
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jan 2024 21:15:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 218ED13A255;
	Thu, 25 Jan 2024 21:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hcuXl/1s"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E5813A24F
	for <linux-kselftest@vger.kernel.org>; Thu, 25 Jan 2024 21:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706217315; cv=none; b=Pcgj7aoLFr42CYIiVCR8dIqINCdHNVFulxc4ntDUj+6ntdzDFH81V6sQV10tcnMUj/4IM9Huw34uVk7yiiYETvBhWUqw1HAdBrKoQ3fTU8d5sA3/zWj9fSKbzRAtgGT2IEQWmA2Wfd7+WVQajMF5YN8Rw/e8XFo9+soimhrvjE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706217315; c=relaxed/simple;
	bh=b/qs/nkt+9BuESReMPYiO827KTWJWW0+QfrfS9/NXgs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PQVkAhldUYmAydmznAizKg6HgJK0NaMIfByQwE6wq5MGiOLaml9Lw72AL5JWSgvkTBJ3fPL8eAdwi87r2rBOtDJTj4xz/eDpBcjUtWO0fRaaHm5WU1WR0hr7yPRYQQ8Xn0eAgb5CkumUTepRtDzQJg320Ks31DW+AfV1EOf4omM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hcuXl/1s; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-7bb06f56fe9so87041839f.0
        for <linux-kselftest@vger.kernel.org>; Thu, 25 Jan 2024 13:15:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1706217311; x=1706822111; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ukzAY7Ia5t5Dvy0Ix5ly4ai+YCBGcgR+LuvxltyaCZQ=;
        b=hcuXl/1s1YvDG0+HCX9DXODxbB30MIK5II+tgWlO4Qh+l1YC/j+04uRZb5b/1u2Ens
         J57kLUgYGh7FxISRTjpYDo/ZNuy9NRwt6ZyNEjFMCb3NSht2e+8aqCUz03lKWGWD0z49
         TdjYL+Bp9b4mMcqI+N7gaoUilUb3PdGbwsUYA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706217311; x=1706822111;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ukzAY7Ia5t5Dvy0Ix5ly4ai+YCBGcgR+LuvxltyaCZQ=;
        b=boeF1rHYT189pg1D+GAxeGbK8511aLTjBV9mgR81SQITcDoSIvOsqPl/drF6EPzKwn
         hQuaHlNDRr2r9gss+Zm4UqAm5jNQpaMHHH5MNVg5VR25iHwekBpZ17duBhr6yZgbd/jY
         FmDHmLmpjI4jl9ZGY+2symD3L3VWQuewnReDl1boMNKKhEMY6dFCLFJ5F0TL6XvkXKVW
         Qujqu7ibffEguHaeGSFFiAY7rhFpbIndU3H4gyuUtIXHSzZ8XQFZqGFy5EFiI7S6u+Fj
         rS3/+tzn33EiCY+TwTy4vgXwlrdj18AAUejhyb7OU0SzSp0NHm/QN4sB7zfeRuC7UH3x
         mciQ==
X-Gm-Message-State: AOJu0YwwZ7VuiedPlIiEyE7tUCtTYdPYoZ29AfhSWItwqqGcQa6rqEfI
	lge9Hu15fXijwIZcxG7T5m6LevRzfDSWwR+JJArXFAYntMl1D7WuEQg2DOTKFcU=
X-Google-Smtp-Source: AGHT+IGgSDqpN5Nf9SwdxyyhjoxVnGwF3qhAxf3L0te+12vXSMjDhnzep66R9fzDIrxZFj8XvHYjrA==
X-Received: by 2002:a6b:e416:0:b0:7bf:356b:7a96 with SMTP id u22-20020a6be416000000b007bf356b7a96mr803126iog.2.1706217310758;
        Thu, 25 Jan 2024 13:15:10 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id t5-20020a5edd05000000b007bfbe4e309asm395593iop.27.2024.01.25.13.15.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jan 2024 13:15:10 -0800 (PST)
Message-ID: <41addcfe-f897-4394-bf40-aaef22c27fca@linuxfoundation.org>
Date: Thu, 25 Jan 2024 14:15:09 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/2] kselftest/seccomp: Convert to KTAP output
To: Mark Brown <broonie@kernel.org>, Kees Cook <keescook@chromium.org>,
 Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>,
 Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Anders Roxell <anders.roxell@linaro.org>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240124-b4-kselftest-seccomp-benchmark-ktap-v4-0-cfd2bd2a31cf@kernel.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240124-b4-kselftest-seccomp-benchmark-ktap-v4-0-cfd2bd2a31cf@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/24/24 06:00, Mark Brown wrote:
> Currently the seccomp benchmark selftest produces non-standard output,
> meaning that while it makes a number of checks of the performance it
> observes this has to be parsed by humans.  This means that automated
> systems running this suite of tests are almost certainly ignoring the
> results which isn't ideal for spotting problems.  Let's rework things so
> that each check that the program does is reported as a test result to
> the framework.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
> Changes in v4:
> - Silence checkpatch noise.
> - Link to v3: https://lore.kernel.org/r/20240122-b4-kselftest-seccomp-benchmark-ktap-v3-0-785bff4c04fd@kernel.org
> 

Thank you Mark.

Applied to linux-kselftest fixes for the next rc

thanks,
-- Shuah


