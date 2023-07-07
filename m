Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D43974AB8D
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jul 2023 09:05:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbjGGHFq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 7 Jul 2023 03:05:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjGGHFp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 7 Jul 2023 03:05:45 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DFC21FDB;
        Fri,  7 Jul 2023 00:05:40 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Qy4DJ4LL1z4f3tpX;
        Fri,  7 Jul 2023 15:05:36 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
        by APP2 (Coremail) with SMTP id Syh0CgAH79w9uadkE+1HNQ--.17177S2;
        Fri, 07 Jul 2023 15:05:37 +0800 (CST)
Subject: Re: [PATCH] tools: testing: Corrected a clerical error
To:     Lu Hongfei <luhongfei@vivo.com>
Cc:     opensource.kernel@vivo.com, Andrii Nakryiko <andrii@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Anton Protopopov <aspsk@isovalent.com>, bpf@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230706095339.4048-1-luhongfei@vivo.com>
From:   Hou Tao <houtao@huaweicloud.com>
Message-ID: <dd226e17-2f3a-4cca-429d-9dd2d711425c@huaweicloud.com>
Date:   Fri, 7 Jul 2023 15:05:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20230706095339.4048-1-luhongfei@vivo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID: Syh0CgAH79w9uadkE+1HNQ--.17177S2
X-Coremail-Antispam: 1UD129KBjvJXoW7AFWxKrWxtr4UAF47uF1xZrb_yoW8Jw13pa
        1xGr1FkryftF1rJ3W8uFW5WryfXrnFqrWrGF4fZrWUZr1xJF9aqr1xKrWYqrn0qrZYvw1f
        ua9agF1fuw48A37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
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
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi,

On 7/6/2023 5:53 PM, Lu Hongfei wrote:
> When wrapping code, use ';' better than using ',' which is more
> in line with the coding habits of most engineers.
>
> Signed-off-by: Lu Hongfei <luhongfei@vivo.com>
> ---
>  tools/testing/selftests/bpf/benchs/bench_ringbufs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/bpf/benchs/bench_ringbufs.c b/tools/testing/selftests/bpf/benchs/bench_ringbufs.c
> index 3ca14ad36607..e1ee979e6acc 100644
> --- a/tools/testing/selftests/bpf/benchs/bench_ringbufs.c
> +++ b/tools/testing/selftests/bpf/benchs/bench_ringbufs.c
> @@ -399,7 +399,7 @@ static void perfbuf_libbpf_setup(void)
>  	ctx->skel = perfbuf_setup_skeleton();
>  
>  	memset(&attr, 0, sizeof(attr));
> -	attr.config = PERF_COUNT_SW_BPF_OUTPUT,
> +	attr.config = PERF_COUNT_SW_BPF_OUTPUT;
>  	attr.type = PERF_TYPE_SOFTWARE;
>  	attr.sample_type = PERF_SAMPLE_RAW;
>  	/* notify only every Nth sample */

Acked-by: Hou Tao <houtao1@huawei.com>

Please update the subject of the patch in v2. The subject should be
something like: "[PATCH bpf-next] selftests/bpf: xxxxxx"

Just be curious. How do you find out the typo ? Is there any similar
typos in bpf selftests and could you please fix these typos as well ?


