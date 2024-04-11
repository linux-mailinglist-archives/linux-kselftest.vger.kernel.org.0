Return-Path: <linux-kselftest+bounces-7732-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 874D18A20B2
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Apr 2024 23:12:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6A05B21B26
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Apr 2024 21:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61BAA2DF84;
	Thu, 11 Apr 2024 21:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Z71l2dp4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A09E1E86C
	for <linux-kselftest@vger.kernel.org>; Thu, 11 Apr 2024 21:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712869928; cv=none; b=e2aWQYkPqiSVhCzgMFJfzGputkqYfyrCEEDFWhvcvIW9v6kP4PTCwBKheH1bpi9iSUuNVSc554vn6B1lpb0bhpy6McdHSl+M7p9vXUEexRu+YSiD0LC3OnOKPFIOOspnli/fJDXLh1y7rLSAZeOFMy4FCj/dJAHGwJYdlk2qb34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712869928; c=relaxed/simple;
	bh=oZ8v4ePupLUg5etGiqmx+FUpnfb/FSvL2oIBZ3dpBF4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XDFbm8gghN63VSmfYpeStsyVPB9KMcnhGFXacl6q9BYTaz9E1sthvP6bseeZOVyYveHv5zY9ib+ZdDipRSHR+xMshqK8TpegqPGpmaIXRjp+Xs8Bin2yxSTzwPYNVr8o/whbQAHx4hytYgRyhdTQn26JcDqICptqVsAnqAi0fmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Z71l2dp4; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-7d67d1073easo4906239f.0
        for <linux-kselftest@vger.kernel.org>; Thu, 11 Apr 2024 14:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1712869926; x=1713474726; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5pYTo5GXTImg/khPgJCEyjaHMOI7shV0+j3Qu01jLxQ=;
        b=Z71l2dp4zBg50YT78pSktQuj+BIpC7oQRpK4pXcc00gjGGLss4phYREA5p7h2g+Bkm
         yeeveCMZ94FT9oIQneSFjSnmjgUpRdHgv8aC+Mz0B0vnAkBY9oQlO+kwQ0aRr/sfwefV
         hbUtTAHNN8G8w2QeHmLIKL43X8xw2MJni4ZS0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712869926; x=1713474726;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5pYTo5GXTImg/khPgJCEyjaHMOI7shV0+j3Qu01jLxQ=;
        b=Dbc6gvX22EnXlsQqavK+7YIR8rLRzos2GHeiLuO59/5JhU6HQl0AjrJxDXrY09NsIN
         cYXjygowowfxxbvtp+anx97zDkuBliBQI/89E5FRWcbiWosj7/nzJ3NwBkjHqAapd34z
         eYJhF89zHh/6kHtNQhuru3VJQWIMMaS9QIvttFAZECNYpPSFKN3yZUWBvj5iwzAJGAxL
         zRlpOONO6KykI4mmZpP3or3GcG+8m5dkNTm3G4gjyrQJB8UqI2c0/jMAZyekOsO2jvt5
         qZbkjsJpzlkGGEh5oydgfxoTBGmqHIB4ad+5cnOL0z3qj4Cp2MRSLq9jYpR27g3I5XAD
         AKdQ==
X-Forwarded-Encrypted: i=1; AJvYcCXDNn0KGY6wTa0NyFYY9A92tFERPZhosA4LtVRfmI/tQU8rQSudsBMawCaGo5tld0n0j+PniZf78zgtmTtgKdkAqj0nvAajheNfmFoNdrn1
X-Gm-Message-State: AOJu0YyRFX5iATGjv6J4YN1ijDrfx7avGeEJ/JopHy7NQcvZ0MmT6Uur
	tc0aNu8ZGqB1K8f7AkBsa9abD5aZeYvl4qllECUQjXBnjaw4f/mbU3TPpDaXyQc=
X-Google-Smtp-Source: AGHT+IGlRvKJzo56yTLwyjOFSWmLeGDpwy6jNHfGtSQrurgovx+V4MNpJI/2H+yHyG38tJbXWUo9yw==
X-Received: by 2002:a6b:7b05:0:b0:7d6:60dc:bc8e with SMTP id l5-20020a6b7b05000000b007d660dcbc8emr1190271iop.1.1712869926226;
        Thu, 11 Apr 2024 14:12:06 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id bt3-20020a056638430300b0047ee01746f1sm615787jab.120.2024.04.11.14.12.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Apr 2024 14:12:05 -0700 (PDT)
Message-ID: <394f886d-ac00-4ad2-9bfa-b77db7bc5998@linuxfoundation.org>
Date: Thu, 11 Apr 2024 15:12:05 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] selftests: timers: Fix posix_timers ksft_print_msg
 warning
To: John Stultz <jstultz@google.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Shuah Khan <shuah@kernel.org>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Stephen Boyd <sboyd@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 Oleg Nesterov <oleg@redhat.com>, Andrew Morton <akpm@linux-foundation.org>,
 Edward Liaw <edliaw@google.com>, Carlos Llamas <cmllamas@google.com>,
 kernel-team@android.com, linux-kselftest@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240410232637.4135564-1-jstultz@google.com>
 <001f99f4-9463-451d-ac16-0cda91e37e67@linuxfoundation.org>
 <CANDhNCoXW2=1nGXYyck6e-CztCjDpC15_qwNk_+dOc8PvB-b4A@mail.gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <CANDhNCoXW2=1nGXYyck6e-CztCjDpC15_qwNk_+dOc8PvB-b4A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4/11/24 14:53, John Stultz wrote:
> On Thu, Apr 11, 2024 at 1:45 PM Shuah Khan <skhan@linuxfoundation.org> wrote:
>>
>> On 4/10/24 17:26, John Stultz wrote:
>>> After commit 6d029c25b71f ("selftests/timers/posix_timers:
>>
>> Tried to apply this for linux-kselftest next with Nathan's patch.
>> I can't find this commit in Linux 6.9-rc3? Is this is timers
>> tree?
> 
> Yes, it in tip/timers/urgent.
> 


Thank you. Assuming this is going through tip/timers/urgent

Acked-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah


