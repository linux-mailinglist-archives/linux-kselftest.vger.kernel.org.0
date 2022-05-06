Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57E7951CF66
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 May 2022 05:25:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388530AbiEFD16 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 5 May 2022 23:27:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352476AbiEFD15 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 5 May 2022 23:27:57 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0A2AD63BE4;
        Thu,  5 May 2022 20:24:14 -0700 (PDT)
Received: from [10.130.0.135] (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9BxENvWlHRiua8LAA--.47364S3;
        Fri, 06 May 2022 11:24:07 +0800 (CST)
Subject: Re: [PATCH 2/2] MIPS: Use NOKPROBE_SYMBOL() instead of __kprobes
 annotation
To:     Masami Hiramatsu <mhiramat@kernel.org>
References: <1651753148-1464-1-git-send-email-yangtiezhu@loongson.cn>
 <1651753148-1464-3-git-send-email-yangtiezhu@loongson.cn>
 <20220506104504.535c6ab065993b97604178fe@kernel.org>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Shuah Khan <shuah@kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>, linux-mips@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <d4115146-966a-61a5-6bdd-0cd7092fd3b4@loongson.cn>
Date:   Fri, 6 May 2022 11:24:06 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <20220506104504.535c6ab065993b97604178fe@kernel.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf9BxENvWlHRiua8LAA--.47364S3
X-Coremail-Antispam: 1UD129KBjvJXoW7ur4UXryUAFyfCF47GrykKrg_yoW8XF4rpa
        s8Jws5CFs5Jw48KryxAw4ru34SkrsrAay5JrWUJry3Jw4qqr4vyrnIga1UtFyxKr1ftayI
        v3WqqrWrKa4DAa7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvG14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
        6r4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26F
        4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
        7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r
        1j6r4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCYjI0SjxkI62AI1cAE
        67vIY487MxkIecxEwVAFwVW8GwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJV
        W8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF
        1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6x
        IIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAI
        cVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa
        73UjIFyTuYvjfUYnYwUUUUU
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 05/06/2022 09:45 AM, Masami Hiramatsu wrote:
> On Thu,  5 May 2022 20:19:08 +0800
> Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
>
>> If define CONFIG_KPROBES, __kprobes annotation forces the whole function
>> into the ".kprobes.text" section, NOKPROBE_SYMBOL() just stores the given
>> function address in the "_kprobe_blacklist" section which is introduced
>> to maintain kprobes blacklist.
>>
>> Modify the related code to use NOKPROBE_SYMBOL() to protect functions from
>> kprobes instead of __kprobes annotation under arch/mips.
>
> So you added some non '__kprobes' annotated functions to NOKPROBE_SYMBOL()
> in this patch. Those caused the kernel panic, right?

Oh, no, this patch is not related with the kernel panic, what it does
is just to use NOKPROBE_SYMBOL() instead of __kprobes annotation, and
also add some non '__kprobes' annotated functions in kprobes.c to
NOKPROBE_SYMBOL() because they can not be probed too.

> If so, please add such
> comment on this description too. Or, split this into 2 patches, one fixes
> the kernel panic by adding those functions to NOKPROBE_SYMBOL() and the
> other is replacing __kprobes with NOKPROBE_SYMBOL().
>
> Also, could you also find the commit which introduces the kernel panic?
> It is worth to backport such fix to stable trees.

I did some work to find some other functions lead to kernel panic,
mark them as notrace function can avoid the problems, but I am not
quite sure the root cause, so I do not submit the changes now.

Thanks,
Tiezhu

