Return-Path: <linux-kselftest+bounces-12756-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AF76917518
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jun 2024 01:57:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC7FA1F221AB
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jun 2024 23:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E483F17F50F;
	Tue, 25 Jun 2024 23:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qjGh7tZm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2077B1494DE
	for <linux-kselftest@vger.kernel.org>; Tue, 25 Jun 2024 23:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719359856; cv=none; b=rjibGU/wqVJslGCFm1UBzc9aiIXiKBRuUDSqN5FqU7wEahWzOpV6yKsf3sTYozbSa7OpWetmUO4uUQRiZSyHw0A66esL5H6YanIiP3VKwxR3fkYDKOpPqkyoL677BFa9n7z2E27GyMMdE9rAP1mgoqfQA9/VyPRP/QJ640Ow23c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719359856; c=relaxed/simple;
	bh=Bf9Y7oEFFhtvmeORml+RSGqddvm0/CJjvC4+D1bcBfQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L6XVFH8oVVR/tDuoVumib3rWJM6+WI4cfeL73wyMh48Aq2IrVGSEBS4SozuKJMlbkzsTO2Ycmnc7x2aILJdtrcHfUJyW4MnDdRZ18e3Nj0GkRcYLTEPshBi4kIlzU5ztVQV2jS/7oq91Oe8YP1rMMFkMQ35xPQTeQXdulbpv+qU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qjGh7tZm; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-424ad991cbbso2377255e9.0
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Jun 2024 16:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719359852; x=1719964652; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W2JcOUDnCt+svS7zGz52ySaRQIEG8KgIWnA1lxR6tik=;
        b=qjGh7tZmCaukZ6THX5r1/rm/pcvPo86iU/28KFiajMbmQxDPCYoqey9+IOehCYaQVU
         QwLSIUYeourMi9DX1RuVNZcnuUd8/D5uro5PEVSJxB8SCNl8Hb0WCHwusWm7wo8+nFio
         GSJKiBR+272RmaeSzQPHM8D1Q8oj21KE2mWOMUj1xdgxaobgGjHFt8ozBZam89q06vdQ
         1lumIM07dE21HD9HZgRFtYbl8KFsmM14v84JEiMIJJx9R+sIls5MDIiR5m/zVFTEzDIG
         fVSqiL46/y82cViewyCW7pTCfaf6J5JohYfkkD8CNWIIG4sLFRs7FPMZVzDw1zS+cVO5
         fJNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719359852; x=1719964652;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W2JcOUDnCt+svS7zGz52ySaRQIEG8KgIWnA1lxR6tik=;
        b=L+1j2xcBeXpRnm+ycVHm6ZYI46unlVfxcBFkaXycjurYuDmk2MXmbkzFTBjcgmNvvq
         iA7RG307F5gq3u/i4M//zqpaSwAHjxHMlb+gvQTonqSVrGM4HwUQqSevsaTwnIMyCXFO
         1zUaQ07wkzfidxdJPRB7NjJuzlpwLgEZg7mtpXRViChWcVx1nTdnhATKbbVd+JlVQJcp
         IA59gTtVj5qA3BkJAmDsawwwz9kmU/sTK4KSKMHh9VuxuS2mWkWL4pjCNcv7oQWQxiN+
         y0xteIr9ayUhYiBes8onCYw32g/C2qj61ItWGqge7r7HYRQAgMVlcT2vwXvCBXwDV19H
         tbiA==
X-Forwarded-Encrypted: i=1; AJvYcCWAf7fQ/v3MGIwIn2CjtCbgUsCDtn2+vGzke0uzLPccLEpAjxXPg+mLE/Q0OftMwtJNTFjI6ZsQ3twvjTJfzwSFaiV+B2gTNHN+UwZWuA1R
X-Gm-Message-State: AOJu0YzeNlZAqRFBBDcbLgHwtYg1eX6E35tZ6mTUPi2gLZLnpn1ogqAC
	mLzQukX+LGsC5fsAev1gm5WAUPhG21A7McfyPlkebFRdxHlHdmUVlF2WuW/3jEfaDKq2W+qbkPP
	3IAw9cBwrzSGxSPi5N+OcMYfj9A36ndrT69a8
X-Google-Smtp-Source: AGHT+IFFJb7WJm7kVvr/YsNNI6PVICNxN4RmhAT6PXUxbvWObAnOWcBp6wVtH/m42umgYY2SNNQ1OS8CJRAvJEgtHSU=
X-Received: by 2002:a05:600c:4a99:b0:421:29e1:998 with SMTP id
 5b1f17b1804b1-4248cc67376mr54381265e9.39.1719359852154; Tue, 25 Jun 2024
 16:57:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240624163348.1751454-1-jiaqiyan@google.com> <20240624163348.1751454-4-jiaqiyan@google.com>
 <609062d2-977c-4229-8c66-d15bb8e47eb8@huawei.com>
