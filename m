Return-Path: <linux-kselftest+bounces-39040-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D07EAB2769F
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Aug 2025 05:16:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BEB3A03905
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Aug 2025 03:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D405529BD93;
	Fri, 15 Aug 2025 03:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="abK5fGGl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E5D529BDA3;
	Fri, 15 Aug 2025 03:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755227704; cv=none; b=D9ja+5PoWhlK33VjNq33SjZ04mpSBihrv2gPO2OYGZrAWE1aYT3P1/Gii1fqw+KKQl+3NRjr4tSDGNr66n2ScAEb6pns7ele9NozOTr0l2E2okNlc0EP7E/zUjJikq4x/zsP9tp/VD/FOvIz5kaqVGMfsfGzKns7PDJ1XSGL8jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755227704; c=relaxed/simple;
	bh=4FNpgkBqGv7OUurYt4FrMaaJFnj1SzUQZwrFcXN55zQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qs8qjx6XgP5r9JypD9VjT56rWxatT4ekoBzN5FOx9ZMMVazSL2BuDS8kSyOlWUARvGUHFG+Ql0EKugTaQMHYqmgoD8/R3wsdx/627X910HMW2G2QDmo6xJiaQCPfE6W1tlz1TyT81m3nNe2pb6PIJGr3dTbN/UcUF7S1qTMfs5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=abK5fGGl; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6188b7550c0so2108414a12.2;
        Thu, 14 Aug 2025 20:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755227701; x=1755832501; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jil/SDWoEH0VnNo/eFUe9s+p3KUllo94Bl9QN7tRkts=;
        b=abK5fGGl65LHWfmvQgcJlRAXSJBMjUcyqr9FXjygslVciavkZJhjjSQJts2xJO0832
         jqT8e7q3XDFM1Re8AucGi70V2tM4H2EOtEizYH4cu1ReXcdOW0LCA85H8aDxbYY4F0zU
         9We2sQoJwieoAtCmn+LogWmqx2vygZd1hSMjoRD4feOrFfQVZRamYWgkR16UZpfmDjf8
         gaFzawQ+IK0kzDBwmeemD1BGO97tqrLN3mxR0fsr71yy+QMCzrSjDuHo+7eRV/eMAmck
         v/EZGmsHc7zgf7N6ylyrYGxzjrH7HNw9BSvo9Yn1HiGVofl2M1cby0w+1Vy5YZK+o91R
         YDnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755227701; x=1755832501;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jil/SDWoEH0VnNo/eFUe9s+p3KUllo94Bl9QN7tRkts=;
        b=pKLTKj1URJESoHznqWxyn5eTRNWzPkecUt4+jWwLQqJqeaHNazJngbZxWAj7YfW/iG
         QMSwM2RNhJeASFvQ9JFUeue2U+holbjcZKD1mQTnerZzoRogXoHSIjussGwjSO+LMC+z
         kVe+SHwHF3AuA2OOzT6RAimKFSTPd/++f8+8/Y4Xj0mVoPUtAyWkjWMwZaHyLqLQAy5G
         qR/KK/1AJ827fjQl5wlgb4XrPoQKn2VS6kUH5E13ZYccI65cr5FJzesjQRP3X3+IP1pC
         2R8jPrv9KUpwH0HkFveJOWV40J2MxRcY6eBLloEGsCN/fvE/V3gd98avoFxYi0TC2D5X
         hD7w==
X-Forwarded-Encrypted: i=1; AJvYcCWBvFxK2Ho2f+1cZz5GyfFffMToPBG7SR2YklnVk1omPQ/LCl4xSGVR1Iip5K40DK7QJS7/wJ+7wXKO9lhI8ekr@vger.kernel.org, AJvYcCWz8xioh+mHhoqjMd2r8k7Gc8tD90wlgWbN7uekE5/KAe6jd1sP2mRYCKiFvtX25VTrfOW5fPfSJjcBCeY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyX4FWF9Knej+D1fSVvI23XCkCyL/h54AR3UwxQ4XDP9BjETUji
	sKEpavKHHW4Ka4rIGpCv/Pma8kms+fbKg/PbNB1cLCfd1n1a3KGvzzDO
X-Gm-Gg: ASbGncsewzpGRKggEl/uE7tMgibKgFZW6CoJOdBzdA+N338H0CgEAPEhw7+nrQdiTRX
	u9K2iXKCn7pORY6gcNoWvvvfXax0PxWOshlaU8hQDGV2mEclsdWITSyJmrW+VcS3bows3+mztgH
	ahrtB5IK4dhr5X99PxEqvhKhvpXU9B2UkR/WtMD5nRKDvbmTUOgwF3r158//UJ3P3PvXpqz7y+U
	JBNmu2aq6njQ1ayCQNI5/AXMvRASZ+JGa7uSlzm+dGsndmeIx/wTaJvlY5rg0OeuuJiZO1Pz+CQ
	Ba8zlsHi5TNIJUlrc2VzXUzRognUjlQplWoyd8eE9ZlBVk6rTOhvGxclqgEF1xULpZlMnPHWuzD
	ZgBWqCs9n2TONoH7KTvyIqA==
X-Google-Smtp-Source: AGHT+IGs5zK6Ch8KejfddlgpsFL2gRX/QDwoXH7kjER4bd5FDXapFk6ehUlWVvF4mB7EqW25R6CYIA==
X-Received: by 2002:a05:6402:350f:b0:618:4a1e:9be4 with SMTP id 4fb4d7f45d1cf-618b054aa91mr339368a12.20.1755227701104;
        Thu, 14 Aug 2025 20:15:01 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-618af9da5d9sm393836a12.16.2025.08.14.20.14.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Aug 2025 20:15:00 -0700 (PDT)
Date: Fri, 15 Aug 2025 03:14:58 +0000
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
Subject: Re: [PATCH v4 3/5] selftests/mm: reimplement is_backed_by_thp() with
 more precise check
Message-ID: <20250815031458.455xxdaiv4m3npxc@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20250815023915.1394655-1-ziy@nvidia.com>
 <20250815023915.1394655-4-ziy@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250815023915.1394655-4-ziy@nvidia.com>
User-Agent: NeoMutt/20170113 (1.7.2)

On Thu, Aug 14, 2025 at 10:39:12PM -0400, Zi Yan wrote:
>and rename it to is_backed_by_folio().
>
>is_backed_by_folio() checks if the given vaddr is backed a folio with
>a given order. It does so by:
>1. getting the pfn of the vaddr;
>2. checking kpageflags of the pfn;
>
>if order is greater than 0:
>3. checking kpageflags of the head pfn;
>4. checking kpageflags of all tail pfns.
>
>pmd_order is added to split_huge_page_test.c and replaces max_order.
>
>Signed-off-by: Zi Yan <ziy@nvidia.com>

Reviewed-by: Wei Yang <richard.weiyang@gmail.com>

-- 
Wei Yang
Help you, Help me

