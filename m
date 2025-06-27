Return-Path: <linux-kselftest+bounces-35981-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0681AEBDB4
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Jun 2025 18:42:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94AA83B17D2
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Jun 2025 16:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6937529E115;
	Fri, 27 Jun 2025 16:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mTXrsa1v"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9925B1C8604;
	Fri, 27 Jun 2025 16:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751042515; cv=none; b=RmbqDzeovzSaXiuM6uKXTSNvit4a8dca7ao59u8yOTIVawgUBCCnrU3u6YQm2AYaFxz4hnWt/PjoKyAtJ8dbUXQ8bmpoNrSe1wil/uOKI5hnxA2OLhgWSEFQkWgJxSt/S5dI2ArKDZPfFPYq12UCh47Ve8Jf5atjjOuzX4rF2uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751042515; c=relaxed/simple;
	bh=SGpA6lL2Y+L9/jTuiLMaJISp3BrcOqJJJhs9vTlECnQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mwV33iLyihphTF+FRXU/E10+69QmQj3IGFL0Izmjre57/sq7OkOGdRENiwPZ0PBtPLTPqQ5oAiGN/ljUexrGodujpEtWadLsHyjCDN1gNcqsdkzvz2E73NeGtKivz7aV7HkSAczyV6rjgAKymnHCmSO6WgxUHbZmWu1q3pt7stY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mTXrsa1v; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6fae04a3795so27859926d6.3;
        Fri, 27 Jun 2025 09:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751042512; x=1751647312; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fyipC4Ey3fSMiqKcNDa+7P48q0NzX69aJ2eDYPmsvlc=;
        b=mTXrsa1vg0PQ8vfMPnQexWcEX8/mXK326JuVZvdM9zIpfgIirD3JpnUhacH5EV41s6
         49th/tXWhGD89tqDzT2rrJUg6sUBusRMM/xcCec+O37HET5bUrRTSVeIkOPBX90300dY
         XSStjX11oE/tqbevlDDyds/ZrThk111zBL0vjQ7YJKewXByH7nahS5Zz3kNOy916Xz/j
         zM2kTumvx9tkCdNnDl/PvjUHz01Lns5ptMUimdplimHnOdkhu1fPlxX0e1rW6RTE0hVh
         Ly6PiVYKgivMK86SUaiSlLu3tlUC5bTyOFjjxNtHlhF6hver9rL12SkPqupQ6mVzMeHw
         1o3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751042512; x=1751647312;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fyipC4Ey3fSMiqKcNDa+7P48q0NzX69aJ2eDYPmsvlc=;
        b=mgJEMNHL+RVTNcJRpI3ZHUugDnDIP6jBo6px1eN0TaaHGgl4eHPx8caj6P6Eo40vvu
         h28XjewbIDPLWv4Kp1Mg2TdYY0bqUGw/Jv/y80IJ5B2U4igEoH5Ff+/zUw4wPcaDaCcS
         jQNvnBTAtb14oqUBa8x6Z63cxgR0n+5nH3sIjHBTdaAOpwNA+lONqK4jtvBT83SpJ72w
         aehOANETWNpCptzbwFp81dmY0v/cXAXTsji1zDq1HBdxAlvjxzY8JDHvSKFuxU2KYjxs
         Jv4TQUEfqenDZi5l9lQ4uls3Zlo9Q+Ejp04RA5iEdimuOY0T/InnaZX1i/+oE31TyThU
         cwMQ==
X-Forwarded-Encrypted: i=1; AJvYcCXaB+NwFDHbTJOK4MaWyim/V9wXCbPsX2czY0DxF3gsFG5JydhF2Uffme9WOe3U6GMn2n4Z6X46eRC/ElfrO0vC@vger.kernel.org, AJvYcCXq40IN1WHwavrmvlAe4iO8gZ41fMmiOactsjquHy50iZVl90Kd5VbFmLTY40V+MkGgNbQwC7xYpR9UjWA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyA0ap4fhcamYJxxhLkQ4zQ75lKzcMVWo/qhJOAL4Gp+9Xh5yjc
	kfnnwnLMEWgeQp6U6dzqYU8f+FEvlNCNQfBISF3C+0O6HnPlNezjHrTbkDdft/MJI7kdZeqtivW
	VLHoTe9T3wPpzdbbmQkpcNZKfM5DkoSTrdpd7Qxsbeg==
X-Gm-Gg: ASbGncsMCQWs3kjbdSe8cPD56IDhMjlw8aFEN+OtZ9Qs/cLjWpqptH4j39d1BHICWmY
	bHxydyRVX3ICJ05gJuNGJPGm52aburR+U8YKtrHno4gjqKbc+5d3/m+CkBleTaEe2vWpNKlxxJV
	wBwwlU5OdYA9zQIa6W4VEDcPW24m/pIsbp3mHHDfHNvlD7
