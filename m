Return-Path: <linux-kselftest+bounces-15870-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A073995A239
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Aug 2024 18:00:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C53BC1C21FEF
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Aug 2024 16:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 711C81531EA;
	Wed, 21 Aug 2024 15:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xt4QApQA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E4E61509AB
	for <linux-kselftest@vger.kernel.org>; Wed, 21 Aug 2024 15:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724255968; cv=none; b=DHWi8MjB7b+zEij90qV7dYHTruagdO/e4anOd3TR/jeme0E5Q6+dV/mP1MeAvsRdb7/GmalNSTE6rm/ON0I9O5RpWSFyGhPc8kOgq+XXTuDNN3tUizbtG8VpQkjAfWlS5KL7VpV6yitPBRt6zEFecuISUUbwvnoogRkHPTfcS+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724255968; c=relaxed/simple;
	bh=RaUaZ8ntV96LwuQUkoftWHtqTL9Sdg2BdUiEIMtJF10=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SeUJJVvkBlCX3jlA6bfVf8K+xQz6ahGnCmjYgzrvavIuU4CCwzXQOdASwNMbEO1zb2/Tr+BTHieTV8A5iFG07fdoAe+1ozfU3Sbs4KmhOJkyzh32NQB2aBDaQLDku71TNomjyMix29yjoxBE/a+9Pj4eyK983IqY5CdFtrdMsNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xt4QApQA; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-454b1e08393so457781cf.0
        for <linux-kselftest@vger.kernel.org>; Wed, 21 Aug 2024 08:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724255965; x=1724860765; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V2+aEKpO7Wfhm/ECC9K4hCXKwFW4mPjQWNMHcyx3sOI=;
        b=xt4QApQAQM4l7pGhb5dJtglcrESfKFK8p9WX47ZLlzlOpPbhtxXeXAn2hG3IW9dVdz
         fPhaSQdcSBoveWF1g5WjYb1ZvLUKwNkVvmqWn/6BAYaE0BY1gV01gRHHh4n3CyBCr9m0
         DB2QmErY49tSRDisIMLmsTZN+M93+mCc4ryYgK7zeKlTXlbXsUtyHDNrHCqpvExyv1Up
         Z8A0rMV0IOSy4UKjrMcb1G0yFv7s2iUxSMcORAreM10Qv4RKWaSUDK27qg1teYAu9rMF
         r3t5IQicf5jr5yTXuDhSCxh3YTTcIbZfoJ1nZPCmHI2WxWULxsCm4YcoqiWFViRyUaF9
         nvOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724255965; x=1724860765;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V2+aEKpO7Wfhm/ECC9K4hCXKwFW4mPjQWNMHcyx3sOI=;
        b=FLAqozIO36iEGkICPGi9ux0tyn4ePeTA4LdnSyCRZYYk6lllV2O+kq3ol2n8xiyiRU
         MhaInFIJFk0CuS0X98QEjYfIAqzR0dOTu1XZh2P58L1GTb9Q/WqPHl2FjybtQ9cu0bSk
         /jEWE83vv34l6rbKGCZqWi2nYboJiFO0EmmRpwfmyR/2OFTjxWQ2aTXn/xW/Sd7/qfI1
         6TLtEniB7hKqwEbYZrHk5ijRN9LSul5ccrd0WnoTDWIhW25TNuckJAHKteF+Toks8BCs
         yaQGI4HkAfWAbVviaolt6cs9YxaOfIpb0Qb+jAQ/OxtEYZQiTDvjJWKqKldqnQJTt+F+
         AwGQ==
X-Forwarded-Encrypted: i=1; AJvYcCUDM7QFCqyNRgj9YvBwVS74Li4axGARfvRvnl637NcVZmcFNLwlU31m5mVbJVgczk6vKGgJOYEYQg6Myapw2TU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzilZ+v8qKC4sKuyodvwTpZqgdc/Q/DoOHz2z+/f/lqEaHQuxor
	FPF3GFKDeNNt901Kg8uX7mjy6mYRh2MKPSiVc1z3PUusY4dV1gNZaCBNy+EEnS4fvDjO9kE5/Jv
	+ulerbCC3IAqCSHXWcIJSL68cbz2J9UoKHprz
X-Google-Smtp-Source: AGHT+IEeBlCs+tAD0iKGIXQrRgxrU8Et2mHj4KqYr5OBwfh2DQAHO/xYRk2RETcL5+jhxfkcum5B/DlFZQRy4Gm3XdU=
X-Received: by 2002:a05:622a:1195:b0:453:62ee:3fe with SMTP id
 d75a77b69052e-454e86e978fmr6356911cf.17.1724255964898; Wed, 21 Aug 2024
 08:59:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240821123115.2068812-1-david@redhat.com>
In-Reply-To: <20240821123115.2068812-1-david@redhat.com>
From: Mina Almasry <almasrymina@google.com>
Date: Wed, 21 Aug 2024 11:59:11 -0400
Message-ID: <CAHS8izNyDymXoH94usJTGNHG45HB50m7SSkL6H1C+9pxBEDE+g@mail.gmail.com>
Subject: Re: [PATCH v1] selftests/mm: fix charge_reserved_hugetlb.sh test
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org, Mario Casquero <mcasquer@redhat.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>, 
	Muchun Song <muchun.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 21, 2024 at 8:31=E2=80=AFAM David Hildenbrand <david@redhat.com=
