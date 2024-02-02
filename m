Return-Path: <linux-kselftest+bounces-4004-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DBA5846EEA
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Feb 2024 12:31:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0BEC1C2259A
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Feb 2024 11:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38ECF13DB9C;
	Fri,  2 Feb 2024 11:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="VdUv+YNe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75EC078B60;
	Fri,  2 Feb 2024 11:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706873493; cv=none; b=MQwfPulybT7wRfyf+oZ905GNJyfs6wmlAwjC2cZ3r7N8+DQzSNYARvlxUGCO+7SeNYVLk07m5UJ3ssNhlsXrQ6GdQHKfN5+cojp8fLR0ziVTN6hQ9VNNWLOslhH3CDvB4+EqLySJvG3QravcZJD+ImAn0ZObiIM+yR/iG/Ml2nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706873493; c=relaxed/simple;
	bh=LZHUHalENQlIbS78UvjPzT4WqCgnFzeIBvpGA8It2G8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b8XPqxhGfVIq84mj1i4NCwBccxWq2EA96KaxybaNd0qY/MHDbVluoz5p2ypjcSHcSl6sgII1ijxDhnZjSnPF6kPOX1agnF60guKucbuvCbG46Evb2ebllDxxH/IJoSE+StoW6+MpT6Bnkemdc0kKa0NDyZ64YihwFUOHGfp6Qgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=VdUv+YNe; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706873489;
	bh=LZHUHalENQlIbS78UvjPzT4WqCgnFzeIBvpGA8It2G8=;
	h=From:To:Cc:Subject:Date:From;
	b=VdUv+YNedFDnzk/G9FC/IMvlbLFt6rbkqapYqYgaeXp/zTnEECSoqgyxl+9gAeeRd
	 b35EV8Uys4SODxhinRGmvHmurs/8dL5zMB9DF1aOCgRodZKsangJ/8Oe9YU7yfne/m
	 fmiv11NkTx/yO5JRJWv4G4FGHsJp24L6AwmbBuyLUjPRYXKJm7PMvrjqRrwZwh13Ut
	 yc5e9XcqbhECOSCRf2UdOHnet0DDClltUY9UWpJiNAWPxhMiMqyV1OGuzW1cEuvhm+
	 6Hygh/ACe566l1c1CdIMaj1+rebvbY+xOgmhSPi79QeoXnMvGGcfmAguZjRIkj1BXR
	 kdFhQVpljNeEQ==
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id DB4F137811CF;
	Fri,  2 Feb 2024 11:31:27 +0000 (UTC)
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
	kernel@collabora.com,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 00/12] conform tests to TAP format output
Date: Fri,  2 Feb 2024 16:31:07 +0500
Message-ID: <20240202113119.2047740-1-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes since v1:
- Rebased the series on top of next-20240202

Muhammad Usama Anjum (12):
  selftests/mm: map_fixed_noreplace: conform test to TAP format output
  selftests/mm: map_hugetlb: conform test to TAP format output
  selftests/mm: map_populate: conform test to TAP format output
  selftests/mm: mlock-random-test: conform test to TAP format output
  selftests/mm: mlock2-tests: conform test to TAP format output
  selftests/mm: mrelease_test: conform test to TAP format output
  selftests/mm: mremap_dontunmap: conform test to TAP format output
  selftests/mm: split_huge_page_test: conform test to TAP format output
  selftests/mm: thp_settings: conform to TAP format output
  selftests/mm: thuge-gen: conform to TAP format output
  selftests/mm: transhuge-stress: conform to TAP format output
  selftests/mm: virtual_address_range: conform to TAP format output

 tools/testing/selftests/mm/khugepaged.c       |   3 +-
 .../selftests/mm/map_fixed_noreplace.c        |  96 ++----
 tools/testing/selftests/mm/map_hugetlb.c      |  42 ++-
 tools/testing/selftests/mm/map_populate.c     |  37 ++-
 .../testing/selftests/mm/mlock-random-test.c  | 136 ++++-----
 tools/testing/selftests/mm/mlock2-tests.c     | 282 +++++++-----------
 tools/testing/selftests/mm/mlock2.h           |  11 +-
 tools/testing/selftests/mm/mrelease_test.c    |  80 ++---
 tools/testing/selftests/mm/mremap_dontunmap.c |  32 +-
 .../selftests/mm/split_huge_page_test.c       | 161 +++++-----
 tools/testing/selftests/mm/thp_settings.c     | 123 +++-----
 tools/testing/selftests/mm/thp_settings.h     |   4 +-
 tools/testing/selftests/mm/thuge-gen.c        | 147 ++++-----
 tools/testing/selftests/mm/transhuge-stress.c |  36 ++-
 .../selftests/mm/virtual_address_range.c      |  44 +--
 tools/testing/selftests/mm/vm_util.c          |   6 +-
 16 files changed, 537 insertions(+), 703 deletions(-)

-- 
2.42.0


