Return-Path: <linux-kselftest+bounces-23058-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E68579E9EAB
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Dec 2024 20:01:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 757AC28294D
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Dec 2024 19:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09A451990AF;
	Mon,  9 Dec 2024 18:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b="DG61zZ0m"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 421FC19343B;
	Mon,  9 Dec 2024 18:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733770600; cv=pass; b=bVxaf/oUelNyn6e+pqsG6TJ+nFEISuEHsjM8vzc/v5xDvwFcXHFDiLy1Ui1gyT41L1Ts90KD3PdbxDQluhmEEPvpvpaLB7GHvIVLPGY37BfynAxe6TA4Hn/bVyt+uQGOLC8qRD+F3MdiBVu3/Pk010swxA2IH/CXCVZoCdkmzxw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733770600; c=relaxed/simple;
	bh=3R1h6svD0lIfcxLcz0Vc9HntsUuEWub4gv+2p4nSa6g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UQ4fpkS1W8QHPPm+9A+rNmVsDTS3gXFIuThnMtQ6rsF23hGiadqF1VPoKp2L2G8Dnh7bV51HvHEcM02wYk3miu6EjwhyOLMB4DVXa7+ya3sWYZ7K1V6s/UiBL+lefXNsvYN6ICdd+4rmNtSkIQ77XzKRjOlwVMq40R1rN8N90TU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b=DG61zZ0m; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1733770584; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=lGR4lGg787LeCSb+a+4PddHWEHv2zFMMHFlbksCcUjXWRnuPerxXr7iOs/vSEFW61U7odDtOyx5J+8Job3TLUcYE+997VQS2PjZhleDcNATm5bMB6+2zneU6gp22G/THGiASVl7Dc6mJJTNr1D6qfs2O+I7U6pvS9qsEtEHIg4I=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1733770584; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=pIQAAr0s4V5rZOCAZkw1ZbSm94i/7OwYX+Tmg9oB6yg=; 
	b=hH+cl/oZ5G3zw2o5NjjCJDWk5z+nW51r6VdD6QMOp1/H/fWL296Sfz4gnTRh8kS0jXwSa9dDxdGi673dt6bIvZFpo1+9V2OgV2RLg1smMdXNOtQjrOhqzKO2ntsLXDay/lhFnf8YqBjkf1LMI7E8Ely0ZoPgCoKdu/wFQAcUxHM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=usama.anjum@collabora.com;
	dmarc=pass header.from=<usama.anjum@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1733770584;
	s=zohomail; d=collabora.com; i=usama.anjum@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=pIQAAr0s4V5rZOCAZkw1ZbSm94i/7OwYX+Tmg9oB6yg=;
	b=DG61zZ0masTRH6n5IEZILsuzC1K6VYo0JddyqbcrciKP+iGwsBLKLF1wA2UqnaBy
	f70p48eFeXnK3gjDxnGNL34itv+Sy/PcsQpjR7KshRk3ffJrIMDO8vtaQ92/g9TGGkb
	l256lAqniVacapeKD08Dcgg3v3NzUdhm52Dm3h7A=
Received: by mx.zohomail.com with SMTPS id 1733770582328336.33983168763575;
	Mon, 9 Dec 2024 10:56:22 -0800 (PST)
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
Subject: [PATCH 0/4] selftest/mm: Remove warnings found by adding compiler flags
Date: Mon,  9 Dec 2024 23:56:20 +0500
Message-Id: <20241209185624.2245158-1-usama.anjum@collabora.com>
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


