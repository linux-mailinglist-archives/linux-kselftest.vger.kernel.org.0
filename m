Return-Path: <linux-kselftest+bounces-47814-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 510FCCD47F8
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Dec 2025 01:56:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1BB0430056C9
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Dec 2025 00:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8754C21ADA4;
	Mon, 22 Dec 2025 00:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZplUHLtO";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="N+ZNDEQg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D771DF72C
	for <linux-kselftest@vger.kernel.org>; Mon, 22 Dec 2025 00:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766364979; cv=none; b=CC06pdHFrhZMNsnRzduVXHaw/bpMkcQyVOGLEvxcbD4o8KWSfXTQyoIjC/zG92S4etI+GBAZiyja4OhoB/KH17t7ShKLcHO1HWiS7Lo7wcUIzsBF/XctXS6kJhjJOQLba0zjy1jzY7IhybbmwaN1SiXSN7Bmvr+YmcBZLuR+Jo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766364979; c=relaxed/simple;
	bh=nY91Zttno0jSUiM+WJgv7O4FZUHX8c9T+2RmZlYD8yU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rkFQpkkIw/mg/etf2082q/v7T8Dr1lRDEmsfQi4TeOIy7uskFrJ7g3+iUtKm3OjKUn+OBYsNxBUgwViNclLi+ZSrUJ43llgvemuKoPyw/b/iVQbV055FEAZEd1prH5hQhvCvlw7Sh1sqjFDsyzkF791Gt+VwENDjTJf/65INre8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZplUHLtO; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=N+ZNDEQg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766364976;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/NMCIq06x6X5N8QIPqgKY8o8XY7IL1HTrfa4Xt9yLJw=;
	b=ZplUHLtOqNNDaUIAHbuAzTvd/p9PPiJmtwW+J3gMDt0UALkMeo8vymbHYwqAK73sXVdw2Z
	tevkHerQDnRs8FTb2XrOqNL0E1qX82kKz2VCSX84UtOWgRlRKY88qjJy7x8WOCrOdlrVkp
	LcjbHQC5QRY9FAb9Xw/N47CLFZP77Xk=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-235-V2AkjYLzNE2AMRCI9l-K6A-1; Sun, 21 Dec 2025 19:56:15 -0500
X-MC-Unique: V2AkjYLzNE2AMRCI9l-K6A-1
X-Mimecast-MFC-AGG-ID: V2AkjYLzNE2AMRCI9l-K6A_1766364974
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c1290abb178so6460367a12.2
        for <linux-kselftest@vger.kernel.org>; Sun, 21 Dec 2025 16:56:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1766364974; x=1766969774; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/NMCIq06x6X5N8QIPqgKY8o8XY7IL1HTrfa4Xt9yLJw=;
        b=N+ZNDEQgdN592NI0zmgRc5DwKcruNMbi0AiNuOf+v8Y+shTLnUbdzdtJHHXgKVatq3
         fnZ7aLYIv1g8z7+FNRFK65jon9Q/2fGNlrvoOpLyVDJUWjZtKMXu6R+Xd/tBhapB6//n
         AbYKbpguzogOGgmZ1fBLBaXEQLf/+uMvSfFf+RPmmq3DUnb2zHjDxv2163CCd3AWzwaj
         VsPrq6brrSlClHsgXOJ8ULskvXsbxYPvTEatu4rBD+VHevOM1eA6fX9asI2rX4O60kGK
         nNzS6mzPhVSwCXC7AbL6m80yY2T+R1JFZGUm1If+5HsE5PHPSuDQbAs4PAd/c6AdJ4km
         9jvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766364974; x=1766969774;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/NMCIq06x6X5N8QIPqgKY8o8XY7IL1HTrfa4Xt9yLJw=;
        b=Xuu1jkxSr0DokyCMKBtJ487m55mvG93swd67g/93uo+Dk1uC4FEU7pw2ivmtZDMFZg
         LSnw85etUAjtLM8YCgpsnfkxz7jDvNFzgJQLZkG3aSGcGGZASXr3Qld4nMDAhv9ekSOi
         kIphP6JX4azBuV7IDzQwRvfG5IfCcQP2UDO+ryRtCRprQW8N+TQIp4azwYRAIAjIn6qP
         gLv71by4MoNBZRR6k+PERyYtz2gzhAsVXChB2qA/ym+8nOZCtDopTaWHwB35lYlN+bTx
         74KdPU8d1yawWcYNJwAFvVeVvU+BJIqJ8pozD661sb1mGw6kqkm0D7Za/qXyHaqQ2Smp
         zjcA==
