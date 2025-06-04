Return-Path: <linux-kselftest+bounces-34331-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FF35ACE3FC
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Jun 2025 19:56:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D6D01896B34
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Jun 2025 17:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4145D1FBCA7;
	Wed,  4 Jun 2025 17:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nOaKsagc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D4BC141987;
	Wed,  4 Jun 2025 17:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749059773; cv=none; b=bJVsDNg/f39H0H1Cd/W5IA5bYGikkk25As1o8q7Gxx45RULmj3dyl2EF56MsJDIbsL3Ln1NGcwyj9vwInIaPIYn3bzL4UfWjYCDUr/ZLF599MYpvu2BPPiIl20X04gB4hErR6QNxHVsIN1so3QZ5DcpUvsXPVbo+DNxuM7JASiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749059773; c=relaxed/simple;
	bh=mYG5hiT0eBPeGiNJXk7MDFsaXtzwu/f1E+RCpzRa3D0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RZFmrrYxOHApjdngbMIb3fXlhEOjhVweYl2D4f98YAkOTs1YmZSRqPdPbjUMQuU+WOU3B1ctWkRvC/X9Vqwer3EnFxJlYXY83VXsHTZZLQ+l/TSnm+ybN5Qm2mmaPMOXcpwEgUefubI8TajX7fddVhg9PM+OuYKANSk9LnHjf1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nOaKsagc; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6fae04a3795so2100286d6.3;
        Wed, 04 Jun 2025 10:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749059770; x=1749664570; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gnvEKTcmmLwrMRljEPpuN+GEAVNuq2EmP2jnZ/w/9S8=;
        b=nOaKsagce3dNeRTFveXQj9SIdqWLqfuvWpOnHp4rhMtO6RC8YZz3wxQ/JJjEZIkwzL
         YgcvvwLdklQhNCs58LU2E4mrU9XF49izfUVDYa0K8HHcd3GPenu5tz82xhJ6OXGSyn/v
         WrnCDcEGyI9IExtJVlmfKvxTS+o2s20O1xtnmGmnRtA4Xy9/K2tiffidwLooNvrBujAP
         4ytrzJ46kw0C15sufVvkGoHrkMeXUKAhfstXI26/E28Y3LiHe1R5Hjng5GeisoegyMT5
         XGQri+yCKZgbgnEPE42NFRcDgiZ6Lk5JS3bgpxbyOvGAwPZ6wVQhkVxr9lqrna5GSsM6
         yBgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749059770; x=1749664570;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gnvEKTcmmLwrMRljEPpuN+GEAVNuq2EmP2jnZ/w/9S8=;
        b=HSz0pOQ/pwBEto8yAKZwPBvFWu5JTknWXrfEf1tTSs8Jh2iXuMkpw8r3M/LlHSYXwy
         VzyWD0azHz8abLEqre81o7vUuweOkOX3ftbBg5wJX68pyiQZpTFvMNVZALs+CrFjbvrx
         2hZjtD0jLk0H8f0zm4zADahae4YS88FqA9xpfL9qNbSJM4PACHo8ThTQV3uia3ZEjnPf
         PezGJlVzRlvLuFQsvodORKVN9hVvURA7suzBnUOhGhWM3td2b5DpyMIJlmkeIRCG6UKF
         d3kcHpB5K6kYRhODlxAt3A+UH9gF7SuAWubdHDimKxTeiUGw4QpTCNSMSB0lO7ZbqshI
         nPjw==
X-Forwarded-Encrypted: i=1; AJvYcCUKoieTAlQ57AwiAY0DMhY2uRnDbseix54GzJC/ujjXlifpRqsW0Ou4kVM3hWWv9TLcq/FssdPKBeqsVlc=@vger.kernel.org, AJvYcCX6ZidZQ4Z+tIhgO0cLYSBDRX3btZVAMREe27azylUR32JFD/s/ha+U+1WgdXE8/RfL8EDxs43NY04EMe9yx37d@vger.kernel.org
X-Gm-Message-State: AOJu0YxiX/XvXLhiXe+S182UC0uwAnoza/9xOP3ONlg1Xeb+uItMKWxg
	QPHQG4bjWcckdQhtQXnei664I8wRviUwGnuj1C2Y18zUq4V2+HWYvVpAO08N45R/9dzBC/PzNGk
	JrM2mKwtP9Dj+/53REvo4rvROLRLjXuc=
X-Gm-Gg: ASbGncu6o1Ma5xL7hs3Uk9bmCRlccxwHe/2PA6w69lJ8+5dlL1ilX7fhriv5xyPz/Oj
	7xuXk/K736dkGexNuhHqL4XKIkiNol041l6quIC+gsy8msmPwYvdV+s0gj1q2U8euV/8Isk9FcZ
	Sn7UgXqaDCUo9yAVIY1rR1wmlBrDJKAQFuKg==
X-Google-Smtp-Source: AGHT+IHgPYUhO6aBFmp/KGRv6pAgLdkGthbSxhqN+51/VWLbrFeRdK6jUDS8WlqrwQbaAL5J6gzzwUPAhrVoQpkLbqw=
X-Received: by 2002:a05:6214:242e:b0:6e8:fbb7:6764 with SMTP id
 6a1803df08f44-6faf6fe41aemr57817946d6.45.1749059769696; Wed, 04 Jun 2025
 10:56:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250524083618.29615-1-suresh.k.chandrappa@gmail.com>
