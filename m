Return-Path: <linux-kselftest+bounces-27584-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2571DA45C31
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2025 11:53:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7B5E18904EF
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2025 10:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A80E24E00F;
	Wed, 26 Feb 2025 10:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="okv33nhA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1823F24DFFC
	for <linux-kselftest@vger.kernel.org>; Wed, 26 Feb 2025 10:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740567177; cv=none; b=VW+WgKsWafq3/4K9PQdQ1znj72U1RTIK90tHHxoPcY+O1d4bTcUlE52HCqIaVIi76D+v1cSWFnqtHQAPzj+9RZe12Ug8e8qoHgv+CwH9CfBmMwo4dGDRKRhNtuptoj88+zELEX01LmwI3MqMW8773dZUykD5pjT8rVa6N+Tz17g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740567177; c=relaxed/simple;
	bh=x5xg3LwibJXQQaaKDM6VQ+lAP9lfPVdOz0gIsQg4kuE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AwwdwzIdLk7Nr+LSUM63Wlc4nHwURmya/DvmDmEeFRzzyKTn0hk39bfhGiaGQuVF8ePd4OPFin3fjHg7XR3M1P1Sam2Sga3xZX+I13rjeyAGZ5ze5hcJwZzxPnnATzstt1ioEkHku6FOb8kINYTawe4O7h9yBbDPLWVu8da5sGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=okv33nhA; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-471fbfe8b89so295011cf.0
        for <linux-kselftest@vger.kernel.org>; Wed, 26 Feb 2025 02:52:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740567174; x=1741171974; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8k9ussjgNfo7XH+19sy9pLzES4opNKoTTPxfbK8Va7w=;
        b=okv33nhAEkxkWcFJtilxgY3BMaorr/cKC33d784UZ+ZTn4u5GpgwRHnm3LqrRiejUr
         Ms/iG2teZxE32cpAhf/uTfZFYBHPuF3PQNEt0cF70Z4GBFlLuENSaSJnkeEVdLykFLn4
         jfnC+54VsvoI6kmwkmsgANWQ+epaRT2yAj5at8wGbhvNk7vlGCbjnX36zCxEIZ4AjMg4
         XYZ9EC1Q2l4C5S4lbaLR5CV2hTSa6uZS4rMYhlhl+zMM5N2GWxv8Z8ziqc9+mheeynfJ
         u1IxtkGkdHGCOh3wHvhJc3g86EAeFyqVtHXSm8UzXnSF6/dTl2ePQ3S0SC6GKHgLExPL
         vaCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740567174; x=1741171974;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8k9ussjgNfo7XH+19sy9pLzES4opNKoTTPxfbK8Va7w=;
        b=oRuTKvRmgZKFOPIEqzkoKPQdpEia0obNns7s4jPjzCynJKLfVFSc39nDMmXilKHoh6
         6tyywYnmsZCQdwmLW8xupe/rBYb0BBBuHAdGJFgHymiPeQJ+aBagLLO+N9iEx/RLJyE5
         7t2uqqIPFGQ/VuDtVa83NmVmf7g0yxBVfsAS8kzV5ugonBuX4ZzdAPT5G80e8oo2vCL2
         SNG67W88jzlAJZa0s5Z2PAXoTxb4SuSCGZGG3LxpE+bsucPref9JMk2WUeG4H5QAjaZD
         Ma1FDtlHMwulUkmAeynOuJHrrFH/CVbIJYP/10aSqUli0pURAcCca00F/IoNXGKBmSqw
         T0tA==
X-Forwarded-Encrypted: i=1; AJvYcCWXE6u1sGYAgcZIJ2qKl7LTm4qNhB6IpX7cLHieSs+yjhhLvaYi4YO3J2x2Qejs5nwF+AtAUtchJWu22bHtz2w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxV2KNGm8qx0ewBMUyUZRZDUkpVTpjSjBtLgaJLtPmADriTndVL
	WepBa+dVg3CIBwxTgNyAnbPXW0dUNVktoTm9YuOBxypr82d/hoDB1T2+9I0UL4/700wvHkjwVNr
	1eolM6tGI8s64YsrqGgWTPUMVtCuHavA7F8qrvOsQ/qOt6P2OVR+valo=
X-Gm-Gg: ASbGncunYZJdK/ysE6VD6VdxVKyEROQ9woXrTnaHOWOy5LieBQOe8k1VWcOTBJKYQ77
	oZFwn5/nURY0hTn7b9Lofagou0Ze7cF2peeHsbeeWzVTJHLjIagRbrKltnXDkJgket9EO56LbbZ
	G4rHFWw371lhTyqDYvtAhvoMy8p8cjblwMCMo=
X-Google-Smtp-Source: AGHT+IEtUNEH5PpKZRBVaacFBgRUGjAhw23RRBB5/3TVjGiyJAVndyaT1T40ETOgSGf0gVSz9gyrvjommoMUte+jJtQ=
X-Received: by 2002:ac8:5a10:0:b0:471:fefc:f002 with SMTP id
 d75a77b69052e-47376e81cf3mr8973501cf.9.1740566831709; Wed, 26 Feb 2025
 02:47:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224-page-alloc-kunit-v1-0-d337bb440889@google.com> <20250224-page-alloc-kunit-v1-4-d337bb440889@google.com>
In-Reply-To: <20250224-page-alloc-kunit-v1-4-d337bb440889@google.com>
From: Brendan Jackman <jackmanb@google.com>
Date: Wed, 26 Feb 2025 11:47:00 +0100
X-Gm-Features: AQ5f1JrJDmTOqjWilOWeguYEmp9d0N0gM7ZtyDHGC2VpER2YE2U_sG3dR8rzJXg
Message-ID: <CA+i-1C2C4GSd3Jhw56WfccKizoeLj4ychCz2BpOU6AwESjzSyg@mail.gmail.com>
Subject: Re: [PATCH RFC 4/4] mm/page_alloc_test: Add smoke-test for page allocation
To: Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, 
	Rae Moar <rmoar@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@redhat.com>, Oscar Salvador <osalvador@suse.de>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Michal Hocko <mhocko@kernel.org>, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Yosry Ahmed <yosry.ahmed@linux.dev>
Content-Type: text/plain; charset="UTF-8"

On Mon, 24 Feb 2025 at 15:47, Brendan Jackman <jackmanb@google.com> wrote:
> +static inline struct page *alloc_pages_force_nid(struct kunit *test,
> +                                                gfp_t gfp, int order, int nid)
> +{
> +       NODEMASK_ALLOC(nodemask_t, nodemask, GFP_KERNEL);
> +       struct page *page;
> +
> +       KUNIT_ASSERT_NOT_NULL(test, nodemask);
> +       kunit_add_action(test, action_nodemask_free, &nodemask);
> +       nodes_clear(*nodemask);
> +       node_set(nid, *nodemask);
> +
> +       page = __alloc_pages_noprof(GFP_KERNEL, 0, nid, nodemask);

Oops, it's ignoring the gfp argument here.

> +       { .gfp_flags = GFP_DMA32,       .want_zone = ZONE_NORMAL },

And with that fixed, it becomes clear DMA32 allocations can't be
expected to succeed in this zone setup.

(Anyway, it's a bit of a silly test regardless, just something to
illustrate the KUnit idea).

