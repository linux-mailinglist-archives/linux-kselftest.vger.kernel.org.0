Return-Path: <linux-kselftest+bounces-23223-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3162C9ED8FB
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Dec 2024 22:49:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C2F01889FCE
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Dec 2024 21:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E8BF1D8A08;
	Wed, 11 Dec 2024 21:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W3D9Zf4p"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF37C259498;
	Wed, 11 Dec 2024 21:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733953551; cv=none; b=cDQA0CoG8wdKxzs0JYlF4rMV2h7lxOQdrGmD6ibkEEEbwY2ITDAEvVnSUNv9ClYo4xLeUwm567XOdWmAL+pmFJyS6tVyPAHtog6Cv7CblJYmxL5HY9/qj5inXS/dhGE4yXnnTDtOhaRQGU6huR8cbxx3lfbr71LhosOt55ReViI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733953551; c=relaxed/simple;
	bh=uZxErtAMqBRDn+WZll10y/bkFTDcTuIEHN0JHfb5GqI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y9ESx4Z5y/+AsX9CyARyS15FjWLMNf/OaA1NEZIuYRZyQvZlwSbR8rHKz+BawYrY68e4g9A793g7LrR77tCOic+6kqlz8shbnAMwXxdyA3zM/mRPCKb8H/D9hzEQODuNtVjbbcPjaWhkVsZd7ibGgrxyj/XFIHfr56tomDkG3tY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W3D9Zf4p; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-435f8f29f8aso14997635e9.2;
        Wed, 11 Dec 2024 13:45:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733953548; x=1734558348; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kKHGYhS/cBN9KevNGUo8edo38c3cn7FpEtFnnmWm5xE=;
        b=W3D9Zf4pRGkXziYgoVZJng90TrqmS2zBYiimMc6TQBMg2Y9Jep1NH5H87ZdoJ0M8oP
         uFn2/h+z6pxvyZjl4FtOUfzCPxrZIeT/B0om8OSfULWloBqDUZaHB9hESqf5euW/ARx1
         fmjmC1FR29OuQ0uVEF9dgr+IbRkgF7rvIPw6mSM32r0qRUQRtTels30rSsEyXS6jjC+d
         qZJ7EkjM76T5FmswUkXetdkn7Nu8+eH8iJNXru4OsDkxEq/Ge1eXPhIXqJmibjOR7/7Z
         askuRMnJk5H9OH/sW8bVKW58bVg8H8hbdU2+esTODohwhnPcbIRPU4IH11yhqojdhbvO
         Do3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733953548; x=1734558348;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kKHGYhS/cBN9KevNGUo8edo38c3cn7FpEtFnnmWm5xE=;
        b=t3K6nSk2nowfwftaAPYfOncqu1rkR8lnn15438HPqeXJzRq0hIq/s6APc009ezcekc
         4sViBdhxmJy4Y94hL6+wO9jX7huXiypIGWnvh27zlxpGD2YkP4WbQwXBSi90O9k2OuPz
         8NPkiAI34MndpMkfGUrkcMZlzaNKQkRhGUGimS4AovpR3Yzj42WX5Zu6kh1AFLfMSLF/
         EujMakUNauHBubSOsdo5pUVpAzIBUBVKE/rj9DZ8WGPlh8l/TT+tixkGJvCzGq6AvzAY
         C7afcogZA/HittvBOBbIGKLt0zQlPcfw7qtwnhOAfjL5Za7RwysmUQ7nk3VH1RCrk56s
         dhFA==
X-Forwarded-Encrypted: i=1; AJvYcCWpb00K3LXQxhsHhCeQfP69Y2Jgw2QDQizDrOdHbZJb/vw1jyTedNMnh3Ongwt7wsXG+9xI+gUF+wOZXJhz@vger.kernel.org, AJvYcCWvLA7KZ2A2kAZ0iuCls+SHXRYe8v5xhlB0+dSdEnBetoMIrz54FR1yNi/x1wy9UdJA7p0=@vger.kernel.org, AJvYcCXQNfq/DfPygTOx2Q7Ie74O4h7ek7MDU4g0Cxr7aXwFy1X5Zmkl+6wqSJkQrQ2wz7gFn3EWHfec9kuXa2IGKBb1@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/q9rU/74TaTMHOU1e/u+sVwOdUyGzA6uIgQE++O5yAU+KdbMz
	reUpy2ngA01GTZof1jR+vCXinqE9E/blOnIPheTvKF1+v/lWnVGE
