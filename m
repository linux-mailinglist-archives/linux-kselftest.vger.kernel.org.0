Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D959F62B499
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Nov 2022 09:08:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233137AbiKPII0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 16 Nov 2022 03:08:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238149AbiKPIHx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 16 Nov 2022 03:07:53 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBC4BC756;
        Wed, 16 Nov 2022 00:07:51 -0800 (PST)
Received: from kwepemi500013.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NBwcv58NdzHvqw;
        Wed, 16 Nov 2022 16:07:11 +0800 (CST)
Received: from [10.67.111.192] (10.67.111.192) by
 kwepemi500013.china.huawei.com (7.221.188.120) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 16 Nov 2022 16:07:41 +0800
Message-ID: <fd1e6d2d-f7a2-21d2-f0ff-3e3d8b2ba9eb@huawei.com>
Date:   Wed, 16 Nov 2022 16:07:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH bpf 1/2] bpf: Do not copy spin lock field from user in
 bpf_selem_alloc
Content-Language: en-US
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
CC:     bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
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
From:   Xu Kuohai <xukuohai@huawei.com>
In-Reply-To: <CAADnVQLEzrqjuF+qYh2kJz0Q=9G8PySJ6ZwXD2EGoZsBUdwsog@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.111.192]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemi500013.china.huawei.com (7.221.188.120)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 11/16/2022 1:27 PM, Alexei Starovoitov wrote:
> On Mon, Nov 14, 2022 at 5:31 AM Xu Kuohai <xukuohai@huawei.com> wrote:
>>
>> bpf_selem_alloc function is used by inode_storage, sk_storage and
>> task_storage maps to set map value, for these map types, there may
>> be a spin lock in the map value, so if we use memcpy to copy the whole
>> map value from user, the spin lock field may be initialized incorrectly.
>>
>> Since the spin lock field is zeroed by kzalloc, call copy_map_value
>> instead of memcpy to skip copying the spin lock field to fix it.
>>
>> Fixes: 6ac99e8f23d4 ("bpf: Introduce bpf sk local storage")
> 
> The tag is wrong. When local storage was introduced it was not
> possible to use spin_locks there.
> Pls resubmit.
> .

No, spin_lock was introduced by d83525ca62cf ("bpf: introduce bpf_spin_lock"),
before 6ac99e8f23d4 ("bpf: Introduce bpf sk local storage").

To confirm this, I built a kernel image on comit 6ac99e8f23d4 ("bpf: Introduce bpf sk local storage")
and run test case posted in patch 2, a softlockup was triggered. Then I picked
this patch and tried again, nothing failed.
