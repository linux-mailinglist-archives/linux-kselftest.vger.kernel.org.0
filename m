Return-Path: <linux-kselftest+bounces-39042-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 08A36B276BF
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Aug 2025 05:27:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C513F5E0382
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Aug 2025 03:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8C5129AB0E;
	Fri, 15 Aug 2025 03:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vdx4aj5+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5548A29B793;
	Fri, 15 Aug 2025 03:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755228424; cv=none; b=i29SskyJmUwcWEXDUAlyKKa5Kjqbc2Hi58VuEgh3w5hartX5SedNmGSirV/6Ba3boUBoaGuKpSrCGftKmaFRXASd9rCFglMEL20o6goEb75zNry5B4uCLxSSx5mwGDiGgeSKzb5Ft2YXn0WeayCFatR5RxPldoaFCcSO9z1VfsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755228424; c=relaxed/simple;
	bh=IJwE1h9uU2c1oLtU42D4nkbltWBeOiGbzJ0JulKnEDM=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=VUsUqtgABD08W3+ynAEkDFD8NayQ6CsueNPyuKXnka8amRweX+rciwuR+Kt3HcAvLKJ4492y/s/RUV7sgRj/0a3nhrJtwxarDNQ8ba4fKlaRGmnt0BYkvU3jd95iGdCihXmuOnHxFldP2TUI8q1DF5nHYZL6llHhXdOjx0Z4mEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vdx4aj5+; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-76e2e618a98so1301135b3a.0;
        Thu, 14 Aug 2025 20:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755228422; x=1755833222; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i4clEhlACsA0tDdg/T9dMN1cKs24lEi4PWd19tCjEwc=;
        b=Vdx4aj5+OuWmknByNwyVVS6MCQxgz1nbGDDdWwGPhyNjXfJDpcJUXAttGoggTmzW0m
         j7iLMrs/ESv004PqR9kDNyT+cu7newyaKOtM3vfbc/iML61eePs2a2qK3Eh6nlgWQ8DP
         2wxNt06YFy2CK+7uQfvADiwCKMRR1exNlFm9rna1vuvWCaw0A9b0W0Q1bpozeVLpv8Da
         I3FvOQU4z4s6XDMn+CHeoE732K1vlGmgbCzjs6h6UVE75nMEHEWMxEBWmGonnvOgDPwz
         8CCMGVNdqwWecFRZexhpPhWCsu5sT188JCO01+1e9t5skNTX8Ve1lXc/IRGuShDy+2cq
         t8jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755228422; x=1755833222;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i4clEhlACsA0tDdg/T9dMN1cKs24lEi4PWd19tCjEwc=;
        b=gk5o8rFR3SZsd8BdPocpvYZKnhFSXPgw+FFLInf8koPWWFlrYpg7qHDiunl0HjjRv+
         y37eukGPXI92suLOuJFaqrMW6Tv1tqNNjqAmd/2o1Wd0YuFLXxt3LGR/jZ8+52RjiPRc
         /Gu5t64fb0+2gW6DZNzRtBTkCNlXOPfrhWJJw7EMSkqfoKIjvewjK9+9BJvi2KlQEE+B
         2XCG0SReVtlZ/W+XSMfFvb3+VWs28aA1a1B9H2CRzCFWgHdP1YLoEeaTbc2gWKNjj8vI
         +mDAE80eKWJ/tBe1kx9OwLMWm6XfarJgKJyC6Cm7tXZ0XQJKv7EHU4+uH84EVXxNxSmM
         xVXA==
X-Forwarded-Encrypted: i=1; AJvYcCU+vyXvPMaqjJRK481zVVtSeY3uj8ed+Mjt/V+f05saBGN/EBeG7/vUH/KDczoiYX5LmAXm7HHjD+U0IERGJZEc@vger.kernel.org, AJvYcCUh5whu4yRCvN7AhmvqZTJsmpaL/nE793C2ULp7jT1KnmGCpIupY2vRhuZ0/nHI6+MihH+wILFifD4FbaM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhgVFrp6JlqQRP/KAV4XmntzZkoeVKT4f2fZ/lMFUyEZlR0vmy
	oxs1crwD+p6x3N9JuDQ5DIz2+gZO8I1v+auxfsIZ+TwVpV/4T8kJZndP
X-Gm-Gg: ASbGncvwqfkfAgVjXGgu0JddRMJsmAyR4pEWgveLHMTjRb0+JXbzWY34iOEqDTFK6Im
	AJp3TgoWTrTWTO/uospPbQR4KaFpqw11NK1Qa2pv08CHYSa1bVAFzWyoUFAaAsbkyVq43AkXr8U
	xIeAYFJAN0SuzitH7977VbAhWvQQhLMNyRdnHlEB/cL6NUx+GmaUt4RsIOxnnxIXgFtt6Razbn2
	6zNkhU9lPegw7v22gI512e0Efhw2vvYUcz0WKQ9z2H8aQXurFZiotU81ed+wYQpHBQfhZWqJWjv
	82SFuCEufPR9FcI3WonCfABGR4Qc97S+YVDL4+XlIHSJzrUmyvmNrHoGWzCvTJl7iTylYsq4lHu
	ihQClTHnIi+8=
X-Google-Smtp-Source: AGHT+IEWmNmS0mZB+sG7vmnApcWmG90xfM+LSnDAqr9fergPICvDpFzevhiBxYKw6Ow5a6S6XPe5Qw==
X-Received: by 2002:a05:6a00:1793:b0:76b:e561:9e1b with SMTP id d2e1a72fcca58-76e446c8803mr593207b3a.1.1755228422508;
        Thu, 14 Aug 2025 20:27:02 -0700 (PDT)
