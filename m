Return-Path: <linux-kselftest+bounces-27449-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 62ECFA43FC9
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 13:56:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E3AD7A65C8
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 12:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4848268C5A;
	Tue, 25 Feb 2025 12:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ke6xQC6D"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00DB0267AE1
	for <linux-kselftest@vger.kernel.org>; Tue, 25 Feb 2025 12:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740488200; cv=none; b=gCbz6uK1fCzC3A16kePW5izg/wQ9RNHMRn3Qm3Gh9EU5eqyT1AKFENzphTNpfrSCryZ+3SmlY8RSouTzogUyQ3eRevaz6Ex66gsKjTgAtPht/qTPCec/+2PQZMrnCcbxLShrG9v35+r2E6ks2iJZY0cTwtFvdelUzEeexyYB9O0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740488200; c=relaxed/simple;
	bh=qeHqr2N7h2hbEwkQv0Vwe6G5E97ceWLeI1LIx1Yu2ZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CRoU1hYXKNj3pTBvtzG+0gKskGfy4Fms6PpvvfwAgaMI3tw73yov2imqHsKkirIfliEe6PgJlEk0d7JiOArDdEoLRXlKtkAqiGrbeWGq1YZSsyOgQ5DuOln47ggbQ+onrjAGOX+QQpYBseFNAIxzMlZrpLqot/o7gNqXoocd+gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ke6xQC6D; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-439849103c8so48435e9.0
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Feb 2025 04:56:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740488197; x=1741092997; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MC9KPLvVqWKMt0reEhfmjJu692XzkFN80RWzCGUDFJk=;
        b=Ke6xQC6Dwzf3Xr8Rlh5t/4YYHw5cWoLpDtX1wrSkbWEnPnwMVvbAZmEZ4mSfoGYXFn
         QS+JeD0oYjuzX1bFXXT7rHFJqs5mTfKH93PKdB0ivvQzx8raYzLPPm2qPkkpPqb+zoFW
         VVaxU48EljrpNC3R1Lthmv9WsiebuEBPwH/5cZFxYRQYRzWyN4rWl9QqeZFJE6mNYjqD
         QeN6oCDrTW18iv6QTUsg4pqiNQcq04BqRPl0UKR98Nx3ZMMlMGBhR9ML9HKeJ051mxpG
         KcygWzBCAklppDwfjaOtIwjutywMVWi0tsvc/1xazNRGKINFEAHVadvoAuqpAe1rQDpp
         KFSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740488197; x=1741092997;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MC9KPLvVqWKMt0reEhfmjJu692XzkFN80RWzCGUDFJk=;
        b=KQBBsFtAFLgeDH2+Frq9X33T4pcI1JNutRWhH1Njhp6TYBVgDHcM6YVgiLqM76BbY6
         XYX4Fy7m6EYq9i+BPWoofIeMCjn+22ruw60s96S1CfO2QJvUPk0+A2de4nQXFlYSCo5f
         9tBB+0RDiEv2gtz5Zpxuegl3cZTjmd/PZ7yFhb46tKxqA7c9gpRYJRLh0Mwp8AB/yA/u
         PVNGbqGoEmTGG+J80rs05zvVn6HZQSF/wHPwId5BhnlTf1ys6PPXwbGwOX6XdRgFmPCi
         skbxdj9SULkFkP6sbjPv9U++IixgtEYS8fXDAYzGEFECo4WPpGS0DkeOjcUbfIfKZfQZ
         Eg4Q==
X-Forwarded-Encrypted: i=1; AJvYcCW+k7qb1O4cKlZHhWSO+neUUdoa9LvayWo1c3rGyYDy6rt9doRSdKoCoUpid3TfhS631QUI0HgPyh1KCs7wI78=@vger.kernel.org
X-Gm-Message-State: AOJu0YydfIY4errrFtOYaHgDJivAabUEawy5vbmvRJbLCAnnguK0aOPW
	joXHYF5iz4JDGUqhhu3IfhgmNbtsvd46GMysfVwnDU6WJB8h66jHvXTnffAiig==
X-Gm-Gg: ASbGncuUv1o8V14d2V+Th5/KrEXSGjjQO9zYVEIHo9J9C/HmcE3k2EMNv+ouemeoFpj
	/AtauAtj3FCDjU6cFp8ExeoFD74UF8kILsAnPOmaGW9TbQ+Iif2wjYXP3GTnaHlpw2/SQ9oVKUX
	RnKByrJM3jeKL3TULJkNHHm174Tcm+twpj2sMf5/nhI+M9JiGVPbgjy0lrj5SEXcS5r8aPkbNdY
	bXgB5KlGFRyqs6cHJEvNKiL5E9d1nPQ513ZzTm4GflhCJCLHtj1+MpuAuckQZFZ1gOSmHSdmEQf
	MafgTK/vSLDiswdwgZa/CzDCiRrbLK8t6uUVVjwfWUFKgmJ3GyXq7tho/i1eig==
