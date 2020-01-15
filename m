Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8201C13B961
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Jan 2020 07:14:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbgAOGOP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 15 Jan 2020 01:14:15 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:42774 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725962AbgAOGOP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 15 Jan 2020 01:14:15 -0500
Received: by mail-yw1-f66.google.com with SMTP id l14so10578022ywj.9
        for <linux-kselftest@vger.kernel.org>; Tue, 14 Jan 2020 22:14:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=VEBiEWWczDCOsezp9xBUmXOvLcrB5S1wxD0g5MzN8aA=;
        b=YECmlLyEJydlZuQRbc4ygVEZ22HwLEJpx9ImEnLFgfMbG12BYqnWQll5imuGXxorWz
         O83fsaCcuui1Mm27iQQNAFiAO3s/g25ffSvXoiUcbkF6eEdOo9wlvn59YGJ9wcbBiEJR
         lZcIjNCU6E0EaQeX9RKRYXW3WKu6/qoaejM8dqk2N+xtr4wydJGMRcYqGvyr6+asqXsf
         YaSblQBtelLSJwf/rBW5GHAShS4zueLC6ygBAE4NxbuV2F56z2QesIjjtRdwI0+9bvqv
         +Mt0sSHhC5C1e3wXp1+SHxhaaIL/W+HRymGNyNI10x1z/4b9W6djbnqxXgOAdqMP7MVm
         Jk+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=VEBiEWWczDCOsezp9xBUmXOvLcrB5S1wxD0g5MzN8aA=;
        b=e9CJ9shONmEPZvkEjnhmBGhoSSDxCISU6jKNJ1hBieMCrT2ODFY3tv8RWqbcuOzAXr
         kiyYd4UxHyQqR6XZVnTbY+QeHeUSKZ1fdEhugrKDyMJ2BcJbZXXy2are8Oo5jfkE0D7n
         PtoF683LRXeyB1JhlBKY7B2DwkY1Tn1Ua20buEVSDFlkBbVlpLqucuzvZwXQgjIUsRNE
         p4UynHIxSIUEFd1F9f8uZPBbjLm6+0SO0GT+h99h2m/ce8c1xlzAZSmrFCB/Uxh4dW0D
         5kmfgLz2IcA4Zdpa9naiIejRkplxVo2twNm43t35FlVC4CuJ8elg7VnK9YbaWt3MtDnQ
         barQ==
X-Gm-Message-State: APjAAAVEGZiB0QZaE8kf7pcYZF6+nvwmxySxVsqPYI7XBA9uCZv4hTVu
        wfBxsSlIyGodUmRrxl3HJSvwoOlBniCGbaebCUxErA==
X-Google-Smtp-Source: APXvYqyIDJGALzUv2jU87wWn412aAc+Hx6yOxAeVZDKZ9ZgzmBjJ3rI//zWGDtDwWehLrjS1KViM467Xeg474lIfklc=
X-Received: by 2002:a81:2782:: with SMTP id n124mr20570754ywn.444.1579068853832;
 Tue, 14 Jan 2020 22:14:13 -0800 (PST)
MIME-Version: 1.0
References: <20200113164158.15803-1-siddhesh@gotplt.org>
In-Reply-To: <20200113164158.15803-1-siddhesh@gotplt.org>
From:   Masami Hiramatsu <masami.hiramatsu@linaro.org>
Date:   Wed, 15 Jan 2020 15:14:02 +0900
Message-ID: <CAA93ih1KXO5oSKAB6PmQc6xOw4fX5T+2+zx91BD18YUxL+nWzQ@mail.gmail.com>
Subject: Re: [PATCH] kselftest: Minimise dependency of get_size on C library interfaces
To:     Siddhesh Poyarekar <siddhesh@gotplt.org>
Cc:     linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        Tim Bird <tim.bird@sony.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi,

[Cc: Tim Bird]

2020=E5=B9=B41=E6=9C=8814=E6=97=A5(=E7=81=AB) 1:43 Siddhesh Poyarekar <sidd=
hesh@gotplt.org>:

