Return-Path: <linux-kselftest+bounces-16281-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A75595F3A7
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Aug 2024 16:16:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E61842811B6
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Aug 2024 14:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6644818CC0B;
	Mon, 26 Aug 2024 14:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F4M/Xyt9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B379F18BB9D
	for <linux-kselftest@vger.kernel.org>; Mon, 26 Aug 2024 14:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724681788; cv=none; b=VnnzDXihV4rbiCyT0NISC/DQb8GSglETpYYihNBjhjWzkCb1OJPLa85l9cb1py7yKQ29obLWMPhPuEn0Ug6RtJ0PwN5v6M2HUjOT/UVFsG27fjirsdZaygkePD4GpK6ONJo7YHVwhg5gkcixvmtaZm+TcZdEPjijlV3P381kN7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724681788; c=relaxed/simple;
	bh=bfh7hrY6hPrVjcxiAQV5eze22xQjzvzqfJ/7/fNvrw4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TCBUqw+fQ3r2IHW8YHXwt8DGU/KvcUxYMKPxLZ5YuRGGVYMt90Cf5g00aoX1ajP3I7n1OfAKHlu5W7Jm6fEykRIs6KS4DUYQXV3G42k+fvDP32oML+rKYDuTsDx1caNGfMxxYsKCO2x7AC224qPc0SU2kzDqQhHBKVXjzbW42lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F4M/Xyt9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724681784;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c+nhWTyzd1EZSu9QxGO7u5TrkuVgATh5FsPGD0fQ+wc=;
	b=F4M/Xyt9s8CY1R4zT/qtb26SiIT7FtR5OpaqAe8wGvVSJbtq3T/j4KUCK6YfbmNcxMWB2Y
	Oozk+7nExD6naDlHl3gKIiustHKLA18fL75UmPDa9/MBZdyzlCkjT2l8NlWSx5u4uzZRqW
	A69rGvslfN8MffOruj2n95/CCYBr3Wk=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-YGW49sFjOwqR-GWZnq_Oew-1; Mon, 26 Aug 2024 10:16:20 -0400
X-MC-Unique: YGW49sFjOwqR-GWZnq_Oew-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2f4444b34a7so34506851fa.0
        for <linux-kselftest@vger.kernel.org>; Mon, 26 Aug 2024 07:16:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724681779; x=1725286579;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c+nhWTyzd1EZSu9QxGO7u5TrkuVgATh5FsPGD0fQ+wc=;
        b=aEUdGTsiq8ovhfC0F5LGmfbUPJVB7J7NxxkSHTOu+LCVYGWeVXRvWHXnpBVAqlIT4g
         W76b/YsAf2HHPcW5hCVUTBsTeVU4+m/CghX/9EV+mlPurP+Ra071N6lGHX/AF18+gusL
         t1HJtBjPsMA/wyt+nfrhXksxdrGfIMspoAiXUOvN1CktLv0AOtCzfYsGFRz9dVpsT8U9
         FDrt+Xx4A4whoeOmVJAg0qPSmFfct1PIdNiFbBbg7siye1ipyCRlpJCXCGCbLUZpJQBM
         d/w1RLqsZhtmuwJntKHzyM5e1RtzxbKpzlyerJLFj3P2QBxs6kjO7Jwmqj1orV6SxCBW
         JQEQ==
X-Forwarded-Encrypted: i=1; AJvYcCUfRvtqsnMyn/dl56vW1cV0vKPhV9RMhY5DLLPEb/O5AuIIYB7sIdHbnkJ++n1yTB0AGK/gOjr9U4s4DNAvsTE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1i0Rq7hXCg5bbkdFAc1KZlaVha4LH4IRgI+YtUsmVjJ+LNaH+
	jcqONb5pWRMUiEiZHA105l2ZKhtEQ0OKgvmujqpZSJ9/DaLNus7L7yFmQQUvqMkbqVIq4wWFRE/
	Um9h+w9x0XXL96tp3GFBC4+IsLt+mgDXvL1ZrAa1lZblzEy60R4qQmWgYNmnv2KQbfL8W7W7NVF
	sDwsQcpA++YKpQKI3m0CXFjmoJOsFl9FF+w/4WTWGL
X-Received: by 2002:a05:651c:1544:b0:2f3:d008:a54e with SMTP id 38308e7fff4ca-2f4f493a354mr82359961fa.36.1724681779192;
        Mon, 26 Aug 2024 07:16:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFjsUTW2QGEs1pHXZ1pLASk+FK03mP2oVNdzWBn0IfbZdLgVs0FRFpTJwlH4BarayX187CLxqiwvqGZ4Zuf5wI=
X-Received: by 2002:a05:651c:1544:b0:2f3:d008:a54e with SMTP id
 38308e7fff4ca-2f4f493a354mr82359731fa.36.1724681778674; Mon, 26 Aug 2024
 07:16:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240821123115.2068812-1-david@redhat.com>
In-Reply-To: <20240821123115.2068812-1-david@redhat.com>
From: Mario Casquero <mcasquer@redhat.com>
Date: Mon, 26 Aug 2024 16:16:07 +0200
Message-ID: <CAMXpfWsoTooEEpgyUvNFNo0tMLmPNO9bfAu_A+rq2+Ri6YbV9Q@mail.gmail.com>
Subject: Re: [PATCH v1] selftests/mm: fix charge_reserved_hugetlb.sh test
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	Shuah Khan <shuah@kernel.org>, Muchun Song <muchun.song@linux.dev>, 
	Mina Almasry <almasrymina@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This patch has been successfully tested. All hugetlb kernel selftests pass =
now.
# SUMMARY: PASS=3D12 SKIP=3D0 FAIL=3D0

Tested by: Mario Casquero <mcasquer@redhat.com>


On Wed, Aug 21, 2024 at 2:31=E2=80=AFPM David Hildenbrand <david@redhat.com=
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
>                 break;
>         default:
> --
> 2.46.0
>


