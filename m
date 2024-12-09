Return-Path: <linux-kselftest+bounces-23001-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96C369E8F37
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Dec 2024 10:51:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF5EF1886645
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Dec 2024 09:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AB68216E10;
	Mon,  9 Dec 2024 09:50:48 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE6D121661A;
	Mon,  9 Dec 2024 09:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733737848; cv=none; b=Yw9VnyOCSkR0z4vn1tNGxelFax1rPnDBdUN9sMrI3ArdTyLdtFA3aBeKaQMj/0W6YQ2AeSslOg+ag8W5MSYWxoddjyAMOUCInJWGl3VGeo10RBHU55CTLEDxEO385O1A1FoJGEEoNsybGhZLx86dRU7bxMJ551oWfROid6IUCUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733737848; c=relaxed/simple;
	bh=wIpvmlCCeJJ3mu0DitBcMqePPrjK9lMxA+PwJdrL3wk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=igv92vTzuih0lQF/sxwTlx25lHi55eSIfcFBD3OaYu3Mc+64lrwpuwCkHQYC2kaDo+aGYWbA/VIXj0MPPm6xKay56tVMiL1FkRpDuRndiVPi4sj1D1lVGl7YQ0kQ8xy7JA1ffqbfDOP2H+Cf9m4KMTr/yzpkpG8VadxUBMGlT1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 44BAB143D;
	Mon,  9 Dec 2024 01:51:14 -0800 (PST)
Received: from e123572-lin.arm.com (e123572-lin.cambridge.arm.com [10.1.194.54])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3B6F33F720;
	Mon,  9 Dec 2024 01:50:44 -0800 (PST)
From: Kevin Brodsky <kevin.brodsky@arm.com>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	Kevin Brodsky <kevin.brodsky@arm.com>,
	akpm@linux-foundation.org,
	aruna.ramakrishna@oracle.com,
	catalin.marinas@arm.com,
	dave.hansen@linux.intel.com,
	joey.gouly@arm.com,
	keith.lucas@oracle.com,
	ryan.roberts@arm.com,
	shuah@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org,
	x86@kernel.org
Subject: [PATCH 03/14] selftests/mm: Fix strncpy() length
Date: Mon,  9 Dec 2024 09:50:08 +0000
Message-ID: <20241209095019.1732120-4-kevin.brodsky@arm.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241209095019.1732120-1-kevin.brodsky@arm.com>
References: <20241209095019.1732120-1-kevin.brodsky@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

GCC complains (with -O2) that the length is equal to the destination
size, which is indeed invalid. Subtract 1 from the size of the array
to leave room for '\0'.

Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
---
 tools/testing/selftests/mm/write_to_hugetlbfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/mm/write_to_hugetlbfs.c b/tools/testing/selftests/mm/write_to_hugetlbfs.c
index 1289d311efd7..34c91f7e6128 100644
--- a/tools/testing/selftests/mm/write_to_hugetlbfs.c
+++ b/tools/testing/selftests/mm/write_to_hugetlbfs.c
@@ -89,7 +89,7 @@ int main(int argc, char **argv)
 			size = atoi(optarg);
 			break;
 		case 'p':
-			strncpy(path, optarg, sizeof(path));
+			strncpy(path, optarg, sizeof(path) - 1);
 			break;
 		case 'm':
 			if (atoi(optarg) >= MAX_METHOD) {
-- 
2.47.0


