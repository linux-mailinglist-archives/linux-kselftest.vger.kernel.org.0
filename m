Return-Path: <linux-kselftest+bounces-27607-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDBD6A45EED
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2025 13:27:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA85018895AF
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2025 12:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07B5621D3E7;
	Wed, 26 Feb 2025 12:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Vxns5nMo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4450113D8A0
	for <linux-kselftest@vger.kernel.org>; Wed, 26 Feb 2025 12:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740572513; cv=none; b=hkFkWNmgHhtpaiQfnWsM2AfSOnGruqFk0QRI3CEzbaWsUFV9VgHAMrjWK0sjpk2c3JlXjz/8TlKxgd2abgKdYlybenpP739JdTflYc+wUQFNMvHHGQ9jiyg9wNimD3+cdlwdih5qNNAO3X6u4Wruau40KNGE6txzKyKF8ffFXBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740572513; c=relaxed/simple;
	bh=AwiFrWtV+715zMILrRkjE/bS7f4TFBxTFpu/weZEttM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ckd2kvyvPdCxJPF9tpf1Rwetwre1nPUEBm6f20IL9oeZZ1i8MXpwauckiPujdYbUvnaOiHjCm350c/6CZgfhiJbaBuBGL3DgpQvjr9yAkmHmv5G//pZ0NGbxEejWPEcC5YJ8Q6n+/fKNqWSmy53C6M0f34s1ZvZuGM1VXZS8Cgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Vxns5nMo; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-472098e6e75so238881cf.1
        for <linux-kselftest@vger.kernel.org>; Wed, 26 Feb 2025 04:21:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740572511; x=1741177311; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FZ8fLnFs5jC511KEwwc78QvRtxNOftae4m622VwEotA=;
        b=Vxns5nMohq2469Yc/t3p9uzRVo1FuK2/q9QgWRJamyKImSY2r4GoG1MVpRv/WWkOQe
         Cn4mw9TSk1116/mFRffkP+uGA/dNNiJJJtmdyShWDcGzCGCBPVEtDhxbjyPeD5Y3JQ/V
         xk2TvBCwF35h3Hmbj2gWlm6Zh2bj89mgZRhi7ABvc3j4EMNX5yB1szg1UOpLxagesKXk
         Da4ZoBZ7/URkUddjVt2UcUkovCCg410wDs3OKOFnshELdyQQwD3GuXVY0t3SBCItrs8p
         Z5H7viuQP4UF06WudfhMyTX00WORC5Ww6ZKL5JWPYI2H2Ng/iNbiNghqc4AlWichLdOD
         eIJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740572511; x=1741177311;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FZ8fLnFs5jC511KEwwc78QvRtxNOftae4m622VwEotA=;
        b=XEMM5Vy58NnbHee8vxlhACjvawY2Lx9jJ9nEWCf9yyDaGuGa3uzuhJ9dpBNN06ivNc
         TDX7M1APTVEM84AZ/1sKuH4+CkndfOnUb4MX/cgx+uKKlSdduBuwysrpw1d15gbtFreM
         +lAU6Ggww84kUxZWVV8sZf5225L2XyV1d8+LcjX/GMnKH3DaqQXPo/r1w8kgu06U3uno
         q/CTWDylJz5V+ES8VPlaA2kcZC5YxakFUWg2DZ0xdO4dTKKbhcnUulM8lyqM5Z6wrAbF
         TiVQNtiHizBAcYGsvn9oAZmG6nVZ+TqOB9S0xn/ICt4U/JNF5efegY/vyZ2eHgHgJAvh
         7gyg==
X-Forwarded-Encrypted: i=1; AJvYcCX1s3KZCkE96BXXK6DFBd5IU6gKgastKfUcKi8OzXt5jhVc/3J69DG49+phuuJmjvlNt2y+Api0vU4XM47UHrE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjbZVDmifoFvcEb/lfWVpLQ91ZFzsqcKfTry+PWFuxN33u90MS
	WMyE4lkt1WUIge5SDt8fTy5orzERF4eSzkSbgKha0HcZ4o2i27fV99iwtN4IL8F6Hgc09jcG5eu
	vzmB5y+ODtL6i3RocG7+fZX7Bx2Oi4nupbL1o
