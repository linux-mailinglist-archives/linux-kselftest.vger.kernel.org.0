Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AC2A6320BC
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Nov 2022 12:35:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230215AbiKULfD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 21 Nov 2022 06:35:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231296AbiKULeq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 21 Nov 2022 06:34:46 -0500
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89858B4838;
        Mon, 21 Nov 2022 03:30:13 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4NG4tl3Tynz4f3l2F;
        Mon, 21 Nov 2022 19:30:07 +0800 (CST)
Received: from [10.67.111.192] (unknown [10.67.111.192])
        by APP3 (Coremail) with SMTP id _Ch0CgBXZqJBYXtj6fFRAw--.52286S2;
        Mon, 21 Nov 2022 19:30:10 +0800 (CST)
Message-ID: <a6f8b4a4-2c37-740b-af87-c61af51eaab5@huaweicloud.com>
Date:   Mon, 21 Nov 2022 19:30:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH bpf 1/2] bpf: Do not copy spin lock field from user in
 bpf_selem_alloc
Content-Language: en-US
From:   Xu Kuohai <xukuohai@huaweicloud.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>
References: <20221114134720.1057939-1-xukuohai@huawei.com>
 <20221114134720.1057939-2-xukuohai@huawei.com>
 <CAADnVQLEzrqjuF+qYh2kJz0Q=9G8PySJ6ZwXD2EGoZsBUdwsog@mail.gmail.com>
 <fd1e6d2d-f7a2-21d2-f0ff-3e3d8b2ba9eb@huawei.com>
In-Reply-To: <fd1e6d2d-f7a2-21d2-f0ff-3e3d8b2ba9eb@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: _Ch0CgBXZqJBYXtj6fFRAw--.52286S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Xw15Xw17Ww15GF4fWF15urg_yoW8JrWxpr
        93Aas8tFW7Xw1rua9Iqr4xAFy09w43G3WDWan8JFWrGrZ3ZF9Igr1Dta1UCa4Syw4aq3Wv
        vF1Yqas8C34DAaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
        e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
        Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a
        6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
        kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE
        14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf
        9x07UZ18PUUUUU=
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 11/16/2022 4:07 PM, Xu Kuohai wrote:
> On 11/16/2022 1:27 PM, Alexei Starovoitov wrote:
>> On Mon, Nov 14, 2022 at 5:31 AM Xu Kuohai <xukuohai@huawei.com> wrote:
>>>
>>> bpf_selem_alloc function is used by inode_storage, sk_storage and
>>> task_storage maps to set map value, for these map types, there may
>>> be a spin lock in the map value, so if we use memcpy to copy the whole
>>> map value from user, the spin lock field may be initialized incorrectly.
>>>
>>> Since the spin lock field is zeroed by kzalloc, call copy_map_value
>>> instead of memcpy to skip copying the spin lock field to fix it.
>>>
>>> Fixes: 6ac99e8f23d4 ("bpf: Introduce bpf sk local storage")
>>
>> The tag is wrong. When local storage was introduced it was not
>> possible to use spin_locks there.
>> Pls resubmit.
>> .
> 
> No, spin_lock was introduced by d83525ca62cf ("bpf: introduce bpf_spin_lock"),
> before 6ac99e8f23d4 ("bpf: Introduce bpf sk local storage").
> 
> To confirm this, I built a kernel image on comit 6ac99e8f23d4 ("bpf: Introduce bpf sk local storage")
> and run test case posted in patch 2, a softlockup was triggered. Then I picked
> this patch and tried again, nothing failed.

Hello, am I right? Or could you please give the correct fix-tag? Thanks.

