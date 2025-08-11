Return-Path: <linux-kselftest+bounces-38657-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1276FB1FFB3
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Aug 2025 08:59:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 241C61791A2
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Aug 2025 06:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE7552D8DAF;
	Mon, 11 Aug 2025 06:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lCyCzhhl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD931509AB;
	Mon, 11 Aug 2025 06:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754895553; cv=none; b=cDs/yHfXiPuvtMphx7vAS0gIcM4/4LHjtYaQgQ8pHCfuj5dMYAcbl3SD1Vqo3BrE8OU6CQrA8LdaDR4NoBME3J8XhOQEIFlIwfKEYFdMu7XLOMHLIoIeRpwT1vcCe5pYh9qIQNzHsgjB0XdBFLGwXqvJmicCiRZD+9+pGUDUrRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754895553; c=relaxed/simple;
	bh=Gjp3WKVioO/jEUNRTxP2ECZne98ObwspxbRyUdnLh+4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aaFsn9RfkHS9VUezxoCgY1OYouAx1o4S2gRZ/AzU/k1Q6RWhD/q9MEZ1zrjoVhPx0ISXqU2FQdHpm6LQ3fjJL7pokFk5U1yXmcrdKW66/7HZGGBS5ZWln4ysiyzaWlAxfkCufuCFOhuQd65WlkPguuXZPs67YUH088y5+w8Rxvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lCyCzhhl; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-71bd394a665so41796607b3.1;
        Sun, 10 Aug 2025 23:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754895551; x=1755500351; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TuOu3OMLWRZy/GrYfsj1vU+FzwQIbj3WgU0WMDegCto=;
        b=lCyCzhhllom32/t582NW8tvptYd6uz55iH89GCn6miZ1r69JlHxYuy9sTnhNt7DTw6
         k0T/jO6YEfJHYcHAgW2xkHlSUMe+O/PV5npnrJ2/5JdS4JeuQmyg5GJeZhJ8yz37a+FL
         ByzD+udHQEijxfEZzPnmouxL3CImC1+ByXCcRstQPLfiORwUdWTled6DI9LziQowQNCT
         hD5Jx4VhhD0pdvqkCPZpxDZ3QI84ChyomQkqbV9FwJ0Q4RsIx1VlE1+nwpIQcSmTAwcR
         9aspj7o6vRnX2CNEVt9xKxLBVHBjfXUh1neoXRNl+NWwzmrl2y5GU96i5tnhzhAxMCpr
         FvyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754895551; x=1755500351;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TuOu3OMLWRZy/GrYfsj1vU+FzwQIbj3WgU0WMDegCto=;
        b=IlwRQDysg77nlTRcyEy1dgz4D3ThxVKBCvY2lVhbE3lrupgALO1Bw3pgjm6LEONIWQ
         A1yuXs7czBNJICp/nz7DfSloTIrIQMIg2lOgbUATLqDGvgWthicPGBg8IGSwXcW4Wuhi
         t5KAMehMXHTlkCy30LzoJxpoghvNCoaH+EHOahe6XCgR0i26F619qUD/6xT68uRvctpG
         yrQqthFDupJEpkDqAE3+a6ZV5PDfOlyqbhZPEy/pEgaktlzSsUWJA/RsyAwQ4x3ePIfc
         oEmG6HSMUzbsV/mccWTZpILWfCbJc4ShLb8u4AueDNtzKk7C+m4QLwE6ZB50b0Elmtcv
         LazA==
X-Forwarded-Encrypted: i=1; AJvYcCUFAGOCKEyPembEMIu3HsO3K5gL6l+IjbI9yUD+Lz/2taso0FMFOJZsGqqhvYQuI+Pi2BLg4wsuwE6+nmg=@vger.kernel.org, AJvYcCUSzUsJECXJ4QhPUNJbG6a3KZGDlBYZz9qN0z2Du/81WumiB8k/tx1/8HVK07Bko+QgYwJ1w+hCBmx589T3nGzl@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0w2Hh2/vQ1W5Msq+TcJzfFzHrCvndEJ1wVEj/JVjTdqY0Ygc0
	oz7n+OcjS37jMS9IQQ6kwJGKqmbviBxgOfnUvGkS0oFecP13Q/u82ZIUiJSi0IBGM4g4nITQmuZ
	w29fqMfq+/4AFVTldwI80f1lLgyWLslM=
