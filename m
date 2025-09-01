Return-Path: <linux-kselftest+bounces-40431-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E06FB3E3AE
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Sep 2025 14:51:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44AE6164F27
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Sep 2025 12:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEF1832A3C4;
	Mon,  1 Sep 2025 12:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Uru6o/JA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B361B3277BF
	for <linux-kselftest@vger.kernel.org>; Mon,  1 Sep 2025 12:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756731061; cv=none; b=YMlXsvwEexocCHVhKDPvv7HPNQOaBFTAhFh+82jUgGD2DgLqg0NkmwbhREHykHVFVeySzzl0wNE+iBMLkFxwZegMGMajnWLqk+Juw6g7X6B20PVYKHCoPyjbD6whuC6cWBmh+rcA/kUgyMXyQuidz1JsrrIt79w/7sqWuCq6v64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756731061; c=relaxed/simple;
	bh=SFLY856JaK+DPw4da8ArP2uz/kcaMmLaqGMn/UNQ4QE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bj6u5eN8wobWo0nni71KQijr7NZYDnjQXouQ8DCqY5utxziKj9G12CevgD5aYdySpuimpzoz2Fz480AyUBczxKDwRLgvvK8LrEioMigUDWdgY3SH/aNNNWkUAuS+EjsZ0Ctszsyu1QtO0iE5fEkgvxcON8IBsM9yGeBKg3NilQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Uru6o/JA; arc=none smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-8960d3a6c2fso479176241.0
        for <linux-kselftest@vger.kernel.org>; Mon, 01 Sep 2025 05:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1756731058; x=1757335858; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RojBF6ZwlxZFZwX/0b1dSoMQba7iu3ojoy33z4p+HaQ=;
        b=Uru6o/JAk9AFWovJhxQ9QupxivVbSko0ZyJf0OoP0lboryJC9dVeURBWQDPISewhOi
         5iZUt+oz1qcKfkhJ1kKLa74GJYW3HebPNc1A1w5wANcAYcwBgrhUyhGZ6mEyYbnLqBkh
         nbYVja9Dy1dyVWLt7IgsS2ug/s3PUklLy1WPqfYm//tI66rjRlYfyR1+fl7UvuJ+lk6N
         Y/3pyTnQe6sF2J3rW51k1QZVAsvLJIJFZMfZu87e8Ff4Iq7DgWilNoKUL1sX0WdAWOJZ
         gJdbn6b2hiWdBrVzYjeMr6lFwhBuB4yuYsAuxiObgyiDGAkIo2TqrJOC9yiOtFjr9Kat
         KtXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756731058; x=1757335858;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RojBF6ZwlxZFZwX/0b1dSoMQba7iu3ojoy33z4p+HaQ=;
        b=nD9It/gdb56WoR11By6oyDLlXbGUpxD0XaeBxWj15kIk12YhB/O7F2JZyiWFtJ7aY4
         y/mEU131BF/1VNQOpag0ENKI4TVOmcirnreWQkjEmmEnauhqiyiEw7hMS/Vkho87d5lR
         K21rq8O/cDOx86GSVjKvUqtlm2FqOzTCjduC3abdIywJoMH4so8yDIFEkFQEFAht+fx4
         pyg8dLRDcwmtwF0bkCxFjvywSBErPsHdvm/9hT2y+hvegZbnxmnvnL49l48MLsAV5ZL0
         BnTmm77M8+A+hPPEWsGMjuMKJtVM567nRl/+JT5WoLxjlEh+g3PgMBK0Ui+vZKoMhCW6
         yeAg==
X-Forwarded-Encrypted: i=1; AJvYcCXi45bq6Ec9h8C9N5Tpk/EPhPYhslqYqB+2nm0MsKqXESS9nzIoj3kD8ffKq3JdF8zV4Z+YaGsZ5gI+nv3hEhg=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywn2rM3eoMUerZOywoeV5XVSlV/SI8LAfvPMMv8fL1t6gMF7v8J
	/PLE19BFXXHFy+VRVbpRkvVlyDXyNpCe8SSkddgjsNsuqzHNcXcMfP2tUz/wY7XD7mUL9vGCRv7
	bazdF+y2h8vR/1sTWPMH/khcAnsNPkjpksA7MQEawBA==
