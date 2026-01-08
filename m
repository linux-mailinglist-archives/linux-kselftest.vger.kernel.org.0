Return-Path: <linux-kselftest+bounces-48448-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C6CE4D0080C
	for <lists+linux-kselftest@lfdr.de>; Thu, 08 Jan 2026 01:57:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CF81130164ED
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Jan 2026 00:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCE941E5201;
	Thu,  8 Jan 2026 00:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SmWb3HEQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9381714F70;
	Thu,  8 Jan 2026 00:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767833834; cv=none; b=Eqo/vIqmCd0Ry+m2GeprBzcEkNKFLh8ku4zH3YDZEuUCwjfTNTDqNZY9M4DfHTnV2SpIv+s6b5X+ZCWHbxdicUdxpHz1YkBYKf4twgvsn28eD6EqvZTKgZtVp38mAUTr5Vy8bQQc0fCySUmEqF6yWCfaNyDn4Hvu5XSbbdhWQPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767833834; c=relaxed/simple;
	bh=CgxeBS/toh4Fwo2zQBVbFoBCp/GRXmjRjFe8ogXrwF4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lJnFhyMkyk7HI/9nXdFfd62nJm93DEQqi1/qPOwr/uGHEl6IawrSNpF5fwC5eDh7E6BOq6e2RLfI++xldqnx5o8tD76i/9N5n2/1ES2AS4e2s1GEdDrdcgMdVl/jVnBWqQVuvLGhv+3QGyAfeE9U548XRuBZGpt8DdSgTSiUChE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SmWb3HEQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A26A6C4CEF1;
	Thu,  8 Jan 2026 00:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767833834;
	bh=CgxeBS/toh4Fwo2zQBVbFoBCp/GRXmjRjFe8ogXrwF4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SmWb3HEQV6CtMvQoLUAWpPxdoEJ4TlLE18UlBE5XfBXdhVpS1Z+hYgyjCpJFxf5rl
	 AQrpBdhSXCr4McJx2ipBobWo6GrSiXn1DJeqkkX194C2HalqzgrDd6RUuiyV5PAkFk
	 KtNKyTDYf4mhbtrZAwi8P8lwykDtVW/lI6uhcb7e/G9IZwPcv0JFEu4U9VIn+4zFoL
	 1fu9nuBy5bP5BpYf5H35lUi8qFUyB3LvQWzNuyQYNtSzfF+dzkuQ1aIXdfYAv1/m//
	 n8hOMgZ3vpyJcJQh9zEsKr1MwniE9Bi5sOQcwjWagSZR/vA1W+R5mCD42opep9rsqS
	 03Hrb5mG29Uow==
From: SeongJae Park <sj@kernel.org>
To: Kevin Brodsky <kevin.brodsky@arm.com>
Cc: SeongJae Park <sj@kernel.org>,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Mark Brown <broonie@kernel.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH v2 4/8] selftests/mm: fix usage of FORCE_READ() in cow tests
Date: Wed,  7 Jan 2026 16:56:59 -0800
Message-ID: <20260108005700.79922-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260107164842.3289559-5-kevin.brodsky@arm.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed,  7 Jan 2026 16:48:38 +0000 Kevin Brodsky <kevin.brodsky@arm.com> wrote:

> Commit 5bbc2b785e63 ("selftests/mm: fix FORCE_READ to read input
> value correctly") modified FORCE_READ() to take a value instead of a
> pointer. It also changed most of the call sites accordingly, but
> missed many of them in cow.c. In those cases, we ended up with the
> pointer itself being read, not the memory it points to.
> 
> No failure occurred as a result, so it looks like the tests work
> just fine without faulting in. However, the huge_zeropage tests
> explicitly check that pages are populated, so those became skipped.
> 
> Convert all the remaining FORCE_READ() to fault in the mapped page,
> as was originally intended. This allows the huge_zeropage tests to
> run again (3 tests in total).
> 
> Fixes: 5bbc2b785e63 ("selftests/mm: fix FORCE_READ to read input value correctly")
> Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>

Acked-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

[...]

