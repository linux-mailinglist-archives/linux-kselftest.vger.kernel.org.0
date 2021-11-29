Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3021946289A
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Nov 2021 00:51:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233134AbhK2Xyg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 29 Nov 2021 18:54:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233148AbhK2Xyg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 29 Nov 2021 18:54:36 -0500
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 227B4C061714;
        Mon, 29 Nov 2021 15:51:18 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id v203so47157841ybe.6;
        Mon, 29 Nov 2021 15:51:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l7Mp/d6Rqmx/LRmJ5y1bc/kVe95zOiVJ5beMB8pxyLE=;
        b=j8OyLd7WUyHnCqZgxAHtSFGz5+Km4xZtxVyoPrepgt7SGdsw4c3GrNLK2KIY3x7lf2
         M1/tyM4i6ihC84jcEsnYoaRTkuL8QEYU2nEoLjF5lrOX6sP+JWNxsOplFuB9Q5a81Tei
         JBZUxJ0QKv4t/hLUbi+1VZJoBFbhZO+iUv5vhb0h9FrNgviSe0CibK4JttaqVGh90N3A
         WVtiZI+9gX7tcLY0enGqsewMTZ+bmfiNXCsMv86ccyYeRQKtAPY7t3KzeQtqDLkjwUK+
         BvaWGuUBm6J1TtP0uk46Z6sSIIOwaODThwwsU6g/53xivsfOsmwS8V3giUyUhsXfQglc
         /vUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l7Mp/d6Rqmx/LRmJ5y1bc/kVe95zOiVJ5beMB8pxyLE=;
        b=CxXSnY75Wya3RHdxzK4BgTCi43dkhLaFLrsHIHg+k+Xrb7/uXmenkKbFCgrJEunKkq
         jSVnt99NHbxb4Clxtk0PlHDTNfFZshvIvh/OiW0iTBntePJkHRQOv24VhvcxiIkSm1dv
         Pwy60+Eup17E1erUPW9O/6wBayFdhLkOapvH5cAEZffYNDqFLUrNoK7VLCiJe07lfZcf
         A+T4XoUzUHAZJ+pw5E4UJCxIIyXQBcQtvM0Zxqxy7cqVkcMLx9lE1A08r1PWqiUb4VNo
         159waABLRY//oNYJsajscKWMXh25AJBo68TmBgPBFQkvm9/ZIeJ+jY80EVDhN6i5ag++
         nPug==
X-Gm-Message-State: AOAM530aFPAXdasdH7zd/v+0mAn1ow+8SbmUysklVRDb//+iNooaJNjE
        5BjVcDO5rXptoigQaH4LcQpecngo2bG416NwYuQ=
X-Google-Smtp-Source: ABdhPJwX81cDy3z4JXfLLsmO+XgVE9RTxTxaZ1TEENhIP4OzNX5qEis71t77WGOnNYYUG6A7Po0ir83tHv32XJB2Afw=
X-Received: by 2002:a05:6902:1006:: with SMTP id w6mr39165243ybt.252.1638229877383;
 Mon, 29 Nov 2021 15:51:17 -0800 (PST)
MIME-Version: 1.0
References: <20211122192019.1277299-1-jean-philippe@linaro.org> <20211122192019.1277299-4-jean-philippe@linaro.org>
In-Reply-To: <20211122192019.1277299-4-jean-philippe@linaro.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 29 Nov 2021 15:51:06 -0800
Message-ID: <CAEf4BzYgeNQXHq2sWR1b2FNs6fC=FOQjxdNdtFVf5+-4Fory+g@mail.gmail.com>
Subject: Re: [PATCH bpf-next 3/6] tools/libbpf: Enable cross-building with clang
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Martin Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
        Yonghong Song <yhs@fb.com>,
        john fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, bpf <bpf@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Nov 22, 2021 at 11:24 AM Jean-Philippe Brucker
<jean-philippe@linaro.org> wrote:
>
> Cross-building using clang requires passing the "-target" flag rather
> than using the CROSS_COMPILE prefix. Makefile.include transforms
> CROSS_COMPILE into CLANG_CROSS_FLAGS. Add them to the CFLAGS.
>
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> ---
>  tools/lib/bpf/Makefile | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/tools/lib/bpf/Makefile b/tools/lib/bpf/Makefile
> index 5f7086fae31c..fe9201862aed 100644
> --- a/tools/lib/bpf/Makefile
> +++ b/tools/lib/bpf/Makefile
> @@ -90,6 +90,7 @@ override CFLAGS += -Werror -Wall
>  override CFLAGS += $(INCLUDES)
>  override CFLAGS += -fvisibility=hidden
>  override CFLAGS += -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=64
> +override CFLAGS += $(CLANG_CROSS_FLAGS)
>
>  # flags specific for shared library
>  SHLIB_FLAGS := -DSHARED -fPIC
> @@ -162,7 +163,7 @@ $(BPF_HELPER_DEFS): $(srctree)/tools/include/uapi/linux/bpf.h
>  $(OUTPUT)libbpf.so: $(OUTPUT)libbpf.so.$(LIBBPF_VERSION)
>
>  $(OUTPUT)libbpf.so.$(LIBBPF_VERSION): $(BPF_IN_SHARED) $(VERSION_SCRIPT)
> -       $(QUIET_LINK)$(CC) $(LDFLAGS) \
> +       $(QUIET_LINK)$(CC) $(CLANG_CROSS_FLAGS) $(LDFLAGS) \

I haven't checked, but what would happen if we just use $(CFLAGS)
here? Would it still work?

>                 --shared -Wl,-soname,libbpf.so.$(LIBBPF_MAJOR_VERSION) \
>                 -Wl,--version-script=$(VERSION_SCRIPT) $< -lelf -lz -o $@
>         @ln -sf $(@F) $(OUTPUT)libbpf.so
> --
> 2.33.1
>
