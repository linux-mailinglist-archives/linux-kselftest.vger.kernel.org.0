Return-Path: <linux-kselftest+bounces-38630-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13570B1F5D8
	for <lists+linux-kselftest@lfdr.de>; Sat,  9 Aug 2025 20:45:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23CBE1899FDD
	for <lists+linux-kselftest@lfdr.de>; Sat,  9 Aug 2025 18:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 883DF2BEC37;
	Sat,  9 Aug 2025 18:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fRgOKmOF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A051F1301;
	Sat,  9 Aug 2025 18:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754765119; cv=none; b=PEbs/hCfNxS5rkiaPpW0C7c80qiv9zRCpLfvX3rD/8x3g6r9YJ6fCPqovU4tlpCiR+d7t8hsfI+J5dyjK1vsB7VnN176/ssualhKYVmljyYzGiObJO9GgExbh+QZbpROfl9C8v1TC+MI4+DLCkLoxZxA20oaMVcwkt5PCTsSCVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754765119; c=relaxed/simple;
	bh=ZNd/uryG0IlirF9BmUwsd7PQAKgrbbcYk4SiTLxWx7E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ibPccG9jcC64Uc0M/poImR+eXoSjTJaDNa+zVEP6PnBd5j8i+Y5dV5TS2Y168MyDik9jUb0z9rlVcWpFDBcBKILZDN2qxgf9lT8QTHQxxBjFdQ0dlwUze+qsez5Eg3ddy0pD8OAcIvyOmSrAIcWleagqu2ZtZs4SZSAy46XyvkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fRgOKmOF; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-615622ed70fso5107904a12.3;
        Sat, 09 Aug 2025 11:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754765116; x=1755369916; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eR8zOZ3z2WcWE6RFK1IoXRDArEFQfISp1rsngDDWJHA=;
        b=fRgOKmOFXtbANoPqtk5wB4I/Z5pxwSzrPtEkdShsKGWKDqxvtI6dgSduimFQhMe5jD
         yaM2b3AgbzJVjWIaZVj2DfasXovABnj8XGLIB4aPDo0DRK761CKxnsr1F9WL5HVLv5jv
         odt5Mo7fQwMxIzfMgYCZWHf2bKGm/LgdbKgnhRs9gSM6fMTb5bh8fxkQyo7b8A+XecD0
         3gDJJ8LYQWqNJW2v+teWendQIMt5d72OtmA/QcxvHQfvCKy6OtbgN7uLZFgOxrxmjMVW
         vh2e1fQnWrPFQgDiU9TdgwGBUWqlrRBSVS3r5kRfIkJtqEZHdfL/XWaUD9oZbGKIIw7A
         9E/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754765116; x=1755369916;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eR8zOZ3z2WcWE6RFK1IoXRDArEFQfISp1rsngDDWJHA=;
        b=PXYjJCFKf0v95bPD46lRFMuXN8kTOJKt/iB9lnmKeNU7LjuYGgYjAYADCpqxL9XZrY
         JK5LU7wNyJhpUoo30NrKW0CFiUW+PKxYFKOH5ukip5BxHfadRtgu848FBHNJaso3eb3K
         C/4XLOUD9NzXs6iEm9hR1qsgOrpuZQEHR40Wmv5QXoM9CKu1GIOaRVP74FDVjlJwS4Gs
         jqnqkVdhdsdMYl4gtSaqi34/Z9LrIovVuzaVdfhOMYU7AyF2/W4ch3LKhU+evj5maBt0
         2g9Mht2kVGya3EN15lsV1LB5HG9xtYo8L0rlhtXLDYVyr5uW3yFPYjHTYm6Cf2DqrKy/
         kkJw==
X-Forwarded-Encrypted: i=1; AJvYcCVzSUNri4X0kw8KadK+6AeD5nUoXa/gdLDGWagEE+O/hHGgfoNMw6rUF4n7bjMeM3hfAP4PmbhulGRpLhYoyqG/@vger.kernel.org, AJvYcCWgiEuw7QZJtaZfBThlgyrG6hSM5Xy/1VFriQYFFfHUHWbvc6fq0DMwRpyUGBCMKkhhHFweZE80huSxrII=@vger.kernel.org
X-Gm-Message-State: AOJu0YyV2e/F8jhZ2EoOGkxIxa2zhyOPi4CRRuPaaD41TvzVM8t6M2mM
	TSMEXRkqdPa+wWdIBv7k2XHWect/E2P5mzDwhVxgnlKs9Mg6LyU//bot
X-Gm-Gg: ASbGncsbosn0wGLKwpLK120v4soie1GQDfYrnQOHIlPAaEhKPaEUnJmoLPc6+mNFHgq
	W7rpmuvmvA8aRjnWNhISW6mbfsRCpL51FElM1r3cEfyz45JWMh7SDKqS/CA2wd7avZhkl7PSXRZ
	FiAnWpFFaXzSGALigyXy9N/hE1Idt5D1UYoIK+AiEjLe3s0TF+Ltu4cth5aySmB9JxjMBu0VleI
	9RLl4g1NS10lHWNcmpby9fyStHlE5MkM26Vc0jExClCj4E5x7e1NdPg1bTD/MVMTZyP+Jmwu4RN
	+/4ZcVlp0YBnjZBf/Ztrs+0p/0orKznmGbwVceNRjQWMTXh7HOIeXzyVoeuBLjnqw/VDIgf1yCo
	M/LQ+RoZslYU4wZLTYgdCPQ==
X-Google-Smtp-Source: AGHT+IGSLKkdoXK2TOxZXhsboglDsLFIiyNrDvo4bkRRZ/lXamgG7y7rXWOoHMoxfnH/vEriZPA3Jw==
X-Received: by 2002:a17:907:3c84:b0:ae3:bf5f:ca20 with SMTP id a640c23a62f3a-af9c640ed5amr594511466b.8.1754765115775;
        Sat, 09 Aug 2025 11:45:15 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a21c076sm1676437966b.102.2025.08.09.11.45.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 09 Aug 2025 11:45:15 -0700 (PDT)
Date: Sat, 9 Aug 2025 18:45:15 +0000
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
Subject: Re: [PATCH v2 1/3] mm/huge_memory: add new_order and offset to
 split_huge_pages*() pr_debug.
Message-ID: <20250809184515.sd2qrwrae4a5bv4r@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20250808190144.797076-1-ziy@nvidia.com>
 <20250808190144.797076-2-ziy@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250808190144.797076-2-ziy@nvidia.com>
User-Agent: NeoMutt/20170113 (1.7.2)

On Fri, Aug 08, 2025 at 03:01:42PM -0400, Zi Yan wrote:
>They are useful information for debugging split huge page tests.
>
>Signed-off-by: Zi Yan <ziy@nvidia.com>

Reviewed-by: Wei Yang <richard.weiyang@gmail.com>

-- 
Wei Yang
Help you, Help me

