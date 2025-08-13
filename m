Return-Path: <linux-kselftest+bounces-38911-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B482B25503
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Aug 2025 23:12:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CDAD77BC41D
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Aug 2025 21:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 079762D1905;
	Wed, 13 Aug 2025 21:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DC90g/hh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2930D2FD7B1;
	Wed, 13 Aug 2025 21:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755119568; cv=none; b=HbrAzZZjBNcrD/4sUv5AyPzCF7Ke2GrDbbmv+8r95H3wSWmLB0tUgVbNveGsa5IoxF30Z7aryMKHXaOT9AKJA0yLaA15r/nFWlKlq02qAHQDl5/ssOK4X5tr9LxHhx3nl6hR8aJPLmc2Hk6JkvJ1S3b7u9EWa+N56uYGOh0+Zs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755119568; c=relaxed/simple;
	bh=EeQx5dVNwrm1Nj5Pid8VwtIMnMsJ3VVlgSwZSJJi97o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LpQfTCAQ5qKyVJn4sS1goiW6iNNGA9KSha2JUhlVbvuCpa4XX4LW7ZIc/X2Z9OQB3b6sbVTo8xjMF7ZFa+y5vkfJGcvd98P//JNnnNKFrzaEDFWhQz7kc2zSnuFrCdEMeGxmIv1WmVf2AlA2fwzMNCT8EpIVIjBRpp4Hh4q3kV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DC90g/hh; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-afcb7ace3baso42935066b.3;
        Wed, 13 Aug 2025 14:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755119565; x=1755724365; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6R+FsQ2hbhcp1JFqDm2g0PdnGeoxdv4HV80v5lSsu3w=;
        b=DC90g/hhzfCtko58lrw/wVMDFkrni4B9EpRVfS38EFC4dQ2TUhC6RTLXsICwBU8OAr
         F0sIXF14OOhThwctHdFWk5XlWkBiW13fk6F2ijHq9FM+WahmotGxriylrSPX4Q8v2cF7
         QCLXNUOVKe6asEfXcK9llLI+adCCp0qN2H8JbsIPPsg0uyyDpTToFfb5LVoMAHxHNGpA
         TVvf8z9VQ20UZ508gUIbkOFDzqhQ5QPncJ5mmpHVW7zo387UpUF3/QgM/gbjUCvk5nYy
         mHXXt9b9XGR2P61BMgwTcvlQBLyid7ZDGeVRk6OeOvEdgG/LvglcgfiPK72hA564KEr5
         R1Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755119565; x=1755724365;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6R+FsQ2hbhcp1JFqDm2g0PdnGeoxdv4HV80v5lSsu3w=;
        b=C0Kilgo92ONPGiL9KN0hpdcIfakiOtMyYY8ZgyT0WrJHCNpZtHpD7XIu4gSKzUZ4c0
         ig7o5aCPf1qvbpfmk6mYdvrHyrW2BTq+nhlbSF7y2qQ6rGckQfk1pF6/83ULqaz7gkBC
         5ArJPPXZJ83itbwjXnYIfyhEZDumRQHI/Zl2vO6n79V2gDdYoTjbLGui5wP8314lEU16
         Pk1eC4o02C0nxhX0XdJ5NAWXn+KdtuZw5mKuQe2kr2GkqnUCVThB9IPEKXH9JEx1JswI
         9O62nfas8PMmvPl8w52mhy397qGDSkRG9IZwDBfUY05gsaGQHPRymuiZP/ezoXit2fcI
         jlcg==
X-Forwarded-Encrypted: i=1; AJvYcCUuT3iGTjlTnJCsLgTqN1bH5FGLQENoHbnVwuf1qDVc2/NFEhIK5dVSGC/6Nodzh4cuIpiy4omWz15n7HQ=@vger.kernel.org, AJvYcCV/wXyL4O7R/Sd2yutUbzXs8wH5e0LPrvWfXEnRX2zizu5vXy8jbBnaXS1rxyBf9qrbVsGnxeOA1hxxTv+SKzNw@vger.kernel.org
X-Gm-Message-State: AOJu0YyVPEJ/LwmrXgmHRS/itxZf1xYsC39PFODfPzv3LmfkrO8qG6Ky
	pTH4HWjJlScWqNy9xUPN0ygVB1zo5ecmbMYoV1oYT0Jfi7L6WA11H3LM
