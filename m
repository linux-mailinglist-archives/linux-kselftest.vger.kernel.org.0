Return-Path: <linux-kselftest+bounces-38445-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3269FB1D466
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Aug 2025 10:45:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9BFC3A9AB8
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Aug 2025 08:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4BFA2586EA;
	Thu,  7 Aug 2025 08:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KllkFYZt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC2D2586FE;
	Thu,  7 Aug 2025 08:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754556306; cv=none; b=N7W7CeZA7N1ZWRlw1gqn4+OPNTnDKIFAZYA03VmY5poHQpYF/3lQCf0+B5Gv69WKTkiqgWfiV5QEkKxhQelpkPr/CVgRkwxxPqfceF0C7K7VEBQ30zN6nJvLx8EYsYPtZd9g978/eaDd56DQwktJY6vaYdWXpsuIeizehCeKgQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754556306; c=relaxed/simple;
	bh=I6OjajkUfWnNit8S5/zBfURezIDggUBkU94gizwjnW0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P7UltA0ygvjivMx0QuzHeGcxQNN+LfanEIN6lk40jquOO3MTQ7S87OVt50BrH/Z7w4rAfAwx1VHD43GnLQ6kvoXl9gjDaMXr+8KMWLvGejsloKG3beksFGg/m5PiNeiThn6mxLOVaCZCXHf26JN9PchD+AuTOhL4VxJvB0DLwZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KllkFYZt; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-617c40825c9so678115a12.2;
        Thu, 07 Aug 2025 01:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754556303; x=1755161103; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kdrjfj4JqRdH5AZX6QJcIeMShUQkrtbEA3mxu4yqktk=;
        b=KllkFYZtx7sHDdCJWtuEDC6hW5s1wDwWMPVEPu+dJBiTCJocldOlsZuvAxngUBWQSF
         MsaQT+DpUZb+NnxiKFQFMUq4umhXg7suJgLlKSocgmpgZ6y67JDXRiFy98XanSTLGO3E
         zlRTT8KmO5+0dEnVO4InGZdKNpI/aiRQm3SoxFhKGod2soU7cScFc3ntmN1ehTWl4Ufl
         JfO/WQ4tl3LVCLsCxt4ngqQU9HuZvbGnbgavZh8JXg6AlqZf8aR0N0YO0pYu7Z5FBiLY
         GLQtkvWS+HwaDuNlztKUx/cBRIFVPIus6ERt0V/xBXPNYG1/4gEO1nVGZ90allvPEL1H
         WM/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754556303; x=1755161103;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kdrjfj4JqRdH5AZX6QJcIeMShUQkrtbEA3mxu4yqktk=;
        b=kB5rZRWnrIg/Oj//6qrrfai8ZBHZ7z+dI6Aq+YFY33c8SLl3DYbyHbuICxIL6Lmokl
         U7Fo8cRIyAAnkem6ruzdZkE4D8c20+eYWULsOyJCjxQFIdCO9h/U+aygmI8fWxh7My6p
         QK3/0Axk+I3B5dgupwQeFo2O7s2JPSWLnCgbgOu2NwZkkAn0Tx6/qOloI/BpNRenTuj5
         yuXvwcZ0YZ3dY4aNfU6QjXohOcU9gdoADnb/ocHCjqMaoIpOUaaROeFUGqb/VqV8Z6UH
         S194XrYs7YKDkVrMw1Qxkbu+9LfN8DzfF+xduj+jT2R6gEtiPJB3526LvocfwNXp3BJ9
         eUqA==
X-Forwarded-Encrypted: i=1; AJvYcCWHYL1gml2zvTwu5bRasDZ/mC3qt25n3sqb82BfrUXt2aq3AoOJd9EQHD7dukYxdcp7fe4eX6ULTLwbz7A=@vger.kernel.org, AJvYcCXIRVsge8mUqqx7ATtkRWZQupVSEd/kOURXcWqSBXQJxT9/cVMNOywHt+eiQGZUju5+rEUZdY40sjUqmYfcviVI@vger.kernel.org
X-Gm-Message-State: AOJu0YyUHaaaL/x905F54y7pfR8FXdn75dtHzXknxGW4gjvvOk+GmKOC
	zav+66T0lpEkDqsN/3uC1zdg+3ADMLnOk8LhTv5NCD/GNReCqlE0bDlE
X-Gm-Gg: ASbGnctO2ta+Qp2TanzY9YZtKwnMAMGzdXZhSJhcG+fcLRnMlJ8hwGuzhjoBuhKd0v9
	QAXiQwUxq5Vv+dRgmc4IVWlqulgssiuqn1tX2i/h19iE72U2k27fHQIH68IOXdqgz1+UkjUqoBo
	3OIMpIol0zg5S7suu8iRlduYZAHhW5w6fm5BIXlqQ7RjpO95JppkGDMKCOtME0cVuE7BSclZD/A
	JT0lYFMHnvLpiFpjIopmumRKZPFyIreesuYiOogdNC82fWI1b02H1Q9ijFYDFUK88O2aHE0EKST
	sec/hQ5BaJ2eRup166daBpF/20dl60PKYnNxN4PVRWPSBZ1hyL//vWmfoGpHj0/j2VPzd2yss+U
	ZYMpI3SFCsrTKNwwOediXUA==
