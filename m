Return-Path: <linux-kselftest+bounces-43748-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 47D91BFB652
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Oct 2025 12:25:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 155674ED45B
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Oct 2025 10:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D494280318;
	Wed, 22 Oct 2025 10:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YEvjjIsd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63732350A35;
	Wed, 22 Oct 2025 10:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761128712; cv=none; b=X5nKGfQtFFSbB+o9dbU3SHjwW+ZQlfr7MSLvl0CR+cT4m7e2r9Hskhyfm9UVY6gF28AbwoFAs6QPrHbraxvyBY0eIVVZI+Nsj25WtEBOteHO5hKVpqxO7zNfDmFD3wabSKFyNl8K7OKm2S+HDr8rVMbl+sQR0KTduZENvM8ixwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761128712; c=relaxed/simple;
	bh=stbg9Z4GKktvhVbBWBaKTlXQZOrVQklo2RFMw2PVpgc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cmXX++ZftMi0C4jg6NqOzQ3RYrKYBlWt2MV4BC+fJdh6forUNdEUIlEixxdoHvBR1nV8NvqDcv4gZYkAj5Hqb9hRb1mBxjKHQ3t1uh30fCYUGpPjhyP0G867hS2b58gJjh3DcEAGz0hoGrt7YjAbU8QlisNsqvalBp/5k703/+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YEvjjIsd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29ECEC4CEE7;
	Wed, 22 Oct 2025 10:25:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761128711;
	bh=stbg9Z4GKktvhVbBWBaKTlXQZOrVQklo2RFMw2PVpgc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=YEvjjIsdeQS+VXWfT62+1y6ZmLHQhBQdO5DzyWVgc/cNGTUnFYLgt7W0n49KP3x0I
	 2qnGRwrRfk8gzhpj6CpJaByqIkuiO4f5E5bie1iequdnJvG6CtJlhk0h+NrqEyKJ+M
	 aR84lskvYfWgFFArVhkhTFgmbo23eeMRV+feqgwkTaOyJuQmqK6HtBVupdmNG3ZAET
	 gi3+NqBHS6maLsdRH8d5jI8rglQ6sRQ+htHYMUSRoYP64KJ05EZSniF1vSbHIqmde8
	 M3EfvChB9r7SD6Ef3E+wnOYZOHDvvVu4xLs5mF2ZLndwj3DISKfdwXsH/CzJXrpwxe
	 dIxmE0xi3Oa4A==
From: Pratyush Yadav <pratyush@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: akpm@linux-foundation.org,  brauner@kernel.org,  corbet@lwn.net,
  graf@amazon.com,  jgg@ziepe.ca,  linux-kernel@vger.kernel.org,
  linux-kselftest@vger.kernel.org,  linux-mm@kvack.org,
  masahiroy@kernel.org,  ojeda@kernel.org,  pratyush@kernel.org,
  rdunlap@infradead.org,  rppt@kernel.org,  tj@kernel.org,
  jasonmiu@google.com,  dmatlack@google.com,  skhawaja@google.com
Subject: Re: [PATCH v3 2/3] liveupdate: kho: Increase metadata bitmap size
 to PAGE_SIZE
In-Reply-To: <20251021000852.2924827-3-pasha.tatashin@soleen.com> (Pasha
	Tatashin's message of "Mon, 20 Oct 2025 20:08:51 -0400")
References: <20251021000852.2924827-1-pasha.tatashin@soleen.com>
	<20251021000852.2924827-3-pasha.tatashin@soleen.com>
Date: Wed, 22 Oct 2025 12:25:08 +0200
Message-ID: <mafs0qzuvfd2z.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Oct 20 2025, Pasha Tatashin wrote:

> KHO memory preservation metadata is preserved in 512 byte chunks which
> requires their allocation from slab allocator. Slabs are not safe to be
> used with KHO because of kfence, and because partial slabs may lead
> leaks to the next kernel. Change the size to be PAGE_SIZE.
>
> The kfence specifically may cause memory corruption, where it randomly
> provides slab objects that can be within the scratch area. The reason
> for that is that kfence allocates its objects prior to KHO scratch is
> marked as CMA region.
>
> While this change could potentially increase metadata overhead on
> systems with sparsely preserved memory, this is being mitigated by
> ongoing work to reduce sparseness during preservation via 1G guest
> pages. Furthermore, this change aligns with future work on a stateless
> KHO, which will also use page-sized bitmaps for its radix tree metadata.
>
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>

Reviewed-by: Pratyush Yadav <pratyush@kernel.org>

[...]

-- 
Regards,
Pratyush Yadav

