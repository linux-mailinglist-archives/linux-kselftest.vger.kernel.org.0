Return-Path: <linux-kselftest+bounces-2959-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EDFC82D44B
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Jan 2024 07:52:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 872001C208DA
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Jan 2024 06:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3878F1FB9;
	Mon, 15 Jan 2024 06:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ruwnjhTM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B814627
	for <linux-kselftest@vger.kernel.org>; Mon, 15 Jan 2024 06:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-5ebca94cf74so80002977b3.0
        for <linux-kselftest@vger.kernel.org>; Sun, 14 Jan 2024 22:52:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705301549; x=1705906349; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TcGqD0gtcFtuZcZ7u66zOaQO/inZ6mabGTo1Ra0lyoY=;
        b=ruwnjhTMHH1Ckad7cHQks9g+BQVEtTSNxofZT2JizHkbWL1luNIJ5CnZLCG+q7YwWY
         hOq3XmH+U1xRo4rRtcYHET22EdbRxDHSAcsKW5GlpKBv5mEwBLCvxa3ZpQMhBGzK8oSP
         2mNlmD4pbNeP9Te4C6WDV3QuOaqLTQvwLj5CFmTkkaPZMRRV9NoDIzHEJBliAxxqNoxA
         5n9DP6knYPJXK2OeydCM3j0wNP6sqBHnGkhcoGZvAJMZs0tVK1eyoVOSy44butuhOdAb
         uigaVpAZZZjBss9UUDn7X3ZB6tzPwHZVr30rEFSqFlZvlX5mHZyof3ONtwbnr7pdawkk
         zSkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705301549; x=1705906349;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TcGqD0gtcFtuZcZ7u66zOaQO/inZ6mabGTo1Ra0lyoY=;
        b=jkjRscWHfEEk+JUx5zpdbAVD8+So9p46Shp3/jC9tahsCh5RzmluObcnP99RkAPVjM
         q3JG4uH9E6Qr3nGVWWMClUe2ztGRr5nroq869dgI0rTvH3Mwa7aJgRYVBir7hXkxkDzl
         5SsFaJpohi8pM0x/RuWz9gaOTLWRU6G9jHTrTJ41FgCj7QRRLiRFCDPJqMeIs1a7UMZC
         ifhQVyebulmj95RR0VefAgMo1kOJDdIL9GrpN/GngJ3XUlSHmQg4KEHl7Iy119Bz7peF
         aerNuyDrI884gsA+jSjF79VHN+XSJFfbAt12/Ztkr8KTFpshDSzgYSTkOLvr1MaqKpZB
         IyNQ==
X-Gm-Message-State: AOJu0YyBQCe6jyECYdeO59cGN14dMw+S39It2Groh3hTodyyC8OiN+hv
	+FvqOPpPpdaLKXb9Dws/+oBfBD1reM9Q7ZouWa2edYRGS3xw
X-Google-Smtp-Source: AGHT+IFOsPa7sJyXBjQzRjtNJAbXpF0xdrOIkcc43KF1+7HJ0A2Q5sACGMkY1TIfBxhwqsac+A4ctLWTvO2OFRFlPh0=
X-Received: by 2002:a25:8a01:0:b0:dbd:a56e:891c with SMTP id
 g1-20020a258a01000000b00dbda56e891cmr1980810ybl.2.1705301548996; Sun, 14 Jan
 2024 22:52:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240112072144.620098-1-usama.anjum@collabora.com>
 <20240112072144.620098-5-usama.anjum@collabora.com> <CACw3F51dwDhuaRxy+ud3CWfTt5ZcoS8=7jLU74KXJHJaCcc8Dw@mail.gmail.com>
 <0b5a7c8c-d46b-496c-b705-fafc54a91ff0@collabora.com>
In-Reply-To: <0b5a7c8c-d46b-496c-b705-fafc54a91ff0@collabora.com>
From: Jiaqi Yan <jiaqiyan@google.com>
Date: Sun, 14 Jan 2024 22:52:16 -0800
Message-ID: <CACw3F50OXfYYSGzbp3+eHjVxj=VU4sJiQO-=yrDTEUX=Map6gQ@mail.gmail.com>
Subject: Re: [PATCH v2 5/7] selftests/mm: hugetlb-read-hwpoison: conform test
 to TAP format output
To: Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>, kernel@collabora.com, 
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 14, 2024 at 10:32=E2=80=AFPM Muhammad Usama Anjum
<usama.anjum@collabora.com> wrote:
>
> On 1/13/24 6:08 AM, Jiaqi Yan wrote:
> > On Thu, Jan 11, 2024 at 11:21=E2=80=AFPM Muhammad Usama Anjum
> > <usama.anjum@collabora.com> wrote:
> >>
> >> Conform the layout, informational and status messages to TAP. No
> >> functional change is intended other than the layout of output messages=
.
> >>
> >> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> >> ---
> >> Tested this by reverting the patch a08c7193e4f18dc8508f2d07d0de2c5b94c=
b39a3
> >> ("mm/filemap: remove hugetlb special casing in filemap.c") as it has
> >> broken the test. The bug report can be found at [1].
> >>
> >> Tested with proposed fix as well [2].
> >>
> >> [1] https://lore.kernel.org/all/079335ab-190f-41f7-b832-6ffe7528fd8b@c=
ollabora.com
> >> [2] https://lore.kernel.org/all/a20e7bdb-7344-306d-e8f5-5ee69af7d5ea@o=
racle.com
> >> ---
> >>  .../selftests/mm/hugetlb-read-hwpoison.c      | 116 +++++++++--------=
-
> >>  1 file changed, 56 insertions(+), 60 deletions(-)
> >>
> >> diff --git a/tools/testing/selftests/mm/hugetlb-read-hwpoison.c b/tool=
s/testing/selftests/mm/hugetlb-read-hwpoison.c
> >> index ba6cc6f9cabc..193ad7275df5 100644
> >> --- a/tools/testing/selftests/mm/hugetlb-read-hwpoison.c
> >> +++ b/tools/testing/selftests/mm/hugetlb-read-hwpoison.c
> >> @@ -58,8 +58,8 @@ static bool verify_chunk(char *buf, size_t len, char=
 val)
