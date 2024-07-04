Return-Path: <linux-kselftest+bounces-13161-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EF1E926E28
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Jul 2024 05:44:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 505EC1C212BE
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Jul 2024 03:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D577C18B04;
	Thu,  4 Jul 2024 03:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z+inKjcI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6641BC2F;
	Thu,  4 Jul 2024 03:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720064657; cv=none; b=Yi8ZPSSv5XSRQXw+o3UXOXZSbjo6y2xcoclrcM8zPWySYiyuYRq+89xCkgLJ8UikZ0DvcIlfaVAfmSgBGIBWsDk5GnxPUO0UWYzOyDJE3aQXBZm05e7Q8mNBBHZ81wtzyHr/+heqr4QEIDgGCEvaqmhzAPLpE8ZpH+DhgQ6CJvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720064657; c=relaxed/simple;
	bh=bHg1oOoNZOVAop9/sk1cT9TRi/dy30jWiJTM1dwfOSM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BonnBWk43ZJAYDKM7Na7r2ZxnxcagW8Hz6FbHBmqWU4tBFXTAw81wE/fTDRZGi8RxnAbeI1o9b8WcodaAuodBuU9XCD7iJsjPNrtBtRqgBMdrJzaXpK0IDDSdBbrBOMpTGh4pluAR8hC3i5GKlszkREFug7h8ta7AOaE4MVeFxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z+inKjcI; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2ec3f875e68so1951561fa.0;
        Wed, 03 Jul 2024 20:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720064654; x=1720669454; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dpb8jh3xl2yUW9tcGzdxy5MpT1Lo32MEWMN1DB3eG78=;
        b=Z+inKjcI5RPyMRrLQeusJAeFbwPJPUHCzn+MZpsmlmxCWCp67lkLMB+8fXx9LuRJ/9
         AWhFEO3vCUIcZgByG+/+QzEQ4nCeZcGO/G4gBYP+q/ua77Me3Tbq96HKq33uWKy5ClOv
         MtrBe4+QlLca6HL0lN3I7sWJKjd/ep8jj6SVLZbY6Mds7qI10iMPUcjAvdIqoZLCob6Y
         hz2viRdNWbIs+NMSPQkwiadmPYYDT2DqibYroZMVCGUIkgn61Gamb+8n6atE1fjzE/Ze
         dKU4sOlFV72vwsLhEYBfI2ULF44NKHCdAbAbkPiwH7/iAjAVOz4HE/Bjn6QdviCROb7j
         3+ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720064654; x=1720669454;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dpb8jh3xl2yUW9tcGzdxy5MpT1Lo32MEWMN1DB3eG78=;
        b=rXImVyMGA31dV2hBCIL30KX+A4Hdbu8kT3uqRNM5yKqetpvau5Onlp6jRaL3f70KhG
         H7+0FVxnf/al+hVLoOmaB07dJQK78/qYALec4ou5HxbCIr3Z433jyll4pgjYL10mYE9B
         7lEyYIllB4mMw7bOwTivphxjcN0iJmHGT79ap2eAc+k2+HPKgjtl77rKn6Zuw7BA/y7q
         79lx0wtHH/QM8lzv6dsuCAfpY8FJqT3vIWo2KG8z94FrqJJvtN6jxo8eY/ndkMd9WPak
         wysd4E7nvOlawNwlerXNqTBkPlRHYB0zlyUeu69KTalqHqB+yStkRLQM8mUXuL9HlUmr
         oaZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVipaWkUtL1onkD393rT63OijNLEkpJfYNGoNWQDXNVQavzQjzTfc4G5Zfw4ZtRUs7WiJ8PRrH0N3pJlDLI6uY9MW+O2l/hNASAwLFwKHOUCFw3Xq2VuYqbjXrlBknHN4ziSdS6lUER2qgRd55I
