Return-Path: <linux-kselftest+bounces-13149-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BD0C6926C55
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Jul 2024 01:11:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38A461F20FDF
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Jul 2024 23:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C24C41849D7;
	Wed,  3 Jul 2024 23:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hqHMl/tq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF5E24964E
	for <linux-kselftest@vger.kernel.org>; Wed,  3 Jul 2024 23:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720048262; cv=none; b=BnWecBy3vWyU6kh1X/2hHr44xC6vuvKyIJomNfWLFyjGC3lGGYTAO+5MnjP9lc2xRyqiuRlVgH8Yxwq/dEl/SzovSlmNt635VTLPJxwkpJmBWprx475KMsuLO38R0K4BUs2qUsBy64ptrM5fvkwTGSfncI4l5sbdkE+BrstDgu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720048262; c=relaxed/simple;
	bh=r0uAG+k85KUhnmC0RU/sPMM+jlY/KvzKUPnko0MwoA4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wt/ytTcyjtbUPAL4ANZE7iNbblZgAFBgD0O2jzreNLADq7zutSVLLaS1N7tVnuQ78+7r0tHLTvGn953DKHfw4nUSV5/mwANiCyLKZ2t44+Xk+3u5g+IWsQM3AeO7u9QTRvK7716LFrc276pB8L8qpJnAVBA4f626TlKDAOG1Yzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hqHMl/tq; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-7f653005b54so163039f.1
        for <linux-kselftest@vger.kernel.org>; Wed, 03 Jul 2024 16:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1720048260; x=1720653060; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OMhBfo2AqOtt3z+XF5sqTNNiKJEZsUksgQMqNwJunyk=;
        b=hqHMl/tqGCSeepVnEPVjW4Topdg6qeJkbrXcLs5KHPtJJmf+RWvBH+b89Qw8Skorpf
         RoDlmU/QSzf6guikqhveHqwjjH8U3yDVsBZAprIYsdOP/wsWStwAKpkMm4CwBsXnSBty
         nZziRgAG5Wb6V4mPhU0O4g/O8J7+JgmUeqy3s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720048260; x=1720653060;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OMhBfo2AqOtt3z+XF5sqTNNiKJEZsUksgQMqNwJunyk=;
        b=J8vX/h7cOaNjzjG+LJ2NphStaq6znxQZsDwzvv85j4Y+7ULcGil7ktQSjMyojcNrYB
         EKVegwkZcD6FABD/SMrJi892kUxBfQu0wHDAfwA+3nalUAEj1tzR2J4iuPyue99TLi6D
         pIpiGMatLe9+uQLtfRSEYvMLWInDpBYkOQ6YYDGYHFpAxoLFwpx1ayHJcGOdEeiMDcF7
         EATXk65pgF4hNczTaa7Ym5NJ0AHOXo1E7hzBPIJOxeLJyMnq9VAoQ9iXx96HpPQPeAvk
         7H+5pWnmy7GYPZCO827TS/gC7p81FX8BP/DNVchaVoFOhx44dff1XrRGuyxd+llb8QL9
         pqPQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/Z/JdE8bN9s2FEv22PBcIil2sC0yzwA//7NB0PFnEXfVzfRy+CnAqzFlpmEs4f1HRCkzUPY59ZFCvf8Dgf/4jodgcZA6MhOto5khrnJP5
X-Gm-Message-State: AOJu0YxetnYqeiDL5jRNC7WNs6LYLp/WJwWBqfR/br9SEes3neRlERf/
	IIu1Ez8WoXl8ejypx+wG16KhnJDDVgQN6iyeB+xH0nTjhNOzHSdQRBM35Ilg5Fw=
X-Google-Smtp-Source: AGHT+IHcxNy4vvenn7jpiCsub8VWCATTgFQTQRQ7tQQa38oCzlQJbrAUv/99P7AbqgB/f4Iku057YA==
X-Received: by 2002:a6b:fe05:0:b0:7f3:ccee:7436 with SMTP id ca18e2360f4ac-7f66dee0b66mr12164939f.2.1720048260238;
        Wed, 03 Jul 2024 16:11:00 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4beeea701e4sm142588173.2.2024.07.03.16.10.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jul 2024 16:10:59 -0700 (PDT)
Message-ID: <6b2bca6d-61e8-40f6-b3b1-3a81dfb2b397@linuxfoundation.org>
Date: Wed, 3 Jul 2024 17:10:59 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] selftests/watchdog: limit ping loop and allow
 configuring the number of pings
To: Laura Nao <laura.nao@collabora.com>
Cc: kernel@collabora.com, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, shuah@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <818d06c2-c5d6-4559-a8c9-9bf9e21c30f6@linuxfoundation.org>
 <20240703144855.89747-1-laura.nao@collabora.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240703144855.89747-1-laura.nao@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/3/24 08:48, Laura Nao wrote:
