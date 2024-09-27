Return-Path: <linux-kselftest+bounces-18511-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 949BC988B6D
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Sep 2024 22:46:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACA391C21120
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Sep 2024 20:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C95FB1C32EC;
	Fri, 27 Sep 2024 20:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Dp88WDvA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21CFE1C32E0
	for <linux-kselftest@vger.kernel.org>; Fri, 27 Sep 2024 20:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727469951; cv=none; b=BgmxYzL874xLZ5DnfMX3s6zn1QPibjceHehq7qix349lbw7G4L+W84Zx8Mk+9I/AJdfk5VijX1GCCiRP42H6bz7owYUtk7EykML0zRn/8K0b+RDguQWnFbf9CimoYNGRUmkrs6ovDmhW+lnDAJCYbKErgOwYNiE5ZBA3Zij9NoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727469951; c=relaxed/simple;
	bh=6Of1VxGdAUu5212I6xyD0qz6mSisX0o6Xz6i9ngeA6E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p4lO4AtcdxN+dcquHHFdLiotEs/xpAnehy3gwQI4m6Tb616AdbqELWcVIWejGIFrBrSwtpif2ajffpSWRdvdnZ/H9e8TK/FgJ1xMsuxFzQ1swc4oeo1qqlsA/K7r7siNZeGjLoyapUWTyzJup/O6HtddKg0v5GH1vsTGAKebWnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Dp88WDvA; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-82aa3f65864so112663239f.2
        for <linux-kselftest@vger.kernel.org>; Fri, 27 Sep 2024 13:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1727469949; x=1728074749; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ELeUhyHEhkX/mXAg1aV0b4XCeqINhoTNbiqlv9cXJu0=;
        b=Dp88WDvAg+uodPTF8RxbmEWY5PVWhc2ztmEvdLiYXxQT3v8Eps9Of3Jlf8Mr+7ITRA
         zyvzCRq9SgKd4Od4k4ds509MdH2tpIxDHrcowqZW9Ne4JLjXMYOSwStIgY+vqBTvKX9d
         q49nIqM3xrtvJxlKa53Fz3zWxXELVkb86Ob88=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727469949; x=1728074749;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ELeUhyHEhkX/mXAg1aV0b4XCeqINhoTNbiqlv9cXJu0=;
        b=uzqbdYVv7hY78sUjkzsscp63r21Hr+qtqGwEEunLXzrPPgflUBx5aBY/LoTnHLsQvI
         M0ABMPJOAiUBjTyXuVNEoRi9JTyoe5KY42ZGdMxy3Yqhb3dd8TYUuHqLfZ2c5S2/6TK8
         jt36LsyipLiF/oLPYy5vBOs/8OEMKpED7I5rdi0RM+zxMlkgXS/W9ALFrKdb72BUb2Ha
         3P5J+DpqU5NcNozCrbX/aRGhrzwWH/+A9ydRJ9TbNq/V0VuwATmTOGjLbEJvtVVR36JL
         b45PuN6UEjDjdJ3NW974l1T00Ay1ejkAgXq7D3Za+V3bHN6FuOrThB2PQPMRl9tQaCvm
         jhhA==
X-Forwarded-Encrypted: i=1; AJvYcCWNR2Bf08s1y03uvRaP4hi4cobUpD79ZuiBGhmIB6QIWkZWgABnKMFgFdTLZXfInTrqndiuypo8yVSYFq2XrMY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvXNtTjdKh4nzGsiDKxwQ2GpTiOqR4HKwa3SN83jepSYF0sl+e
	Oi1NR08rpHqyCheRPH78Byqjn5eo6ZoT+swH1fldipNoDfYeTXBbGfaNg1SGIVU=
X-Google-Smtp-Source: AGHT+IG8H8BaLurHSTTAfNxUSV4X7fVN3L5lrZqFFO8rs0RzP2N+Y+8YF1zbMMAzEzM94iNQwXnCAg==
X-Received: by 2002:a05:6e02:12ee:b0:3a3:445d:f711 with SMTP id e9e14a558f8ab-3a344fc8ff7mr59088925ab.0.1727469949083;
        Fri, 27 Sep 2024 13:45:49 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4d888849ca8sm694390173.41.2024.09.27.13.45.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Sep 2024 13:45:48 -0700 (PDT)
