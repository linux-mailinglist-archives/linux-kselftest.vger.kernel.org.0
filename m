Return-Path: <linux-kselftest+bounces-10316-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E1C08C7D9D
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 May 2024 22:14:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91993B215B5
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 May 2024 20:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75FCF157496;
	Thu, 16 May 2024 20:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DVk2DsXS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F5AB282E1;
	Thu, 16 May 2024 20:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715890468; cv=none; b=rtjg70cEHb1c60a0ix1WgKZo5Wfr74R6qRoEAxCeniT8Ev30fGOVkGCgidIkHLaIYRDMs178sm6W/8DUAwXMzkgERaKCoe9DBq4dRBgK8JeJslXNVeh24ShGqWWzaWoG+iStEANAJNcK37g8dqVA7WLKwyGolYM0dxIO0xyMwa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715890468; c=relaxed/simple;
	bh=OFe/ZL0e30eGPwsmxyP86C74EW1jVn+nxDNC1Ljp4uY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZqlLCUZXmsW0G8Z1J23pKnF6LBOtGifEl3EtNuAUCZb0FLKCXBZ8QjbOVclKGW5JPHC4RVY08RGrdOy9zgyEvf4EEbvsdSwqPQ/9MacDwWxX0tCOX84WPvTJQ85yExDHXQBDwfLKSeU1w3q/4a90KhUIqqp8j/Sm+quxf98t15A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DVk2DsXS; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2e2a216758bso2371751fa.3;
        Thu, 16 May 2024 13:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715890465; x=1716495265; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Vya+uy7v324SP8pO8WI3GxGb7Sg/yebLjN4lmzLeISg=;
        b=DVk2DsXShQdX56y8D4vCP3uaKTUX72sxNySKXCgvFZgSZNLl5hcVEmSKNds0Uz0b0O
         ezgBzopnXQYQLLGZ0A95T2X+wucL4piwaDRsY9/UoUezeoqZW/C/Qt/gPvQSblHWBzzG
         7haE0CSyynZxB+8hiQ76Ji+LLogUJmca3lSeFGl6kzE0RMNmDHHR1sute7RNR/tFakhX
         jbNoADGBJxQDpzcoxZozjTqd4xpXGPpvmXQUnBWFxtOoe0UXGEY3247zNA05J4FrX9T3
         w8QF5sSVGs8PmlEWq2a2PIaLIWK3jzCz7bejGwPtM2kEr/K/DdA7Sfv94FhGXC7WCsR0
         0ESA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715890465; x=1716495265;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vya+uy7v324SP8pO8WI3GxGb7Sg/yebLjN4lmzLeISg=;
        b=iKP4qKS9Kaj9t3h32hfaOq8iZ+nyC9nrIVSn+iU2AtxVT/ysrbTbMk1WS8ZrAjBl/t
         W12+7EtuCsQDEJ4YD1SzJaqPEeA8vZkvCL8b94FkkSTNPe1h+Dj45iWlazvdi05T7P99
         m3EgccawZpawGFwqifqQKi7Q3+Zaoklo6vW1RaVj31lQzte/jfkQKu54QnJMoM8vL6gP
         xbtc2W802qbYiRefDnb38zSsx2K3nfHDbTifOOqxY1+o4tpYPJip003QbnzCC82+PZm9
         b3awtBcwofKwT7602lXrM+glAc4piIgsa9mpo58hI8bDTKbM6vPtrG4mKRBo4BslHXBm
         PI/A==
X-Forwarded-Encrypted: i=1; AJvYcCWVTJeVDVUnUIUzwf1+unHlqloNvXbYZdCy5JqiXghQO9Wt6m7SG9oZt3Z10cpKl9qoznPnXp3LHbko49P4T83rmsB71+URL6gxDYbZFvBC4OQ/W7yayoj69C3ez3PWQVUZ+a3GkZUT0TQkqaA0
X-Gm-Message-State: AOJu0Yzx+1DF4X4MO8gfuFMmtkfedTYkZ93u54zivwjgLeHrcSoGkTYk
	cwe7oUyAqmFhuU1QAfSTPmdH9UB8N76rF1ZOLEcs/nGKzthY9uzd
