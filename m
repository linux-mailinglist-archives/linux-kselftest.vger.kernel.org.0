Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AADA55B3CA1
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Sep 2022 18:06:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231304AbiIIQGb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 9 Sep 2022 12:06:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230510AbiIIQGa (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 9 Sep 2022 12:06:30 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A99EB1282D5;
        Fri,  9 Sep 2022 09:06:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4F4C5B82584;
        Fri,  9 Sep 2022 16:06:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBAB3C4347C;
        Fri,  9 Sep 2022 16:06:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662739587;
        bh=axWEZR2AGhaBfThvLrSFA+NxQSVcKpOAZwv+H9dW4Nk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=iibSQJJ4qO0hADleXEMz2q8bsHl4E5kuxqbEW814lAtB6rTghQGxlaWLayEs9BxL6
         qWsyybTYDgORZqa6SMD8HdP43rhj1S8YjCOGM9LPqk1nIDUVt5ZuMgXhANuH88DKOX
         95BFN5MFwjwD9ElXZwnG8HK/hMlNHfBMh1T8AIl9UALOKwpDACprIwB3Q/uJMOMGK9
         sLu1xcTQkm+vu/dcD4ppCL5/l1YYFiqRqH8Y9AVLUdEQsy+oN4tgJUEMP1ZH820Oi4
         mIWgpb9JtuezcGS477Kc9vOF3tkLh6WKLFdEXRqhZCKemRhAoj+tFJ1fRKxhMvAKDS
         51qBZeIRP1V5g==
Received: by mail-ot1-f48.google.com with SMTP id 6-20020a9d0106000000b0063963134d04so1356595otu.3;
        Fri, 09 Sep 2022 09:06:26 -0700 (PDT)
X-Gm-Message-State: ACgBeo26VrXaTyec/izQJuIUnPTImjFNVOv1eFUaqESyTBoEi6C6AFcW
        0WgF/GpLpCB37EyxNemsswUpO/bndaY6iHRZCkY=
X-Google-Smtp-Source: AA6agR7gNcjRD/fchDqW/acEVY47PneSmF9ZfU3M+Ex1YMk2RVvQ+AETSXZH7W4vEnLR3dT4sV0ywAUAaVtWdc9Vjok=
X-Received: by 2002:a9d:7c94:0:b0:636:f74b:2364 with SMTP id
 q20-20020a9d7c94000000b00636f74b2364mr5594298otn.165.1662739586134; Fri, 09
 Sep 2022 09:06:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220909120736.1027040-1-roberto.sassu@huaweicloud.com> <20220909120736.1027040-8-roberto.sassu@huaweicloud.com>
In-Reply-To: <20220909120736.1027040-8-roberto.sassu@huaweicloud.com>
From:   Song Liu <song@kernel.org>
Date:   Fri, 9 Sep 2022 17:06:15 +0100
X-Gmail-Original-Message-ID: <CAPhsuW6zhrUJBfht7RCiUGWWCaWwpcjzAq-R4W-YmpU+YZyMXg@mail.gmail.com>
Message-ID: <CAPhsuW6zhrUJBfht7RCiUGWWCaWwpcjzAq-R4W-YmpU+YZyMXg@mail.gmail.com>
Subject: Re: [PATCH v17 07/12] bpf: Add bpf_verify_pkcs7_signature() kfunc
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>,
        David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, paul@paul-moore.com,
        jmorris@namei.org, serge@hallyn.com, Shuah Khan <shuah@kernel.org>,
        bpf <bpf@vger.kernel.org>, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Daniel_M=C3=BCller?= <deso@posteo.net>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Roberto Sassu <roberto.sassu@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Sep 9, 2022 at 1:09 PM Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
>
> From: Roberto Sassu <roberto.sassu@huawei.com>
>
> Add the bpf_verify_pkcs7_signature() kfunc, to give eBPF security modules
> the ability to check the validity of a signature against supplied data, by
> using user-provided or system-provided keys as trust anchor.
>
> The new kfunc makes it possible to enforce mandatory policies, as eBPF
> programs might be allowed to make security decisions only based on data
> sources the system administrator approves.
>
> The caller should provide the data to be verified and the signature as eBPF
> dynamic pointers (to minimize the number of parameters) and a bpf_key
> structure containing a reference to the keyring with keys trusted for
> signature verification, obtained from bpf_lookup_user_key() or
> bpf_lookup_system_key().
>
> For bpf_key structures obtained from the former lookup function,
> bpf_verify_pkcs7_signature() completes the permission check deferred by
> that function by calling key_validate(). key_task_permission() is already
> called by the PKCS#7 code.
>
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> Acked-by: KP Singh <kpsingh@kernel.org>

Acked-by: Song Liu <song@kernel.org>

[...]