X-Gm-Message-State: AOJu0Yx3NCMFwtm+8+/PYdakgUduxQUtk3Mr+HAHISV5nXvHO4HeIue9
	PtBtGjcBjJTpUqXcw3sI7tyD5T8Cfh99Fk8T6eBnUIGziK/bSO3I6tz2Owc3UDm1+JkumV32HkY
	ZBHg1VFeti8Zs+uKYEHXPTYaEQ+xJZg==
X-Google-Smtp-Source: AGHT+IHF22lgyUZ2Y6iVXkzcNFcV0U429j08sVQqCZNQ7f1zdntEjlZWjKvybaI3Rsux2M4PZVTvbsbL3gXmdV6X2hM=
X-Received: by 2002:a2e:a78f:0:b0:2ec:5603:41a with SMTP id
 38308e7fff4ca-2ee8ed66bc0mr2168791fa.2.1720064653811; Wed, 03 Jul 2024
 20:44:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240704025247.86418-1-jhubbard@nvidia.com>
In-Reply-To: <20240704025247.86418-1-jhubbard@nvidia.com>
From: Andrei Vagin <avagin@gmail.com>
Date: Wed, 3 Jul 2024 20:44:01 -0700
Message-ID: <CANaxB-zk-j2E8D0_4x04WL5Jbe08SD39jqBLbehBYWedFg+mMw@mail.gmail.com>
Subject: Re: [PATCH v3] selftest/timerns: fix clang build failures for abs() calls
To: John Hubbard <jhubbard@nvidia.com>
Cc: Shuah Khan <shuah@kernel.org>, Dmitry Safonov <dima@arista.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Valentin Obst <kernel@valentinobst.de>, 
	linux-kselftest@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
	llvm@lists.linux.dev, Muhammad Usama Anjum <usama.anjum@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 3, 2024 at 7:52=E2=80=AFPM John Hubbard <jhubbard@nvidia.com> w=
rote:
>
> When building with clang, via:
>
>     make LLVM=3D1 -C tools/testing/selftests
>
> ...clang warns about mismatches between the expected and required
> integer length being supplied to abs(3).
>
> Fix this by using the correct variant of abs(3): labs(3) or llabs(3), in
> these cases.
>

Acked-by: Andrei Vagin <avagin@google.com>

