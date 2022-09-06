Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 296AD5ADDC4
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Sep 2022 05:07:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238210AbiIFDG4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 5 Sep 2022 23:06:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232190AbiIFDGy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 5 Sep 2022 23:06:54 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC28E58DEE;
        Mon,  5 Sep 2022 20:06:52 -0700 (PDT)
Received: from dggpeml500025.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MM9Dl4CyKzkWsy;
        Tue,  6 Sep 2022 11:03:03 +0800 (CST)
Received: from [10.174.176.117] (10.174.176.117) by
 dggpeml500025.china.huawei.com (7.185.36.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 6 Sep 2022 11:06:49 +0800
Subject: Re: [PATCH v16 04/12] bpf: Export bpf_dynptr_get_size()
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>, <ast@kernel.org>,
        <daniel@iogearbox.net>, <andrii@kernel.org>,
        <martin.lau@linux.dev>, <song@kernel.org>, <yhs@fb.com>,
        <john.fastabend@gmail.com>, <kpsingh@kernel.org>, <sdf@google.com>,
        <haoluo@google.com>, <jolsa@kernel.org>, <mykolal@fb.com>,
        <dhowells@redhat.com>, <jarkko@kernel.org>, <rostedt@goodmis.org>,
        <mingo@redhat.com>, <paul@paul-moore.com>, <jmorris@namei.org>,
        <serge@hallyn.com>, <shuah@kernel.org>
CC:     <bpf@vger.kernel.org>, <keyrings@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <deso@posteo.net>, <memxor@gmail.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Joanne Koong <joannelkoong@gmail.com>
References: <20220905143318.1592015-1-roberto.sassu@huaweicloud.com>
 <20220905143318.1592015-5-roberto.sassu@huaweicloud.com>
From:   Hou Tao <houtao1@huawei.com>
Message-ID: <0be03b75-8666-f18b-bd4f-f6677c448287@huawei.com>
Date:   Tue, 6 Sep 2022 11:06:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20220905143318.1592015-5-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.174.176.117]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500025.china.huawei.com (7.185.36.35)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi,

On 9/5/2022 10:33 PM, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
>
> Export bpf_dynptr_get_size(), so that kernel code dealing with eBPF dynamic
> pointers can obtain the real size of data carried by this data structure.
>
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> Reviewed-by: Joanne Koong <joannelkoong@gmail.com>
> Acked-by: KP Singh <kpsingh@kernel.org>
> ---
>  include/linux/bpf.h  | 1 +
>  kernel/bpf/helpers.c | 2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)
SNIP
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index fc08035f14ed..824864ac82d1 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -1408,7 +1408,7 @@ static void bpf_dynptr_set_type(struct bpf_dynptr_kern *ptr, enum bpf_dynptr_typ
>  	ptr->size |= type << DYNPTR_TYPE_SHIFT;
>  }
>  
> -static u32 bpf_dynptr_get_size(struct bpf_dynptr_kern *ptr)
> +u32 bpf_dynptr_get_size(struct bpf_dynptr_kern *ptr)
>  {
>  	return ptr->size & DYNPTR_SIZE_MASK;
>  }
qp-trie also need it. But considering bpf_dynptr_get_size() is just one line,
Would moving it and the related definitions into bpf.h be a better choice ?