>
> It was observed[1] on arm64 that __builtin_strlen led to an infinite
> loop in the get_size selftest.  This is because __builtin_strlen (and
> other builtins) may sometimes result in a call to the C library
> function.  The C library implementation of strlen uses an IFUNC
> resolver to load the most efficient strlen implementation for the
> underlying machine and hence has a PLT indirection even for static
> binaries.  Because this binary avoids the C library startup routines,
> the PLT initialization never happens and hence the program gets stuck
> in an infinite loop.
>
> On x86_64 the __builtin_strlen just happens to expand inline and avoid
> the call but that is not always guaranteed.
>
> Further, while testing on x86_64 (Fedora 31), it was observed that the
> test also failed with a segfault inside write() because the generated
> code for the write function in glibc seems to access TLS before the
> syscall (probably due to the cancellation point check) and fails
> because TLS is not initialised.
>
> To mitigate these problems, this patch reduces the interface with the
> C library to just the syscall function.  The syscall function still
> sets errno on failure, which is undesirable but for now it only
> affects cases where syscalls fail.
>
> [1] https://bugs.linaro.org/show_bug.cgi?id=3D5479
>

Thank you for the fix! I confirmed this fixes the issue.

----
root@devnote2:/opt/kselftest/size# ./get_size
TAP version 13
# Testing system size.
ok 1 get runtime memory use
# System runtime memory report (units in Kilobytes):
 ---
 Total:  16085116
 Free:   2042880
 Buffer: 814052
 In use: 13228184
 ...
1..1
----

Tested-by: Masami Hiramatsu <masami.hiramatsu@linaro.org>


> Signed-off-by: Siddhesh Poyarekar <siddhesh@gotplt.org>
> Reported-by: Masami Hiramatsu <masami.hiramatsu@linaro.org>
> ---
>  tools/testing/selftests/size/get_size.c | 24 ++++++++++++++++++------
>  1 file changed, 18 insertions(+), 6 deletions(-)
>
> diff --git a/tools/testing/selftests/size/get_size.c b/tools/testing/self=
tests/size/get_size.c
> index d4b59ab979a0..f55943b6d1e2 100644
> --- a/tools/testing/selftests/size/get_size.c
> +++ b/tools/testing/selftests/size/get_size.c
> @@ -12,23 +12,35 @@
>   * own execution.  It also attempts to have as few dependencies
>   * on kernel features as possible.
>   *
> - * It should be statically linked, with startup libs avoided.
> - * It uses no library calls, and only the following 3 syscalls:
> + * It should be statically linked, with startup libs avoided.  It uses
> + * no library calls except the syscall() function for the following 3
> + * syscalls:
>   *   sysinfo(), write(), and _exit()
>   *
>   * For output, it avoids printf (which in some C libraries
>   * has large external dependencies) by  implementing it's own
>   * number output and print routines, and using __builtin_strlen()
> + *
> + * The test may crash if any of the above syscalls fails because in some
> + * libc implementations (e.g. the GNU C Library) errno is saved in
> + * thread-local storage, which does not get initialized due to avoiding
> + * startup libs.
>   */
>
>  #include <sys/sysinfo.h>
>  #include <unistd.h>
> +#include <sys/syscall.h>
>
>  #define STDOUT_FILENO 1
>
>  static int print(const char *s)
>  {
> -       return write(STDOUT_FILENO, s, __builtin_strlen(s));
> +       size_t len =3D 0;
> +
> +       while (s[len] !=3D '\0')
> +               len++;
> +
> +       return syscall(SYS_write, STDOUT_FILENO, s, len);
>  }
>
>  static inline char *num_to_str(unsigned long num, char *buf, int len)
> @@ -80,12 +92,12 @@ void _start(void)
>         print("TAP version 13\n");
>         print("# Testing system size.\n");
>
> -       ccode =3D sysinfo(&info);
> +       ccode =3D syscall(SYS_sysinfo, &info);
>         if (ccode < 0) {
>                 print("not ok 1");
>                 print(test_name);
>                 print(" ---\n reason: \"could not get sysinfo\"\n ...\n")=
;
> -               _exit(ccode);
> +               syscall(SYS_exit, ccode);
>         }
>         print("ok 1");
>         print(test_name);
> @@ -101,5 +113,5 @@ void _start(void)
>         print(" ...\n");
>         print("1..1\n");
>
> -       _exit(0);
> +       syscall(SYS_exit, 0);
>  }
> --
> 2.24.1
>


--
Masami Hiramatsu