X-Google-Smtp-Source: AGHT+IHCDJ8w1rrxe0y33ueWsUdSVYyrhSFHiZquYFjDCAjqBwW48xH9NBGraRbYoZby/QGgFefKJA==
X-Received: by 2002:a2e:9f4e:0:b0:2e5:6859:1902 with SMTP id 38308e7fff4ca-2e56859194bmr120879611fa.0.1715890464445;
        Thu, 16 May 2024 13:14:24 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:d20e:7300:e9c4:b0ae:5941:af8b? ([2a01:4b00:d20e:7300:e9c4:b0ae:5941:af8b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502b79bd5asm19924705f8f.18.2024.05.16.13.14.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 May 2024 13:14:23 -0700 (PDT)
Message-ID: <7a190f66-3d55-4fad-aaa9-854b586ed5aa@gmail.com>
Date: Thu, 16 May 2024 21:14:22 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] kunit: Cover 'assert.c' with tests
To: Rae Moar <rmoar@google.com>
Cc: brendan.higgins@linux.dev, davidgow@google.com,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 kunit-dev@googlegroups.com, skhan@linuxfoundation.org
References: <20240515142056.1374495-1-ivan.orlov0322@gmail.com>
 <CA+GJov4e8K2gWbQQA_vZvWs34OZJ7biMTkOnGAhfidG4V_dPJg@mail.gmail.com>
Content-Language: en-US
From: Ivan Orlov <ivan.orlov0322@gmail.com>
In-Reply-To: <CA+GJov4e8K2gWbQQA_vZvWs34OZJ7biMTkOnGAhfidG4V_dPJg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/16/24 19:57, Rae Moar wrote:
> On Wed, May 15, 2024 at 10:20 AM Ivan Orlov <ivan.orlov0322@gmail.com> wrote:
>>
>> There are multiple assertion formatting functions in the `assert.c`
>> file, which are not covered with tests yet. Implement the KUnit test
>> for these functions.
>>
>> The test consists of 11 test cases for the following functions:
>>
>> 1) 'is_literal'
>> 2) 'is_str_literal'
>> 3) 'kunit_assert_prologue', test case for multiple assert types
>> 4) 'kunit_assert_print_msg'
>> 5) 'kunit_unary_assert_format'
>> 6) 'kunit_ptr_not_err_assert_format'
>> 7) 'kunit_binary_assert_format'
>> 8) 'kunit_binary_ptr_assert_format'
>> 9) 'kunit_binary_str_assert_format'
>> 10) 'kunit_assert_hexdump'
>> 11) 'kunit_mem_assert_format'
>>
>> The test aims at maximizing the branch coverage for the assertion
>> formatting functions.
>>
>> As you can see, it covers some of the static helper functions as
>> well, so mark the static functions in `assert.c` as 'VISIBLE_IF_KUNIT'
>> and conditionally export them with EXPORT_SYMBOL_IF_KUNIT. Add the
>> corresponding definitions to `assert.h`.
>>
>> Build the assert test when CONFIG_KUNIT_TEST is enabled, similar to
>> how it is done for the string stream test.
>>
>> Signed-off-by: Ivan Orlov <ivan.orlov0322@gmail.com>
>> ---
>> V1 -> V2:
>> - Check the output from the string stream for containing the key parts
>> instead of comparing the results with expected strings char by char, as
>> it was suggested by Rae Moar <rmoar@google.com>. Define two macros to
>> make it possible (ASSERT_TEST_EXPECT_CONTAIN and
>> ASSERT_TEST_EXPECT_NCONTAIN).
>> - Mark the static functions in `assert.c` as VISIBLE_IF_KUNIT and export
>> them conditionally if kunit is enabled instead of including the
>> `assert_test.c` file in the end of `assert.c`. This way we will decouple
>> the test from the implementation (SUT).
>> - Update the kunit_assert_hexdump test: now it checks for presense of
>> the brackets '<>' around the non-matching bytes, instead of comparing
>> the kunit_assert_hexdump output char by char.
>> V2 -> V3:
>> - Make test case array and test suite definitions static
>> - Change the condition in `assert.h`: we should declare VISIBLE_IF_KUNIT
>> functions in the header file when CONFIG_KUNIT is enabled, not
>> CONFIG_KUNIT_TEST. Otherwise, if CONFIG_KUNIT_TEST is disabled,
>> VISIBLE_IF_KUNIT functions in the `assert.c` are not static, and
>> prototypes for them can't be found.
>> - Add MODULE_LICENSE and MODULE_DESCRIPTION macros
>> V3 -> V4:
>> - Compile the assertion test only when CONFIG_KUNIT_TEST is set to 'y',
>> as it is done for the string-stream test. It is necessary since
>> functions from the string-stream are not exported into the public
>> namespace, and therefore they are not accessible when linking and
>> loading the test module.
> 
> Hi Ivan!
> 
> This looks great! Just one last thing, since this test is no longer
> loadable as a module, could you remove the exporting of new symbols
> and adding of the module license. Those can be part of the next patch,
> where we convert these tests to modules.
> 
> Thanks!
> -Rae
> 

Hi Rae,

Ah, sorry, I completely forgot to remove the module-related part. Thank 
you for the review, and I'll try to be more attentive next time :)

-- 
Kind regards,
Ivan Orlov


