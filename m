Return-Path: <linux-kselftest+bounces-12767-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F903917706
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jun 2024 05:58:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9E0C283B13
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jun 2024 03:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A51D8248D;
	Wed, 26 Jun 2024 03:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G5vSLlMS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C45347C7
	for <linux-kselftest@vger.kernel.org>; Wed, 26 Jun 2024 03:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719374279; cv=none; b=LxlrRZwfhd/0VNe28Is8DER1meR05wjFNd2oyfH0mezgtfWdhF5Y40qr7C3E9GRDtBq/zHlV1Ly/EeFk35Y7p89NMSp+kPaTwDtCCihkL8bs766FNpkzXylC8VbbP07Gf2Qxa0EKHl4IysxoGv7VxcNswxD22Q9k+9y0Pxp6dLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719374279; c=relaxed/simple;
	bh=/jOkK/GB36l5OeNHSL9FJ3Y553WdQcl90bcmcyPU/dA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PPTq6LgfYiPLFnubJiyLXKBZg4Fu4nkiykhahojLHbbpud8kfhbkXkVruTMomjtfLxioZAx5ZJ+vkOVfsWjlSasmdVLwt3AU0UCnpb6aYrraXAwme2t3AMGLUVY3ncnrb/kbVAGhEN2J0+roP/2s1UZuy19vBbQVyBkzBxNpyzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G5vSLlMS; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-424ad289912so3296695e9.2
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Jun 2024 20:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719374275; x=1719979075; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=msH6Ni8XjmIv87Xn+7LRokn7k7HhrU+c2RpRB9CU8Zo=;
        b=G5vSLlMStCSZF/fAdoSdwpjy0DTWV2nsa2LJrtDDQKGV5doVD0JcUN5B9wiDYLCxdz
         yJm5gZIVv0poUOJwElizaQy+ESqBhGSzBZwpShaeHG7Sv3fxG4Tq71O3Tc4zVNrtC6hI
         dd6apx6CSoOUCiw1Zr8Qvmzr49/8/yWVzr8IgaxrL/g7rC3/WUtYs7jfHhxKfK8/5WYB
         icqCtdFmVTsv6cVCJAjQDYbnMaGa5L3C6lNYC2tHJohHZpc303yUfxINLkLYdmGPAd83
         L0jtxIGSjCMEwSN6rVcCjYnfDFt3XrUvHtJ/TjcraBP1od0yKFWL9UVS0vm9Blfj7kiL
         +EJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719374275; x=1719979075;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=msH6Ni8XjmIv87Xn+7LRokn7k7HhrU+c2RpRB9CU8Zo=;
        b=UR8rN2cmO3MKT7O/KbxkWA7c11GSRuP2TgvRopGD+2FJa6RMxAY1AYYP1dilOIYRq4
         I89yIGtOzGUPSaFJMHDd96FR59pf+4mhDNSvfkYEVUxfRYbL+aVIPZaMV7yW6fMeLZ/9
         DT+ZSNJp9H1MrS3HXDn8XK4vb00280VecL405M8cnY/z5Br9rXSFw852ZX2qa53OsCpE
         Aj0zGVaVBbqYEfjA0T8QsgJ4s3XmoI6uNC5K0XFE/0woCRpquGD/V7YfZ/U/NtJibuwy
         0FJYhukcmHSpIJTcTYikCEOe5fdBGJu30eJ0wbVVPQdtg6QJdAv6a+4qZmiyo+Gh9BM1
         pKEA==
X-Forwarded-Encrypted: i=1; AJvYcCVFKt/5PYSM6bWoXaTfGOYyLl+ciFzCEALXCHM0nBz5OpOpL+zTBVniXfEG/4JnJuWZ3trMYIseCUuL7z1u9v+giBuDUHELtNO42CGGUPvN
X-Gm-Message-State: AOJu0YzGIKqOc+0dYFdrGlrbEwGVw8LPSVB7Z5STZpdrPVNVOXNKxib8
	RW42DQ8Au2Cx2NEqdFy2IYlc4C1VmtsrLRuMxwY2/ZVqnwRMOesEbwmwIe2iriq/JKIcSmmhvsj
	lc/QTguK9wZdvI9CK81qBZKLNA8S/mdhvDouQ
