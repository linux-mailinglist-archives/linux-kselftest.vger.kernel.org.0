Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B795863B99E
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Nov 2022 06:59:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235519AbiK2F7P (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 29 Nov 2022 00:59:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbiK2F7O (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 29 Nov 2022 00:59:14 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96E0F2983E;
        Mon, 28 Nov 2022 21:59:13 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id v8so18398119edi.3;
        Mon, 28 Nov 2022 21:59:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=A5R4C2aWexZsPArmjDH3ZXhc/nuP+Jv80yeRmE03+3Y=;
        b=NPoI5sGa4eoD7m3PZcImAedtV9zgPn92Xyvx4je/A8t6DqzT3qlSN47OfxkVDgRw4N
         Odm7gLkVMAucYLhuhhoqc1IUsQcF+HQFOTgcdhKG4R7OAYiL0rRMr9uWcnOR69LoQids
         H6X6RVicu5J/LXpCtZEzyRlxvxr05q41N5Ks1n1bV9pFsLz7tK3TxrqANVCYzU5mlDXv
         IzX5XhhNveW0oUpRv4fVGLFYl2W8tGQQYyImTePRKsH5L8lhX0YAZn62ChTREvo8ESzJ
         xckoCa7MMfTVq+XLKXI594Oq0TW3Zn6RwpIyMfAqMvGqasTYa6WyQHeg0IEDQ/5OOJnR
         Fn8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A5R4C2aWexZsPArmjDH3ZXhc/nuP+Jv80yeRmE03+3Y=;
        b=2ehHp70SIhQDwK8wdHZCSOuIUE84u7TzjnmZufVGG0z4YDKbBfrT+ZVIVPx1cMvCLP
         k+xJtTX04x7q8h2DgmSfJPZibIi4yJB0SabDt4H1qizMHap33AwJI45fC0dpT5Qr9StM
         gGu2D6Fi8W2+F/7D2o9zGy3KTqt6Qg7Rou6SzghMvVm/oBhMfPVDdT2+7QlKQ4uBLoiB
         mj76mE3J9vkkP+ODU4oj/P6+PfNzXGowW8KflyL9agCQRNNoQgrlMxOTc6tE7z9jQ5fi
         RrBBM4oUaU/iJrgvmKny9JC7mivCu9CRFv5LYp4T/AzQRn1DLWkU0la0UyOI6mrAI9tg
         a92A==
X-Gm-Message-State: ANoB5pkrUH1pkd9YwZBMTzPm4pI1NrjtqigiBoYFMkP33o2IcgTq468t
        QW96ZwpNb30taQPBXI1t5EReiffLbsfuGXrKMh8=
X-Google-Smtp-Source: AA0mqf61R1pxzPjXd65f/ntApUjrv3GpEO+onbJf191BTNPzrWYZEjQqYgMLUxzhCUoOsLN+wjyk2eU/3vf9wzG/ImY=
X-Received: by 2002:aa7:d80d:0:b0:46b:7645:86a9 with SMTP id
 v13-20020aa7d80d000000b0046b764586a9mr2395448edq.311.1669701552145; Mon, 28
 Nov 2022 21:59:12 -0800 (PST)
MIME-Version: 1.0
References: <20221126111147.199366-1-changbin.du@gmail.com> <20221126111147.199366-2-changbin.du@gmail.com>
In-Reply-To: <20221126111147.199366-2-changbin.du@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 28 Nov 2022 21:59:00 -0800
Message-ID: <CAEf4BzYt7MhKjWfdxKUe10mUxDoCYeWNHYr1-ruCxMEmNqJqqA@mail.gmail.com>
Subject: Re: [PATCH 1/2] libbpf: show more info about missing ".BTF" section
To:     Changbin Du <changbin.du@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Quentin Monnet <quentin@isovalent.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>,
        linux-perf-users@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Nov 26, 2022 at 3:13 AM Changbin Du <changbin.du@gmail.com> wrote:
>
> Show more information about why failed instead of just saying "No such file or
> directory".
>
> Now will print below info:
> libbpf: can not find '.BTF' section
> libbpf: is CONFIG_DEBUG_INFO_BTF enabled for kernel?
> Error: failed to load BTF from /home/changbin/work/linux/vmlinux: No such file or directory
>
> Signed-off-by: Changbin Du <changbin.du@gmail.com>
> ---
>  tools/lib/bpf/btf.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> index d88647da2c7f..3f661d991808 100644
> --- a/tools/lib/bpf/btf.c
> +++ b/tools/lib/bpf/btf.c
> @@ -906,6 +906,15 @@ struct btf *btf__new(const void *data, __u32 size)
>         return libbpf_ptr(btf_new(data, size, NULL));
>  }
>
> +static bool is_vmlinux(const char *path)
> +{
> +       size_t path_len = strlen(path);
> +       size_t suffix_len = strlen("vmlinux");
> +
> +       return (path_len >= suffix_len) &&
> +              (!memcmp(path + path_len - suffix_len, "vmlinux", suffix_len));
> +}
> +
>  static struct btf *btf_parse_elf(const char *path, struct btf *base_btf,
>                                  struct btf_ext **btf_ext)
>  {
> @@ -990,6 +999,9 @@ static struct btf *btf_parse_elf(const char *path, struct btf *base_btf,
>         err = 0;
>
>         if (!btf_data) {
> +               pr_warn("can not find '%s' section\n", BTF_ELF_SEC);
> +               if (is_vmlinux(path))
> +                       pr_warn("is CONFIG_DEBUG_INFO_BTF enabled for kernel?\n");

this is generic piece of BTF loading code in libbpf, it knows nothing
and should know nothing about vmlinux and CONFIG_DEBUG_INFO_BTF, this
is not the right place to add such suggestions.

Check bpf_object__load_vmlinux_btf(), libbpf emits vmlinux-specific
error there: "Error loading vmlinux BTF". If we need to mention
CONFIG_DEBUG_INFO_BTF anywhere, that would be the place to do that.

>                 err = -ENOENT;
>                 goto done;
>         }
> --
> 2.37.2
>
