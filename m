Return-Path: <linux-kselftest+bounces-6897-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ED7F8924AB
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Mar 2024 20:55:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE62D1C2126A
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Mar 2024 19:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BF7E13A41A;
	Fri, 29 Mar 2024 19:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DxqF0inF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D00184AEDA
	for <linux-kselftest@vger.kernel.org>; Fri, 29 Mar 2024 19:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711742151; cv=none; b=OLE+EtZLkgeEWaiAA15WqbcsN16YLRtUVpqnaAE5bHPj6x7Wf+eSzW4xYJYf3MpVT4CBeSE6/WyTGtamhbMBKZK+JUG3xNLOn93qYFoi6vjA4KrmenLl7NVqi3Wg0f3ieEfnb+MSj1qppbW/ww5+Mfi07hav7WMSbHVAFO/Da+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711742151; c=relaxed/simple;
	bh=LkAx5cpqKJA/f7RawwxSb4SGqCnIjolDiMqhEFnnFAk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X9Fi0S3zCSjIugHf0y1wBqks3/riEDBoGvX8RtPEJMebU9iTVmwqOArKnxu7cnk3KYY/7b8uc5hfb+C/ZgDTRoA0GqwulwwMFH3OhU5sfKIj0iNQlcQ2AnzCF3ToYpzpbtN6ugsyE9pHVDGLICGiUdjpOCgjoLX7XVFHnTfbkWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DxqF0inF; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3685acaa878so3103885ab.1
        for <linux-kselftest@vger.kernel.org>; Fri, 29 Mar 2024 12:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1711742149; x=1712346949; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PschPcZk1PmI1OFMglYy1kMU6CIeKkX26n3x+fr0kKs=;
        b=DxqF0inFbwxFMkFSl/K4WTaVh4yy7eaErcEMg1bL2NDXM3A/f4Xl3XQqdvhQ1N9J/e
         z6mdMmqtZ8P3/bQp3QsA4Stv8n+SfzhzPnDusII68nir3eV7wvRvWbpSIGuvArI39OUf
         ufD5KVItRkHDMY3hY2I8I/hJmVU0mk7kWNU/o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711742149; x=1712346949;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PschPcZk1PmI1OFMglYy1kMU6CIeKkX26n3x+fr0kKs=;
        b=J0ereTQ40u8UlBkQiNqvz4H0w74O/TM2MrkCDuf6IgSRvu/Wg17C4YP2znlSg5DQYJ
         Uco5XKdLyVxpp2r62ZG/fZePPPnWMNzBLf3pOx1YXn8DkP7KXF9k/cvkVXBN0gwT2mAW
         z5hvNzY7JFFAEu7UKqDnfX530Lm4/rWQi5bCvMfjKu7fcYrb/lqYNdAAgbJwgK24CJvm
         4cCB8UyBc1yx0mKfWjKhglD/t6FU4woZ6f9GXIbkBzHjyiE8fBoA+pgwRGu2NpKiQkAh
         zdJRoKa/xYXV8cElh0sv85dIdxgv8sT7KbTU3cT9QM6ApvNkzpL9a7Sx1s0P7T6rjCaU
         Mftw==
X-Forwarded-Encrypted: i=1; AJvYcCVwMvwKV20daiqESSkaDW8A1W0GFk34fT8mtTXNhfJoe2Kdhuy4hdqGEJmxyjIK8dU6fhVbN0+Il6WSU17hCCUs3hfomv9p2vWWr7ccUR7D
X-Gm-Message-State: AOJu0Yz7bqsgS0RJ5EHGlBwfIcLu8QQO1lF2gs9V0nE1+tGEqDD/ZW+j
	Wupx0xn+2vqDTJNPfeF//yBhFZ01kqATVH4ZGkcmpCWiVfzZTQh2d+2eGWxPIuY=
X-Google-Smtp-Source: AGHT+IGRWxtPEMClc3GD1YuiNVAMyflNpK+NgYEs3OLFay8hBgdipqgLNnAM+SDhRKGAlp6PSPSKNw==
X-Received: by 2002:a5e:8a47:0:b0:7d0:a740:a9b8 with SMTP id o7-20020a5e8a47000000b007d0a740a9b8mr1156254iom.2.1711742148910;
        Fri, 29 Mar 2024 12:55:48 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id gs20-20020a0566382d9400b00476cca7d5b9sm1143917jab.166.2024.03.29.12.55.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Mar 2024 12:55:48 -0700 (PDT)
Message-ID: <1aba5312-6ff0-4497-b633-8d6edbef5c3b@linuxfoundation.org>
Date: Fri, 29 Mar 2024 13:55:47 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] kselftest/clone3: Make test names for set_tid test
 stable
To: Mark Brown <broonie@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>, Shuah Khan <shuah@kernel.org>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20240325-kselftest-clone3-set-tid-v3-1-6fdd91506e53@kernel.org>
 <0cee99af-f058-47a0-9119-94cc9a37e88b@linuxfoundation.org>
 <91f2e916-2f90-4970-9448-09f821597083@linuxfoundation.org>
 <ce20762a-9ab4-49d4-adc5-e8eb5e5ac848@sirena.org.uk>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <ce20762a-9ab4-49d4-adc5-e8eb5e5ac848@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/26/24 14:27, Mark Brown wrote:
> On Tue, Mar 26, 2024 at 02:20:08PM -0600, Shuah Khan wrote:
> 
>> I am seeing the following compile warnings. Please fix and send patch
>> on top pf linux-kselftest fixes.
> 
> Which toolchain and architecture are you using?  These compile cleanly
> for me.

This is what I have:
  
gcc version 13.2.0 (Ubuntu 13.2.0-4ubuntu3)

I am seeing warnings with this patch. No warnings without
the patch.

thanks,
-- Shuah

