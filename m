Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CBF66C8A14
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 Mar 2023 02:57:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231395AbjCYB5j (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 24 Mar 2023 21:57:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjCYB5i (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 24 Mar 2023 21:57:38 -0400
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62FEFA27B;
        Fri, 24 Mar 2023 18:57:35 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Pk2Jp4lMkz4f3jXr;
        Sat, 25 Mar 2023 09:57:30 +0800 (CST)
Received: from [10.67.111.192] (unknown [10.67.111.192])
        by APP4 (Coremail) with SMTP id gCh0CgCnWa0LVR5k8bYQGA--.31219S2;
        Sat, 25 Mar 2023 09:57:32 +0800 (CST)
Message-ID: <253dd595-c850-c09f-2057-641487024fb7@huaweicloud.com>
Date:   Sat, 25 Mar 2023 09:57:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH bpf-next v2 1/2] bpf: add bound tracking for BPF_MOD
Content-Language: en-US
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>
References: <20230324045842.729719-1-xukuohai@huaweicloud.com>
 <20230324045842.729719-2-xukuohai@huaweicloud.com>
 <CAADnVQLKxssX1K_CSpbkcOPep2NNnoTRt2bMFzKhCo5AaUzwWA@mail.gmail.com>
From:   Xu Kuohai <xukuohai@huaweicloud.com>
In-Reply-To: <CAADnVQLKxssX1K_CSpbkcOPep2NNnoTRt2bMFzKhCo5AaUzwWA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgCnWa0LVR5k8bYQGA--.31219S2
X-Coremail-Antispam: 1UD129KBjvdXoWrtr1ktF4DJF48GFyDJr4xWFg_yoWktrXEk3
        s2ywn5uwnxGwn7Can3A3WqqryDCa1DGry5GrWaqr12qFyxAr9YkFn5Crn2yr98GFWfJ3yD
        Jrnavay7Zw1SqjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbIxYFVCjjxCrM7AC8VAFwI0_Xr0_Wr1l1xkIjI8I6I8E6xAIw20E
        Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
        A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x02
        67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
        0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS
        07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
        02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_
        WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
        CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAF
        wI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa
        7IU13rcDUUUUU==
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.0 required=5.0 tests=NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 3/24/2023 1:16 AM, Alexei Starovoitov wrote:
> On Thu, Mar 23, 2023 at 8:59 AM Xu Kuohai <xukuohai@huaweicloud.com> wrote:
>>
>> From: Xu Kuohai <xukuohai@huawei.com>
>>
>> dst_reg is marked as unknown when BPF_MOD instruction is verified, causing
>> the following bpf prog to be incorrectly rejected.
>>
>> 0: r0 = 0
>> 1: r0 %= 1   // r0 is marked as unknown
>> 2: r1 = 0
>> 3: r1 += 1
>> 4: if r1 < r0 goto pc-2 // verifier treats the loop as unbounded
>> 5: exit
>>
>> To teach verifier to accept the above prog, this patch adds bound tracking
>> for BPF_MOD.
>>
>> The approach is based on the following rules:
>>
>> 1. BPF_MOD is unsigned;
>>
>> 2. For an unsigned constant divisor x:
>>
>>   a. when x != 0, the resulted dst_reg bits are in the range [0, x - 1],
>>      and if no wrapping occurs, the result can be further narrowed down
>>      to [umin mod x, umax mod x];
>>
>>   b. when x == 0, dst_reg is truncated to 32 bits by mod32 or remains
>>      unchanged by mod64.
>>
>> Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
> 
> Same Nack as before.

Sorry, I did not receive Nack for this patch before.

> You haven't answered _why_ anyone needs it.

No idea, I simply believe it's good to have a closer estimate of the result.