Message-ID: <6f5a5b5f-71a7-4ed3-8cb3-d930bbce599b@linuxfoundation.org>
Date: Fri, 27 Sep 2024 14:45:47 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 8/8] clk: Add KUnit tests for clks registered with
 struct clk_parent_data
To: Guenter Roeck <linux@roeck-us.net>, Stephen Boyd <sboyd@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>,
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
 patches@lists.linux.dev, kunit-dev@googlegroups.com,
 linux-kselftest@vger.kernel.org, devicetree@vger.kernel.org,
 Brendan Higgins <brendan.higgins@linux.dev>, David Gow
 <davidgow@google.com>, Rae Moar <rmoar@google.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>, Rob Herring <robh@kernel.org>,
 Saravana Kannan <saravanak@google.com>, Daniel Latypov
 <dlatypov@google.com>, Christian Marangi <ansuelsmth@gmail.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Maxime Ripard <maxime@cerno.tech>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240718210513.3801024-1-sboyd@kernel.org>
 <20240718210513.3801024-9-sboyd@kernel.org>
 <6cd337fb-38f0-41cb-b942-5844b84433db@roeck-us.net>
 <a339ec8c-38f6-425a-94d1-ad69b5ddbd88@roeck-us.net>
 <dcd8894f-1eb6-4b5c-9e6f-f6e584c601d2@roeck-us.net>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <dcd8894f-1eb6-4b5c-9e6f-f6e584c601d2@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/27/24 10:19, Guenter Roeck wrote:
> Copying devicetree maintainers.
> 
> On Thu, Sep 26, 2024 at 09:39:38PM -0700, Guenter Roeck wrote:
>> On Thu, Sep 26, 2024 at 09:14:11PM -0700, Guenter Roeck wrote:
>>> Hi Stephen,
>>>
>>> On Thu, Jul 18, 2024 at 02:05:07PM -0700, Stephen Boyd wrote:
>>>> Test that clks registered with 'struct clk_parent_data' work as
>>>> intended and can find their parents.
>>>>
>>>
>>> When testing this on arm64, I see the error below. The error is only
>>> seen if I boot through efi, i.e., with "-bios QEMU_EFI-aarch64.fd"
>>> qemu parameter.
>>>
>>> Any idea what might cause the problem ?
>>>
>> I noticed that the new overlay tests fail as well, also with "path '/' not
>> found".
>>
>> [Maybe] answering my own question: I think the problem may be that there
>> is no devicetree file and thus no devicetree root when booting through
>> efi (in other words, of_root is NULL). Would it make sense to skip the
>> tests in that case ?
>>
> 
> The problem is that of_root is not initialized in arm64 boots if ACPI
> is enabled.
> 
>  From arch/arm64/kernel/setup.c:setup_arch():
> 
> 	if (acpi_disabled)
> 		unflatten_device_tree();		// initializes of_root
> 
> ACPI is enabled if the system boots from EFI. This also affects
> CONFIG_OF_KUNIT_TEST, which explicitly checks if of_root exists and
> fails the test if it doesn't.
> 
> I think those tests need to add a check for this condition, or affected
> machines won't be able to run those unit tests. The obvious solution would
> be to check if of_root is set, but then the associated test case in
> CONFIG_OF_KUNIT_TEST would not make sense.
> 
> Any suggestions ?
> 

Would it work if these tests check if acpi_disabled and skip if it isn't
disabled? It might be low overhead condition to check from these tests.

acpi_disabled is exported:

arch/arm64/kernel/acpi.c:EXPORT_SYMBOL(acpi_disabled);
arch/loongarch/kernel/acpi.c:EXPORT_SYMBOL(acpi_disabled);
arch/riscv/kernel/acpi.c:EXPORT_SYMBOL(acpi_disabled);
arch/x86/kernel/acpi/boot.c:EXPORT_SYMBOL(acpi_disabled);

thanks,
-- Shuah


