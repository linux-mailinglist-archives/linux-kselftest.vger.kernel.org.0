Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 406EB6F010D
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Apr 2023 08:53:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243064AbjD0GxF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 27 Apr 2023 02:53:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242825AbjD0GxF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 27 Apr 2023 02:53:05 -0400
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBD921BD6;
        Wed, 26 Apr 2023 23:53:03 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.229])
        by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4Q6R5P4Tgzz9yHBc;
        Thu, 27 Apr 2023 14:43:21 +0800 (CST)
Received: from roberto-ThinkStation-P620 (unknown [10.204.63.22])
        by APP2 (Coremail) with SMTP id GxC2BwAn61GxG0pkqy9aAg--.8914S2;
        Thu, 27 Apr 2023 07:52:43 +0100 (CET)
Message-ID: <e1bd99a4ea209277d657f7fb7ccdc26451113fc9.camel@huaweicloud.com>
Subject: Re: [PATCH bpf] selftests/bpf: fix pkg-config call building
 sign-file
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     Jeremy Sowden <jeremy@azazel.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
        Roberto Sassu <roberto.sassu@huawei.com>
Cc:     bpf@vger.kernel.org, linux-kselftest@vger.kernel.org
Date:   Thu, 27 Apr 2023 08:52:27 +0200
In-Reply-To: <20230426215032.415792-1-jeremy@azazel.net>
References: <20230426215032.415792-1-jeremy@azazel.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: GxC2BwAn61GxG0pkqy9aAg--.8914S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJryrJrykurWrtr1kZw45GFg_yoW8WF4kpa
        yFy3WYyFySgw17JFWrCFW3uFWrKr1UXFyYvFnFgryUZrn3Jr97Jr4IkFW5WF9xW3yrtr13
        Za4IgFy3Zw48J37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij
        64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
        8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE
        2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42
        xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
        c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UZ18PUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAABF1jj4yJpAABsU
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, 2023-04-26 at 22:50 +0100, Jeremy Sowden wrote:
> When building sign-file, the call to get the CFLAGS for libcrypto is
> missing white-space between `pkg-config` and `--cflags`:
> 
>   $(shell $(HOSTPKG_CONFIG)--cflags libcrypto 2> /dev/null)
> 
> Removing the redirection of stderr, we see:
> 
>   $ make -C tools/testing/selftests/bpf sign-file
>   make: Entering directory '[...]/tools/testing/selftests/bpf'
>   make: pkg-config--cflags: No such file or directory
>     SIGN-FILE sign-file
>   make: Leaving directory '[...]/tools/testing/selftests/bpf'
> 
> Add the missing space.
> 
> Fixes: fc97590668ae ("selftests/bpf: Add test for bpf_verify_pkcs7_signature() kfunc")
> Signed-off-by: Jeremy Sowden <jeremy@azazel.net>

Thanks.

Reviewed-by: Roberto Sassu <roberto.sassu@huawei.com>

Roberto

> ---
>  tools/testing/selftests/bpf/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> index b677dcd0b77a..ad01c9e1ff12 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -197,7 +197,7 @@ $(OUTPUT)/urandom_read: urandom_read.c urandom_read_aux.c $(OUTPUT)/liburandom_r
>  
>  $(OUTPUT)/sign-file: ../../../../scripts/sign-file.c
>  	$(call msg,SIGN-FILE,,$@)
> -	$(Q)$(CC) $(shell $(HOSTPKG_CONFIG)--cflags libcrypto 2> /dev/null) \
> +	$(Q)$(CC) $(shell $(HOSTPKG_CONFIG) --cflags libcrypto 2> /dev/null) \
>  		  $< -o $@ \
>  		  $(shell $(HOSTPKG_CONFIG) --libs libcrypto 2> /dev/null || echo -lcrypto)
>  

