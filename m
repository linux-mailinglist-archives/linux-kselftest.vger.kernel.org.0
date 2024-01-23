Return-Path: <linux-kselftest+bounces-3431-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 765DC83970C
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jan 2024 18:56:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7DBB284DE3
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jan 2024 17:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CD4C811EF;
	Tue, 23 Jan 2024 17:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JU/tK5wa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10530612FA
	for <linux-kselftest@vger.kernel.org>; Tue, 23 Jan 2024 17:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706032566; cv=none; b=o/1aaiFoq2XByaVojMPnbVRcjKi9uXrNGtjUTUZBKnCjmjlKvKOAyyxwssDPNo2zXl6slDqRaBsCCvEfuNEsveE5KmWcwFwUIvFxMh30HlBEXw2gC1Cjn1y1hMjqkkUE89qHfu3YshnarnY70ZaZjGm3C9piF2nzJQ2lHZWwQ58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706032566; c=relaxed/simple;
	bh=lTw2d+jEr19zQERliBwvc7vpz5HMAj1TWQn6WLETomM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gW/GfskVu67sFzkdQPErHu5FqIXFHsv+J8A7wkqZDYD7d3n6T2o9oLWyv9NM5u9W8UxS0HwjDjCTgLULSoBai9YrT9fkCh5NtF8krVvOt8OGfu/kLvy4F/ZVow+CQcudW7co3lKWQdUtt1qvQLl0mum/sRZ2Nd+6w62a3Jg6veE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JU/tK5wa; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6d9b41a3cb7so1494587b3a.0
        for <linux-kselftest@vger.kernel.org>; Tue, 23 Jan 2024 09:56:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1706032563; x=1706637363; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vW1EwQtQkDL16oAi0iCe/mJ0F+Pfw76tUi9aoHvOjRw=;
        b=JU/tK5waHfMH8WO44+HFW1Vsar7DtylGPb1mVFd2Mmo0EGwGTUwWAKtC/83BvcSiCz
         lfsLhOXpIM9m92iOd73LXlaKVEe531tqPyARu2x4r2XJ9inIK5FjIt/pYEm3GCaAJheA
         WJJIklfn6wnTAGDa+Jq8VeRTTBV7BmkiI+xFs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706032563; x=1706637363;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vW1EwQtQkDL16oAi0iCe/mJ0F+Pfw76tUi9aoHvOjRw=;
        b=Ar0SA7J2IIsi/EZOE/3SgIopVtbTmAcM1lVyXRr73UEIiKDhJIkgV6Vd8tBZ4Tg9Jy
         PnSCQSuGlF0R5J4rwmcYUMLUTvoUf2lcxZbu9NOFSg7ndOH4bKAW308Jr0xNmIAmQOMf
         dAQdgDtrvUF/Ltje/bP5Ox5qDySfDg5e8BqFBMsDY68XrauOQj01j+pF6nVhTm5C+p5M
         s1xuKU/cD+w5lw8DhqJyEoWrtrfHBDzSsQZdZE1l8nXY4JFac6KsxPzmF0KmlshCWfVu
         ZJZlRR4IFzLzCBEzaYg8N6zEb1eRah3rxQRpXjBrDqxXGKh1lLcOmlFz2MZ8CJlg+NgK
         O4dQ==
X-Gm-Message-State: AOJu0YyWVHo+INVbZ9GO9moA/Box0iMluSnomotpuRBFvqElBR07FIEI
	Ae2utrruk7+pU3dXjIIzjLexdym+JQ1tBbY4XdX1ewwrv+xAxU1TnsLi3o9i7IU=
X-Google-Smtp-Source: AGHT+IGS2tOvuR7n33KSMNw4mOSzqzR31U9JGY3psgHs+GV4iEzWcOcjv2KXq+2/qM/y0ShIPbl1Dg==
X-Received: by 2002:a05:6a20:671b:b0:19b:7fba:7d34 with SMTP id q27-20020a056a20671b00b0019b7fba7d34mr10178109pzh.6.1706032563332;
        Tue, 23 Jan 2024 09:56:03 -0800 (PST)
Received: from [128.240.2.100] (rbi200e.jcresorts.com. [206.170.126.10])
        by smtp.gmail.com with ESMTPSA id ks11-20020a056a004b8b00b006d6b91c6eb6sm12207705pfb.13.2024.01.23.09.56.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jan 2024 09:56:02 -0800 (PST)
Message-ID: <1f220805-d5b8-4f84-9edd-ff3a9659eb19@linuxfoundation.org>
Date: Tue, 23 Jan 2024 10:55:58 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] kselftest/seccomp: Report each expectation we
 assert as a KTAP test
To: Mark Brown <broonie@kernel.org>, Kees Cook <keescook@chromium.org>,
 Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>,
 Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Anders Roxell <anders.roxell@linaro.org>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240122-b4-kselftest-seccomp-benchmark-ktap-v3-0-785bff4c04fd@kernel.org>
 <20240122-b4-kselftest-seccomp-benchmark-ktap-v3-2-785bff4c04fd@kernel.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240122-b4-kselftest-seccomp-benchmark-ktap-v3-2-785bff4c04fd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/22/24 14:08, Mark Brown wrote:
> The seccomp benchmark test makes a number of checks on the performance it
> measures and logs them to the output but does so in a custom format which
> none of the automated test runners understand meaning that the chances that
> anyone is paying attention are slim. Let's additionally log each result in
> KTAP format so that automated systems parsing the test output will see each
> comparison as a test case. The original logs are left in place since they
> provide the actual numbers for analysis.
> 
> As part of this rework the flow for the main program so that when we skip
> tests we still log all the tests we skip, this is because the standard KTAP
> headers and footers include counts of the number of expected and run tests.
> 
> Tested-by: Anders Roxell <anders.roxell@linaro.org>
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---

> -	return 0;
> +	if (ret) {
> +		ksft_print_msg("Saw unexpected benchmark result. Try running again with more samples?\n");
> +	}
> +

WARNING: braces {} are not necessary for single statement blocks
> +	ksft_finished();
>   }
> 

Mark,

Can you fix this warning. Tried fixing it --fix-inplace and no luck.

thanks,
-- Shuah

