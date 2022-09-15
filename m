Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9F595B9F6D
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Sep 2022 18:12:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbiIOQMH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 15 Sep 2022 12:12:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbiIOQMG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 15 Sep 2022 12:12:06 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 194A19AFF7
        for <linux-kselftest@vger.kernel.org>; Thu, 15 Sep 2022 09:12:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C665AB81C53
        for <linux-kselftest@vger.kernel.org>; Thu, 15 Sep 2022 16:12:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81614C433D7
        for <linux-kselftest@vger.kernel.org>; Thu, 15 Sep 2022 16:12:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663258322;
        bh=biii+7n43gDq9XV3lLWEwCgiBUcjGdS9pCCJ+UVSt80=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=KY92zLXe4muQeT1lP6R9O5WWgH7s5lQ+vChsWGQh8DGyYNJ6977AySX8t8+qdp7v3
         aLfeeEhEodnbotQKGT6sCZ6Drv8TMMhccqgAIWerpQs6aV6eQDUCEKuUL3Qi2k+wIT
         htRuqYdkNUN5O+PyusMCvjYSdy5m30dnl0szn8dppzVlJo5e9sPcKsJJQl2uPJfG/F
         u4qKF2QS8Tqzks05KCbYy7TNpHRciwFKTO7fqmillcE6nWWrJgq7woUJo09OJEasvV
         FUXY1Xlm6GUwumTZNgYKLh3w+i7EFTEqNW9bU7iV3G2XP/cq8BVnHW5h4lDXTwRQD4
         FGPpWinZS+7uw==
Received: by mail-ej1-f54.google.com with SMTP id l14so43275472eja.7
        for <linux-kselftest@vger.kernel.org>; Thu, 15 Sep 2022 09:12:02 -0700 (PDT)
X-Gm-Message-State: ACrzQf1YFgB669oD3qLvbvS0q8Jy/Eg0ztQzxfYCJBBoATxco71DPQGV
        ZNv2ZhJ6TycmU04wrBPV829msg1vcCAQvPvFIDcRbw==
X-Google-Smtp-Source: AMsMyM6A+1amQaBgdn6PNz6+7XLx4sQcOmwWWgNA8pV7010ZefQzIPoOFXBCHMTh3iKNuMgzYaiNCa6qWPB+3IVAEF8=
X-Received: by 2002:a17:906:9bd3:b0:778:c8e0:fcee with SMTP id
 de19-20020a1709069bd300b00778c8e0fceemr471268ejc.275.1663258310370; Thu, 15
 Sep 2022 09:11:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220909120736.1027040-1-roberto.sassu@huaweicloud.com> <20220909120736.1027040-12-roberto.sassu@huaweicloud.com>
In-Reply-To: <20220909120736.1027040-12-roberto.sassu@huaweicloud.com>
From:   KP Singh <kpsingh@kernel.org>
Date:   Thu, 15 Sep 2022 17:11:39 +0100
X-Gmail-Original-Message-ID: <CACYkzJ7uraUdmGV9gMmTZs1OMb_3Q2DttoaxU-irmrXFudOweQ@mail.gmail.com>
Message-ID: <CACYkzJ7uraUdmGV9gMmTZs1OMb_3Q2DttoaxU-irmrXFudOweQ@mail.gmail.com>
Subject: Re: [PATCH v17 11/12] selftests/bpf: Add test for bpf_verify_pkcs7_signature()
 kfunc
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, mykolal@fb.com, dhowells@redhat.com,
        jarkko@kernel.org, rostedt@goodmis.org, mingo@redhat.com,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
        shuah@kernel.org, bpf@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        deso@posteo.net, memxor@gmail.com,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Joanne Koong <joannelkoong@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Sep 9, 2022 at 1:10 PM Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
>
> From: Roberto Sassu <roberto.sassu@huawei.com>
>

[...]

> +}
> diff --git a/tools/testing/selftests/bpf/progs/test_verify_pkcs7_sig.c b/tools/testing/selftests/bpf/progs/test_verify_pkcs7_sig.c
> new file mode 100644
> index 000000000000..4ceab545d99a
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/test_verify_pkcs7_sig.c
> @@ -0,0 +1,100 @@
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
> +#define MAX_DATA_SIZE (1024 * 1024)
> +#define MAX_SIG_SIZE 1024
> +
> +typedef __u8 u8;
> +typedef __u16 u16;
> +typedef __u32 u32;
> +typedef __u64 u64;

I think you can avoid this and just use u32 and u64 directly.

> +
> +struct bpf_dynptr {
> +       __u64 :64;
> +       __u64 :64;
> +} __attribute__((aligned(8)));
> +

I think you are doing this because including the uapi headers causes
type conflicts.
This does happen quite often. What do other folks think about doing
something like

#define DYNPTR(x) ((void *)x)

It seems like this will be an issue anytime we use the helpers with
vmlinux.h and users
will always have to define this type in their tests.

- KP

> +extern struct bpf_key *bpf_lookup_user_key(__u32 serial, __u64 flags) __ksym;
> +extern struct bpf_key *bpf_lookup_system_key(__u64 id) __ksym;
> +extern void bpf_key_put(struct bpf_key *key) __ksym;
> +extern int bpf_verify_pkcs7_signature(struct bpf_dynptr *data_ptr,
> +                                     struct bpf_dynptr *sig_ptr,
> +                                     struct bpf_key *trusted_keyring) __ksym;
> +
> +u32 monitored_pid;
> +u32 user_keyring_serial;
> +u64 system_keyring_id;
> +
> +struct data {
> +       u8 data[MAX_DATA_SIZE];
> +       u32 data_len;
> +       u8 sig[MAX_SIG_SIZE];
> +       u32 sig_len;
> +};
> +
> +struct {
> +       __uint(type, BPF_MAP_TYPE_ARRAY);
> +       __uint(max_entries, 1);
> +       __type(key, __u32);
> +       __type(value, struct data);
> +} data_input SEC(".maps");
> +
> +char _license[] SEC("license") = "GPL";
> +
> +SEC("lsm.s/bpf")
> +int BPF_PROG(bpf, int cmd, union bpf_attr *attr, unsigned int size)
> +{
> +       struct bpf_dynptr data_ptr, sig_ptr;
> +       struct data *data_val;
> +       struct bpf_key *trusted_keyring;
> +       u32 pid;
> +       u64 value;
> +       int ret, zero = 0;
> +
> +       pid = bpf_get_current_pid_tgid() >> 32;
> +       if (pid != monitored_pid)
> +               return 0;
> +
> +       data_val = bpf_map_lookup_elem(&data_input, &zero);
> +       if (!data_val)
> +               return 0;
> +
> +       bpf_probe_read(&value, sizeof(value), &attr->value);
> +
> +       bpf_copy_from_user(data_val, sizeof(struct data),
>

[...]

> --
> 2.25.1
>
