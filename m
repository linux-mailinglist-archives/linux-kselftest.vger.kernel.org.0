Return-Path: <linux-kselftest+bounces-47793-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 57F41CD3DC0
	for <lists+linux-kselftest@lfdr.de>; Sun, 21 Dec 2025 10:35:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 714B83002E93
	for <lists+linux-kselftest@lfdr.de>; Sun, 21 Dec 2025 09:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0F55274669;
	Sun, 21 Dec 2025 09:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fPucl+5C";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="MekZWg03"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF0422F755
	for <linux-kselftest@vger.kernel.org>; Sun, 21 Dec 2025 09:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766309747; cv=none; b=sdbWzKhfDCvsNBV0cQnAONidecaVeznfwgGFgGEfTfz9+/6h/SI8/jp4w/4Y5MX2URz6BZyCBWBESOb0MLy3YeYhM1jfTp74SSwKm2wT1VvcXia+lS3xjHOhItNb4nKgsqOQhjM4sTuFBZv9diCe56kNX3YCconZ8TH5iMxASXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766309747; c=relaxed/simple;
	bh=mu3dZVFcS0faFuqNAxSJ5DAGdNtfxdFN572U1hZaZKI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WS57pj+83VHIbLThQ5Q/2EnNfNX3OjwPfaOCM07F8kl9kNUk3e3tMyG6Z54bkN+QExLQywZ94itfH8Zew5gD2N/zdtmSnSIt2iolBwWENjKNhxjZ02cawIqm98BkWiuldnYGsU4P9zKTGfIE0o7dlUgT37DnGk0Ig+spTRFIwn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fPucl+5C; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=MekZWg03; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766309744;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K0b0ttvVfnzqnnqxYqjwrgGto4u6m79oNU2NLdK5EaY=;
	b=fPucl+5Cy/jvnooerrd6aDNp4oWqM6+1Swgm+1hJREIFT1XElhkpQqRYgoYi/E/soU6PXq
	yxcHnQvHYsL6UMLgX4XFDkX1S9/bq/qKufco2PAqXTaMnCW2IKK3W/g3WwxOo7RJmhvpyW
	5egpp4zsYNJ5uf7EX+ANkfIbAnn23F8=
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-452-nXJuMENCOtCfXrjM89q_9w-1; Sun, 21 Dec 2025 04:35:42 -0500
X-MC-Unique: nXJuMENCOtCfXrjM89q_9w-1
X-Mimecast-MFC-AGG-ID: nXJuMENCOtCfXrjM89q_9w_1766309741
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-2b0588c6719so2676824eec.0
        for <linux-kselftest@vger.kernel.org>; Sun, 21 Dec 2025 01:35:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1766309741; x=1766914541; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K0b0ttvVfnzqnnqxYqjwrgGto4u6m79oNU2NLdK5EaY=;
        b=MekZWg037TsRYuw+0HbFunG3nt/hox9zsLEjTWT5L++tQRDR7pm3ioX8xE0URZjYzg
         HQwRW7NAxEC7gZBnN2JyZa9EVZolt8kuIlSSr3Aeri9hMiX7eXSgTZPpWvkBbkqJC0sY
         Etg5lhu9fFGSa9H5S5hDctypyjnBWDYKqwZuPV1rO2P9Ffy0SrGT1IY+cYf7+4n/ZssE
         zahxBK0EVFYO5jsIjauTJGTYvc8kx+AbcTULI9lO4CsFlI21U1TrMZKvwn4ickDOa0At
         uQ3IYH+vASAZmyBgMPirEZgFBgbd1QqJbVPSoPHUNz0wKU5VPkhsRmFFiRyB6qgIU9Iu
         jm/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766309741; x=1766914541;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=K0b0ttvVfnzqnnqxYqjwrgGto4u6m79oNU2NLdK5EaY=;
        b=Icib04IVGHJA2auxZDmNNuE+IkHbAt6QRCrBBDqETsQAwm55V4cgGLKh8aVMH63rw9
         ayPfDWCYa2eyJgp41mTyFE8ToTpV2dmA6HADryoh5Pso3QqW/8v2nvyLlc/vawurJmjv
         E+fbQMi0B3WVkvpUj8ptV3Q+njbwlXPCZJRt6BGskSSkoGKUSLSz9yN7LUuw8sHz7+om
         T9C7OvLzEKDZssXGiZ905SfQLmSKeGO1LQVh9RqoQ5QoIFhZJ4/P/ZfaJBBOcYuIXyxU
         JIxD15Ug4uz6+ieymKkQZLyDbMc5s0jblhdXpcFlA/gkXaOEcy9Y4NbhF7Za+63NuCuU
         9xxw==
X-Forwarded-Encrypted: i=1; AJvYcCVYaodq7rgvtuHqvmcgu0gkkR/0OAHr+dpgOdd2ApRzrhGT7zdDSGwwxLiKQQbvmtEjVWYIUPphqCL+AonIJbw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwO3FwFu437P5B4twxQWLj0oyWOASI+VN+/oDMb4g10wtTEQdRu
	13tSzFufClI+SsvGNBNcF7esDrpHlpLL9IckGVia2QQr4WrIKCUDhoyBxSpM845ZGCjYVnXSI9m
	HeV/qE82AgWuZRbYcQfdmCjJi0FlfANZ+pFTJykCkupOQDRq42sb3MBoOWEvToJOT2kibCoZsIi
	YAITPdZYOswx6ZDwcgrhKUBLyJCnT55tk6pk8dr5DElNiI