X-Gm-Gg: ASbGncvqgXFiZ6hdmIyFKrpBMIm9EIbARjQ1w8UQx6D8mwICXHu2PYEWJ2N6YbV7dKT
	xKzjyJ8pduzdmG+LHSx+XiGO7/3V7HlDniK6eSNjefWcmKbGlheBFSPUgpNvDSJr/BM/PsTpS6Y
	ZPHT7Uz8z+Y/JR/nzp0D/3vA2jfEemch1l4pInsu/l+egJ4ZqPKP/pRC2SUwjJXXcMBFwmAc+Bp
	Bcg6xrozd2YTVluUSsYuXlInUOFgrdJdBON4RUUAKwgvtfIWzU96G5NOblgkzP3L+emWjZhdQOA
	XDCOIJC0IHdm5hfFESUX8BE=
X-Google-Smtp-Source: AGHT+IH6R1p/+7YyxKtU/3Pv+FwIn+it1MCc11BigiVlTByBTldrdq5Oc6JbbUCqjWW52cCOGaoVsA==
X-Received: by 2002:a5d:6daa:0:b0:385:f17b:de54 with SMTP id ffacd0b85a97d-3864ce894d5mr4038779f8f.5.1733953547810;
        Wed, 11 Dec 2024 13:45:47 -0800 (PST)
Received: from ?IPV6:2a02:8012:e013:0:1ab3:1f25:931:4d97? ([2a02:8012:e013:0:1ab3:1f25:931:4d97])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38782527520sm2145157f8f.109.2024.12.11.13.45.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Dec 2024 13:45:47 -0800 (PST)
Message-ID: <fba03de3-f44b-4a2d-a15a-4071c5b09427@gmail.com>
Date: Wed, 11 Dec 2024 21:45:44 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/6] Enhance event delivery error handling
To: Sean Christopherson <seanjc@google.com>, Ivan Orlov <iorlov@amazon.com>
Cc: bp@alien8.de, dave.hansen@linux.intel.com, mingo@redhat.com,
 pbonzini@redhat.com, shuah@kernel.org, tglx@linutronix.de, hpa@zytor.com,
 kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, x86@kernel.org, pdurrant@amazon.co.uk,
 dwmw@amazon.co.uk
References: <20241111102749.82761-1-iorlov@amazon.com>
 <Z1nX8aCfZMvJ4co4@google.com>
Content-Language: en-US
From: Ivan Orlov <ivan.orlov0322@gmail.com>
In-Reply-To: <Z1nX8aCfZMvJ4co4@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/11/24 18:20, Sean Christopherson wrote:
> On Mon, Nov 11, 2024, Ivan Orlov wrote:
>> Currently, the situation when guest accesses MMIO during vectoring is
>> handled differently on VMX and SVM: on VMX KVM returns internal error,
>> when SVM goes into infinite loop trying to deliver an event again and
>> again.
>>
>> This patch series eliminates this difference by returning a KVM internal
>> error when guest performs MMIO during vectoring for both VMX and SVM.
>>
>> Also, introduce a selftest test case which covers the error handling
>> mentioned above.
>>
>> V1 -> V2:
>> - Make commit messages more brief, avoid using pronouns
>> - Extract SVM error handling into a separate commit
>> - Introduce a new X86EMUL_ return type and detect the unhandleable
>> vectoring error in vendor-specific check_emulate_instruction instead of
>> handling it in the common MMU code (which is specific for cached MMIO)
>>
>> Ivan Orlov (6):
>>    KVM: x86: Add function for vectoring error generation
>>    KVM: x86: Add emulation status for vectoring during MMIO
>>    KVM: VMX: Handle vectoring error in check_emulate_instruction
>>    KVM: SVM: Handle MMIO during vectroing error
>>    selftests: KVM: extract lidt into helper function
>>    selftests: KVM: Add test case for MMIO during vectoring
> 
> Minor nits throughout, but unless you disagree with my suggestions, I'll fix them
> up when applying, i.e. no need to post a v3.
> 

Hi Sean,

Thanks a lot for the review :)

I don't have any conceptual disagreement with your suggestions, so 
please feel free to fix them when applying the patches. Thanks!

-- 
Kind regards,
Ivan Orlov