X-Forwarded-Encrypted: i=1; AJvYcCWt5FNXwGxXHv9t3X359elPIsiG/ajX8iPdCr0n/uQCWdO2h2iXug9rFRkgz/vySSDGXaUoXKuBFi2b0KUjnXU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeHiEc9CEbdbzjPxLpofqMpLRTbu2VxcuxAdiO+svZqBcsOjQu
	qXNLwrsNfBAK9j8DtLPV+9faPh7EHTQjnXHE42HmC4RUJKty9Kn3SBwSf/Sod5Jno/wfjXxpoPB
	Hdybq9bmu1nz3fXHbD/PnI+a97ghWAKBbFuCFQtGa4kyh07y1Gum9kwSiSXh9Hw+XDR2JTAia6X
	lRqHN64g7kcWc5e0Min3I6wfPUNcv3/bIyATUEjfjCGEjO
X-Gm-Gg: AY/fxX5eeSE1evEJwBbmKlcgJGxOerVvJZeiAcJS7jWj0Kol4RRegghTIQZkab/i2nt
	zxPf1972EX9zV7JAhiGXmu1DCZIVjinuaK5J3MBnNqPgonV3p5GMQOOkk/R1rhxebkyLRTd+tRx
	kVdEXJcoWNrp3PRzNb50LinsQzts1Yh5VsDux1/ldw8PgOnLSm4HROrQhUhZrFvp8fcYA=
X-Received: by 2002:a05:7301:fc12:b0:2ae:5fb4:c5f1 with SMTP id 5a478bee46e88-2b05ec8580fmr8756379eec.22.1766364973906;
        Sun, 21 Dec 2025 16:56:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF0029GFn24iMMCw3XfWWVMPRTwXTkFaymfwbymZKK/ZbqfRE+pohNx1p4BX0tdPi90xo3sUbGz84BHevp2vwo=
X-Received: by 2002:a05:7301:fc12:b0:2ae:5fb4:c5f1 with SMTP id
 5a478bee46e88-2b05ec8580fmr8756369eec.22.1766364973450; Sun, 21 Dec 2025
 16:56:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251221122639.3168038-1-liwang@redhat.com> <20251221122639.3168038-4-liwang@redhat.com>
 <33d5bdc7-0fde-4a97-aa1a-f8565e196ccd@redhat.com>
In-Reply-To: <33d5bdc7-0fde-4a97-aa1a-f8565e196ccd@redhat.com>
From: Li Wang <liwang@redhat.com>
Date: Mon, 22 Dec 2025 08:56:01 +0800
X-Gm-Features: AQt7F2o8rt4dEdkF8DAco4IG4TTUWxg7AyWZZTuM29XF18apL6ox-9F2z5tlIYs
Message-ID: <CAEemH2ehOUyDqHhn5+Mu2B31dCpOhDv6AL7sEFU5Vt7nSST=Tw@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] selftests/mm/charge_reserved_hugetlb.sh: add waits
 with timeout helper