X-Gm-Gg: AY/fxX4SiL3q67b2vIaYmAqIcQLPGeCaSlaCZSbYem4fwsimHpgBbWidqoLOxuPO2dC
	rZP3d8Yqm9Zko9jT4aIn9jLlhbxBfz8XFZB0BkJSwrv7S/K+FqP887RLyJlH01bd8jFmD7oeXaO
	S4ZUtY3KTGAk0cn/lFtDcoxyYbsyFeNnM7ms3599dMZhDaONkOSwmHUro1Pd/vtz+9gu0=
X-Received: by 2002:a05:7300:e2c4:b0:2a9:9125:ac0c with SMTP id 5a478bee46e88-2b04cb3be5emr12744652eec.9.1766309740953;
        Sun, 21 Dec 2025 01:35:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGUw9TgWiHOkqocZLrZuRSZYEWQGLXVlBNWuV5SikvrxsD/8J+sWbXaeQCGZlrmMv1T0rJtd+XOi0Aj6jWZZgI=
X-Received: by 2002:a05:7300:e2c4:b0:2a9:9125:ac0c with SMTP id
 5a478bee46e88-2b04cb3be5emr12744636eec.9.1766309740573; Sun, 21 Dec 2025
 01:35:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251221085810.3163919-1-liwang@redhat.com> <20251221085810.3163919-3-liwang@redhat.com>
 <74414ade-63fb-47ff-adda-903949468b88@kernel.org>
In-Reply-To: <74414ade-63fb-47ff-adda-903949468b88@kernel.org>
From: Li Wang <liwang@redhat.com>
Date: Sun, 21 Dec 2025 17:35:28 +0800
X-Gm-Features: AQt7F2pI9TPRNFP6_5rrof-BE4Ld9AmH3MgEbxo8XJtb4yqP0gpcixLOLcYjTg0
Message-ID: <CAEemH2eH0a6vHhv80hDcTBxTUYHALrOKjtvWnajCwPk_zLpJ3Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] selftests/mm/charge_reserved_hugetlb.sh: add waits
 with timeout helper
To: "David Hildenbrand (Red Hat)" <david@kernel.org>
Cc: akpm@linux-foundation.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Mark Brown <broonie@kernel.org>, Shuah Khan <shuah@kernel.org>, Waiman Long <longman@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

David Hildenbrand (Red Hat) <david@kernel.org> wrote:

> On 12/21/25 09:58, Li Wang wrote:
> > The hugetlb cgroup usage wait loops in charge_reserved_hugetlb.sh were
> > unbounded and could hang forever if the expected cgroup file value neve=
r
> > appears (e.g. due to bugs, timing issues, or unexpected behavior).
>
> Did you actually hit that in practice? Just wondering.

Yes.

On an aarch64 64k setup with 512MB hugepages, the test failed earlier
(hugetlbfs got mounted with an effective size of 0 due to size=3D256M), so
write_to_hugetlbfs couldn=E2=80=99t allocate the expected pages. After that=
, the
script=E2=80=99s wait loops never observed the target value, so they spun f=
orever.

Detail see below logs.

>
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
> > This makes the waits consistent and adds a hard timeout (120 tries with
> > 0.5s sleep) so the test fails instead of stalling indefinitely.
> >
> > Signed-off-by: Li Wang <liwang@redhat.com>
> > Cc: David Hildenbrand <david@kernel.org>
> > Cc: Mark Brown <broonie@kernel.org>
> > Cc: Shuah Khan <shuah@kernel.org>
> > Cc: Waiman Long <longman@redhat.com>
> > ---
> >   .../selftests/mm/charge_reserved_hugetlb.sh   | 47 ++++++++++--------=
-
> >   1 file changed, 26 insertions(+), 21 deletions(-)
> >
> > diff --git a/tools/testing/selftests/mm/charge_reserved_hugetlb.sh b/to=
ols/testing/selftests/mm/charge_reserved_hugetlb.sh
> > index e1fe16bcbbe8..249a5776c074 100755
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
> > @@ -112,41 +112,46 @@ function setup_cgroup() {
> >     fi
> >   }
> >
> > +function wait_for_file_value() {
> > +  local path=3D"$1"
> > +  local expect=3D"$2"
> > +  local max_tries=3D"120"
> > +
> > +  local i cur
>
> I would just move "cur" into the loop; I don't see a reason to print it
> on the error path when you printed the value on the last "Waiting" line?
>
>         local cur=3D"$(cat "$path")"

+1

>
> Also, not sure if you really need the "local i" here.
>
> What if the path does not exist, do we want to catch that earlier and
> bail out instead of letting "cat" fail here?

Yes, we can add a file check before the "cat" loop.

>
> > +  for ((i=3D1; i<=3Dmax_tries; i++)); do
> > +    cur=3D"$(cat "$path")"
> > +    if [[ "$cur" =3D=3D "$expect" ]]; then
> > +      return 0
> > +    fi
> > +    echo "Waiting for $path to become '$expect' (current: '$cur') (try=
 $i/$max_tries)"
> > +    sleep 0.5
>
> Any reason we don't go for the more intuitive "wait 1s" - max 60s wait?

Sure, the total loop time are same.

--=20
Regards,
Li Wang


