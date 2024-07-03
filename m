Return-Path: <linux-kselftest+bounces-13131-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9AC49263D4
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Jul 2024 16:51:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4BDBAB2ACFF
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Jul 2024 14:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB38117B41F;
	Wed,  3 Jul 2024 14:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Q48s6RI8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF3A175555;
	Wed,  3 Jul 2024 14:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720018105; cv=none; b=r5SEiSZ4kcRk2A240+9BrHGmQhdEVis8k/oltnCaBlUE9Mm4S0X6fE4QWuAUwxLyhIrGgId+sWq28aSn6uQJfZ1cWVSWaSpUMDdyjm421pWXjA++A9TN2hDK65Pv8hnMPZZfZEy4X/ZcO0YSYvnmVOYAe0VZO/p8Udp5+GCdHyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720018105; c=relaxed/simple;
	bh=sSmi/QQtkeOZdLU3gOEqDxI3RiWJeWbg7igI09J26/0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kKZ7hAP2BXhy+14H+9YgDTlROzufrE2/8A020dHo065KpnLGc4RJ9qiESlmX9q8eUhuWGjVPSIp5H7PXtrvCz0tMY9buCv6UAz/l/37BQaaRp6aM6lIHzntV2nNlt+iTQuWvrH3P1ibeS8tHpA8wKAnJp+aAatULYO245z586Jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Q48s6RI8; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1720018100;
	bh=sSmi/QQtkeOZdLU3gOEqDxI3RiWJeWbg7igI09J26/0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q48s6RI8N+y96cIfFNYxS73uByb5ja1AYUcBxfwXrTl72x1ycffDXcCJRlRxkTuza
	 RGxG1Xwfk5vxaWIXrxoL0uFoTT5ncoiLlY1wAVqnR1XpX9r7z3wBgrfgQUdpu4uasB
	 kPDqQmXdWlmZOZAWkI5fEbr9sS6no1VmkqMjMc36yOQh0Z9s9ulO8x5SaQ8eUCxzpT
	 /0h5ry0XTrIsTmMscyDSBJY3TGQl+jHD25ekM7wexHmsH1c8sVHGFZNF1l5s/YlNoS
	 DUAa/+9iKJhMRfin2E0ExNMXukgYW36DZXqutcZAcMmLNP76X9nMJ80XDveacWfUd/
	 xdHTANYUTItUQ==
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laura.nao)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id C698837821A0;
	Wed,  3 Jul 2024 14:48:19 +0000 (UTC)
From: Laura Nao <laura.nao@collabora.com>
To: skhan@linuxfoundation.org
Cc: kernel@collabora.com,
	laura.nao@collabora.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	shuah@kernel.org
Subject: Re: [PATCH 1/2] selftests/watchdog: limit ping loop and allow configuring the number of pings
Date: Wed,  3 Jul 2024 16:48:55 +0200
Message-Id: <20240703144855.89747-1-laura.nao@collabora.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <818d06c2-c5d6-4559-a8c9-9bf9e21c30f6@linuxfoundation.org>
References: <818d06c2-c5d6-4559-a8c9-9bf9e21c30f6@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On 6/27/24 20:48, Shuah Khan wrote:
> On 5/6/24 05:13, Laura Nao wrote:
>> In order to run the watchdog selftest with the kselftest runner, the
>> loop responsible for pinging the watchdog should be finite. This
>> change limits the loop to 5 iterations by default and introduces a new
>> '-c' option to adjust the number of pings as needed.
> 
> This patch makes the test run finite in all cases changing the bevavior
> to run it forever?

Correct.

>>
>> Signed-off-by: Laura Nao <laura.nao@collabora.com>
>> ---
>>   tools/testing/selftests/watchdog/watchdog-test.c | 16 ++++++++++++++--
>>   1 file changed, 14 insertions(+), 2 deletions(-)
>>
>> diff --git a/tools/testing/selftests/watchdog/watchdog-test.c 
>> b/tools/testing/selftests/watchdog/watchdog-test.c
>> index bc71cbca0dde..786cc5a26206 100644
>> --- a/tools/testing/selftests/watchdog/watchdog-test.c
>> +++ b/tools/testing/selftests/watchdog/watchdog-test.c
>> @@ -24,16 +24,18 @@
>>   #include <linux/watchdog.h>
>>   #define DEFAULT_PING_RATE    1
>> +#define DEFAULT_PING_COUNT    5
>>   int fd;
>>   const char v = 'V';
>> -static const char sopts[] = "bdehp:st:Tn:NLf:i";
>> +static const char sopts[] = "bdehp:c:st:Tn:NLf:i";
>>   static const struct option lopts[] = {
>>       {"bootstatus",          no_argument, NULL, 'b'},
>>       {"disable",             no_argument, NULL, 'd'},
>>       {"enable",              no_argument, NULL, 'e'},
>>       {"help",                no_argument, NULL, 'h'},
>>       {"pingrate",      required_argument, NULL, 'p'},
>> +    {"pingcount",     required_argument, NULL, 'c'},
>>       {"status",              no_argument, NULL, 's'},
>>       {"timeout",       required_argument, NULL, 't'},
>>       {"gettimeout",          no_argument, NULL, 'T'},
>> @@ -90,6 +92,8 @@ static void usage(char *progname)
>>       printf(" -h, --help\t\tPrint the help message\n");
>>       printf(" -p, --pingrate=P\tSet ping rate to P seconds (default 
>> %d)\n",
>>              DEFAULT_PING_RATE);
>> +    printf(" -c, --pingcount=C\tSet number of pings to C (default 
>> %d)\n",
>> +           DEFAULT_PING_COUNT);
>>       printf(" -t, --timeout=T\tSet timeout to T seconds\n");
>>       printf(" -T, --gettimeout\tGet the timeout\n");
>>       printf(" -n, --pretimeout=T\tSet the pretimeout to T seconds\n");
>> @@ -172,6 +176,7 @@ int main(int argc, char *argv[])
>>   {
>>       int flags;
>>       unsigned int ping_rate = DEFAULT_PING_RATE;
>> +    unsigned int ping_count = DEFAULT_PING_COUNT;
>>       int ret;
>>       int c;
>>       int oneshot = 0;
>> @@ -248,6 +253,12 @@ int main(int argc, char *argv[])
>>                   ping_rate = DEFAULT_PING_RATE;
>>               printf("Watchdog ping rate set to %u seconds.\n", 
>> ping_rate);
>>               break;
>> +        case 'c':
>> +            ping_count = strtoul(optarg, NULL, 0);
>> +            if (!ping_count)
>> +                ping_count = DEFAULT_PING_COUNT;
>> +            printf("Number of pings set to %u.\n", ping_count);
>> +            break;
>>           case 's':
>>               flags = 0;
>>               oneshot = 1;
>> @@ -336,9 +347,10 @@ int main(int argc, char *argv[])
>>       signal(SIGINT, term);
>> -    while (1) {
>> +    while (ping_count > 0) {
>>           keep_alive();
>>           sleep(ping_rate);
>> +        ping_count--;
> 
> So this test no longer runs forever?
>

That's correct, with this patch applied the test no longer runs forever. 
I understand you prefer the current behavior - how about keeping the
keep_alive() loop infinite by default and only making it finite when the 
-c argument is passed? Would that be reasonable?

Thanks for your feedback!

Laura

