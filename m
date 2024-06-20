Return-Path: <linux-kselftest+bounces-12362-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C16F911337
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Jun 2024 22:30:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADFDA1C21E0A
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Jun 2024 20:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E443A46525;
	Thu, 20 Jun 2024 20:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h7noAxW7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A1238FB9
	for <linux-kselftest@vger.kernel.org>; Thu, 20 Jun 2024 20:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718915433; cv=none; b=ethw+jJ2rLOrvrrUXh0fbesCufvBzu44ONiijuZXlMJUsXglIWJdtm8E2frUq+en/vq1/osPyI5uhy0rP8GqngctFNrtAnMDnBDtSYr9zw/N6iYMAiZ5KToNjH3gF/BzsrNrP5ekY1xyf3Tmp/HXR7zePVlmKH0wn+dzYafZb7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718915433; c=relaxed/simple;
	bh=+DcBwBWZGYsDodZL/Y2GSfDlItZ6xAMPG7ESuqXwD3Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=X3NUPiAjhvwTLa3aTOgm7vcPq2Gx9E4R77KjQoyaQ4GII1CNzxkTKY5bq5yJxcVr3V7XuoMNLRIZuHrYfrlggEhanryPZzRwDPd9RBFPw/WXxtpYwDv0LSaxTodQsDp5gII8MY5sVj9yAs/LdxciNz6ydH6sgyK1V2x7gxgm+dI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=h7noAxW7; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dff1bcbc104so1977657276.2
        for <linux-kselftest@vger.kernel.org>; Thu, 20 Jun 2024 13:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718915431; x=1719520231; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xErkJFtS8pAZxrsiKGOWzCS+kBI6/sMQ5JqWLp2DsFQ=;
        b=h7noAxW7WKUBzCrlhbbRRBh5FMJPBkPfRNBWpj6qxZVJ5RSJsk71JHdkoA/SQBAk84
         MKr4ynHj64FLj5SwUM/Utbsk0lVCBKg6C1qui1Mm3SETpFGdDUK1fFtW47yx+Op2lVpc
         yJsdjvTh+Dks0P32RYacgxNnd6UwOffwZJ9EYxAgQ4GA9L4fNvq4oxl7XFCRR01Eeu1k
         Kxlf6eEYkc6/l5SZe6EfsnHa/QzLHRF6pCI2sQQNjt5LVH65t+CojDZ6nt9ikAMAOK7i
         rGkkdWwtZd5fylUBSF5lxohYFJSJYrtriatRCZsp69Gc/41WSLQAfxfiEQBpL9WhkSK4
         TVkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718915431; x=1719520231;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xErkJFtS8pAZxrsiKGOWzCS+kBI6/sMQ5JqWLp2DsFQ=;
        b=BSqmhwIR90m1Rzf8rwp+DoCcpnDEJgHzvUfZA/K0gRwSnzPDSmDIxlmqVkM/to1Fsu
         /fUSAaheTNJjAjMGGM8REv0ICI6nt6ujEA2yEDUA8DcXoL+q7TY5iJ3Xv2gsFHc35lVz
         bqBBoQtaXQoJKurseE4JAl4JrX+ge0VIMEjrllDwwUbt+Sbye7lqh6x6BrKjVnbPNrCe
         bWntYNvJduqUWz+17Z9daEfio2V+NIivxztnAUi9WbeTOPLrtO3RdWQEVBAlHfNh2w/8
         gbzssqmF8mOSDZUJYYSiZaRMduzZ/Zl3luu1d5ZLZSVatS1pL06m+65h9F9PeUGVGEFx
         yVZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUEugtgp/Olpt0L0osSLe0s9JZgIxXVOl+7T+OtdMVooYDrMy0zguA5REthSbuNRjRNsEkQyxuqBmmmDyp/R2Mz8kfoBbGTG+fRz6EbUVhF
X-Gm-Message-State: AOJu0Ywb23mpItuSOVbwpmY2LSS8WQKmYsmO1zzkztCZHyDDSsAyjL76
	jlLowDZLeYvEQ4EVAkC4hWWSWlDVQvlF7p101wgZvSu9R0EReZXRfR/1/YU0HP0Kjnf/awR3qu1
	DIQ==
X-Google-Smtp-Source: AGHT+IH+qzaTVuDFz4vV+UPf7kAV7X+gFLVb8FVXbaLwLuHspIscNuw5GWE2VrrHWfEenP649+wJpEFjVek=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:1007:b0:df2:eaac:d811 with SMTP id
 3f1490d57ef6-e02be2301e5mr447972276.10.1718915431251; Thu, 20 Jun 2024
 13:30:31 -0700 (PDT)
Date: Thu, 20 Jun 2024 13:30:29 -0700
In-Reply-To: <66a285fc-e54e-4247-8801-e7e17ad795a6@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CA+EHjTxWWEHfjZ9LJqZy+VCk43qd3SMKiPF7uvAwmDdPeVhrvQ@mail.gmail.com>
 <20240619115135.GE2494510@nvidia.com> <ZnOsAEV3GycCcqSX@infradead.org>
 <CA+EHjTxaCxibvGOMPk9Oj5TfQV3J3ZLwXk83oVHuwf8H0Q47sA@mail.gmail.com>
 <20240620135540.GG2494510@nvidia.com> <6d7b180a-9f80-43a4-a4cc-fd79a45d7571@redhat.com>
 <20240620142956.GI2494510@nvidia.com> <385a5692-ffc8-455e-b371-0449b828b637@redhat.com>
 <20240620163626.GK2494510@nvidia.com> <66a285fc-e54e-4247-8801-e7e17ad795a6@redhat.com>
