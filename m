Return-Path: <linux-kselftest+bounces-18238-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 581AA97EF06
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Sep 2024 18:16:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B359BB21E72
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Sep 2024 16:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8D8C19E985;
	Mon, 23 Sep 2024 16:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YMHhifpi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA02419ADBF
	for <linux-kselftest@vger.kernel.org>; Mon, 23 Sep 2024 16:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727108193; cv=none; b=F7Ug1mOJmtxeiDnUFyoaXpoezsI5jrBG7AmVZzGYHiXEGJyShTVgLRpqdbMu9hqJ8ZsWQv5JreIRxvCZLdxP464GUL6T3g7Ml+ZviewUpFPmbdE2FAau/50SX/HcUHQpxc+WlQ1YaJAPuqaqNXXuy1ToSspLqfN4B3egFN2/m84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727108193; c=relaxed/simple;
	bh=PaVCnBOKk2NESWPONQlxx6ZgFkfE6jLEf8fYtjJKjb8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=U33VluWl/4TCdmFx4ARlfTSwE5EGLiK6ZmgY0ujGF61rj56mn3rrJvP76Y66MIIVo2bpG50loUfTw0nOm7EWivQ8fqkb4WCGnr9VwXD+jq4f/NIz27eyyU8WyI6UUlYr+dxA4C02AhSj0S5OYkFmNtQZVNjc7Fjj586/N/kIifI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YMHhifpi; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-37636c3872bso13990565ab.3
        for <linux-kselftest@vger.kernel.org>; Mon, 23 Sep 2024 09:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1727108191; x=1727712991; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=P5jMyl1o/1TmcmM08X17fpAg4ADxzwYCfdFzHbbaa3w=;
        b=YMHhifpipIKLWvy/w02AZkCFkO32+0xzVUmxERUJt0kTVnVSwPnAAgKLlSI4E45bdu
         8d/jbtNRvc9QX15qgv3be3JdiYVz+Zxdc8YFqwAA1cuzvdYmyjro6HYHr0AqUJajMkUz
         tMLeLH2SmGLTCLGLDSnS5+73I1HK1pHL47oJs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727108191; x=1727712991;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P5jMyl1o/1TmcmM08X17fpAg4ADxzwYCfdFzHbbaa3w=;
        b=KYqh/V/XtxrKar+6vHIWvqs7L05h8GxBOrT41kkzQfW9LLbePcCtrccYE3UQb5pY1g
         p4P2Rst0WKH3RTscjSW2M5w/Fz5gVguH3Ct2rvWjaqZUGyEspplSzB+CBkFMUgo08iVF
         yfzmEih/AFUki66kASTUok4uZuHqDXAmpBMm8VOV+NJOIFDxiNW+10gJq1SfdlzX/11c
         0gjMlP2RSfut1zrX5t3qEZFHJOJ6IYGRhg9vsZHZtj/r5rh/MKkE9chQGQFkXzNX7eNg
         Nplnx4j41oJ7/Ud38RUDxj1S9dVdU4mwSC+QSyTkltTHEl+cWglRPfVqWZ2I5zKeUbiC
         o35A==
X-Forwarded-Encrypted: i=1; AJvYcCV1Fu8bPOyal3aKwofDEzxC8dpYKPfh9gWOO9L95aB0BlKVUrYUCUB0EthRiPoXbxfX7WtqLQUoDcl6uEqmIUo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yye7U4V5bvM4hjpjWQeRlRd+JsGcfqlU7AQCHd31xb0e5UGB5gU
	pzCfjJMnU+9j0JAJE8RRzgz/8NeuqRTVGfUPLliLs/t+OrglQgBF/i/GVkfSlpw=
X-Google-Smtp-Source: AGHT+IEavZikzUvEoQrnouuHC7VsGydWDHWwaU5JCQGMN+RAYA4mkhllBoYUAIZRqWeOopdM8/dwBQ==
X-Received: by 2002:a05:6e02:1a63:b0:3a0:9f85:d74e with SMTP id e9e14a558f8ab-3a0c8d0ba04mr100943395ab.16.1727108190886;
        Mon, 23 Sep 2024 09:16:30 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4d37ed1901dsm5162715173.115.2024.09.23.09.16.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Sep 2024 09:16:30 -0700 (PDT)
Message-ID: <9abe1f61-3379-44b5-8b8a-517c3df34daa@linuxfoundation.org>
Date: Mon, 23 Sep 2024 10:16:29 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] selftests: livepatch: test livepatching a kprobed
 function
To: Marcos Paulo de Souza <mpdesouza@suse.com>,
 Michael Vetter <mvetter@suse.com>, linux-kselftest@vger.kernel.org,
 live-patching@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240920115631.54142-1-mvetter@suse.com>
 <5e544e68ad83fcdeb3502f1273f18e3d33dc8804.camel@suse.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <5e544e68ad83fcdeb3502f1273f18e3d33dc8804.camel@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/23/24 08:45, Marcos Paulo de Souza wrote:
> On Fri, 2024-09-20 at 13:56 +0200, Michael Vetter wrote:
>> This patchset adds a test for livepatching a kprobed function.
>>
>> Thanks to Petr and Marcos for the reviews!
>>
>> V3:
>> Save and restore kprobe state also when test fails, by integrating it
>> into setup_config() and cleanup().
>> Rename SYSFS variables in a more logical way.
>> Sort test modules in alphabetical order.
>> Rename module description.
>>
>> V2:
>> Save and restore kprobe state.
>>
>> Michael Vetter (3):
>>    selftests: livepatch: rename KLP_SYSFS_DIR to SYSFS_KLP_DIR
>>    selftests: livepatch: save and restore kprobe state
>>    selftests: livepatch: test livepatching a kprobed function
>>
> 
> Thanks for the new version! LGTM, so the series is
> 
> Reviewed-by: Marcos Paulo de Souza <mpdesouza@suse.com>
> 
>>   tools/testing/selftests/livepatch/Makefile    |  3 +-
>>   .../testing/selftests/livepatch/functions.sh  | 13 +++-
>>   .../selftests/livepatch/test-kprobe.sh        | 62
>> +++++++++++++++++++
>>   .../selftests/livepatch/test_modules/Makefile |  3 +-
>>   .../livepatch/test_modules/test_klp_kprobe.c  | 38 ++++++++++++
>>   5 files changed, 114 insertions(+), 5 deletions(-)
>>   create mode 100755 tools/testing/selftests/livepatch/test-kprobe.sh
>>   create mode 100644
>> tools/testing/selftests/livepatch/test_modules/test_klp_kprobe.c
>>
> 

Assuming this is going through livepatch tree:

Acked-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah


