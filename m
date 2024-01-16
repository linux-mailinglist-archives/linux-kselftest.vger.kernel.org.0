Return-Path: <linux-kselftest+bounces-3085-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EAC3082F2DD
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Jan 2024 18:07:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB40D1C235FB
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Jan 2024 17:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEBDD1CA8E;
	Tue, 16 Jan 2024 17:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YAmXjYw/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15EF71CA87
	for <linux-kselftest@vger.kernel.org>; Tue, 16 Jan 2024 17:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705424840; cv=none; b=e8eogXGiRZ3fwPj80WVKysI1/RNBS8P3LOeaGXjfTU4mJSUep9M5V9qIgPoGeEecmATHawDYln1aL7dWWHOZnnHX+3cFKuIpKakODJRBvT7UsMYy6Pm9F+wl4ZCmmi/NjJ/wBf1jkCwFVYNaMi9YtbdLas8F3hcUktIJNKkOyNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705424840; c=relaxed/simple;
	bh=+GuC6zoEYQWSr7aItYSuVAM5WsDyoSk4ZitaQsNzqWM=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=PEHFZnfi2fQljmyMt5deFwiEjifylvtSvBWbDyMQpnWoBUztIJl3RieDxjTutvoPowI9MgqxbG9vDr1LWGbS0OpInsaVsvoJbjEnLnUwEHz9couejJwg6gc+7zYgmNoRMYOAJU3WVGSGtadkN2pAgu5oSqpz+z2bPUPHV7p2caE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YAmXjYw/
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-5e54d40cca2so76373707b3.3
        for <linux-kselftest@vger.kernel.org>; Tue, 16 Jan 2024 09:07:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705424838; x=1706029638; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LYAyXDnBieOZ07+HSztPJfv/gicy4Aq73XfYrqZGI+A=;
        b=YAmXjYw/YnYOHOHWdhlyhvsplLSnVGw7BjiqbHaeN5dbtDkXkbpU9sSqqxTBNPYDUP
         9dEoLCfSuL0torWgiwfR4uwv/0xH6Pz2uTq35HO6SY98wSW9zrpLS2XUDrg0g4fmvMwo
         5t3KJHxcdAQjNILOcZdYA37JaxH4G9y0EsNcEfyYGu++jj7BpKC3wo0OUqlAD/A9n6R+
         gsJv1KWW/s1FDKbfb3UtYOgvfEG/m9jVNewHTZY7hoEpq3A7RMXuBqszG/k+hFWoGT4+
         4ZO4Z2YSQCbM/sh4DIAjzRfE0vV8pUge2R+UfklwLu+ooksT5b/tk8/Jj7KnhXdvwbI/
         y0BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705424838; x=1706029638;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LYAyXDnBieOZ07+HSztPJfv/gicy4Aq73XfYrqZGI+A=;
        b=mpRyXUoIYpY69JQollb0pNKKoZdAFQYvehQDOzsnyI/EZq0qWR2vmsE9JGhmEq8tI1
         6PXlsxXeX/70YUi6TCJaZlOnXkxoMeivyuxroFk91Ru4/k6pHLCuhz6UgkZ/hO6WlRYd
         0lk1tcNvoZAs4/lCeBkx432S7rfkbNjrxljEfRVCwMipNU+7NEIA+lro9R6cI8wY/Du3
         J9QqnhUyPG7/4Yspq3VFAAibzbceDD1/l0eem5MTO0fwY00U+eHl3zjG3uIxWLrp4j1D
         y1LCk5L2L48BUWFWmluI2Ju3yI6Ehdq97e+qmbYvW1hsY2gm4+AA55gmR/RxLdy6XCEl
         BrJg==
X-Gm-Message-State: AOJu0Yw3IxscVpPWv92rHD1rrxqZpMXUMIYKLMrFKRQNAK/s041e5TsN
	/hc+4Fg7x1uDZeH9DJqVhsoNYHIvHzC1nXmcHVjcnJSlxcyvj5Ih1PQ3k5r2Q27l