X-Gm-Gg: ASbGncue7qNVLdEJs6ScMMAAmSUGPaJNjIe7LKO+e5i7LhwnI3JvsaCCWzPA7JM7TL4
	mKNXq/vs20op3b0LYntTFvXNJw8yVNsuMV9l9FzA22ja0uSDTGdLBIxy0cWoZb1oLLc8e9IA3zB
	6ylgcAEBuPTO7u6kcrJYuGWxhtBA5nHnlqw6E=
X-Google-Smtp-Source: AGHT+IHhkPpVrAfcuu6cQ99DaZetDklozQpTm2/0R7nz9+TlVkUIb9LVAMa4c37TFqY7rDF6/NSPiYVd6iEl3BowJcw=
X-Received: by 2002:a05:622a:1806:b0:46e:1311:5920 with SMTP id
 d75a77b69052e-47376dd1d49mr8958801cf.0.1740572510952; Wed, 26 Feb 2025
 04:21:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224-page-alloc-kunit-v1-0-d337bb440889@google.com>
 <0449ff75-0a6b-4c1e-bf12-ff052aad5287@redhat.com> <Z72-AP-yQ2hPwpKe@google.com>
 <657f10ed-4e82-4048-98ab-1c4b65349298@redhat.com>
In-Reply-To: <657f10ed-4e82-4048-98ab-1c4b65349298@redhat.com>
From: Brendan Jackman <jackmanb@google.com>
Date: Wed, 26 Feb 2025 13:21:39 +0100
X-Gm-Features: AQ5f1JpRBblxfE48EKs85Q8pbMMgiuSClFK4hMJuxnVUG4HT_JiUqeb3ib6VHjM
Message-ID: <CA+i-1C01x3CUf_pVEZCmr-rWV26-JZoRoF_uBkchOhobraKGvg@mail.gmail.com>
Subject: Re: [PATCH RFC 0/4] mm: KUnit tests for the page allocator
To: David Hildenbrand <david@redhat.com>
Cc: Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, 
	Rae Moar <rmoar@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Oscar Salvador <osalvador@suse.de>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@kernel.org>, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Yosry Ahmed <yosry.ahmed@linux.dev>
Content-Type: text/plain; charset="UTF-8"

On Wed, 26 Feb 2025 at 12:52, David Hildenbrand <david@redhat.com> wrote:
>  > > It seems possible that very little mm code cares if the memory we're
> > managing actually exists. (For ASI code we did briefly experiment with
> > tracking information about free pages in the page itself, but it's
> > pretty sketchy and the presence of debug_pagealloc makes me think
> > nobody does it today).
>
> At least when it comes to the buddy, only page zeroing+poisoning should
> access actual page content.
>
> So making up memory might actually work in quite some setups, assuming
> that it will never get allocated.
>
> The "complicated" thing is still that we are trying to test parts of the
> buddy in a well-controlled way while other kernel infrastructure is
> using the buddy in rather uncontrolled ways.

Thanks, yeah that makes sense, and I agree that's the hard part. If we
can design a way to actually test the interface in an isolated way,
where we get the "memory" that we use to do that is kinda secondary
and can be changed later.

> > There might be arch-specific issues there, but for unit tests it
> > seems OK if they don't work on every ISA.
>
> Just pointing it out: for memblock tests (tools/testing/memblock/) we
> actually compile memblock.c to be used in a user space application,
> stubbing all external function calls etc such that we get the basics
> running.
>
> It'd probably be quite some work to get page_alloc.c into a similar
> shape, likely we'd have to move a lot of unrelated-for-the tests stuff,
> and think about how to handle some nasty details like pcp etc. Just
> wondering, did you think about that option as well?
>
> The nice thing about such an approach is that we can test the allcator
> without any possible side effects from the running system.

Yeah Lorenzo also pointed me to tools/testing/vma and I am pretty sold
that it's a better approach than KUnit where it's possible. But, I'm
doubtful about using it for page_alloc.

I think it could definitely be a good idea for the really core buddy
logic (like rmqueue_buddy() and below), where I'm sure we could stub
out stuff like percpu_* and locking and have the tests still be
meaningful. But I'm not sure that really low-level code is calling out
for more testing.

Whereas I suspect if you zoom out even just to the level of
__alloc_frozen_pages_noprof(), it starts to get a bit impractical
already. And that's where I really wanna get coverage.

Anyway, I'm thinking the next step here is to explore how to get away
from the node_isolated() stuff in this RFC, so I'll keep that idea in
mind and try to get a feel for whether it looks possible.