> On 6/27/24 20:48, Shuah Khan wrote:
>> On 5/6/24 05:13, Laura Nao wrote:
>>> In order to run the watchdog selftest with the kselftest runner, the
>>> loop responsible for pinging the watchdog should be finite. This
>>> change limits the loop to 5 iterations by default and introduces a new
>>> '-c' option to adjust the number of pings as needed.
>>
>> This patch makes the test run finite in all cases changing the bevavior
>> to run it forever?
> 
> Correct.
> 
>>>
>>> Signed-off-by: Laura Nao <laura.nao@collabora.com>
>>> ---
>>>    tools/testing/selftests/watchdog/watchdog-test.c | 16 ++++++++++++++--
>>>    1 file changed, 14 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/tools/testing/selftests/watchdog/watchdog-test.c
>>> b/tools/testing/selftests/watchdog/watchdog-test.c
>>> index bc71cbca0dde..786cc5a26206 100644
>>> --- a/tools/testing/selftests/watchdog/watchdog-test.c
>>> +++ b/tools/testing/selftests/watchdog/watchdog-test.c
>>> @@ -24,16 +24,18 @@
>>>    #include <linux/watchdog.h>
>>>    #define DEFAULT_PING_RATE    1
>>> +#define DEFAULT_PING_COUNT    5
>>>    int fd;
>>>    const char v = 'V';
>>> -static const char sopts[] = "bdehp:st:Tn:NLf:i";
>>> +static const char sopts[] = "bdehp:c:st:Tn:NLf:i";
>>>    static const struct option lopts[] = {
>>>        {"bootstatus",          no_argument, NULL, 'b'},
>>>        {"disable",             no_argument, NULL, 'd'},
>>>        {"enable",              no_argument, NULL, 'e'},
>>>        {"help",                no_argument, NULL, 'h'},
>>>        {"pingrate",      required_argument, NULL, 'p'},
>>> +    {"pingcount",     required_argument, NULL, 'c'},
>>>        {"status",              no_argument, NULL, 's'},
>>>        {"timeout",       required_argument, NULL, 't'},
>>>        {"gettimeout",          no_argument, NULL, 'T'},
>>> @@ -90,6 +92,8 @@ static void usage(char *progname)
>>>        printf(" -h, --help\t\tPrint the help message\n");
>>>        printf(" -p, --pingrate=P\tSet ping rate to P seconds (default
>>> %d)\n",
>>>               DEFAULT_PING_RATE);
>>> +    printf(" -c, --pingcount=C\tSet number of pings to C (default
>>> %d)\n",
>>> +           DEFAULT_PING_COUNT);
>>>        printf(" -t, --timeout=T\tSet timeout to T seconds\n");
>>>        printf(" -T, --gettimeout\tGet the timeout\n");
>>>        printf(" -n, --pretimeout=T\tSet the pretimeout to T seconds\n");
>>> @@ -172,6 +176,7 @@ int main(int argc, char *argv[])
>>>    {
>>>        int flags;
>>>        unsigned int ping_rate = DEFAULT_PING_RATE;
>>> +    unsigned int ping_count = DEFAULT_PING_COUNT;
>>>        int ret;
>>>        int c;
>>>        int oneshot = 0;
>>> @@ -248,6 +253,12 @@ int main(int argc, char *argv[])
>>>                    ping_rate = DEFAULT_PING_RATE;
>>>                printf("Watchdog ping rate set to %u seconds.\n",
>>> ping_rate);
>>>                break;
>>> +        case 'c':
>>> +            ping_count = strtoul(optarg, NULL, 0);
>>> +            if (!ping_count)
>>> +                ping_count = DEFAULT_PING_COUNT;
>>> +            printf("Number of pings set to %u.\n", ping_count);
>>> +            break;
>>>            case 's':
>>>                flags = 0;
>>>                oneshot = 1;
>>> @@ -336,9 +347,10 @@ int main(int argc, char *argv[])
>>>        signal(SIGINT, term);
>>> -    while (1) {
>>> +    while (ping_count > 0) {
>>>            keep_alive();
>>>            sleep(ping_rate);
>>> +        ping_count--;
>>
>> So this test no longer runs forever?
>>
> 
> That's correct, with this patch applied the test no longer runs forever.
> I understand you prefer the current behavior - how about keeping the
> keep_alive() loop infinite by default and only making it finite when the
> -c argument is passed? Would that be reasonable?
> 

Yes. I am open to taking the patch if the default behavior doesn't change.

thanks,
-- Shuah


