Return-Path: <linux-kselftest+bounces-12451-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 968DF912839
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jun 2024 16:43:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50372289143
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jun 2024 14:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB42F20DC8;
	Fri, 21 Jun 2024 14:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YSnL/+bD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5425A2868D
	for <linux-kselftest@vger.kernel.org>; Fri, 21 Jun 2024 14:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718981017; cv=none; b=jrUEFvHG1zvYgh/Fmc8NQ8h3DKPZDBc3ncngkoLFf+CGHqJ2qZk2pB7kD7k703aFRVzRSzFIauKXP/JzWDg/AkJnlQKiv0llmI7tWYlmtMtHHNDeDsYAAeYUgyRBfIf/R+A8+RBJ9yOZlNiQPditiBNxbAwFO6lACVXeXghpkfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718981017; c=relaxed/simple;
	bh=fwxVt1xCUdJ4J3/7hu1rhG4muqfZxWwWAwEu5AGYL04=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZOC+f4nektbnMa0W3z695zoeyhFYGkkpRqquP6CbwioKsqvxGu5Q30R4ZvS16/Too4TJcF96WXZnOON+z7YAB3sa/1/i6amS8nAndIZepjJO+r5cMFhvPH95EOKxSObXuqyFlub4YSdImsAGc1Vaps82pcrv0Q9JM2KqYazrBNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YSnL/+bD; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-52cdb0d8107so617333e87.1
        for <linux-kselftest@vger.kernel.org>; Fri, 21 Jun 2024 07:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718981013; x=1719585813; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R5g6cVCLX6JMDoyy8Jad2HKl/F+iJNHQJt1nOcWgC3Y=;
        b=YSnL/+bDHF0zkNIcN40JPbwf1G9RfzKpUaaPQjcQxteRCR7cZxTug3CLbv33NW5IG6
         xzfu4+exYgyKu2w5smiaHIV4Tko0jZpaWhSBzaXRi248sD2CR8nrQBCKy+lh0dilC0nF
         /7THtkpgkABJlSxvi8uhO0MvQQcC9AHT1u6nzFsOHI6HLrr/5Cx4k6p0WDCI/MSvfZNd
         eKCVkgBsZV812I/YwNWtZAyz+ee81iwruER9KbRWDGoHZM05Io4B/LRkRjxQxV9X8W8V
         cWA5mJlTOzyPu4aujSTIkRQr9NdE/UuF0Um4tHTE64wbdNAj5SZlNJtAdZe3ItXA31/c
         l+uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718981013; x=1719585813;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R5g6cVCLX6JMDoyy8Jad2HKl/F+iJNHQJt1nOcWgC3Y=;
        b=UoTVjpZF6Xn3A9pk4Zr4+I1EvJmfJWvu1LztP/74KTBhFfhPAXjpIJiDZbFgzrIUtN
         mSq9vy35/7MIdmAOKm0NALCw40jOHeg+YRU8/we4gNLd9J2eH4d2TZOnBGHr5N8Z2juR
         SQ7pj+t5BWfglmf7WpfX3KitB8oT2Y6RP46YdjmRgvSwz9F/BdXlqOzpH7bN8XgPPN04
         9dAzs2s9WToXxdNvbya6XkdcmZhG4irTTGnb2UoRm8B3XLTUv7YiV8w+YZRsCxJbZ6Ru
         d4V61ZAjh3c0OIZ/efZV+BO9XorXKdCy+uFTcWA+lSJTxS0oi5rb5d2L37NJPZhcZizd
         dhxg==
X-Forwarded-Encrypted: i=1; AJvYcCXdH3hRDfSlHR67ZK6uzNA1KH5XLSICNkWtCltxfN8xIJrjg4V1haLCrs+l8ODHeyh6uOnRD2leAGWZlMKHE+wJWL9DZ/LTxZGWwH6qhxQj
X-Gm-Message-State: AOJu0YzjG7ZdTJik/5FSnO2l5aBZKViPTvvOBdCv6OkAvKuB7vk27XGp
	/sPF7AbF63Nayg2wS9eysBSRiHc+YP/vtoIFX4/m/737zcMmf7fa0UtXwGHtXymuchIMrOpsezi
	14gEHhV0ICanqXO7SW55qkC1oMRRpS2QHetM6
X-Google-Smtp-Source: AGHT+IGuSyGxky4loefW/M/7lSHf8dCMC14rFygG6Wo59hUV8p+ArOn+9K5FhkHmJFIES0QpoJxsfg1eWpdP+1EpdKI=
X-Received: by 2002:a19:5e4e:0:b0:52c:db50:c026 with SMTP id
 2adb3069b0e04-52cdb50c14bmr575208e87.39.1718981013077; Fri, 21 Jun 2024
 07:43:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240620184856.600717-1-jiaqiyan@google.com> <20240620184856.600717-4-jiaqiyan@google.com>
 <1591a354-d999-45b4-aff2-357fa7612634@collabora.com>
