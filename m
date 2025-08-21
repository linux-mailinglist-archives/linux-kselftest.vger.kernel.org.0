Return-Path: <linux-kselftest+bounces-39588-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D97D3B306A1
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 22:49:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0FC27B00DC
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 20:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7698837429A;
	Thu, 21 Aug 2025 20:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Rn087/J5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865A23728B4
	for <linux-kselftest@vger.kernel.org>; Thu, 21 Aug 2025 20:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755807889; cv=none; b=ovnUHBXlMZrEVUOsv/LrEpGW0CL+dqIUnugEvWCs8z6TmkLQhEn4fxP3q9g8laXlwcBw93fAbOfproipKBO0Rqv+5gQPaT4+uwHHCs7lORjTDZ8t5nlIys2Sea2MuMiE0tUJgLcu0Ib5P+m2JiUlQht6ESS5JdU3oA+Sz4SGcVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755807889; c=relaxed/simple;
	bh=oA3XFTq+X9InxrtY53OI1FqTpqPTKR+1uoMqvtlA0+o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ABpzs2iQydAl+kT909YdeZ/0zgcCwwlr/K1pfM8yCsBldULqApFD1xC8Hdicq3Jo1gf3ZAxh+ieHn5XaywtwLMwAPm0gYjcLAPs41lu/qGBOc7CnLBS1nF6f2tQu007vczbBH9xKMVUiZMqqZ3R9YAvaDlKFNI3bS3ddraWLNh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Rn087/J5; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-53b17534eeeso554931e0c.3
        for <linux-kselftest@vger.kernel.org>; Thu, 21 Aug 2025 13:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1755807886; x=1756412686; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6aeG3+zXNcZH2d1Z1/su6zkQOg7Uc4j3Xw+oqie+iPw=;
        b=Rn087/J5j5FyNm4Qob+9GCqTtp8pQbHjYbCRu64LYME9nCB/R8OdClXzzaa7a+/uxY
         ujfPt2eRSJw/WeMN0EQF8as3k6xLpR5eUf3rYsO8DckcIhSxFOL7+S65CbXwcqa1jcr4
         iB1ovtPyDAUUI5rkLx/QO2uZ3EMX/16guNRXo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755807886; x=1756412686;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6aeG3+zXNcZH2d1Z1/su6zkQOg7Uc4j3Xw+oqie+iPw=;
        b=EnlwY8Qbf0jGCE+/GhlyEXLzJE2n1zxVl21Zxm2cyuehXg1sznhaFdfaMVpEkS69Yr
         8ZzfVVspuNY12mknuyywoA1lBjCPATBIV21GyeTMtZc+Qm8pVId0EhbxOaRwz212oABq
         5fYuatqfqt6kp8eCf8v2ik3o1ANQ6SmnEb31ZKi2330bWzL9lFcg3vgqiV7bT+IZ3pLO
         3+TGxUp2pIXmRrUJBcBLtQIWZFbNqkgREay4yPMXiP+v0TtJ5VSEwhl7vD5ccHMhnFzR
         veVsab/vW8In9E+OvpflsdgkIjRBijI51azQU38utR9a6pjUcOQPfYx7QXgFfQgLBFvt
         yGcA==
X-Forwarded-Encrypted: i=1; AJvYcCWIygWFuAuzOs9N/KQEJcIpamxgo0fbas7O9kAokG94VTfrM1Uy9z6S6Z7iONCw2qYEfyjWXlZjo9nHbuf+xn0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOod8p8WHy0YPyFO9eB7wi5vZdjvRbSXKgtt9HxeK0IimvD39t
	5QVKqyy2wZnaJbdwbu04w6xXvjXG/wol9GTr0aMTgp0pP/QTpLgWej2HceiqAb7ccz0Q6Y3DixJ
	loFSNzUU=
X-Gm-Gg: ASbGnctLrALRxq0CL53rfECoJJbVItTRC+35G+l9xfLAOlN963Ye1uRwS2ZnETgbWgo
	vtpHR3VVxRrikW6ZJGeYr3f+QzPECZe+MNXzsc2lx7BP86GlIbPMSMDZuZz1GhTrUldzLITdmKB
	OVjzIMI4AJ/cyHQ4FBlSsl8n1NNwxu5RnDLqdk+z8/5y1tJqKxXsTK1dS0NBM3SjBFeIneowS82
	F0mcqB0vShTtjJhncuKRiPFZOQC1EZ/Nf3pIGwtM/WY/wV76BVYnzdbm6Op7ewW8x8MAM6mzkBw
	plF0tDD9RxLuVz5vduWvUXFf400UJF90LLmYvfoAo9EgxwIfz+crTbNieFgsbIAcknaWhtsvlBC
	VuWXGJAPOwDFQO6DCgV2jNM56K+crus40Hs5lEoPgtaqEvZ556ji+7cnY06T0ZZeezR7S0PnFig
	QFlq6ImGFRRQQ=
