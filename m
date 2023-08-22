Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C4DE784658
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Aug 2023 17:55:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237431AbjHVPzy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 22 Aug 2023 11:55:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237421AbjHVPzy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 22 Aug 2023 11:55:54 -0400
Received: from mail-vk1-xa2d.google.com (mail-vk1-xa2d.google.com [IPv6:2607:f8b0:4864:20::a2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBD7BE4C;
        Tue, 22 Aug 2023 08:55:24 -0700 (PDT)
Received: by mail-vk1-xa2d.google.com with SMTP id 71dfb90a1353d-48d165bd108so721003e0c.0;
        Tue, 22 Aug 2023 08:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692719724; x=1693324524;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GGDC7f3iS1dC4ufAdA6D7FCUMW4+E/u8Z+mXRP5rOco=;
        b=TU3fLEuiW3VIJpmZP5AdlUmiZOFwZqLUUH5ZTVBYlWBFfTK3azd0E3gJEYJFJA1qFq
         36rz7GFv6kiuzLjw3+davKSFG0pDBmW6E41EBqGM2pi6RY8SV2bDTgkj+icAAQ//+KbR
         5lLrO7gViUG6RgPoU5YWKFH+ib/8pgze1pfF9+KWvIAgXBeNxvb2eveGtcEQvoFsBTYo
         IgxHb8nx7BWXRLtqjI+Dz4PwPA9G1gq/2/XvdIBfZ0Fe/MmFAp1H3zB0KfAZLWwV9d6m
         oKl4alKX6HWEqPB70fI4H8QdIFUZCpqN8BcHoFOcSFdC+zqbY7kNYG8pREuMwhMM8HFb
         rQlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692719724; x=1693324524;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GGDC7f3iS1dC4ufAdA6D7FCUMW4+E/u8Z+mXRP5rOco=;
        b=LFy02XXTOk0dnhXZnmGv3/UzxcopThHUVPK3dqKe9qWMmxAtzmFk9h7s7KuM7f1odf
         FlNFuXPCLEJYAtBMCR0o09EN7tVjqwtwRxxSMAiXchwBzCxiq4PrkTZGbjkzFEk89GUb
         AKPy1ogs9DmSy3cH0LDMFe9EiVaGLaM3ufpbdW6Iir0YTPli2iQUgT/4Q7xkioCAJtJy
         3s/RY8uYuZ0QPW08HKmHmfc+reJXn+c8ejsQeNWQVB09uZmzoj442Zpfgt05p1ykntsw
         7y2CNCBum9EUBOnEz57kfDCkdJVZeRvpN2YBo3MdOREfpbGzltKgskFk0Sjj/y0A7R81
         7SWw==
X-Gm-Message-State: AOJu0Yx0AyBcvA6Bm9qb21QGgH/qAIjkEdf2LEXmEJWzdAokzlB+TNCV
        uACCsXH1u+ncLY65KMIDb2Nn3A6JJ1v5wHBUEK9yQHJ29ws=
X-Google-Smtp-Source: AGHT+IHXPjWyxj5ouCGPqQlGMW2Gf47yy5ZoK3qu1KzWgxaGAd35ldVGFywIxgCQoEJ1ym9JjCSP2ImoZ5qHMPmD0WU=
X-Received: by 2002:a67:de08:0:b0:42c:9d63:47ea with SMTP id
 q8-20020a67de08000000b0042c9d6347eamr6292504vsk.0.1692719723773; Tue, 22 Aug
 2023 08:55:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230821160534.3414911-1-andre.przywara@arm.com> <20230821160534.3414911-3-andre.przywara@arm.com>
In-Reply-To: <20230821160534.3414911-3-andre.przywara@arm.com>
From:   Nhat Pham <nphamcs@gmail.com>
Date:   Tue, 22 Aug 2023 08:55:12 -0700
Message-ID: <CAKEwX=NEZjeFFQsC3gWLgkh=PMHDh44Uzo3aZFH07y1xL=VvWg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] selftests: cachestat: catch failing fsync test on tmpfs
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     Shuah Khan <shuah@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Aug 21, 2023 at 9:05=E2=80=AFAM Andre Przywara <andre.przywara@arm.=
com> wrote:
>
> The cachestat kselftest runs a test on a normal file, which is created
> temporarily in the current directory. Among the tests it runs there is a
> call to fsync(), which is expected to clean all dirty pages used by the
> file.
> However the tmpfs filesystem implements fsync() as noop_fsync(), so the
> call will not even attempt to clean anything when this test file happens
> to live on a tmpfs instance. This happens in an initramfs, or when the
> current directory is in /dev/shm or sometimes /tmp.
>
> To avoid this test failing wrongly, use statfs() to check which filesyste=
m
> the test file lives on. If that is "tmpfs", we skip the fsync() test.
>
> Since the fsync test is only one part of the "normal file" test, we now
> execute this twice, skipping the fsync part on the first call.
> This way only the second test, including the fsync part, would be skipped=
.
>
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  .../selftests/cachestat/test_cachestat.c      | 62 ++++++++++++++-----
>  1 file changed, 47 insertions(+), 15 deletions(-)
>
> diff --git a/tools/testing/selftests/cachestat/test_cachestat.c b/tools/t=
esting/selftests/cachestat/test_cachestat.c
> index 8f8f46c24846d..4804c7dc7b312 100644
> --- a/tools/testing/selftests/cachestat/test_cachestat.c
> +++ b/tools/testing/selftests/cachestat/test_cachestat.c
> @@ -4,10 +4,12 @@
>  #include <stdio.h>
>  #include <stdbool.h>
>  #include <linux/kernel.h>
> +#include <linux/magic.h>
>  #include <linux/mman.h>
>  #include <sys/mman.h>
>  #include <sys/shm.h>
>  #include <sys/syscall.h>
> +#include <sys/vfs.h>
>  #include <unistd.h>
>  #include <string.h>
>  #include <fcntl.h>
> @@ -15,7 +17,7 @@
>
>  #include "../kselftest.h"
>
> -#define NR_TESTS       8
> +#define NR_TESTS       9
>
>  static const char * const dev_files[] =3D {
>         "/dev/zero", "/dev/null", "/dev/urandom",
> @@ -91,6 +93,20 @@ bool write_exactly(int fd, size_t filesize)
>         return ret;
>  }
>
> +/*
> + * fsync() is implemented via noop_fsync() on tmpfs. This makes the fsyn=
c()
> + * test fail below, so we need to check for test file living on a tmpfs.
> + */
> +static bool is_on_tmpfs(int fd)
> +{
> +       struct statfs statfs_buf;
> +
> +       if (fstatfs(fd, &statfs_buf))
> +               return false;
> +
> +       return statfs_buf.f_type =3D=3D TMPFS_MAGIC;
> +}
> +
>  /*
>   * Open/create the file at filename, (optionally) write random data to i=
t
>   * (exactly num_pages), then test the cachestat syscall on this file.
> @@ -98,13 +114,13 @@ bool write_exactly(int fd, size_t filesize)
>   * If test_fsync =3D=3D true, fsync the file, then check the number of d=
irty
>   * pages.
>   */
> -bool test_cachestat(const char *filename, bool write_random, bool create=
,
> -               bool test_fsync, unsigned long num_pages, int open_flags,
> -               mode_t open_mode)
> +static int test_cachestat(const char *filename, bool write_random, bool =
create,
> +                         bool test_fsync, unsigned long num_pages,
> +                         int open_flags, mode_t open_mode)
>  {
Hmm would the semantic change a bit here?

Previously, this function returned true if passed.
But it seems like KSFT_PASS is defined as 0:
https://github.com/torvalds/linux/blob/9e38be7/tools/testing/selftests/ksel=
ftest.h#L74

So maybe we have to change from:

if (test_<test-name>())


to:

if (!test_<test-name>)())

or, explicitly as:

if (test_<test-name>() =3D=3D KSFT_PASS)


>         size_t PS =3D sysconf(_SC_PAGESIZE);
>         int filesize =3D num_pages * PS;
> -       bool ret =3D true;
> +       int ret =3D KSFT_PASS;
>         long syscall_ret;
>         struct cachestat cs;
>         struct cachestat_range cs_range =3D { 0, filesize };
> @@ -113,7 +129,7 @@ bool test_cachestat(const char *filename, bool write_=
random, bool create,
>
>         if (fd =3D=3D -1) {
>                 ksft_print_msg("Unable to create/open file.\n");
> -               ret =3D false;
> +               ret =3D KSFT_FAIL;
>                 goto out;
>         } else {
>                 ksft_print_msg("Create/open %s\n", filename);
> @@ -122,7 +138,7 @@ bool test_cachestat(const char *filename, bool write_=
random, bool create,
>         if (write_random) {
>                 if (!write_exactly(fd, filesize)) {
>                         ksft_print_msg("Unable to access urandom.\n");
> -                       ret =3D false;
> +                       ret =3D KSFT_FAIL;
>                         goto out1;
>                 }
>         }
> @@ -133,7 +149,7 @@ bool test_cachestat(const char *filename, bool write_=
random, bool create,
>
>         if (syscall_ret) {
>                 ksft_print_msg("Cachestat returned non-zero.\n");
> -               ret =3D false;
> +               ret =3D KSFT_FAIL;
>                 goto out1;
>
>         } else {
> @@ -143,15 +159,17 @@ bool test_cachestat(const char *filename, bool writ=
e_random, bool create,
>                         if (cs.nr_cache + cs.nr_evicted !=3D num_pages) {
>                                 ksft_print_msg(
>                                         "Total number of cached and evict=
ed pages is off.\n");
> -                               ret =3D false;
> +                               ret =3D KSFT_FAIL;
>                         }
>                 }
>         }
>
>         if (test_fsync) {
> -               if (fsync(fd)) {
> +               if (is_on_tmpfs(fd)) {
> +                       ret =3D KSFT_SKIP;
> +               } else if (fsync(fd)) {
>                         ksft_print_msg("fsync fails.\n");
> -                       ret =3D false;
> +                       ret =3D KSFT_FAIL;
>                 } else {
>                         syscall_ret =3D syscall(__NR_cachestat, fd, &cs_r=
ange, &cs, 0);
>
> @@ -162,13 +180,13 @@ bool test_cachestat(const char *filename, bool writ=
e_random, bool create,
>                                 print_cachestat(&cs);
>
>                                 if (cs.nr_dirty) {
> -                                       ret =3D false;
> +                                       ret =3D KSFT_FAIL;
>                                         ksft_print_msg(
>                                                 "Number of dirty should b=
e zero after fsync.\n");
>                                 }
>                         } else {
>                                 ksft_print_msg("Cachestat (after fsync) r=
eturned non-zero.\n");
> -                               ret =3D false;
> +                               ret =3D KSFT_FAIL;
>                                 goto out1;
>                         }
>                 }
> @@ -259,7 +277,7 @@ int main(void)
>                 const char *dev_filename =3D dev_files[i];
>
>                 if (test_cachestat(dev_filename, false, false, false,
> -                       4, O_RDONLY, 0400))
> +                       4, O_RDONLY, 0400) =3D=3D KSFT_PASS)
>                         ksft_test_result_pass("cachestat works with %s\n"=
, dev_filename);
>                 else {
>                         ksft_test_result_fail("cachestat fails with %s\n"=
, dev_filename);
> @@ -268,13 +286,27 @@ int main(void)
>         }
>
>         if (test_cachestat("tmpfilecachestat", true, true,
> -               true, 4, O_CREAT | O_RDWR, 0400 | 0600))
> +               false, 4, O_CREAT | O_RDWR, 0600) =3D=3D KSFT_PASS)
>                 ksft_test_result_pass("cachestat works with a normal file=
\n");
>         else {
>                 ksft_test_result_fail("cachestat fails with normal file\n=
");
>                 ret =3D 1;
>         }
>
> +       switch (test_cachestat("tmpfilecachestat", true, true,
> +               true, 4, O_CREAT | O_RDWR, 0600)) {
> +       case KSFT_FAIL:
> +               ksft_test_result_fail("cachestat fsync fails with normal =
file\n");
> +               ret =3D KSFT_FAIL;
> +               break;
> +       case KSFT_PASS:
> +               ksft_test_result_pass("cachestat fsync works with a norma=
l file\n");
> +               break;
> +       case KSFT_SKIP:
> +               ksft_test_result_skip("tmpfilecachestat is on tmpfs\n");
> +               break;
> +       }
> +
>         if (test_cachestat_shmem())
>                 ksft_test_result_pass("cachestat works with a shmem file\=
n");
>         else {
> --
> 2.25.1
>