> wrote:
>
> Currently, running the charge_reserved_hugetlb.sh selftest we can
> sometimes observe something like:
>
>   $ ./charge_reserved_hugetlb.sh -cgroup-v2
>   ...
>   write_result is 0
>   After write:
>   hugetlb_usage=3D0
>   reserved_usage=3D10485760
>   killing write_to_hugetlbfs
>   Received 2.
>   Deleting the memory
>   Detach failure: Invalid argument
>   umount: /mnt/huge: target is busy.
>
> Both cases are issues in the test.
>
> While the unmount error seems to be racy, it will make the test fail:
>         $ ./run_vmtests.sh -t hugetlb
>         ...
>         # [FAIL]
>         not ok 10 charge_reserved_hugetlb.sh -cgroup-v2 # exit=3D32
>
> The issue is that we are not waiting for the write_to_hugetlbfs process
> to quit. So it might still have a hugetlbfs file open, about which
> umount is not happy. Fix that by making "killall" wait for the process
> to quit.
>
> The other error ("Detach failure: Invalid argument") does not seem to
> result in a test error, but is misleading. Turns out write_to_hugetlbfs.c
> unconditionally tries to cleanup using shmdt(), even when we only
> mmap()'ed a hugetlb file. Even worse, shmaddr is never even set for the
> SHM case. Fix that as well.
>
> With this change it seems to work as expected.
>
> Fixes: 29750f71a9b4 ("hugetlb_cgroup: add hugetlb_cgroup reservation test=
s")
> Reported-by: Mario Casquero <mcasquer@redhat.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Shuah Khan <shuah@kernel.org>
> Cc: Muchun Song <muchun.song@linux.dev>
> Cc: Mina Almasry <almasrymina@google.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Initially I thought it could be nice to split fixes for the 2 issues
in separate patches in case one of them ends up needing a revert or
something, but probably not worth a respin. Fixes look good to me.

Reviewed-by: Mina Almasry <almasrymina@google.com>

> ---
>  .../selftests/mm/charge_reserved_hugetlb.sh   |  2 +-
>  .../testing/selftests/mm/write_to_hugetlbfs.c | 21 +++++++++++--------
>  2 files changed, 13 insertions(+), 10 deletions(-)
>
> diff --git a/tools/testing/selftests/mm/charge_reserved_hugetlb.sh b/tool=
s/testing/selftests/mm/charge_reserved_hugetlb.sh
> index d680c00d2853a..67df7b47087f0 100755
> --- a/tools/testing/selftests/mm/charge_reserved_hugetlb.sh
> +++ b/tools/testing/selftests/mm/charge_reserved_hugetlb.sh
> @@ -254,7 +254,7 @@ function cleanup_hugetlb_memory() {
>    local cgroup=3D"$1"
>    if [[ "$(pgrep -f write_to_hugetlbfs)" !=3D "" ]]; then
>      echo killing write_to_hugetlbfs
> -    killall -2 write_to_hugetlbfs
> +    killall -2 --wait write_to_hugetlbfs

This looks correct. I don't think I expected killall not to wait.

>      wait_for_hugetlb_memory_to_get_depleted $cgroup
>    fi
>    set -e
> diff --git a/tools/testing/selftests/mm/write_to_hugetlbfs.c b/tools/test=
ing/selftests/mm/write_to_hugetlbfs.c
> index 6a2caba19ee1d..1289d311efd70 100644
> --- a/tools/testing/selftests/mm/write_to_hugetlbfs.c
> +++ b/tools/testing/selftests/mm/write_to_hugetlbfs.c
> @@ -28,7 +28,7 @@ enum method {
>
>  /* Global variables. */
>  static const char *self;
> -static char *shmaddr;
> +static int *shmaddr;
>  static int shmid;
>
>  /*
> @@ -47,15 +47,17 @@ void sig_handler(int signo)
>  {
>         printf("Received %d.\n", signo);
>         if (signo =3D=3D SIGINT) {
> -               printf("Deleting the memory\n");
> -               if (shmdt((const void *)shmaddr) !=3D 0) {
> -                       perror("Detach failure");
> +               if (shmaddr) {
> +                       printf("Deleting the memory\n");
> +                       if (shmdt((const void *)shmaddr) !=3D 0) {
> +                               perror("Detach failure");
> +                               shmctl(shmid, IPC_RMID, NULL);
> +                               exit(4);
> +                       }
> +
>                         shmctl(shmid, IPC_RMID, NULL);
> -                       exit(4);
> +                       printf("Done deleting the memory\n");
>                 }
> -
> -               shmctl(shmid, IPC_RMID, NULL);
> -               printf("Done deleting the memory\n");

This seems like a simple refactor to only delete when shmaddr is set,
looks fine to me.

>         }
>         exit(2);
>  }
> @@ -211,7 +213,8 @@ int main(int argc, char **argv)
>                         shmctl(shmid, IPC_RMID, NULL);
>                         exit(2);
>                 }
> -               printf("shmaddr: %p\n", ptr);
> +               shmaddr =3D ptr;
> +               printf("shmaddr: %p\n", shmaddr);
>

Setting shmaddr seems correct and an oversight. I don't see shmaddr
set anywhere in the current code.

>                 break;
>         default:
> --
> 2.46.0
>


--=20
Thanks,
Mina

