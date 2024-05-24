Return-Path: <linux-kselftest+bounces-10644-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD9208CDF99
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 May 2024 04:57:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 792D41F2221E
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 May 2024 02:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC23222F03;
	Fri, 24 May 2024 02:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="t07vfPWT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CBA612B6C;
	Fri, 24 May 2024 02:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716519455; cv=none; b=mPaluDVDpV8tI/0SKJamVPjVHMvR+N0YEFSoEFPv+O+f7r6b6dtwnxikmiR/ENKjGqO0BVkFuWW+f4YYZUa05BV6rc/D03+qbFwT5734U4l8On5iYf6a5wQuWJbemsX5aWozY+5uGaruKL5j+YeYxDvXiwQ3SUrCuinYZvz1ABo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716519455; c=relaxed/simple;
	bh=KumiJ0dcTbAP3ItPboriTQrVVDVKUARaIq7RCMFm+nw=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=KD5OQkX1fNPOruUfctS+T6VYLf90NZmriTW2Dl1FVNWFQWGxJmMocJh4b4Z1ICKJGQnCaveqsuux7zWpAeO4ST1XSySpesHE21V3MhHK41DvkRxnZYaPWJ0pzNn6RhQSW377pbX8ykpsvQLTNIHG686TahlGMFp+0SOPM51WywQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=t07vfPWT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC635C2BD10;
	Fri, 24 May 2024 02:57:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1716519455;
	bh=KumiJ0dcTbAP3ItPboriTQrVVDVKUARaIq7RCMFm+nw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=t07vfPWTsUhVpAlA44lnGhqRPWVxDW4/G0c7tGCLBfSlG4Um8+SlW6GxDCDM0Ie/3
	 ZT9Rsr4SnkxXKdrCWUHU2WqBfgSAi4IOJdpiUfRBmQ/gJH+MHWY9lC6J2mmVZCBllu
	 H65fjrfxEqe2T+aDn8vX4oLx58h2cVnJUoi5Ic1M=
Date: Thu, 23 May 2024 19:57:34 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: David Hildenbrand <david@redhat.com>
Cc: Donet Tom <donettom@linux.ibm.com>, Shuah Khan <shuah@kernel.org>,
 Matthew Wilcox <willy@infradead.org>, Tony Battersby
 <tonyb@cybernetics.com>, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, Ritesh
 Harjani <ritesh.list@gmail.com>, Mike Rapoport <rppt@kernel.org>, Muchun
 Song <songmuchun@bytedance.com>, stable@vger.kernel.org
Subject: Re: [PATCH] selftest: mm: Test if hugepage does not get leaked
 during __bio_release_pages()
Message-Id: <20240523195734.bc03a8822a34b1a97880fb65@linux-foundation.org>
In-Reply-To: <d551d1cd-a02f-42aa-9de2-10ff7757224c@redhat.com>
References: <20240523063905.3173-1-donettom@linux.ibm.com>
	<20240523121344.6a67a109e0af2ba70973b34b@linux-foundation.org>
	<d551d1cd-a02f-42aa-9de2-10ff7757224c@redhat.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 23 May 2024 22:40:25 +0200 David Hildenbrand <david@redhat.com> wrote:

> > You have stable@vger.kernel.org in the mail headers, so I assume you're
> > proposing this for backporting.  When doing this, please include
> > 
> > Cc: <stable@vger.kernel.org>
> > 
> > in the changelog footers and also include a Fixes: target.  I'm
> > assuming the suitable Fixes: target for this patch is 38b43539d64b?
> 
> This adds a new selfest to make sure what was fixed (and backported to 
> stable) remains fixed.

Sure.  But we should provide -stable maintainers guidance for "how far
back to go".  There isn't much point in backporting this into kernels
where it's known to fail!

I'm still thinking that we want this in kernels which have 38b43539d64b?

