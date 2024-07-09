Return-Path: <linux-kselftest+bounces-13414-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 990EB92C6B2
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Jul 2024 01:40:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAA661C220F2
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Jul 2024 23:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F061189F32;
	Tue,  9 Jul 2024 23:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DGa7kQWO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B29E1156C74
	for <linux-kselftest@vger.kernel.org>; Tue,  9 Jul 2024 23:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720568398; cv=none; b=MXJRVYxJeQMJD8KQ9X7eOm5eQkcYcNvO2VVgUdxLHEW4Eujv4M5PWa17a29CoMV2jTy9bCsugqe/W+UNFblWJ/dbKxQosSZzGjQp25P8v+9p74NeO3Lvh7xy1OvgdMY4XYLmqkmsCwQ9l9Elm9QTXqbWtZ7xx5x2JjXZxpGuTMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720568398; c=relaxed/simple;
	bh=xoYWGcz96RHvOP5RMCIKUt/z0q5VtjNbJQcwewVakP8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bMIM0DfyyyqZL/QowDG4qy40Cf5q0ImKZ07UFJ1DSxSufqHG/AE1nQAFMjEEeSGdPu8UTKIe+w+3dfz95/OVLrYF/ge5nGNRYHexzrZwSuVKwMZNx9jeaHBbAxcj4wzXXo4lZN07Lajs9OfoGFpceuBVmU3g8Pe8AQqeYgsEEYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DGa7kQWO; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-7f70a7470d3so12810739f.0
        for <linux-kselftest@vger.kernel.org>; Tue, 09 Jul 2024 16:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1720568396; x=1721173196; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7wZJcxOUMzqnMjEFIAKREA8lwePmg9X2G0N/hJmIdK4=;
        b=DGa7kQWO46elYeTVvToRXV1Fg/seMbDlLy2mC5XTyAgpiaY4RKlGxmzy3sO0VNGpr4
         9JmsoQKLIsZSRjsHpfBd6YdCSEBAkNpIcWayhcq/my7kq2kJ0Qb1UsUTzMhvQlSt5hqz
         SDTOiDxkfXRDdBBgxbcVF8EzLKh30Udo11Muo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720568396; x=1721173196;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7wZJcxOUMzqnMjEFIAKREA8lwePmg9X2G0N/hJmIdK4=;
        b=OkBD6A0rcG6kD00SMJm5U9kPnZFo7Pxm9ZQuJW07K10g4npb0/9dkHxbds2vh/vGWQ
         myJFNQDcEV5zUOAsfNMUaFNoHSzD41ej0NFhxU5esCOL15EGlu0VLNPOAj/4VpI/fZdA
         fnBfgIwRIkNMsHWu81OZOAzXcmG5R5B/ynhcIUqI5VvaL/GA1QXraprRFAjqrfvOqU10
         aVnUWmET919xA3zGcq6IOnpiCk/bRL5RuDve6/8jlXVZWBTbgCAlZqu92DVWTetUhfNT
         78ezyC4r4DE8kn9vXCB8KU0OST7xcqr1pn4b8S8se4aMplWALKWImdn/JH7UX07g0itc
         QuJw==
X-Forwarded-Encrypted: i=1; AJvYcCX9mTauD9r8/lIQv2WnddPCY/DkfDz1VnZZkeGUJHmitQ38nRFvV55oic5fuEy7WmOmGQniR29u8Dvde6+yWgzseS0p4sv6v3kqnHvp/5tS
X-Gm-Message-State: AOJu0Yy1uV+EOObkH7PDhcvvUqPVsqPYfxmWQtdsycwJtl5KYIATPqqW
	VePlZUUY++dUqejdK8wxiY4JMRJXvn8ov04f6+F4u83WrXBJzN8GKVu1UYoiPdc=
X-Google-Smtp-Source: AGHT+IEuCuhYJkAvAQQcqS5jynk6i+qDZXnB+nhM8B70PkkseKAaNX6qU33nF7oZrixRnw8aPfQ1ng==
X-Received: by 2002:a05:6602:160f:b0:7f9:444e:4918 with SMTP id ca18e2360f4ac-80003120d96mr488234339f.2.1720568395838;
        Tue, 09 Jul 2024 16:39:55 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4c0b1af8229sm767555173.7.2024.07.09.16.39.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jul 2024 16:39:55 -0700 (PDT)
Message-ID: <fb305513-580a-4bac-a078-fe0170a6ffa2@linuxfoundation.org>
Date: Tue, 9 Jul 2024 17:39:54 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] selftest: x86: conform tests to TAP format output
To: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org
Cc: kernel@collabora.com, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240414131807.2253344-1-usama.anjum@collabora.com>
 <dd277b6b-b28e-4860-b285-e89fd5fd3d41@collabora.com>
 <90dc0dfc-4c67-4ea1-b705-0585d6e2ec47@linuxfoundation.org>
 <386da8e3-1559-4ec2-9a66-f5f3f6405a2b@collabora.com>
 <23db41bb-1f3b-4b7b-95ac-960b8775a062@collabora.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <23db41bb-1f3b-4b7b-95ac-960b8775a062@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/2/24 04:17, Muhammad Usama Anjum wrote:
> On 6/10/24 10:19 AM, Muhammad Usama Anjum wrote:
>> Adding Borislav, Dave and x86 mailing list:
>> 	Please review the series.
> Kind reminder
> 

Usama,

As I mentioned another TAP conversion patch from you  patch if the
following command gives you TAP, there is  no need to convert.

make -C tools/testing/tmp2 run_tests
make kselftest TARGETS=tmp2

kselftest framework lib.mk and runtests wrappers take care for
TAP. The reason to take care of this at framework level is to
avoid changes to individual tests. The wrapper keys off of
KSFT_* codes returned from tests.

Please don't send TAP conversion patches like this one. The output
from the commands will have duplicate messages. The reason tests
return

make -C tools/testing/tmp2 run_tests
make kselftest TARGETS=tmp2

thanks,
-- Shuah