X-Google-Smtp-Source: AGHT+IEt6m4lRGkN7pl7yK1iWV5zYl2byqnaXWtr21i/9sli77T3BzIJos4eANuyzDvtU0Qq8bOorQMIMRTCqTeZFis=
X-Received: by 2002:a25:9904:0:b0:dbe:9274:bdd5 with SMTP id
 z4-20020a259904000000b00dbe9274bdd5mr2811327ybn.29.1705424837732; Tue, 16 Jan
 2024 09:07:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240115073247.1280266-1-usama.anjum@collabora.com> <20240115073247.1280266-5-usama.anjum@collabora.com>
In-Reply-To: <20240115073247.1280266-5-usama.anjum@collabora.com>
From: Jiaqi Yan <jiaqiyan@google.com>
Date: Tue, 16 Jan 2024 09:07:05 -0800
Message-ID: <CACw3F531DPDtQe5PJmH091n9RhK57FhUYR1L45FdjrYBMSUOtQ@mail.gmail.com>
Subject: Re: [PATCH v3 5/7] selftests/mm: hugetlb-read-hwpoison: conform test
 to TAP format output
To: Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>, kernel@collabora.com, 
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 14, 2024 at 11:33=E2=80=AFPM Muhammad Usama Anjum
<usama.anjum@collabora.com> wrote:
>
> Conform the layout, informational and status messages to TAP. No
> functional change is intended other than the layout of output messages.
>
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---
> Changes in v3:
> - Use ksft_perror as short hand instead of missing strerror(errno) at
>   one place

Minor thing: I think we should preserve previous changelogs, right?