X-Gm-Gg: ASbGnctpZdeNyKgM1o+v1AP0lrTpxKXnm+/FgOzLlVDa2q3NzgjXZBj/zowsO+8Z4VG
	ykVZrhIygA76dpaJ0rkGhdtQa2Y4Idfo8PvLl44E4KgZJXnzmreui758s8K2MZPjBP4X/9kwC0j
	X+WmYxye2Paj4QooO8kxrasb/7pIYJTjqTDBosgLF9SzOXsWy4yMwtstEmyOd++h/E6sp6YKvdz
	em3BxhkPpY/bWWsBYIwJr/tqJ7cB4M=
X-Google-Smtp-Source: AGHT+IHr9UCL19brxa2iKAokFlw9VR4MD7FOmMAqfdtgQT+g1vRFoxL2i+IO+GvaPMnobuW4oatWNjOm6C5v2o0ix98=
X-Received: by 2002:a05:6102:6447:b0:523:6f5:5b18 with SMTP id
 ada2fe7eead31-52b1b2eca8fmr2157651137.9.1756731058441; Mon, 01 Sep 2025
 05:50:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250825145719.29455-1-linyongting@bytedance.com>
 <20250825145719.29455-5-linyongting@bytedance.com> <18530429-cac2-42a4-891e-24033dc54461@oracle.com>
In-Reply-To: <18530429-cac2-42a4-891e-24033dc54461@oracle.com>
From: Yongting Lin <linyongting@bytedance.com>
Date: Mon, 1 Sep 2025 20:50:47 +0800
X-Gm-Features: Ac12FXzEc3BxXpFrvQO5A4KgSDp4VDpvBoAfQRVXMGVwFUBvUT7kQaY8ahX-wSk
Message-ID: <CAFuXZ_UY6RrOVmTayW-DdxQX9TE978LPx7ad=Pzr01j1cZ4o2Q@mail.gmail.com>
Subject: Re: [External] Re: [PATCH 4/8] mshare: selftests: Add test case
 shared memory
