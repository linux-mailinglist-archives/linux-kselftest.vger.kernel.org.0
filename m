Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 019147C6277
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Oct 2023 03:52:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234003AbjJLBww (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 11 Oct 2023 21:52:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233989AbjJLBww (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 11 Oct 2023 21:52:52 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A09A5B6;
        Wed, 11 Oct 2023 18:52:45 -0700 (PDT)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8BxJvFsUSdl2zoxAA--.29454S3;
        Thu, 12 Oct 2023 09:52:44 +0800 (CST)
Received: from [10.130.0.149] (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Cxzt5pUSdlsjYhAA--.6621S3;
        Thu, 12 Oct 2023 09:52:41 +0800 (CST)
Subject: Re: [PATCH v2 0/2] Modify vDSO selftests
To:     Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>
References: <1689069425-17414-1-git-send-email-yangtiezhu@loongson.cn>
 <6aafe4f7-5b20-e791-12c1-413f2db3417b@loongson.cn>
Cc:     linux-kselftest@vger.kernel.org, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org, loongson-kernel@lists.loongnix.cn,
        Andrew Morton <akpm@linux-foundation.org>
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <379c1f53-3e32-0033-3658-6689f43e7f1f@loongson.cn>
Date:   Thu, 12 Oct 2023 09:52:41 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <6aafe4f7-5b20-e791-12c1-413f2db3417b@loongson.cn>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8Cxzt5pUSdlsjYhAA--.6621S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj9xXoWrtr1ftw4xKryDXw45KFW5CFX_yoWfurbE9a
        y8uas3tws7ZF9xAF4Sgw13ZryDJayIyr4UKr17Way7Xry3ZFWUWF4kur48u3WrWa17trZ2
        yF4UZasavryDXosvyTuYvTs0mTUanT9S1TB71UUUUj7qnTZGkaVYY2UrUUUUj1kv1TuYvT
        s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
        cSsGvfJTRUUUbDAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
        vaj40_Wr0E3s1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
        w2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
        W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
        Gr0_Gr1UM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
        kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUAVWU
        twAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMx
        k0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l
        4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67AKxV
        WUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI
        7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r
        1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI
        42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07j5o7tUUUUU=
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Cc: Andrew Morton <akpm@linux-foundation.org>

On 08/17/2023 03:20 PM, Tiezhu Yang wrote:
> Hi Shuah,
>
> On 07/11/2023 05:57 PM, Tiezhu Yang wrote:
>> v2: Rebase on 6.5-rc1 and update the commit message
>>
>> Tiezhu Yang (2):
>>   selftests/vDSO: Add support for LoongArch
>>   selftests/vDSO: Get version and name for all archs
>>
>>  tools/testing/selftests/vDSO/vdso_config.h         |  6 ++++-
>>  tools/testing/selftests/vDSO/vdso_test_getcpu.c    | 16 +++++--------
>>  .../selftests/vDSO/vdso_test_gettimeofday.c        | 26
>> ++++++----------------
>>  3 files changed, 18 insertions(+), 30 deletions(-)
>>
>
> Any comments? I guess this should go through the linux-kselftest tree.
>
> Thanks,
> Tiezhu
>

What are the status of these patches?

https://lore.kernel.org/lkml/1689069425-17414-1-git-send-email-yangtiezhu@loongson.cn/

This is a ping message, maybe you have forgot them?

Thanks,
Tiezhu

