Return-Path: <linux-kselftest+bounces-36980-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 307D4B0055C
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 16:36:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07C0C1C45746
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 14:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B846522E3FA;
	Thu, 10 Jul 2025 14:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RBt9DDfX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14AFB17B421;
	Thu, 10 Jul 2025 14:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752158168; cv=none; b=B7eBx121f1Attk9nlpwkw+38pSa/gG9550Ei5vRrAvbsUQm4nJNzt22VWfwfYY6qPasj+9Y5Yx3H012fxqk8TXc9ndjQzp/uELrFbt5s2Z0cGt9hI137RqiJw9PxI3llBmcWNDmhLh/AaBd2paaqTZ6gXUd/KR8mYaUdIm6JSfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752158168; c=relaxed/simple;
	bh=1N4tkziDIAUaH31nEsb55mcNpfly+0L/hLWGifRmUkk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gc4KJKwnPTYu1NnX/aQ08JYn8d5mQKJkMalMjexeIZ9kpEO3khcu5Xs9D6mM1LRn+hBQbDY+ObYc1xU3LX7VYdSx0G/S+Hf6PB2ACLaOLmVqoecBTItSAZvhZRqWSlb0ty9z1wj9FFfAB0Nzayyo/g7kO9Q+d2PL7DDsPN10G9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RBt9DDfX; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6fad8b4c927so9619316d6.0;
        Thu, 10 Jul 2025 07:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752158165; x=1752762965; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4qJGxOWQ8Up5dWYJdXH7usil2iamd9hTDCPtvQ0awIQ=;
        b=RBt9DDfX7OBpJP9zAv30TixS52lELUO4rG5zIomgnGGJSytHBxvPpV5Wjv3QNWSW/s
         zfNh6OfwzgUWodPOaYrfgW/0Nb0hKiiDh8FspcUiG4bSc3MFcHPmjyiBoZrX4bof4nr8
         Pide9GMbcsjvQgejxW2RffI4QFAqnVXmuuT3a/VBWukph7tEPi9nkT5u3tbTt2IFzZX0
         7OlvWiIYOUO2Xlijl+eqkPjKBjfLUG+Bpz0xP4rYBFqpJMYugCF0ntj9CWZJ6JbJmOmf
         ka9fb53uEDcI50dU5k6xcYtApd8zLO7qb9+aHo25ctRUHQpfzkaB9Dl+TnHJbJtAaapS
         ldcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752158165; x=1752762965;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4qJGxOWQ8Up5dWYJdXH7usil2iamd9hTDCPtvQ0awIQ=;
        b=dGWyhqCUfdvjUUDhLWFc24LIh3JksCVUNVlNR8gKrqLYsG8hy+SA74fKYdVmhhgC1w
         NNiCdcQdAIXi7XI/BpnW3DDB6RmDmI0mDtiijwgjyMts9BVG3lDuD1LPjATmXoz+lcT6
         eKXbjRloyCCr8/B1eXgAbilfr5L4uZutm1xatjeod8KbksnUUSye5XSZircGnfJHeiJa
         nswftIwUcq9HvHBkEJutkNSHnohZCCjmDDMEkUFjpyn0nvRU9P3dSNxgagHCcIpBCs72
         tdU5L4++DlWIubyRzI2DCb2LLsO+amBoKG4vjPnoYcwGlBxlYGntQN61o2xeokReBOGK
         jI6g==
X-Forwarded-Encrypted: i=1; AJvYcCUaR/fr9DJGVv/+YDBQXqPCU5LoPbJQwlUlB3pkfI2bMDIMVyTV25iYoEEbipu1p+0vGQwarCFCbZLtjSS++6li@vger.kernel.org, AJvYcCWVAlu36FFWZqGhyBcuVM4tYajMF+edDK2yV7+QxH/0ZSzAW4FcTEIYNbc/RE59/jDfR2SFVodj/2R/ONE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8a6JfsH7/yUEc6fjbAjMRgWEoj2msAcpAQTp2grJw7KQqtPmu
	RJ3pg+ANPH5lNvAs3YH2iRggtLHscrXJoIJf6+UHTANMl3DKl74IMkL9vNBnoN9dRHaKMMSxZGd
	WTSYY/Rul6h0x2XRcy4sZZA44T93w/54=
