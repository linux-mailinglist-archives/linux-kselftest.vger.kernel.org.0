Return-Path: <linux-kselftest+bounces-37351-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E7A4B05871
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Jul 2025 13:07:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEDE83B1280
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Jul 2025 11:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC1152E03E4;
	Tue, 15 Jul 2025 11:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="enerStJq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC0A2DFA2D;
	Tue, 15 Jul 2025 11:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752577521; cv=none; b=WlT4Tt8NNYyPxJC3UOhq02bSDUMJ0bqLIEcbsU/TetEcs0oMZGPMYX/pO1xu7Ao2EOKX8wsUSpD9IL07NLiqtGMzdYldCkFxvamDJBn8fFVsYTrwdHm7D9nvDWD2UfnPi0v2XHZgrCmoJIFVZ7fR/XxySdk7nzrW/OLA0GparBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752577521; c=relaxed/simple;
	bh=HAoF2sUWyT3T91Zxpuepmt97am3f7ctQ7EPIkg8OWm0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pLMA6nfxUzKanYRdfWaPAegi2WDPUa7LiUe4x5n1gyFumFcnzvrScrj1Xv3Wcr7U7rBew8b+jF2zxHkRUp3m5zdXeRln87K3w4u3FlSP9IGCae0KeU+8HQj1lYjrv5O4TTP8gmzru7S1V1fLks9YcmNs20DDyQ5QNxkVSHeJs/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=enerStJq; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-74b54cead6cso3606946b3a.1;
        Tue, 15 Jul 2025 04:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752577518; x=1753182318; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PdyrYF2somcJWeVef/fvp9prs0ptIROm/PEHLAtgGIQ=;
        b=enerStJqaezAy7KgamCRYiVOi0MU97R8oNT9+zDlTVFuAS0ANZ9J05gA5VlHGOgw8A
         1NTU1Me615h6c3DOD7Pa+UicHxHmAh0kcO6H1h1mglSJcIQoiWC5yXjRIm+VTf6/aIwI
         n/cXeyzhnQ0BUO8oeRD0riHLnLpg7iYVD1MluIWdmg5yRlntFZPPW0yT+vqnRv1ox0HN
         zk++x5kDQx5YC4Ld5jj3Ghm/ymsgfxESYQr82f5/W0eD1P2OKSyLMqv/ciCkKD3C7R2g
         Qkqf16ZTulBfGvVfOXxihJeRg6YYw4M6SI1jgtFJWoBxpjR8z7sMIEpRbUOjnlsAvoki
         n7+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752577518; x=1753182318;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PdyrYF2somcJWeVef/fvp9prs0ptIROm/PEHLAtgGIQ=;
        b=BqDI7JFVyBt7jY0/kJrNCUm7TSLCtWwV6ibfThpO1nGJYbOaGwjtnv6Ssk01zpdAGn
         w7adL/eTt0ksGuNMacuwbS9AF5GJoPl+RcZVWuqXYnC+Gu+nxUNdtDQ7En+JasfGN9Pi
         olmPmwLlncqC/EgEP5V5QSS1P2iInJpUtijArDCDefgww0c+fWDdYFpVpsLXWulZL5RP
         d0L+LSZ7RvVhJhsRdJz6lMl+IsNRUnKYFRqKvb/B65tRbQCtRT61sWCcd2KRjHFp25T1
         P2SMsAl9AAEkWC6j0SorlZmhtITwb6ejOUjDVnH17Wf7hfBKL0I+5I1SGYDp6/aSI4Rn
         +YLw==
X-Forwarded-Encrypted: i=1; AJvYcCUd+5xr9rdyo7m9iRmSvTQH0b5Uc01j4HUpM1wagOPObOo8jHmmBdavkEZ0CR2fw1ClKcMS62Lpyb22kOKbFj71@vger.kernel.org, AJvYcCXWadCt8+HALKVQZQup6yQjS6m7gWMXudeBIx7nYr0tLjhP3gJ3xGjPD8Bm9YwVL2iKvoQ+CnSDqITJzTs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzqitakf06r4b6semMNu+4ObeUmFntUm1D+R/XhBDKW6HAzOnpb
	cD220Uwuf0EDFSu7+rFicraB67ve7k5KWzvPbcBSjSWlA82jmMBD26X8