In-Reply-To: <1591a354-d999-45b4-aff2-357fa7612634@collabora.com>
From: Jiaqi Yan <jiaqiyan@google.com>
Date: Fri, 21 Jun 2024 07:43:19 -0700
Message-ID: <CACw3F5229yVkVTjwYCTDF73evvbvEO0=K9wTvFQN+xbNqp0zSQ@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] selftest/mm: test enable_soft_offline behaviors
To: Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: nao.horiguchi@gmail.com, linmiaohe@huawei.com, jane.chu@oracle.com, 
	osalvador@suse.de, muchun.song@linux.dev, akpm@linux-foundation.org, 
	shuah@kernel.org, corbet@lwn.net, rientjes@google.com, duenwen@google.com, 
	fvdl@google.com, linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
	linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 20, 2024 at 10:08=E2=80=AFPM Muhammad Usama Anjum
<usama.anjum@collabora.com> wrote:
>
> On 6/20/24 11:48 PM, Jiaqi Yan wrote:
> > Add regression and new tests when hugepage has correctable memory
> > errors, and how userspace wants to deal with it:
> > * if enable_soft_offline=3D1, mapped hugepage is soft offlined
> > * if enable_soft_offline=3D0, mapped hugepage is intact
> >
> > Free hugepages case is not explicitly covered by the tests.
> >
> > Hugepage having corrected memory errors is emulated with
> > MADV_SOFT_OFFLINE.
> >
> > Signed-off-by: Jiaqi Yan <jiaqiyan@google.com>
> > ---
> >  tools/testing/selftests/mm/.gitignore         |   1 +
> >  tools/testing/selftests/mm/Makefile           |   1 +
> >  .../selftests/mm/hugetlb-soft-offline.c       | 229 ++++++++++++++++++
> >  tools/testing/selftests/mm/run_vmtests.sh     |   4 +
> >  4 files changed, 235 insertions(+)
> >  create mode 100644 tools/testing/selftests/mm/hugetlb-soft-offline.c
> >
> > diff --git a/tools/testing/selftests/mm/.gitignore b/tools/testing/self=
tests/mm/.gitignore
> > index 0b9ab987601c..064e7b125643 100644
> > --- a/tools/testing/selftests/mm/.gitignore
> > +++ b/tools/testing/selftests/mm/.gitignore
> > @@ -6,6 +6,7 @@ hugepage-shm
> >  hugepage-vmemmap
> >  hugetlb-madvise
> >  hugetlb-read-hwpoison
> > +hugetlb-soft-offline
> >  khugepaged
> >  map_hugetlb
> >  map_populate
> > diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selfte=
sts/mm/Makefile
> > index 3b49bc3d0a3b..d166067d75ef 100644
> > --- a/tools/testing/selftests/mm/Makefile
> > +++ b/tools/testing/selftests/mm/Makefile
> > @@ -42,6 +42,7 @@ TEST_GEN_FILES +=3D gup_test
> >  TEST_GEN_FILES +=3D hmm-tests
> >  TEST_GEN_FILES +=3D hugetlb-madvise
> >  TEST_GEN_FILES +=3D hugetlb-read-hwpoison
> > +TEST_GEN_FILES +=3D hugetlb-soft-offline
> >  TEST_GEN_FILES +=3D hugepage-mmap
> >  TEST_GEN_FILES +=3D hugepage-mremap
> >  TEST_GEN_FILES +=3D hugepage-shm
> > diff --git a/tools/testing/selftests/mm/hugetlb-soft-offline.c b/tools/=
testing/selftests/mm/hugetlb-soft-offline.c
> > new file mode 100644
> > index 000000000000..5701eea4ee48
> > --- /dev/null
> > +++ b/tools/testing/selftests/mm/hugetlb-soft-offline.c
> > @@ -0,0 +1,229 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Test soft offline behavior for HugeTLB pages:
> > + * - if enable_soft_offline =3D 0, hugepages should stay intact and so=
ft
> > + *   offlining failed with EINVAL.
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
> > +#define _GNU_SOURCE
> > +#include <errno.h>
> > +#include <stdlib.h>
> > +#include <stdio.h>
> > +#include <string.h>
> > +#include <unistd.h>
> > +
> > +#include <linux/magic.h>
> > +#include <linux/memfd.h>
> > +#include <sys/mman.h>
> > +#include <sys/statfs.h>
> > +#include <sys/types.h>
> > +
> > +#ifndef MADV_SOFT_OFFLINE
> > +#define MADV_SOFT_OFFLINE 101
> > +#endif
> > +
> > +#define PREFIX " ... "
> > +#define EPREFIX " !!! "
> > +
> > +enum test_status {
> > +     TEST_PASS =3D 0,
> > +     TEST_FAILED =3D 1,
> > +     // From ${ksft_skip} in run_vmtests.sh.
> > +     TEST_SKIPPED =3D 4,
> > +};
> Include ../kselftest.h and use macros from there instead of redifining.
> Also try to use helper functions from same header file to mark the test
> pass/fail or exit the test entirely. You can look at soft-dirty.c how tha=
t
> is written.

Thanks Muhammad.

For sure, I will wait a couple of days to see if there is more
feedback on v4, then refactor with kselftest.h in v5.

>
> --
> BR,
> Muhammad Usama Anjum

