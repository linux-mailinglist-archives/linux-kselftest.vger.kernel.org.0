Return-Path: <linux-kselftest+bounces-39338-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB648B2CF89
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Aug 2025 00:53:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1C453BC538
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Aug 2025 22:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86D80239567;
	Tue, 19 Aug 2025 22:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="VRxHnEG0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D29E236451;
	Tue, 19 Aug 2025 22:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755643946; cv=none; b=O+UHysLTbc/CharAK/lOjEPMRAeUxg6gz5BkMflyIyr9PCd0sXUzoMPhlmgpBnGiGSXF6i2uY1/Zkro3QRyzm+wDHxLQ2Vt3O18TQNJ82vGpLrsJUS0W+evYr/lblJn1hIzghrnBxk1aA3ToFPc/U1MSrPOv4fYpngtqqbowcVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755643946; c=relaxed/simple;
	bh=VHQSLjKvrE7HNYDGcF9hXuERvtRcIH2r8IoBLnp3tGI=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=X30n97edG0zn2Ya8JS+CWuRzlwMcv8Lw1kgEemXo5UluXA8MO17bLcqq47lboz5XKMNRI9UD5GsYkGqgBbmCCojvb9+PWG6RLsftCVo/KjEFjMhAJqy75j5T4s9ASMy54BcesRF1NNiG0e4r/Aal/KMhBDKRJvbBzT4q7EC5jS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=VRxHnEG0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F330CC4CEF1;
	Tue, 19 Aug 2025 22:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1755643945;
	bh=VHQSLjKvrE7HNYDGcF9hXuERvtRcIH2r8IoBLnp3tGI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VRxHnEG0v+ow/6aDnDx9elsJSvUiowJJ8lN6T/rQnlpoiVhnpwkQciMdIi1zv7RGi
	 JjRDJ+b5lNRiClIOfVFV9zJEGb4tyLGmOugHSddO5s/H/Xv/WdbI/U9GjhEUmqdAYU
	 IYxp75U+ahWCvfr+9L94JLCV8JuGzpMCyjjDGXrA=
Date: Tue, 19 Aug 2025 15:52:24 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Kevin Brodsky <kevin.brodsky@arm.com>
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>, David Hildenbrand
 <david@redhat.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan
 <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Jason Gunthorpe
 <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>, Peter Xu
 <peterx@redhat.com>, Leon Romanovsky <leon@kernel.org>, Zi Yan
 <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, Nico Pache
 <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>, Dev Jain
 <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, Paul Walmsley
 <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
 <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-riscv@lists.infradead.org, Shuah Khan
 <shuah@kernel.org>, kernel@collabora.com
Subject: Re: [PATCH v2 4/8] selftests/mm: Add -Wunused family of flags
Message-Id: <20250819155224.23fe3d79896e269bd9e27d04@linux-foundation.org>
In-Reply-To: <57c816d6-a9ba-47c9-8f40-3978580b7f67@arm.com>
References: <20250731160132.1795351-1-usama.anjum@collabora.com>
	<20250731160132.1795351-5-usama.anjum@collabora.com>
	<57c816d6-a9ba-47c9-8f40-3978580b7f67@arm.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 18 Aug 2025 10:16:35 +0200 Kevin Brodsky <kevin.brodsky@arm.com> wrote:

> >  # Avoid accidental wrong builds, due to built-in rules working just a little
> >  # bit too well--but not quite as well as required for our situation here.
> >  #
> > @@ -35,6 +34,7 @@ MAKEFLAGS += --no-builtin-rules
> >  
> >  CFLAGS = -Wall -O2 -I $(top_srcdir) $(EXTRA_CFLAGS) $(KHDR_INCLUDES) $(TOOLS_INCLUDES)
> >  CFLAGS += -Wunreachable-code
> > +CFLAGS += -Wunused  -Wunused-parameter -Wunused-function -Wunused-label -Wunused-variable -Wunused-value
> 
> -Wall implies all of these except -Wunused-parameter (at least according
> to gcc(1)).
> 
> As to -Wunused-parameter I am frankly not convinced it's worth the
> hassle. We're getting 90 lines changed in patch 6-8 just to mark
> parameters as unused, in other words noise to keep the compiler happy.
> It is not enabled by default in the kernel proper precisely because it
> is so noisy when callbacks are involved.

Yeah, we rely upon unused parameters in a million places:

#else
static inline void some_stub_function(type1 arg2, type2 arg2)
{
}
#endif