>
> Tested this by reverting the patch a08c7193e4f18dc8508f2d07d0de2c5b94cb39=
a3
> ("mm/filemap: remove hugetlb special casing in filemap.c") as it has
> broken the test. The bug report can be found at [1].
>
> Tested with proposed fix as well [2].
>
> [1] https://lore.kernel.org/all/079335ab-190f-41f7-b832-6ffe7528fd8b@coll=
abora.com
> [2] https://lore.kernel.org/all/a20e7bdb-7344-306d-e8f5-5ee69af7d5ea@orac=
le.com
> ---
>  .../selftests/mm/hugetlb-read-hwpoison.c      | 116 ++++++++----------
>  1 file changed, 54 insertions(+), 62 deletions(-)
>
> diff --git a/tools/testing/selftests/mm/hugetlb-read-hwpoison.c b/tools/t=
esting/selftests/mm/hugetlb-read-hwpoison.c
> index ba6cc6f9cabc..23b41b88c6af 100644
> --- a/tools/testing/selftests/mm/hugetlb-read-hwpoison.c
> +++ b/tools/testing/selftests/mm/hugetlb-read-hwpoison.c
> @@ -58,8 +58,8 @@ static bool verify_chunk(char *buf, size_t len, char va=
l)
>
>         for (i =3D 0; i < len; ++i) {
>                 if (buf[i] !=3D val) {
> -                       printf(PREFIX ERROR_PREFIX "check fail: buf[%lu] =
=3D %u !=3D %u\n",
> -                               i, buf[i], val);
> +                       ksft_print_msg(PREFIX ERROR_PREFIX "check fail: b=
uf[%lu] =3D %u !=3D %u\n",
> +                                      i, buf[i], val);
>                         return false;
>                 }
>         }
> @@ -75,21 +75,21 @@ static bool seek_read_hugepage_filemap(int fd, size_t=
 len, size_t wr_chunk_size,
>         ssize_t total_ret_count =3D 0;
>         char val =3D offset / wr_chunk_size + offset % wr_chunk_size;
>
> -       printf(PREFIX PREFIX "init val=3D%u with offset=3D0x%lx\n", val, =
offset);
> -       printf(PREFIX PREFIX "expect to read 0x%lx bytes of data in total=
\n",
> -              expected);
> +       ksft_print_msg(PREFIX PREFIX "init val=3D%u with offset=3D0x%lx\n=
", val, offset);
> +       ksft_print_msg(PREFIX PREFIX "expect to read 0x%lx bytes of data =
in total\n",
> +                      expected);
>         if (lseek(fd, offset, SEEK_SET) < 0) {
> -               perror(PREFIX ERROR_PREFIX "seek failed");
> +               ksft_perror(PREFIX ERROR_PREFIX "seek failed");
>                 return false;
>         }
>
>         while (offset + total_ret_count < len) {
>                 ret_count =3D read(fd, buf, wr_chunk_size);
>                 if (ret_count =3D=3D 0) {
> -                       printf(PREFIX PREFIX "read reach end of the file\=
n");
> +                       ksft_print_msg(PREFIX PREFIX "read reach end of t=
he file\n");
>                         break;
>                 } else if (ret_count < 0) {
> -                       perror(PREFIX ERROR_PREFIX "read failed");
> +                       ksft_perror(PREFIX ERROR_PREFIX "read failed");
>                         break;
>                 }
>                 ++val;
> @@ -98,8 +98,8 @@ static bool seek_read_hugepage_filemap(int fd, size_t l=
en, size_t wr_chunk_size,
>
>                 total_ret_count +=3D ret_count;
>         }
> -       printf(PREFIX PREFIX "actually read 0x%lx bytes of data in total\=
n",
> -              total_ret_count);
> +       ksft_print_msg(PREFIX PREFIX "actually read 0x%lx bytes of data i=
n total\n",
> +                      total_ret_count);
>
>         return total_ret_count =3D=3D expected;
>  }
> @@ -112,15 +112,15 @@ static bool read_hugepage_filemap(int fd, size_t le=
n,
>         ssize_t total_ret_count =3D 0;
>         char val =3D 0;
>
> -       printf(PREFIX PREFIX "expect to read 0x%lx bytes of data in total=
\n",
> -              expected);
> +       ksft_print_msg(PREFIX PREFIX "expect to read 0x%lx bytes of data =
in total\n",
> +                      expected);
>         while (total_ret_count < len) {
>                 ret_count =3D read(fd, buf, wr_chunk_size);
>                 if (ret_count =3D=3D 0) {
> -                       printf(PREFIX PREFIX "read reach end of the file\=
n");
> +                       ksft_print_msg(PREFIX PREFIX "read reach end of t=
he file\n");
>                         break;
>                 } else if (ret_count < 0) {
> -                       perror(PREFIX ERROR_PREFIX "read failed");
> +                       ksft_perror(PREFIX ERROR_PREFIX "read failed");
>                         break;
>                 }
>                 ++val;
> @@ -129,8 +129,8 @@ static bool read_hugepage_filemap(int fd, size_t len,
>
>                 total_ret_count +=3D ret_count;
>         }
> -       printf(PREFIX PREFIX "actually read 0x%lx bytes of data in total\=
n",
> -              total_ret_count);
> +       ksft_print_msg(PREFIX PREFIX "actually read 0x%lx bytes of data i=
n total\n",
> +                      total_ret_count);
>
>         return total_ret_count =3D=3D expected;
>  }
> @@ -142,14 +142,14 @@ test_hugetlb_read(int fd, size_t len, size_t wr_chu=
nk_size)
>         char *filemap =3D NULL;
>
>         if (ftruncate(fd, len) < 0) {
> -               perror(PREFIX ERROR_PREFIX "ftruncate failed");
> +               ksft_perror(PREFIX ERROR_PREFIX "ftruncate failed");
>                 return status;
>         }
>
>         filemap =3D mmap(NULL, len, PROT_READ | PROT_WRITE,
>                        MAP_SHARED | MAP_POPULATE, fd, 0);
>         if (filemap =3D=3D MAP_FAILED) {
> -               perror(PREFIX ERROR_PREFIX "mmap for primary mapping fail=
ed");
> +               ksft_perror(PREFIX ERROR_PREFIX "mmap for primary mapping=
 failed");
>                 goto done;
>         }
>
> @@ -162,7 +162,7 @@ test_hugetlb_read(int fd, size_t len, size_t wr_chunk=
_size)
>         munmap(filemap, len);
>  done:
>         if (ftruncate(fd, 0) < 0) {
> -               perror(PREFIX ERROR_PREFIX "ftruncate back to 0 failed");
> +               ksft_perror(PREFIX ERROR_PREFIX "ftruncate back to 0 fail=
ed");
>                 status =3D TEST_FAILED;
>         }
>
> @@ -179,14 +179,14 @@ test_hugetlb_read_hwpoison(int fd, size_t len, size=
_t wr_chunk_size,
>         const unsigned long pagesize =3D getpagesize();
>
>         if (ftruncate(fd, len) < 0) {
> -               perror(PREFIX ERROR_PREFIX "ftruncate failed");
> +               ksft_perror(PREFIX ERROR_PREFIX "ftruncate failed");
>                 return status;
>         }
>
>         filemap =3D mmap(NULL, len, PROT_READ | PROT_WRITE,
>                        MAP_SHARED | MAP_POPULATE, fd, 0);
>         if (filemap =3D=3D MAP_FAILED) {
> -               perror(PREFIX ERROR_PREFIX "mmap for primary mapping fail=
ed");
> +               ksft_perror(PREFIX ERROR_PREFIX "mmap for primary mapping=
 failed");
>                 goto done;
>         }
>
> @@ -201,7 +201,7 @@ test_hugetlb_read_hwpoison(int fd, size_t len, size_t=
 wr_chunk_size,
>          */
>         hwp_addr =3D filemap + len / 2 + pagesize;
>         if (madvise(hwp_addr, pagesize, MADV_HWPOISON) < 0) {
> -               perror(PREFIX ERROR_PREFIX "MADV_HWPOISON failed");
> +               ksft_perror(PREFIX ERROR_PREFIX "MADV_HWPOISON failed");
>                 goto unmap;
>         }
>
> @@ -228,7 +228,7 @@ test_hugetlb_read_hwpoison(int fd, size_t len, size_t=
 wr_chunk_size,
>         munmap(filemap, len);
>  done:
>         if (ftruncate(fd, 0) < 0) {
> -               perror(PREFIX ERROR_PREFIX "ftruncate back to 0 failed");
> +               ksft_perror(PREFIX ERROR_PREFIX "ftruncate back to 0 fail=
ed");
>                 status =3D TEST_FAILED;
>         }
>
> @@ -240,27 +240,32 @@ static int create_hugetlbfs_file(struct statfs *fil=
e_stat)
>         int fd;
>
>         fd =3D memfd_create("hugetlb_tmp", MFD_HUGETLB);
> -       if (fd < 0) {
> -               perror(PREFIX ERROR_PREFIX "could not open hugetlbfs file=
");
> -               return -1;
> -       }
> +       if (fd < 0)
> +               ksft_exit_fail_msg(PREFIX ERROR_PREFIX "could not open hu=
getlbfs file: %s\n",
> +                                  strerror(errno));
>
>         memset(file_stat, 0, sizeof(*file_stat));
> +
>         if (fstatfs(fd, file_stat)) {
> -               perror(PREFIX ERROR_PREFIX "fstatfs failed");
> -               goto close;
> +               close(fd);
> +               ksft_exit_fail_msg(PREFIX ERROR_PREFIX "fstatfs failed: %=
s\n", strerror(errno));
>         }
>         if (file_stat->f_type !=3D HUGETLBFS_MAGIC) {
> -               printf(PREFIX ERROR_PREFIX "not hugetlbfs file\n");
> -               goto close;
> +               close(fd);
> +               ksft_exit_fail_msg(PREFIX ERROR_PREFIX "not hugetlbfs fil=
e\n");
>         }
>
>         return fd;
> -close:
> -       close(fd);
> -       return -1;
>  }
>
> +#define KSFT_PRINT_MSG(status, fmt, ...)                                =
       \
> +       do {                                                             =
       \
> +               if (status =3D=3D TEST_SKIPPED)                          =
           \
> +                       ksft_test_result_skip(fmt, __VA_ARGS__);         =
       \
> +               else                                                     =
       \
> +                       ksft_test_result(status =3D=3D TEST_PASSED, fmt, =
__VA_ARGS__); \
> +       } while (0)
> +
>  int main(void)
>  {
>         int fd;
> @@ -273,50 +278,37 @@ int main(void)
>         };
>         size_t i;
>
> +       ksft_print_header();
> +       ksft_set_plan(12);

Minor: can this number be calculated, or at least defined as a macro
with documents? That would make it easier for reading.

> +
>         for (i =3D 0; i < ARRAY_SIZE(wr_chunk_sizes); ++i) {
> -               printf("Write/read chunk size=3D0x%lx\n",
> -                      wr_chunk_sizes[i]);
> +               ksft_print_msg("Write/read chunk size=3D0x%lx\n",
> +                              wr_chunk_sizes[i]);
>
>                 fd =3D create_hugetlbfs_file(&file_stat);
> -               if (fd < 0)
> -                       goto create_failure;
> -               printf(PREFIX "HugeTLB read regression test...\n");
> +               ksft_print_msg(PREFIX "HugeTLB read regression test...\n"=
);
>                 status =3D test_hugetlb_read(fd, file_stat.f_bsize,
>                                            wr_chunk_sizes[i]);
> -               printf(PREFIX "HugeTLB read regression test...%s\n",
> -                      status_to_str(status));
> +               KSFT_PRINT_MSG(status, PREFIX "HugeTLB read regression te=
st...%s\n",
> +                              status_to_str(status));
>                 close(fd);
> -               if (status =3D=3D TEST_FAILED)
> -                       return -1;
>
>                 fd =3D create_hugetlbfs_file(&file_stat);
> -               if (fd < 0)
> -                       goto create_failure;
> -               printf(PREFIX "HugeTLB read HWPOISON test...\n");
> +               ksft_print_msg(PREFIX "HugeTLB read HWPOISON test...\n");
>                 status =3D test_hugetlb_read_hwpoison(fd, file_stat.f_bsi=
ze,
>                                                     wr_chunk_sizes[i], fa=
lse);
> -               printf(PREFIX "HugeTLB read HWPOISON test...%s\n",
> -                      status_to_str(status));
> +               KSFT_PRINT_MSG(status, PREFIX "HugeTLB read HWPOISON test=
...%s\n",
> +                              status_to_str(status));
>                 close(fd);
> -               if (status =3D=3D TEST_FAILED)
> -                       return -1;
>
>                 fd =3D create_hugetlbfs_file(&file_stat);
> -               if (fd < 0)
> -                       goto create_failure;
> -               printf(PREFIX "HugeTLB seek then read HWPOISON test...\n"=
);
> +               ksft_print_msg(PREFIX "HugeTLB seek then read HWPOISON te=
st...\n");
>                 status =3D test_hugetlb_read_hwpoison(fd, file_stat.f_bsi=
ze,
>                                                     wr_chunk_sizes[i], tr=
ue);
> -               printf(PREFIX "HugeTLB seek then read HWPOISON test...%s\=
n",
> -                      status_to_str(status));
> +               KSFT_PRINT_MSG(status, PREFIX "HugeTLB seek then read HWP=
OISON test...%s\n",
> +                              status_to_str(status));
>                 close(fd);
> -               if (status =3D=3D TEST_FAILED)
> -                       return -1;
>         }
>
> -       return 0;
> -
> -create_failure:
> -       printf(ERROR_PREFIX "Abort test: failed to create hugetlbfs file\=
n");
> -       return -1;
> +       ksft_finished();
>  }
> --
> 2.42.0
>
>

This version looks good to me. Maybe someone else need to take another
look, just add mine:

Reviewed-by: Jiaqi Yan <jiaqiyan@google.com>

