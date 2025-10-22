Return-Path: <linux-kselftest+bounces-43753-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15907BFB945
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Oct 2025 13:15:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 414E01A0548F
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Oct 2025 11:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36D0A32E126;
	Wed, 22 Oct 2025 11:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ou7Su6GC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BFD7296BC9;
	Wed, 22 Oct 2025 11:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761131734; cv=none; b=QkddCopblNa7B8/PPwYRq5Qytew1seGirXk4UDMvKzngi44ZDg24GLBg/yEgHo2QUq78IZA8CyqlQoYgumqWOcRw8f2LRq3/X1Ba6RHtjU8lpYcC5iIoC7lI0PMCm+IYmB6kE0Vv1B02n+tcx7JQZfc6wjgqy/QILjYmP61EAXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761131734; c=relaxed/simple;
	bh=QJH5l7/QfRaBN4zYaquzGrr8H9aALZ24iuSHMe+PgVA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YadxIlUikcqxw3ItqgA/SHkJEhvz0CVlKo59pd6Lcz6y1PEItBs8ujbmR9f1NLZ+QTvogyoQZ73iheHv64S8kUr43w0JbQt9Ily4He/QVxyFQa+njA4h5DHbl/Zj3W89LOHat7gIGF7D6MN5Om8f+K+zf07gIhF/0Ep6s7K9kK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ou7Su6GC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9767EC4CEE7;
	Wed, 22 Oct 2025 11:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761131733;
	bh=QJH5l7/QfRaBN4zYaquzGrr8H9aALZ24iuSHMe+PgVA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=ou7Su6GC0HgcXE91A7ybE8rVrAL/ds7lBgRUPKFdr8xf8W+ro3p5Rf0JTKAuV/7pM
	 tav/40d80NMF8uKrh1eiYH4tUq9156kNTU+Zhe4c/4v8n76653PSTWQPQwsSJAAfdH
	 n+ikFBTgaZHETW3x/XzFgaNcAq4+I8uZk5lVqZ5FVFr5JvgAdDBhGohZqXw6BJKvWx
	 cUUMNRCLxMQJc5eIcMOsfGzUj3u+E/590ZdrPxib7whbxMhb3GKMN4G4uGXbfqKcYA
	 RqdfcClr06xWf6PGxHO6MenJi67hnRqmmGPrGpglmeCA1YstxY1n4HfRCZnZWkHIMd
	 QDw1JYkizpolQ==
From: Pratyush Yadav <pratyush@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: akpm@linux-foundation.org,  brauner@kernel.org,  corbet@lwn.net,
  graf@amazon.com,  jgg@ziepe.ca,  linux-kernel@vger.kernel.org,
  linux-kselftest@vger.kernel.org,  linux-mm@kvack.org,
  masahiroy@kernel.org,  ojeda@kernel.org,  pratyush@kernel.org,
  rdunlap@infradead.org,  rppt@kernel.org,  tj@kernel.org
Subject: Re: [PATCHv7 5/7] kho: don't unpreserve memory during abort
In-Reply-To: <20251022005719.3670224-6-pasha.tatashin@soleen.com> (Pasha
	Tatashin's message of "Tue, 21 Oct 2025 20:57:17 -0400")
References: <20251022005719.3670224-1-pasha.tatashin@soleen.com>
	<20251022005719.3670224-6-pasha.tatashin@soleen.com>
Date: Wed, 22 Oct 2025 13:15:30 +0200
Message-ID: <mafs0a51jfar1.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Oct 21 2025, Pasha Tatashin wrote:

> KHO allows clients to preserve memory regions at any point before the
> KHO state is finalized. The finalization process itself involves KHO
> performing its own actions, such as serializing the overall
> preserved memory map.
>
> If this finalization process is aborted, the current implementation
> destroys KHO's internal memory tracking structures
> (`kho_out.ser.track.orders`). This behavior effectively unpreserves
> all memory from KHO's perspective, regardless of whether those
> preservations were made by clients before the finalization attempt
> or by KHO itself during finalization.
>
> This premature unpreservation is incorrect. An abort of the
> finalization process should only undo actions taken by KHO as part of
> that specific finalization attempt. Individual memory regions
> preserved by clients prior to finalization should remain preserved,
> as their lifecycle is managed by the clients themselves. These
> clients might still need to call kho_unpreserve_folio() or
> kho_unpreserve_phys() based on their own logic, even after a KHO
> finalization attempt is aborted.

I think you also need to update test_kho and reserve_mem to do this
since right now they assume all memory gets unpreserved on failure.

>
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> ---
[...]

-- 
Regards,
Pratyush Yadav

