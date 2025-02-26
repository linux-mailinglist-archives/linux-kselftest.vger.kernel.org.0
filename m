Return-Path: <linux-kselftest+bounces-27583-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6496AA45BE1
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2025 11:33:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C8F63A10CB
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2025 10:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AAF8226CF6;
	Wed, 26 Feb 2025 10:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LnggYE7S"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D23F258CED
	for <linux-kselftest@vger.kernel.org>; Wed, 26 Feb 2025 10:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740566027; cv=none; b=nLlXeErtjnQBLsEUvffZlUXi6F0axJKlmj8qh+yJXan6dGMW0mbvBXuvhrqdGxUc/uiY6H5O4/g3Q/GtwPIV3QP3paVPdMSZx8TOdEXGeU6/YMpB3MwGB4E/zW5TSXM39ZQn5h3+dsZzkTNY4US3bVC7CbJYxbKuya+WkClw8E0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740566027; c=relaxed/simple;
	bh=OInzV5A00n7mGPHyOTHzxDyfR7GJd4/agyAg8/xaO+s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rJu+fj2B1Dv7FYivFBr9WTYotIxxm+cmknNADNehIGQPh/ClgbHTNc4X83n1DogtlQk79qUDKVUqoh06/P4HVCj8WYLp1id1dlwAaJ96B9lOnb6Vm0jhqvFpkzZslQXe84geaGGednenCKhDhFqEWXGcQy0R3+BgOxH0kGyafbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LnggYE7S; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-471fa3b19bcso205121cf.0
        for <linux-kselftest@vger.kernel.org>; Wed, 26 Feb 2025 02:33:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740566024; x=1741170824; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OInzV5A00n7mGPHyOTHzxDyfR7GJd4/agyAg8/xaO+s=;
        b=LnggYE7SrJXEnGzjTivOYac6Yiq/z6kyifz7yIkE1B8dK0GRLp0T3rFz5yw782lipV
         OTSzueZ5zDS4vXEtoozVQRP5BLBcfNVa/6l8w/wj+rD7P+JiJnT8XCCIz4uKLyOyc0xa
         vD5HPv/ewCIRyOQV4D8P/a7rnVXxoP56dVwXFLowN+DjZTZrANxG8aQSabqv7MLT4tfV
         RQvVNPwYIB+0PikkDOqtTOy+YZrZH2CzZzKfXmr0ZQYQ0E8Xaa7R4Kx0ZAGlGRCbkWb8
         fiaC+IDBiX+lTxKVDHIP5iMWRpleFJMKphVGoCFMWsGmlops5T03Uw740Xbng8/YPN/Q
         XIpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740566024; x=1741170824;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OInzV5A00n7mGPHyOTHzxDyfR7GJd4/agyAg8/xaO+s=;
        b=AaUXm2fVuJjHWAuW5qarmg2G2nJ4fnifsyJZr3Gbuen6WwUPALGFCa0PN7nfYIKp8v
         CiOW5aJDuDfmYjMjTsRydWvztySeTYc7lyLWTs+seK32OUKt9OM4qi453faJv7lpyGhV
         9qELMj+zmlixi/9LX9EizUwayO1Xtc95e3SHbXd6k3E7pl+EGpJBBtulAjyTqkEeBkr8
         rfkMlpFB8Up6R9tffy4+GSirBjEG0Uopk/TCNqNTn1lLhiF1tI80zX4WZW5zAUYFf2f3
         QCiyq7YLt4+QAC9v1by0M9SsKuED/ORtPhASMs5RBOU8RygnwNwihjcRB9GK11bSmsh3
         kjlw==