X-Google-Smtp-Source: AGHT+IGiUfVfyJ26Bx4wl5kfNYZjoCTkcL0cHSajEsErrJvIE+yC5lhtciLge9rl2SK0bCUfyIYVL/jMRdpJ3J2gBFc=
X-Received: by 2002:a05:6214:2624:b0:6fa:b9e9:e799 with SMTP id
 6a1803df08f44-70002ee7f49mr55922566d6.24.1751042512252; Fri, 27 Jun 2025
 09:41:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250611180936.12886-1-suresh.k.chandrappa@gmail.com> <CAAMO5pgcHoxZ=SitNZeCu2vo5H5qtX0m5xf+aFfkYyqP4dMz5Q@mail.gmail.com>
In-Reply-To: <CAAMO5pgcHoxZ=SitNZeCu2vo5H5qtX0m5xf+aFfkYyqP4dMz5Q@mail.gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Fri, 27 Jun 2025 09:41:40 -0700
X-Gm-Features: Ac12FXxvXlWgt_fhT6-D6650tZx56zP0Ru5h2FBmanswINTMW2ehWBPl7bvd2YI
Message-ID: <CAKEwX=PM2CbcRhCqZgSTSz+KV6Jazmox68EuX3aoa5kQMie_nA@mail.gmail.com>
Subject: Re: [PATCH v2] selftests: cachestat: Refactor test to remove duplication
To: Suresh Chandrappa <suresh.k.chandrappa@gmail.com>
Cc: hannes@cmpxchg.org, shuah@kernel.org, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 24, 2025 at 9:58=E2=80=AFPM Suresh Chandrappa
<suresh.k.chandrappa@gmail.com> wrote:
>
> Hi @nphamcs
> Can you please check the modified change

Is this supposed to be on top of the earlier patch you sent out? In
that case, you should send both together as a patch series.

