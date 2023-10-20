Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8D5E7D062C
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Oct 2023 03:34:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346776AbjJTBex (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 19 Oct 2023 21:34:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346768AbjJTBex (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 19 Oct 2023 21:34:53 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 59525126;
        Thu, 19 Oct 2023 18:34:50 -0700 (PDT)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8Dx_+s42TFl3V0zAA--.33030S3;
        Fri, 20 Oct 2023 09:34:48 +0800 (CST)
Received: from [10.130.0.149] (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Cxjd412TFl5rErAA--.29062S3;
        Fri, 20 Oct 2023 09:34:45 +0800 (CST)
Subject: Re: [PATCH] selftests/clone3: Skip new time namespace test when
 unsupported
To:     Andrew Morton <akpm@linux-foundation.org>,
        Mark Brown <broonie@kernel.org>
References: <20231020-kselftest-clone3-time-ns-v1-1-31a17e072a05@kernel.org>
 <20231019163538.69d494a0af0560a492b5ffb4@linux-foundation.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Tobias Klauser <tklauser@distanz.ch>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <d2d0bb05-4d8c-533b-c67d-7c5d5af6e577@loongson.cn>
Date:   Fri, 20 Oct 2023 09:34:45 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <20231019163538.69d494a0af0560a492b5ffb4@linux-foundation.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8Cxjd412TFl5rErAA--.29062S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7AF4kAr4kur1rZFWxAFy5GFX_yoW8Zr4Upa
        y8Za15Kr45Xr1UGFZ7X3s7JFy3AF1DAFy7Gw18J3yvk398WF9Yyr4S9Fy5WrnFqr9Y9F1Y
        yayIqF9F9ayUA3gCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUUP2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
        6r4UJVWxJr1ln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
        xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r12
        6r1DMcIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr4
        1lc7I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxG
        rwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AKxVWUXVWUAwC20s026c02F40E14
        v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkG
        c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
        0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4U
        MIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8HKZJUUUU
        U==
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 10/20/2023 07:35 AM, Andrew Morton wrote:
> On Fri, 20 Oct 2023 00:08:12 +0100 Mark Brown <broonie@kernel.org> wrote:
>
>> Use a filter function to skip the time namespace test on systems with
>> !CONFIG_TIME_NS. This reworks a fix originally done by Tiezhu Yang prior
>> to the refactoring in 34dce23f7e40 ("selftests/clone3: Report descriptive
>> test names"). The changelog from their fix explains the issue very clearly:
>
> I was about to send Tiezhu Yang's fix to Linus.   I'll rebase mm-hotfixes-stable
> to drop that patch, so you own it now!
>
> Please note that your version lacks an explicit cc:stable, but I suppose the
> stablebots will scoop it up anyway.
>
>> Original-fix-from: Tiezhu Yang <yangtiezhu@loongson.cn>
>
> "Original-fix-from" isn't a thing.  In fact it seems to be the first
> time this has been used.  Grepping for  "Original-.*:" shows
> all sorts of innovations, including "Based-on-the-original-screenplay-by:".
>
> I guess Documentation/process/submitting-patches.rst and checkpatch
> lost this fight a long time ago.
>

Thank you all.

If it is possible, I think it is better to rebase linux-kselftest next
to do the following things sequentially.

(1) Apply patch "selftests/clone3: Fix broken test under !CONFIG_TIME_NS"
which is sent on 11 Jul 2023.

https://lore.kernel.org/linux-kselftest/1689066814-13295-1-git-send-email-yangtiezhu@loongson.cn/

(2) Squash the changes in patch "selftests/clone3: Skip new time 
namespace test when unsupported"

https://lore.kernel.org/linux-kselftest/20231020-kselftest-clone3-time-ns-v1-1-31a17e072a05@kernel.org/

into patch "selftests/clone3: Report descriptive test names", and then 
apply it.

https://lore.kernel.org/linux-kselftest/20231018-kselftest-clone3-output-v1-1-12b7c50ea2cf@kernel.org/

This can make the log more clear. Anyway, I am fine with either way.

Thanks,
Tiezhu

