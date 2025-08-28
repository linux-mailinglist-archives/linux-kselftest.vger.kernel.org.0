Return-Path: <linux-kselftest+bounces-40170-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0F5CB39CC0
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Aug 2025 14:18:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CA32A0033B
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Aug 2025 12:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C29330FF21;
	Thu, 28 Aug 2025 12:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b2h0o7lG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 752EA30F936
	for <linux-kselftest@vger.kernel.org>; Thu, 28 Aug 2025 12:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756383095; cv=none; b=BsORj76demOrsQ+dNGzE5iiN5m2kwHfmqgrkm6qrAK7vdNkbKJE1TJs66nP9Rhu3u6O6vMFHuH9oNcvBDNO49N4bZPjAIoL57h4VIJjhwy9TMb9aUjVNjQjVZDrunnZrT+9mZDdlo2rutkp9Yk2pIfyP+SpmuwwFpyMFXSvXt/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756383095; c=relaxed/simple;
	bh=2ktMdNY3k61aPA2/lm50+GCes4gOy0DJDNPYFQGl4fs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QFrfRa9cyMvH+D9ef0MDtYrY/ddM6Q9/3YggO09Hl0AzEOoM+P5fQD+o7q5FZc9UGc1fLKHEtvWIe2dyl79UR3PPEbkhiqCse6xSiiVRkvrqi/0a6V+jD3WWJReESHvr6UPJYtwU8HBjUBirDyl5KzUqTeJg+hyaC6vakf8rAqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b2h0o7lG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756383091;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2UGqflFI8eChQOA7+GEyiXkR47jGjc2vCRu3os6QQyo=;
	b=b2h0o7lGP9NewypRJYFaNVf4JFY8KNFELmZZaCeuNMoEFCzBCcn71xRBRbS1k2NCGIDCj1
	BWGbD+5kxZJHS2ajSz3wSvJofp3BtRh2C0hVuJVzYAoXQqYLmhEWTm2pa9yjyvtjYmbyyR
	HWTg+IJ9Pxy8mVqOSd1IW9ryOG9FI+w=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-614-m11AM7EzPLWFk-Y1fySjLw-1; Thu, 28 Aug 2025 08:11:30 -0400
X-MC-Unique: m11AM7EzPLWFk-Y1fySjLw-1
X-Mimecast-MFC-AGG-ID: m11AM7EzPLWFk-Y1fySjLw_1756383089
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-325ce108e16so1472367a91.1
        for <linux-kselftest@vger.kernel.org>; Thu, 28 Aug 2025 05:11:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756383089; x=1756987889;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2UGqflFI8eChQOA7+GEyiXkR47jGjc2vCRu3os6QQyo=;
        b=II6pudznbMbWqF/Uj58lUDNj4XmhLpFyaqp9g9lIgYbMFnznqrKV0i+i98mBfUC90d
         bshePlfgnL0PMAApFOJU4s0jl/1aKFSO3X1O98D5xechoQa1H2Lljm7r30ReLbLCTXEd
         m5W38iPw3bCDTLsHS30qTiVJlcd+SeuKGEq47vOnjTMX0ItXgyvYOZbeOI2F9k+XDdNZ
         PcrUbmg5QT8ztnOUGCc6EEl8NVPKzXn1v9tjxLW550wMVpuEt9TwwBc60l1Lc5nVSh58
         YqjE9nEzf+YxqUjtZuNr/eJ7rBftBblNs/WhWRueLvEnx7ZB7626PpsrhJVaNf4yMJwC
         yUsQ==
