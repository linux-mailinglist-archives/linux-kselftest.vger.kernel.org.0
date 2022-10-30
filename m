Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6A706128F0
	for <lists+linux-kselftest@lfdr.de>; Sun, 30 Oct 2022 09:09:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbiJ3IJA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 30 Oct 2022 04:09:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbiJ3II7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 30 Oct 2022 04:08:59 -0400
Received: from mail1.bemta34.messagelabs.com (mail1.bemta34.messagelabs.com [195.245.231.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 100C62F3;
        Sun, 30 Oct 2022 01:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1667117333; i=@fujitsu.com;
        bh=GnBfYzGWA0vmnFd9Bc9cgXwV8mGrL8FERsoAAm7IpcQ=;
        h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
         In-Reply-To:Content-Type:Content-Transfer-Encoding;
        b=bMZxDkMXjh3u1cr3QYEGV4+s1yZjvuw5X1M1k4VmaSwxMltfdJmKPXZCVzeh8RqXm
         qKjhs98UclGdZ3+D3xPpQQTfzCsc1y6pT9wHr7CMCaYaCT+gHjurJ/jNIkcdbdZHh+
         a03CLf7MQ30EMrSZPCdO+CAWD4LN2urUhq7gb+6fY0/FIJQjakEjJcS1lPQa9HNPas
         kdqy8XIcCcTMb0YNNCfrnjA5l+4U7aJ0Nm9K2O6Qomkj/C55om4vCsHrLhd/AJgyj/
         EeM8UUjlBTih00o4vLyAAsggnMzw0my2cUcIk+DS2O/SX5ZtRfAkTHyTeuqSqKSvZy
         6ckz0T4lgjE5A==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupgleJIrShJLcpLzFFi42Kxs+HYrCtiGJd
  ssOukvsXrw58YLS7vmsNmMf3OezaLKS/XsTuweGxa1cnm8XmTXABTFGtmXlJ+RQJrxuq371gL
  DgpX9DccZ2xgnCnYxcjFISSwkVHi2JdlbBDOEiaJ6w2LWCGcbYwSO7efY+li5OTgFbCTWHJiJ
  huIzSKgKvF9+S5miLigxMmZT8BqRAUiJB4+mgRkc3AIC9hLdF70BAkzC4hL3HoynwnEZhPQkL
  jXcpMRxBYRCJA4fOs4I0SNksTJx5fYQVqFBEolGp5rgIQ5gaasXnKRBaLEQmLxm4PsELa8RPP
  W2WAXSAgoShzp/MsCYVdIzJrVxgRhq0lcPbeJeQKj8Cwkh85CctEsJGNnIRm7gJFlFaNZcWpR
  WWqRrqGpXlJRZnpGSW5iZo5eYpVuol5qqW55anGJrpFeYnmxXmpxsV5xZW5yTopeXmrJJkZgB
  KUUK1zawfhm2R+9Q4ySHExKorz5v2OThfiS8lMqMxKLM+KLSnNSiw8xynBwKEnwduvFJQsJFq
  Wmp1akZeYAoxkmLcHBoyTCW6kClOYtLkjMLc5Mh0idYlSUEuctMABKCIAkMkrz4NpgCeQSo6y
  UMC8jAwODEE9BalFuZgmq/CtGcQ5GJWHefSDbeTLzSuCmvwJazAS0OH1SFMjikkSElFQDU/L6
  sl1upofq9529+91FUEFo4m3NJe2PHlf+5uvLN73KI3LC9Gpe4aJ1Cb/+ZRyLmi2xanHXChftW
  WmfYucw7ji5++sN34L0W7/YQo8HXvG5eOwX/yIhvxx3V18fmRvTPr1f8raqzcli9pSX0S9Uj0
  3dyZ5UwJTyQ8V0mbGsMqPJxmkXmyZ7fLm5+pJ1wtyQYxUvS3jF5Dwf9jxtj1/KF99lb5BeVZ/
  haipjeH7WRvPUMu/fvn06j06JOC6YcDvnxKT4pDNbjp/5wr5/T+DUrSy1U9xuF884d2biy5qp
  a/Nfel2bJnLqdvsNA+EDf7JsP8/sMfm8rcnysuetwsNOm/f9eXE25Nqas8wLK5pX3byrxFKck
  WioxVxUnAgAYcZhFpsDAAA=
X-Env-Sender: lizhijian@fujitsu.com
X-Msg-Ref: server-7.tower-565.messagelabs.com!1667117332!337827!1
X-Originating-IP: [62.60.8.179]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.100.1; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 5176 invoked from network); 30 Oct 2022 08:08:52 -0000
Received: from unknown (HELO n03ukasimr04.n03.fujitsu.local) (62.60.8.179)
  by server-7.tower-565.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 30 Oct 2022 08:08:52 -0000
Received: from n03ukasimr04.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr04.n03.fujitsu.local (Postfix) with ESMTP id 7D0CF150;
        Sun, 30 Oct 2022 08:08:52 +0000 (GMT)
Received: from R01UKEXCASM126.r01.fujitsu.local (R01UKEXCASM126 [10.183.43.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr04.n03.fujitsu.local (Postfix) with ESMTPS id 702AA142;
        Sun, 30 Oct 2022 08:08:52 +0000 (GMT)
Received: from [10.167.226.45] (10.167.226.45) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Sun, 30 Oct 2022 08:08:50 +0000
Message-ID: <bedb0125-fb81-56c3-4495-cbb942dc31ca@fujitsu.com>
Date:   Sun, 30 Oct 2022 16:08:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2] selftests: pidfd: Fix compling warnings
Content-Language: en-US
From:   Li Zhijian <lizhijian@fujitsu.com>
To:     <brauner@kernel.org>, <shuah@kernel.org>,
        <linux-kselftest@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>
References: <1662002254-7-1-git-send-email-lizhijian@fujitsu.com>
 <9052fe6c-6a56-8662-2747-9387447d11fa@fujitsu.com>
In-Reply-To: <9052fe6c-6a56-8662-2747-9387447d11fa@fujitsu.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.167.226.45]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

ping again



On 29/09/2022 08:55, Li Zhijian wrote:
> ping
>
> On 01/09/2022 11:17, Li Zhijian wrote:
>> Fix warnings and enable Wall.
>>
>> pidfd_wait.c: In function ‘wait_nonblock’:
>> pidfd_wait.c:150:13: warning: unused variable ‘status’ [-Wunused-variable]
>>    150 |  int pidfd, status = 0;
>>        |             ^~~~~~
>> ...
>> pidfd_test.c: In function ‘child_poll_exec_test’:
>> pidfd_test.c:438:1: warning: no return statement in function returning non-void [-Wreturn-type]
>>    438 | }
>>        | ^
>>
>> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
>> v2: fix mistake assignment to pidfd
>> ---
>>   tools/testing/selftests/pidfd/Makefile     | 2 +-
>>   tools/testing/selftests/pidfd/pidfd_test.c | 2 ++
>>   tools/testing/selftests/pidfd/pidfd_wait.c | 2 +-
>>   3 files changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/tools/testing/selftests/pidfd/Makefile b/tools/testing/selftests/pidfd/Makefile
>> index f4a2f28f926b..778b6cdc8aed 100644
>> --- a/tools/testing/selftests/pidfd/Makefile
>> +++ b/tools/testing/selftests/pidfd/Makefile
>> @@ -1,5 +1,5 @@
>>   # SPDX-License-Identifier: GPL-2.0-only
>> -CFLAGS += -g -I../../../../usr/include/ -pthread
>> +CFLAGS += -g -I../../../../usr/include/ -pthread -Wall
>>     TEST_GEN_PROGS := pidfd_test pidfd_fdinfo_test pidfd_open_test \
>>       pidfd_poll_test pidfd_wait pidfd_getfd_test pidfd_setns_test
>> diff --git a/tools/testing/selftests/pidfd/pidfd_test.c b/tools/testing/selftests/pidfd/pidfd_test.c
>> index 9a2d64901d59..d36654265b7a 100644
>> --- a/tools/testing/selftests/pidfd/pidfd_test.c
>> +++ b/tools/testing/selftests/pidfd/pidfd_test.c
>> @@ -435,6 +435,8 @@ static int child_poll_exec_test(void *args)
>>        */
>>       while (1)
>>           sleep(1);
>> +
>> +    return 0;
>>   }
>>     static void test_pidfd_poll_exec(int use_waitpid)
>> diff --git a/tools/testing/selftests/pidfd/pidfd_wait.c b/tools/testing/selftests/pidfd/pidfd_wait.c
>> index c3e2a3041f55..0dcb8365ddc3 100644
>> --- a/tools/testing/selftests/pidfd/pidfd_wait.c
>> +++ b/tools/testing/selftests/pidfd/pidfd_wait.c
>> @@ -148,7 +148,7 @@ static int sys_waitid(int which, pid_t pid, siginfo_t *info, int options,
>>     TEST(wait_nonblock)
>>   {
>> -    int pidfd, status = 0;
>> +    int pidfd;
>>       unsigned int flags = 0;
>>       pid_t parent_tid = -1;
>>       struct clone_args args = {
>