To: Anthony Yznaga <anthony.yznaga@oracle.com>
Cc: khalid@kernel.org, shuah@kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, akpm@linux-foundation.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 29, 2025 at 9:00=E2=80=AFAM Anthony Yznaga
<anthony.yznaga@oracle.com> wrote:
>
> Hi Yongting,
>
> Thank you for doing this. This is a great start for testing mshare.
> I do have some comments below.
>
> On 8/25/25 7:57 AM, Yongting Lin wrote:
> > This test case aims to verify the basic functionalities of mshare.
> >
> > Create a mshare file and use ioctl to create mapping for host mm
> > with supportive flags, then create two processes to map mshare file
> > to their memory spaces, and eventually verify the correctiness
> > of sharing memory.
> >
> > Signed-off-by: Yongting Lin <linyongting@bytedance.com>
> > ---
> >   tools/testing/selftests/mshare/basic.c | 81 +++++++++++++++++++++++++=
-
> >   1 file changed, 79 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/testing/selftests/mshare/basic.c b/tools/testing/sel=
ftests/mshare/basic.c
> > index 35739b1133f7..2347d30adfee 100644
> > --- a/tools/testing/selftests/mshare/basic.c
> > +++ b/tools/testing/selftests/mshare/basic.c
> > @@ -3,9 +3,86 @@
> >   #include "../kselftest_harness.h"
> >   #include "util.c"
> >
> > -TEST(basic)
> > +#define STRING "I am Msharefs"
> > +
> > +FIXTURE(basic)
> > +{
> > +     char filename[128];
> > +     size_t align_size;
> > +     size_t allocate_size;
> > +};
> > +
> > +FIXTURE_VARIANT(basic) {
> > +     /* decide the time of real mapping size besed on align_size */
> > +     size_t map_size_time;
> > +     /* flags for ioctl */
> > +     int map_flags;
> > +};
> > +
> > +FIXTURE_VARIANT_ADD(basic, ANON_512G) {
> > +     .map_size_time =3D 1,
> > +     .map_flags =3D MAP_ANONYMOUS | MAP_SHARED | MAP_FIXED,
> > +};
> > +
> > +FIXTURE_VARIANT_ADD(basic, HUGETLB_512G) {
> > +     .map_size_time =3D 1,
> > +     .map_flags =3D MAP_ANONYMOUS | MAP_HUGETLB | MAP_SHARED | MAP_FIX=
ED,
> > +};
> > +
> > +FIXTURE_VARIANT_ADD(basic, ANON_1T) {
> > +     .map_size_time =3D 2,
> > +     .map_flags =3D MAP_ANONYMOUS | MAP_SHARED | MAP_FIXED,
> > +};
> > +
> > +FIXTURE_VARIANT_ADD(basic, HUGETLB_1T) {
> > +     .map_size_time =3D 2,
> > +     .map_flags =3D MAP_ANONYMOUS | MAP_HUGETLB | MAP_SHARED | MAP_FIX=
ED,
> > +};
> > +
> > +FIXTURE_SETUP(basic)
> >   {
> > -     printf("Hello mshare\n");
> > +     int fd;
> > +
> > +     self->align_size =3D mshare_get_info();
> > +     self->allocate_size =3D self->align_size * variant->map_size_time=
;
> > +
> > +     fd =3D create_mshare_file(self->filename, sizeof(self->filename))=
;
> > +     ftruncate(fd, self->allocate_size);
> > +
> > +     ASSERT_EQ(mshare_ioctl_mapping(fd, self->allocate_size, variant->=
map_flags), 0);
>
> The tests should differentiate between how much VA space is allocated to
> an mshare region (i.e with ftruncate()) and how much memory is allocated
> within an mshare region through the ioctl. While the bounds of an mshare
> region need to be aligned to 512 GB, the memory allocated within it does
> not. Right now the tests will try to map 512 GB or 1 TB of anon or
> hugetlb memory in an mshare region which will fail on smaller systems to
> due to insufficient memory. Better to allocate smaller amounts so the
> tests can run on more systems.
>
> Anthony

I Changed my code to allocate a smaller chunk of memory (i.e.
4K/8K/2M/4M), and these tests are passed.

But I found something different:
step1:  ftruncate a mshare file to 512G
step2:  ioctl map 8K
step3: but after that, I am going to mmap 8K to a process but it
fails, then I have up to mmap 512G memory to process.
step4: Accessing the memory within the 8K boundary is fine but get
segfault after exceling the boundary (as the vma of host mm only holds
a memory region of 8K)

Should the mmap region keep consistent with the ioctl map region in
size? (currently, ioctl map region is 8K, but mmap region is 512G)

Yongting
>
> > +     close(fd);
> > +}
> > +
> > +FIXTURE_TEARDOWN(basic)
> > +{
> > +     ASSERT_EQ(unlink(self->filename), 0);
> > +}
> > +
> > +TEST_F(basic, shared_mem)
> > +{
> > +     int fd;
> > +     void *addr;
> > +     pid_t pid =3D fork();
> > +
> > +     ASSERT_NE(pid, -1);
> > +
> > +     fd =3D open(self->filename, O_RDWR, 0600);
> > +     ASSERT_NE(fd, -1);
> > +
> > +     addr =3D mmap(NULL, self->allocate_size, PROT_READ | PROT_WRITE,
> > +                    MAP_SHARED, fd, 0);
> > +     ASSERT_NE(addr, MAP_FAILED);
> > +
> > +     if (pid =3D=3D 0) {
> > +             /* Child process write date the shared memory */
> > +             memcpy(addr, STRING, sizeof(STRING));
> > +             exit(0);
> > +     }
> > +
> > +     ASSERT_NE(waitpid(pid, NULL, 0), -1);
> > +
> > +     /* Parent process should retrieve the data from the shared memory=
 */
> > +     ASSERT_EQ(memcmp(addr, STRING, sizeof(STRING)), 0);
> >   }
> >
> >   TEST_HARNESS_MAIN
>

