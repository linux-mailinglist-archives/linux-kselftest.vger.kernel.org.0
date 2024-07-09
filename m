Return-Path: <linux-kselftest+bounces-13413-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8719792C6AE
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Jul 2024 01:39:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41D38282684
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Jul 2024 23:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE951189F38;
	Tue,  9 Jul 2024 23:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fKgsEQy6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B01189F25
	for <linux-kselftest@vger.kernel.org>; Tue,  9 Jul 2024 23:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720568358; cv=none; b=KQdFa4sZRVKsRK/KY6CCQ5KlLbvKJ8RuGzGR+/9T5y3YB8izfvbUTdOUE8hIrtDa+vtkEC7n/s8q8+Nyvpi7H4iPHmjg4j+wwTBXYc07oG563Y7CDu8gS+Mxm48vdrftzJgHCkjhsazC3YsHNgVJ144dn47484Mc8HqXbO0bOJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720568358; c=relaxed/simple;
	bh=v13RojyNkrmLvZIYKxPxcFW9s/xF3d+S1wjfUtD88wE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fo0HA/PAiQgEH4VwdxBYAhAkHY94gh7To7Lg9vFK/xUgzhlmh4ylP97m7nw50NAc5dGVjg291wRmFr1VUTgbvBl+0sUlPLKPpndJFm+7PgWvXxTqqroNWaROHaaxCeTYfC4knziden1tJh79+b/zrEmQIaeejooqP/I+SqkRxjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fKgsEQy6; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-8045e14c32bso1105939f.2
        for <linux-kselftest@vger.kernel.org>; Tue, 09 Jul 2024 16:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1720568356; x=1721173156; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pPHX4dzzyvza7GIEzAuMce3E3fWQvE/BuyWds2omlz4=;
        b=fKgsEQy6addE6NuVpK9jC/KWUpz1bv3HHHoi6wPgrAh5noEmOqYHSRbHgB2hP0osUV
         eLw8wsdkhJ39FA11t56KlLGlA2Tnn13mSFyoCv9icxdvGTpAOqa4e/g3g48d7UR39yR3
         9CnKVuuTxJ6faLmI8TFiTF2idrEex4wnhxSZw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720568356; x=1721173156;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pPHX4dzzyvza7GIEzAuMce3E3fWQvE/BuyWds2omlz4=;
        b=LmO5qC/6ZALuoaW77u410J82HbH+F6xnEYfZZREDV0CddqGvXUlNVBDjUOeY0IqSqq
         8zHj24ok7JO44I9g+OvQ/zr5IRvKLrLSE7nG8i2UA301ZK7/EnB+a3F8hlcozd2gI+KH
         G2J2567MJ+DaACc+31H18HgKyDppK2Jj1xA7+ED0AAPWM1OR9cfU9utAFI3onBDZPRQY
         rsoIncjvzlFKzZLbTnBwKSUJ42W/2NOOc66tS+4zjNc3P8471hbWY+dgSYNz1QUYfGiQ
         uOZEhaAwJ8JXOIGA6KOdv/Mo29Z71orBJiYjcHB1b5Rx4WTXu6+hdEdbfE7uzjnDerp9
         ipiw==
X-Forwarded-Encrypted: i=1; AJvYcCVLVni2iYmJZCNJz7QTZ5DqwTnX3qDAaqtfDBM+R+1VI7hR9PfFXUeVqNY69T49Hb2q+/6NiDSk6z3uYt1GDW+mppoCPfjz0ctZsIrTAOAf
X-Gm-Message-State: AOJu0Yz9DC/Z4QPA6Sx8+Ex7tsOAuzJ927oE4f4JQyDTIIFKsODHyv+x
	xfN5C4t1wecOzARXEclr4OP7EPsUrgSIcJo3eD1rdtPWlBujs04GhH92uyCaPRk=
X-Google-Smtp-Source: AGHT+IHs7kD0Ze1CquM53sNDxDzUw7iITKvUWidVMGeDcyaS52ylpyK3DsW4wJS9slXxuvJMLZNZyA==
X-Received: by 2002:a5e:c90a:0:b0:803:f97f:59e1 with SMTP id ca18e2360f4ac-803f97f5a96mr120011539f.0.1720568356523;
        Tue, 09 Jul 2024 16:39:16 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4c0b1c29d90sm765580173.163.2024.07.09.16.39.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jul 2024 16:39:15 -0700 (PDT)
Message-ID: <cac603cc-2fa1-42e1-afc5-c9d8ce789112@linuxfoundation.org>
Date: Tue, 9 Jul 2024 17:39:14 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] selftests/thermel/intel: conform the test to TAP
 output
To: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 srinivas pandruvada <srinivas.pandruvada@linux.intel.com>,
 "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
 Shuah Khan <shuah@kernel.org>
Cc: kernel@collabora.com, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20240702101259.1251377-1-usama.anjum@collabora.com>
 <20240702101259.1251377-2-usama.anjum@collabora.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240702101259.1251377-2-usama.anjum@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/2/24 04:12, Muhammad Usama Anjum wrote:
> Conform the layout, informational and status messages to TAP. No
> functional change is intended other than the layout of output messages.
> 
> The test has infinite loop to read the value of status_str. Break the
> loop after getting the value once and finish the test.
> 
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---
> Changes since v1:
> - Use ksft_exit_fail_perror if read() returns error
> - Break the infinite loop after printing status_str
> ---

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