X-Google-Smtp-Source: AGHT+IFaR9xVE6ac3PpXzEgyrSyjpD2EAIJOWO039WEPgG5jv0L/fhqjyAYkmz8dWx37htOpPFt+lQ==
X-Received: by 2002:a05:6122:4699:b0:53c:6d68:1cca with SMTP id 71dfb90a1353d-53c8a44f72fmr258548e0c.16.1755807886173;
        Thu, 21 Aug 2025 13:24:46 -0700 (PDT)
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com. [209.85.221.174])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-53b2bdb84f5sm3949164e0c.13.2025.08.21.13.24.45
        for <linux-kselftest@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 13:24:45 -0700 (PDT)
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-53b1718837dso603898e0c.0
        for <linux-kselftest@vger.kernel.org>; Thu, 21 Aug 2025 13:24:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXs+Yotzt647gjmm4JKJmg+fxE4BMSibYPsK0zrdOSlmCk0BSctlu8P8l7DbCbrbNE89eVw22a/vIzGfPCbqGQ=@vger.kernel.org
X-Received: by 2002:a05:6122:1ad2:b0:53c:896e:2870 with SMTP id
 71dfb90a1353d-53c8a40b923mr212315e0c.12.1755807884664; Thu, 21 Aug 2025
 13:24:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250821200701.1329277-1-david@redhat.com> <20250821200701.1329277-32-david@redhat.com>
In-Reply-To: <20250821200701.1329277-32-david@redhat.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 21 Aug 2025 16:24:23 -0400
X-Gmail-Original-Message-ID: <CAHk-=wjGzyGPgqKDNXM6_2Puf7OJ+DQAXMg5NgtSASN8De1roQ@mail.gmail.com>
X-Gm-Features: Ac12FXxaZhwn04a0gbwY6rjh9UGLxnRlGOG0Jy0WjRbVAG0UxLDqNy0Wydj0GQk
Message-ID: <CAHk-=wjGzyGPgqKDNXM6_2Puf7OJ+DQAXMg5NgtSASN8De1roQ@mail.gmail.com>
Subject: Re: [PATCH RFC 31/35] crypto: remove nth_page() usage within SG entry
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>, 
	"David S. Miller" <davem@davemloft.net>, Alexander Potapenko <glider@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Brendan Jackman <jackmanb@google.com>, 
	Christoph Lameter <cl@gentwo.org>, Dennis Zhou <dennis@kernel.org>, Dmitry Vyukov <dvyukov@google.com>, 
	dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, 
	iommu@lists.linux.dev, io-uring@vger.kernel.org, 
	Jason Gunthorpe <jgg@nvidia.com>, Jens Axboe <axboe@kernel.dk>, Johannes Weiner <hannes@cmpxchg.org>, 
	John Hubbard <jhubbard@nvidia.com>, kasan-dev@googlegroups.com, kvm@vger.kernel.org, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, linux-arm-kernel@axis.com, 
	linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org, 
	linux-ide@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mips@vger.kernel.org, linux-mmc@vger.kernel.org, linux-mm@kvack.org, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	linux-scsi@vger.kernel.org, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Marco Elver <elver@google.com>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	Michal Hocko <mhocko@suse.com>, Mike Rapoport <rppt@kernel.org>, Muchun Song <muchun.song@linux.dev>, 
	netdev@vger.kernel.org, Oscar Salvador <osalvador@suse.de>, Peter Xu <peterx@redhat.com>, 
	Robin Murphy <robin.murphy@arm.com>, Suren Baghdasaryan <surenb@google.com>, Tejun Heo <tj@kernel.org>, 
	virtualization@lists.linux.dev, Vlastimil Babka <vbabka@suse.cz>, wireguard@lists.zx2c4.com, 
	x86@kernel.org, Zi Yan <ziy@nvidia.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 21 Aug 2025 at 16:08, David Hildenbrand <david@redhat.com> wrote:
>
> -       page = nth_page(page, offset >> PAGE_SHIFT);
> +       page += offset / PAGE_SIZE;

Please keep the " >> PAGE_SHIFT" form.

Is "offset" unsigned? Yes it is, But I had to look at the source code
to make sure, because it wasn't locally obvious from the patch. And
I'd rather we keep a pattern that is "safe", in that it doesn't
generate strange code if the value might be a 's64' (eg loff_t) on
32-bit architectures.

Because doing a 64-bit shift on x86-32 is like three cycles. Doing a
64-bit signed division by a simple constant is something like ten
strange instructions even if the end result is only 32-bit.

And again - not the case *here*, but just a general "let's keep to one
pattern", and the shift pattern is simply the better choice.

             Linus

