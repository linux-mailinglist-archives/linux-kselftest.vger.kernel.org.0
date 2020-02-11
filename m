Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2613159843
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2020 19:20:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731192AbgBKSUw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 11 Feb 2020 13:20:52 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36369 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731308AbgBKSUu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 11 Feb 2020 13:20:50 -0500
Received: by mail-pg1-f193.google.com with SMTP id d9so6161194pgu.3
        for <linux-kselftest@vger.kernel.org>; Tue, 11 Feb 2020 10:20:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4OgG0hetIsP1V38kbC307zOjczZWs0KOp5Ez5Rl0KME=;
        b=lDSRjevbxM40tz/93zZtEf0l5hvgAJaYkwnSWnpl1y1J058EWn71+v9gGdFqjyE+LM
         1s4OIdw7yTpcWQTOq78Kzb/qRXieUEXKhZD1e2no6c6b8LIKHiCiOhHk5IQ7CvjD+4ZG
         iamdeGk/eC+W3+8zZ3SoHfWNLug+eDxbO22PGJxFXTjmO3FyBy9bpuBT9fAD+SJoPWRy
         swmj5LdJkecykIqqY9Xqa+ITTp8kIdfwQlM67qbKEfKq2cmKZSsVZ+Ghx1T9cJJCeA3s
         sPO8DhjPO+7NsB6lmFx1DVTzfI3s0fn2XPRQlZb5shxgKYa3Qgijkc12NseHBQcRqo+R
         LdDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4OgG0hetIsP1V38kbC307zOjczZWs0KOp5Ez5Rl0KME=;
        b=C2ILBblgblC30vcj8NPZpMawxNS9cc50+LGj8+vpVd5sxJQTY0cdjtIE4OPtbzQuIl
         2DFazp2CokFGvDRv3ORL8RIK/8CXn153/5yVG+qzUFbieAdxveCK7/fmBp32/Lufna1O
         MLBqvgTFSBjky0VHYlKilkwJLZqm+yhoxU2YrXei8qf1sE/3wpzqHo9+ll/tGl3tAcer
         uqg6tmeWG4iuz4LmSPS6iWsUlW9r1BOYzAyRY+yWFZ24QUz6hy0ohXDtfZ5OQnoNb0s7
         lAzOBq2J4YZTq8pXTHmERpTf0P1legnLrVQ0+VVyi3BnlVq0ZamnDmCf9C5itpZop97l
         6H/g==
X-Gm-Message-State: APjAAAWQchCkt6G5md0i/kPSmmjImMshB89IQkmwBIjXX/9/IAMEFvH3
        0iwncUo7sN87VqsHTeqqV0FF7OVL3YwwcOZreRgtLA==
X-Google-Smtp-Source: APXvYqxMvSkOVcfNtGbDzyRqqzjTst6GjcEty8BqJsis9ObxAC/QNdkqDYmzeMZhO0NEe3Lhmu8jwxwDkyO1K6X7SpM=
X-Received: by 2002:a62:1615:: with SMTP id 21mr4402234pfw.84.1581445249952;
 Tue, 11 Feb 2020 10:20:49 -0800 (PST)
MIME-Version: 1.0
References: <20200128021145.36774-1-palmerdabbelt@google.com> <20200128021145.36774-2-palmerdabbelt@google.com>
In-Reply-To: <20200128021145.36774-2-palmerdabbelt@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 11 Feb 2020 18:20:39 +0000
Message-ID: <CAKwvOdnPu8-0O5kLDY2t=wq1rqWNX7v0CSrRmomPYLA1=BX=GQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] selftests/bpf: Elide a check for LLVM versions that
 can't compile it
To:     Palmer Dabbelt <palmerdabbelt@google.com>
Cc:     Bjorn Topel <bjorn.topel@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>, zlim.lnx@gmail.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        andriin@fb.com, Shuah Khan <shuah@kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        bpf@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        kernel-team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jan 27, 2020 at 6:14 PM 'Palmer Dabbelt' via Clang Built Linux
<clang-built-linux@googlegroups.com> wrote:
>
> The current stable LLVM BPF backend fails to compile the BPF selftests
> due to a compiler bug.  The bug has been fixed in trunk, but that fix
> hasn't landed in the binary packages I'm using yet (Fedora arm64).
> Without this workaround the tests don't compile for me.
>
> This patch triggers a preprocessor warning on LLVM versions that
> definitely have the bug.  The test may be conservative (ie, I'm not sure
> if 9.1 will have the fix), but it should at least make the current set
> of stable releases work together.

Do older versions of clang still work? Should there be a lower bounds?

>
> See https://reviews.llvm.org/D69438 for more information on the fix.  I
> obtained the workaround from
> https://lore.kernel.org/linux-kselftest/aed8eda7-df20-069b-ea14-f06628984566@gmail.com/T/
>
> Fixes: 20a9ad2e7136 ("selftests/bpf: add CO-RE relocs array tests")
> Signed-off-by: Palmer Dabbelt <palmerdabbelt@google.com>
> ---
>  .../testing/selftests/bpf/progs/test_core_reloc_arrays.c  | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/progs/test_core_reloc_arrays.c b/tools/testing/selftests/bpf/progs/test_core_reloc_arrays.c
> index bf67f0fdf743..c9a3e0585a84 100644
> --- a/tools/testing/selftests/bpf/progs/test_core_reloc_arrays.c
> +++ b/tools/testing/selftests/bpf/progs/test_core_reloc_arrays.c
> @@ -40,15 +40,23 @@ int test_core_arrays(void *ctx)
>         /* in->a[2] */
>         if (BPF_CORE_READ(&out->a2, &in->a[2]))
>                 return 1;
> +#if defined(__clang__) && (__clang_major__ < 10) && (__clang_minor__ < 1)
> +# warning "clang 9.0 SEGVs on multidimensional arrays, see https://reviews.llvm.org/D69438"
> +#else
>         /* in->b[1][2][3] */
>         if (BPF_CORE_READ(&out->b123, &in->b[1][2][3]))
>                 return 1;
> +#endif
>         /* in->c[1].c */
>         if (BPF_CORE_READ(&out->c1c, &in->c[1].c))
>                 return 1;
> +#if defined(__clang__) && (__clang_major__ < 10) && (__clang_minor__ < 1)
> +# warning "clang 9.0 SEGVs on multidimensional arrays, see https://reviews.llvm.org/D69438"
> +#else
>         /* in->d[0][0].d */
>         if (BPF_CORE_READ(&out->d00d, &in->d[0][0].d))
>                 return 1;
> +#endif
>
>         return 0;
>  }
> --
> 2.25.0.341.g760bfbb309-goog
>
> --
> You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/20200128021145.36774-2-palmerdabbelt%40google.com.



-- 
Thanks,
~Nick Desaulniers
