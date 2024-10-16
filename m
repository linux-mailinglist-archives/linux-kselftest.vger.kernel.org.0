Return-Path: <linux-kselftest+bounces-19849-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A3A89A0DA6
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Oct 2024 17:08:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92F121C22BA0
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Oct 2024 15:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7800920E022;
	Wed, 16 Oct 2024 15:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hUrilThX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954C220C029
	for <linux-kselftest@vger.kernel.org>; Wed, 16 Oct 2024 15:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729091318; cv=none; b=oMhGpqOzn0FZhkfVqN7Zc9Jf6PUqRlAULnVOPDty8o4C5QHHSJpr4n+xI+5+qeFgbP0ZPf5vv4QG3gLj4uNI29HNi8WiHn+PMBAoYwySH4cfJO8s+QCFBGxVru02+ZK8JZc46kZDQHkKxnWJuBRMQsO62uGBQKODrxFByUXisEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729091318; c=relaxed/simple;
	bh=ugXK4yJBUN+Slya1taqj2nqhxByT0jN7tyoiZsSnCWE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jZUgnc7huaXtWGOQ8P3TtQYzJOa6oLmE2zzcMTFxwAQfYpBS2haJAQNbSrng8FkNGqJF0YadLwqpGhEB/qmsn1zMYaKQjEKBXpImWLjzAQs2uOpKlrGJy5nry3Unf0YW1eD+DAX0pcceCyDuLid/uEDvve+CMftdJv/so1zMhbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hUrilThX; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-83a9630eeb2so56815739f.1
        for <linux-kselftest@vger.kernel.org>; Wed, 16 Oct 2024 08:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1729091315; x=1729696115; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/4tgYDEMyWF70hV33bnhGys2n1KE306NIrsZuvfC/VQ=;
        b=hUrilThXxuOWoBixMthbICuRxoS56TeBu4FqBmF99oSckfwkJFZC7BQfh0c+zTqbZ3
         46nlNccaipFBTPKmWeZTh9jeBjfmqFAhC3COqXATgWwA38ug1HQBRuXRTCUMusK5r3mt
         usUjyzA8lRJJcpnFnoEszAx/CnkXP3WuW4NGU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729091315; x=1729696115;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/4tgYDEMyWF70hV33bnhGys2n1KE306NIrsZuvfC/VQ=;
        b=kt37fWaRnf7Cey7IudVLDJtUz/ayhvNDzJTZxQv3xGGbV6+uCvrgwIumr66k9iIMoJ
         1JtOOBteYysMyYw1V5kEtjvC0ywg+DolGAPIJuNv2Hd3HHUHdMND6sQse0WLdE4CwJBc
         5WLImeOsGQ3xuRA0TAiVbdPWTG/oqKbYyTxUNARasi1FsSfjGXWOu0U+riBS4l32qCbo
         bUL2SaoNR3g+DJXpt3fKTbbQjiYTJzAdpxP2BTVLmVVLWpC+jI6aJ8mKgrbre1pPoJK9
         HGtJQE1apKTkdY9P0Dhd0EWWGXULjAvl9CgtzFH6O5OGXsfVHqXrXQZs5nOJSdRGpylw
         MSuA==
X-Forwarded-Encrypted: i=1; AJvYcCWP9U65j/TaLBjBvbMA3evz5iH0F3nVuxhAdrik1CyydDOPzzFCOJC/Qcy98jSqzcBvcaFyJyvoyWD+0HokXS8=@vger.kernel.org
X-Gm-Message-State: AOJu0YysVQOQwoeblwCEvsZqi/rT+Uw4npWGEu+v1T+EZTowJi5MYsl1
	YYvBUA7iRWhCD681vmmRWI/JXiWD8YAR30u0m32BF1CEINOg1hS/4/7fzscbWtw=
X-Google-Smtp-Source: AGHT+IEZZ9R5D5k7TiW9DkRGpBKYTHVQXRVjQpBXUXlLF3pytP9NH7nG87Ar66Nko1Wgo1NMA7yySA==
X-Received: by 2002:a05:6602:164a:b0:82c:fdc2:e25a with SMTP id ca18e2360f4ac-83a64bfd806mr1687024939f.0.1729091314567;
        Wed, 16 Oct 2024 08:08:34 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-83a8b28c080sm81265639f.10.2024.10.16.08.08.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Oct 2024 08:08:34 -0700 (PDT)
Message-ID: <96ac2fd6-a885-4455-b0c9-91c514c8f3f5@linuxfoundation.org>
Date: Wed, 16 Oct 2024 09:08:33 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] selftest: hid: add the missing tests directory
To: Benjamin Tissoires <bentiss@kernel.org>, Yun Lu <luyun@kylinos.cn>
Cc: jikos@kernel.org, shuah@kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20241015091520.2431150-1-luyun@kylinos.cn>
 <4ioshjncgxafin7jcm7kne5fahp4l5nhk5664mnrdo7fgutgyn@jac5gopdyjty>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <4ioshjncgxafin7jcm7kne5fahp4l5nhk5664mnrdo7fgutgyn@jac5gopdyjty>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/16/24 02:27, Benjamin Tissoires wrote:
> On Oct 15 2024, Yun Lu wrote:
>> Commit 160c826b4dd0 ("selftest: hid: add missing run-hid-tools-tests.sh")
>> has added the run-hid-tools-tests.sh script for it to be installed, but
>> I forgot to add the tests directory together.
>>
>> If running the test case without the tests directory,  will results in
>> the following error message:
>>
>>      make -C tools/testing/selftests/ TARGETS=hid install \
>> 	    INSTALL_PATH=$KSFT_INSTALL_PATH
>>      cd $KSFT_INSTALL_PATH
>>      ./run_kselftest.sh -t hid:hid-core.sh
>>
>>    /usr/lib/python3.11/site-packages/_pytest/config/__init__.py:331: PluggyTeardownRaisedWarning: A plugin raised an exception during an old-style hookwrapper teardown.
>>    Plugin: helpconfig, Hook: pytest_cmdline_parse
>>    UsageError: usage: __main__.py [options] [file_or_dir] [file_or_dir] [...]
>>    __main__.py: error: unrecognized arguments: --udevd
>>      inifile: None
>>      rootdir: /root/linux/kselftest_install/hid
>>
>> In fact, the run-hid-tools-tests.sh script uses the scripts in the tests
>> directory to run tests. The tests directory also needs to be added to be
>> installed.
>>
>> v2: add the error message
>>
>> Fixes: ffb85d5c9e80 ("selftests: hid: import hid-tools hid-core tests")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Yun Lu <luyun@kylinos.cn>
> 
> Acked-by: Benjamin Tissoires <bentiss@kernel.org>
> 
> Shuah, I guess you'll want to take this one through your tree given that
> you already took the run-hid-tools-tests.sh one?
> 

Yes. I will take this one. Thanks.

thanks,
-- Shuah


