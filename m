Return-Path: <linux-kselftest+bounces-9134-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06AAE8B75CF
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Apr 2024 14:34:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B80E5284425
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Apr 2024 12:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A17F1171089;
	Tue, 30 Apr 2024 12:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="Bg/I1oz7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3AD617107D
	for <linux-kselftest@vger.kernel.org>; Tue, 30 Apr 2024 12:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714480431; cv=none; b=CspiOZUgTtMYwcl0XFep9zk0FBBNU0Ca/JxiCmbtAOGjuA1DGqVi3yy6UJyrR/u/Nh89r3Kna/Wejml89OACdAhesnIiHAfFEGEcX3zLZnLd8z6SYD3nYtRB6ivpBll/r7iJmuf2T2yuV6b82byU6UMnZE3W9xC3pTp8mgjVCqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714480431; c=relaxed/simple;
	bh=8qRGv9BUyqVd6XtlXFdWfT5zPzODEmCn5lc+lyDQMQk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jDvfOXB4FduKq0/iwT3ASqTn/fOO1cAmzESOPenOkWr3jR0Mvywlh4NpgIJjKQ1MiABc5/oribYHRH4wRME09gl0V6iRmeU4cnaLOCG45IX4SSwbkVGvkRR7HY/JVZUXYuB+YDBw9vnK5DNE8qC0kF+ot/SedrJZ56yq+VnnkbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=Bg/I1oz7; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5191b61cad3so1351696e87.2
        for <linux-kselftest@vger.kernel.org>; Tue, 30 Apr 2024 05:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1714480428; x=1715085228; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8JYnpful/x3DE6HE/Q8pSIRWAs5wjh2Z17X6El2O6XQ=;
        b=Bg/I1oz7Fb9DgA6vYFCZ/Y5HynGpEMOEpF5OzKXbUCynjMGP7QoDW3mpSl+/W3fH0V
         +al2uHC0RAAeo4MDgAjuPeEdsiBxvYu494vHrrL/nGpYJB5y28YRPWxvov6tCwYbOwAM
         /p4pwYuV2diJZ7QTBRVvfuzuyI/yjymKAELkrrKbDbh2l/O3vmxz2q0v1RnI3I5puG3G
         PQtwA2oznCVbXeUO4vxD7MDN1pLnp/O/2rF6rSk5mT+bmNgZTy3RrgjUVQYwkKnLsGN/
         8Q65S69a6A+lu5ZOP80/p9axP13UgzOR/8a3MJjERrXVWYLaASsDZdHx5SqZYrOnf150
         7L6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714480428; x=1715085228;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8JYnpful/x3DE6HE/Q8pSIRWAs5wjh2Z17X6El2O6XQ=;
        b=EOt2aLmxjCAaTiIzf265uD/r0LefhyMETR26pOYyBcVQOLflPQuPQU0jGgZYO/jy3R
         IuHkW0SMPOg2nhOMswBQK6yWBUX6lqWyLelfR4N1Y8typ/Fz52dh9imfKLzbCJCkwxiB
         Ih/TkN70soT1N399hE6cQ9IPzMgZX4RmbKw46g5tlMIaCoo+h1NFUP/ykDN/6FVA1fd4
         Wzvem+aLXoaRrKRK20j1jqIujRNLcWip03ir8XghGdCc9ziTIZJgpVG//jC2O39lEtEr
         VxWa8c9IpZin2eQBHhlkpIK4dknRgLRA+AjT0CE+pgnQvjpWrNFtHmBS+jN7cowRsglo
         0atw==
X-Forwarded-Encrypted: i=1; AJvYcCXmUcQEPaTm9xwzJFD68zSGg6hCEa9XyIt0kgmQCUQ8m0PoPWrL645erEcw5WknLxwUFymMIwX2iuncnkHRj6uQvgKFHsnIhhjnF6Mn7IQT
X-Gm-Message-State: AOJu0YwO2JFNAkrP2yewaybDbTeFQxZIyhIpCe4VdytBxVDO2vi66iec
	8dK1dmG7yYg6ZB6LPAOZmorXVjbBKRIQVjZiuPxQgwHS41flgxS5lUM1n2NJdSg=
X-Google-Smtp-Source: AGHT+IGh50yRx9fgD9SXLf1xEw2mn31RrUC8rB0v4vouvrUtYjpyhg94cyY1iBQpCTQRoHim5SrX3A==
X-Received: by 2002:a2e:910a:0:b0:2dd:60d3:7664 with SMTP id m10-20020a2e910a000000b002dd60d37664mr8644774ljg.5.1714480428077;
        Tue, 30 Apr 2024 05:33:48 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:999:a3a0:c21b:67fd:90ab:9053? ([2a01:e0a:999:a3a0:c21b:67fd:90ab:9053])
        by smtp.gmail.com with ESMTPSA id c1-20020a5d4141000000b003436cb45f7esm550771wrq.90.2024.04.30.05.33.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Apr 2024 05:33:47 -0700 (PDT)
Message-ID: <770710b3-2495-41a6-9822-d9af9b13cef5@rivosinc.com>
Date: Tue, 30 Apr 2024 14:33:46 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 02/11] riscv: add ISA extensions validation
To: Conor Dooley <conor.dooley@microchip.com>
Cc: Conor Dooley <conor@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Anup Patel <anup@brainfault.org>, Shuah Khan <shuah@kernel.org>,
 Atish Patra <atishp@atishpatra.org>, linux-doc@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, kvm@vger.kernel.org,
 kvm-riscv@lists.infradead.org, linux-kselftest@vger.kernel.org
References: <20240429150553.625165-1-cleger@rivosinc.com>
 <20240429150553.625165-3-cleger@rivosinc.com>
 <20240429-subtext-tabby-3a1532f058a5@spud>
 <5d5febd5-d113-4e8c-9535-9e75acf23398@rivosinc.com>
 <20240430-payable-famished-6711765d5ca4@wendy>
 <dbcf0be9-eae6-4776-bc5b-c6fad58df9c3@rivosinc.com>
 <20240430-gratuity-refinish-29abb136c958@wendy>
Content-Language: en-US
From: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
In-Reply-To: <20240430-gratuity-refinish-29abb136c958@wendy>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 30/04/2024 14:12, Conor Dooley wrote:
> On Tue, Apr 30, 2024 at 01:58:11PM +0200, Clément Léger wrote:
>> Yeah, see what you mean. I think we also need to define if we want to
>> expose all the ISA extensions in /proc/cpuinfo (ie no matter the config
>> of the kernel) or not. If so, additional validate() callback would make
>> sense. If we want to keep the full ISA string in /proc/info, then we
>> will need another way of doing so.
> 
> If extensions aren't usable, they shouldn't be in /proc/cpuinfo either
> as there's programs that parse that to figure out what they can use,
> possibly even only checking a single cpu and using that as gospel.
> That's why there's that per-hart-isa thing that was added by one of your
> colleagues last year.

Acked. So indeed, validate() callback for F/V dependent extensions makes
sense.

Clément