X-Forwarded-Encrypted: i=1; AJvYcCXsBhqkRGA/sBFexIWt81WcmHTpf6EpwG6Zn4MyFz6pPcPksZ6JE0Lxqz3jyWaxU5EzMpjA0vjmaoqT7UblaMk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbNrlqfmya3b0xamshBQfxA79Ck6VUdc/hjTy8X7e+3GR1DF0M
	VeIBtz7unYCE0tJQt/Q1gwciG2iS9Mo86EQ2X/wq5Ly07j3Eh5xmErswlQ51nUXhImqqJ5TILlP
	SbZA02Qlli+PulVqoUBIl4P+ZIPurKKC0z7o11jdncmb8QmCfv/6EFkV3gOFvZChpOMCNl3QBt7
	YTv/tnql3YcgfNOStS5q+XdiG90bcl/qF3ANjrgeA9xGil
X-Gm-Gg: ASbGncvHstErKiRpIqvdBoeXO6DpxBtwC391VWD6JI3a85nsRomT4z77tDl9t9k7hMr
	yWBQpogsBVdl9w17VdKVQ3uMP5QARlqA7ZoWJAI+OC0DTnx9Yo0YKyDIhHQFuIfcP7VaDOp3TiB
	D4dzTbA02Mh3pVDCZj7Yk3lg==
X-Received: by 2002:a17:90b:4ec7:b0:31f:42e8:a896 with SMTP id 98e67ed59e1d1-32518b8233amr27589478a91.34.1756383088814;
        Thu, 28 Aug 2025 05:11:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG/1VuJO7sOj+w9DbBPxn7h7VRP4y4KKuh9IZVK6bmCJgpn+KrmoXKNVFrzEshD5AQ6z5yFNiOU64bGtA72s9Y=
X-Received: by 2002:a17:90b:4ec7:b0:31f:42e8:a896 with SMTP id
 98e67ed59e1d1-32518b8233amr27589439a91.34.1756383088324; Thu, 28 Aug 2025
 05:11:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250827075209.2347015-1-chuhu@redhat.com> <20250827075209.2347015-2-chuhu@redhat.com>
 <87956f34-e6b0-4d03-b30e-56be4f6b84f1@redhat.com>
In-Reply-To: <87956f34-e6b0-4d03-b30e-56be4f6b84f1@redhat.com>
From: Chunyu Hu <chuhu@redhat.com>
Date: Thu, 28 Aug 2025 20:11:17 +0800
X-Gm-Features: Ac12FXy5i29Lv7D_Qeef2pLLf4cwbU_o5j8qeJDX_02H1KqJvRXEd1sgycpMGA0
Message-ID: <CAKJHmxy_zT7kT5mz85OAbThcjYHHKoMRNwkdh8m+i94keQR2BQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] selftests/mm: fix hugepages cleanup too early
To: David Hildenbrand <david@redhat.com>
Cc: akpm@linux-foundation.org, shuah@kernel.org, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz, 
	rppt@kernel.org, surenb@google.com, mhocko@suse.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 27, 2025 at 7:41=E2=80=AFPM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 27.08.25 09:52, Chunyu Hu wrote:
> > The nr_hugepgs variable is used to keep the original nr_hugepages at th=
e
> > hugepage setup step at test beginning. After userfaultfd test, a cleaup=
 is
> > executed, both /sys/kernel/mm/hugepages/hugepages-*/nr_hugepages and
> > /proc/sys//vm/nr_hugepages are reset to 'original' value before userfau=
ltfd
> > test starts.
> >
> > Issue here is the value used to restore /proc/sys/vm/nr_hugepages is
> > nr_hugepgs which is the initial value before the vm_runtests.sh runs, n=
ot
> > the value before userfaultfd test starts. 'va_high_addr_swith.sh' tests
> > runs after that will possibly see no hugepages available for test, and =
got
> > EINVAL when mmap(HUGETLB), making the result invalid.
> >
> > And before pkey tests, nr_hugepgs is changed to be used as a temp varia=
ble
> > to save nr_hugepages before pkey test, and restore it after pkey tests
> > finish. The original nr_hugepages value is not tracked anymore, so no w=
ay
> > to restore it after all tests finish.
> >
> > Add a new variable nr_hugepgs_origin to save the original nr_hugepages,=
 and
