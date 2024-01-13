Return-Path: <linux-kselftest+bounces-2936-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE2DF82C88F
	for <lists+linux-kselftest@lfdr.de>; Sat, 13 Jan 2024 02:08:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B2CE287304
	for <lists+linux-kselftest@lfdr.de>; Sat, 13 Jan 2024 01:08:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F17F410796;
	Sat, 13 Jan 2024 01:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CMSfilDz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB01F503
	for <linux-kselftest@vger.kernel.org>; Sat, 13 Jan 2024 01:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-dbe69afb431so6264948276.1
        for <linux-kselftest@vger.kernel.org>; Fri, 12 Jan 2024 17:08:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705108121; x=1705712921; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jb1wwJrWJvoyReb8Nv/VrYvbxBXv4F3rDgRPRu/DK1M=;
        b=CMSfilDzogWQTUR9tpY7uJ4lW6E9spMF6FeqFDvsHOlkGJf71h3JyMKVkXEqKbv92F
         S5FDuqx64HY+9jmkmNo4H/Vbs3hg3LJsixzc5BfxWEMAIiN9fB5+qT0iZ7lYWTutI1Yu
         yNFl0TAoFpAfjkCzq5T50nPUutU2/OZcrOi+lW6AFqc/1/ga2EEDcyBOBGIHPXd0mojV
         8vuj1gXeEn1ajF967KNhlKmXRzD2UW7rNB7u+ldQ7qyNmCunZi0cz66oJkmx3SsYwpWB
         Nsn+SCnI13HzcKw93vFZf0EQTtVWSBsNDF03PugP5EUaAny2AMUWkgLQcgU8u6IUarz2
         ONjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705108121; x=1705712921;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jb1wwJrWJvoyReb8Nv/VrYvbxBXv4F3rDgRPRu/DK1M=;
        b=dc8pWGFMmmqftHaVyIeTe0dYb9Cbfe4cUbv9/0K3+JnofCJH8lJFllfdgSPvWEqRNh
         O8IjPLxVeB85CZYrcZLpGzA+TVvCXcrrSubc1XrvZjBVl0tCHqrP8Lg3LMeo0LZMgIIR
         f20BEgeoWxqfAHrtd2mmxQP7IsNM2VkDnQnTjFN7A2N4z1SsvdTv+pzLsb6eQ3m7gCr7
         smWYv69NRmv0npjyh5TiZ/HaInchkHJAII75EY2A3inU98KfEEVvtcFpeii4ToJi4p4/
         H3pl7zK+Tkl/GeDOjhtMvWVgNu9ajfg3lhJIvZ0ZaunYCQDfxtKWdOMvh3pnJ0cpQqkJ
         phpA==
X-Gm-Message-State: AOJu0YxhE0RA/k1MhKLhBBqgosZ1pG3pzqel0qqGlMnzllrbxB3uj9+D
	bf1MD2DyUx/SgT2Ajs70t2h+QgEH4Yt21OX24wGWvhX7dIGl
X-Google-Smtp-Source: AGHT+IG53yTERUmsQPKfQbbyKT10TbTCEz6l+cMhYeuPamipi1gLQLKaesCeAcBT6eS/Y93H2MMvkl9gWRrmF7IfqJA=
X-Received: by 2002:a25:d255:0:b0:dbd:49fe:f134 with SMTP id
 j82-20020a25d255000000b00dbd49fef134mr1489269ybg.34.1705108120738; Fri, 12
 Jan 2024 17:08:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240112072144.620098-1-usama.anjum@collabora.com> <20240112072144.620098-5-usama.anjum@collabora.com>
In-Reply-To: <20240112072144.620098-5-usama.anjum@collabora.com>
From: Jiaqi Yan <jiaqiyan@google.com>
Date: Fri, 12 Jan 2024 17:08:29 -0800
Message-ID: <CACw3F51dwDhuaRxy+ud3CWfTt5ZcoS8=7jLU74KXJHJaCcc8Dw@mail.gmail.com>
Subject: Re: [PATCH v2 5/7] selftests/mm: hugetlb-read-hwpoison: conform test
 to TAP format output
