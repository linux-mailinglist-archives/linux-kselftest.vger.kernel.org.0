Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 961EF5AE2AB
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Sep 2022 10:32:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238819AbiIFIcB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 6 Sep 2022 04:32:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238870AbiIFIbl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 6 Sep 2022 04:31:41 -0400
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 943E777562;
        Tue,  6 Sep 2022 01:31:06 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.227])
        by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4MMJQT3HlTz9xtV6;
        Tue,  6 Sep 2022 16:26:57 +0800 (CST)
Received: from roberto-ThinkStation-P620 (unknown [10.204.63.22])
        by APP1 (Coremail) with SMTP id LxC2BwAnH5MeBRdj+U8nAA--.38178S2;
        Tue, 06 Sep 2022 09:30:36 +0100 (CET)
Message-ID: <c723f4fd42163e0a701c94e3002127170c5590aa.camel@huaweicloud.com>
Subject: Re: [PATCH v16 12/12] selftests/bpf: Add tests for dynamic pointers
 parameters in kfuncs
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, mykolal@fb.com,
        dhowells@redhat.com, jarkko@kernel.org, rostedt@goodmis.org,
        mingo@redhat.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, shuah@kernel.org, bpf@vger.kernel.org,
        keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        deso@posteo.net, Roberto Sassu <roberto.sassu@huawei.com>