Message-ID: <ZnSRZcap1dc2_WBV@google.com>
Subject: Re: [PATCH RFC 0/5] mm/gup: Introduce exclusive GUP pinning
From: Sean Christopherson <seanjc@google.com>
To: David Hildenbrand <david@redhat.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Fuad Tabba <tabba@google.com>, 
	Christoph Hellwig <hch@infradead.org>, John Hubbard <jhubbard@nvidia.com>, 
	Elliot Berman <quic_eberman@quicinc.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Shuah Khan <shuah@kernel.org>, Matthew Wilcox <willy@infradead.org>, maz@kernel.org, 
	kvm@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	pbonzini@redhat.com
Content-Type: text/plain; charset="us-ascii"

On Thu, Jun 20, 2024, David Hildenbrand wrote:
> On 20.06.24 18:36, Jason Gunthorpe wrote:
> > On Thu, Jun 20, 2024 at 04:45:08PM +0200, David Hildenbrand wrote:
> > 
> > > If we could disallow pinning any shared pages, that would make life a lot
> > > easier, but I think there were reasons for why we might require it. To
> > > convert shared->private, simply unmap that folio (only the shared parts
> > > could possibly be mapped) from all user page tables.
> > 
> > IMHO it should be reasonable to make it work like ZONE_MOVABLE and
> > FOLL_LONGTERM. Making a shared page private is really no different
> > from moving it.
> > 
> > And if you have built a VMM that uses VMA mapped shared pages and
> > short-term pinning then you should really also ensure that the VM is
> > aware when the pins go away. For instance if you are doing some virtio
> > thing with O_DIRECT pinning then the guest will know the pins are gone
> > when it observes virtio completions.
> > 
> > In this way making private is just like moving, we unmap the page and
> > then drive the refcount to zero, then move it.
> Yes, but here is the catch: what if a single shared subpage of a large folio
> is (validly) longterm pinned and you want to convert another shared subpage
> to private?
> 
> Sure, we can unmap the whole large folio (including all shared parts) before
> the conversion, just like we would do for migration. But we cannot detect
> that nobody pinned that subpage that we want to convert to private.
> 
> Core-mm is not, and will not, track pins per subpage.
> 
> So I only see two options:
> 
> a) Disallow long-term pinning. That means, we can, with a bit of wait,
>    always convert subpages shared->private after unmapping them and
>    waiting for the short-term pin to go away. Not too bad, and we
>    already have other mechanisms disallow long-term pinnings (especially
>    writable fs ones!).

I don't think disallowing _just_ long-term GUP will suffice, if we go the "disallow
GUP" route than I think it needs to disallow GUP, period.  Like the whole "GUP
writes to file-back memory" issue[*], which I think you're alluding to, short-term
GUP is also problematic.  But unlike file-backed memory, for TDX and SNP (and I
think pKVM), a single rogue access has a high probability of being fatal to the
entire system.

I.e. except for blatant bugs, e.g. use-after-free, we need to be able to guarantee
with 100% accuracy that there are no outstanding mappings when converting a page
from shared=>private.  Crossing our fingers and hoping that short-term GUP will
have gone away isn't enough.

[*] https://lore.kernel.org/all/cover.1683235180.git.lstoakes@gmail.com

> b) Expose the large folio as multiple 4k folios to the core-mm.
> 
> 
> b) would look as follows: we allocate a gigantic page from the (hugetlb)
> reserve into guest_memfd. Then, we break it down into individual 4k folios
> by splitting/demoting the folio. We make sure that all 4k folios are
> unmovable (raised refcount). We keep tracking internally that these 4k
> folios comprise a single large gigantic page.
> 
> Core-mm can track for us now without any modifications per (previously
> subpage,) now small folios GUP pins and page table mappings without
> modifications.
> 
> Once we unmap the gigantic page from guest_memfd, we recronstruct the
> gigantic page and hand it back to the reserve (only possible once all pins
> are gone).
> 
> We can still map the whole thing into the KVM guest+iommu using a single
> large unit, because guest_memfd knows the origin/relationship of these
> pages. But we would only map individual pages into user page tables (unless
> we use large VM_PFNMAP mappings, but then also pinning would not work, so
> that's likely also not what we want).

Not being to map guest_memfd into userspace with 1GiB mappings should be ok, at
least for CoCo VMs.  If the guest shares an entire 1GiB chunk, e.g. for DMA or
whatever, then userspace can simply punch a hole in guest_memfd and allocate 1GiB
of memory from regular memory.  Even losing 2MiB mappings should be ok.

For non-CoCo VMs, I expect we'll want to be much more permissive, but I think
they'll be a complete non-issue because there is no shared vs. private to worry
about.  We can simply allow any and all userspace mappings for guest_memfd that is
attached to a "regular" VM, because a misbehaving userspace only loses whatever
hardening (or other benefits) was being provided by using guest_memfd.  I.e. the
kernel and system at-large isn't at risk.

> The downside is that we won't benefit from vmemmap optimizations for large
> folios from hugetlb, and have more tracking overhead when mapping individual
> pages into user page tables.

Hmm, I suspect losing the vmemmap optimizations would be acceptable, especially
if we could defer the shattering until the guest actually tried to partially
convert a 1GiB/2MiB region, and restore the optimizations when the memory is
converted back.

> OTOH, maybe we really *need* per-page tracking and this might be the
> simplest way forward, making GUP and friends just work naturally with it.

