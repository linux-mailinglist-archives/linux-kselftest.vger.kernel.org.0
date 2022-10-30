Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C50466128F3
	for <lists+linux-kselftest@lfdr.de>; Sun, 30 Oct 2022 09:10:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbiJ3IKB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 30 Oct 2022 04:10:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbiJ3IKA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 30 Oct 2022 04:10:00 -0400
Received: from mail3.bemta32.messagelabs.com (mail3.bemta32.messagelabs.com [195.245.230.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D05A6477;
        Sun, 30 Oct 2022 01:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1667117395; i=@fujitsu.com;
        bh=pYw7uqjyEvZaLsNuFiKYxapJZFv8SQRZj+Lqn+bU7gY=;
        h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
         In-Reply-To:Content-Type:Content-Transfer-Encoding;
        b=pouJlnki67wus/8JOla19P0yEUMLGyf3I5TxLiALmtjUI+/jziRHq5u+TKZ/DwqnF
         oX2ot1/0J/uVb8kXJ77hrkAgj9UUYjy0mBhNgf2x1Wy/dAdYiehpPSwe1ESa286i+C
         lGx2F03nuSWyualeMmc50XLXzeTLDQstaxotECsFvApsnZw9J1woXULuZkXMYr5JTV
         8R278om0YNc6OJosbyPYuinvFLW0fJ3eNg2M92Rg6iikgAcAOKtt2r4qYnsWbbprRD
         gtTwqlBgv/Z927difv8cHH1e7y1zH385NVi7Uw0gfuY9UHvMRe11epnoGsDU8T2cHu
         DN30EBxXpi6Cg==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPKsWRWlGSWpSXmKPExsViZ8OxWTfIMC7
  ZYNcPFovXhz8xWlzeNYfNYvqd92wWlw5dZLKY8nIduwOrx+I9L5k8Nq3qZPP4vEkugDmKNTMv
  Kb8igTVjw75JjAUXpSra951ibGDsE+9i5OIQEtjIKDFx6h4WCGcJk8TD/5+hnG2MEivObmPtY
  uTk4BWwk9i77zg7iM0ioCqx8VsfE0RcUOLkzCcsILaoQITEw0eTgGwODmGBcIkpS9RBwswC4h
  K3nswHK2cT0JC413KTEcQWEQiQOHzrOCNEjbPEyzcb2UBsIYFSiVdz5oPZnAL2Eo1TJrNB1Fh
  ILH5zkB3Clpdo3jqbGcSWEFCUONL5lwXCrpCYNauNCcJWk7h6bhPzBEbhWUgunYXkpFlIxs5C
  MnYBI8sqRrPi1KKy1CJdQ1O9pKLM9IyS3MTMHL3EKt1EvdRS3fLU4hJdQ73E8mK91OJiveLK3
  OScFL281JJNjMC4SilmL97B+GDZH71DjJIcTEqivPm/Y5OF+JLyUyozEosz4otKc1KLDzHKcH
  AoSfB268UlCwkWpaanVqRl5gBjHCYtwcGjJMJbqQKU5i0uSMwtzkyHSJ1i1OU4uGv/XmYhlrz
  8vFQpcd4CA6AiAZCijNI8uBGwdHOJUVZKmJeRgYFBiKcgtSg3swRV/hWjOAejkjDvPpBLeDLz
  SuA2vQI6ggnoiPRJUSBHlCQipKQamLRv/klQ7+nWuXzg3YXyqzcbXtWeVgrsvFV258CK3T5Hr
  DK+R+/Oyb+y6tG3h0rhXRU1PYzNx2taLooHmN/5fTlAZMFdt80TnnSVigt4S31oVYqMnLl/0r
  K0yTG398pv45nqZNO18MXE3bfqJYJanB92ezzzZ9p07dL1PVo16UnqpZa+9Q7zYjRsPkTu4LT
  v3nFGNiWiZ3HupFm3brQK/WHriDnC/bjB6NNLrm15pyVUvwW/8WbM3GGabSz5gnO1d/Uq99Np
  5xR0TDMfmyTIXnf6WSPFterlOs658qVXMrjMV9oGqes8KZhWJ6XJo/LbVD1y345lHNLfW1sT0
  xedmVV+KGT6nrCcZYu7C3avVWIpzkg01GIuKk4EAKbQypyyAwAA
X-Env-Sender: lizhijian@fujitsu.com
X-Msg-Ref: server-6.tower-585.messagelabs.com!1667117393!224574!1
X-Originating-IP: [62.60.8.179]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.100.1; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 2117 invoked from network); 30 Oct 2022 08:09:54 -0000
Received: from unknown (HELO n03ukasimr04.n03.fujitsu.local) (62.60.8.179)
  by server-6.tower-585.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 30 Oct 2022 08:09:54 -0000
Received: from n03ukasimr04.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr04.n03.fujitsu.local (Postfix) with ESMTP id AB69B151;
        Sun, 30 Oct 2022 08:09:53 +0000 (GMT)
Received: from R01UKEXCASM126.r01.fujitsu.local (R01UKEXCASM126 [10.183.43.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr04.n03.fujitsu.local (Postfix) with ESMTPS id 9E9AD142;
        Sun, 30 Oct 2022 08:09:53 +0000 (GMT)
Received: from [10.167.226.45] (10.167.226.45) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Sun, 30 Oct 2022 08:09:50 +0000
Message-ID: <b081620b-5a42-82c2-ceba-dcb077e8bd39@fujitsu.com>
Date:   Sun, 30 Oct 2022 16:09:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3] ksefltests: pidfd: Fix wait_states: Test terminated by
 timeout
Content-Language: en-US
From:   Li Zhijian <lizhijian@fujitsu.com>
To:     <brauner@kernel.org>, <shuah@kernel.org>,
        <linux-kselftest@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, Philip Li <philip.li@intel.com>
References: <1662001807-7-1-git-send-email-lizhijian@fujitsu.com>
 <8b921394-e7c4-2c85-da76-0ebd05e6ef07@fujitsu.com>
In-Reply-To: <8b921394-e7c4-2c85-da76-0ebd05e6ef07@fujitsu.com>
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


On 29/09/2022 08:56, Li Zhijian wrote:
> ping
>
>
> On 01/09/2022 11:10, Li Zhijian wrote:
>> 0Day/LKP observed that the kselftest blocks forever since one of the
>> pidfd_wait doesn't terminate in 1 of 30 runs. After digging into
>> the source, we found that it blocks at:
>> ASSERT_EQ(sys_waitid(P_PIDFD, pidfd, &info, WCONTINUED, NULL), 0);
>>
>> wait_states has below testing flow:
>>    CHILD                 PARENT
>>    ---------------+--------------
>> 1 STOP itself
>> 2                   WAIT for CHILD STOPPED
>> 3                   SIGNAL CHILD to CONT
>> 4 CONT
>> 5 STOP itself
>> 5'                  WAIT for CHILD CONT
>> 6                   WAIT for CHILD STOPPED
>>
>> The problem is that the kernel cannot ensure the order of 5 and 5', once
>> 5 goes first, the test will fail.
>>
>> we can reproduce it by:
>> $ while true; do make run_tests -C pidfd; done
>>
>> Introduce a blocking read in child process to make sure the parent can
>> check its WCONTINUED.
>>
>> CC: Philip Li <philip.li@intel.com>
>> Reported-by: kernel test robot <lkp@intel.com>
>> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
>> Reviewed-by: Christian Brauner (Microsoft) <brauner@kernel.org>
>> ---
>> I have almost forgotten this patch since the former version post over 6 months
>> ago. This time I just do a rebase and update the comments.
>> V3: fixes description and add review tag
>> V2: rewrite with pipe to avoid usleep
>> ---
>>   tools/testing/selftests/pidfd/pidfd_wait.c | 10 ++++++++++
>>   1 file changed, 10 insertions(+)
>>
>> diff --git a/tools/testing/selftests/pidfd/pidfd_wait.c b/tools/testing/selftests/pidfd/pidfd_wait.c
>> index 070c1c876df1..c3e2a3041f55 100644
>> --- a/tools/testing/selftests/pidfd/pidfd_wait.c
>> +++ b/tools/testing/selftests/pidfd/pidfd_wait.c
>> @@ -95,20 +95,28 @@ static int sys_waitid(int which, pid_t pid, siginfo_t *info, int options,
>>           .flags = CLONE_PIDFD | CLONE_PARENT_SETTID,
>>           .exit_signal = SIGCHLD,
>>       };
>> +    int pfd[2];
>>       pid_t pid;
>>       siginfo_t info = {
>>           .si_signo = 0,
>>       };
>>   +    ASSERT_EQ(pipe(pfd), 0);
>>       pid = sys_clone3(&args);
>>       ASSERT_GE(pid, 0);
>>         if (pid == 0) {
>> +        char buf[2];
>> +
>> +        close(pfd[1]);
>>           kill(getpid(), SIGSTOP);
>> +        ASSERT_EQ(read(pfd[0], buf, 1), 1);
>> +        close(pfd[0]);
>>           kill(getpid(), SIGSTOP);
>>           exit(EXIT_SUCCESS);
>>       }
>>   +    close(pfd[0]);
>>       ASSERT_EQ(sys_waitid(P_PIDFD, pidfd, &info, WSTOPPED, NULL), 0);
>>       ASSERT_EQ(info.si_signo, SIGCHLD);
>>       ASSERT_EQ(info.si_code, CLD_STOPPED);
>> @@ -117,6 +125,8 @@ static int sys_waitid(int which, pid_t pid, siginfo_t *info, int options,
>>       ASSERT_EQ(sys_pidfd_send_signal(pidfd, SIGCONT, NULL, 0), 0);
>>         ASSERT_EQ(sys_waitid(P_PIDFD, pidfd, &info, WCONTINUED, NULL), 0);
>> +    ASSERT_EQ(write(pfd[1], "C", 1), 1);
>> +    close(pfd[1]);
>>       ASSERT_EQ(info.si_signo, SIGCHLD);
>>       ASSERT_EQ(info.si_code, CLD_CONTINUED);
>>       ASSERT_EQ(info.si_pid, parent_tid);
>

