Return-Path: <linux-kselftest+bounces-41791-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 10B15B82291
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Sep 2025 00:30:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C65A1C80F87
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Sep 2025 22:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E65B309DCE;
	Wed, 17 Sep 2025 22:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="eXNgK4cm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC932D660D;
	Wed, 17 Sep 2025 22:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758148249; cv=none; b=ZJJV/Edp8cz0cnQoNMXsx25l08s/zbdGjcfsQ8JRGa3o52HymB7y2Ndytb5JioYv8aXGmwe6JMb475x3ObqLWYatyp2SfLl9CQMz9p4FGOPkEk98vvoGzPAiGiCB6UYhur55IJ4lMH4nSoxgkzC175KQHlh7235lgR/B+sNZ1HI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758148249; c=relaxed/simple;
	bh=dUgGbvrbudlHAHGgS6P3LAmsFzYQs7U4CkzBsdK7Mpc=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=ma7AMFIJDjOmPCO53qM9LEWv1k7vx6w3/iP5owLorhQnQiVUpWrKizmG+4oZvrJX89If7aj4eNoQfOJtlbZSh+ph2Ue0y7V+/f7khgz7JiMmG82OsIS8b7H16j3PPtkLTm5/1uYcGgiBpWMn3fTaJ2eww+VON6yo4dO0+q0ua2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=eXNgK4cm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 776C6C4CEE7;
	Wed, 17 Sep 2025 22:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1758148247;
	bh=dUgGbvrbudlHAHGgS6P3LAmsFzYQs7U4CkzBsdK7Mpc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eXNgK4cmDv7XJTS1oWEzWXMxh8n7EBjOMAGzglifT0bN8XMW9nLS2uilzRxJp+bsu
	 g4/YPHBElGlqtcd/bTJA/uDk/y0E9jkysWKYImMOIRQBc5z+qABFxHAuFx5d4e7OSF
	 kllisVZyIoZlbs9F/NzIhvx5Hw68vA6hZhXSIiw8=
Date: Wed, 17 Sep 2025 15:30:46 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Lance Yang <lance.yang@linux.dev>
Cc: david@redhat.com, lorenzo.stoakes@oracle.com, shuah@kernel.org,
 ioworker0@gmail.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 1/1] selftests/mm: skip soft-dirty tests when
 CONFIG_MEM_SOFT_DIRTY is disabled
Message-Id: <20250917153046.b781f65ea9a54875f4ddd02e@linux-foundation.org>
In-Reply-To: <20250917133137.62802-1-lance.yang@linux.dev>
References: <20250917133137.62802-1-lance.yang@linux.dev>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 17 Sep 2025 21:31:37 +0800 Lance Yang <lance.yang@linux.dev> wrote:

> The madv_populate and soft-dirty kselftests currently fail on systems where
> CONFIG_MEM_SOFT_DIRTY is disabled.
> 
> Introduce a new helper softdirty_supported() into vm_util.c/h to ensure
> tests are properly skipped when the feature is not enabled.

It's pretty sad for us to ship kernels which have known selftest flaws
like this.

would

	Fixes: 9f3265db6ae8 ("selftests: vm: add test for Soft-Dirty PTE bit")

be appropriate?


