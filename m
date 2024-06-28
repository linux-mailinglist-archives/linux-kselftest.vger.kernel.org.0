Return-Path: <linux-kselftest+bounces-12939-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE37991C4C3
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Jun 2024 19:25:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD9B11C22462
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Jun 2024 17:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDBDA1CCCA6;
	Fri, 28 Jun 2024 17:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="blEU5tDu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34DD61CB33B
	for <linux-kselftest@vger.kernel.org>; Fri, 28 Jun 2024 17:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719595516; cv=none; b=dTThkmEICf3GWfUjhxNr/AxYd4E7bF16uEISk6UkU5yVycKpCH99UvRmdY8lcXk48yEw+oHIDTV7p9G1diTeE5ZDB3ErICw/+T9zGtmqvht2Wc74LWsJfDCsTGQtkcj+/hb802dlGA9USKCNYAufjKt8g2M0HLuiqwQAi2EDfLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719595516; c=relaxed/simple;
	bh=kq1fpL86p3CAakLQbNhpZmymFcmjyTTnrGV3h0AgDm0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=udC6lphs0UGwxcku5Pfcy9zWu/9RO1WhgQKSqUfhUNpqCbFOTOgRdV6VssUNRFpHdhpjGZA30zYdN6M3u+yhvR4RG135JFrerrQ1OiixGK6Wa90j2vAHz09qKq8H9txnj1S4ByrLpU3d1v7JY9tPJ0dtv9YxHVj8QGGE+h46yXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=blEU5tDu; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-42565697036so12328305e9.1
        for <linux-kselftest@vger.kernel.org>; Fri, 28 Jun 2024 10:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719595513; x=1720200313; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=caKA1ZLZy4Gxv4ZL6Bf0GGH+gpZqMfFYuX6KpD7fNlo=;
        b=blEU5tDu3IEAyIanTnVhuFKUcTpFJoNUgrSdcBP7RVXUBT7Nv1RIAEc1Afs9qgHWK2
         1jbhpH6b945m1sogPKGsS6wOtpIphtC6itawFslUnWQVF/pIUzArdwLPWAdFGXTFOCvJ
         sOYj1v0DIjWF+mIAXEOWXC6y5rKzRv9v04g2y0Ef3JjDuaGDOh4zgTSfV7Ldc5eSAPXx
         WGCOoIe/6DTe0i5AlRo5vfxBHn+ytaX9QyeZc6z4AxXXoA+0bLj7C5+p56WC/fOQ7zfw
         M6UE8gyseC9jjkWDnRyWQjPNblOo+JiB/tJV2frL77FPr8BeMO6kvAkjoBX9bTN3lUgd
         Nz6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719595513; x=1720200313;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=caKA1ZLZy4Gxv4ZL6Bf0GGH+gpZqMfFYuX6KpD7fNlo=;
        b=J1uvVR2UKlIayRKxDTo/tGBAbt3v9nJkRLZLqfqfiFjzg2/bLhCiI917EpbuCY9QkG
         AJWWAfrBtj4zp875/4+QmmmRCQSbwpxjU/OkmDlLhLvlfXDSMbsKmmr1AwrctGHuJDOm
         sMj46VzOgoxJuPgm19x9w7wwkY3RDyGzDgbtpxZHgfRABCKjWMFYIc67muIXSxNnEtCQ
         Yl12bXsgpQRIlqtfGgSMOmujdOdn138kuVEHi80DT/zz+kgbscYQTkrUixkjjdC6JDAb
         5YgVfQdpHYotYTneut9NTwAPokYgFSBcQWqHnRvO+zKBfSwG371XFOjDN3GGlVfVYDue
         ySqQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2uqrQV3KqRiBgyM7jATH6wGWWQiZiHG5kYt5W5Hp3KG+bO6HAI/kav78ot8eh5ciYYW+v5ZXiBPDh7av4aKAfpmlWjIO2m8h6HVKZzA4K
X-Gm-Message-State: AOJu0YzN1LAvpD6aB/psCvs0tAEoNrHIQFZ+IDtr4v1acrDOI/sB2Yue
	9rMsiX+YqaIKs6ygYmFr2ED+tev6jW0p9HFiEM+TD4Qs90x+Mhel2nVWMhdMVRUKoc/XtGnIl6k
	ynP/lKb21WV4wzrR4gwXKNGIXSb/TWhPpMGRk
X-Google-Smtp-Source: AGHT+IHaga+0HZwFoMa7vh1+QWpuNmbt+Pa/Udmt9iDW5i8J5dXuxOLSqkHGx+gHqUzkUgc64qZI0rblrxW0ml7XPRE=
X-Received: by 2002:a5d:648c:0:b0:367:42bc:b2dc with SMTP id
 ffacd0b85a97d-36760a6ab1fmr2440949f8f.7.1719595513311; Fri, 28 Jun 2024
 10:25:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240626050818.2277273-1-jiaqiyan@google.com> <20240626050818.2277273-4-jiaqiyan@google.com>
 <0a28831c-b28e-6db5-0ef3-70940e75d4d2@huawei.com>
