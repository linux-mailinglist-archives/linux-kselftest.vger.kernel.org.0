Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5D4558E230
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Aug 2022 23:54:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbiHIVyR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 9 Aug 2022 17:54:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiHIVyM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 9 Aug 2022 17:54:12 -0400
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 112406BD63;
        Tue,  9 Aug 2022 14:54:11 -0700 (PDT)
Received: from sslproxy05.your-server.de ([78.46.172.2])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1oLXAc-000Gax-BP; Tue, 09 Aug 2022 23:53:50 +0200
Received: from [85.1.206.226] (helo=linux.home)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1oLXAb-000HwI-MK; Tue, 09 Aug 2022 23:53:49 +0200
Subject: Re: [PATCH v9 02/10] bpf: Allow kfuncs to be used in LSM programs
To:     Roberto Sassu <roberto.sassu@huawei.com>, ast@kernel.org,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org,
        corbet@lwn.net, dhowells@redhat.com, jarkko@kernel.org,
        rostedt@goodmis.org, mingo@redhat.com, paul@paul-moore.com,
        jmorris@namei.org, serge@hallyn.com, shuah@kernel.org
Cc:     bpf@vger.kernel.org, linux-doc@vger.kernel.org,
        keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220809134603.1769279-1-roberto.sassu@huawei.com>
 <20220809134603.1769279-3-roberto.sassu@huawei.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <bf912249-a91e-77a5-0cc7-de5f85c6a6cd@iogearbox.net>
Date:   Tue, 9 Aug 2022 23:53:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20220809134603.1769279-3-roberto.sassu@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.6/26622/Tue Aug  9 09:53:52 2022)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 8/9/22 3:45 PM, Roberto Sassu wrote:
> From: KP Singh <kpsingh@kernel.org>
> 
> In preparation for the addition of bpf_getxattr kfunc.

Given this is taken out of context and the series is not about bpf_getxattr,
this patch should have a better commit description.

> Signed-off-by: KP Singh <kpsingh@kernel.org>

Please also append your SoB then [0].

   [0] https://www.kernel.org/doc/html/latest/process/submitting-patches.html#developer-s-certificate-of-origin-1-1

> ---
>   kernel/bpf/btf.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index d3e4c86b8fcd..67dfc728fbf8 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -7244,6 +7244,7 @@ static int bpf_prog_type_to_kfunc_hook(enum bpf_prog_type prog_type)
>   	case BPF_PROG_TYPE_STRUCT_OPS:
>   		return BTF_KFUNC_HOOK_STRUCT_OPS;
>   	case BPF_PROG_TYPE_TRACING:
> +	case BPF_PROG_TYPE_LSM:
>   		return BTF_KFUNC_HOOK_TRACING;
>   	case BPF_PROG_TYPE_SYSCALL:
>   		return BTF_KFUNC_HOOK_SYSCALL;
> 

