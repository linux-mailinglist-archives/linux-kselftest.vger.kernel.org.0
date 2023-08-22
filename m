Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71CFC784B71
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Aug 2023 22:34:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230391AbjHVUeL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 22 Aug 2023 16:34:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230348AbjHVUeL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 22 Aug 2023 16:34:11 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 779E3CFC
        for <linux-kselftest@vger.kernel.org>; Tue, 22 Aug 2023 13:34:08 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-51cff235226so10124210a12.0
        for <linux-kselftest@vger.kernel.org>; Tue, 22 Aug 2023 13:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692736446; x=1693341246;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=q+1hpk+zIGq7829PqmAqIamjnmavQ0nqrtYhNbK5hcI=;
        b=5iuEpC5klS8KNuSvePxVlp+wSR9n6kjssr2yYX93DakJYbpX8HVgRLjUxAeI417tra
         /YypJi8GMTIEq6S2R6spC6wbvH2yKikM1/skaPuaR5Z5MkYNzEBSnTiDQ0Ej3/a4DgYr
         4ddgW7NbExlqhcoirKmVMU5GNvlCDyQdxaXHoG9dcmFMZorcdT9l1f4haN4mwteSk65w
         mgBStSLj3xV0R4uaDsN5pg2rO6+qTmWv5GK5P2ypxOOKlx4c2vFZrLfpmd0juN4Im6p6
         l7zUkCLO915TN+GMj+Q+JlmrnBgJ5vFaKSIW3txG5HGuGzCNDUQWJBxuOlUVzQGRi/CK
         8R8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692736446; x=1693341246;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q+1hpk+zIGq7829PqmAqIamjnmavQ0nqrtYhNbK5hcI=;
        b=flAA6MSoqKQzxS9dlAKinmXTeeWGuQrjN5nOdnIsY+LyyJUdb7DUJrEWh4BmoDl0p5
         ACPZgaruA/iAOo4o7LuMv7ncXQYi7ZCYgEGS4cWeg1+d3E5sODKvR2MUXUo0FIaZ+MrF
         M61HmWCJDIUIgbLDjg+HnZaotX+i3T/4evrrpZlAC3+jSGGRVrWTgr7ppIpob7oO0oQv
         KG2ARmVrmfdaFSjWJA3dae3vvQZFfiKynYlGCkAl6iIxUfQlSmEtdQrSOL6zagia9Fcd
         3NnFsSNPZorycPAwwzY64Rwu6lJ9jYrkHfCbH4esrI4C7Ka2szb/TNRBecFDouMDTSLa
         vTCQ==
X-Gm-Message-State: AOJu0YzhxawhOHUILS1EOKLYkCfd6cTmTG7gVoS2yvo78fOJXWpGEnKk
        2l+Ldz0XUUvpuyJfkOCeMDq+6d6dWmIH4Lqhok9mmbU52wrC5Z/sZ4UUrw==
X-Google-Smtp-Source: AGHT+IEJnr3fnhA0KmPoQVLzh5rEqOubxjBouZBE0y/39+iYjKH02l32TcXwYRzNrUWXeYi/zstpCKqeEFJj+DTrclI=
X-Received: by 2002:a05:6402:524b:b0:522:28b9:e84c with SMTP id
 t11-20020a056402524b00b0052228b9e84cmr11816533edd.21.1692736446457; Tue, 22
 Aug 2023 13:34:06 -0700 (PDT)
MIME-Version: 1.0
From:   Justin Stitt <justinstitt@google.com>
Date:   Tue, 22 Aug 2023 13:33:53 -0700
Message-ID: <CAFhGd8ryUcu2yPC+dFyDKNuVFHxT-=iayG+n2iErotBxgd0FVw@mail.gmail.com>
Subject: selftests: hid: trouble building with clang due to missing header
To:     linux-kselftest@vger.kernel.org
Cc:     bpf@vger.kernel.org, linux-input@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi, I'd like to get some help with building the kselftest target.

I am running into some warnings within the hid tree:
| progs/hid_bpf_helpers.h:9:38: error: declaration of 'struct
hid_bpf_ctx' will \
|       not be visible outside of this function [-Werror,-Wvisibility]
|     9 | extern __u8 *hid_bpf_get_data(struct hid_bpf_ctx *ctx,
|       |                                      ^
| progs/hid.c:23:35: error: incompatible pointer types passing 'struct
hid_bpf_ctx *' \
|       to parameter of type 'struct hid_bpf_ctx *'
[-Werror,-Wincompatible-pointer-types]
|    23 |         __u8 *rw_data = hid_bpf_get_data(hid_ctx, 0 /*
offset */, 3 /* size */);

This warning, amongst others, is due to some symbol not being included.
In this case, `struct hid_bpf_ctx` is not being defined anywhere that I
can see inside of the testing tree itself.

Instead, `struct hid_bpf_ctx` is defined and implemented at
`include/linux/hid_bpf.h`. AFAIK, I cannot just include this header as
the tools directory is a separate entity from kbuild and these tests are
meant to be built/ran without relying on kernel headers. Am I correct in
this assumption? At any rate, the include itself doesn't work. How can I
properly include this struct definition and fix the warning(s)?

Please note that we cannot just forward declare the struct as it is
being dereferenced and would then yield a completely different
error/warning for an incomplete type. We need the entire implementation
for the struct included.

Other symbols also defined in `include/linux/hid_bpf.h` that we need are
`struct hid_report_type` and `HID_BPF_FLAG...`

Here's the invocation I am running to build kselftest:
`$ make LLVM=1 ARCH=x86_64 mrproper headers && make LLVM=1 ARCH=x86_64
-j128 V=1 -C tools/testing/selftests`

If anyone is currently getting clean builds of kselftest with clang,
what invocation works for you?



Link: https://github.com/ClangBuiltLinux/linux/issues/1698
Full-build-log:
https://gist.github.com/JustinStitt/b217f6e47c1d762e5e1cc6c3532f1bbb
(V=1)

Thanks.
Justin