In-Reply-To: <0a28831c-b28e-6db5-0ef3-70940e75d4d2@huawei.com>
From: Jiaqi Yan <jiaqiyan@google.com>
Date: Fri, 28 Jun 2024 10:25:02 -0700
Message-ID: <CACw3F52DHhTM4M8GEURjft_Qx=kvzRvFxHp-pkYdpXAim7anMg@mail.gmail.com>
Subject: Re: [PATCH v6 3/4] selftest/mm: test enable_soft_offline behaviors
To: Miaohe Lin <linmiaohe@huawei.com>
Cc: jane.chu@oracle.com, rdunlap@infradead.org, ioworker0@gmail.com, 
	muchun.song@linux.dev, akpm@linux-foundation.org, shuah@kernel.org, 
	corbet@lwn.net, osalvador@suse.de, rientjes@google.com, duenwen@google.com, 
	fvdl@google.com, linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
	linux-doc@vger.kernel.org, Naoya Horiguchi <nao.horiguchi@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 27, 2024 at 8:29=E2=80=AFPM Miaohe Lin <linmiaohe@huawei.com> w=
rote:
>
> On 2024/6/26 13:08, Jiaqi Yan wrote:
> > Add regression and new tests when hugepage has correctable memory
> > errors, and how userspace wants to deal with it:
> > * if enable_soft_offline=3D1, mapped hugepage is soft offlined
> > * if enable_soft_offline=3D0, mapped hugepage is intact
> >
> > Free hugepages case is not explicitly covered by the tests.
> >
> > Hugepage having corrected memory errors is emulated with
> > MADV_SOFT_OFFLINE.
>
> Thanks for update.
>
> >
> > Signed-off-by: Jiaqi Yan <jiaqiyan@google.com>
> > ---
> >  tools/testing/selftests/mm/.gitignore         |   1 +
> >  tools/testing/selftests/mm/Makefile           |   1 +
> >  .../selftests/mm/hugetlb-soft-offline.c       | 228 ++++++++++++++++++
> >  tools/testing/selftests/mm/run_vmtests.sh     |   4 +
> >  4 files changed, 234 insertions(+)
> >  create mode 100644 tools/testing/selftests/mm/hugetlb-soft-offline.c
> ...
> > +static void test_soft_offline_common(int enable_soft_offline)
> > +{
> > +     int fd;
> > +     int expect_errno =3D enable_soft_offline ? 0 : EOPNOTSUPP;
> > +     struct statfs file_stat;
> > +     unsigned long hugepagesize_kb =3D 0;
> > +     unsigned long nr_hugepages_before =3D 0;
> > +     unsigned long nr_hugepages_after =3D 0;
> > +     int ret;
> > +
> > +     ksft_print_msg("Test soft-offline when enabled_soft_offline=3D%d\=
n",
> > +                    enable_soft_offline);
> > +
> > +     fd =3D create_hugetlbfs_file(&file_stat);
> > +     if (fd < 0)
> > +             ksft_exit_fail_msg("Failed to create hugetlbfs file\n");
> > +
> > +     hugepagesize_kb =3D file_stat.f_bsize / 1024;
> > +     ksft_print_msg("Hugepagesize is %ldkB\n", hugepagesize_kb);
> > +
> > +     if (set_enable_soft_offline(enable_soft_offline)) {
>
> Nit: should this be written as if (set_enable_soft_offline(enable_soft_of=
fline) !=3D 0) to keep consistent with below code?

for sure

>
> > +             close(fd);
> > +             ksft_exit_fail_msg("Failed to set enable_soft_offline\n")=
;
> > +     }
> > +
> > +     if (read_nr_hugepages(hugepagesize_kb, &nr_hugepages_before) !=3D=
 0) {
> > +             close(fd);
> > +             ksft_exit_fail_msg("Failed to read nr_hugepages\n");
> > +     }
> > +
> > +     ksft_print_msg("Before MADV_SOFT_OFFLINE nr_hugepages=3D%ld\n",
> > +                    nr_hugepages_before);
> > +
> > +     ret =3D do_soft_offline(fd, 2 * file_stat.f_bsize, expect_errno);
> > +
> > +     if (read_nr_hugepages(hugepagesize_kb, &nr_hugepages_after) !=3D =
0) {
> > +             close(fd);
> > +             ksft_exit_fail_msg("Failed to read nr_hugepages\n");
> > +     }
> > +
> ...
> > diff --git a/tools/testing/selftests/mm/run_vmtests.sh b/tools/testing/=
selftests/mm/run_vmtests.sh
> > index 3157204b9047..781117fac1ba 100755
> > --- a/tools/testing/selftests/mm/run_vmtests.sh
> > +++ b/tools/testing/selftests/mm/run_vmtests.sh
> > @@ -331,6 +331,10 @@ CATEGORY=3D"hugetlb" run_test ./thuge-gen
> >  CATEGORY=3D"hugetlb" run_test ./charge_reserved_hugetlb.sh -cgroup-v2
> >  CATEGORY=3D"hugetlb" run_test ./hugetlb_reparenting_test.sh -cgroup-v2
> >  if $RUN_DESTRUCTIVE; then
> > +nr_hugepages_tmp=3D$(cat /proc/sys/vm/nr_hugepages)
> > +echo 8 > /proc/sys/vm/nr_hugepages
> > +CATEGORY=3D"hugetlb" run_test ./hugetlb-soft-offline
> > +echo "$nr_hugepages_tmp" > /proc/sys/vm/nr_hugepages
>
> Should we save and restore the value of /proc/sys/vm/enable_soft_offline =
too?

absolutely, thanks for catching.

>
> With above fixed, this patch looks good to me.
> Acked-by: Miaohe Lin <linmiaohe@huawei.com>

Thanks Miaohe, I will send out v7 with fixes.

> Thanks.
> .
>

