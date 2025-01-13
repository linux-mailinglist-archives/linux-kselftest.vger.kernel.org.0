Return-Path: <linux-kselftest+bounces-24411-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D4978A0C4F7
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Jan 2025 23:58:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 599E57A042C
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Jan 2025 22:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C69161F9A9E;
	Mon, 13 Jan 2025 22:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eqiERcZ3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D5E21F9A8E
	for <linux-kselftest@vger.kernel.org>; Mon, 13 Jan 2025 22:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736809115; cv=none; b=oqv96dzieV7Hm6d6ghIdzEcPbXG8DvfrAig7H7xkRczdk1uUwAiQp1CXFe88QXk1IajQFf1rHdXy1hh3hGtaBBgW+wvDyW4840o47w2s9lv7OrytapDm7agOiwWUo9Ya1ELGdERrHD4Ul+47rLhJsxl2hC0/Kh6GzdA36zeZGVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736809115; c=relaxed/simple;
	bh=byHt66kkQFo3Oh8DOl5PbZj822vUim1Mk2jmFglzeXA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o2uiWwcFhM0sa3s/awPmayUOMlqz3K0t4DR7+j744AbgzPGFocoHhMlaVZGq5Wafhos5jEHoBAvuaq1N8uWP51k3+9ZfoaJSS2jRngg4NvNnqdea4dr5mjlouvNYsoEv14oOtDmU+NalNs3YH38GaO0bL0mpl4lnPTqIw48Yv1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eqiERcZ3; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3ce34c6872aso34186025ab.0
        for <linux-kselftest@vger.kernel.org>; Mon, 13 Jan 2025 14:58:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1736809113; x=1737413913; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q1ki8S/1pM9VyM2McX7OFVsdWhta3AZDu+5hXf8b6fI=;
        b=eqiERcZ3++0lW7L1yhUh/j/Se8uvx+dpclcGJu1bBeplsSYrcGo9V8Rxu12B2iRnJj
         8n7AkJDb51/a+23zcLKtFP574NvdKL7wNmmTiYjax6JuhqBrNx6gGl4FWSacyfU6Ysve
         X4YqlIM2KshWT3hWHEQxwi5khUY2csxMJfpQY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736809113; x=1737413913;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q1ki8S/1pM9VyM2McX7OFVsdWhta3AZDu+5hXf8b6fI=;
        b=C5o0+aaJZ+yVqTeK0F4f8CIssTucZzYEc5aQvd7jDzBQpL8wZrBhQZ5M97bpTocr6k
         W/m94UXFrNUqUXlGv26aM4CgRuZS/EnAYEUPEpCJLLhZhU8YOLqlemE63DIKOakbyaX8
         NmkD0Xc5Ta/c+j2Bo/JTpn5VgBFrE6haz+JH/Ifho1QvmQjXAb+gLJM8KFU3+I8bDL7l
         tq351fwBxh7WqUHgwCcCVXw0EhIOO80N3lIwLymhe1V9Iirdi7PULyyrxO1ELSsHXmfK
         T0MxC8r+te4ixBSNHYB2eBSKuJk0Cg557ZEWvpieufKFAQvwmWO2O1GnDOulTibTijba
         K1DA==
X-Forwarded-Encrypted: i=1; AJvYcCX4TrSMnZxl5CsZkIUVCZqrC0ar8INstwNEXev5MYu6/4+gygdEIHMb46p+ZXVkwie4MYCAfgQP1xKZv+52N8E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhM7veCZ9JiLyZCuhxMzh3H4O/w8gldxIMK1WlowPzxXRH3IPy
	400LxGLdFNKYajv847jLTCtfy4YBKJIkEV7gGy1r5XnzBdmhe3U0yndxl22NWow=
X-Gm-Gg: ASbGncsSzvDoLKlhENSUMVzigq9cAubrJ5tr8di2KRuPVXW4nJFsEkUxqBM91SvtZCN
	yublDoL8CNjeMaiH1V5yyD8uQJ5EFD9VbbpqoMEyioWt6UFdyWYJmjyocvaexS70XOI9PKx7rIQ
	zU8R6IeQt3Cwh9SPmcR9+J1VJ7mLSve7jOqJevegxiZCYMB5KWKCD+vASgCeSBZ8hb/rbIGRdFV
	XfZABOeE/aTghboHs110/nV0ga6TOcMwPUIKKuLkAgAMoVHKj5RNH7Z8hzen0FEudM=
X-Google-Smtp-Source: AGHT+IHFIlNITXIsqX92H+Yt3BQ7vnOktQvSWZgpdC9mZ+XQJnLQ2NuJeXo1enL5e8CWwvFiBVTHXg==
X-Received: by 2002:a05:6e02:1687:b0:3a6:ad61:7ff8 with SMTP id e9e14a558f8ab-3ce3a8883e1mr197964095ab.12.1736809113324;
        Mon, 13 Jan 2025 14:58:33 -0800 (PST)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3ce6c1fc60dsm12776665ab.7.2025.01.13.14.58.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jan 2025 14:58:32 -0800 (PST)
Message-ID: <668be2b3-4db1-45e9-bf2d-558c237db57f@linuxfoundation.org>
Date: Mon, 13 Jan 2025 15:58:31 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] rseq/selftests: Add support for OpenRISC
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Stafford Horne <shorne@gmail.com>, LKML <linux-kernel@vger.kernel.org>
Cc: Linux OpenRISC <linux-openrisc@vger.kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, "Paul E. McKenney"
 <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
 Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250110102248.3295944-1-shorne@gmail.com>
 <20250110102248.3295944-4-shorne@gmail.com>
 <cf78a480-e38f-496c-931c-cd889fb29d59@efficios.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <cf78a480-e38f-496c-931c-cd889fb29d59@efficios.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 1/10/25 09:16, Mathieu Desnoyers wrote:
> On 2025-01-10 05:22, Stafford Horne wrote:
>> Add support for OpenRISC in the rseq selftests.  OpenRISC is 32-bit
>> only.
>>
>> Tested this with:
>>
>>      Compiler:  gcc version 14.2.0 (GCC)
>>      Binutils:  GNU assembler version 2.43.1 (or1k-smh-linux-gnu) using BFD version (GNU Binutils) 2.43.1.20241207
>>      Linux:     Linux buildroot 6.13.0-rc2-00005-g1fa73dd6c2d3-dirty #213 SMP Sat Dec 28 22:18:39 GMT 2024 openrisc GNU/Linux
>>      Glibc:     2024-12-13 e4e49583d9 Stafford Horne   or1k: Update libm-test-ulps
>>
>> Signed-off-by: Stafford Horne <shorne@gmail.com>
> 
> Thanks!
> 
> Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> 

If these are going through risc repo

Acked-by: Shuah Khan <skhan@linuxfoundation.org>

If you would like me to take this, let me know.

thanks,
-- Shuah