In-Reply-To: <20250524083618.29615-1-suresh.k.chandrappa@gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Wed, 4 Jun 2025 10:55:58 -0700
X-Gm-Features: AX0GCFtcpSexHVVUqZ5FfuA5ekkM5E7Wr5rglkeeWBhvyX4PPBqfBC5CRQilNqg
Message-ID: <CAKEwX=MGgNw6rq1Y+gao=_AKP+hjuck-dafeaEs18YB21gGQKA@mail.gmail.com>
Subject: Re: [PATCH] selftests: cachestat: add tests for mmap and /proc/cpuinfo
To: Suresh K C <suresh.k.chandrappa@gmail.com>
Cc: hannes@cmpxchg.org, shuah@kernel.org, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 24, 2025 at 1:36=E2=80=AFAM Suresh K C
<suresh.k.chandrappa@gmail.com> wrote:
>
> From: Suresh K C <suresh.k.chandrappa@gmail.com>
>
> Add a test case to verify cachestat behavior with memory-mapped files
> using mmap(). This ensures that pages accessed via mmap are correctly
> accounted for in the page cache.
>
> Also add a test for /proc/cpuinfo to validate cachestat's handling of
> virtual files in pseudo-filesystems. This improves test coverage for

Hmm, it's been awhile since I wrote these tests, but isn't there
already a test for /proc/* files?

> edge cases involving non-regular files.
>
> Tested on x86_64 with default kernel config.
>
> Signed-off-by: Suresh K C <suresh.k.chandrappa@gmail.com>
> ---
>  .../selftests/cachestat/test_cachestat.c      | 69 ++++++++++++++++++-
>  1 file changed, 67 insertions(+), 2 deletions(-)
>
> diff --git a/tools/testing/selftests/cachestat/test_cachestat.c b/tools/t=
esting/selftests/cachestat/test_cachestat.c
> index 632ab44737ec..81e7f6dd2279 100644
> --- a/tools/testing/selftests/cachestat/test_cachestat.c
> +++ b/tools/testing/selftests/cachestat/test_cachestat.c
> @@ -22,7 +22,7 @@
>
>  static const char * const dev_files[] =3D {
>         "/dev/zero", "/dev/null", "/dev/urandom",
> -       "/proc/version", "/proc"
> +       "/proc/version","/proc/cpuinfo","/proc"
>  };
>
>  void print_cachestat(struct cachestat *cs)
> @@ -202,6 +202,65 @@ static int test_cachestat(const char *filename, bool=
 write_random, bool create,
>         return ret;
>  }
>
> +bool test_cachestat_mmap(void){
> +
> +       size_t PS =3D sysconf(_SC_PAGESIZE);
> +       size_t filesize =3D PS * 512 * 2;;
> +       int syscall_ret;
> +       size_t compute_len =3D PS * 512;
> +       struct cachestat_range cs_range =3D { PS, compute_len };
> +       char *filename =3D "tmpshmcstat";
> +       unsigned long num_pages =3D compute_len / PS;
> +       struct cachestat cs;
> +       bool ret =3D true;
> +       int fd =3D open(filename, O_RDWR | O_CREAT | O_TRUNC, 0666);
> +       if (fd < 0) {
> +               ksft_print_msg("Unable to create mmap file.\n");
> +               ret =3D false;
> +               goto out;
> +       }
> +       if (ftruncate(fd, filesize)) {
> +               ksft_print_msg("Unable to truncate mmap file.\n");
> +               ret =3D false;
> +               goto close_fd;
> +       }
> +       if (!write_exactly(fd, filesize)) {
> +               ksft_print_msg("Unable to write to mmap file.\n");
> +               ret =3D false;
> +               goto close_fd;
> +       }
> +       char *map =3D mmap(NULL, filesize, PROT_READ | PROT_WRITE, MAP_SH=
ARED, fd, 0);
> +       if (map =3D=3D MAP_FAILED) {
> +               ksft_print_msg("mmap failed.\n");
> +               ret =3D false;
> +               goto close_fd;
> +       }
> +
> +       for (int i =3D 0; i < filesize; i++) {
> +               map[i] =3D 'A';
> +       }
> +       map[filesize - 1] =3D 'X';
> +
> +       syscall_ret =3D syscall(__NR_cachestat, fd, &cs_range, &cs, 0);
> +
> +       if (syscall_ret) {
> +               ksft_print_msg("Cachestat returned non-zero.\n");
> +               ret =3D false;
> +       } else {
> +               print_cachestat(&cs);
> +               if (cs.nr_cache + cs.nr_evicted !=3D num_pages) {
> +                       ksft_print_msg("Total number of cached and evicte=
d pages is off.\n");
> +                       ret =3D false;
> +               }
> +       }
> +
> +close_fd:
> +       close(fd);
> +       unlink(filename);
> +out:
> +       return ret;
> +}
> +

This looks 90% the same as another test. Are we literally just adding
the mmap step to test_cachestat and call it a new test?

Can we at least refactor things?