Date:   Tue, 06 Sep 2022 10:30:19 +0200
In-Reply-To: <CAP01T750hFZbHdRTzSSeWpc95Omp2-PLmOojhMohFGJD=yrTzg@mail.gmail.com>
References: <20220905143318.1592015-1-roberto.sassu@huaweicloud.com>
         <20220905143318.1592015-13-roberto.sassu@huaweicloud.com>
         <CAP01T750hFZbHdRTzSSeWpc95Omp2-PLmOojhMohFGJD=yrTzg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: LxC2BwAnH5MeBRdj+U8nAA--.38178S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Ar4rKF1rWw47Cr17Gw47CFg_yoW3Wr15pa
        y8GFyj9rWIqF1fJr13XFsruF4ftr48Zr12krZxta4xAr1qvr93uF18KrW3Wwn5K395Ww4Y
        v34Sqrs3uw4UJa7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkFb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6r1S6rWUM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28IcxkI
        7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxV
        Cjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY
        6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6x
        AIw20EY4v20xvaj40_Wr1j6rW3Jr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280
        aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07UAkuxUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAHBF1jj4Km7QAAs6
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, 2022-09-06 at 05:15 +0200, Kumar Kartikeya Dwivedi wrote:
> On Mon, 5 Sept 2022 at 16:36, Roberto Sassu
> <roberto.sassu@huaweicloud.com> wrote:
> > From: Roberto Sassu <roberto.sassu@huawei.com>
> > 
> > Add tests to ensure that only supported dynamic pointer types are
> > accepted,
> > that the passed argument is actually a dynamic pointer, and that
> > the passed
> > argument is a pointer to the stack.
> > 
> > The tests are currently in the deny list for s390x (JIT does not
> > support
> > calling kernel function).
> > 
> > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > ---
> >  tools/testing/selftests/bpf/DENYLIST.s390x    |   1 +
> >  .../bpf/prog_tests/kfunc_dynptr_param.c       | 103
> > ++++++++++++++++++
> >  .../bpf/progs/test_kfunc_dynptr_param.c       |  57 ++++++++++
> >  3 files changed, 161 insertions(+)
> >  create mode 100644
> > tools/testing/selftests/bpf/prog_tests/kfunc_dynptr_param.c
> >  create mode 100644
> > tools/testing/selftests/bpf/progs/test_kfunc_dynptr_param.c
> > 
> > diff --git a/tools/testing/selftests/bpf/DENYLIST.s390x
> > b/tools/testing/selftests/bpf/DENYLIST.s390x
> > index 4e305baa5277..9a6dc3671c65 100644
> > --- a/tools/testing/selftests/bpf/DENYLIST.s390x
> > +++ b/tools/testing/selftests/bpf/DENYLIST.s390x
> > @@ -71,3 +71,4 @@ cgroup_hierarchical_stats                # JIT
> > does not support calling kernel f
> >  htab_update                              # failed to attach:
> > ERROR: strerror_r(-
> > 524)=22                                (trampoline)
> >  lookup_key                               # JIT does not support
> > calling kernel function                                (kfunc)
> >  verify_pkcs7_sig                         # JIT does not support
> > calling kernel function                                (kfunc)
> > +kfunc_dynptr_param                       # JIT does not support
> > calling kernel function                                (kfunc)
> > diff --git
> > a/tools/testing/selftests/bpf/prog_tests/kfunc_dynptr_param.c
> > b/tools/testing/selftests/bpf/prog_tests/kfunc_dynptr_param.c
> > new file mode 100644
> > index 000000000000..ea655a5c9d8b
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/prog_tests/kfunc_dynptr_param.c
> > @@ -0,0 +1,103 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +/*
> > + * Copyright (c) 2022 Facebook
> > + * Copyright (C) 2022 Huawei Technologies Duesseldorf GmbH
> > + *
> > + * Author: Roberto Sassu <roberto.sassu@huawei.com>
> > + */
> > +
> > +#include <test_progs.h>
> > +#include "test_kfunc_dynptr_param.skel.h"
> > +
> > +static size_t log_buf_sz = 1048576; /* 1 MB */
> > +static char obj_log_buf[1048576];
> > +
> > +static struct {
> > +       const char *prog_name;
> > +       const char *expected_err_msg;
> > +} kfunc_dynptr_tests[] = {
> > +       {"dynptr_type_not_supp",
> > +        "arg#0 pointer type STRUCT bpf_dynptr_kern points to
> > unsupported dynamic pointer type"},
> > +       {"not_valid_dynptr",
> > +        "arg#0 pointer type STRUCT bpf_dynptr_kern must be valid
> > and initialized"},
> > +       {"not_ptr_to_stack", "arg#0 pointer type STRUCT
> > bpf_dynptr_kern not to stack"},
> > +};
> > +
> > +static bool kfunc_not_supported;
> > +
> > +static int libbpf_print_cb(enum libbpf_print_level level, const
> > char *fmt,
> > +                          va_list args)
> > +{
> > +       if (strcmp(fmt, "libbpf: extern (func ksym) '%s': not found
> > in kernel or module BTFs\n"))
> > +               return 0;
> > +
> > +       if (strcmp(va_arg(args, char *),
> > "bpf_verify_pkcs7_signature"))
> > +               return 0;
> > +
> > +       kfunc_not_supported = true;
> > +       return 0;
> > +}
> > +
> > +static void verify_fail(const char *prog_name, const char
> > *expected_err_msg)
> > +{
> > +       struct test_kfunc_dynptr_param *skel;
> > +       LIBBPF_OPTS(bpf_object_open_opts, opts);
> > +       libbpf_print_fn_t old_print_cb;
> > +       struct bpf_program *prog;
> > +       int err;
> > +
> > +       opts.kernel_log_buf = obj_log_buf;
> > +       opts.kernel_log_size = log_buf_sz;
> > +       opts.kernel_log_level = 1;
> > +
> > +       skel = test_kfunc_dynptr_param__open_opts(&opts);
> > +       if (!ASSERT_OK_PTR(skel,
> > "test_kfunc_dynptr_param__open_opts"))
> > +               goto cleanup;
> > +
> > +       prog = bpf_object__find_program_by_name(skel->obj,
> > prog_name);
> > +       if (!ASSERT_OK_PTR(prog,
> > "bpf_object__find_program_by_name"))
> > +               goto cleanup;
> > +
> > +       bpf_program__set_autoload(prog, true);
> > +
> > +       bpf_map__set_max_entries(skel->maps.ringbuf,
> > getpagesize());
> > +
> > +       kfunc_not_supported = false;
> > +
> > +       old_print_cb = libbpf_set_print(libbpf_print_cb);
> > +       err = test_kfunc_dynptr_param__load(skel);
> > +       libbpf_set_print(old_print_cb);
> > +
> > +       if (err < 0 && kfunc_not_supported) {
> > +               fprintf(stderr,
> > +                 "%s:SKIP:bpf_verify_pkcs7_signature() kfunc not
> > supported\n",
> > +                 __func__);
> > +               test__skip();
> > +               goto cleanup;
> > +       }
> > +
> > +       if (!ASSERT_ERR(err, "unexpected load success"))
> > +               goto cleanup;
> > +
> > +       if (!ASSERT_OK_PTR(strstr(obj_log_buf, expected_err_msg),
> > "expected_err_msg")) {
> > +               fprintf(stderr, "Expected err_msg: %s\n",
> > expected_err_msg);
> > +               fprintf(stderr, "Verifier output: %s\n",
> > obj_log_buf);
> > +       }
> > +
> > +cleanup:
> > +       test_kfunc_dynptr_param__destroy(skel);
> > +}
> > +
> > +void test_kfunc_dynptr_param(void)
> > +{
> > +       int i;
> > +
> > +       for (i = 0; i < ARRAY_SIZE(kfunc_dynptr_tests); i++) {
> > +               if
> > (!test__start_subtest(kfunc_dynptr_tests[i].prog_name))
> > +                       continue;
> > +
> > +               verify_fail(kfunc_dynptr_tests[i].prog_name,
> > +                           kfunc_dynptr_tests[i].expected_err_msg)
> > ;
> > +       }
> > +}
> > diff --git
> > a/tools/testing/selftests/bpf/progs/test_kfunc_dynptr_param.c
> > b/tools/testing/selftests/bpf/progs/test_kfunc_dynptr_param.c
> > new file mode 100644
> > index 000000000000..2f09f91a1576
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/progs/test_kfunc_dynptr_param.c
> > @@ -0,0 +1,57 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +/*
> > + * Copyright (C) 2022 Huawei Technologies Duesseldorf GmbH
> > + *
> > + * Author: Roberto Sassu <roberto.sassu@huawei.com>
> > + */
> > +
> > +#include "vmlinux.h"
> > +#include <errno.h>
> > +#include <bpf/bpf_helpers.h>
> > +#include <bpf/bpf_tracing.h>
> > +
> > +struct bpf_dynptr {
> > +       __u64 :64;
> > +       __u64 :64;
> > +} __attribute__((aligned(8)));
> > +
> > +extern int bpf_verify_pkcs7_signature(struct bpf_dynptr *data_ptr,
> > +                                     struct bpf_dynptr *sig_ptr,
> > +                                     struct bpf_key
> > *trusted_keyring) __ksym;
> > +
> > +struct {
> > +       __uint(type, BPF_MAP_TYPE_RINGBUF);
> > +} ringbuf SEC(".maps");
> > +
> > +char _license[] SEC("license") = "GPL";
> > +
> > +SEC("?lsm.s/bpf")
> > +int BPF_PROG(dynptr_type_not_supp, int cmd, union bpf_attr *attr,
> > +            unsigned int size)
> > +{
> > +       char write_data[64] = "hello there, world!!";
> > +       struct bpf_dynptr ptr;
> > +
> > +       bpf_ringbuf_reserve_dynptr(&ringbuf, sizeof(write_data), 0,
> > &ptr);
> > +
> > +       return bpf_verify_pkcs7_signature(&ptr, &ptr, NULL);
> > +}
> > +
> > +SEC("?lsm.s/bpf")
> > +int BPF_PROG(not_valid_dynptr, int cmd, union bpf_attr *attr,
> > unsigned int size)
> > +{
> > +       unsigned long val;
> > +
> > +       return bpf_verify_pkcs7_signature((struct bpf_dynptr
> > *)&val,
> > +                                         (struct bpf_dynptr
> > *)&val, NULL);
> > +}
> > +
> > +SEC("?lsm.s/bpf")
> > +int BPF_PROG(not_ptr_to_stack, int cmd, union bpf_attr *attr,
> > unsigned int size)
> > +{
> > +       unsigned long val;
> > +
> > +       return bpf_verify_pkcs7_signature((struct bpf_dynptr *)val,
> > +                                         (struct bpf_dynptr *)val,
> > NULL);
> 
> Please also include a test where you cause the dynptr to be set to
> NULL, e.g. by passing invalid stuff to ringbuf_reserve_dynptr, and
> then try to pass it to bpf_verify_pkc7_signature.

Uhm, bpf_ringbuf_reserve_dynptr() is expecting a valid map. How else I
can achieve it?

Thanks

Roberto

