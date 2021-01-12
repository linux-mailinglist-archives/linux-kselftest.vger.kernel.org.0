Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C76112F3D27
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Jan 2021 01:43:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406958AbhALVh1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 12 Jan 2021 16:37:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437084AbhALU6L (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 12 Jan 2021 15:58:11 -0500
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADF81C061786;
        Tue, 12 Jan 2021 12:57:30 -0800 (PST)
Received: by mail-yb1-xb32.google.com with SMTP id j17so30432ybt.9;
        Tue, 12 Jan 2021 12:57:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q9logYdf98bjtsW9lQM4O5mQ6GbxNVRI4NvrhakrEmY=;
        b=ETo1OViX+SoZpMJbg3lBnX7nVUxUZmzova4dURKKaX90uQHsOOKIQIgjUhQ1G7CTSN
         JtzTWAyzWjIADrUTJ0o97r0VAhLdQxSWPx2LTODB/9yeaInbj7spebYiI8Em+CDmt8gc
         o6B+gjXnR6mlhMNhm05GxhWI7NbtYE7Siy/IaGWpHBenk+jPMXyePjzfA9iei98+UKTE
         WamHKBzeubixqC5GF9IC0HvQ6Eq2D97DTTVXlM91Fb6ufA24H7WQWdnPROcmKEvp0uHG
         79j4qv3jQwEkZ7zscIs9EaimbwYeWrgpgI38fXbwZs/vStHVNAeVov+VNv5y2pJuYKyr
         JiaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q9logYdf98bjtsW9lQM4O5mQ6GbxNVRI4NvrhakrEmY=;
        b=F1G5Augl9sSLzLG0TNmJYOZ4jPNXWSDbLGWYRj0sAn7kf/ZO9aaSdJEgCRUDzvqO8O
         tgTjSmdNSNn5CTuDYPqKExA9hmnIMalCbL/Hb9XjqoRDJONQokMa9uUgtpglw3tc1yIR
         y/rV08TIiUnjing1fclfAI6qlimd7FGsFpZR+Kj0irbli6+EMiPsW2W45JGQLDlKkTCY
         +vVPzZx3AKK2riXH9WlQDrn1qiVs6PnQZ7ihyjfgWU0lW08IVnMRRB8r0xwocYWmfA/L
         x7iSoF4/gfjGncKbjhBHlQKfcU/NfQN8nYwkWr+EPbZZejVLfkD9a3/mEMPVTcMmgioS
         Gy2A==
X-Gm-Message-State: AOAM533pLOS4D0dwrqVopZXMFt0ZmG1gvQQ54EUkyuCoZ2JvnsNRn9ft
        500exk3qelavQq0BnzFds00mtvTmmkAUqBYBe+Y=
X-Google-Smtp-Source: ABdhPJwaXEgY+gC/606R3VYHq6L02XOKyxG6y+y8a+csk6cdBdqzJY98+u/F9Jzqs9tKiSHfhzRyKXX5RLrwBQ9C8pU=
X-Received: by 2002:a25:9882:: with SMTP id l2mr1755488ybo.425.1610485050045;
 Tue, 12 Jan 2021 12:57:30 -0800 (PST)
MIME-Version: 1.0
References: <20210112135959.649075-1-jean-philippe@linaro.org> <20210112135959.649075-3-jean-philippe@linaro.org>
In-Reply-To: <20210112135959.649075-3-jean-philippe@linaro.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 12 Jan 2021 12:57:19 -0800
Message-ID: <CAEf4BzbFy_8+JLRaM1cg=MbO+NsQWE__TSs7xmiaX8AkAV16CQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/5] selftests/bpf: Fix out-of-tree build
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     bpf <bpf@vger.kernel.org>, Shuah Khan <shuah@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, Martin Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        john fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jan 12, 2021 at 6:01 AM Jean-Philippe Brucker
<jean-philippe@linaro.org> wrote:
>
> When building out-of-tree, the .skel.h files are generated into the
> $(OUTPUT) directory, rather than $(CURDIR). Add $(OUTPUT) to the include
> paths.
>
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> ---

Acked-by: Andrii Nakryiko <andrii@kernel.org>


>  tools/testing/selftests/bpf/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> index 1d85565883ea..3ff7e79cc497 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -25,7 +25,7 @@ BPF_GCC               ?= $(shell command -v bpf-gcc;)
>  SAN_CFLAGS     ?=
>  CFLAGS += -g -rdynamic -Wall -O2 $(GENFLAGS) $(SAN_CFLAGS)             \
>           -I$(CURDIR) -I$(INCLUDE_DIR) -I$(GENDIR) -I$(LIBDIR)          \
> -         -I$(TOOLSINCDIR) -I$(APIDIR)                                  \
> +         -I$(TOOLSINCDIR) -I$(APIDIR) -I$(OUTPUT)                      \
>           -Dbpf_prog_load=bpf_prog_test_load                            \
>           -Dbpf_load_program=bpf_test_load_program
>  LDLIBS += -lcap -lelf -lz -lrt -lpthread
> --
> 2.30.0
>
