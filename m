Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4225258E2B8
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Aug 2022 00:13:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbiHIWNQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 9 Aug 2022 18:13:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbiHIWMz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 9 Aug 2022 18:12:55 -0400
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43693275C7;
        Tue,  9 Aug 2022 15:09:13 -0700 (PDT)
Received: from sslproxy05.your-server.de ([78.46.172.2])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1oLXPC-0007Lb-LF; Wed, 10 Aug 2022 00:08:54 +0200
Received: from [85.1.206.226] (helo=linux.home)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1oLXPB-000OdW-V3; Wed, 10 Aug 2022 00:08:53 +0200
Subject: Re: [PATCH v9 03/10] btf: Handle dynamic pointer parameter in kfuncs
To:     Roberto Sassu <roberto.sassu@huawei.com>, ast@kernel.org,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org,
        corbet@lwn.net, dhowells@redhat.com, jarkko@kernel.org,
        rostedt@goodmis.org, mingo@redhat.com, paul@paul-moore.com,
        jmorris@namei.org, serge@hallyn.com, shuah@kernel.org
Cc:     bpf@vger.kernel.org, linux-doc@vger.kernel.org,
        keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Joanne Koong <joannelkoong@gmail.com>
References: <20220809134603.1769279-1-roberto.sassu@huawei.com>
 <20220809134603.1769279-4-roberto.sassu@huawei.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <8fe84489-be78-142e-90fe-a76c7d61100d@iogearbox.net>
Date:   Wed, 10 Aug 2022 00:08:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20220809134603.1769279-4-roberto.sassu@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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
> Allow the bpf_dynptr_kern parameter to be specified in kfuncs. Also, ensure
> that the dynamic pointer is valid and initialized.
> 
> Cc: Joanne Koong <joannelkoong@gmail.com>
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---
>   include/linux/bpf_verifier.h |  3 +++
>   kernel/bpf/btf.c             | 17 +++++++++++++++++
>   kernel/bpf/verifier.c        |  4 ++--
>   3 files changed, 22 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index 2e3bad8640dc..55876fbdbae2 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -560,6 +560,9 @@ int check_kfunc_mem_size_reg(struct bpf_verifier_env *env, struct bpf_reg_state
>   			     u32 regno);
>   int check_mem_reg(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
>   		   u32 regno, u32 mem_size);
> +bool is_dynptr_reg_valid_init(struct bpf_verifier_env *env,
> +			      struct bpf_reg_state *reg,
> +			      enum bpf_arg_type arg_type);
>   
>   /* this lives here instead of in bpf.h because it needs to dereference tgt_prog */
>   static inline u64 bpf_trampoline_compute_key(const struct bpf_prog *tgt_prog,
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 67dfc728fbf8..17cca396c89f 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -6363,6 +6363,8 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
>   
>   			if (is_kfunc) {
>   				bool arg_mem_size = i + 1 < nargs && is_kfunc_arg_mem_size(btf, &args[i + 1], &regs[regno + 1]);
> +				bool arg_dynptr = btf_type_is_struct(ref_t) &&
> +						  !strcmp(ref_tname, "bpf_dynptr_kern");

For the strcmp(), could we add some BUILD_BUG_ON() if "bpf_dynptr_kern" ever
gets renamed? I played a bit with the below compile-tested toy example. If we
rename foo_bar into something else, we then get:

   [...]
   CC      net/core/dev.o
   In file included from <command-line>:
   net/core/dev.c: In function ‘net_dev_init’:
   net/core/dev.c:11376:25: error: invalid application of ‘sizeof’ to incomplete type ‘struct foo_bar’
   11376 |  ({ BUILD_BUG_ON(sizeof(struct x) < 0); \
         |                         ^~~~~~
   [...]

diff --git a/net/core/dev.c b/net/core/dev.c
index 716df64fcfa5..a2ed271f7ded 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -11368,16 +11368,30 @@ static struct pernet_operations __net_initdata default_device_ops = {
   *
   */

+struct foo_bar {
+       int a;
+};
+
+#define stringify_struct(x)                    \
+       ({ BUILD_BUG_ON(sizeof(struct x) < 0);  \
+       __stringify(x); })
+
  /*
   *       This is called single threaded during boot, so no need
   *       to take the rtnl semaphore.
   */
  static int __init net_dev_init(void)
  {
+       const char *ref_tname = "abc";
         int i, rc = -ENOMEM;

         BUG_ON(!dev_boot_phase);

+       printk("%s\n", stringify_struct(foo_bar));
+
+       if (!strcmp(ref_tname, stringify_struct(foo_bar)))
+               goto out;
+
         if (dev_proc_init())
                 goto out;

