Return-Path: <linux-kselftest+bounces-32094-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F7E1AA644A
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 May 2025 21:50:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C78516BC16
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 May 2025 19:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF9A723507B;
	Thu,  1 May 2025 19:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bpFTZwi5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 316D623505B
	for <linux-kselftest@vger.kernel.org>; Thu,  1 May 2025 19:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746129008; cv=none; b=GbnNx7agZbnhtgFFVeZHZ3mtfqaRbQrhOjAXGtbL60VAnf5rhHVIMeAi+DGPm/UTbARRoetkOAntYTZR9PR3sGp09HO21sXlbxumJcWJ0zJTuxUMCuc2gfcUSLjGwQ9t3BAjrufkNxZvtmVHi87VqG7FyLWsybePzW1HhEdfzYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746129008; c=relaxed/simple;
	bh=2+apnvaLBiIzvCpdS7UmoaeaZD+fLMfXuixakTq8zyk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ttDioLIlvsytTqqdKAzQrIBi6oyk4mf7UYMWtJorXkwtJS7uE51njZyLk47ebeVLe8+XlX6y7eQ3DTaXuAb13o3Pq3JFkXP0mdfU/5EvAgfYB+aX9dMY3LQijkNgW7/9OBAlWV5VxNyM5/G8gic3G/Tk3aArCg+wI8ThUylVj10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bpFTZwi5; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-227e2faab6dso10147325ad.1
        for <linux-kselftest@vger.kernel.org>; Thu, 01 May 2025 12:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746129006; x=1746733806; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5WkPY+IyOhaPmE7ksJuei+YjVRdCjQvuKQAGefphhn0=;
        b=bpFTZwi50S7LXvNlzOnQyeJuZ3GZGCohxBKXiVlskaDx/TglZ6YLxjgD5TbjwYg2OT
         1vnxEC0B8DsTpdb983vd5QpSGyvSbLC+SNQAxp8ng66soqc2wq0fCcsGFI6hxHs1iPsX
         p6MBNFfFmKMNp7tYdpNqwiVKJV6PwAupUIwgbPKsb0jPIy+mbE9O1ypO/6nKS7xyh7dX
         HITdMRVW9o6/OpFntqpsZTb5khSgDcbAZYj9DQUNo7vIaUhCJjD9BRz8MGLn36u6tGAH
         PjM2TOBNxUJf6KbK49spwKpvFHGv46S3Sxg07b2CeQjefTHSNjsFUN/tr3nNPhfNPmGr
         AWpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746129006; x=1746733806;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5WkPY+IyOhaPmE7ksJuei+YjVRdCjQvuKQAGefphhn0=;
        b=B2I6rWJfDBCBBOsqukDvGuDaWKhM5WVV/qt14exJ7q5jMFK1rIcEWafEQ614kolUG3
         kVRNnAQ5P8P31aTPg1xPjnmPTg07+Dychk4xwXNtS16yA6Bd+kIKg7WF7vq2fvU3Gutt
         s0dZUPaz3kCqFUd75L8yZBJobh18e7tdTiPD3UXqzVfMeDA5Bfjq2ZgcGLz8SXYkigcc
         EjzcNB3a7cv3tEX3Dzr8DjXiKKOiPfvoWH52N0sL5Z48NSgcs5MKqkPuASlMACivdsV3
         S7Y3nomzqvKc8YwL+59yBg2h3LywQZATICrV7pbJn2x/0nP5tMjDt4DyO8aYcLlqyF44
         Hq3g==
X-Forwarded-Encrypted: i=1; AJvYcCUsssj6I0u3+AqtulUsvAxxbRax2KX6N3pEWk0vdylw8L2lG3hUScduWNeSaiNxHxPJDWtH6EgqoRoSYeCp/fg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5pxVURYzH8FGd0Lx84rqztbSDbqjGie3CKzZ9DMJ7qpvKi5tZ
	6xbLB2eVJtYnNaLh4Euz0MFGkxVqF/8kQawT1WajMqfaQdCP+Ke8Py35e7h3Bpjz+whTg8C3Ire
	enw==
X-Google-Smtp-Source: AGHT+IHPnH1hW0IfvKQ+lBW/azDi6UujtOpIW5dmyw0EC5ljOGt6t59+v/zFX71H5UcxugE1fcSMml30hc0=
X-Received: from pjbsq5.prod.google.com ([2002:a17:90b:5305:b0:308:6685:55e6])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:cf0c:b0:21f:2ded:76ea
 with SMTP id d9443c01a7336-22e103b4341mr4441965ad.36.1746129006451; Thu, 01
 May 2025 12:50:06 -0700 (PDT)
Date: Thu, 1 May 2025 12:50:04 -0700
In-Reply-To: <20250501124646.GC4356@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1729073310.git.lorenzo.stoakes@oracle.com>
 <c083817403f98ae45a70e01f3f1873ec1ba6c215.1729073310.git.lorenzo.stoakes@oracle.com>
 <a3778bea-0a1e-41b7-b41c-15b116bcbb32@linuxfoundation.org>
 <a6133831-3fc3-49aa-83c6-f9aeef3713c9@lucifer.local> <5b0b8e1e-6f50-4e18-bf46-39b00376c26e@nvidia.com>
 <20250501114235.GP4198@noisy.programming.kicks-ass.net> <20250501124646.GC4356@noisy.programming.kicks-ass.net>
Message-ID: <aBPQbNlccOPoS5Nu@google.com>
Subject: Re: [PATCH v3 3/3] selftests: pidfd: add tests for PIDFD_SELF_*
From: Sean Christopherson <seanjc@google.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: John Hubbard <jhubbard@nvidia.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, Christian Brauner <christian@brauner.io>, 
	Shuah Khan <shuah@kernel.org>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
	Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>, pedro.falcato@gmail.com, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Oliver Sang <oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"

On Thu, May 01, 2025, Peter Zijlstra wrote:
> On Thu, May 01, 2025 at 01:42:35PM +0200, Peter Zijlstra wrote:
> > On Wed, Oct 16, 2024 at 07:14:34PM -0700, John Hubbard wrote:
> > > Peter Zijlstra's "NAK NAK NAK" response [1] last year was the most
> > > colorful, so I'll helpfully cite it here. :)
> > 
> > Let me re-try this.
> > 
> > This is driving me insane. I've spend the past _TWO_ days trying to
> > build KVM selftests and I'm still failing.
> > 
> > This is absolute atrocious crap and is costing me valuable time.
> > 
> > Please fix this fucking selftests shit to just build. This is unusable
> > garbage.
> 
> So after spending more time trying to remember how to debug Makefiles (I
> hate my life), I found that not only do I need this headers shit, the
> kvm selftests Makefile is actively broken if you use: make O=foo
> 
> -INSTALL_HDR_PATH = $(top_srcdir)/usr
> +INSTALL_HDR_PATH = $(top_srcdir)/$(O)/usr
> 
> 
> And then finally, I can do:
> 
> make O=foo headers_install
> make O=foo -C tools/testing/selftests/kvm/

This doesn't actually work either, because for whatever reason, the selftests
infrastructure uses OUTPUT, not O, for the output directory.

And the whole top_srcdir crud doesn't work if O/OUTPUT is completely out-of-tree,
e.g. I use absolute paths that have nothing to do with the source tree.

I am more than happy to support any cleanup of KVM selftests, but I've more or
less given up myself because so much of the ugliness is inhereted from selftests.
I've resorted to hacked wrappers to make it work for my setup.  E.g. I force
KHDR_INCLUDES and INSTALL_HDR_PATH so that make doesn't try to grab usr/ files
from the source tree.

