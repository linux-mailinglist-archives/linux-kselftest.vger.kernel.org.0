Return-Path: <linux-kselftest+bounces-23877-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B6C2EA00C1C
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Jan 2025 17:36:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F362160B26
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Jan 2025 16:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5CA11FAC23;
	Fri,  3 Jan 2025 16:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fi0u+Kdt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4407B59B71;
	Fri,  3 Jan 2025 16:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735922212; cv=none; b=TQPD+HULh8GcixKS6hWrztIM780reU1GODAjjb16dKM5yw26T2Y1uKUA886Ty+9OGpUt6rF4KiSZIAkVIKUretPtv3AD4pcJaK6c36GBw66GD1QFag1EdCQRdw5hLCcw4Acmc7zJo2P4z4MEzXB2Eo1oJ0BJUxu/lcYtt5L29m0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735922212; c=relaxed/simple;
	bh=xTzC7QG443/IqvY+HWK4H3OTW+C0tZXHKjpa3i02TQw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RPsc82cVWIQ8AZDBd7cWz+XEHWKRO5t7ZRB4HgRRKCFRsmJ9uu0jSIRI2+KhXK2Yw/P5oJaDOiw9F6iqRIBV1iFfUpQAkRdB9eK1UkOkXBevMtwLd1Bl+oBAWYNWfaB/0jyWDbdoAtDQnt0/cRH5xbR+jSwQSJKuoZ/BDzRHgM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fi0u+Kdt; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-21683192bf9so172840085ad.3;
        Fri, 03 Jan 2025 08:36:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735922210; x=1736527010; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VMl82Qe7iLhAKI1LGNVec2tfoUuAXVFX79xmKaJmlP0=;
        b=Fi0u+KdtP0uTANvIk4g8dY3wVacNaTbYh5dZleUdtELIBSXYiSESkZ0GWqvUtBwD+2
         poBE75It5lFN81gR5BmmmW/MwhdipVKC09stF0gq53xYO44o+rXQiwj6yrZA/i9hkEtB
         Y78XzlQ9le81RKG3NcLMGM1+Q6deC+az1KvMUs271xpVFfTjwM82I9Vt6bFdYsRRcQYp
         qJukAwloEUwGNzr02qEPTIjL+CmXFU+/IL7SDlWYuEwDA0hNKZ3rEpLzi+qw7vybeRY7
         SJ4ZOVfsSaaNxPMzwzRkaBUXhVSXyOR9mBi5UFhe9OQpBMbDYo4eQyoC5yc9yUrMLVYJ
         foHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735922210; x=1736527010;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VMl82Qe7iLhAKI1LGNVec2tfoUuAXVFX79xmKaJmlP0=;
        b=Y/XxsfOycTrujjeIr/KyrYT9yj/NNM/Mky6hatkyceaxsr0b0y1djG6ZUvDSzIdpCw
         Sffv1LMmmLhKOP/O06Ospry38hhqJ2VrSgGg3DZNUMRT0UYhwpy/5RvLWqbC7o/69gRG
         pl845lpKrxfELOWDP/9o0rwvY+LsH74cTaLdT5pCDsmvCueuAHouKsDc3DgLOe3PhV3n
         7zz97pk/FddJg2nl1kLdJ5CoZ5X/R9/2NAczyzcLF6I8TVfHc+rPx8GvWSIGhRkdYPZc
         GeNGWiFVN0bFYgBm4omtgNf1ef39Ddi3RVK1q9YaN+1AqBBjdFb9zH7ct5O7jLpGa3p4
         3mgQ==
X-Forwarded-Encrypted: i=1; AJvYcCU59qxJ5eNhuWbpkAQQ7Ihy8lxKjgHn+VUkQhKpHNqwKGgQC1Azzl2Fh7g43vRkoxhVWUOPOE4AaX1d2PM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyufuCdoL/4EPR7KUkVBUt/DJrPm0Dp7rz8eEDvOY2bwU48kpOZ
	MOvqpzd7sPepDvo69iN7muOwAIqHLHQgxmwkBnboGHOWtAaeYRCIqPZdFw==
X-Gm-Gg: ASbGncucoTuqZdPNnHcRpl352Ai1cwKq2cm0NHpyfu0a9l7eUApmArXv8vmGJEytvC+
	EfIGAKTqi7H9CVgByIa0F1HPgwk22XQHC90kGact+AuscD8WYkfqiyx9XAVfDA1NQfgOXGP9YP2
	YMGrDEUJR6QvGwt8cEuiNXXBYIVf0lbvBDk/nRZ9aMpD7u0H3HrBT0ovUStiWiri3gfb4GKBSgD
	W+2FdXOLFYSBk9BptMju+BRIx9ZtBHXrCd4gq7Oml53i8xOcQQM/bwmneiRVXGRQg==
X-Google-Smtp-Source: AGHT+IGFYUAYlTYgjcqixQnvTkViIo/2ZjXTU9NSNLaISPjDBbgAu48ItXyw5MkoIt8yxZrz6/oOvQ==
X-Received: by 2002:a05:6a20:d045:b0:1e1:9893:9a1a with SMTP id adf61e73a8af0-1e5e085855dmr88025964637.46.1735922210456;
        Fri, 03 Jan 2025 08:36:50 -0800 (PST)
Received: from [10.25.73.64] ([202.164.25.5])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-842e414d3c1sm20397355a12.81.2025.01.03.08.36.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jan 2025 08:36:50 -0800 (PST)
Message-ID: <a5bf80c4-0062-4f3d-94e2-a40c1cac2934@gmail.com>
Date: Fri, 3 Jan 2025 22:06:46 +0530
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/2] selftests: tmpfs: Add Test-skip if not run as root
To: Shuah Khan <skhan@linuxfoundation.org>, shuah@kernel.org
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250102100459.1291426-1-cvam0000@gmail.com>
 <20250102100459.1291426-2-cvam0000@gmail.com>
 <e6d8cb36-089b-41cc-8ab7-90338bcda8de@linuxfoundation.org>
Content-Language: en-US
From: Shivam Chaudhary <cvam0000@gmail.com>
In-Reply-To: <e6d8cb36-089b-41cc-8ab7-90338bcda8de@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 03/01/25 3:24 AM, Shuah Khan wrote:
> On 1/2/25 03:04, Shivam Chaudhary wrote:
>> Add 'ksft_exit_skip()', if  not run as root, with an appropriate
>> Warning.
>>
>> Add 'ksft_print_header()' and 'ksft_set_plan()' to structure test
>> outputs more effectively.
>>
>> Test logs:
>>
>> Before Change:
>> - Without root
>>   error: unshare, errno 1
>>
>> - With root
>>   No, output
>>
>> After change:
>>
>> - Without root
>> TAP version 13
>> 1..1
>> ok 2 # SKIP This test needs root to run!
>> Totals: pass:0 fail:0 xfail:0 xpass:0 skip:1 error:0
>>
>> - With root
>> TAP version 13
>> 1..1
>
> How are you running this test to see the before ad after
> results?

I'm doing the unit test, meaning, I'm building the test separatley and 
running it

to ensure the the code works as expected.

thanks

--Shivam