X-Gm-Gg: ASbGncug90UAy+Hj9z8ZoU64FJtbjzuOcBzD/CHchIGlWmQkA/5n6Ft67x0dB8lqDGB
	2snACb/k3C6tYOH6fvLB3E6EmRUCYpbDSS0hoh2la+xVyTd9LJXpHY7xX/z3yPm3TlgA9QwXV1O
	H+Y1G4whK+JtyDwBQv7Gzc1O5uF9zS/2TJP9LFG0OmYs8=
X-Google-Smtp-Source: AGHT+IEKim1PUIFElOcNyHSqrLn01w9htemvtx7RLvrE5/uf9zQTKhdPq+4LhB5J8wrFv+2K0gTROANsR4kOkYJeXQU=
X-Received: by 2002:ad4:5f0e:0:b0:701:775:70b8 with SMTP id
 6a1803df08f44-7049505d74emr63722756d6.38.1752158164505; Thu, 10 Jul 2025
 07:36:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250709174657.6916-1-suresh.k.chandrappa@gmail.com>
In-Reply-To: <20250709174657.6916-1-suresh.k.chandrappa@gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Thu, 10 Jul 2025 07:35:53 -0700
X-Gm-Features: Ac12FXyoLktlmX39quFWyEEFVsEtk0kX_j9HtNIamMLSlCQffuIUqfEi_lx_asM
Message-ID: <CAKEwX=M6WOoE+A=6DVdAjR6J2tyULLGAqiZ6325Fn7R=Tn=igQ@mail.gmail.com>
Subject: Re: [PATCH v3] selftests: cachestat: add tests for mmap Refactor and
 enhance mmap test for cachestat validation
