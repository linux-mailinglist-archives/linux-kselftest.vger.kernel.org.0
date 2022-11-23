Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC8D2634BBB
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Nov 2022 01:40:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234795AbiKWAk2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 22 Nov 2022 19:40:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233436AbiKWAk0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 22 Nov 2022 19:40:26 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BE8A5C689E;
        Tue, 22 Nov 2022 16:40:24 -0800 (PST)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8Dxvuv2a31j1yEAAA--.400S3;
        Wed, 23 Nov 2022 08:40:22 +0800 (CST)
Received: from [10.130.0.135] (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8AxiFfxa31jwGsYAA--.45736S3;
        Wed, 23 Nov 2022 08:40:18 +0800 (CST)
Subject: Re: [PATCH] tools: selftests: Use "grep -E" instead of "egrep"
To:     Shuah Khan <skhan@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>
References: <1668763704-10408-1-git-send-email-yangtiezhu@loongson.cn>
 <42c7effb-691c-c7a1-0d7d-8ba1569c0269@linuxfoundation.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <4cd49bce-7722-f388-6c2b-1b65b65cb54f@loongson.cn>
Date:   Wed, 23 Nov 2022 08:40:17 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <42c7effb-691c-c7a1-0d7d-8ba1569c0269@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8AxiFfxa31jwGsYAA--.45736S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvJXoW7uFyDuF43Kr4Uur43Ww4DJwb_yoW8tFyDpa
        y8J3Wagr18tFy7XF1xJrsrXFyftFs5Ja1rJw4rtryDXrn8XFnaqr1IgFsxKFZrWrZ5XrsY
        va92gF17Cw48A37anT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bxxYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_JrI_Jryl8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwA2z4
        x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267AKxVW8JVW8Jr1le2I2
        62IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4
        CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvj
        eVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67vIY487MxAIw2
        8IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4l
        x2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrw
        CI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI
        42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z2
        80aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU7XTmDUUUU
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 11/22/2022 11:43 PM, Shuah Khan wrote:
> On 11/18/22 02:28, Tiezhu Yang wrote:
>> The latest version of grep claims the egrep is now obsolete so the build
>> now contains warnings that look like:
>>     egrep: warning: egrep is obsolescent; using grep -E
>> fix this up by moving the related file to use "grep -E" instead.
>>
>>    sed -i "s/egrep/grep -E/g" `grep egrep -rwl tools/testing/selftests`
>>
>> Here are the steps to install the latest grep:
>>
>>    wget http://ftp.gnu.org/gnu/grep/grep-3.8.tar.gz
>>    tar xf grep-3.8.tar.gz
>>    cd grep-3.8 && ./configure && make
>>    sudo make install
>>    export PATH=/usr/local/bin:$PATH
>>
>
> Does this change work without the latest grep? It seems to work on
> grep (GNU grep) 3.7 when I ran quick test on kselftest_deps.sh with
> your change.

Yes, AFAIK, "grep -E" is supported by various versions of grep.

We can see the following NEWS in grep-3.8 release announcement [1]:

"The egrep and fgrep commands, which have been deprecated since
  release 2.5.3 (2007), now warn that they are obsolescent and should
  be replaced by grep -E and grep -F."

[1] https://savannah.gnu.org/forum/forum.php?forum_id=10227

>
>> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
>> ---
>>   .../selftests/ftrace/test.d/preemptirq/irqsoff_tracer.tc       |  8
>> ++++----
>>   tools/testing/selftests/gpio/gpio-sim.sh                       |  2 +-
>>   tools/testing/selftests/kselftest_deps.sh                      |  2 +-
>>   tools/testing/selftests/net/toeplitz.sh                        |  2 +-
>>   tools/testing/selftests/powerpc/scripts/hmi.sh                 |  2 +-
>>   tools/testing/selftests/rcutorture/bin/console-badness.sh      |  2 +-
>>   tools/testing/selftests/rcutorture/bin/kvm-build.sh            |  4
>> ++--
>>   tools/testing/selftests/rcutorture/bin/kvm-find-errors.sh      |  4
>> ++--
>>   tools/testing/selftests/rcutorture/bin/kvm.sh                  |  4
>> ++--
>>   tools/testing/selftests/rcutorture/bin/parse-console.sh        | 10
>> +++++-----
>>   10 files changed, 20 insertions(+), 20 deletions(-)
>>
>
> Please split these into sepratate 5 patches. All rcu changes in one, net in
> one, powerpc  etc.

OK, maybe 6 patches,
(1) rcutorture
(2) ftrace
(3) powerpc
(4) gpio
(5) net
(6) kselftest_deps.sh

>
> The change looks good to me.

Thank you, I will send v2 later.

Thanks,
Tiezhu