In-Reply-To: <609062d2-977c-4229-8c66-d15bb8e47eb8@huawei.com>
From: Jiaqi Yan <jiaqiyan@google.com>
Date: Tue, 25 Jun 2024 16:57:19 -0700
Message-ID: <CACw3F51yApRGaKcKmeEo-SYbt-nxULCwe2imCnsaPP8m4UBW6g@mail.gmail.com>
Subject: Re: [PATCH v5 3/4] selftest/mm: test enable_soft_offline behaviors
To: Miaohe Lin <linmiaohe@huawei.com>
Cc: muchun.song@linux.dev, akpm@linux-foundation.org, shuah@kernel.org, 
	corbet@lwn.net, osalvador@suse.de, rientjes@google.com, duenwen@google.com, 
	fvdl@google.com, linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
	linux-doc@vger.kernel.org, nao.horiguchi@gmail.com, jane.chu@oracle.com, 
	ioworker0@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 25, 2024 at 12:05=E2=80=AFAM Miaohe Lin <linmiaohe@huawei.com> =
wrote:
>
> On 2024/6/25 0:33, Jiaqi Yan wrote:
> > Add regression and new tests when hugepage has correctable memory
> ...
> > diff --git a/tools/testing/selftests/mm/hugetlb-soft-offline.c b/tools/=
testing/selftests/mm/hugetlb-soft-offline.c
> > new file mode 100644
> > index 000000000000..16fe52f972e2
> > --- /dev/null
> > +++ b/tools/testing/selftests/mm/hugetlb-soft-offline.c
> > @@ -0,0 +1,227 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Test soft offline behavior for HugeTLB pages:
> > + * - if enable_soft_offline =3D 0, hugepages should stay intact and so=
ft
> > + *   offlining failed with EINVAL.
>
> s/failed with EINVAL/failed with EOPNOTSUPP/g

To be fixed in v6.

>
> > + * - if enable_soft_offline =3D 1, a hugepage should be dissolved and
> > + *   nr_hugepages/free_hugepages should be reduced by 1.
> > + *
> > + * Before running, make sure more than 2 hugepages of default_hugepage=
sz
> > + * are allocated. For example, if /proc/meminfo/Hugepagesize is 2048kB=
:
> > + *   echo 8 > /sys/kernel/mm/hugepages/hugepages-2048kB/nr_hugepages
> > + */
> > +
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
> > +     if (fd < 0) {
> > +             ksft_exit_fail_msg("Failed to create hugetlbfs file\n");
> > +             return;
> > +     }
> > +
> > +     hugepagesize_kb =3D file_stat.f_bsize / 1024;
> > +     ksft_print_msg("Hugepagesize is %ldkB\n", hugepagesize_kb);
> > +
> > +     if (set_enable_soft_offline(enable_soft_offline)) {
> > +             ksft_exit_fail_msg("Failed to set enable_soft_offline\n")=
;
>
> Call destroy_hugetlbfs_file() in error path?

As the counterpart of destroy_hugetlbfs_file, I think the test only
needs to close(fd). Will add it in v6.

>
> > +             return;
> > +     }
> > +
> > +     if (read_nr_hugepages(hugepagesize_kb, &nr_hugepages_before) !=3D=
 0) {
> > +             ksft_exit_fail_msg("Failed to read nr_hugepages\n");
> > +             return;
> > +     }
> > +
> > +     ksft_print_msg("Before MADV_SOFT_OFFLINE nr_hugepages=3D%ld\n",
> > +                    nr_hugepages_before);
> > +
> > +     ret =3D do_soft_offline(fd, 2 * file_stat.f_bsize, expect_errno);
> > +
> > +     if (read_nr_hugepages(hugepagesize_kb, &nr_hugepages_after) !=3D =
0) {
> > +             ksft_exit_fail_msg("Failed to read nr_hugepages\n");
> > +             return;
> > +     }
> > +
> > +     ksft_print_msg("After MADV_SOFT_OFFLINE nr_hugepages=3D%ld\n",
> > +             nr_hugepages_after);
> > +
> > +     if (enable_soft_offline) {
> > +             if (nr_hugepages_before !=3D nr_hugepages_after + 1) {
> > +                     ksft_test_result_fail("MADV_SOFT_OFFLINE should r=
educed 1 hugepage\n");
> > +                     return;
> > +             }
> > +     } else {
> > +             if (nr_hugepages_before !=3D nr_hugepages_after) {
> > +                     ksft_test_result_fail("MADV_SOFT_OFFLINE reduced =
%lu hugepages\n",
> > +                             nr_hugepages_before - nr_hugepages_after)=
;
> > +                     return;
> > +             }
> > +     }
> > +
> > +     ksft_test_result(ret =3D=3D 0,
> > +                      "Test soft-offline when enabled_soft_offline=3D%=
d\n",
> > +                      enable_soft_offline);
>
> Call destroy_hugetlbfs_file() when test finished ?

Test can just close(fd) once nr_hugepages_after is read.

>
> Thanks.
> .
>
>
>