To: Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>, kernel@collabora.com, 
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 11, 2024 at 11:21=E2=80=AFPM Muhammad Usama Anjum
<usama.anjum@collabora.com> wrote:
>
> Conform the layout, informational and status messages to TAP. No
> functional change is intended other than the layout of output messages.
>
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---
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
>  .../selftests/mm/hugetlb-read-hwpoison.c      | 116 +++++++++---------
>  1 file changed, 56 insertions(+), 60 deletions(-)
>
> diff --git a/tools/testing/selftests/mm/hugetlb-read-hwpoison.c b/tools/t=
esting/selftests/mm/hugetlb-read-hwpoison.c
> index ba6cc6f9cabc..193ad7275df5 100644
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
> @@ -75,9 +75,9 @@ static bool seek_read_hugepage_filemap(int fd, size_t l=
en, size_t wr_chunk_size,
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
>                 perror(PREFIX ERROR_PREFIX "seek failed");
>                 return false;
> @@ -86,7 +86,7 @@ static bool seek_read_hugepage_filemap(int fd, size_t l=
en, size_t wr_chunk_size,
>         while (offset + total_ret_count < len) {
>                 ret_count =3D read(fd, buf, wr_chunk_size);
>                 if (ret_count =3D=3D 0) {
> -                       printf(PREFIX PREFIX "read reach end of the file\=
n");
> +                       ksft_print_msg(PREFIX PREFIX "read reach end of t=
he file\n");
>                         break;
>                 } else if (ret_count < 0) {
>                         perror(PREFIX ERROR_PREFIX "read failed");
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
> +                       ksft_print_msg(PREFIX ERROR_PREFIX "read failed")=
;

Should we also include strerror(errno) in log msg, like you did below?

Actually, would ksft_perror be a better choice for perror()s?

>
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
> @@ -142,14 +142,15 @@ test_hugetlb_read(int fd, size_t len, size_t wr_chu=
nk_size)
>         char *filemap =3D NULL;
>
>         if (ftruncate(fd, len) < 0) {
> -               perror(PREFIX ERROR_PREFIX "ftruncate failed");
> +               ksft_print_msg(PREFIX ERROR_PREFIX "ftruncate failed: %s\=
n", strerror(errno));
>                 return status;
>         }
>
>         filemap =3D mmap(NULL, len, PROT_READ | PROT_WRITE,
>                        MAP_SHARED | MAP_POPULATE, fd, 0);
>         if (filemap =3D=3D MAP_FAILED) {
> -               perror(PREFIX ERROR_PREFIX "mmap for primary mapping fail=
ed");
> +               ksft_print_msg(PREFIX ERROR_PREFIX "mmap for primary mapp=
ing failed: %s\n",
> +                              strerror(errno));
>                 goto done;
>         }
>
> @@ -162,7 +163,8 @@ test_hugetlb_read(int fd, size_t len, size_t wr_chunk=
_size)
>         munmap(filemap, len);
>  done:
>         if (ftruncate(fd, 0) < 0) {
> -               perror(PREFIX ERROR_PREFIX "ftruncate back to 0 failed");
> +               ksft_print_msg(PREFIX ERROR_PREFIX "ftruncate back to 0 f=
ailed : %s\n",
> +                              strerror(errno));
>                 status =3D TEST_FAILED;
>         }
>
> @@ -179,14 +181,15 @@ test_hugetlb_read_hwpoison(int fd, size_t len, size=
_t wr_chunk_size,
>         const unsigned long pagesize =3D getpagesize();
>
>         if (ftruncate(fd, len) < 0) {
> -               perror(PREFIX ERROR_PREFIX "ftruncate failed");
> +               ksft_print_msg(PREFIX ERROR_PREFIX "ftruncate failed: %s\=
n", strerror(errno));
>                 return status;
>         }
>
>         filemap =3D mmap(NULL, len, PROT_READ | PROT_WRITE,
>                        MAP_SHARED | MAP_POPULATE, fd, 0);
>         if (filemap =3D=3D MAP_FAILED) {
> -               perror(PREFIX ERROR_PREFIX "mmap for primary mapping fail=
ed");
> +               ksft_print_msg(PREFIX ERROR_PREFIX "mmap for primary mapp=
ing failed: %s\n",
> +                              strerror(errno));
>                 goto done;
>         }
>
> @@ -201,7 +204,7 @@ test_hugetlb_read_hwpoison(int fd, size_t len, size_t=
 wr_chunk_size,
>          */
>         hwp_addr =3D filemap + len / 2 + pagesize;
>         if (madvise(hwp_addr, pagesize, MADV_HWPOISON) < 0) {
> -               perror(PREFIX ERROR_PREFIX "MADV_HWPOISON failed");
> +               ksft_print_msg(PREFIX ERROR_PREFIX "MADV_HWPOISON failed:=
 %s\n", strerror(errno));
>                 goto unmap;
>         }
>
> @@ -228,7 +231,8 @@ test_hugetlb_read_hwpoison(int fd, size_t len, size_t=
 wr_chunk_size,
>         munmap(filemap, len);
>  done:
>         if (ftruncate(fd, 0) < 0) {
> -               perror(PREFIX ERROR_PREFIX "ftruncate back to 0 failed");
> +               ksft_print_msg(PREFIX ERROR_PREFIX "ftruncate back to 0 f=
ailed: %s\n",
> +                              strerror(errno));
>                 status =3D TEST_FAILED;
>         }
>
> @@ -240,27 +244,32 @@ static int create_hugetlbfs_file(struct statfs *fil=
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
> @@ -273,50 +282,37 @@ int main(void)
>         };
>         size_t i;
>
> +       ksft_print_header();
> +       ksft_set_plan(12);
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

