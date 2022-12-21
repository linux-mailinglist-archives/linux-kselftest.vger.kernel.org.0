Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 340AC6536CE
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Dec 2022 20:07:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232786AbiLUTHm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 21 Dec 2022 14:07:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiLUTHl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 21 Dec 2022 14:07:41 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A3CB21800
        for <linux-kselftest@vger.kernel.org>; Wed, 21 Dec 2022 11:07:39 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id h2-20020a170902f54200b0018e56572a4eso11713086plf.9
        for <linux-kselftest@vger.kernel.org>; Wed, 21 Dec 2022 11:07:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FuHaksFWfmzvX/0UcFQCgtayWDVlA975ayg4IySh6xU=;
        b=BkDw4UUzBfCiXj8kHMlNPB7j8MqI8B8JKZhzddUdlC9YhXFpxhXgIOHWgwN79k8qoP
         NXJ55BhukivabsqHxkEz3n4AGQ1/QLSIQzsLnnNoKXPRT/KjwkpxoqJ8xRGUdJmspZX7
         RyHqPDo7GJzthBPB05auY+JiRJzJRtvZtTTxwbpvGw5ahokR03xAj6teBIrUZBZnVmSM
         3XAKXZBU0f8kLtMIWY15oKGeoKY7kyWJcKQhaJSpPfwokABNqYL+qSfHkt+AF4qpevQk
         02hOXbQatSoRrYlu6+fVui5CzAPSsAEP4lSPyG9v/RF3ANO/HtAscNmF6BCz5R2U1W68
         nRLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FuHaksFWfmzvX/0UcFQCgtayWDVlA975ayg4IySh6xU=;
        b=7pYYDwZ7mw55b2kLDqrj4x6bqB4dai0ptNUhuIaF7ndfpFU4TZC3bIz1X9OoIzYOPv
         gZYWnAIZI+J+SlPljnbD8hu0CbnCvQsHcX3xco9NkcXeo842XhcvBfExV4roVAGd0rUh
         4WJ2c0CRTmk6D4LGBJB7qybb7kh8leGWztwNh5oqBxEY1FN/SFg9c/qfvHsDabSZJsMa
         ViqgR8RnpO/GM8a/l/On9t1H3+P+CxniI2rCYh78tpGEzsHxTvEDvycOTN4v4wk7IhVP
         KbtCCQeK4datvNsM9umF4hMOO4Qfsf/QGWZHiFbI/T5CfncKKGxbd+9I9zqYFNFZ5QGs
         TCoA==
X-Gm-Message-State: AFqh2kr4Np+I7dRDvACRdBHMESmC1t3VTsJyU9ed1BmxwGXVqUCsSART
        Dxf3dpvNBvPm6AHYkpnb2xM3CfA=
X-Google-Smtp-Source: AMrXdXt+ySJHbpwBcBFTpnKo3KORcNuqsBqsVtsZm5wl+3GzpFxTxgKl8VYETHw9dOg5iKk2exNzbNQ=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:90b:4fc3:b0:218:9893:9aa7 with SMTP id
 qa3-20020a17090b4fc300b0021898939aa7mr216143pjb.223.1671649658846; Wed, 21
 Dec 2022 11:07:38 -0800 (PST)
Date:   Wed, 21 Dec 2022 11:07:37 -0800
In-Reply-To: <20221221055856.2786043-1-james.hilliard1@gmail.com>
Mime-Version: 1.0
References: <20221221055856.2786043-1-james.hilliard1@gmail.com>
Message-ID: <Y6NZeY/YpbR3pdFM@google.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: move struct definitions out of
 function params
From:   sdf@google.com
To:     James Hilliard <james.hilliard1@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
        Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
        Shuah Khan <shuah@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Eduard Zingerman <eddyz87@gmail.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 12/20, James Hilliard wrote:
> Anonymous structs can't be declared inside function parameter
> definitions in current c standards, however clang doesn't detect this
> condition currently while GCC does.

> Details: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=108189

