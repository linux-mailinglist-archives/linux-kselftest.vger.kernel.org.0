Return-Path: <linux-kselftest+bounces-40382-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42ADCB3D50E
	for <lists+linux-kselftest@lfdr.de>; Sun, 31 Aug 2025 22:03:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F899175E06
	for <lists+linux-kselftest@lfdr.de>; Sun, 31 Aug 2025 20:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF80B22FDEC;
	Sun, 31 Aug 2025 20:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="I9cY79ni"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA421DC9B1;
	Sun, 31 Aug 2025 20:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756670622; cv=none; b=UyTRS84Cu9Ck2bjUqc0Q1BVDJ7ZXV307zFhQ6Wl9/aCLZFkRqZmNpEjcCkRmMSjwOvz2ckbTAPikUwU+raA+TMV8DBD6bH040wwozgLknmd2vInvR5skyncPmWyGH4oDAFO+87TwdC6CGjhRD7Scs7x/NbaWbSK1p8EvWISCiRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756670622; c=relaxed/simple;
	bh=DPPkcb21slAFTG9P0dPfTMqmPZQZs0zA6URZPmIF4aQ=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=ZJluhrdIMmKbtuxbpby0mMLhOBZKXIyb35hNCOnXKSZwkTtJteZJWoHGWRbC90LsfP8bpo8VdqKP4UwFquT9IgZabiuN86qQGvLJpaQOsO7HoSCf/cqb3U34CRWTxK3UOhQWvSjdhUWRJODgGtnLtlYtXYy8H5TaHntM59tSaU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=I9cY79ni; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43B50C4CEED;
	Sun, 31 Aug 2025 20:03:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1756670622;
	bh=DPPkcb21slAFTG9P0dPfTMqmPZQZs0zA6URZPmIF4aQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=I9cY79niBHMOtwU5hsj7SCJxtuY2+gGtapyoxfF8v+481gGJZRLlj15P+mbhewE9U
	 6WCA4kEeFGXjQw0z86jDb80fzDEAPnyf7wgNxXkEZ4JTzB9l4VP200eSkqXEZfZJhx
	 Cw+qht02yc54pcjkoNk+/jH6Jws2xsl6DOYUNCbQ=
Date: Sun, 31 Aug 2025 13:03:40 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Bala-Vignesh-Reddy <reddybalavignesh9979@gmail.com>
Cc: richard.weiyang@gmail.com, Liam.Howlett@oracle.com, davem@davemloft.net,
 david@redhat.com, edumazet@google.com, gnoack@google.com, horms@kernel.org,
 kuba@kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
 linux-security-module@vger.kernel.org, lorenzo.stoakes@oracle.com,
 mhocko@suse.com, mic@digikod.net, ming.lei@redhat.com, pabeni@redhat.com,
 rppt@kernel.org, shuah@kernel.org, skhan@linuxfoundation.org,
 surenb@google.com, vbabka@suse.cz
Subject: Re: [PATCH v2 2/2] selftests: Replace relative includes with
 non-relative for kselftest.h and kselftest_harness.h
Message-Id: <20250831130340.c096ab001dd38bcdb11146b8@linux-foundation.org>
In-Reply-To: <20250830163949.20952-3-reddybalavignesh9979@gmail.com>
References: <20250827144733.82277-1-reddybalavignesh9979@gmail.com>
	<20250830163949.20952-1-reddybalavignesh9979@gmail.com>
	<20250830163949.20952-3-reddybalavignesh9979@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 30 Aug 2025 22:09:49 +0530 Bala-Vignesh-Reddy <reddybalavignesh9979@gmail.com> wrote:

> Replaced relative path of kselftest.h and kselftest_harness.h
> to a non-relative path

This patch causes me some trouble.  It alters things which are also
altered in both mm.git's `mm' and `non-mm' branches.  I try to keep
those branches independent and this patch won't apply to either branch.
And I'd rather not mess around doing git tricks to address this just
for one patch.

So what I plan to do is to simply drop the problematic hunks from this
patch.  So what will be queued in mm.git's mm-nonmm will have a few
missed conversion sites.  Everything should still work OK and I'll ask
that after 6.17 is released, you send along a followup patch which fixes
those missed sites, OK?


