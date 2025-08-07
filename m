Return-Path: <linux-kselftest+bounces-38447-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 069A5B1D47F
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Aug 2025 10:55:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 296CB165F4B
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Aug 2025 08:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AEAD25D549;
	Thu,  7 Aug 2025 08:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Us0rW9ru"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C892F248F59;
	Thu,  7 Aug 2025 08:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754556925; cv=none; b=qmEHOMySBYyu3263CVOj6XRe9wkn3zvO9TvNqQ+jScOPjSFjFNBgjwisbcuC8d27ioei7cEPxP9UPsqBHo8goHunDxWaC8eYOAM9Qj0ZHUsU+whznYcKLDDZKAJfjI97DyqpYbVgqc3eV2i0fd6P9NB+PsZ2c9U0/k9v/2Cio0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754556925; c=relaxed/simple;
	bh=4YqWG9wfnD66JGzSAgBW267X6VSf1B2jfJGMkI7DZNE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ssLlQcV3qev50mmYshb9g47qdeiSKTMqF2Vk5Q4Nchv/IS6hb4VZPn9eBhNrOW3OCyQFZA3Wnn7a+Uwj6fOEVsxSlRmTJxEhhbv9m+SXC1vrlgVnQWzCkX19KWLK9oPTVG5d0YuOAQjrLwfpInyBdK5EqPq14NSe+4INeppDYHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Us0rW9ru; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-615460d9897so883439a12.0;
        Thu, 07 Aug 2025 01:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754556922; x=1755161722; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DDXmh75UDPVZcShbfv7sdO0bYeNcflHpZyxCdwnzbWg=;
        b=Us0rW9ruTw2Sf6iz1HKtFOYnIOORN6rP4OuYmD8IOVw1WiJucBwDsh38mw/oWbOKHQ
         P+FfUbBsMZBBYtPdrUF3BlSNdA82KIOY2tpoTQBiTeBXAn1sbrOIea5A/8ynUHuaIX5B
         snqW7c3Qjpqc5xaT2BID1uFk5ydPtlruzg/t627xo7goTYd5zvd6GuJxCKeMaa/RLoGk
         /QKufRv+2/ZrnWXwc1YhqKhzYo3vHo4ggkmDfuPZeHV3X9LgNn/ejsF+gr+G8QlYTs/U
         flQ04ToqamXxEM2WO/Nar+f9wVkfXDMi+vAWsSCErQKp1ocO1aINsMRgCXOrv9VjtzjB
         ZRjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754556922; x=1755161722;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DDXmh75UDPVZcShbfv7sdO0bYeNcflHpZyxCdwnzbWg=;
        b=U1h5leksz+d6g5DtIsf4Rg+oVsGYCST9fwbAM5LcxvW+Aujd/5ybqKZCmn5v/hb2sG
         QKlpszWU4Ndd5x5BStzHHY7zGw+PIJp9jxz9pBl/AvqHFLq0qEgZFH7HJtYos/qITqD4
         Y4lxodea8KLpzckXqcDTcQLs1VHKzVOw24Q1KHhvNAKJfIHOURmpgb3jIpl+igIQXfGH
         /ahQtl9v8QN3alFCm2Lk+J1FqI2vMoX4fO7foTKkmaV6O83r/QIP6M2Ap1sXL86BiJ2Q
         7ITeC46H7MzwrQV+c1UpzHuKnIV0O68hPtSGmq4DyTLwu6Mv/Sa99OfvrrT/a3n4GyoO
         DNUg==
X-Forwarded-Encrypted: i=1; AJvYcCVSriFvT8LW7mS4IFaiyAlmsQmCLB9nDU6k4N5fb8qbaL+jgu/IhZCuELzyhW3D22YMuAhNAsdlQ+TgjAc=@vger.kernel.org, AJvYcCXv9LsN78w+9KCiU28JLpaab1OZQtEmDzSeFe7fcs31FqWdBNJICqu1I+9IxWyQfpWD08TCLFV/dwvePKqIJvoP@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8irSXY5Byk0PxszWIoTXsrfB8P7Of127Mb8tJ74RzaCGB23T4
	AYgH1s8TzgzU2jbyq+J4FzYwMGya3iygaB1rDajTRddAsO9X0+X+qBp/
X-Gm-Gg: ASbGncuFWTvlsHU+X4UFKXYWa1ehAnDItBZKjxl2S52kUZNaqyH3r1/dVGIKyOiVd34
	zB9wmppcnY5DYix61TCgNWgainEbJBVpIdAqCo+1ERDJSlJNCNYe+yOsFMIMEYbtgoQNgihMZbq
	8bBG+JTqCa6b6b0/DmRwTUz3eFaCdFJ1OXhM2bzB745Xt2Mz+Mwwpz1iWuLVOnqFBitkaOgCY4x
	IgttAXTms2Wjrj99sqeNrqEvPOExWNzB+MQOUe3zW3AQGa5ijuuaMbZQnwWLWcKrA1wZMPiA4ph
	Ayq8gmR7BgluhFGieaZRMz0Gb24JEnBzjsmccbfnuSrp/OoVFzqjX0dERW/ry+nkIGGwGv/156x
	Y1c3wudXVO/3LCWvhqspOxQ==
X-Google-Smtp-Source: AGHT+IEMfydQQxrb5qVbUYv84cM9PkRXl2Hy6YQQDXc0ZkkpggsvAOcx80HhZPB2m/3PXSX7+GY/gQ==
X-Received: by 2002:a17:907:783:b0:af9:8c1c:b9be with SMTP id a640c23a62f3a-af9902976f4mr529061166b.14.1754556922031;
        Thu, 07 Aug 2025 01:55:22 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a0df08dsm1250904166b.60.2025.08.07.01.55.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Aug 2025 01:55:21 -0700 (PDT)
Date: Thu, 7 Aug 2025 08:55:21 +0000
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
Message-ID: <20250807085521.bhs2o6wk6pe7xf5x@master>
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
[...]
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

Are we sure addr points to the folio start?

-- 
Wei Yang
Help you, Help me