X-Gm-Gg: ASbGnct870uMARLegZK16bNfBoEOHlQEVEVWzHy289mJInlYvcjqPXCGR/vd78ETVh0
	lbXq90QQZFyCNRqWpZaQ5YYWIa/lreaT9HyRjrl/aGSkFNsD4utr8++7c0xAKCyzluduKikeXcQ
	90LhkVAggbQppaYp2GuGzK2oejVytmG+CIta3wRpyZ402T9+QUEqsXH1yGM+JQoo+S2IRnj5vl2
	zht38uJihyOwP4xe15cgYU4IC4yN/JbWjOJZN0Ey1dZWC4ZDRL+6ye03dJMesSCbkK/gKBhcvTn
	VaDZy+ddO4qVFLv2VmkVcj2oX4wSZHHOqxaBfpmMK088SOROzKE3GsEDsC8wnTw9LR3c3i5rpgX
	nd7OY5XXzwmjCGAQ89zy6Hs2rANiZ+GF7
X-Google-Smtp-Source: AGHT+IEQx3+dF5FhXYRCJA2jGhnWmcvHp7LT+bA3JCWJ/ZghpN0pfgTNFHkTyAH3O3lXS3R8AV+/GQ==
X-Received: by 2002:a17:907:1c89:b0:af9:d863:5ce4 with SMTP id a640c23a62f3a-afcbe075846mr21721666b.15.1755119565076;
        Wed, 13 Aug 2025 14:12:45 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a078afbsm2455007166b.4.2025.08.13.14.12.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Aug 2025 14:12:44 -0700 (PDT)
Date: Wed, 13 Aug 2025 21:12:44 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Zi Yan <ziy@nvidia.com>
Cc: Wei Yang <richard.weiyang@gmail.com>, wang lian <lianux.mm@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 2/4] selftests/mm: add check_folio_orders() helper.
Message-ID: <20250813211244.ikequq4kvgs65mpp@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20250812155512.926011-1-ziy@nvidia.com>
 <20250812155512.926011-3-ziy@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250812155512.926011-3-ziy@nvidia.com>
User-Agent: NeoMutt/20170113 (1.7.2)

