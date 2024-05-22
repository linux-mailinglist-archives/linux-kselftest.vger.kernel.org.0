Return-Path: <linux-kselftest+bounces-10559-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB1878CBBAE
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 May 2024 09:05:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27E1E1C20999
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 May 2024 07:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D1A477F13;
	Wed, 22 May 2024 07:05:01 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C4862B9C2;
	Wed, 22 May 2024 07:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716361501; cv=none; b=WJ3ckDCzgGM6KioBxIAAgenPIedl91uicNlk1XzHcOPdxnsM854ri7p8IAL1lzeMZJchHN4ND8DUNiueF99Vg1/w2Q/3FQ6xuGiN66KB0dtaBt+NGvcRqq2bn4ozMsPgUKVlHYZnrLZUUtx0WQflolHuahvBXKhUktq4wjxmnxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716361501; c=relaxed/simple;
	bh=Maj4y6vtasFfUDF/5v7Lo3r/V1ateVquJu2HyG3+IQs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=odGVCy6P0ESCbCoWOh+8RsA+V7mnXFkZRgu7h1jfGyGQAtWAtQ6IdPgh5A3zVDa330+jTz7mP0B3UWGuDh4uEBIuigQjyvPuEB0GEfJWoDoFxnheq+0ncHA/aGlyLDu2A2X0HkCrdynKE0tcVwaQQy825Ma/lWPwMI4P4A+qwSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4A558339;
	Wed, 22 May 2024 00:05:17 -0700 (PDT)
Received: from e116581.blr.arm.com (e116581.arm.com [10.162.42.16])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 530BD3F766;
	Wed, 22 May 2024 00:04:50 -0700 (PDT)
From: Dev Jain <dev.jain@arm.com>
To: akpm@linux-foundation.org,
	shuah@kernel.org
Cc: linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Anshuman.Khandual@arm.com,
	kirill.shutemov@linux.intel.com,
	AneeshKumar.KizhakeVeetil@arm.com,
	Dev Jain <dev.jain@arm.com>
Subject: [PATCH 0/2] Restructure va_high_addr_switch
Date: Wed, 22 May 2024 12:34:33 +0530
Message-Id: <20240522070435.773918-1-dev.jain@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The va_high_addr_switch memory selftest tests out some corner cases
related to allocation and page/hugepage faulting around the switch
boundary. Currently, the page size and hugepage size have been statically
defined. Post FEAT_LPA2, the Aarch64 Linux kernel adds support for 4k and
16k translation granules on higher addresses; we restructure the test to
support the same. In addition, we avoid invocation of the binary twice,
in the shell script, to reduce test noise.

Dev Jain (2):
  selftests/mm: va_high_addr_switch: Reduce test noise
  selftests/mm: va_high_addr_switch: Dynamically initialize testcases to
    enable LPA2 testing

 .../selftests/mm/va_high_addr_switch.c        | 454 +++++++++---------
 .../selftests/mm/va_high_addr_switch.sh       |   4 -
 2 files changed, 232 insertions(+), 226 deletions(-)

-- 
2.34.1


