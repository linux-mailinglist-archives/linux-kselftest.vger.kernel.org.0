Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A06F5A2090
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Aug 2022 07:57:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241505AbiHZF5C (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 26 Aug 2022 01:57:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230054AbiHZF5B (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 26 Aug 2022 01:57:01 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B230C5789;
        Thu, 25 Aug 2022 22:56:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7F5A6B82F5C;
        Fri, 26 Aug 2022 05:56:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43271C4314A;
        Fri, 26 Aug 2022 05:56:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661493417;
        bh=/FvktWWHz025DxZFW/BBwLRligmr0a9pBYK2MH9aV5Q=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=uCgUQCc/Qlk7Pi7/drdrT0yEzgE2IinbxX+THqgq2Tq5u0b5Kb6RL++DEn7XlDWwg
         pYwPj+IIOFPS9bL8SODw+FRZcnizjhFomi548R9lX+YLXdbaY748aaWkVEYjme6hG7
         kV5JeqS6f+G69EWtgP68/6H/Ms6Afj/30OGf33XPFhiV2cmSBuhN1aEjSHsCpT0drP
         A4TKWrBDUKKkmluFZHkgYrgNYwkRrR5UNov35B1g5xgEiQfZL3lzJpBdRBuTNvHqiy
         sSDyAl6KZkWo2fKpZ5mGp01B0TUS7PiXF0UcFhNmpv9xdEClFTjZzxL33z+aBOsBrF
         B3BComuHnQQ1A==
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-324ec5a9e97so11435067b3.7;
        Thu, 25 Aug 2022 22:56:57 -0700 (PDT)
X-Gm-Message-State: ACgBeo2JzkJT2fwEKc8wnwNdSGmoyvYPTovwp5l7/ioZTM8r830icmMW
        6wecUxg4jG/aJUqOolAfMhrP5TCQtqfLYbsFJg4=
X-Google-Smtp-Source: AA6agR5vlJNlo+eJot0Uf/IDkuELdfK6w7/mY1PtEAOjZwbYPWIA9NBIT4itd5TdjUSZY6bc90hWaEd9s8Kvg6BA5WU=
X-Received: by 2002:a81:7489:0:b0:33e:dca7:9750 with SMTP id
 p131-20020a817489000000b0033edca79750mr489448ywc.73.1661493416193; Thu, 25
 Aug 2022 22:56:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220823150035.711534-1-roberto.sassu@huaweicloud.com> <20220823150035.711534-6-roberto.sassu@huaweicloud.com>
In-Reply-To: <20220823150035.711534-6-roberto.sassu@huaweicloud.com>
From:   Song Liu <song@kernel.org>
Date:   Thu, 25 Aug 2022 22:56:45 -0700
X-Gmail-Original-Message-ID: <CAPhsuW5iVRSCQsMRC7bGHw=ZHW1Y7y0SccQG-i-7=umHF2yJEQ@mail.gmail.com>
Message-ID: <CAPhsuW5iVRSCQsMRC7bGHw=ZHW1Y7y0SccQG-i-7=umHF2yJEQ@mail.gmail.com>
Subject: Re: [PATCH v13 05/10] bpf: Add bpf_lookup_*_key() and bpf_key_put() kfuncs
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
        Jonathan Corbet <corbet@lwn.net>,
        David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, paul@paul-moore.com,
        jmorris@namei.org, serge@hallyn.com, Shuah Khan <shuah@kernel.org>,
        bpf <bpf@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Daniel_M=C3=BCller?= <deso@posteo.net>,
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

On Tue, Aug 23, 2022 at 8:02 AM Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
>
> From: Roberto Sassu <roberto.sassu@huawei.com>
>
> Add the bpf_lookup_user_key(), bpf_lookup_system_key() and bpf_key_put()
> kfuncs, to respectively search a key with a given key handle serial number
> and flags, obtain a key from a pre-determined ID defined in
> include/linux/verification.h, and cleanup.
>
> Introduce system_keyring_id_check() to validate the keyring ID parameter of
> bpf_lookup_system_key().
>
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---
>  include/linux/bpf.h          |   6 ++
>  include/linux/verification.h |   8 +++
>  kernel/trace/bpf_trace.c     | 135 +++++++++++++++++++++++++++++++++++
>  3 files changed, 149 insertions(+)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 6041304b402e..991da09a5858 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -2586,4 +2586,10 @@ static inline void bpf_cgroup_atype_get(u32 attach_btf_id, int cgroup_atype) {}
>  static inline void bpf_cgroup_atype_put(int cgroup_atype) {}
>  #endif /* CONFIG_BPF_LSM */
>
> +#ifdef CONFIG_KEYS

Do we need to declare struct key here?

> +struct bpf_key {
> +       struct key *key;
> +       bool has_ref;
> +};
> +#endif /* CONFIG_KEYS */
>  #endif /* _LINUX_BPF_H */
>
