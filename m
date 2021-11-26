Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 106BD45F5FA
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Nov 2021 21:41:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238955AbhKZUoy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 26 Nov 2021 15:44:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231860AbhKZUmy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 26 Nov 2021 15:42:54 -0500
Received: from mail-vk1-xa34.google.com (mail-vk1-xa34.google.com [IPv6:2607:f8b0:4864:20::a34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94F0EC06175C
        for <linux-kselftest@vger.kernel.org>; Fri, 26 Nov 2021 12:36:36 -0800 (PST)
Received: by mail-vk1-xa34.google.com with SMTP id u68so6688603vke.11
        for <linux-kselftest@vger.kernel.org>; Fri, 26 Nov 2021 12:36:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TFS0HFFa3DF2mBq7mbNDhAUEHsq6tdnEc4bL+Qa6DAo=;
        b=sB677R+7siP73YQaUzij/Y16nHFk7kDMyLTPn2sUE/p+yn0lxsmOGgtqIlrWLPXq5l
         E4SgtZ3lo7QEwSeqOZHXKiAefJFBZQMqOvzuCvlN7hdiLKne+ndjPfaeKqN+MjzS0x2t
         wIkL6xSw+IMzVDyitDUWMmwt+dhKN4wxIAKEN26Zu3+n5ekdAijvZZRuLquOJlXCad9K
         YbOu5oRYMn9BZ9R/ObE7VX3prABrTeUZPV7VEjsBA6unQeA57vqnRJTqaw6JnhSYFBP0
         sJuQ1NkDaeUeEvxmxKPTx7AMo9Xy+vK0WuxnyuAcGeN65Wem+sQ43SHEJfu09qLcVmRm
         lKrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TFS0HFFa3DF2mBq7mbNDhAUEHsq6tdnEc4bL+Qa6DAo=;
        b=YBWtmWgAniJ9jHKo+u38OzUByhkF4+Sfvug86ZVrSoUUGMa50wGLCoNhdYCjjsIIEy
         xUBnIzI5rWvE/hgKz1D8J4H3a8sWbXdHSynSh3LGWDjL134sgwRGnymnZSK7jb5KBL38
         j/3ikSc2dMVqPyR7TcvjZ7XPCYsPOUc6qqTmtnlnGJhiXXno55wfZnhtBu1z86z9Jlx9
         b71VwANy6RsdLmy2OLhsouN5pUujMP9AAf1CzIFJiEkb/niNqB8fOntLICCAu8aWwZHV
         UlnzfUPa2wudDehyzTxA+K1hhWFExdcc06XjWX8VIDYKdqPgAg6fz13S2oAelueNOGZ8
         Ye9A==
X-Gm-Message-State: AOAM531X48VIb8jTdvge20sIvlRB/qQpci7a65CqJq5yR1T1EWpViMYw
        wHH93IxggSWoDTpfUti2lOyvWKZ6uWtIsUZqbiHH/w==
X-Google-Smtp-Source: ABdhPJy1Ry9bvIoqLWKjyr7uxvRb9zSPZNweFHhl21DQUT21sbAa6ndli5VfyOGAXaIGih4UMJ0aEvqRdsVvHvKGdvQ=
X-Received: by 2002:a05:6122:1813:: with SMTP id ay19mr22170144vkb.24.1637958995634;
 Fri, 26 Nov 2021 12:36:35 -0800 (PST)
MIME-Version: 1.0
References: <20211122192019.1277299-1-jean-philippe@linaro.org>
In-Reply-To: <20211122192019.1277299-1-jean-philippe@linaro.org>
From:   Quentin Monnet <quentin@isovalent.com>
Date:   Fri, 26 Nov 2021 20:36:24 +0000
Message-ID: <CACdoK4JWJRH0VuStA2N+xziTsC5d_ewuWpQEO2aHhVbsWuAq0g@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/6] tools/bpf: Enable cross-building with clang
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Shuah Khan <shuah@kernel.org>, nathan@kernel.org,
        ndesaulniers@google.com, Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, bpf <bpf@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, 22 Nov 2021 at 19:23, Jean-Philippe Brucker
<jean-philippe@linaro.org> wrote:
>
> Add support for cross-building BPF tools and selftests with clang, by
> passing LLVM=1 or CC=clang to make, as well as CROSS_COMPILE. A single
> clang toolchain can generate binaries for multiple architectures, so
> instead of having prefixes such as aarch64-linux-gnu-gcc, clang uses the
> -target parameter: `clang -target aarch64-linux-gnu'.
>
> Patch 1 adds the parameter in Makefile.include so tools can easily
> support this. Patch 2 prepares for the libbpf change from patch 3 (keep
> building resolve_btfids's libbpf in the host arch, when cross-building
> the kernel with clang). Patches 3-6 enable cross-building BPF tools with
> clang.

The set looks good to me. I checked that the tools are still building
(without cross-compiling). I currently have issues building the
selftests on my setup, but they don't appear to be related to this
patchset.

Acked-by: Quentin Monnet <quentin@isovalent.com>

Note that on bpf-next, patch 5 (runqslower) has a conflict with
be79505caf3f ("tools/runqslower: Install libbpf headers when
building").

Did you consider enabling cross-compiling for the BPF samples too? I'm
asking because the build system is pretty similar to the BPF tools.

Thanks,
Quentin
