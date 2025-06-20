Return-Path: <linux-kselftest+bounces-35405-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB4D6AE13A5
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Jun 2025 08:13:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A47617B80A
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Jun 2025 06:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75BEE220699;
	Fri, 20 Jun 2025 06:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fzeYY3zW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2024220686
	for <linux-kselftest@vger.kernel.org>; Fri, 20 Jun 2025 06:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750400016; cv=none; b=akVTcI3LMbAIqzljKP7C5gd6vSJ/p6/ku8uoep3SZ7FPGXeftxqXIo3Rry0TeM1l47kP69cNnSE553SGMl1uPg6t0M6LvzDlwxERQ7BESYA/OPbxEm1XwMobBukbeh3h+agyvEGtXEclOrGZ/6pj1ett3qTUX1q8tw5rgnsYxe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750400016; c=relaxed/simple;
	bh=/ifl4BkSAS+X5kqLgyKG7HDnegLgq4lIIlYvhAYoKY4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dc7NjElW8rrF4dzwjg5ocGutQes7+UNK7FOFoDfkZi0Ztun9o2AUHewjSdiCgTxlOASmv3KxkFFPDi1eLdMTh8wq8sKu+58eyOjowLX0pvsU41nE8yXZ8x62Jjkqz5Hm9bOpr1rSdoSzgHJlFIfgqjLZ90psb8Frmlxnjk7oXkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fzeYY3zW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750400013;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GWlhXdAovke7Vs8lHzjuiPwP8l8W3x2600LjzDGhdIU=;
	b=fzeYY3zWcG/1ldwczyA/reT4wihAXOVBezASjWaFAE+8dnbOYJ4mdXs7hPT8woPyt3CFo1
	CQPmcQp9fwoxC1z50wpvOSiN8f65c0jh9AkrMMKR2BBcbpHpzhszHTV5wD9jpEEYZSKaed
	+W2F71cKF3aP0rTiZAfV20GBWSAQeuE=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-168-XYzCOXgkNpeZNG8bwFG_CQ-1; Fri, 20 Jun 2025 02:13:31 -0400
X-MC-Unique: XYzCOXgkNpeZNG8bwFG_CQ-1
X-Mimecast-MFC-AGG-ID: XYzCOXgkNpeZNG8bwFG_CQ_1750400010
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-32b3a3c5cd0so5641291fa.3
        for <linux-kselftest@vger.kernel.org>; Thu, 19 Jun 2025 23:13:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750400010; x=1751004810;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GWlhXdAovke7Vs8lHzjuiPwP8l8W3x2600LjzDGhdIU=;
        b=oNmdYXvlJuFHgr42Ond09y6TfuUtKU94Z7CPGtZf+Pa5mAJamvfV5Xy6nU7fgTMjz4
         K8ByqW/dHUvsubwPBsIZh6/CucPhkA1y3BOMIe3CybyNduO1nW6EWrK6m5bpI0B4Pbwa
         pnyPrRNY3kqcR646Equx83KEPM8aN1CSROGTYb+btDnmn2+cAPBSMbBFXUrv66HyJliL
         foVXmhGjAKLZOIZaLoK0xl7YNVFYnLFmNNNgWHvGUFl9UwV4m47pgPg7UoqxOLb8B5EC
         0U9147vckSORV7pVxCXKbffM+2BD0lwikIiN6WfBFhYoAYCpEP4DF/KJzm+BqLKgD8Mv
         FqfQ==
X-Forwarded-Encrypted: i=1; AJvYcCX8t37uGGr0M1LNOVZqkmweX28oYG0lTEq63kZkzF7KOlbFsuRQq4x4S25vxygeqdgd/WsXh78AJTC551QGa1A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJAhFcK0SrIrJ8GSASHbrYr33yJsgtnMO1EelZgbh2SmoR/DXF
	o0NVk3re2+pKX6MHaeNI8YKUpf0wmo3HulrpbuCdVMnfCqWSXOIlVM8IW3yTvpBceM514RSuCfX
	qDGyOKA6421ApQYOjZaV0liFcEuBOzRvILhy5Pl5/IJYoyzr478iWJ8Qop4oD0Vh6YbQXVugS1+
	y4+FqpGwrs8+h6ww3YJXLbNK1xbXvzLqzDxmn/bnS5Cvqh
X-Gm-Gg: ASbGncu7ux0ICos/ytr76jGwALqhWVvIDtxXlxnaVVKojXZQU4h79RjPjaqUa7DG9Ro
	UtlNqIbuQIjntm7OUBa+CZqAfZ2Q/iduuk3Br8NMBS5EPUAM+ctOPZVhDU/LegdTTaqlauCX3ts
	paopU=
X-Received: by 2002:a05:6512:239e:b0:553:2ed1:ab1e with SMTP id 2adb3069b0e04-553e3c0683bmr505123e87.46.1750400010006;
        Thu, 19 Jun 2025 23:13:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGH4g5z39YT/GJpNxPkdKTXDg17aIrhd/D007WVzIXQTfClNJBfmh3YvsYiNTwz+uEo5UDB2z9coqbY70UMhnw=
