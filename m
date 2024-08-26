Return-Path: <linux-kselftest+bounces-16282-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AD0495F3AF
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Aug 2024 16:18:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D782F1F21C46
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Aug 2024 14:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B19C618BB92;
	Mon, 26 Aug 2024 14:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i6kncBRs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 123997BB15
	for <linux-kselftest@vger.kernel.org>; Mon, 26 Aug 2024 14:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724681909; cv=none; b=HkqQ4O7pZI945vE1dckiWkCX3GoiHXr40QZ11yPufYE2K4WtzzK3TXOtYwH8vfmvaHMKYvgq0puag9jr5Sbq59Vt7Hv4YEmw3hvM8bg6OWhrQ3/Mkm4IAPg+81bAf+5cQvLy4Ay2F9vsp9F1wiXgRZBpraZaV2b6rzxgdUYc3tM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724681909; c=relaxed/simple;
	bh=53R3qtA2DB+9v4U+hc88fR8XKEtW2edB3+GQ9O1Vn6k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LbW39CSF9lo7a5DAnn6I+lvGdWBhYijZxQr2VOAGkZulIit5nrwefHFa49ED/sY1Vd/rkIGL+FsaIb5JBCUmzKiaQp6wHPDlClbi6vfYr0Ov89WkIRLwBbsIUbSWVcqjokjchvcdbfWeQ18WV5YXlTm0Mf12ZRNi1wQ/olT7niM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i6kncBRs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724681907;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=epejtgmZ6P+cnuAUKGDMtJ1Zom6Sbo3EnXXkkIT7RGo=;
	b=i6kncBRsMTUIF7NCpUDSTSs3XeajPLnbiGisw9MH8mLdY35t0Zj6kcXm/5mvMPJ0JYt/yC
	2r1s5lg0eDSoXFsAcK0665M7whGeOk1kzknWBkETHJVM0Yc+ldHkR12F/7p41CXByF+5d7
	HYv5eHJH3Zp71u5qJtfAujeFeolD8Hw=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-329-epUKuv-RPJeN_nWMUceYtw-1; Mon, 26 Aug 2024 10:18:24 -0400
X-MC-Unique: epUKuv-RPJeN_nWMUceYtw-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2f3f82f55feso34370151fa.0
        for <linux-kselftest@vger.kernel.org>; Mon, 26 Aug 2024 07:18:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724681903; x=1725286703;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=epejtgmZ6P+cnuAUKGDMtJ1Zom6Sbo3EnXXkkIT7RGo=;
        b=h/32YBU718G67spB8mdqSVdRidKE0K84wjgfoszjFkn2uxTwzFcEqXGKBSwsJKIuOZ
         m9BenyYQUfnU7d+Dwh9ueuUkHzxofzKJPXr4TxjPaB7Im4IDH/1IsBSbZXY29ftH1SiY
         x249HFqy7br7P6vkzq1vbpdJz/vEUaLrnCS/8L1HgSlvQ6hwWm3KN2PpcU4ibm7FatPX
         bY+dCya+pRGrlOdWCq8ioPDFKNTJRj4wGbwlFuutPAQm5PTvioASlb35aHBvmRQaDNdJ
         SgzDRjD6nh+M3iYXNX70UAx/Dpi5wyENU165uwoT7kpZrcA02nd6h/YkE846wUOF+ROK
         4baw==
X-Forwarded-Encrypted: i=1; AJvYcCU9IhRes3b9zIw0MFB+Y6HW2XMbDQeqsbloyk56a0duySVkpGFFwbJkNyq9iV39j37G9xJJZcB/5/Z7cUN1UK8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yza2HnXMdcQHJDI7f2eSiRC0mODh+VmJEhLL0mfGMr/EZyPwd4Y
	65fFxfKmlLsCkRW6MAeNgp2VhheZMJMNRdwJwZmjz/Y4mgYa7810S6TwaDU5TP7yCX0ayClV8BC
	XVpVj3K01eMAEagH/bNvhNf3Zq2yV/42GUr46vUqy48wdoBzFkVv6ZtFKgOSdPihON066pGsYV0
	oGNO2d2awbQCh2pY9em+dISYiLUI4u2SEgJPY4xtQJ
