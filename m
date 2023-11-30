Return-Path: <linux-kselftest+bounces-915-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7FE07FFD94
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Nov 2023 22:35:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1946281662
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Nov 2023 21:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A15D59151;
	Thu, 30 Nov 2023 21:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BbaHP0t6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CD681B4
	for <linux-kselftest@vger.kernel.org>; Thu, 30 Nov 2023 13:34:57 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id ca18e2360f4ac-7b05e65e784so7581639f.1
        for <linux-kselftest@vger.kernel.org>; Thu, 30 Nov 2023 13:34:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1701380097; x=1701984897; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qUf1IZM80yx5I/uYhbQ2wqUvHfjUSNuMsT/QakbGtJk=;
        b=BbaHP0t6Q0EnZEAP60r7SyEh/nB1VN1zWjzn4e8LNzABmWqjvg9VsJODEz+iPwV+rx
         X2kzlFiU+vZAawfy++qAFgfV0/x/NE5Y4Gyh59PWURmaYAvzFoZ5vbIROYh6yEObLx1k
         vK8bM0PsvAyLOrjroV44UE8sUUfLPV7ARnSgM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701380097; x=1701984897;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qUf1IZM80yx5I/uYhbQ2wqUvHfjUSNuMsT/QakbGtJk=;
        b=hL1CgNbJW1shAkd+ZcR24DuiKZd4z5NhVZqY3qp0seWNdquzL5D3U/KtJ/ofXIJjQH
         U6mN/ExBRHrTB+PEz9shEEHp/uPviNpN7EOIjhhfnLKwezJjyLm8NFTBB+0Le+HDdy/r
         GgNbDQpMfpgx9SR12HueWZyFeYhSvFH+npIB0odSOgHmZN3nPpc1zurT+j3MMyEU7O8F
         ozC0VIbOUjQPC33IyZa/yxJVxMr1mgIhY+cdybgoJECnM4sXKy7klAmcu49ifLxW7zm+
         ypB1CcUlZHkhILRM4uSfpJviYGvWxAfoAmX6iZFe9/NXby23we8yb365Iu5K8ZB1DFGL
         E25A==
X-Gm-Message-State: AOJu0YwNKHwWIu1FlQrQzmcUtN5nAQEez8TDhJKchWySrBk/AvkH5PuE
	8ih7u6X+pkMoGuxl49DS9ytxUg==
X-Google-Smtp-Source: AGHT+IF4F3xQmJZ6+UhUcyzvSzVJ0VgieGSd6DoK5uGwTAG7adkjYZew6KUU27lXIsxCnovm0RJJ1Q==
X-Received: by 2002:a92:ce8c:0:b0:35c:7b32:241f with SMTP id r12-20020a92ce8c000000b0035c7b32241fmr17946580ilo.2.1701380096997;
        Thu, 30 Nov 2023 13:34:56 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id i9-20020a056e020ec900b0035aeaed5112sm609123ilk.84.2023.11.30.13.34.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Nov 2023 13:34:56 -0800 (PST)
Message-ID: <57c7feb8-9529-460d-af4e-db4591177f9f@linuxfoundation.org>
Date: Thu, 30 Nov 2023 14:34:56 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/breakpoints: Fix format specifier in
 ksft_print_msg in step_after_suspend_test.c
Content-Language: en-US
To: angquan yu <angquan21@gmail.com>
Cc: shuah@kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-kernel-mentees@lists.linuxfoundation.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20231128214854.60362-1-angquan21@gmail.com>
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20231128214854.60362-1-angquan21@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/28/23 14:48, angquan yu wrote:
> From: angquan yu <angquan21@gmail.com>
> 
> In the function 'tools/testing/selftests/breakpoints/run_test' within
> step_after_suspend_test.c, the ksft_print_msg function call incorrectly
> used '$s' as a format specifier. This commit corrects this typo to use the
> proper '%s' format specifier, ensuring the error message from
> waitpid() is correctly displayed.
> 
> The issue manifested as a compilation warning (too many arguments
> for format [-Wformat-extra-args]), potentially obscuring actual
> runtime errors and complicating debugging processes.
> 
> This fix enhances the clarity of error messages during test failures
> and ensures compliance with standard C format string conventions.
> 
> Signed-off-by: angquan yu <angquan21@gmail.com>

Thank you for the fix. Applied to linux-kselftest next for Linux 6.8-rc1

thanks,
-- Shuah


