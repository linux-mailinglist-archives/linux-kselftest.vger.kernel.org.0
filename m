Return-Path: <linux-kselftest+bounces-26151-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BF33A2E5AA
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Feb 2025 08:43:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D61A67A420C
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Feb 2025 07:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 451601B85F8;
	Mon, 10 Feb 2025 07:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="hEHhEnub"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1181B425A
	for <linux-kselftest@vger.kernel.org>; Mon, 10 Feb 2025 07:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739173364; cv=none; b=IgdXO6izdUg4sonE+u86zPMMwQ5JofC69WqvHPIlKUi6sRuouW7KqL9Dzn+9/XzBMu3nbNH6QvPbs3zn6ymRUeOeIgDaSeSsu0FYiMJTXjTX+HBxJ489bKN25mtju2v9IES0Du0rkdRr+YcyaynFu3d8OOoFUisfgGmEaOg2iwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739173364; c=relaxed/simple;
	bh=uELykYu2UfnPFrcbXaL5ytU50E2XF8fxhOESv8wBqLc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qV76+Wz+tot/0uV8ME6haAO9KpzAHOvdmczCKqX45+JNQWZMteF3yt6Pvjnh7+DObk0rcJmEPAzMp0VlQub2bKd/eb0OZSWq4e5EXX0Oo2ICqgaPlrm1UW0pIkGhpNE+trxzNABLAH8q6oBoI/Rt7PUlba+IsVWbBAKbrAuz6fI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=hEHhEnub; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4393dc02b78so5024515e9.3
        for <linux-kselftest@vger.kernel.org>; Sun, 09 Feb 2025 23:42:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1739173360; x=1739778160; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Jki0b2am8yzlz3QyhCDEFnMh6r+K6Xff5FC3zmcGxIQ=;
        b=hEHhEnub9vJ60lxT2vbKKBzRLmTMTfzEohjaxyIuLzLiow2SvvpkSatF4AZQxAJjnt
         GldSg7omHp61iZ44O1NoCTj6O106Fa44wXsTEgwrO3V6PzE0XKFkh6b/1ZhCnDiUMPLD
         iwdjtrUpH14ypIzDoUIvMM99VMZk3yMbhrAuLsSxv/dZnbni6dapXkUUVW/cIaTFVxpU
         G5YOpqgvdH6tvuTG1XbLoQT9/+QjN8WaQ3SBagZb0OxHRyre8cxLMu7PshbV34ULqsvb
         gv/zLIyYV/g09f6i49Cxt3Z9AKBh7vYEdtAS2ASA6AqW2u06PJmqX7yjLhHIybimdYpn
         yLVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739173360; x=1739778160;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jki0b2am8yzlz3QyhCDEFnMh6r+K6Xff5FC3zmcGxIQ=;
        b=floLpYrV5dVYStSxrZd4r+22YfJBCs5qqrmuE6oBs7KXuXcqj0iHOfGNB03vvNkzfp
         8vKiHGeORcMnhOowdihxtyvnP6ug5WydVQZVIw/7gmT82EEddJapKuB11fwLcu2iZhqr
         5Oxf72PULZWkoCgKW8oKcQw8fsI8l/7RZQgmeXnk9jzeCXDPTQWVuxLF+0AVVos0GjEC
         /jyn9TpbSfhOshc1s8SmxXvFa8UhHTWeEDy70AuTRoQcbINZTkE1U73LQBd9xhdlfCbD
         /wxdbv6lQbyzo0l63EVpMnqjbGsY83UhnDRPUnhDr5JrCLHoSSRjIZuvvh6c44Gx4sO0
         b9zg==
X-Forwarded-Encrypted: i=1; AJvYcCVaifnxE1KbhQSH5YIkO4CNk4bofGRVxCb4Bd2W6sHoNJ/rKI6DewfPgnb5IMQIcysycPbX7rh9AK6Q0g+ijsA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8HkYLY7aPnrNUsGm+eifKmkDRt8VVu4NXhok26MOSzMZh6SFC
	fB+1Ok/TUhFtDrm2ZVMcVhyZf+aaj5ZVez5hl3byQKOq1OCqg2MiZF+cK36PUqQ=
