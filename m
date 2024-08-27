Return-Path: <linux-kselftest+bounces-16387-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EE50960909
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 13:41:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71B9B1C22F14
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 11:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E50871A4F02;
	Tue, 27 Aug 2024 11:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FeV1T5uJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A1201A4B9F
	for <linux-kselftest@vger.kernel.org>; Tue, 27 Aug 2024 11:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724758706; cv=none; b=QpDqKlkUW4qZZK5TFWQF9OT3rh+UfciMcsF1hVAmNh5Oi0qFguvy0IimPj3Jz5HVZ5xU6sNh/96m/Sij4bbjOu3BSCgAZhW1gnuStPE29C3eLcA487Kw09ofsz8vHdglY5IXCOCzReLoesCGg6NOdvKzZe0/Mju7E2nwtIRVvtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724758706; c=relaxed/simple;
	bh=Npj44TBKlqnhu3zHMPy7+eqaEtI/Ba/zXO+RNqdGj8w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AEOImf6X3OJ3A7OewlF/WSoV4GKJrFU9SlCpSdYrvZDv9Mu0AdzgsTn6VzjA106Ts9ha/oMHfMBr/XOsu0lE1Fsg+JSirUjqWggahJtLC7LtmXAGMZPGtkWXrMndqs7IeU7InLxUSiPEzeyOh/2kjQorfyPyZsQxxYg6M6+X+K8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FeV1T5uJ; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-71423273c62so3864539b3a.0
        for <linux-kselftest@vger.kernel.org>; Tue, 27 Aug 2024 04:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1724758704; x=1725363504; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TAy/Xjv7dazCWNa6I0ehFJegEbGsU1jmIx9V0tPRpro=;
        b=FeV1T5uJRH48usV9BLsrMKoJ1ZY8OpbniAy/YZO2DutNzu7DxFPJtJVBYWrDIkCx2N
         a1aeJoQiWNUDPbPgewPenDFqp5N49LPr0TdXawkQfGro0QTgViv7RLFZ2M5C+WkMTqsU
         kbVyiAa6qRwels5Wi5NdvjNmrZBKYHeHnFGFY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724758704; x=1725363504;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TAy/Xjv7dazCWNa6I0ehFJegEbGsU1jmIx9V0tPRpro=;
        b=my2gt4CsBGpwp0qCY+SIA1aBnTo9fCuYZPDqrzaVOG7nuJOdztE9EAFdadf3zQGQ0W
         REWfWpEAtgQVSfForr+Pv/A+/yuOyQk82eleE6nIuhHJYuA/6J7LyArA0d+6WNaZXthm
         nYxN9rm/15k6xROnBn289hkad2FH8Pm22YHyAvRbHmsuz6Ko/cYGTQCQa/2nv10f59eZ
         I3zZRBAa6SG4UpPNwxmsfhMVOA+VC5Ve4+5RZTXkjm6fcNgayghTdzwACTdxtPwJSojY
         G7B5lmkFvLf622NRsMOZ/g8Ale8kJyjgOSBxZ6HKnfXBuZUPAN22H6nErlQnNzHeLH1n
         ehLA==
X-Forwarded-Encrypted: i=1; AJvYcCWV8yMcYdsVEVsvTbUnvKZ8wKdiYIjknGGLNqSOrTbTZ6hI/tSFaAXitjq1cSo+q0bQ6DrUqs22uPJKmqE6dk0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5EBmN6JTLOLfVtZjzkyxHXgmLmjg9lQQp2jGAWVaAftRHJuku
	Jc6KmnzxLjwZP5waKYhPsA8OkBc6O3Te4s6/todVxZLdzznWoPkYWTBmKmlKhG8=
X-Google-Smtp-Source: AGHT+IHgbs9Bq+GBA6SDyCLeBOxwxfa3Hl8DfIoeX8tN6KodOJhVa97KS7/E2OhmeptghNq1dqpSVQ==
X-Received: by 2002:a05:6a00:23c2:b0:70d:2583:7227 with SMTP id d2e1a72fcca58-71445cd599dmr11286300b3a.6.1724758704331;
        Tue, 27 Aug 2024 04:38:24 -0700 (PDT)
Received: from [192.168.121.153] ([218.49.71.194])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7cd9ac97fb5sm9115107a12.8.2024.08.27.04.38.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Aug 2024 04:38:23 -0700 (PDT)
Message-ID: <2b6112b1-ce10-4e14-87d4-04d64972be56@linuxfoundation.org>
Date: Tue, 27 Aug 2024 05:38:17 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/2] selftests: Rename sigaltstack to generic signal
To: Dev Jain <dev.jain@arm.com>, shuah@kernel.org, oleg@redhat.com
Cc: mingo@kernel.org, tglx@linutronix.de, mark.rutland@arm.com,
 ryan.roberts@arm.com, broonie@kernel.org, suzuki.poulose@arm.com,
 Anshuman.Khandual@arm.com, DeepakKumar.Mishra@arm.com,
 aneesh.kumar@kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20240821061523.2650568-1-dev.jain@arm.com>
 <20240821061523.2650568-2-dev.jain@arm.com>
 <1ac911c2-9d9c-4408-8697-1e90b3ae3e8d@linuxfoundation.org>
 <51617076-3aec-413d-bf42-cf1c359a0c38@arm.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <51617076-3aec-413d-bf42-cf1c359a0c38@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/22/24 05:10, Dev Jain wrote:
> 
> On 8/22/24 08:33, Shuah Khan wrote:
>> On 8/21/24 00:15, Dev Jain wrote:
>>> Rename sigaltstack to signal, and rename the existing test to
>>> sigaltstack.c.
>>
>> Can you elaborate on the benefits if renaming the test?
>>
>> Also you have such a good information in the cover-letter for this
>> patch - it would be good to include it in the change log for this
>> one or the new test.
> 
> Okay.
> 
> 
>>
>> The new test itself is good. I don't understand the value of renaming.
>> I can see the problems due to not being able to fix stables if the
>> existing test needs fixing. If there are good reasons for renaming,
>> I am all for it.
> 
> After looking into some git history, now I understand that "sas" actually
> has some meaning, although I still can't find its full-form :) I thought that
> sigaltstack would be a better name, but I guess sas is a subset of sigaltstack
> as part of SA_ONSTACK. So, let us drop the renaming of the test.
> 

I assume you will be sending a new v6 patch series without the renaming and just the
new test?

thanks,
-- Shuah