> >>
> >>         for (i =3D 0; i < len; ++i) {
> >>                 if (buf[i] !=3D val) {
> >> -                       printf(PREFIX ERROR_PREFIX "check fail: buf[%l=
u] =3D %u !=3D %u\n",
> >> -                               i, buf[i], val);
> >> +                       ksft_print_msg(PREFIX ERROR_PREFIX "check fail=
: buf[%lu] =3D %u !=3D %u\n",
> >> +                                      i, buf[i], val);
> >>                         return false;
> >>                 }
> >>         }
> >> @@ -75,9 +75,9 @@ static bool seek_read_hugepage_filemap(int fd, size_=
t len, size_t wr_chunk_size,
> >>         ssize_t total_ret_count =3D 0;
> >>         char val =3D offset / wr_chunk_size + offset % wr_chunk_size;
> >>
> >> -       printf(PREFIX PREFIX "init val=3D%u with offset=3D0x%lx\n", va=
l, offset);
> >> -       printf(PREFIX PREFIX "expect to read 0x%lx bytes of data in to=
tal\n",
> >> -              expected);
> >> +       ksft_print_msg(PREFIX PREFIX "init val=3D%u with offset=3D0x%l=
x\n", val, offset);
> >> +       ksft_print_msg(PREFIX PREFIX "expect to read 0x%lx bytes of da=
ta in total\n",
> >> +                      expected);
> >>         if (lseek(fd, offset, SEEK_SET) < 0) {
> >>                 perror(PREFIX ERROR_PREFIX "seek failed");
> >>                 return false;
> >> @@ -86,7 +86,7 @@ static bool seek_read_hugepage_filemap(int fd, size_=
t len, size_t wr_chunk_size,
> >>         while (offset + total_ret_count < len) {
> >>                 ret_count =3D read(fd, buf, wr_chunk_size);
> >>                 if (ret_count =3D=3D 0) {
> >> -                       printf(PREFIX PREFIX "read reach end of the fi=
le\n");
> >> +                       ksft_print_msg(PREFIX PREFIX "read reach end o=
f the file\n");
> >>                         break;
> >>                 } else if (ret_count < 0) {
> >>                         perror(PREFIX ERROR_PREFIX "read failed");
> >> @@ -98,8 +98,8 @@ static bool seek_read_hugepage_filemap(int fd, size_=
t len, size_t wr_chunk_size,
> >>
> >>                 total_ret_count +=3D ret_count;
> >>         }
> >> -       printf(PREFIX PREFIX "actually read 0x%lx bytes of data in tot=
al\n",
> >> -              total_ret_count);
> >> +       ksft_print_msg(PREFIX PREFIX "actually read 0x%lx bytes of dat=
a in total\n",
> >> +                      total_ret_count);
> >>
> >>         return total_ret_count =3D=3D expected;
> >>  }
> >> @@ -112,15 +112,15 @@ static bool read_hugepage_filemap(int fd, size_t=
 len,
> >>         ssize_t total_ret_count =3D 0;
> >>         char val =3D 0;
> >>
> >> -       printf(PREFIX PREFIX "expect to read 0x%lx bytes of data in to=
tal\n",
> >> -              expected);
> >> +       ksft_print_msg(PREFIX PREFIX "expect to read 0x%lx bytes of da=
ta in total\n",
> >> +                      expected);
> >>         while (total_ret_count < len) {
> >>                 ret_count =3D read(fd, buf, wr_chunk_size);
> >>                 if (ret_count =3D=3D 0) {
> >> -                       printf(PREFIX PREFIX "read reach end of the fi=
le\n");
> >> +                       ksft_print_msg(PREFIX PREFIX "read reach end o=
f the file\n");
> >>                         break;
> >>                 } else if (ret_count < 0) {
> >> -                       perror(PREFIX ERROR_PREFIX "read failed");
> >> +                       ksft_print_msg(PREFIX ERROR_PREFIX "read faile=
d");
> >
> > Should we also include strerror(errno) in log msg, like you did below?
> Looks like I missed it. I'll post a v3.
> >
> > Actually, would ksft_perror be a better choice for perror()s?
> It may or may not be. There aren't ksft_*_perror macros for printing the
> logs at this time. I prefer using just whatever macros are available. The=
y
> aren't generic enough. Maybe mm tests use perror whenever error occurs, b=
ut
> other tests don't.

can't you use this ksft_perror available today?
https://github.com/torvalds/linux/blob/master/tools/testing/selftests/kself=
test.h#L161C25-L172

>
> >
> >>
> >>                         break;
> >>                 }
> >>                 ++val;
> >> @@ -129,8 +129,8 @@ static bool read_hugepage_filemap(int fd, size_t l=
en,
> >>
> >>                 total_ret_count +=3D ret_count;
> >>         }
> >> -       printf(PREFIX PREFIX "actually read 0x%lx bytes of data in tot=
al\n",
> >> -              total_ret_count);
> >> +       ksft_print_msg(PREFIX PREFIX "actually read 0x%lx bytes of dat=
a in total\n",
> >> +                      total_ret_count);
> >>
> >>         return total_ret_count =3D=3D expected;
> >>  }
> >> @@ -142,14 +142,15 @@ test_hugetlb_read(int fd, size_t len, size_t wr_=
chunk_size)
> >>         char *filemap =3D NULL;
> >>
> >>         if (ftruncate(fd, len) < 0) {
> >> -               perror(PREFIX ERROR_PREFIX "ftruncate failed");
> >> +               ksft_print_msg(PREFIX ERROR_PREFIX "ftruncate failed: =
%s\n", strerror(errno));
> >>                 return status;
> >>         }
> >>
> >>         filemap =3D mmap(NULL, len, PROT_READ | PROT_WRITE,
> >>                        MAP_SHARED | MAP_POPULATE, fd, 0);
> >>         if (filemap =3D=3D MAP_FAILED) {
> >> -               perror(PREFIX ERROR_PREFIX "mmap for primary mapping f=
ailed");
> >> +               ksft_print_msg(PREFIX ERROR_PREFIX "mmap for primary m=
apping failed: %s\n",
> >> +                              strerror(errno));
> >>                 goto done;
> >>         }
> >>
> >> @@ -162,7 +163,8 @@ test_hugetlb_read(int fd, size_t len, size_t wr_ch=
unk_size)
> >>         munmap(filemap, len);
> >>  done:
> >>         if (ftruncate(fd, 0) < 0) {
> >> -               perror(PREFIX ERROR_PREFIX "ftruncate back to 0 failed=
");
> >> +               ksft_print_msg(PREFIX ERROR_PREFIX "ftruncate back to =
0 failed : %s\n",
> >> +                              strerror(errno));
> >>                 status =3D TEST_FAILED;
> >>         }
> >>
> >> @@ -179,14 +181,15 @@ test_hugetlb_read_hwpoison(int fd, size_t len, s=
ize_t wr_chunk_size,
> >>         const unsigned long pagesize =3D getpagesize();
> >>
> >>         if (ftruncate(fd, len) < 0) {
> >> -               perror(PREFIX ERROR_PREFIX "ftruncate failed");
> >> +               ksft_print_msg(PREFIX ERROR_PREFIX "ftruncate failed: =
%s\n", strerror(errno));
> >>                 return status;
> >>         }
> >>
> >>         filemap =3D mmap(NULL, len, PROT_READ | PROT_WRITE,
> >>                        MAP_SHARED | MAP_POPULATE, fd, 0);
> >>         if (filemap =3D=3D MAP_FAILED) {
> >> -               perror(PREFIX ERROR_PREFIX "mmap for primary mapping f=
ailed");
> >> +               ksft_print_msg(PREFIX ERROR_PREFIX "mmap for primary m=
apping failed: %s\n",
> >> +                              strerror(errno));
> >>                 goto done;
> >>         }
> >>
> >> @@ -201,7 +204,7 @@ test_hugetlb_read_hwpoison(int fd, size_t len, siz=
e_t wr_chunk_size,
> >>          */
> >>         hwp_addr =3D filemap + len / 2 + pagesize;
> >>         if (madvise(hwp_addr, pagesize, MADV_HWPOISON) < 0) {
> >> -               perror(PREFIX ERROR_PREFIX "MADV_HWPOISON failed");
> >> +               ksft_print_msg(PREFIX ERROR_PREFIX "MADV_HWPOISON fail=
ed: %s\n", strerror(errno));
> >>                 goto unmap;
> >>         }
> >>
> >> @@ -228,7 +231,8 @@ test_hugetlb_read_hwpoison(int fd, size_t len, siz=
e_t wr_chunk_size,
> >>         munmap(filemap, len);
> >>  done:
> >>         if (ftruncate(fd, 0) < 0) {
> >> -               perror(PREFIX ERROR_PREFIX "ftruncate back to 0 failed=
");
> >> +               ksft_print_msg(PREFIX ERROR_PREFIX "ftruncate back to =
0 failed: %s\n",
> >> +                              strerror(errno));
> >>                 status =3D TEST_FAILED;
> >>         }
> >>
> >> @@ -240,27 +244,32 @@ static int create_hugetlbfs_file(struct statfs *=
file_stat)
> >>         int fd;
> >>
> >>         fd =3D memfd_create("hugetlb_tmp", MFD_HUGETLB);
> >> -       if (fd < 0) {
> >> -               perror(PREFIX ERROR_PREFIX "could not open hugetlbfs f=
ile");
> >> -               return -1;
> >> -       }
> >> +       if (fd < 0)
> >> +               ksft_exit_fail_msg(PREFIX ERROR_PREFIX "could not open=
 hugetlbfs file: %s\n",
> >> +                                  strerror(errno));
> >>
> >>         memset(file_stat, 0, sizeof(*file_stat));
> >> +
> >>         if (fstatfs(fd, file_stat)) {
> >> -               perror(PREFIX ERROR_PREFIX "fstatfs failed");
> >> -               goto close;
> >> +               close(fd);
> >> +               ksft_exit_fail_msg(PREFIX ERROR_PREFIX "fstatfs failed=
: %s\n", strerror(errno));
> >>         }
> >>         if (file_stat->f_type !=3D HUGETLBFS_MAGIC) {
> >> -               printf(PREFIX ERROR_PREFIX "not hugetlbfs file\n");
> >> -               goto close;
> >> +               close(fd);
> >> +               ksft_exit_fail_msg(PREFIX ERROR_PREFIX "not hugetlbfs =
file\n");
> >>         }
> >>
> >>         return fd;
> >> -close:
> >> -       close(fd);
> >> -       return -1;
> >>  }
> >>
> >> +#define KSFT_PRINT_MSG(status, fmt, ...)                             =
          \
> >> +       do {                                                          =
          \
> >> +               if (status =3D=3D TEST_SKIPPED)                       =
              \
> >> +                       ksft_test_result_skip(fmt, __VA_ARGS__);      =
          \
> >> +               else                                                  =
          \
> >> +                       ksft_test_result(status =3D=3D TEST_PASSED, fm=
t, __VA_ARGS__); \
> >> +       } while (0)
> >> +
> >>  int main(void)
> >>  {
> >>         int fd;
> >> @@ -273,50 +282,37 @@ int main(void)
> >>         };
> >>         size_t i;
> >>
> >> +       ksft_print_header();
> >> +       ksft_set_plan(12);
> >> +
> >>         for (i =3D 0; i < ARRAY_SIZE(wr_chunk_sizes); ++i) {
> >> -               printf("Write/read chunk size=3D0x%lx\n",
> >> -                      wr_chunk_sizes[i]);
> >> +               ksft_print_msg("Write/read chunk size=3D0x%lx\n",
> >> +                              wr_chunk_sizes[i]);
> >>
> >>                 fd =3D create_hugetlbfs_file(&file_stat);
> >> -               if (fd < 0)
> >> -                       goto create_failure;
> >> -               printf(PREFIX "HugeTLB read regression test...\n");
> >> +               ksft_print_msg(PREFIX "HugeTLB read regression test...=
\n");
> >>                 status =3D test_hugetlb_read(fd, file_stat.f_bsize,
> >>                                            wr_chunk_sizes[i]);
> >> -               printf(PREFIX "HugeTLB read regression test...%s\n",
> >> -                      status_to_str(status));
> >> +               KSFT_PRINT_MSG(status, PREFIX "HugeTLB read regression=
 test...%s\n",
> >> +                              status_to_str(status));
> >>                 close(fd);
> >> -               if (status =3D=3D TEST_FAILED)
> >> -                       return -1;
> >>
> >>                 fd =3D create_hugetlbfs_file(&file_stat);
> >> -               if (fd < 0)
> >> -                       goto create_failure;
> >> -               printf(PREFIX "HugeTLB read HWPOISON test...\n");
> >> +               ksft_print_msg(PREFIX "HugeTLB read HWPOISON test...\n=
");
> >>                 status =3D test_hugetlb_read_hwpoison(fd, file_stat.f_=
bsize,
> >>                                                     wr_chunk_sizes[i],=
 false);
> >> -               printf(PREFIX "HugeTLB read HWPOISON test...%s\n",
> >> -                      status_to_str(status));
> >> +               KSFT_PRINT_MSG(status, PREFIX "HugeTLB read HWPOISON t=
est..%s\n",
> >> +                              status_to_str(status));
> >>                 close(fd);
> >> -               if (status =3D=3D TEST_FAILED)
> >> -                       return -1;
> >>
> >>                 fd =3D create_hugetlbfs_file(&file_stat);
> >> -               if (fd < 0)
> >> -                       goto create_failure;
> >> -               printf(PREFIX "HugeTLB seek then read HWPOISON test...=
\n");
> >> +               ksft_print_msg(PREFIX "HugeTLB seek then read HWPOISON=
 test...\n");
> >>                 status =3D test_hugetlb_read_hwpoison(fd, file_stat.f_=
bsize,
> >>                                                     wr_chunk_sizes[i],=
 true);
> >> -               printf(PREFIX "HugeTLB seek then read HWPOISON test...=
%s\n",
> >> -                      status_to_str(status));
> >> +               KSFT_PRINT_MSG(status, PREFIX "HugeTLB seek then read =
HWPOISON test...%s\n",
> >> +                              status_to_str(status));
> >>                 close(fd);
> >> -               if (status =3D=3D TEST_FAILED)
> >> -                       return -1;
> >>         }
> >>
> >> -       return 0;
> >> -
> >> -create_failure:
> >> -       printf(ERROR_PREFIX "Abort test: failed to create hugetlbfs fi=
le\n");
> >> -       return -1;
> >> +       ksft_finished();
> >>  }
> >> --
> >> 2.42.0
> >>
> >>
> >
>
> --
> BR,
> Muhammad Usama Anjum