X-Google-Smtp-Source: AGHT+IHHx1tnED5DbqgakpRRi9n7AbytxVfYjoT3lvOaag4Ekssq2e8VL3NZ4DRLo24ldsb4E07AvA==
X-Received: by 2002:a05:600c:590c:b0:439:8f59:2c56 with SMTP id 5b1f17b1804b1-43ab0fa8bd4mr1345945e9.2.1740488197133;
        Tue, 25 Feb 2025 04:56:37 -0800 (PST)
Received: from google.com (44.232.78.34.bc.googleusercontent.com. [34.78.232.44])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ab156a183sm24997255e9.40.2025.02.25.04.56.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 04:56:36 -0800 (PST)
Date: Tue, 25 Feb 2025 12:56:32 +0000
From: Brendan Jackman <jackmanb@google.com>
To: David Hildenbrand <david@redhat.com>
Cc: Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Oscar Salvador <osalvador@suse.de>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@kernel.org>,
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Yosry Ahmed <yosry.ahmed@linux.dev>
Subject: Re: [PATCH RFC 0/4] mm: KUnit tests for the page allocator
Message-ID: <Z72-AP-yQ2hPwpKe@google.com>
References: <20250224-page-alloc-kunit-v1-0-d337bb440889@google.com>
 <0449ff75-0a6b-4c1e-bf12-ff052aad5287@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0449ff75-0a6b-4c1e-bf12-ff052aad5287@redhat.com>

On Tue, Feb 25, 2025 at 11:01:47AM +0100, David Hildenbrand wrote:
> > This is an RFC and not a PATCH because:
> > 
> > 1. I have not taken much care to ensure the isolation is complete.
> >     There are probably sources of flakiness and nondeterminism in here.
> > 
> > 2. I suspect the the basic idea might be over-complicated: do we really
> >     need memory hotplug here? Do we even need the instance of the
> >     allocator we're testing to actual memory behind the pages it's
> >     allocating, or could we just hallucinate a new region of vmemmap
> >     without any of that awkwardness?
> > 
> >     One significant downside of relying on memory hotplug is that the
> >     test won't run if we can't hotplug anything out. That means you have
> >     to fiddle with the platform to even run the tests - see the
> >     --kernel_args and --qemu_args I had to add to my kunit.py command
> >     above.
> > 
> >     So yeah, other suggestions welcome.
> > 
> >     2b. I'm not very confident I'm using the hotplug API properly.
> 
> Me neither ;)
> 
> Dynamically adding memory to that "fake" node is certainly interesting, but
> which guarantees do we have that some other features (page migration, memory
> offlining, page reporting ...) don't interact in weird ways with this "fake"
> node? Adding special-casing all over the place for that feels wrong. I
> assume this is point 1. you note above.

Yeah, basically this is the big downside. Changing the system we're
trying to test in order to make it testable can't be avoided entirely,
but I am also pretty unhappy with sprinkling "if (node_isolated(node))"
everywhere.

I guess the ideal approach is one where, instead of having to modify
the meaning of node_data, we just support replacing it completely,
e.g:

struct page *__alloc_frozen_pages_noprof(gfp_t gfp, unsigned int order,
		int preferred_nid, nodemask_t *nodemask, 
		struct pagelist_data *node_data)
{
	struct alloc_context ac = { .node_data = node_data };

	// ...
}

Ideally this could be done in such a way that it disappears completely
outside of KUnit builds, the interface should be private and we'd
wanna get rid of any unnecessary pointer chasing with stuff like:

#ifdef CONFIG_PAGE_ALLOC_KUNIT_TESTS
static inline struct ac_node_data(struct alloc_context *ac, int node)
{
	return ac->node_data[node];
}
#else
#define ac_node_data(ac, node) (NODE_DATA(node))
#endif

I initially rejected this approach because it felt "too intrusive",
but now that I've actually written this RFC I think it could be less
intrusive than the node_isolated() thing I've proposed here.

The most obvious challenges I can see there are:

- There might be places that page_alloc.c calls out to that care about
  node_data but where we really don't want to plumb the alloc_context
  through (maybe vmscan.c is already such a place)?

- I dunno how many more such helpers we'd need beyond ac_node_data(),
  like do we need ac_nodes_possible_mask() etc etc etc?

But maybe worth a try - can you see any obvious reason this idea is
stupid?

> So I don't quite love the idea on first sight ... but I haven't grasped all
> details of the full picture yet I'm afraid.

Do you have any thoughts about "making up" memory instead of
hot-unplugging real memory for test usage? That might simplify things
a bit?

It seems possible that very little mm code cares if the memory we're
managing actually exists. (For ASI code we did briefly experiment with
tracking information about free pages in the page itself, but it's
pretty sketchy and the presence of debug_pagealloc makes me think
nobody does it today).

There might be arch-specific issues there, but for unit tests it
seems OK if they don't work on every ISA.