X-Received: by 2002:a05:6512:239e:b0:553:2ed1:ab1e with SMTP id
 2adb3069b0e04-553e3c0683bmr505111e87.46.1750400009578; Thu, 19 Jun 2025
 23:13:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <c16d1d452aa876b449324d12df6465677158a711.1749697399.git.baolin.wang@linux.alibaba.com>
In-Reply-To: <c16d1d452aa876b449324d12df6465677158a711.1749697399.git.baolin.wang@linux.alibaba.com>
From: Mario Casquero <mcasquer@redhat.com>
Date: Fri, 20 Jun 2025 08:13:17 +0200
X-Gm-Features: AX0GCFvqt2A2D33JItMcp-_xGgCqB-8XDFV7THnllqE6YY7C7ZYKwaZco7UWRac
Message-ID: <CAMXpfWtM3kMLdkfKpf3CHF1XVk8M18MaZNXHUvwkX7REgQ3ANQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] selftests: khugepaged: fix the shmem collapse failure
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: akpm@linux-foundation.org, david@redhat.com, lorenzo.stoakes@oracle.com, 
	Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com, 
	dev.jain@arm.com, baohua@kernel.org, shuah@kernel.org, ziy@nvidia.com, 
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This patch has been successfully tested. All the khugepaged shmem tests pas=
sed.

# ./khugepaged khugepaged:shmem
Save THP and khugepaged settings... OK
Allocate huge page on fault... OK
Split huge PMD on MADV_DONTNEED... OK

Run test: collapse_full (khugepaged:shmem)
Collapse multiple fully populated PTE table.... OK

Run test: collapse_single_pte_entry (khugepaged:shmem)
Collapse PTE table with single PTE entry present.... OK

Run test: collapse_full_of_compound (khugepaged:shmem)
Allocate huge page... OK
Split huge page leaving single PTE page table full of compound pages... OK
Collapse PTE table full of compound pages.... OK
Restore THP and khugepaged settings... OK

Tested-by: Mario Casquero <mcasquer@redhat.com>

On Thu, Jun 12, 2025 at 5:55=E2=80=AFAM Baolin Wang
<baolin.wang@linux.alibaba.com> wrote:
>
> When running the khugepaged selftest for shmem (./khugepaged all:shmem),
> I encountered the following test failures:
> "
> Run test: collapse_full (khugepaged:shmem)
> Collapse multiple fully populated PTE table.... Fail
> ...
> Run test: collapse_single_pte_entry (khugepaged:shmem)
> Collapse PTE table with single PTE entry present.... Fail
> ...
> Run test: collapse_full_of_compound (khugepaged:shmem)
> Allocate huge page... OK
> Split huge page leaving single PTE page table full of compound pages... O=
K
> Collapse PTE table full of compound pages.... Fail
> "
>
> The reason for the failure is that, it will set MADV_NOHUGEPAGE to preven=
t
> khugepaged from continuing to scan shmem VMA after khugepaged finishes
> scanning in the wait_for_scan() function. Moreover, shmem requires a refa=
ult
> to establish PMD mappings.
>
> However, after commit 2b0f922323cc, PMD mappings are prevented if the VMA=
 is
> set with MADV_NOHUGEPAGE flag, so shmem cannot establish PMD mappings dur=
ing
> refault.
>
> To fix this issue, we can set the MADV_NOHUGEPAGE flag after the shmem re=
fault.
> With this fix, the shmem test case passes.
>
> Fixes: 2b0f922323cc ("mm: don't install PMD mappings when THPs are disabl=
ed by the hw/process/vma")
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> ---
>  tools/testing/selftests/mm/khugepaged.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/tools/testing/selftests/mm/khugepaged.c b/tools/testing/self=
tests/mm/khugepaged.c
> index 8a4d34cce36b..d462f62d8116 100644
> --- a/tools/testing/selftests/mm/khugepaged.c
> +++ b/tools/testing/selftests/mm/khugepaged.c
> @@ -561,8 +561,6 @@ static bool wait_for_scan(const char *msg, char *p, i=
nt nr_hpages,
>                 usleep(TICK);
>         }
>
> -       madvise(p, nr_hpages * hpage_pmd_size, MADV_NOHUGEPAGE);
> -
>         return timeout =3D=3D -1;
>  }
>
> @@ -585,6 +583,7 @@ static void khugepaged_collapse(const char *msg, char=
 *p, int nr_hpages,
>         if (ops !=3D &__anon_ops)
>                 ops->fault(p, 0, nr_hpages * hpage_pmd_size);
>
> +       madvise(p, nr_hpages * hpage_pmd_size, MADV_NOHUGEPAGE);
>         if (ops->check_huge(p, expect ? nr_hpages : 0))
>                 success("OK");
>         else
> --
> 2.43.5
>
>