X-Forwarded-Encrypted: i=1; AJvYcCWn5RH02710Yh19GZ9NmN5OBX9UFR02jYEj4BrMvuocku/SElk2qai2W5jDBCp7WHVD/9wJ0/Yya0GZThj3Ln8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8g1mzYp/IM8DtOYE6OGaCEwT4ZnlHyad/Kk93MDiUKMLS4fZl
	T+XAHT10iBYQV7yRJX81laTxYJ5HuIXuGBzbLwPW5Ag23oxFkr2kUNZvSToPBlOvk+/IfRpFsDp
	+gKAQnD44qGJ55eJF8f4NPh2Bsbd8R322W2Nj
X-Gm-Gg: ASbGncvY7OQjSRmHyUM+008sSHL7pyMpCokLR1KK7vFtc0Yyzk4nldUSDUIU3dWTvjx
	MN2rABuEL/78RL4uUUtz7pM584bnv5zaUS3M6NA2joSV207EI6vwhdnmhDr4MC4tgNDN93BSslx
	OGSEZgIC+3M/1NmcpudmC3ubI7MVSkgnRMA8A=
X-Google-Smtp-Source: AGHT+IF1PpaLFEiA7f+EXz6qq+cFGjDAy9aw353F05vZULOtvLZWfHJ0lyt+gtzy2bQXRNEdC1uzl1vmxroPzPbxC0c=
X-Received: by 2002:ac8:7d04:0:b0:465:c590:ed18 with SMTP id
 d75a77b69052e-47376e6ef18mr9498391cf.9.1740566024238; Wed, 26 Feb 2025
 02:33:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224-page-alloc-kunit-v1-0-d337bb440889@google.com>
 <20250224-page-alloc-kunit-v1-3-d337bb440889@google.com> <Z7y7ltOSDjamYmhP@google.com>
 <CA+i-1C31w5yjVRBLNr9b2WwghP_=Wv0+SymWKOQtG8SEszKxxA@mail.gmail.com>
In-Reply-To: <CA+i-1C31w5yjVRBLNr9b2WwghP_=Wv0+SymWKOQtG8SEszKxxA@mail.gmail.com>
From: Brendan Jackman <jackmanb@google.com>
Date: Wed, 26 Feb 2025 11:33:33 +0100
X-Gm-Features: AQ5f1JqGuyBNSN8KYcK9T7xt4yQKGTXnaeYG0DwOUWhx-q_M4BMgBpShAvdqPrA
Message-ID: <CA+i-1C2F-Wx6_6WT_m83uEmmsaiXRU3yNOTMJOpL8yTkEjZ7Vg@mail.gmail.com>
Subject: Re: [PATCH RFC 3/4] mm/page_alloc_test: Add logic to isolate a node
 for testing
To: Yosry Ahmed <yosry.ahmed@linux.dev>
Cc: Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, 
	Rae Moar <rmoar@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@redhat.com>, Oscar Salvador <osalvador@suse.de>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Michal Hocko <mhocko@kernel.org>, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 25 Feb 2025 at 12:20, Brendan Jackman <jackmanb@google.com> wrote:
>
> On Mon, 24 Feb 2025 at 19:34, Yosry Ahmed <yosry.ahmed@linux.dev> wrote:
> > > +#ifdef CONFIG_KUNIT
> >
> > Why not CONFIG_PAGE_ALLOC_KUNIT_TEST?
>
> VISIBLE_IF_KUNIT is paired with #ifdef CONFIG_KUNIT elsewhere (I think
> there might even be docs that do this in an example) so I just
> followed the pattern.
>
> #ifdef CONFIG_KUNIT -> things are consistent and you just don't have
> to think about this very much.
>
> #ifdef CONFIG_PAGE_ALLOC_KUNIT_TEST -> better scoping.
>
> So yeah, shrug. Maybe David/Rae/Brendan has an opinion.

Oh, actually I rescind my shrug. If we used #ifdef
CONFIG_PAGE_ALLOC_KUNIT_TEST, then -Wmissing-prototypes would fire for
people running other KUnit tests.

So yeah the function needs to be non-static exactly when there's a
prototype in the header.

