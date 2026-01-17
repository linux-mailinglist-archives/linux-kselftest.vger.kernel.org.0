Return-Path: <linux-kselftest+bounces-49217-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 805A4D38B39
	for <lists+linux-kselftest@lfdr.de>; Sat, 17 Jan 2026 02:22:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E269B30200A4
	for <lists+linux-kselftest@lfdr.de>; Sat, 17 Jan 2026 01:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28688285066;
	Sat, 17 Jan 2026 01:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AypgwY6x"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E81721146C;
	Sat, 17 Jan 2026 01:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768612914; cv=none; b=M8yOEdAd0KmCtfPe1YxyeKOJ2tvtu5Eoan1PqLS6YKEkdMw2d6jhowLG5l3sPWo/B1ra4+O/8X1wtwihhcGWpY1kixjk8NsL96zNIRb64gluwqjG5nPZD62hkgfXFZsVE9e+NnGS/cLBFZQYuZf7xhGiWxIencGtt3JwRxkQY/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768612914; c=relaxed/simple;
	bh=6xxMF1nF4gFfiAabY8bBSiHZyIKO9vi3p2MzOkcN4lY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n1jDtC1x5PKkwOxsoNpdxBY7lZkjg7PG+K2Sql6119gx5M/5zdxPUJ7kEvRyj77pdTQCxVhhD/4iFnP9e/kn5ly+tdQB7Uncn3YSbwr7O9/pU0CZbHv93ru3AZxRqqsKtqsFW2Yf5ogKCCQAKGic06yZrc+SFA+rO9kJ/9JrkhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AypgwY6x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0333C116C6;
	Sat, 17 Jan 2026 01:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768612914;
	bh=6xxMF1nF4gFfiAabY8bBSiHZyIKO9vi3p2MzOkcN4lY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AypgwY6xtKtraBu85pjM4BHwPQHL1gZRO1U25ZRbUGgvO9BBiA5OR6Idyypbuhc9y
	 oqgTVz4aQ/D/ncN41RYp0VPZgyI75z5bdONyF7epuUSv7WPh/bUNVpdwHp/UqCfUJS
	 x9DZOpbk8yf7WbREHWtT1bf0mVQyI2BrL4s9UkMj/zfIcNZWFh+G01NfjduIKsfY3d
	 An6X9zQWlfzHM6lOC8LFc40Nwye1wMMx3Qe2Gs3pwdzKWSjq/eqFKILAtGiGYkPWz1
	 C/licmDrm6cziIvMeOdlxmB8srXbY4SRMzMw9koB34jimYHMES+56JWu71ADMrIJvN
	 r5wHsNzS3PHnA==
From: SeongJae Park <sj@kernel.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] selftests/mm: remove virtual_address_range test
Date: Fri, 16 Jan 2026 17:21:40 -0800
Message-ID: <20260117012141.224053-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260116132053.857887-1-lorenzo.stoakes@oracle.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 16 Jan 2026 13:20:53 +0000 Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:

[...]
> It therefore, sadly, seems that the best course is to remove this test
> altogether.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Acked-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

[...]

