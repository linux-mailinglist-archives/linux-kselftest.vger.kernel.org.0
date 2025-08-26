Return-Path: <linux-kselftest+bounces-39919-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5346B35500
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Aug 2025 09:07:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0B50243075
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Aug 2025 07:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB8C42F6572;
	Tue, 26 Aug 2025 07:07:46 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 182542E1727;
	Tue, 26 Aug 2025 07:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756192066; cv=none; b=s9l901UINmliAkIcQQEocp+ubEKUk2zGs67RyS43alu3TGqSq7OOPSmSXD2OuRHIzdjcvVERr6ukwmdVNs6csPIS5L7xQ9a4K3FQHOSUus5XDMF5sFjRJ3ZzgXghmSKtWMvZWtAmv5mJvhlASi4IdAlDlcHvnWQ1AmzQ1ZOiD+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756192066; c=relaxed/simple;
	bh=JBBpMIQRn60+u8z1zAtEE86zoEsSFSgFHp+El1LyHts=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XnUHWMlo5lHphr0dhp709fryrHTEEMKyogRmfk+XLjGCLh633coFrTHjLCGb5OGjjRdHU3IsgbYbZEMg6hO/hAcYrXmYYim/D3eBBtTdLGDLTFhUWdn/wTw7YUkvUmmkouEPoNXFhdz2IwQ/qOwDRIHOLdVYYRFEssysVcK6III=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D68711BC0;
	Tue, 26 Aug 2025 00:07:28 -0700 (PDT)
Received: from localhost.localdomain (unknown [10.163.65.202])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 15C723F63F;
	Tue, 26 Aug 2025 00:07:30 -0700 (PDT)
From: Dev Jain <dev.jain@arm.com>
To: akpm@linux-foundation.org,
	david@redhat.com,
	shuah@kernel.org
Cc: lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	npache@redhat.com,
	ryan.roberts@arm.com,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dev Jain <dev.jain@arm.com>
Subject: [PATCH 0/2] selftests/mm: uffd-stress fixes
Date: Tue, 26 Aug 2025 12:37:03 +0530
Message-Id: <20250826070705.53841-1-dev.jain@arm.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset ensures that the number of hugepages is correctly set in the
system so that the uffd-stress test does not fail due to the racy nature of
the test. Patch 1 corrects the hugepage constraint in the run_vmtests.sh
script, whereas patch 2 corrects the constraint in the test itself.

Dev Jain (2):
  selftests/mm/uffd-stress: Make test operate on less hugetlb memory
  selftests/mm/uffd-stress: Stricten constraint on free hugepages before
    the test

 tools/testing/selftests/mm/run_vmtests.sh | 2 +-
 tools/testing/selftests/mm/uffd-stress.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
2.30.2