To: Suresh K C <suresh.k.chandrappa@gmail.com>
Cc: hannes@cmpxchg.org, joshua.hahnjy@gmail.com, shuah@kernel.org, 
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 9, 2025 at 10:47=E2=80=AFAM Suresh K C
<suresh.k.chandrappa@gmail.com> wrote:
>
> From: Suresh K C <suresh.k.chandrappa@gmail.com>
>
> This patch merges the previous two patches into a single,
> cohesive test case that verifies cachestat behavior with memory-mapped fi=
les using mmap().
> It also refactors the test logic to reduce redundancy, improve error repo=
rting, and clarify failure messages for both shmem and mmap file types.
>
> Changes since v2:
>
> - Merged the two patches into one as suggested
> - Improved error messages for better clarity
>
> Tested on x86_64 with default kernel config.
>
> Signed-off-by: Suresh K C <suresh.k.chandrappa@gmail.com>
> ---
>  .../selftests/cachestat/test_cachestat.c      | 66 +++++++++++++++----
>  1 file changed, 55 insertions(+), 11 deletions(-)
>
> diff --git a/tools/testing/selftests/cachestat/test_cachestat.c b/tools/t=
esting/selftests/cachestat/test_cachestat.c
> index 632ab44737ec..18188d7c639e 100644
> --- a/tools/testing/selftests/cachestat/test_cachestat.c
> +++ b/tools/testing/selftests/cachestat/test_cachestat.c
> @@ -33,6 +33,11 @@ void print_cachestat(struct cachestat *cs)
>         cs->nr_evicted, cs->nr_recently_evicted);
>  }
>
> +enum file_type {
> +       FILE_MMAP,
> +       FILE_SHMEM
> +};
> +
>  bool write_exactly(int fd, size_t filesize)
>  {
>         int random_fd =3D open("/dev/urandom", O_RDONLY);
> @@ -201,8 +206,19 @@ static int test_cachestat(const char *filename, bool=
 write_random, bool create,
>  out:
>         return ret;
>  }
> +const char* file_type_str(enum file_type type) {
> +       switch (type) {
> +               case FILE_SHMEM:
> +                       return "shmem";
> +               case FILE_MMAP:
> +                       return "mmap";
> +               default:
> +                       return "unknown";
> +       }
> +}
>
> -bool test_cachestat_shmem(void)
> +
> +bool run_cachestat_test(enum file_type type)
>  {
>         size_t PS =3D sysconf(_SC_PAGESIZE);
>         size_t filesize =3D PS * 512 * 2; /* 2 2MB huge pages */
> @@ -212,27 +228,49 @@ bool test_cachestat_shmem(void)
>         char *filename =3D "tmpshmcstat";
>         struct cachestat cs;
>         bool ret =3D true;
> +       int fd;
>         unsigned long num_pages =3D compute_len / PS;
> -       int fd =3D shm_open(filename, O_CREAT | O_RDWR, 0600);
> +       if (type =3D=3D FILE_SHMEM)
> +               fd =3D shm_open(filename, O_CREAT | O_RDWR, 0600);
> +       else
> +               fd =3D open(filename, O_RDWR | O_CREAT | O_TRUNC, 0666);
>
>         if (fd < 0) {
> -               ksft_print_msg("Unable to create shmem file.\n");
> +               ksft_print_msg("Unable to create %s file.\n",file_type_st=
r(type));
>                 ret =3D false;
>                 goto out;
>         }
>
>         if (ftruncate(fd, filesize)) {
> -               ksft_print_msg("Unable to truncate shmem file.\n");
> +               ksft_print_msg("Unable to truncate %s file.\n",file_type_=
str(type));
>                 ret =3D false;
>                 goto close_fd;
>         }
> -
> -       if (!write_exactly(fd, filesize)) {
> -               ksft_print_msg("Unable to write to shmem file.\n");
> -               ret =3D false;
> -               goto close_fd;
> +       switch (type){
> +               case FILE_SHMEM:
> +                       if (!write_exactly(fd, filesize)) {
> +                               ksft_print_msg("Unable to write to file.\=
n");
> +                               ret =3D false;
> +                               goto close_fd;
> +                       }
> +                       break;
> +               case FILE_MMAP:
> +                       char *map =3D mmap(NULL, filesize, PROT_READ | PR=
OT_WRITE, MAP_SHARED, fd, 0);
> +                       if (map =3D=3D MAP_FAILED) {
> +                               ksft_print_msg("mmap failed.\n");
> +                               ret =3D false;
> +                               goto close_fd;
> +                       }
> +                       for (int i =3D 0; i < filesize; i++) {
> +                               map[i] =3D 'A';
> +                       }
> +                       break;
> +               default:
> +                       ksft_print_msg("Unsupported file type.\n");
> +                       ret =3D false;
> +                       goto close_fd;
> +                       break;
>         }
> -
>         syscall_ret =3D syscall(__NR_cachestat, fd, &cs_range, &cs, 0);
>
>         if (syscall_ret) {
> @@ -308,12 +346,18 @@ int main(void)
>                 break;
>         }
>
> -       if (test_cachestat_shmem())
> +       if (run_cachestat_test(FILE_SHMEM))
>                 ksft_test_result_pass("cachestat works with a shmem file\=
n");
>         else {
>                 ksft_test_result_fail("cachestat fails with a shmem file\=
n");
>                 ret =3D 1;
>         }
>
> +       if (run_cachestat_test(FILE_MMAP))
> +               ksft_test_result_pass("cachestat works with a mmap file\n=
");
> +       else {
> +               ksft_test_result_fail("cachestat fails with a mmap file\n=
");
> +               ret =3D 1;
> +       }
>         return ret;
>  }
> --
> 2.43.0
>

Code LGTM, and the test passed on my system (x86-64 too though). FWIW:

Tested-by: Nhat Pham <nphamcs@gmail.com>
Acked-by: Nhat Pham <nphamcs@gmail.com>

Thanks for the test contribution, Suresh! And thanks for the review
help, Joshua :)