X-Google-Smtp-Source: AGHT+IGuXXtl+E+WLOr/DRy3HX5YGqfni5q3C91JuUMbkVHAWgZ+NvdKFU4lQlqlvsl5Uu1kziQ3Kjz5SQYtHYDMhto=
X-Received: by 2002:adf:f887:0:b0:361:dde2:87a0 with SMTP id
 ffacd0b85a97d-366e4f0cd03mr6529981f8f.65.1719374275190; Tue, 25 Jun 2024
 20:57:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240624163348.1751454-1-jiaqiyan@google.com> <20240624163348.1751454-4-jiaqiyan@google.com>
 <609062d2-977c-4229-8c66-d15bb8e47eb8@huawei.com> <CACw3F51yApRGaKcKmeEo-SYbt-nxULCwe2imCnsaPP8m4UBW6g@mail.gmail.com>
 <6afa8830-1a58-5e57-7d73-9601768bcda0@huawei.com>
In-Reply-To: <6afa8830-1a58-5e57-7d73-9601768bcda0@huawei.com>
From: Jiaqi Yan <jiaqiyan@google.com>
Date: Tue, 25 Jun 2024 20:57:43 -0700
Message-ID: <CACw3F52V6GEYOOC2HLxBuA_6uzaExvex_zYd1rW27DW1iFv9Uw@mail.gmail.com>
Subject: Re: [PATCH v5 3/4] selftest/mm: test enable_soft_offline behaviors
To: Miaohe Lin <linmiaohe@huawei.com>
Cc: muchun.song@linux.dev, akpm@linux-foundation.org, shuah@kernel.org, 
	corbet@lwn.net, osalvador@suse.de, rientjes@google.com, duenwen@google.com, 
	fvdl@google.com, linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
	linux-doc@vger.kernel.org, nao.horiguchi@gmail.com, jane.chu@oracle.com, 
	ioworker0@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 25, 2024 at 6:54=E2=80=AFPM Miaohe Lin <linmiaohe@huawei.com> w=