X-Gm-Gg: ASbGncssQLVYDIxTxgtBDumCAzTfeeNFX1Q+ayM6S3xNtZ21sXdMXdyBCYPZDf4GqIA
	xiU8o/GBaSGNvURuvorzQuOKh2enbT7UWCOLMvChHlBlKtDxQHnntHF4sTm8uzFSlKvFgYx8INQ
	eVvYlZq+aAFmqchV3xrv8+JYv0yKKKvoY0EYhR4k2gwFH+9gbXOH1YE9Fmas4vkTIxUXAP23AGS
	JLMjkLBtX1qsINjrpwrwH1RD09aFSwid8W8y82Hij4XfhtAa2bNCBNe3Fg8hFyzTsxuhhTyy6iI
	rQjLpNPkyKnHx6DlJiBk/qEavV48JRmsRK6QxtZarmxgAQzEUE0BZ8K2xfTS
X-Google-Smtp-Source: AGHT+IF39BdEkA9ZgcBIHbLRArZRwyqYfhbYwkkcPtQvR89C0KQhk8Xnq25iZkfcHIflDsp+ppJQFw==
X-Received: by 2002:a5d:47ad:0:b0:38b:d7c3:3768 with SMTP id ffacd0b85a97d-38dc90fdb89mr7501603f8f.12.1739173359748;
        Sun, 09 Feb 2025 23:42:39 -0800 (PST)
Received: from ?IPV6:2a01:e0a:e17:9700:16d2:7456:6634:9626? ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4390d896d70sm171375435e9.0.2025.02.09.23.42.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Feb 2025 23:42:38 -0800 (PST)
Message-ID: <4320b0be-acce-43b2-b148-1577c6a56dff@rivosinc.com>
Date: Mon, 10 Feb 2025 08:42:34 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 14/26] riscv/traps: Introduce software check exception
To: Deepak Gupta <debug@rivosinc.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Christian Brauner <brauner@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Oleg Nesterov <oleg@redhat.com>,
 Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
 Jann Horn <jannh@google.com>, Conor Dooley <conor+dt@kernel.org>,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-riscv@lists.infradead.org,
 devicetree@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
 alistair.francis@wdc.com, richard.henderson@linaro.org, jim.shu@sifive.com,
 andybnac@gmail.com, kito.cheng@sifive.com, charlie@rivosinc.com,
 atishp@rivosinc.com, evan@rivosinc.com, alexghiti@rivosinc.com,
 samitolvanen@google.com, broonie@kernel.org, rick.p.edgecombe@intel.com
References: <20250204-v5_user_cfi_series-v9-0-b37a49c5205c@rivosinc.com>
 <20250204-v5_user_cfi_series-v9-14-b37a49c5205c@rivosinc.com>
 <fec3b7be-4259-4eef-87f9-b2cee5718cae@rivosinc.com>
 <Z6Z6mhiQ3DmsNZe9@debug.ba.rivosinc.com>
Content-Language: en-US
From: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
In-Reply-To: <Z6Z6mhiQ3DmsNZe9@debug.ba.rivosinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 07/02/2025 22:26, Deepak Gupta wrote:
> Hi Clement,
> 
> Thanks for looking at it. Inline
> On Thu, Feb 06, 2025 at 02:49:09PM +0100, Clément Léger wrote:
>>
>>
>> On 05/02/2025 02:22, Deepak Gupta wrote:
>>> zicfiss / zicfilp introduces a new exception to priv isa `software check
>>> exception` with cause code = 18. This patch implements software check
>>> exception.
>>
>> Hey Deepak,
>>
>> While not directly related to this patch, is the exception 18 delegation
>> documented in the SBI doc ? I mean, should we specify that it is always
>> delegated when implementing FWFT LANDING_PAD/SHADOW_STACK ?
> 
> I don't think it's document in SBI spec anywhere. Should it be ?

That's a good question ! I don't know the process to document that part
of the SBI but that would probably be nice to document it anyway I
guess. Atish may know what to do with that.

Clément

> 
> 
> In code, opensbi delegates the exception (SW_CHECK)
> https://github.com/riscv-software-src/opensbi/
> commit/110524441a827e026db3547ed03c5723b9c9e211
> 
>>
>> Thanks,
>>
>> Clément
>>
>>>