Received: from smtpclient.apple ([2402:1f00:8001:567::104])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e4528c28csm153092b3a.29.2025.08.14.20.26.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Aug 2025 20:27:02 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH v4 2/5] selftests/mm: mark all functions static in
 split_huge_page_test.c
From: wang lian <lianux.mm@gmail.com>
In-Reply-To: <20250815023915.1394655-3-ziy@nvidia.com>
Date: Fri, 15 Aug 2025 11:26:43 +0800
Cc: Wei Yang <richard.weiyang@gmail.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 David Hildenbrand <david@redhat.com>,
 linux-mm@kvack.org,
 Andrew Morton <akpm@linux-foundation.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>,
 Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>,
 Vlastimil Babka <vbabka@suse.cz>,
 Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>,
 Shuah Khan <shuah@kernel.org>,
 linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <219CDAAB-2571-4F47-815C-96A41F8D4410@gmail.com>
References: <20250815023915.1394655-1-ziy@nvidia.com>
 <20250815023915.1394655-3-ziy@nvidia.com>
To: Zi Yan <ziy@nvidia.com>
X-Mailer: Apple Mail (2.3826.600.51.1.1)



> On Aug 15, 2025, at 10:39, Zi Yan <ziy@nvidia.com> wrote:
>=20
> All functions are only used within the file.
>=20
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> ---
> .../selftests/mm/split_huge_page_test.c       | 22 +++++++++----------
> 1 file changed, 11 insertions(+), 11 deletions(-)
>=20
> diff --git a/tools/testing/selftests/mm/split_huge_page_test.c =
b/tools/testing/selftests/mm/split_huge_page_test.c
> index 5d07b0b89226..89d3dc08fe4c 100644
> --- a/tools/testing/selftests/mm/split_huge_page_test.c
> +++ b/tools/testing/selftests/mm/split_huge_page_test.c
> @@ -38,7 +38,7 @@ uint64_t pmd_pagesize;
> #define KPF_THP      (1UL<<22)
> #define GET_ORDER(nr_pages)    (31 - __builtin_clz(nr_pages))
>=20
> -int is_backed_by_thp(char *vaddr, int pagemap_file, int =
kpageflags_file)
> +static int is_backed_by_thp(char *vaddr, int pagemap_file, int =
kpageflags_file)
> {
> 	uint64_t paddr;
> 	uint64_t page_flags;
> @@ -136,7 +136,7 @@ static void =
verify_rss_anon_split_huge_page_all_zeroes(char *one_page, int nr_hp
> 		       rss_anon_before, rss_anon_after);
> }
>=20
> -void split_pmd_zero_pages(void)
> +static void split_pmd_zero_pages(void)
> {
> 	char *one_page;
> 	int nr_hpages =3D 4;
> @@ -148,7 +148,7 @@ void split_pmd_zero_pages(void)
> 	free(one_page);
> }
>=20
> -void split_pmd_thp_to_order(int order)
> +static void split_pmd_thp_to_order(int order)
> {
> 	char *one_page;
> 	size_t len =3D 4 * pmd_pagesize;
> @@ -182,7 +182,7 @@ void split_pmd_thp_to_order(int order)
> 	free(one_page);
> }
>=20
> -void split_pte_mapped_thp(void)
> +static void split_pte_mapped_thp(void)
> {
> 	char *one_page, *pte_mapped, *pte_mapped2;
> 	size_t len =3D 4 * pmd_pagesize;
> @@ -265,7 +265,7 @@ void split_pte_mapped_thp(void)
> 	close(kpageflags_fd);
> }
>=20
> -void split_file_backed_thp(int order)
> +static void split_file_backed_thp(int order)
> {
> 	int status;
> 	int fd;
> @@ -365,7 +365,7 @@ void split_file_backed_thp(int order)
> 	ksft_exit_fail_msg("Error occurred\n");
> }
>=20
> -bool prepare_thp_fs(const char *xfs_path, char *thp_fs_template,
> +static bool prepare_thp_fs(const char *xfs_path, char =
*thp_fs_template,
> 		const char **thp_fs_loc)
> {
> 	if (xfs_path) {
> @@ -381,7 +381,7 @@ bool prepare_thp_fs(const char *xfs_path, char =
*thp_fs_template,
> 	return true;
> }
>=20
> -void cleanup_thp_fs(const char *thp_fs_loc, bool created_tmp)
> +static void cleanup_thp_fs(const char *thp_fs_loc, bool created_tmp)
> {
> 	int status;
>=20
> @@ -394,8 +394,8 @@ void cleanup_thp_fs(const char *thp_fs_loc, bool =
created_tmp)
> 				   strerror(errno));
> }
>=20
> -int create_pagecache_thp_and_fd(const char *testfile, size_t fd_size, =
int *fd,
> -		char **addr)
> +static int create_pagecache_thp_and_fd(const char *testfile, size_t =
fd_size,
> +		int *fd, char **addr)
> {
> 	size_t i;
> 	unsigned char buf[1024];
> @@ -461,8 +461,8 @@ int create_pagecache_thp_and_fd(const char =
*testfile, size_t fd_size, int *fd,
> 	return -1;
> }
>=20
> -void split_thp_in_pagecache_to_order_at(size_t fd_size, const char =
*fs_loc,
> -		int order, int offset)
> +static void split_thp_in_pagecache_to_order_at(size_t fd_size,
> +		const char *fs_loc, int order, int offset)
> {
> 	int fd;
> 	char *addr;
> --=20
> 2.50.1

LGTM.
Reviewed-by: wang lian <lianux.mm@gmail.com>