> > and restore it to nr_hugepages after all tests finish. And change to us=
e
> > the nr_hugepgs variable to save the /proc/sys/vm/nr_hugeages after huge=
page
> > setup, it's also the value before userfaultfd test starts, and the corr=
ect
> > value to be restored after userfaultfd finishes. The va_high_addr_switc=
h.sh
> > broken will be resolved.
> >
> > Signed-off-by: Chunyu Hu <chuhu@redhat.com>
> > ---
> >   tools/testing/selftests/mm/run_vmtests.sh | 9 +++++++--
> >   1 file changed, 7 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/testing/selftests/mm/run_vmtests.sh b/tools/testing/=
selftests/mm/run_vmtests.sh
> > index 471e539d82b8..f1a7ad3ec6a7 100755
> > --- a/tools/testing/selftests/mm/run_vmtests.sh
> > +++ b/tools/testing/selftests/mm/run_vmtests.sh
> > @@ -172,13 +172,13 @@ fi
> >
> >   # set proper nr_hugepages
> >   if [ -n "$freepgs" ] && [ -n "$hpgsize_KB" ]; then
> > -     nr_hugepgs=3D$(cat /proc/sys/vm/nr_hugepages)
> > +     nr_hugepgs_origin=3D$(cat /proc/sys/vm/nr_hugepages)
>
> I'd call this "orig_nr_hugepgs".

Hi David,

Thank you for your review and valuable feedback. I will rename it with
a v2 and resend the two patches. Do you have suggestions on patch 2?

>
> But it's a shame that the naming is then out of sync with nr_size_hugepgs=
?

nr_size_hugepgs is for uffd-wp-mremap, the test need all sizes hugepages,
it's used to save and restore the nr_hugepagees of all sizes of hugepages,
it's a test case setup, not like nr_hugepgs which is a global/general setup=
.
They are not the same kind, maybe they don't need to be aligned...

>
>
> >       needpgs=3D$((needmem_KB / hpgsize_KB))
> >       tries=3D2
> >       while [ "$tries" -gt 0 ] && [ "$freepgs" -lt "$needpgs" ]; do
> >               lackpgs=3D$((needpgs - freepgs))
> >               echo 3 > /proc/sys/vm/drop_caches
> > -             if ! echo $((lackpgs + nr_hugepgs)) > /proc/sys/vm/nr_hug=
epages; then
> > +             if ! echo $((lackpgs + nr_hugepgs_origin)) > /proc/sys/vm=
/nr_hugepages; then
> >                       echo "Please run this test as root"
> >                       exit $ksft_skip
> >               fi
> > @@ -189,6 +189,7 @@ if [ -n "$freepgs" ] && [ -n "$hpgsize_KB" ]; then
> >               done < /proc/meminfo
> >               tries=3D$((tries - 1))
> >       done
> > +     nr_hugepgs=3D$(cat /proc/sys/vm/nr_hugepages)
> >       if [ "$freepgs" -lt "$needpgs" ]; then
> >               printf "Not enough huge pages available (%d < %d)\n" \
> >                      "$freepgs" "$needpgs"
> > @@ -532,6 +533,10 @@ CATEGORY=3D"page_frag" run_test ./test_page_frag.s=
h aligned
> >
> >   CATEGORY=3D"page_frag" run_test ./test_page_frag.sh nonaligned
> >
> > +if [ "${HAVE_HUGEPAGES}" =3D 1 ]; then
> > +     echo "$nr_hugepgs_origin" > /proc/sys/vm/nr_hugepages
> > +fi
>
> FWIW, I think the tests should maybe be doing that
> (save+configure+restore) themselves, like we do with THP settings through=
.
>
> thp_save_settings()
> thp_write_settings()
>
> and friends.
>
> This is not really something run_vmtests.sh should bother with.
>
> A bigger rework, though ...

Totally agree, with the c interface to do that is better. then the
vm_runtest.sh would  be clean. It's a bigger rework outside of this topic..=
.

>
> --
> Cheers
>
> David / dhildenb
>


--
----
Thanks,
Chunyu Hu


