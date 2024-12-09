Return-Path: <linux-kselftest+bounces-23057-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B4979E9EA7
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Dec 2024 20:00:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5CE5188885F
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Dec 2024 18:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 659EB19D071;
	Mon,  9 Dec 2024 18:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b="MvWk3WRF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A5E719D07A;
	Mon,  9 Dec 2024 18:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733770543; cv=pass; b=snTH21uOOvZn23P5Pg2GdqIbe7w7tZAvHjhw5aRxrAQqZjaa7/ouVyg2FIHnnzE5qlkPrILn3yHwBP/nyvr9Z/dCX400IfUOJiA6WBRliTYidhOFQJ3cctGMUtpEF/4gIvI6o7KPZQw9E/YaSH2J6o4TgmvTJTXELT5HcShS3w0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733770543; c=relaxed/simple;
	bh=3R1h6svD0lIfcxLcz0Vc9HntsUuEWub4gv+2p4nSa6g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=e8lGv/RSjKMx/Kk4SIsbymR1HUebKHdmHCWn4Mnj3HRh4dUV/ADth5mXkBjvC9mq0R0cIgFHq5KzSmHpRkkbcm5SgrL7pyYvoYz3wgnyUyKH9Lh0w5dWLPYQjfBkMqXk65HfRX3TLY9xCopqWcZOBtJo/VDVM62t7rBuX8HaYeY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b=MvWk3WRF; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1733770524; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=GOF+BRe2qDbxSrSuEoo299zjprEd1Hby238PQ4x3DNO6A7sopNljSA1qwuzYla4f6HLGLejSvNS+YxX6f6LtWZNJO71WX8xrXvXD6X6OXX6rR8JylWzr7wCIfw1MnZfVA5DhicJauIQslBlOo4+TD5zk14sRVWERNhqnM5Ci4wc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1733770524; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=pIQAAr0s4V5rZOCAZkw1ZbSm94i/7OwYX+Tmg9oB6yg=; 
	b=N0rH3zKTWHD9/rdvTaXWPUGbsvam3V1M7Z+OdYmCColS1r5FbpesKSSi91HbszpnCOqJ4e6OglCb7Yuo98sZBoC8T3nxYXaZcwZhELyohx9FHjHC6MVsCnhX0tADPesn27gECVkHI5bZVRgLK/utrf2gvzVlJ9nI7ZoYkVpHGHg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=usama.anjum@collabora.com;
	dmarc=pass header.from=<usama.anjum@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1733770524;
	s=zohomail; d=collabora.com; i=usama.anjum@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=pIQAAr0s4V5rZOCAZkw1ZbSm94i/7OwYX+Tmg9oB6yg=;
	b=MvWk3WRFGBbP9+pOaFxl3YIFod4x6xYDGvFxl6WOadNjMv6FLBdc/JbFxMGZ3mtX
	O4FwDdrvmemufbUdVI5hQJqC7A2XE0fH6Zs6RlGJf9kDRoT5+kvNge3j96x/JGZBiZB
	6n0kmmXiDWq197xXPdBiniqboxPU06BWcKZ5x2yU=
Received: by mx.zohomail.com with SMTPS id 1733770522520188.72284005113454;
	Mon, 9 Dec 2024 10:55:22 -0800 (PST)
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	David Hildenbrand <david@redhat.com>,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
	kernel@collabora.com
Subject: [PATCH 0/4] selftest/mm: Remove warnings foun
Date: Mon,  9 Dec 2024 23:55:19 +0500
Message-Id: <20241209185523.2242089-1-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Recently, I reviewed a patch on the mm/kselftest mailing list about a
test which had obvious type mismatch fix in it. It was strange why that
wasn't caught during development and when patch was accepted. This led
me to discover that those extra compiler options to catch these warnings
aren't being used. When I added them, I found tens of warnings in just
mm suite.

In this series, I'm fixing those warnings in a few files. More fixes
would be sent later.

Muhammad Usama Anjum (4):
  selftests/mm: thp_settings: remove const from return type
  selftests/mm: pagemap_ioctl: Fix types mismatches shown by compiler
    options
  selftests/mm: mseal_test: remove unused variables
  selftests/mm: mremap_test: Remove unused variable and type mismatches

 tools/testing/selftests/mm/mremap_test.c   |  15 +--
 tools/testing/selftests/mm/mseal_test.c    |   8 +-
 tools/testing/selftests/mm/pagemap_ioctl.c | 108 +++++++++++----------
 tools/testing/selftests/mm/thp_settings.c  |   4 +-
 tools/testing/selftests/mm/thp_settings.h  |   4 +-
 tools/testing/selftests/mm/vm_util.c       |   2 +-
 6 files changed, 75 insertions(+), 66 deletions(-)

-- 
2.39.5