X-Google-Smtp-Source: AGHT+IHTRmKHwL7DD9CYouIIyx4NxN+nypgCzWZu23Usy+u/PAYeINh0DZM18YqUo2k9n8jjDpRnUg==
X-Received: by 2002:a17:907:60d2:b0:ae0:ded9:7f31 with SMTP id a640c23a62f3a-af992aa9796mr468147766b.20.1754556302936;
        Thu, 07 Aug 2025 01:45:02 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a240645sm1258413466b.125.2025.08.07.01.45.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Aug 2025 01:45:02 -0700 (PDT)
Date: Thu, 7 Aug 2025 08:45:02 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Zi Yan <ziy@nvidia.com>
Cc: David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 2/4] mm/huge_memory: move to next folio after
 folio_split() succeeds.
Message-ID: <20250807084502.vizmxfum7knsr257@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20250806022045.342824-1-ziy@nvidia.com>
 <20250806022045.342824-3-ziy@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250806022045.342824-3-ziy@nvidia.com>
User-Agent: NeoMutt/20170113 (1.7.2)

On Tue, Aug 05, 2025 at 10:20:43PM -0400, Zi Yan wrote:
>Current behavior is to move to next PAGE_SIZE and split, but that makes it
>hard to check after-split folio orders. This is a preparation patch to
>allow more precise split_huge_page_test check in an upcoming commit.
>
>split_folio_to_order() part is not changed, since split_pte_mapped_thp test
>relies on its current behavior.
>
>Signed-off-by: Zi Yan <ziy@nvidia.com>
>---
> mm/huge_memory.c | 18 +++++++++++-------
> 1 file changed, 11 insertions(+), 7 deletions(-)
>
>diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>index 8a11c2d402d4..b2ce8ac0c5a9 100644
>--- a/mm/huge_memory.c
>+++ b/mm/huge_memory.c
>@@ -4341,6 +4341,7 @@ static int split_huge_pages_pid(int pid, unsigned long vaddr_start,
> 		struct folio *folio;
> 		struct address_space *mapping;
> 		unsigned int target_order = new_order;
>+		long nr_pages;
> 
> 		if (!vma)
> 			break;
>@@ -4358,6 +4359,8 @@ static int split_huge_pages_pid(int pid, unsigned long vaddr_start,
> 		if (!is_transparent_hugepage(folio))
> 			goto next;
> 
>+		nr_pages = folio_nr_pages(folio);
>+

Could be folio_large_nr_pages()?

> 		if (!folio_test_anon(folio)) {
> 			mapping = folio->mapping;
> 			target_order = max(new_order,
>@@ -4385,15 +4388,16 @@ static int split_huge_pages_pid(int pid, unsigned long vaddr_start,
> 		if (!folio_test_anon(folio) && folio->mapping != mapping)
> 			goto unlock;
> 
>-		if (in_folio_offset < 0 ||
>-		    in_folio_offset >= folio_nr_pages(folio)) {
>+		if (in_folio_offset < 0 || in_folio_offset >= nr_pages) {
> 			if (!split_folio_to_order(folio, target_order))
> 				split++;
> 		} else {
>-			struct page *split_at = folio_page(folio,
>-							   in_folio_offset);
>-			if (!folio_split(folio, target_order, split_at, NULL))
>+			struct page *split_at =
>+				folio_page(folio, in_folio_offset);
>+			if (!folio_split(folio, target_order, split_at, NULL)) {
> 				split++;
>+				addr += PAGE_SIZE * nr_pages;
>+			}
> 		}
> 
> unlock:
>@@ -4438,8 +4442,8 @@ static int split_huge_pages_in_file(const char *file_path, pgoff_t off_start,
> 	if (IS_ERR(candidate))
> 		goto out;
> 
>-	pr_debug("split file-backed THPs in file: %s, page offset: [0x%lx - 0x%lx]\n",
>-		 file_path, off_start, off_end);
>+	pr_debug("split file-backed THPs in file: %s, page offset: [0x%lx - 0x%lx], new_order %u in_folio_offset %ld\n",
>+		 file_path, off_start, off_end, new_order, in_folio_offset);
> 

How about move this part into patch 1?

> 	mapping = candidate->f_mapping;
> 	min_order = mapping_min_folio_order(mapping);
>-- 
>2.47.2
>

-- 
Wei Yang
Help you, Help me

