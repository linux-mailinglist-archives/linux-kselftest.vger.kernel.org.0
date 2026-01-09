Return-Path: <linux-kselftest+bounces-48578-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B4CCD06BDC
	for <lists+linux-kselftest@lfdr.de>; Fri, 09 Jan 2026 02:30:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 18A35303BFA5
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Jan 2026 01:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54B591A83F9;
	Fri,  9 Jan 2026 01:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vQovDXVe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A63219A7A;
	Fri,  9 Jan 2026 01:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767922217; cv=none; b=D0bex9hyMXstGPXNbOFRfiu6OCPeL53WsncuUhvelQR6w4n7Nu9NHqK+lUY4C33nMJSnaM2YrknTYH7a7d9pus/UJdiCpJDhFXavkAJWWRLNQlZxTJIMl0esi/wyV1VetWcLKWPORI5FK2kjh/ntLsYDU6UKhYIpTtw+DVqR0aY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767922217; c=relaxed/simple;
	bh=c4Rl9rf3K+A4EsY02anP15UAm6twZEGiXt9HoSy2sHQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PkL6/5ZuUbA8Q2RUA/HRTLqK1THK5iNemRR+7k1UHAuAIjBg1eEhs06IOTS00l1L9TZjmahvsyVHwRM405bq3GMAx1TSiCcGL2nBosB5K4THPRSQ5/YbGxkbAkIBhrzTMeAOxl/MLTmNYVq83Kv2DVronxvFWr55p34QFXWzRKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vQovDXVe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C1CCC116C6;
	Fri,  9 Jan 2026 01:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767922216;
	bh=c4Rl9rf3K+A4EsY02anP15UAm6twZEGiXt9HoSy2sHQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vQovDXVe6c6VHLNf2U5IVI1CbFHOJAuMVIWyauRtl0wVLIOZUu3odYTW/zqZhHXic
	 EpMOf+wLt2LsYaeS6zcGRhy+wiYzAdKwcuz2BZP4KYI1TqC0GwbzEpzB5OTpa1shqt
	 +0a+Bvzn840zp0kJAIc7uTGkAXXY0I1OYWcbAoCiU5WRW02aP7Pa7ChyfC0NpLY5Z4
	 dpE//cZMkaBE115uDFJNH95+KcqKzLIO7guxRmnM9S0MHbKyASgGQ0c6iMznFxysiK
	 DWFh+xvB1P0KzguOOkAL96ZCtvMAPTA6ysDt5YPbLcynlePoOfYPDpljfpGLPxXEJ9
	 zQkn0aBgeaiSQ==
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
Subject: Re: [PATCH v2 5/8] selftests/mm: introduce helper to read every page in range
Date: Thu,  8 Jan 2026 17:30:08 -0800
Message-ID: <20260109013009.68474-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260107164842.3289559-6-kevin.brodsky@arm.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed,  7 Jan 2026 16:48:39 +0000 Kevin Brodsky <kevin.brodsky@arm.com> wrote:

> FORCE_READ(*addr) ensures that the compiler will emit a load from
> addr. Several tests need to trigger such a load for every page in
> the range [addr, addr + len), ensuring that every page is faulted
> in, if it wasn't already.
> 
> Introduce a new helper force_read_pages_in_range() that does exactly
> that and replace existing loops with a call to it.

Seems like a good cleanup to me.

> Some of those
> loops have a different step size, but reading from every page is
> appropriate in all cases.

So the test program's behavior is slightly be changed.  I believe that
shouldn't be problem, but I'm not that familiar with the test code, so not very
sure.  I'd like to listen voices from people more familiar with those.

Meanwhile, I'm curious what do you think about making the helper function
receives the step size together, and let the callers just pass their current
step size.


Thanks,
SJ

[...]

