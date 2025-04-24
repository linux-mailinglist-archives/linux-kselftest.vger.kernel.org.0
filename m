Return-Path: <linux-kselftest+bounces-31611-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B92B2A9BB08
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Apr 2025 01:02:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC157189DB96
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Apr 2025 23:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F02E6226D0A;
	Thu, 24 Apr 2025 23:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jvkvJN12"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D4521FF2C;
	Thu, 24 Apr 2025 23:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745535724; cv=none; b=AyFXFAf/O2rfqgaru8nu2hxLw1/wsBQyldUlX6hmGhyxftzwP1n3RDEB4mV2b5GucV0Ued/E68RyWpEmENoo0Lsw8DhM8Rk1Wt81nvua7h1DlJopbvf8hgKajfG/6jpcbhX5KdO4sZ8sNAbn0cfw7QWfG+EifRig0z2bZqH8bNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745535724; c=relaxed/simple;
	bh=RM2OYSddyxLHI66KofXsa3+Uz916VuEHEO3+6YWhVJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u7aXGRVOsDqsIsNkN7TV/SEdBDZd2oUZ94mCzhwOoBu9GtrVAlX0vvOUFw3Goj7WiGnsTmby1xuUoqm1gk7VG29+XCiBY3c7YeI+ljEs5uMZ/2n9l7BNgfaZ/xfw+dtxGnLCAz+0T/O8A5/PXCzT/yqz9x0hHhbRRiEAr5zPs/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jvkvJN12; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2A85C4CEE3;
	Thu, 24 Apr 2025 23:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745535724;
	bh=RM2OYSddyxLHI66KofXsa3+Uz916VuEHEO3+6YWhVJ0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jvkvJN124qP1LoHaO4rrv/8YPF2OGfg2iIxudbPiQAG2R+HUJvJgtgt5/poGwg6Hb
	 9AOGhrFj+661tE5qnnpQM0gqniHqRpJsl5hXfzAGa6kaHENdPQG0n+qHg8qmOqQaJE
	 pfO5IS/eL150Up7nCN5yKo008O8BAeTH3YXeCvjV0hp87U5PkfyZ4uplI4A8zKYYUX
	 AtKw3hFH7NXuHGTgFZKwQDbGvi6MI6AfUQkrF1+Dff8sdLxYfZo1VCkmw4EN3HkDFg
	 039bk1CNEOJholGcLMv7ieZmfVzTSmzUQP7NGZ4U7CvlNHOUlMcX/lALgc/kCdeSLh
	 WxbxA95Pxd7HQ==
Date: Thu, 24 Apr 2025 16:02:02 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Felix Maurer <fmaurer@redhat.com>
Cc: socketcan@hartkopp.net, mkl@pengutronix.de, shuah@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, linux-can@vger.kernel.org, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, dcaratti@redhat.com, fstornio@redhat.com
Subject: Re: [PATCH 0/4] selftest: can: Start importing selftests from
 can-tests
Message-ID: <20250424160202.52472f66@kernel.org>
In-Reply-To: <cover.1745323279.git.fmaurer@redhat.com>
References: <cover.1745323279.git.fmaurer@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 22 Apr 2025 14:02:33 +0200 Felix Maurer wrote:
> I have cc'ed netdev and its reviewers and maintainers to make sure they
> are okay with the location of the tests and the changes to the paths in
> MAINTAINERS. The changes should be merged through linux-can-next and
> subsequent changes will not go to netdev anymore.

Makes perfect sense to me as well, FWIW.