X-Gm-Gg: ASbGncv2otU1cMFvOyQm4lG0wH1hoMZU0RS9xS6t86H7FiLhuA07mj9Jro4HFxGFwnG
	TZF1nIFqSOZuugQYG1SfRxWukGVGSfHLg9fphYHru/MRtZbrNbH6LD19wog40SW9adtP5FpbIDO
	IyRJRYQKGAQtpenPLxkWUYAd914zjA9Nofc3qzkoiM0j48ZVawx7y4bNuZyYjlszvA82c2ci75A
	GG7UTWzCLNElqzUbHFxto37dO6zWqBLSSxx9JJOxEsJ+YWvFCcWKS4gtexw7sZMcXdRI6FsmeXD
	7p6KSY7A5LGZPESeM9huHyBuxaZ4vYzCXAuLR1Xvj69f9nEc66bUpryWINfkw5PH9qeBPDB1AbX
	tRAEJZZBBhDbz8jjOGmd43EFX17F8PQtLSWMev/GCSBvV
X-Google-Smtp-Source: AGHT+IHvaoN5oYUSaPoNNV8wa34UYow1jV/wQynQyE+HDVIwE4uylcfESipjeICXNaldk8QQGezczQ==
X-Received: by 2002:a05:6a00:810:b0:748:e0ee:dcff with SMTP id d2e1a72fcca58-74ee295d75cmr22942281b3a.11.1752577518294;
        Tue, 15 Jul 2025 04:05:18 -0700 (PDT)
Received: from DESKTOP-GIED850.localdomain ([114.247.113.178])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9f4a050sm11802421b3a.119.2025.07.15.04.05.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 04:05:18 -0700 (PDT)
From: wang lian <lianux.mm@gmail.com>
To: lorenzo.stoakes@oracle.com
Cc: Liam.Howlett@oracle.com,
	akpm@linux-foundation.org,
	brauner@kernel.org,
	broonie@kernel.org,
	david@redhat.com,
	gkwang@linx-info.com,
	jannh@google.com,
	lianux.mm@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	p1ucky0923@gmail.com,
	ryncsn@gmail.com,
	shuah@kernel.org,
	sj@kernel.org,
	vbabka@suse.cz,
	zijing.zhang@proton.me,
	ziy@nvidia.com
Subject: Re: [PATCH] selftests/mm: refactor common code and improve test skipping in guard_region
Date: Tue, 15 Jul 2025 19:05:07 +0800
Message-ID: <20250715110507.5383-1-lianux.mm@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <5e2b88e0-84ef-4870-b472-bd2aa7e88c78@lucifer.local>
References: <5e2b88e0-84ef-4870-b472-bd2aa7e88c78@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> On Mon, Jul 14, 2025 at 03:44:28PM +0200, David Hildenbrand wrote:
> > On 14.07.25 15:39, Mark Brown wrote:
> > > On Mon, Jul 14, 2025 at 09:00:09PM +0800, wang lian wrote:
> > >
> > > > Move the generic `FORCE_READ` macro from `guard-regions.c` to the shared
> > > > `vm_util.h` header to promote code reuse.
> > > >
> > > > In `guard-regions.c`, replace `ksft_exit_skip()` with the `SKIP()` macro
> > > > to ensure only the current test is skipped on permission failure, instead
> > > > of terminating the entire test binary.
> > >
> > > These two changes look fine but they're not really related so should be
> > > separate patches.  Looking briefly at guard-regions.c I see a bunch more
> > > use of ksft_exit_ functions that ought to be fixed as well, but your fix
> > > is good.
> >
> > The FORCE_READ() could be factored out separately, and as part of the same
> > patch, replace the "asm volatile("" : "+r" (XXX));" usage in
> >
> > * cow.c
> > * hugetlb-madvise.c
> > * migration.c
> > * pagemap_ioctl.c
> > * split_huge_page_test.c

> Wang - Feel free to put my Reviewed-by in any such series assuming you do a
> straight up replace.

> >
> > --
> > Cheers,
> >
> > David / dhildenb
> > 

> Cheers, Lorenzo

Thanks all for the helpful feedback and encouragement!

I'll prepare  include the straightforward replacements in the other tests as suggested.


Thanks again!

Best regards,
wang lian