X-Received: by 2002:a2e:a543:0:b0:2f1:6108:3f00 with SMTP id 38308e7fff4ca-2f4f4743664mr26815201fa.0.1724681903011;
        Mon, 26 Aug 2024 07:18:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEAZYY5jdtpgdgXWZ7zNtGCuEM+zlPT/j+eVCg3rTngipWDx2Xz2dHTuB+p5Bj7qVhnNUS2aqr4ZKB7Tk3FRc4=
X-Received: by 2002:a2e:a543:0:b0:2f1:6108:3f00 with SMTP id
 38308e7fff4ca-2f4f4743664mr26815101fa.0.1724681902401; Mon, 26 Aug 2024
 07:18:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240821123115.2068812-1-david@redhat.com> <CAMXpfWsoTooEEpgyUvNFNo0tMLmPNO9bfAu_A+rq2+Ri6YbV9Q@mail.gmail.com>
In-Reply-To: <CAMXpfWsoTooEEpgyUvNFNo0tMLmPNO9bfAu_A+rq2+Ri6YbV9Q@mail.gmail.com>
From: Mario Casquero <mcasquer@redhat.com>
Date: Mon, 26 Aug 2024 16:18:11 +0200
Message-ID: <CAMXpfWuMZJqDndoNX7no4vJm9d0RwkV=OQ3XqQHqkj1YfvsmVw@mail.gmail.com>
Subject: Re: [PATCH v1] selftests/mm: fix charge_reserved_hugetlb.sh test
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	Shuah Khan <shuah@kernel.org>, Muchun Song <muchun.song@linux.dev>, 
	Mina Almasry <almasrymina@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Missing the hyphen :)
Tested-by: Mario Casquero <mcasquer@redhat.com>