On Tue, Aug 12, 2025 at 11:55:10AM -0400, Zi Yan wrote:
[...]
>+/*
>+ * gather_folio_orders - scan through [vaddr_start, len) and record folio orders
>+ * @vaddr_start: start vaddr
>+ * @len: range length
>+ * @pagemap_fd: file descriptor to /proc/<pid>/pagemap
>+ * @kpageflags_fd: file descriptor to /proc/kpageflags
>+ * @orders: output folio order array
>+ * @nr_orders: folio order array size
>+ *
>+ * gather_folio_orders() scan through [vaddr_start, len) and check all folios
>+ * within the range and record their orders. All order-0 pages will be recorded.

I feel a little confused about the description here. Especially on the
behavior when the range is not aligned on folio boundary. 

See following code at 1) and 2).

>+ * Non-present vaddr is skipped.
>+ *
>+ *
>+ * Return: 0 - no error, -1 - unhandled cases
>+ */
>+static int gather_folio_orders(char *vaddr_start, size_t len,
>+			       int pagemap_fd, int kpageflags_fd,
>+			       int orders[], int nr_orders)
>+{
>+	uint64_t page_flags = 0;
>+	int cur_order = -1;
>+	char *vaddr;
>+
>+	if (!pagemap_fd || !kpageflags_fd)
>+		return -1;

If my understanding is correct, we use open() to get a file descriptor.

On error it returns -1. And 0 is a possible valid value, but usually used by
stdin. The code may work in most cases, but seems not right.

>+	if (nr_orders <= 0)
>+		return -1;
>+

Maybe we want to check orders[] here too?

>+	for (vaddr = vaddr_start; vaddr < vaddr_start + len;) {
>+		char *next_folio_vaddr;
>+		int status;
>+
>+		status = get_page_flags(vaddr, pagemap_fd, kpageflags_fd,
>+					&page_flags);
>+		if (status < 0)
>+			return -1;
>+
>+		/* skip non present vaddr */
>+		if (status == 1) {
>+			vaddr += psize();
>+			continue;
>+		}
>+
>+		/* all order-0 pages with possible false postive (non folio) */

Do we still false positive case? Non-present page returns 1, which is handled
above.

>+		if (!(page_flags & (KPF_COMPOUND_HEAD | KPF_COMPOUND_TAIL))) {
>+			orders[0]++;
>+			vaddr += psize();
>+			continue;
>+		}
>+
>+		/* skip non thp compound pages */
>+		if (!(page_flags & KPF_THP)) {
>+			vaddr += psize();
>+			continue;
>+		}
>+
>+		/* vpn points to part of a THP at this point */
>+		if (page_flags & KPF_COMPOUND_HEAD)
>+			cur_order = 1;
>+		else {
>+			/* not a head nor a tail in a THP? */
>+			if (!(page_flags & KPF_COMPOUND_TAIL))
>+				return -1;

When reaches here, we know (page_flags & (KPF_COMPOUND_HEAD | KPF_COMPOUND_TAIL)).
So we have at least one of it set.

Looks not possible to hit it?

>+
>+			vaddr += psize();
>+			continue;

1)

In case vaddr points to the middle of a large folio, this will skip this folio
and count from next one.

>+		}
>+
>+		next_folio_vaddr = vaddr + (1UL << (cur_order + pshift()));
>+
>+		if (next_folio_vaddr >= vaddr_start + len)
>+			break;
>+
>+		while ((status = get_page_flags(next_folio_vaddr, pagemap_fd,
>+						 kpageflags_fd,
>+						 &page_flags)) >= 0) {
>+			/*
>+			 * non present vaddr, next compound head page, or
>+			 * order-0 page
>+			 */
>+			if (status == 1 ||
>+			    (page_flags & KPF_COMPOUND_HEAD) ||
>+			    !(page_flags & (KPF_COMPOUND_HEAD | KPF_COMPOUND_TAIL))) {
>+				if (cur_order < nr_orders) {
>+					orders[cur_order]++;
>+					cur_order = -1;
>+					vaddr = next_folio_vaddr;
>+				}
>+				break;
>+			}
>+
>+			/* not a head nor a tail in a THP? */
>+			if (!(page_flags & KPF_COMPOUND_TAIL))
>+				return -1;
>+
>+			cur_order++;
>+			next_folio_vaddr = vaddr + (1UL << (cur_order + pshift()));

2)

If (vaddr_start + len) points to the middle of a large folio and folio is more
than order 1 size, we may continue the loop and still count this last folio.
Because we don't check next_folio_vaddr and (vaddr_start + len).

A simple chart of these case.

          vaddr_start                   +     len
               |                               |
               v                               v
     +---------------------+              +-----------------+
     |folio 1              |              |folio 2          |
     +---------------------+              +-----------------+

folio 1 is not counted, but folio 2 is counted.

So at 1) and 2) handles the boundary differently. Not sure this is designed
behavior. If so I think it would be better to record in document, otherwise
the behavior is not obvious to user.

>+		}
>+
>+		if (status < 0)
>+			return status;
>+	}
>+	if (cur_order > 0 && cur_order < nr_orders)
>+		orders[cur_order]++;

Another boundary case here.

If we come here because (next_folio_vaddr >= vaddr_start + len) in the for
loop instead of the while loop. This means we found the folio head at vaddr,
but the left range (vaddr_start + len - vaddr) is less than or equal to order
1 page size.

But we haven't detected the real end of this folio. If this folio is more than
order 1 size, we still count it an order 1 folio.

>+	return 0;
>+}
>+
>+int check_folio_orders(char *vaddr_start, size_t len, int pagemap_fd,
>+			int kpageflags_fd, int orders[], int nr_orders)
>+{
>+	int *vaddr_orders;
>+	int status;
>+	int i;
>+
>+	vaddr_orders = (int *)malloc(sizeof(int) * nr_orders);
>+
>+	if (!vaddr_orders)
>+		ksft_exit_fail_msg("Cannot allocate memory for vaddr_orders");
>+
>+	memset(vaddr_orders, 0, sizeof(int) * nr_orders);
>+	status = gather_folio_orders(vaddr_start, len, pagemap_fd,
>+				     kpageflags_fd, vaddr_orders, nr_orders);
>+	if (status)
>+		goto out;
>+
>+	status = 0;
>+	for (i = 0; i < nr_orders; i++)
>+		if (vaddr_orders[i] != orders[i]) {
>+			ksft_print_msg("order %d: expected: %d got %d\n", i,
>+				       orders[i], vaddr_orders[i]);
>+			status = -1;
>+		}
>+
>+out:
>+	free(vaddr_orders);
>+	return status;
>+}

-- 
Wei Yang
Help you, Help me

