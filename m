Return-Path: <linux-kselftest+bounces-40940-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE02BB48E0C
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Sep 2025 14:49:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD5923419BF
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Sep 2025 12:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1235304BDB;
	Mon,  8 Sep 2025 12:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OblUx51x"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D77E630496A
	for <linux-kselftest@vger.kernel.org>; Mon,  8 Sep 2025 12:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757335679; cv=none; b=HSk57FT/56OTj8tcFsNIdQCM4rWDwTq21lc7oT8c4RgrY4Wni5+oIyndEt6U4iYAvijouj02lvl4I9n2Nl8GZTHJPovTCsJfvcOxc5HcEwb/Ybq+dDvzDfdmFcqL3XxiKtCjUunLnQ17RDW7+gdIqoN/dvlHxOB0pWnxF0HSKXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757335679; c=relaxed/simple;
	bh=CuiJ+AC17Kj288Ih1c5D12rNdUHse5TIb+qZzvjH44s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=inmuyxUsMovB3CDOs4rndAP7TDmTb1tn2Ef19fYhs0DeqnNIe/Ap+Lcls3DUsOrkt666BMnJwUq6jz9YsWH+N47GLQqOS+c8TEsRdpwwwt8cVma8G7IaHiefcxsPgt0WuUq9vhQ/HBXck5IOX5qkCRQsJc2Crttr6esryX1FZXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OblUx51x; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757335675;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=aevj+k7+HSbyx1kuE19JILsk9KtpoCEGQ/zs/FNoek4=;
	b=OblUx51xXIA2fDP40lLHFeUIrTlBGzEorHfPYeIYEXA3hor/Cx5hzE02D2O4hU3049aMPn
	b0oQCo7OtDiJb9vpJon8KTUAy/yIkFy9Xl2AoIWd9GFVLPd4af5fk8SzhczJ4uMJFOz2xv
	CbnhNZeyEIpzWQMgN5n+pvEHHfWeHEE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-594-i4kBMdJ5PL-PQnfrQkaxNg-1; Mon,
 08 Sep 2025 08:47:52 -0400
X-MC-Unique: i4kBMdJ5PL-PQnfrQkaxNg-1
X-Mimecast-MFC-AGG-ID: i4kBMdJ5PL-PQnfrQkaxNg_1757335671
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BBA2B1800451;
	Mon,  8 Sep 2025 12:47:50 +0000 (UTC)
Received: from dell-per7425-02.rhts.eng.pek2.redhat.com (dell-per7425-02.rhts.eng.pek2.redhat.com [10.73.116.18])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 271C6300018D;
	Mon,  8 Sep 2025 12:47:44 +0000 (UTC)
From: Chunyu Hu <chuhu@redhat.com>
To: akpm@linux-foundation.org,
	david@redhat.com,
	shuah@kernel.org,
	linux-mm@kvack.org
Cc: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	chuhu@redhat.com
Subject: [PATCH v2 0/3] Fix va_high_addr_switch.sh test failure
Date: Mon,  8 Sep 2025 20:47:36 +0800
Message-ID: <20250908124740.2946005-1-chuhu@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

The three patches fix the va_high_addr_switch.sh test failure on x86_64.

Patch 1 fixes the hugepage setup issue that nr_hugepages is reset too
early in run_vmtests.sh and break the later va_high_addr_switch testing.

Patch 2 adds hugepage setup in va_high_addr_switch test, so that it can
still work if vm_runtests.sh changes the hugepage setup someday.

Patch 3 fixes the test failure caused by the hint addr align method change
in hugetlb_get_unmapped_area().

Changes in v2:
 - patch 1 renames nr_hugepgs_origin to orig_nr_hugepgs
 - add a patch 2 to setup hugeapges in va_high_addr_switch test

Chunyu Hu (3):
  selftests/mm: fix hugepages cleanup too early
  selftests/mm: alloc hugepages in va_high_addr_switch test
  selftests/mm: fix va_high_addr_switch.sh failure on x86_64

 tools/testing/selftests/mm/run_vmtests.sh     |  9 ++++-
 .../selftests/mm/va_high_addr_switch.c        |  4 +-
 .../selftests/mm/va_high_addr_switch.sh       | 37 +++++++++++++++++++
 3 files changed, 46 insertions(+), 4 deletions(-)

-- 
2.49.0