On Mon, Aug 26, 2024 at 4:16=E2=80=AFPM Mario Casquero <mcasquer@redhat.com=
> wrote:
>
> This patch has been successfully tested. All hugetlb kernel selftests pas=
s now.
> # SUMMARY: PASS=3D12 SKIP=3D0 FAIL=3D0
>
> Tested by: Mario Casquero <mcasquer@redhat.com>
>
>
> On Wed, Aug 21, 2024 at 2:31=E2=80=AFPM David Hildenbrand <david@redhat.c=
om> wrote:
> >
> > Currently, running the charge_reserved_hugetlb.sh selftest we can
> > sometimes observe something like:
> >
> >   $ ./charge_reserved_hugetlb.sh -cgroup-v2
> >   ...
> >   write_result is 0
> >   After write:
> >   hugetlb_usage=3D0
> >   reserved_usage=3D10485760
> >   killing write_to_hugetlbfs
> >   Received 2.
> >   Deleting the memory
> >   Detach failure: Invalid argument
> >   umount: /mnt/huge: target is busy.
> >
> > Both cases are issues in the test.
> >
> > While the unmount error seems to be racy, it will make the test fail:
> >         $ ./run_vmtests.sh -t hugetlb
> >         ...
> >         # [FAIL]
> >         not ok 10 charge_reserved_hugetlb.sh -cgroup-v2 # exit=3D32
> >
> > The issue is that we are not waiting for the write_to_hugetlbfs process
> > to quit. So it might still have a hugetlbfs file open, about which
> > umount is not happy. Fix that by making "killall" wait for the process
> > to quit.
> >
> > The other error ("Detach failure: Invalid argument") does not seem to
> > result in a test error, but is misleading. Turns out write_to_hugetlbfs=
.c
> > unconditionally tries to cleanup using shmdt(), even when we only
> > mmap()'ed a hugetlb file. Even worse, shmaddr is never even set for the
> > SHM case. Fix that as well.
> >
> > With this change it seems to work as expected.
> >
> > Fixes: 29750f71a9b4 ("hugetlb_cgroup: add hugetlb_cgroup reservation te=
sts")
> > Reported-by: Mario Casquero <mcasquer@redhat.com>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Shuah Khan <shuah@kernel.org>
> > Cc: Muchun Song <muchun.song@linux.dev>
> > Cc: Mina Almasry <almasrymina@google.com>
> > Signed-off-by: David Hildenbrand <david@redhat.com>
> > ---
> >  .../selftests/mm/charge_reserved_hugetlb.sh   |  2 +-
> >  .../testing/selftests/mm/write_to_hugetlbfs.c | 21 +++++++++++--------
> >  2 files changed, 13 insertions(+), 10 deletions(-)
> >
> > diff --git a/tools/testing/selftests/mm/charge_reserved_hugetlb.sh b/to=
ols/testing/selftests/mm/charge_reserved_hugetlb.sh
> > index d680c00d2853a..67df7b47087f0 100755
> > --- a/tools/testing/selftests/mm/charge_reserved_hugetlb.sh
> > +++ b/tools/testing/selftests/mm/charge_reserved_hugetlb.sh
> > @@ -254,7 +254,7 @@ function cleanup_hugetlb_memory() {
> >    local cgroup=3D"$1"
> >    if [[ "$(pgrep -f write_to_hugetlbfs)" !=3D "" ]]; then
> >      echo killing write_to_hugetlbfs
> > -    killall -2 write_to_hugetlbfs
> > +    killall -2 --wait write_to_hugetlbfs
> >      wait_for_hugetlb_memory_to_get_depleted $cgroup
> >    fi
> >    set -e
> > diff --git a/tools/testing/selftests/mm/write_to_hugetlbfs.c b/tools/te=
sting/selftests/mm/write_to_hugetlbfs.c
> > index 6a2caba19ee1d..1289d311efd70 100644
> > --- a/tools/testing/selftests/mm/write_to_hugetlbfs.c
> > +++ b/tools/testing/selftests/mm/write_to_hugetlbfs.c
> > @@ -28,7 +28,7 @@ enum method {
> >
> >  /* Global variables. */
> >  static const char *self;
> > -static char *shmaddr;
> > +static int *shmaddr;
> >  static int shmid;
> >
> >  /*
> > @@ -47,15 +47,17 @@ void sig_handler(int signo)
> >  {
> >         printf("Received %d.\n", signo);
> >         if (signo =3D=3D SIGINT) {
> > -               printf("Deleting the memory\n");
> > -               if (shmdt((const void *)shmaddr) !=3D 0) {
> > -                       perror("Detach failure");
> > +               if (shmaddr) {
> > +                       printf("Deleting the memory\n");
> > +                       if (shmdt((const void *)shmaddr) !=3D 0) {
> > +                               perror("Detach failure");
> > +                               shmctl(shmid, IPC_RMID, NULL);
> > +                               exit(4);
> > +                       }
> > +
> >                         shmctl(shmid, IPC_RMID, NULL);
> > -                       exit(4);
> > +                       printf("Done deleting the memory\n");
> >                 }
> > -
> > -               shmctl(shmid, IPC_RMID, NULL);
> > -               printf("Done deleting the memory\n");
> >         }
> >         exit(2);
> >  }
> > @@ -211,7 +213,8 @@ int main(int argc, char **argv)
> >                         shmctl(shmid, IPC_RMID, NULL);
> >                         exit(2);
> >                 }
> > -               printf("shmaddr: %p\n", ptr);
> > +               shmaddr =3D ptr;
> > +               printf("shmaddr: %p\n", shmaddr);
> >
> >                 break;
> >         default:
> > --
> > 2.46.0
> >