> Reviewed-by: Dmitry Safonov <dima@arista.com>
> Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> ---
>
> Hi,
>
> Changes since v2:
>
> 1) Commit description: removed the reference to Valentin Obst's patch
>    being a prerequisite, now that that has been merged.
>
> 2) Rebased on Linux 6.10-rc6+.
>
> Changes since the first version:
>
> 1) Rebased onto Linux 6.10-rc1
>
> 2) Reviewed-by's added.
>
> thanks,
> John Hubbard
>
>
>  tools/testing/selftests/timens/exec.c       | 6 +++---
>  tools/testing/selftests/timens/timer.c      | 2 +-
>  tools/testing/selftests/timens/timerfd.c    | 2 +-
>  tools/testing/selftests/timens/vfork_exec.c | 4 ++--
>  4 files changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/tools/testing/selftests/timens/exec.c b/tools/testing/selfte=
sts/timens/exec.c
> index e40dc5be2f66..d12ff955de0d 100644
> --- a/tools/testing/selftests/timens/exec.c
> +++ b/tools/testing/selftests/timens/exec.c
> @@ -30,7 +30,7 @@ int main(int argc, char *argv[])
>
>                 for (i =3D 0; i < 2; i++) {
>                         _gettime(CLOCK_MONOTONIC, &tst, i);
> -                       if (abs(tst.tv_sec - now.tv_sec) > 5)
> +                       if (labs(tst.tv_sec - now.tv_sec) > 5)
>                                 return pr_fail("%ld %ld\n", now.tv_sec, t=
st.tv_sec);
>                 }
>                 return 0;
> @@ -50,7 +50,7 @@ int main(int argc, char *argv[])
>
>         for (i =3D 0; i < 2; i++) {
>                 _gettime(CLOCK_MONOTONIC, &tst, i);
> -               if (abs(tst.tv_sec - now.tv_sec) > 5)
> +               if (labs(tst.tv_sec - now.tv_sec) > 5)
>                         return pr_fail("%ld %ld\n",
>                                         now.tv_sec, tst.tv_sec);
>         }
> @@ -70,7 +70,7 @@ int main(int argc, char *argv[])
>                 /* Check that a child process is in the new timens. */
>                 for (i =3D 0; i < 2; i++) {
>                         _gettime(CLOCK_MONOTONIC, &tst, i);
> -                       if (abs(tst.tv_sec - now.tv_sec - OFFSET) > 5)
> +                       if (labs(tst.tv_sec - now.tv_sec - OFFSET) > 5)
>                                 return pr_fail("%ld %ld\n",
>                                                 now.tv_sec + OFFSET, tst.=
tv_sec);
>                 }
> diff --git a/tools/testing/selftests/timens/timer.c b/tools/testing/selft=
ests/timens/timer.c
> index 5e7f0051bd7b..5b939f59dfa4 100644
> --- a/tools/testing/selftests/timens/timer.c
> +++ b/tools/testing/selftests/timens/timer.c
> @@ -56,7 +56,7 @@ int run_test(int clockid, struct timespec now)
>                         return pr_perror("timerfd_gettime");
>
>                 elapsed =3D new_value.it_value.tv_sec;
> -               if (abs(elapsed - 3600) > 60) {
> +               if (llabs(elapsed - 3600) > 60) {
>                         ksft_test_result_fail("clockid: %d elapsed: %lld\=
n",
>                                               clockid, elapsed);
>                         return 1;
> diff --git a/tools/testing/selftests/timens/timerfd.c b/tools/testing/sel=
ftests/timens/timerfd.c
> index 9edd43d6b2c1..a4196bbd6e33 100644
> --- a/tools/testing/selftests/timens/timerfd.c
> +++ b/tools/testing/selftests/timens/timerfd.c
> @@ -61,7 +61,7 @@ int run_test(int clockid, struct timespec now)
>                         return pr_perror("timerfd_gettime(%d)", clockid);
>
>                 elapsed =3D new_value.it_value.tv_sec;
> -               if (abs(elapsed - 3600) > 60) {
> +               if (llabs(elapsed - 3600) > 60) {
>                         ksft_test_result_fail("clockid: %d elapsed: %lld\=
n",
>                                               clockid, elapsed);
>                         return 1;
> diff --git a/tools/testing/selftests/timens/vfork_exec.c b/tools/testing/=
selftests/timens/vfork_exec.c
> index beb7614941fb..5b8907bf451d 100644
> --- a/tools/testing/selftests/timens/vfork_exec.c
> +++ b/tools/testing/selftests/timens/vfork_exec.c
> @@ -32,7 +32,7 @@ static void *tcheck(void *_args)
>
>         for (i =3D 0; i < 2; i++) {
>                 _gettime(CLOCK_MONOTONIC, &tst, i);
> -               if (abs(tst.tv_sec - now->tv_sec) > 5) {
> +               if (labs(tst.tv_sec - now->tv_sec) > 5) {
>                         pr_fail("%s: in-thread: unexpected value: %ld (%l=
d)\n",
>                                 args->tst_name, tst.tv_sec, now->tv_sec);
>                         return (void *)1UL;
> @@ -64,7 +64,7 @@ static int check(char *tst_name, struct timespec *now)
>
>         for (i =3D 0; i < 2; i++) {
>                 _gettime(CLOCK_MONOTONIC, &tst, i);
> -               if (abs(tst.tv_sec - now->tv_sec) > 5)
> +               if (labs(tst.tv_sec - now->tv_sec) > 5)
>                         return pr_fail("%s: unexpected value: %ld (%ld)\n=
",
>                                         tst_name, tst.tv_sec, now->tv_sec=
);
>         }
>
> base-commit: 8a9c6c40432e265600232b864f97d7c675e8be52
> --
> 2.45.2
>