X-Gm-Gg: ASbGncu75M1ynd1xFh+mJdNLKiA8yfmiZCd8CBG5CcPghlGyn3fgRt80Dm5onrjsLl5
	OnD3SbIJ4987ZVFzkGYBev6x2MCQ7C5oFDr2ibDE4Ji2iFfneZjU3hOa7SjUEDWRb/n8J10Wk5B
	6P1e1PboiA5aZ6F5136Ui0nacVJg0xTrv7kbVybK9Rb1Sn526dCDRhnuBaaZM1hQQqyXgaGKvWa
	NmZM4c=
X-Google-Smtp-Source: AGHT+IEbcYjT+506lJ1E8j322xg7JOfAMpd/UJ9FVya57rTPDfeGc0w3hklgL2ebknAB2dJaYt27gaIWwQkN8hNl6h4=
X-Received: by 2002:a05:690c:868a:10b0:71b:fa04:d16e with SMTP id
 00721157ae682-71bfa04dc14mr94083937b3.16.1754895551013; Sun, 10 Aug 2025
 23:59:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250808190144.797076-1-ziy@nvidia.com> <20250808190144.797076-2-ziy@nvidia.com>
In-Reply-To: <20250808190144.797076-2-ziy@nvidia.com>
From: Barry Song <21cnbao@gmail.com>
Date: Mon, 11 Aug 2025 14:58:58 +0800
X-Gm-Features: Ac12FXxoqfvnZ6zVcvsM3WYdQubEnyeJWwkI1SyNlh9YvtyzjV1u_HW36tSML5E
Message-ID: <CAGsJ_4y23gxB+P8=WkBe+oU9j+1YDZmBUTdE2=aw40O78DA7Yg@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] mm/huge_memory: add new_order and offset to
 split_huge_pages*() pr_debug.
To: Zi Yan <ziy@nvidia.com>
Cc: Wei Yang <richard.weiyang@gmail.com>, wang lian <lianux.mm@gmail.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, David Hildenbrand <david@redhat.com>, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 9, 2025 at 3:02=E2=80=AFAM Zi Yan <ziy@nvidia.com> wrote:
>
> They are useful information for debugging split huge page tests.
>
> Signed-off-by: Zi Yan <ziy@nvidia.com>

LGTM.
Reviewed-by: Barry Song <baohua@kernel.org>

> ---
>  mm/huge_memory.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 2b4ea5a2ce7d..ebf875928bac 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -4327,8 +4327,8 @@ static int split_huge_pages_pid(int pid, unsigned l=
ong vaddr_start,
>                 goto out;
>         }
>
> -       pr_debug("Split huge pages in pid: %d, vaddr: [0x%lx - 0x%lx]\n",
> -                pid, vaddr_start, vaddr_end);
> +       pr_debug("Split huge pages in pid: %d, vaddr: [0x%lx - 0x%lx], ne=
w_order: %u, in_folio_offset: %ld\n",
> +                pid, vaddr_start, vaddr_end, new_order, in_folio_offset)=
;
>
>         mmap_read_lock(mm);
>         /*
> @@ -4438,8 +4438,8 @@ static int split_huge_pages_in_file(const char *fil=
e_path, pgoff_t off_start,
>         if (IS_ERR(candidate))
>                 goto out;
>
> -       pr_debug("split file-backed THPs in file: %s, page offset: [0x%lx=
 - 0x%lx]\n",
> -                file_path, off_start, off_end);
> +       pr_debug("split file-backed THPs in file: %s, page offset: [0x%lx=
 - 0x%lx], new_order: %u, in_folio_offset: %ld\n",
> +                file_path, off_start, off_end, new_order, in_folio_offse=
t);
>
>         mapping =3D candidate->f_mapping;
>         min_order =3D mapping_min_folio_order(mapping);
> --
> 2.47.2
>

Thanks
Barry

