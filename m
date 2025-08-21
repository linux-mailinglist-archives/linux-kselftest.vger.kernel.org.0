Return-Path: <linux-kselftest+bounces-39591-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A102CB30709
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 22:52:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 76A3E4E694B
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 20:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BF9234A336;
	Thu, 21 Aug 2025 20:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="FV234+mU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A44734A327
	for <linux-kselftest@vger.kernel.org>; Thu, 21 Aug 2025 20:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755808607; cv=none; b=IqDx/mqjWSBiX+i7lLZwzY96/i4RmAD+qodwJhst7MjekVwepjaZxpfPyEqFSbJwBR2kzBDpsAY0BjEqEZKGFcJeu2rK0O3b8H+LEAMOkHV3T/p2/9cnitQIyNYWXnAe8zRt2DbT+vr9PoI/5t78zQCTf+4EHukIwQPkJphIH34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755808607; c=relaxed/simple;
	bh=yojduCRvPCmYgwaX7kfWJ1p+To4BJmiAMcPa2zQubFw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ikd6xi6q1o/lWDRmCAmhfbgOoBhU1WRj8xfKBpzdtViDaY20CI/3AK+iBkCCSZl8vZ/6cDhEonfacAV3RKB+GzzyA28WkBO36gGld2SqKxJJhOWS2RwCLxinIEOvLnm21r8x33YLrrsuvqDWqTaqdG0x16QgXd9UIjYzm8xLoxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=FV234+mU; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e93498d436dso1478632276.1
        for <linux-kselftest@vger.kernel.org>; Thu, 21 Aug 2025 13:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1755808604; x=1756413404; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=083PuN2wICwWm8iwB5WBlP6qyKXLyqdZEBdZ0ztp8l8=;
        b=FV234+mU7pRMURRjma/HCXOh7oRBz2o8mZ4HY80Nw18ph+1Eb98oLCMJUBmPlL/wYk
         wbYnIjf40zeiyigCAOvdnmVZW/bVhKI/R6VE8hLE1yX0t518kJFFvAM8OXr9IG/1iZiY
         bM5bWY1XzkQ4ggk041+jvfFIOSBug5NgOCliY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755808604; x=1756413404;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=083PuN2wICwWm8iwB5WBlP6qyKXLyqdZEBdZ0ztp8l8=;
        b=X9DV9zPnk1gPR6gk6Y5HKbPlRfkZG7iw6yO258YDCWAU4CXNZ6Mq4k95MYLCvdK7MU
         v75hvO7QFw8Ql2FVqM58hoizbCYui7SJduSgzC3HtjM38dsA5d/3OYB33PqwUyhA1k1y
         fS/yan6m8W3qKRgNk/34x/OxPIrqthHlTKTjTmTpyDcuy9LZC7VOUogemqQ5imRhfu6s
         Wf3PIdQmzbOhuIcnE3BTFXNfd3S6KSO9wporgbTR8bVx2YJRSVGp/O5Cs3Mg/S0WwEOz
         VfzNKLEJzseGRAosoAjqk/4jrwkZN6iw6jZvsWlBCSknNKYW372HlSqCmMuCq+eHj5vX
         aQpw==
X-Forwarded-Encrypted: i=1; AJvYcCVziktEjQEIBK/g2pcurghr+iUTpeo+sE5xhgqZ+lEp6LKfc7d0Xdnl1z1+76jTj7V3NY8y5sfhdSo+eS6jDio=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz01kzAXhxZbIkH5buS3XznLDeo28VcabO4FzEOisb/1kswnTv9
	Sb6zOLzWmW7vQNhkDG5dsCpEhl0kTV2K9PBSXfBAhKebf15cuKtUtqWUJykq7yCRMaJPeiXy0yW
	NdVHAC2GOb2eQh6c3bOPcmbWzPwrQZHdvr2BFDC7bdg==
X-Gm-Gg: ASbGncvZnHiHH32fFEit6Y9WM3lXhQBKfbiqxTEMNl4RZYjZ6jzsqSXKi1od+sNv/Lq
	226UVJSEs3SgU5oc5qZqogtu7tFukkALfa4Z7qLiNJpWJmT//kpOJn2qZ4u1LxmRYEOVm4dvvf7
	MaWogHqUwxr6eycCQ8WWuc4NnYjx/AqjFNt8y9gj7n2IDJT9EaGw5HphF+2pLWQJQSCH+pn8r3h
	480wBYNFt/U/y2WPkju6cNgzkw=
X-Google-Smtp-Source: AGHT+IHnF0lVhm+1Tun1UWlMLnnSk/jF/jUOt69DP22IOjEUNxjHdHqCJTIRGjm6XM6hiUq/Axp7jnIGuYc/D1Y8ZZI=
X-Received: by 2002:a05:6902:4381:b0:e94:dea:b80b with SMTP id
 3f1490d57ef6-e951c365621mr715984276.40.1755808604080; Thu, 21 Aug 2025
 13:36:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250821200701.1329277-1-david@redhat.com> <20250821200701.1329277-32-david@redhat.com>
 <CAHk-=wjGzyGPgqKDNXM6_2Puf7OJ+DQAXMg5NgtSASN8De1roQ@mail.gmail.com> <2926d7d9-b44e-40c0-b05d-8c42e99c511d@redhat.com>
In-Reply-To: <2926d7d9-b44e-40c0-b05d-8c42e99c511d@redhat.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 21 Aug 2025 16:36:32 -0400
X-Gm-Features: Ac12FXz8i_O0Dca-zCdGNOyRYVeCyfB9Z0ucQ3KoLazk0PNM2PIB2a_qe1sXKks
Message-ID: <CAADWXX81Y3ny6WvDN8EeYvBPa2qy10PKhWfZpj=VBcqczL6npg@mail.gmail.com>
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

Oh, an your reply was an invalid email and ended up in my spam-box:

  From: David Hildenbrand <david@redhat.com>

but you apparently didn't use the redhat mail system, so the DKIM signing fails

       dmarc=fail (p=QUARANTINE sp=QUARANTINE dis=QUARANTINE)
header.from=redhat.com

and it gets marked as spam.

I think you may have gone through smtp.kernel.org, but then you need
to use your kernel.org email address to get the DKIM right.

          Linus

