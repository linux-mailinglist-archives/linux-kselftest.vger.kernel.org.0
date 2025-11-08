Return-Path: <linux-kselftest+bounces-45175-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E9D38C42F86
	for <lists+linux-kselftest@lfdr.de>; Sat, 08 Nov 2025 17:11:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6F6364E29F9
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Nov 2025 16:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAA3923A9BD;
	Sat,  8 Nov 2025 16:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VwpzuUfx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f196.google.com (mail-pg1-f196.google.com [209.85.215.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E490238C33
	for <linux-kselftest@vger.kernel.org>; Sat,  8 Nov 2025 16:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762617828; cv=none; b=OistH8kc5kppDdyS6JrcSp9/Tr49Ipd1hFhWdtOTrplxzZn58gyODmmuFjePj3hlb56OiF+4Kho6gBCNHOzlHje5X7TNdEQmO8PFSNl0pjhDDljVyrCruYFuOaBXlF98UEB8GufHk4VLRKyOKk9U+8JtsYLLH6S5DZb6xqvFQK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762617828; c=relaxed/simple;
	bh=3Ybn5iXrkjkYhMWK9VcbyAZU3uy2DNNzj4Lp89kHrfU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t7JHsgvJvdDd3DAZcTpwCiGP79ADL/gQX0deoEjW++J1IpS6uyL9vYDTyYY5XY4FUXevzyGUSPr1KBpPLR6Ru2kBO+jr+SmdMmVNccA2mxjNda0K6EUfkHfPgleB4jj7Z1hE65mH7ZY9Z//hlRJzIRFjf0tXdn3LTo9rAJIh8uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VwpzuUfx; arc=none smtp.client-ip=209.85.215.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f196.google.com with SMTP id 41be03b00d2f7-b9ef786babcso1129250a12.1
        for <linux-kselftest@vger.kernel.org>; Sat, 08 Nov 2025 08:03:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762617826; x=1763222626; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CuVjvWt5pWlBdwB9kStq+sIEfsEspJe0fkwfw20IDZE=;
        b=VwpzuUfxcRugH/W+wvcMCIICA5lILiqpdgk5i4fk5c751ChsMHFsXuQK1qEkhmyHPE
         6etZKzdEWecr9cId50OKYwc+H/tGb6qP7CPRJmIda7RjdPLo1nGqas9oBSDPekflpALz
         amE0e9aPGl6hu19KuwItaOqoi37/fwsougN1SvFLLYxAPUulBcfRd8SmIgVMRJud9qSJ
         FKuZhC6/TQSeijwX1Dh1GwEuzyZgzuLonBL8rQ9VMdy3rZGNUM3pMxY7SV4sm5+tuESS
         HtM8eorJ8WvySDYz3twYL4M49fidkvcaIcWnQgxh04WBu9zpeH1yS3wv4CSGXffaQwk7
         35OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762617826; x=1763222626;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CuVjvWt5pWlBdwB9kStq+sIEfsEspJe0fkwfw20IDZE=;
        b=rH5H5qpWuO3xRwCXovo5GT+7hczPo8fQMj3LZmldKX+H1QIKuYzntJhK3blcjS0j9s
         7aNLjpJAxkF4+Tl5WJukqYxuaMOtnPdEZj1qdApuPq9e2MEUMWbPVwiHGmnPJ2ag5q8x
         qi9W3+hsokjTUCCl9juujfLMts2Y4AN8V+FWzAE9pvnJieGs/IEWjgxMAPygX71+oeBS
         1APdEhLxy6HzQLfK0AJEEfZwKClJ8L0IhcZ7iZRNDi4vJsfTzsei/6/nYm8usPrjt7MN
         g6z/g9xhadmSsQn+YZ8tc0MjlY9uFonenBb+qsTm851WdmH+lUFz0ud2z9fWm9I4Bj14
         mFNA==
X-Forwarded-Encrypted: i=1; AJvYcCWoJpNUCpDAsjYUNG79iFdDp/6AE+sH3Q8njwYFo3cY4oVgK4vW0KU0Y/6t6TcFXiz5y09eLr72Lv2EWtN1XFg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwogJ4mlk5WkCnq++U3js5RkKKNb/Cxm6tAQB3YbmfC92p+Q9cv
	hZyuOzmdafUPa1nItMPP1nX+75zMzuKGK/SpWYQlcxKzfUwH4cLUkjO6
X-Gm-Gg: ASbGnct5t/xHrVv2dOLFFppqX0fg9rvL8ifZ/JPLCLSI05J5MYPVJU+gbLBu+WNdRk9
	Uyetyg3nUMrGOZ0Adou7YvkaStjLeSESuVGwPG01g4tJIz/Q8Qna3qTF3Ahz7mqmI7REI5GOOhO
	GIehtWuQvCXeHBEa+5wjAGqxwm9PPKQ6T0vNhqZh5vhBf7UUVJlfU8i76OLhC9K38BYqp6gh6VB
	qmPAHcuh0OEtQ5Z5olnGaFL0DUt3xd6jvcNtZIKl4IZxoLrLdLR4UQAR+Ic2EUpTzHMULCTer+B
	Kp3yE0FJI7lbIf294P6zIR2G8ebsMa6UnCg60eUt7sX4uQ3EtFDVoJlVSjaYtZOuxsiJsh6trnY
	CZC5kOEPEJMAly0YT2T3rvuLd1l2Ojyht7/u4HvMJmCFa196kTS0iI8AmgfN50uzBeSP47jYjQO
	VsbgDHfiDAFSiDlFanssIVn6bFW5ZsGkUFOdIMW2nq
X-Google-Smtp-Source: AGHT+IEE4oksO9LbHCgRQRuTc/gmfnr3f8yjUh+jBjYO6mFyInWa/Uxiu+FDx81kzpxEEQ/Iw2vrsg==
X-Received: by 2002:a17:903:4b2b:b0:295:6427:87d4 with SMTP id d9443c01a7336-297e56cbe33mr33577915ad.50.1762617826483;
        Sat, 08 Nov 2025 08:03:46 -0800 (PST)
Received: from fedora ([103.120.31.122])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2965096b8f4sm93174305ad.10.2025.11.08.08.03.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 08:03:46 -0800 (PST)
Date: Sat, 8 Nov 2025 21:33:38 +0530
From: Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "David Hildenbrand (Red Hat)" <david@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Shuah Khan <shuah@kernel.org>,
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftest/mm: fix pointer comparison in mremap_test
Message-ID: <aQ9p2srpUtRG4Ltp@fedora>
References: <20251106104917.39890-1-ankitkhushwaha.linux@gmail.com>
 <fc051006-5cb2-49e1-bb27-7839837439cd@kernel.org>
 <aQyOZ6eYng-IjxS_@fedora>
 <6e07949b-d86f-46d8-a68c-9717cfb26084@kernel.org>
 <20251107160855.58891ac6df6854a3b608185f@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251107160855.58891ac6df6854a3b608185f@linux-foundation.org>

On Fri, Nov 07, 2025 at 04:08:55PM -0800, Andrew Morton wrote:
> 
> 	void *addr2 = addr + c.dest_alignment;
> 	if (addr2 < addr)
> 		...
>
Hi Andrew,
i have tried this and clang is raising no warning.
I will send v2 patch with this changes.

Thanks
-- Ankit