To: Waiman Long <llong@redhat.com>
Cc: akpm@linux-foundation.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	David Hildenbrand <david@kernel.org>, Mark Brown <broonie@kernel.org>, Shuah Khan <shuah@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 22, 2025 at 4:30=E2=80=AFAM Waiman Long <llong@redhat.com> wrot=
e:
>
>
> On 12/21/25 7:26 AM, Li Wang wrote:
> > The hugetlb cgroup usage wait loops in charge_reserved_hugetlb.sh were
> > unbounded and could hang forever if the expected cgroup file value neve=
r
> > appears (e.g. due to write_to_hugetlbfs in Error mapping).
> >
> > --- Error log ---
> >    # uname -r
> >    6.12.0-xxx.el10.aarch64+64k
> >
> >    # ls /sys/kernel/mm/hugepages/hugepages-*
> >    hugepages-16777216kB/  hugepages-2048kB/  hugepages-524288kB/
> >
> >    #./charge_reserved_hugetlb.sh -cgroup-v2
> >    # -----------------------------------------
> >    ...
> >    # nr hugepages =3D 10
> >    # writing cgroup limit: 5368709120
> >    # writing reseravation limit: 5368709120
> >    ...
> >    # write_to_hugetlbfs: Error mapping the file: Cannot allocate memory
> >    # Waiting for hugetlb memory reservation to reach size 2684354560.
> >    # 0
> >    # Waiting for hugetlb memory reservation to reach size 2684354560.
> >    # 0
> >    # Waiting for hugetlb memory reservation to reach size 2684354560.
> >    # 0
> >    # Waiting for hugetlb memory reservation to reach size 2684354560.
> >    # 0
> >    # Waiting for hugetlb memory reservation to reach size 2684354560.
> >    # 0
> >    # Waiting for hugetlb memory reservation to reach size 2684354560.
> >    # 0
> >    ...
> >
> > Introduce a small helper, wait_for_file_value(), and use it for:
> >    - waiting for reservation usage to drop to 0,
> >    - waiting for reservation usage to reach a given size,
> >    - waiting for fault usage to reach a given size.
> >
> > This makes the waits consistent and adds a hard timeout (60 tries with
> > 1s sleep) so the test fails instead of stalling indefinitely.
> >
> > Signed-off-by: Li Wang <liwang@redhat.com>
> > Cc: David Hildenbrand <david@kernel.org>
> > Cc: Mark Brown <broonie@kernel.org>
> > Cc: Shuah Khan <shuah@kernel.org>
> > Cc: Waiman Long <longman@redhat.com>
> > ---
> >   .../selftests/mm/charge_reserved_hugetlb.sh   | 51 +++++++++++-------=
-
> >   1 file changed, 30 insertions(+), 21 deletions(-)
> >
> > diff --git a/tools/testing/selftests/mm/charge_reserved_hugetlb.sh b/to=
ols/testing/selftests/mm/charge_reserved_hugetlb.sh
> > index fa6713892d82..447769657634 100755
> > --- a/tools/testing/selftests/mm/charge_reserved_hugetlb.sh
> > +++ b/tools/testing/selftests/mm/charge_reserved_hugetlb.sh
> > @@ -100,7 +100,7 @@ function setup_cgroup() {
> >     echo writing cgroup limit: "$cgroup_limit"
> >     echo "$cgroup_limit" >$cgroup_path/$name/hugetlb.${MB}MB.$fault_lim=
it_file
> >
> > -  echo writing reseravation limit: "$reservation_limit"
> > +  echo writing reservation limit: "$reservation_limit"
> >     echo "$reservation_limit" > \
> >       $cgroup_path/$name/hugetlb.${MB}MB.$reservation_limit_file
> >
> > @@ -112,41 +112,50 @@ function setup_cgroup() {
> >     fi
> >   }
> >
> > +function wait_for_file_value() {
> > +  local path=3D"$1"
> > +  local expect=3D"$2"
> > +  local max_tries=3D60
> > +
> > +  if [[ ! -r "$path" ]]; then
> > +    echo "ERROR: cannot read '$path', missing or permission denied"
> > +    return 1
> > +  fi
> > +
> > +  for ((i=3D1; i<=3Dmax_tries; i++)); do
> > +    local cur=3D"$(cat "$path")"
> > +    if [[ "$cur" =3D=3D "$expect" ]]; then
> > +      return 0
> > +    fi
> > +    echo "Waiting for $path to become '$expect' (current: '$cur') (try=
 $i/$max_tries)"
> > +    sleep 1
> > +  done
> > +
> > +  echo "ERROR: timeout waiting for $path to become '$expect'"
> > +  return 1
> > +}
> > +
> >   function wait_for_hugetlb_memory_to_get_depleted() {
> >     local cgroup=3D"$1"
> >     local path=3D"$cgroup_path/$cgroup/hugetlb.${MB}MB.$reservation_usa=
ge_file"
> > -  # Wait for hugetlbfs memory to get depleted.
> > -  while [ $(cat $path) !=3D 0 ]; do
> > -    echo Waiting for hugetlb memory to get depleted.
> > -    cat $path
> > -    sleep 0.5
> > -  done
> > +
> > +  wait_for_file_value "$path" "0"
> >   }
> >
> >   function wait_for_hugetlb_memory_to_get_reserved() {
> >     local cgroup=3D"$1"
> >     local size=3D"$2"
> > -
> >     local path=3D"$cgroup_path/$cgroup/hugetlb.${MB}MB.$reservation_usa=
ge_file"
> > -  # Wait for hugetlbfs memory to get written.
> > -  while [ $(cat $path) !=3D $size ]; do
> > -    echo Waiting for hugetlb memory reservation to reach size $size.
> > -    cat $path
> > -    sleep 0.5
> > -  done
> > +
> > +  wait_for_file_value "$path" "$size"
> >   }
> >
> >   function wait_for_hugetlb_memory_to_get_written() {
> >     local cgroup=3D"$1"
> >     local size=3D"$2"
> > -
> >     local path=3D"$cgroup_path/$cgroup/hugetlb.${MB}MB.$fault_usage_fil=
e"
> > -  # Wait for hugetlbfs memory to get written.
> > -  while [ $(cat $path) !=3D $size ]; do
> > -    echo Waiting for hugetlb memory to reach size $size.
> > -    cat $path
> > -    sleep 0.5
> > -  done
> > +
> > +  wait_for_file_value "$path" "$size"
> >   }
> >
> >   function write_hugetlbfs_and_get_usage() {
>
> wait_for_file_value() now return 0 onr success and 1 on timeout.
> However, none of the callers of the wait_for_hugetlb_memory* are
> checking their return values and acting accordingly. Are we expecting
> that the test will show failure because the waiting isn't completed or
> should we explicitly exit with ksft_fail (1) value?

Hmm, it seems the test shouldn't exit too early.

As the wait_for_hugetlb_memory* is only trying 60s to examine the file
value, if timeouted, we still need to keep going because the test requires
CLEANUP work and exit/report from there.

The key point of each subtest is to save the '$write_result' value and
examine it
which controls the whole test to exit.

e.g.

This is an intentional error test:

# ./charge_reserved_hugetlb.sh -cgroup-v2
CLEANUP DONE
...
Writing to this path: /mnt/huge/test
Writing this size: 2684354560
Not populating.
Not writing to memory.
Using method=3D0
Shared mapping.
RESERVE mapping.
Allocating using HUGETLBFS.
write_to_hugetlbfs: Error mapping the file: Cannot allocate memory
Waiting for /sys/fs/cgroup/hugetlb_cgroup_test/hugetlb.512MB.rsvd.current
to become '2684354560' (current: '0') (try 1/60)
Waiting for /sys/fs/cgroup/hugetlb_cgroup_test/hugetlb.512MB.rsvd.current
to become '2684354560' (current: '0') (try 2/60)
Waiting for /sys/fs/cgroup/hugetlb_cgroup_test/hugetlb.512MB.rsvd.current
to become '2684354560' (current: '0') (try 3/60)
Waiting for /sys/fs/cgroup/hugetlb_cgroup_test/hugetlb.512MB.rsvd.current
to become '2684354560' (current: '0') (try 4/60)
...
Waiting for /sys/fs/cgroup/hugetlb_cgroup_test/hugetlb.512MB.rsvd.current
to become '2684354560' (current: '0') (try 60/60)
ERROR: timeout waiting for
/sys/fs/cgroup/hugetlb_cgroup_test/hugetlb.512MB.rsvd.current to
become '2684354560'
After write:
hugetlb_usage=3D0
reserved_usage=3D0
0
0
Memory charged to hugtlb=3D0
Memory charged to reservation=3D0
expected (2684354560) !=3D actual (0): Reserved memory not charged to
reservation usage.
CLEANUP DONE


--=20
Regards,
Li Wang


