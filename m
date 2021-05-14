Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB81D380F69
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 May 2021 20:07:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232788AbhENSIl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 14 May 2021 14:08:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231394AbhENSIk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 14 May 2021 14:08:40 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 829FCC061574;
        Fri, 14 May 2021 11:07:28 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id f9so162063ybo.6;
        Fri, 14 May 2021 11:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F+bB2SlwmXAbGko5eMsle0FPLI0dLitYqgCywht6E24=;
        b=Vs/2boPWCvpNFM3Vj85vK2A+AfiEkNUoQvYX3TYEbljhDi+EZSL5EN8iOP+J7xDiet
         DkA7ml5iNwcpIx4AmoCuQ0rNQTMP77swG1m9GNNud+Kq+AzwyECZpPoHBc/78dGhfjd9
         FSIPbWD6MI3k9togpmoIVZCZAxRIhLzBZfT0LdHWf/5QwL0W/0OwpUCcC74nOlt8h9Ye
         r8iuBXyEpjcw91Pfqqd6uuAm+9ZeLRJioHLbU9Q6GOJC184QGFYhUKrmtxlPiFe52BJC
         lhdotSiuVGxbjfI6aAMTZZKu8XTy9yzXEvN9gFEv90urFCe634ndfck14Ssyqr0iN9yh
         u0Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F+bB2SlwmXAbGko5eMsle0FPLI0dLitYqgCywht6E24=;
        b=UtqZZSunEQ4ln+L3JnM782YpQHTZ2rDNCTxi2EbApCko3SYhw6O/+8qBK0FAVgBLTu
         kmjPI59zCf/ggB7PttGhEfldv+1YqLwPPNz+47efwvjcCyguvJh7xdPQq/TT9IbrZGa2
         Wl/Z4HZgyd/PDsL9I0Y3AbvjPWTgBuJ3OleHmEdP/t4Jyf5RDalyAtn4dpK0FUDA+2T3
         Fav0BR9NsrTcT1bKcQZ6e2srGym0ZK5IckXt5ySUyORCKcwnzBzWgLDlVR+o6RazAX0E
         TEas3bYMRkJPk9alAGH9CTkjURs1wPgBOlkPjMWZoJS6YAwHgRkMGt8uumMIZ97vwXNW
         wjBg==
X-Gm-Message-State: AOAM530JfWDij5CQCSwZEWpvKELw+0D5zhB6Lx69nMM5COUKkVtmmIy6
        9CCuwzEyD3qYeRQUFO6rRijGjqwIRan7FuCsarY=
X-Google-Smtp-Source: ABdhPJz1AicHvZdtmJHyzn+7fW9n0cpyvFocIjMBo+2uSTMczuKBc9XD/PQKxru4tWWWWOKDr1JMYE7vx2Bu2Dkxak4=
X-Received: by 2002:a25:7507:: with SMTP id q7mr65257173ybc.27.1621015647823;
 Fri, 14 May 2021 11:07:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210514012306.39020-1-cascardo@canonical.com>
In-Reply-To: <20210514012306.39020-1-cascardo@canonical.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 14 May 2021 11:07:17 -0700
Message-ID: <CAEf4BzZoQSq2=YXMFBomack=1Y86rn04Aa594dGACw+nDmMhFQ@mail.gmail.com>
Subject: Re: [PATCH] selftests/bpf: only munmap the mmaped ringbuf pages
To:     Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
Cc:     bpf <bpf@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, May 13, 2021 at 6:23 PM Thadeu Lima de Souza Cascardo
<cascardo@canonical.com> wrote:
>
> One the mmap tests will map a single page, then try to extend the
> mapping by use of mremap, which should fail. Right after that, it unmaps
> the extended area, which may end up unmapping other valid mapped areas,
> this causing a segfault.
>
> Only unmap the area that is expected to be mapped.
>
> Fixes: b2fb299c9aa4 ("selftests/bpf: test ringbuf mmap read-only and read-write restrictions")

We backed out this patch because it was causing our CI to crash on the
ringbuf test. I think you found out why :)

I'm going to incorporate your fix into my patch and leave your and
mine Signed-off-by and post it upstream. Hope that works fine for
attribution? And thanks for catching this!


> Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
> ---
>  tools/testing/selftests/bpf/prog_tests/ringbuf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/ringbuf.c b/tools/testing/selftests/bpf/prog_tests/ringbuf.c
> index 197e30b83298..f9a8ae331963 100644
> --- a/tools/testing/selftests/bpf/prog_tests/ringbuf.c
> +++ b/tools/testing/selftests/bpf/prog_tests/ringbuf.c
> @@ -146,7 +146,7 @@ void test_ringbuf(void)
>         ASSERT_ERR(mprotect(mmap_ptr, page_size, PROT_WRITE), "write_protect");
>         ASSERT_ERR(mprotect(mmap_ptr, page_size, PROT_EXEC), "exec_protect");
>         ASSERT_ERR_PTR(mremap(mmap_ptr, 0, 3 * page_size, MREMAP_MAYMOVE), "ro_remap");
> -       ASSERT_OK(munmap(mmap_ptr, 3 * page_size), "unmap_ro");
> +       ASSERT_OK(munmap(mmap_ptr, page_size), "unmap_ro");
>
>         /* only trigger BPF program for current process */
>         skel->bss->pid = getpid();
> --
> 2.30.2
>
