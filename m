Return-Path: <linux-kselftest+bounces-8891-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A92E18B2D0E
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Apr 2024 00:24:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00FA8B221A6
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Apr 2024 22:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCF5415574E;
	Thu, 25 Apr 2024 22:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rnJioHsy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A34205A0EA;
	Thu, 25 Apr 2024 22:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714083824; cv=none; b=n/Qya5tf6aENM53O0nWBUwZ9IaphMZUZldV6hKXJOdaR+xNU4/TDXrCvPJ5Yq1/TvDpWvZPJB7KbYtBYXAEbdA3n6GFppRFlRFpMkCCTKMeQ+4CrVG56MvZE8I8L52/fhe+N3ZhCtzGZzfSMc9VN8K4CnJ8T6mfdSTqe20WfYVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714083824; c=relaxed/simple;
	bh=OJuThvfjoL/1z/8A1taGm21WkLvBecMRiDvFBv3kMTM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QBmYNm1wxreBJdFhmXdcCZnZ99Aj4X4cvOZ31617c2yQbMiG+KY5GIxE413ePeK+/x/O7iNdT0ErvC3rWzSVuK+Ic06v522f9UT9ecrcw9aDZK3b2kAN+1PzUQ3JXH2gl51F2Sj+CCx069ZhAbzPTjandvhmEfXBNbx89jrAqHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rnJioHsy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C367CC113CC;
	Thu, 25 Apr 2024 22:23:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714083824;
	bh=OJuThvfjoL/1z/8A1taGm21WkLvBecMRiDvFBv3kMTM=;
	h=From:To:Cc:Subject:Date:From;
	b=rnJioHsyVvg3MBwUOwbONZ/hKJA+sH2b4ENsiWEgccoSlcMI2jDQVgv84JZAQ8W2y
	 1xkvLo0KuyA9ojUJZSx6uDUsnax4SJf2Zo+0rGeFgJLJLpuM0T107ZBrLBM8pzjlUh
	 ZwNNQGoMPC8Lo6wYoDMkhKFts69Sxyw1jiPFdLExUkZt5dcwMigXniPOCIzuCTLjk6
	 Jpj8nRQJ1c5evPgqeMt8nDF793piE6aGrBbYrOH6yY/N+4Pv+d0QvM0I7rZBXK38oZ
	 Fhr1Sl7Yr2xDnfxD0Mmk+pqdTMKwdP/N6SKtWQRxOO7boPdeL2T/5RRd9h30BxR3LB
	 xBGfx8JabrN/g==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	linux-kselftest@vger.kernel.org,
	willemdebruijn.kernel@gmail.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 0/3] selftests: drv-net: round some sharp edges
Date: Thu, 25 Apr 2024 15:23:38 -0700
Message-ID: <20240425222341.309778-1-kuba@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I had to explain how to run the driver tests twice already.
Improve the README so we can just point to it.
Improve the config validation.

v2:
 - use split() in patch 2
 - more validation in last patch
v1: https://lore.kernel.org/r/20240424221444.4194069-1-kuba@kernel.org/

Jakub Kicinski (3):
  selftests: drv-net: extend the README with more info and example
  selftests: drv-net: reimplement the config parser
  selftests: drv-net: validate the environment

 .../testing/selftests/drivers/net/README.rst  | 97 ++++++++++++++++---
 .../selftests/drivers/net/lib/py/env.py       | 51 +++++++---
 2 files changed, 124 insertions(+), 24 deletions(-)

-- 
2.44.0


