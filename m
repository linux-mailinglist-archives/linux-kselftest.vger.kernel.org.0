Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DAF35A8EEA
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Sep 2022 08:58:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233027AbiIAG6X (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 1 Sep 2022 02:58:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233038AbiIAG6V (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 1 Sep 2022 02:58:21 -0400
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FC7AD11E5;
        Wed, 31 Aug 2022 23:58:18 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.227])
        by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4MJBZ93wPyz9v7Hg;
        Thu,  1 Sep 2022 14:52:49 +0800 (CST)
Received: from roberto-ThinkStation-P620 (unknown [10.204.63.22])
        by APP2 (Coremail) with SMTP id GxC2BwA3s13fVxBjZcATAA--.7637S2;
        Thu, 01 Sep 2022 07:57:48 +0100 (CET)
Message-ID: <2b2242f8d09378fbec49d4f7e29960d5e50d0a68.camel@huaweicloud.com>
Subject: Re: [PATCH v15 12/12] selftests/bpf: Add tests for dynamic pointers
 parameters in kfuncs
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, mykolal@fb.com,
        dhowells@redhat.com, jarkko@kernel.org, rostedt@goodmis.org,
        mingo@redhat.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, shuah@kernel.org
Cc:     bpf@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        deso@posteo.net, memxor@gmail.com,
        Roberto Sassu <roberto.sassu@huawei.com>
Date:   Thu, 01 Sep 2022 08:57:30 +0200
In-Reply-To: <20220831165445.1071641-13-roberto.sassu@huaweicloud.com>
References: <20220831165445.1071641-1-roberto.sassu@huaweicloud.com>
         <20220831165445.1071641-13-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: GxC2BwA3s13fVxBjZcATAA--.7637S2
X-Coremail-Antispam: 1UD129KBjvJXoW3AF4kCF18Zr4UJrWUKr1kAFb_yoWxGF13pa
        yrGFy29rWIq3W7Wr13XF4IvF4fKr48Zr1akrZFq34xAr1DXryxWF48Kr45Jwn5K395Xw45
        Zw1Sgr4rCr4Uta7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6r1S6rWUM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij
        64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
        8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE
        2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42
        xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
        c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UAkuxUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgACBF1jj3589gAEsF
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, 2022-08-31 at 18:54 +0200, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
> 
> Add tests to ensure that only supported dynamic pointer types are
> accepted,
> that the passed argument is actually a dynamic pointer, and that the
> passed
> argument is a pointer to the stack.

Sorry, forgot to add this test to the deny list of s390.

I also rebased to the latest commit.

Let me know if I should resend.

Thanks

Roberto

> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---
>  .../bpf/prog_tests/kfunc_dynptr_param.c       | 102
> ++++++++++++++++++
>  .../bpf/progs/test_kfunc_dynptr_param.c       |  57 ++++++++++
>  2 files changed, 159 insertions(+)
>  create mode 100644
> tools/testing/selftests/bpf/prog_tests/kfunc_dynptr_param.c
>  create mode 100644
> tools/testing/selftests/bpf/progs/test_kfunc_dynptr_param.c
> 
> diff --git
> a/tools/testing/selftests/bpf/prog_tests/kfunc_dynptr_param.c
> b/tools/testing/selftests/bpf/prog_tests/kfunc_dynptr_param.c
> new file mode 100644
> index 000000000000..732897faf36b
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/kfunc_dynptr_param.c
> @@ -0,0 +1,102 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2022 Facebook
> + * Copyright (C) 2022 Huawei Technologies Duesseldorf GmbH
> + *
> + * Author: Roberto Sassu <roberto.sassu@huawei.com>
> + */
> +
> +#include <test_progs.h>
> +#include "test_kfunc_dynptr_param.skel.h"
> +
> +static size_t log_buf_sz = 1048576; /* 1 MB */
> +static char obj_log_buf[1048576];
> +
> +static struct {
> +	const char *prog_name;
> +	const char *expected_err_msg;
> +} kfunc_dynptr_tests[] = {
> +	{"dynptr_type_not_supp",
> +	 "arg#0 pointer type STRUCT bpf_dynptr_kern points to
> unsupported dynamic pointer type"},
> +	{"not_valid_dynptr",
> +	 "arg#0 pointer type STRUCT bpf_dynptr_kern must be valid and
> initialized"},
> +	{"not_ptr_to_stack", "arg#0 pointer type STRUCT bpf_dynptr_kern
> not to stack"},
> +};
> +
> +static bool kfunc_not_supported;
> +
> +static int libbpf_print_cb(enum libbpf_print_level level, const char
> *fmt,
> +			   va_list args)
> +{
> +	if (strcmp(fmt, "libbpf: extern (func ksym) '%s': not found in
> kernel or module BTFs\n"))
> +		return 0;
> +
> +	if (strcmp(va_arg(args, char *), "bpf_verify_pkcs7_signature"))
> +		return 0;
> +
> +	kfunc_not_supported = true;
> +	return 0;
> +}
> +
> +static void verify_fail(const char *prog_name, const char
> *expected_err_msg)
> +{
> +	struct test_kfunc_dynptr_param *skel;
> +	LIBBPF_OPTS(bpf_object_open_opts, opts);
> +	libbpf_print_fn_t old_print_cb;
> +	struct bpf_program *prog;
> +	int err;
> +
> +	opts.kernel_log_buf = obj_log_buf;
> +	opts.kernel_log_size = log_buf_sz;
> +	opts.kernel_log_level = 1;
> +
> +	skel = test_kfunc_dynptr_param__open_opts(&opts);
> +	if (!ASSERT_OK_PTR(skel, "test_kfunc_dynptr_param__open_opts"))
> +		goto cleanup;
> +
> +	prog = bpf_object__find_program_by_name(skel->obj, prog_name);
> +	if (!ASSERT_OK_PTR(prog, "bpf_object__find_program_by_name"))
> +		goto cleanup;
> +
> +	bpf_program__set_autoload(prog, true);
> +
> +	bpf_map__set_max_entries(skel->maps.ringbuf, getpagesize());
> +
> +	kfunc_not_supported = false;
> +
> +	old_print_cb = libbpf_set_print(libbpf_print_cb);
> +	err = test_kfunc_dynptr_param__load(skel);
> +	libbpf_set_print(old_print_cb);
> +
> +	if (err < 0 && kfunc_not_supported) {
> +		fprintf(stderr,
> +		  "%s:SKIP:bpf_verify_pkcs7_signature() kfunc not
> supported\n",
> +		  __func__);
> +		test__skip();
> +		goto cleanup;
> +	}
> +
> +	if (!ASSERT_ERR(err, "unexpected load success"))
> +		goto cleanup;
> +
> +	if (!ASSERT_OK_PTR(strstr(obj_log_buf, expected_err_msg),
> "expected_err_msg")) {
> +		fprintf(stderr, "Expected err_msg: %s\n",
> expected_err_msg);
> +		fprintf(stderr, "Verifier output: %s\n", obj_log_buf);
> +	}
> +
> +cleanup:
> +	test_kfunc_dynptr_param__destroy(skel);
> +}
> +
> +void test_kfunc_dynptr_param(void)
> +{
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(kfunc_dynptr_tests); i++) {
> +		if
> (!test__start_subtest(kfunc_dynptr_tests[i].prog_name))
> +			continue;
> +
> +		verify_fail(kfunc_dynptr_tests[i].prog_name,
> +			    kfunc_dynptr_tests[i].expected_err_msg);
> +	}
> +}
> diff --git
> a/tools/testing/selftests/bpf/progs/test_kfunc_dynptr_param.c
> b/tools/testing/selftests/bpf/progs/test_kfunc_dynptr_param.c
> new file mode 100644
> index 000000000000..2f09f91a1576
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/test_kfunc_dynptr_param.c
> @@ -0,0 +1,57 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/*
> + * Copyright (C) 2022 Huawei Technologies Duesseldorf GmbH
> + *
> + * Author: Roberto Sassu <roberto.sassu@huawei.com>
> + */
> +
> +#include "vmlinux.h"
> +#include <errno.h>
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_tracing.h>
> +
> +struct bpf_dynptr {
> +	__u64 :64;
> +	__u64 :64;
> +} __attribute__((aligned(8)));
> +
> +extern int bpf_verify_pkcs7_signature(struct bpf_dynptr *data_ptr,
> +				      struct bpf_dynptr *sig_ptr,
> +				      struct bpf_key *trusted_keyring)
> __ksym;
> +
> +struct {
> +	__uint(type, BPF_MAP_TYPE_RINGBUF);
> +} ringbuf SEC(".maps");
> +
> +char _license[] SEC("license") = "GPL";
> +
> +SEC("?lsm.s/bpf")
> +int BPF_PROG(dynptr_type_not_supp, int cmd, union bpf_attr *attr,
> +	     unsigned int size)
> +{
> +	char write_data[64] = "hello there, world!!";
> +	struct bpf_dynptr ptr;
> +
> +	bpf_ringbuf_reserve_dynptr(&ringbuf, sizeof(write_data), 0,
> &ptr);
> +
> +	return bpf_verify_pkcs7_signature(&ptr, &ptr, NULL);
> +}
> +
> +SEC("?lsm.s/bpf")
> +int BPF_PROG(not_valid_dynptr, int cmd, union bpf_attr *attr,
> unsigned int size)
> +{
> +	unsigned long val;
> +
> +	return bpf_verify_pkcs7_signature((struct bpf_dynptr *)&val,
> +					  (struct bpf_dynptr *)&val,
> NULL);
> +}
> +
> +SEC("?lsm.s/bpf")
> +int BPF_PROG(not_ptr_to_stack, int cmd, union bpf_attr *attr,
> unsigned int size)
> +{
> +	unsigned long val;
> +
> +	return bpf_verify_pkcs7_signature((struct bpf_dynptr *)val,
> +					  (struct bpf_dynptr *)val,
> NULL);
> +}

