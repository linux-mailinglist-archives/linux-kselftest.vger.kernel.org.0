Return-Path: <linux-kselftest+bounces-40037-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF11EB37C3B
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Aug 2025 09:52:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E33171891605
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Aug 2025 07:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D018931B119;
	Wed, 27 Aug 2025 07:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fdBr6Pht"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 446D1319862
	for <linux-kselftest@vger.kernel.org>; Wed, 27 Aug 2025 07:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756281151; cv=none; b=HJ7Vl4w8lVU17mykRY83orDL37nuJJXIJcc0g0ARWuEGqNDjcZNKpXmF2NwlcZF2Fssg0Muwss//NZI4RJKofMHsGHRusF8QmtjUZ6euNUTX4qyTXjnMuw1o9vyfXsEieT1CNIdCd+BRVx5aCf3mZORZWiDG4pKEDE3TIV1NuiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756281151; c=relaxed/simple;
	bh=dg56cDVzVKF5RZZcfZmiI2WJCoLUQN9GcG/PmKry18c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Xcp6SBzvPZqKplqJryD4NpSyStU4x9+WKJUGBu2/Nvk3x9bNO3ism9XnwnQd/QyYAIfp9qk2gL2karUwkBaBnTzYAx3m+xP8qD2GlrPuM94JDvb5jg4U1rDoea+veS0HwHNXKxoQNYkCRO+nUshX5xVxv/3zVvolA7RA8O8joHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fdBr6Pht; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756281149;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=N6SntE+UiHIpGFBxOP3k+c2SCeNJCrXgtm7HmQ15Vds=;
	b=fdBr6PhtQNqMREnAC2FEfyBPO5yo3E9tVOk+TZ46q6kXF79xoz+NCjVKwC1o1F6quEWfyV
	osUP73Fnpt7SKNk9SclAUWbQYm0wIikISG1c48t5rXxeJGjWiVSibSZDEf/KczyTG3S1/9
	R3I+htpA/QZ9JEicqKdS4Yp7I7rdp6g=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-76-iZHGTYBHNge45eseCba7nw-1; Wed,
 27 Aug 2025 03:52:25 -0400
X-MC-Unique: iZHGTYBHNge45eseCba7nw-1
X-Mimecast-MFC-AGG-ID: iZHGTYBHNge45eseCba7nw_1756281140
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5354319560B4;
	Wed, 27 Aug 2025 07:52:20 +0000 (UTC)
Received: from dell-per7425-02.rhts.eng.pek2.redhat.com (dell-per7425-02.rhts.eng.pek2.redhat.com [10.73.116.18])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4A23E180044F;
	Wed, 27 Aug 2025 07:52:13 +0000 (UTC)
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
Subject: [PATCH 0/2] Fix va_high_addr_switch.sh test failure
Date: Wed, 27 Aug 2025 15:52:07 +0800
Message-ID: <20250827075209.2347015-1-chuhu@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

The two patches fix the va_high_addr_switch.sh test failure on x86_64.
Patch 1 fixes the hugepages setup issue that nr_hugepages is reset too
early in run_vmtests.sh and break the later va_high_addr_switch testing.
Patch 2 fixes the test failure caused by the hint addr align method change
in hugetlb_get_unmapped_area().

Chunyu Hu (2):
  selftests/mm: fix hugepages cleanup too early
  selftests/mm: fix va_high_addr_switch.sh failure on x86_64

 tools/testing/selftests/mm/run_vmtests.sh        | 9 +++++++--
 tools/testing/selftests/mm/va_high_addr_switch.c | 4 ++--
 2 files changed, 9 insertions(+), 4 deletions(-)

-- 
2.49.0