> Fixes errors like:
> progs/btf_dump_test_case_bitfields.c:85:7: error: anonymous struct  
> declared inside parameter list will not be visible outside of this  
> definition or declaration [-Werror]
>     85 | int f(struct {
>        |       ^~~~~~

> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

Acked-by: Stanislav Fomichev <sdf@google.com>

Looking at the referenced thread, seems like it requires at lest C23
and I doubt default clang is using that; so seems fine to be pedantic
here and move the definitions out.

> ---
>   .../bpf/progs/btf_dump_test_case_bitfields.c  |  9 ++++--
>   .../progs/btf_dump_test_case_namespacing.c    | 10 ++++---
>   .../bpf/progs/btf_dump_test_case_packing.c    | 10 ++++---
>   .../bpf/progs/btf_dump_test_case_padding.c    | 10 ++++---
>   .../bpf/progs/btf_dump_test_case_syntax.c     | 30 +++++++++++++------
>   5 files changed, 46 insertions(+), 23 deletions(-)

> diff --git  
> a/tools/testing/selftests/bpf/progs/btf_dump_test_case_bitfields.c  
> b/tools/testing/selftests/bpf/progs/btf_dump_test_case_bitfields.c
> index e01690618e1e..c75f6bd06a49 100644
> --- a/tools/testing/selftests/bpf/progs/btf_dump_test_case_bitfields.c
> +++ b/tools/testing/selftests/bpf/progs/btf_dump_test_case_bitfields.c
> @@ -82,11 +82,16 @@ struct bitfield_flushed {
>   	long b: 16;
>   };

> -int f(struct {
> +/* ----- START-EXPECTED-OUTPUT ----- */
> +struct root_struct {
>   	struct bitfields_only_mixed_types _1;
>   	struct bitfield_mixed_with_others _2;
>   	struct bitfield_flushed _3;
> -} *_)
> +};
> +
> +/* ------ END-EXPECTED-OUTPUT ------ */
> +
> +int f(struct root_struct *_)
>   {
>   	return 0;
>   }
> diff --git  
> a/tools/testing/selftests/bpf/progs/btf_dump_test_case_namespacing.c  
> b/tools/testing/selftests/bpf/progs/btf_dump_test_case_namespacing.c
> index 92a4ad428710..d7cf2a8487c9 100644
> --- a/tools/testing/selftests/bpf/progs/btf_dump_test_case_namespacing.c
> +++ b/tools/testing/selftests/bpf/progs/btf_dump_test_case_namespacing.c
> @@ -49,9 +49,7 @@ typedef int Y;

>   typedef int Z;

> -/*------ END-EXPECTED-OUTPUT ------ */
> -
> -int f(struct {
> +struct root_struct {
>   	struct S _1;
>   	S _2;
>   	union U _3;
> @@ -67,7 +65,11 @@ int f(struct {
>   	X xx;
>   	Y yy;
>   	Z zz;
> -} *_)
> +};
> +
> +/*------ END-EXPECTED-OUTPUT ------ */
> +
> +int f(struct root_struct *_)
>   {
>   	return 0;
>   }
> diff --git  
> a/tools/testing/selftests/bpf/progs/btf_dump_test_case_packing.c  
> b/tools/testing/selftests/bpf/progs/btf_dump_test_case_packing.c
> index 7998f27df7dd..e039ceb50c43 100644
> --- a/tools/testing/selftests/bpf/progs/btf_dump_test_case_packing.c
> +++ b/tools/testing/selftests/bpf/progs/btf_dump_test_case_packing.c
> @@ -132,9 +132,7 @@ struct outer_packed_struct {
>   	struct nested_packed_struct b;
>   } __attribute__((packed));

> -/* ------ END-EXPECTED-OUTPUT ------ */
> -
> -int f(struct {
> +struct root_struct {
>   	struct packed_trailing_space _1;
>   	struct non_packed_trailing_space _2;
>   	struct packed_fields _3;
> @@ -147,7 +145,11 @@ int f(struct {
>   	struct usb_host_endpoint _10;
>   	struct outer_nonpacked_struct _11;
>   	struct outer_packed_struct _12;
> -} *_)
> +};
> +
> +/* ------ END-EXPECTED-OUTPUT ------ */
> +
> +int f(struct root_struct *_)
>   {
>   	return 0;
>   }
> diff --git  
> a/tools/testing/selftests/bpf/progs/btf_dump_test_case_padding.c  
> b/tools/testing/selftests/bpf/progs/btf_dump_test_case_padding.c
> index 79276fbe454a..2ca46ad8d66a 100644
> --- a/tools/testing/selftests/bpf/progs/btf_dump_test_case_padding.c
> +++ b/tools/testing/selftests/bpf/progs/btf_dump_test_case_padding.c
> @@ -220,9 +220,7 @@ struct outer_mixed_but_unpacked {
>   	struct nested_packed b2;
>   };

> -/* ------ END-EXPECTED-OUTPUT ------ */
> -
> -int f(struct {
> +struct root_struct {
>   	struct padded_implicitly _1;
>   	struct padded_explicitly _2;
>   	struct padded_a_lot _3;
> @@ -243,7 +241,11 @@ int f(struct {
>   	struct ib_wc _201;
>   	struct acpi_object_method _202;
>   	struct outer_mixed_but_unpacked _203;
> -} *_)
> +} __attribute__((packed));
> +
> +/* ------ END-EXPECTED-OUTPUT ------ */
> +
> +int f(struct root_struct *_)
>   {
>   	return 0;
>   }
> diff --git  
> a/tools/testing/selftests/bpf/progs/btf_dump_test_case_syntax.c  
> b/tools/testing/selftests/bpf/progs/btf_dump_test_case_syntax.c
> index 26fffb02ed10..3e31df7cecc6 100644
> --- a/tools/testing/selftests/bpf/progs/btf_dump_test_case_syntax.c
> +++ b/tools/testing/selftests/bpf/progs/btf_dump_test_case_syntax.c
> @@ -104,24 +104,24 @@ typedef void (*printf_fn_t)(const char *, ...);
>    *   typedef const fn_output_inner_t fn_ptr_arr2_t[5];
>    */
>   /* ----- START-EXPECTED-OUTPUT ----- */
> -typedef char * const * (*fn_ptr2_t)(struct {
> -	int a;
> -}, int (*)(int));
> +struct struct_a;
> +
> +typedef char * const * (*fn_ptr2_t)(struct struct_a, int (*)(int));
> +
> +struct struct_c;
> +
> +struct struct_h;

>   typedef struct {
>   	int a;
> -	void (*b)(int, struct {
> -		int c;
> -	}, union {
> +	void (*b)(int, struct struct_c, union {
>   		char d;
>   		int e[5];
>   	});
>   } (*fn_complex_t)(union {
>   	void *f;
>   	char g[16];
> -}, struct {
> -	int h;
> -});
> +}, struct struct_h);

>   typedef void (* (*signal_t)(int, void (*)(int)))(int);

> @@ -272,6 +272,18 @@ struct root_struct {
>   	struct float_struct _15;
>   };

> +struct struct_a {
> +	int a;
> +};
> +
> +struct struct_h {
> +	int h;
> +};
> +
> +struct struct_c {
> +	int c;
> +};
> +
>   /* ------ END-EXPECTED-OUTPUT ------ */

>   int f(struct root_struct *s)
> --
> 2.34.1

