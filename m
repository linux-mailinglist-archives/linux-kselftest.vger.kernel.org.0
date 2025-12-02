Return-Path: <linux-kselftest+bounces-46922-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 73A1BC9D521
	for <lists+linux-kselftest@lfdr.de>; Wed, 03 Dec 2025 00:19:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1E98434ABD6
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Dec 2025 23:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D84D5277CAB;
	Tue,  2 Dec 2025 23:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="D3lbk/j0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07828200C2
	for <linux-kselftest@vger.kernel.org>; Tue,  2 Dec 2025 23:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764717545; cv=none; b=Em7IkIDNtI0PhXvXNBNthhmcYEdMIMvHjX2RhW6o1w18JbOMraaqL74f/5qOVfl4u8Bl69yPE8xvIecL6L2fAKicOmCeaSIhPcCEfweTu4VggTO7rR5yc/Wh3BigNYLh3evuTEzRpBzLKXVVMRQ3xRDM/tIkdoiasHIb+ATCuhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764717545; c=relaxed/simple;
	bh=tTLJTkopiZuixU05XWZTD5LAWT9CkPbH6N6bIiPBbDA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uGFySIvx8Jc1OOSh4aB9Ti9dyZyK7oiw+ePLVXe3dc6ODJHwsiH6HFuxWgn39PL+XQR/77XwYLss0WVhB9laA6u/RhFd3QJ14ua+xHtpCTqnngX4SEOSmAIq7HIW2Iu9RRw9EqKsACLDvQ9QD2q8bQRN0ZGtw2NMAiaUClFSImU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=D3lbk/j0; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 2 Dec 2025 15:18:42 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1764717532;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tYjD1KC7LKwhQmMybkAlbHo11LR6BNRCoCUD/B/QiUM=;
	b=D3lbk/j0I16VjzHWDqhQT1N6rVhT500zGJut0+GOVA0Vt36HFWVZ7lq7nZ+FwQRARGJ018
	y9GR/gj+VEXfurF2gGjSRvlQKPZwA2+73Cunh3AhKVSNki2RNqI7Jx6AdqRDprrTG45uiB
	zDMbAvE0G9DbRxJ0BKQnzPIJ9pQ2NYs=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Guopeng Zhang <zhangguopeng@kylinos.cn>
Cc: tj@kernel.org, hannes@cmpxchg.org, mhocko@kernel.org, 
	roman.gushchin@linux.dev, mkoutny@suse.com, muchun.song@linux.dev, lance.yang@linux.dev, 
	shuah@kernel.org, linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/3] selftests: cgroup: Replace sleep with
 cg_read_key_long_poll() for waiting on nr_dying_descendants
Message-ID: <3p7o2cxir6yz4baonmkrzumklg5zx3oddhi7mqlmxu26j7ze33@u2mrvj6pqad4>
References: <20251124123816.486164-1-zhangguopeng@kylinos.cn>
 <20251124123816.486164-4-zhangguopeng@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251124123816.486164-4-zhangguopeng@kylinos.cn>
X-Migadu-Flow: FLOW_OUT

On Mon, Nov 24, 2025 at 08:38:16PM +0800, Guopeng Zhang wrote:
> Replaced the manual sleep and retry logic in test_kmem_dead_cgroups() with the new
> helper `cg_read_key_long_poll()`.  This change improves the robustness of the test by
> polling the "nr_dying_descendants" counter in `cgroup.stat` until it reaches 0 or the timeout is exceeded.
> 
> Additionally, increased the retry timeout to 8 seconds (from 5 seconds) based on testing results:

Why 8 seconds? What does it depend on? For memcg stats I see the 3
seconds driven from the 2 sec periodic rstat flush. Mainly how can we
make this more future proof?

>   - With 5-second timeout: 4/20 runs passed.
>   - With 8-second timeout: 20/20 runs passed.
> 
> Signed-off-by: Guopeng Zhang <zhangguopeng@kylinos.cn>

Anyways, just add a sentence in the commit message on the reasoning
behind 8 seconds and a comment in code as well. With that, you can add:

Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>