rote:
>
> On 2024/6/26 7:57, Jiaqi Yan wrote:
> > On Tue, Jun 25, 2024 at 12:05=E2=80=AFAM Miaohe Lin <linmiaohe@huawei.c=
om> wrote:
> >>
> >> On 2024/6/25 0:33, Jiaqi Yan wrote:
> >>> Add regression and new tests when hugepage has correctable memory
> >> ...
> >>> diff --git a/tools/testing/selftests/mm/hugetlb-soft-offline.c b/tool=
s/testing/selftests/mm/hugetlb-soft-offline.c
> >>> new file mode 100644
> >>> index 000000000000..16fe52f972e2
> >>> --- /dev/null
> >>> +++ b/tools/testing/selftests/mm/hugetlb-soft-offline.c
> >>> @@ -0,0 +1,227 @@
> >>> +// SPDX-License-Identifier: GPL-2.0
> >>> +/*
> >>> + * Test soft offline behavior for HugeTLB pages:
> >>> + * - if enable_soft_offline =3D 0, hugepages should stay intact and =
soft
> >>> + *   offlining failed with EINVAL.
> >>
> >> s/failed with EINVAL/failed with EOPNOTSUPP/g
> >
> > To be fixed in v6.
> >
> >>
> >>> + * - if enable_soft_offline =3D 1, a hugepage should be dissolved an=
d
> >>> + *   nr_hugepages/free_hugepages should be reduced by 1.
> >>> + *
> >>> + * Before running, make sure more than 2 hugepages of default_hugepa=
gesz
> >>> + * are allocated. For example, if /proc/meminfo/Hugepagesize is 2048=
kB:
> >>> + *   echo 8 > /sys/kernel/mm/hugepages/hugepages-2048kB/nr_hugepages
> >>> + */
> >>> +
> >> ...
> >>> +static void test_soft_offline_common(int enable_soft_offline)
> >>> +{
> >>> +     int fd;
> >>> +     int expect_errno =3D enable_soft_offline ? 0 : EOPNOTSUPP;
> >>> +     struct statfs file_stat;
> >>> +     unsigned long hugepagesize_kb =3D 0;
> >>> +     unsigned long nr_hugepages_before =3D 0;
> >>> +     unsigned long nr_hugepages_after =3D 0;
> >>> +     int ret;
> >>> +
> >>> +     ksft_print_msg("Test soft-offline when enabled_soft_offline=3D%=
d\n",
> >>> +                    enable_soft_offline);
> >>> +
> >>> +     fd =3D create_hugetlbfs_file(&file_stat);
> >>> +     if (fd < 0) {
> >>> +             ksft_exit_fail_msg("Failed to create hugetlbfs file\n")=
;
> >>> +             return;
> >>> +     }
> >>> +
> >>> +     hugepagesize_kb =3D file_stat.f_bsize / 1024;
> >>> +     ksft_print_msg("Hugepagesize is %ldkB\n", hugepagesize_kb);
> >>> +
> >>> +     if (set_enable_soft_offline(enable_soft_offline)) {
> >>> +             ksft_exit_fail_msg("Failed to set enable_soft_offline\n=
");
> >>
> >> Call destroy_hugetlbfs_file() in error path?
> >
> > As the counterpart of destroy_hugetlbfs_file, I think the test only
> > needs to close(fd). Will add it in v6.
> >
> >>
> >>> +             return;
> >>> +     }
> >>> +
> >>> +     if (read_nr_hugepages(hugepagesize_kb, &nr_hugepages_before) !=
=3D 0) {
> >>> +             ksft_exit_fail_msg("Failed to read nr_hugepages\n");
> >>> +             return;
> >>> +     }
> >>> +
> >>> +     ksft_print_msg("Before MADV_SOFT_OFFLINE nr_hugepages=3D%ld\n",
> >>> +                    nr_hugepages_before);
> >>> +
> >>> +     ret =3D do_soft_offline(fd, 2 * file_stat.f_bsize, expect_errno=
);
> >>> +
> >>> +     if (read_nr_hugepages(hugepagesize_kb, &nr_hugepages_after) !=
=3D 0) {
> >>> +             ksft_exit_fail_msg("Failed to read nr_hugepages\n");
> >>> +             return;
> >>> +     }
> >>> +
> >>> +     ksft_print_msg("After MADV_SOFT_OFFLINE nr_hugepages=3D%ld\n",
> >>> +             nr_hugepages_after);
> >>> +
> >>> +     if (enable_soft_offline) {
> >>> +             if (nr_hugepages_before !=3D nr_hugepages_after + 1) {
> >>> +                     ksft_test_result_fail("MADV_SOFT_OFFLINE should=
 reduced 1 hugepage\n");
> >>> +                     return;
> >>> +             }
> >>> +     } else {
> >>> +             if (nr_hugepages_before !=3D nr_hugepages_after) {
> >>> +                     ksft_test_result_fail("MADV_SOFT_OFFLINE reduce=
d %lu hugepages\n",
> >>> +                             nr_hugepages_before - nr_hugepages_afte=
r);
> >>> +                     return;
> >>> +             }
> >>> +     }
> >>> +
> >>> +     ksft_test_result(ret =3D=3D 0,
> >>> +                      "Test soft-offline when enabled_soft_offline=
=3D%d\n",
> >>> +                      enable_soft_offline);
> >>
> >> Call destroy_hugetlbfs_file() when test finished ?
> >
> > Test can just close(fd) once nr_hugepages_after is read.
>
> I'm sorry but I can't find the code to call close(fd) after nr_hugepages_=
after is read.

Sorry, I meant in v6 I will add close(fd) after nr_hugepages_after.

> IMO create_hugetlbfs_file() would fail to create a new hugetlb file later=
 if close(fd)
> is not called when testing previous enable_soft_offline =3D 1 testcase. B=
ecause a hugetlb
> file with same name is already there. But I might miss something.

Yes, this is an absolutely valid concern, and should be address in v6
by adding close(fd) after nr_hugepages_after.

>
> Thanks.
> .
>