>
> Thanks
> Suresh K C
>
>
> On Wed, 11 Jun 2025, 23:39 Suresh K C, <suresh.k.chandrappa@gmail.com> wr=
ote:
>>
>> From: Suresh K C <suresh.k.chandrappa@gmail.com>
>>
>> Refactored the mmap and shmem test logic into a common function
>> to reduce code duplication and improve maintainability
>>
>> Changes in v2:
>>     Refactored mmap and shmem tests into a common function
>>     Renamed test function to run_cachestat_test()
>>     Removed test for /proc/cpuinfo as a general /proc test case already =
exists
>>
>> Signed-off-by: Suresh K C <suresh.k.chandrappa@gmail.com>
>> ---
>>  .../selftests/cachestat/test_cachestat.c      | 97 ++++++-------------
>>  1 file changed, 30 insertions(+), 67 deletions(-)
>>
>> diff --git a/tools/testing/selftests/cachestat/test_cachestat.c b/tools/=
testing/selftests/cachestat/test_cachestat.c
>> index 81e7f6dd2279..7c2f64175943 100644
>> --- a/tools/testing/selftests/cachestat/test_cachestat.c
>> +++ b/tools/testing/selftests/cachestat/test_cachestat.c
>> @@ -22,7 +22,7 @@
>>
>>  static const char * const dev_files[] =3D {
>>         "/dev/zero", "/dev/null", "/dev/urandom",
>> -       "/proc/version","/proc/cpuinfo","/proc"
>> +       "/proc/version","/proc"

So you removed one file that you added in an earlier patch, right?
Then why bother adding it in the first place...?

Can you either:

1. Send the two patch together as a series. In the first patch, do not
add /proc/cpuinfo.

or

2. Squash them into a single patch. I'll let you decide if this is worth it=
.


>>  };
>>
>>  void print_cachestat(struct cachestat *cs)
>> @@ -33,6 +33,11 @@ void print_cachestat(struct cachestat *cs)
>>         cs->nr_evicted, cs->nr_recently_evicted);
>>  }
>>
>> +enum file_type {
>> +       FILE_MMAP,
>> +       FILE_SHMEM
>> +};
>> +
>>  bool write_exactly(int fd, size_t filesize)
>>  {
>>         int random_fd =3D open("/dev/urandom", O_RDONLY);
>> @@ -202,66 +207,8 @@ static int test_cachestat(const char *filename, boo=
l write_random, bool create,
>>         return ret;
>>  }
>>
>> -bool test_cachestat_mmap(void){
>> -
>> -       size_t PS =3D sysconf(_SC_PAGESIZE);
>> -       size_t filesize =3D PS * 512 * 2;;
>> -       int syscall_ret;
>> -       size_t compute_len =3D PS * 512;
>> -       struct cachestat_range cs_range =3D { PS, compute_len };
>> -       char *filename =3D "tmpshmcstat";
>> -       unsigned long num_pages =3D compute_len / PS;
>> -       struct cachestat cs;
>> -       bool ret =3D true;
>> -       int fd =3D open(filename, O_RDWR | O_CREAT | O_TRUNC, 0666);
>> -       if (fd < 0) {
>> -               ksft_print_msg("Unable to create mmap file.\n");
>> -               ret =3D false;
>> -               goto out;
>> -       }
>> -       if (ftruncate(fd, filesize)) {
>> -               ksft_print_msg("Unable to truncate mmap file.\n");
>> -               ret =3D false;
>> -               goto close_fd;
>> -       }
>> -       if (!write_exactly(fd, filesize)) {
>> -               ksft_print_msg("Unable to write to mmap file.\n");
>> -               ret =3D false;
>> -               goto close_fd;
>> -       }
>> -       char *map =3D mmap(NULL, filesize, PROT_READ | PROT_WRITE, MAP_S=
HARED, fd, 0);
>> -       if (map =3D=3D MAP_FAILED) {
>> -               ksft_print_msg("mmap failed.\n");
>> -               ret =3D false;
>> -               goto close_fd;
>> -       }
>> -
>> -       for (int i =3D 0; i < filesize; i++) {
>> -               map[i] =3D 'A';
>> -       }
>> -       map[filesize - 1] =3D 'X';
>> -
>> -       syscall_ret =3D syscall(__NR_cachestat, fd, &cs_range, &cs, 0);
>> -
>> -       if (syscall_ret) {
>> -               ksft_print_msg("Cachestat returned non-zero.\n");
>> -               ret =3D false;
>> -       } else {
>> -               print_cachestat(&cs);
>> -               if (cs.nr_cache + cs.nr_evicted !=3D num_pages) {
>> -                       ksft_print_msg("Total number of cached and evict=
ed pages is off.\n");
>> -                       ret =3D false;
>> -               }
>> -       }
>> -
>> -close_fd:
>> -       close(fd);
>> -       unlink(filename);
>> -out:
>> -       return ret;
>> -}
>>
>> -bool test_cachestat_shmem(void)
>> +bool run_cachestat_test(enum file_type type)

Can you just call this function test_cachestat(enum file_type type) ?

>>  {
>>         size_t PS =3D sysconf(_SC_PAGESIZE);
>>         size_t filesize =3D PS * 512 * 2; /* 2 2MB huge pages */
>> @@ -271,27 +218,43 @@ bool test_cachestat_shmem(void)
>>         char *filename =3D "tmpshmcstat";
>>         struct cachestat cs;
>>         bool ret =3D true;
>> +       int fd;
>>         unsigned long num_pages =3D compute_len / PS;
>> -       int fd =3D shm_open(filename, O_CREAT | O_RDWR, 0600);
>> +       if (type =3D=3D FILE_SHMEM)
>> +               fd =3D shm_open(filename, O_CREAT | O_RDWR, 0600);
>> +       else
>> +               fd =3D open(filename, O_RDWR | O_CREAT | O_TRUNC, 0666);
>>
>>         if (fd < 0) {
>> -               ksft_print_msg("Unable to create shmem file.\n");
>> +               ksft_print_msg("Unable to create file.\n");
>>                 ret =3D false;
>>                 goto out;
>>         }
>>
>>         if (ftruncate(fd, filesize)) {
>> -               ksft_print_msg("Unable to truncate shmem file.\n");
>> +               ksft_print_msg("Unable to truncate file.\n");
>>                 ret =3D false;
>>                 goto close_fd;
>>         }
>>
>>         if (!write_exactly(fd, filesize)) {
>> -               ksft_print_msg("Unable to write to shmem file.\n");
>> +               ksft_print_msg("Unable to write to file.\n");
>>                 ret =3D false;
>>                 goto close_fd;
>>         }
>>
>> +       if (type =3D=3D FILE_MMAP){
>> +               char *map =3D mmap(NULL, filesize, PROT_READ | PROT_WRIT=
E, MAP_SHARED, fd, 0);
>> +               if (map =3D=3D MAP_FAILED) {
>> +                       ksft_print_msg("mmap failed.\n");
>> +                       ret =3D false;
>> +                       goto close_fd;
>> +               }
>> +               for (int i =3D 0; i < filesize; i++) {
>> +                       map[i] =3D 'A';
>> +               }
>> +               map[filesize - 1] =3D 'X';
>> +       }
>>         syscall_ret =3D syscall(__NR_cachestat, fd, &cs_range, &cs, 0);
>>
>>         if (syscall_ret) {
>> @@ -333,7 +296,7 @@ int main(void)
>>                 ret =3D 1;
>>         }
>>
>> -       for (int i =3D 0; i < 6; i++) {
>> +       for (int i =3D 0; i < 5; i++) {
>>                 const char *dev_filename =3D dev_files[i];
>>
>>                 if (test_cachestat(dev_filename, false, false, false,
>> @@ -367,14 +330,14 @@ int main(void)
>>                 break;
>>         }
>>
>> -       if (test_cachestat_shmem())
>> +       if (run_cachestat_test(FILE_SHMEM))
>>                 ksft_test_result_pass("cachestat works with a shmem file=
\n");
>>         else {
>>                 ksft_test_result_fail("cachestat fails with a shmem file=
\n");
>>                 ret =3D 1;
>>         }
>>
>> -       if (test_cachestat_mmap())
>> +       if (run_cachestat_test(FILE_MMAP))
>>                 ksft_test_result_pass("cachestat works with a mmap file\=
n");
>>         else {
>>                 ksft_test_result_fail("cachestat fails with a mmap file\=
n");
>> --
>> 2.43.0
>>

