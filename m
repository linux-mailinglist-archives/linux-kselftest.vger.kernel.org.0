Return-Path: <linux-kselftest+bounces-12791-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0812F9181AF
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jun 2024 15:06:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71A8FB249ED
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jun 2024 13:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C90DD18413F;
	Wed, 26 Jun 2024 13:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PHt+nV5M"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0A718411D
	for <linux-kselftest@vger.kernel.org>; Wed, 26 Jun 2024 13:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719407136; cv=none; b=giSp52T04VhTP5bhipKvV69vSCdmV/CGijrcXN4ygHAEs+BqR2n5TSp8GzlZJiD0Ep7uVro5FkXdLHqU5rBWV/vw9Vrg/cqlwz4Y294BBWB0E+s5YY7SPrykEqHwwBZs0jSkRiU8EdurZ9XH+6ByjuUdl09+VifaoVSMays9Ieo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719407136; c=relaxed/simple;
	bh=qEhLQdr86USC/5RuNtoQJZNoL2ffiEHDGtZJnWtPsXA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ku1yDisO6zyWOtV8fk7XjEws1k6G5LsOsNbpsd6pfijP3grcSRgaaRxLOYZarBD6iukQKQqpqkv7AFqrGZG0BTGQgMi9mC7gOc+LC84Nl+yojonmF+lKV0NaMZryHO5ZBX1Bqgp500bIsQB+xKRXzi4V5p3uoVoUplh0Q22od0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PHt+nV5M; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719407134;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JykDiXdqlJ6ciyv4C7jHD9UAaumemJj0MYtCVwinG38=;
	b=PHt+nV5MgByDFR2wogoNEmKMOYYp17gqovbzTKIUppUZBMmVMt7ViITWGardRzPCL3mjs7
	NvfdMBd/H8d4hJ78eDclOAXDMhRkRo0CKVGWJ2+ugJZAmUVBptwvZGIz9rU1gaVXE5AsF5
	JcEG2VGYNaxXMeCN64YtNSxK91u5uhE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-18-ITRtfxPeOlmGxIiufKwUFg-1; Wed,
 26 Jun 2024 09:05:31 -0400
X-MC-Unique: ITRtfxPeOlmGxIiufKwUFg-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 04A4E19560A7;
	Wed, 26 Jun 2024 13:05:28 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.34.168])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 117261956050;
	Wed, 26 Jun 2024 13:05:24 +0000 (UTC)
From: Audra Mitchell <audra@redhat.com>
To: viro@zeniv.linux.org.uk
Cc: brauner@kernel.org,
	jack@suse.cz,
	aarcange@redhat.com,
	akpm@linux-foundation.org,
	rppt@linux.vnet.ibm.com,
	shli@fb.com,
	peterx@redhat.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	raquini@redhat.com,
	linux-mm@kvack.org
Subject: [PATCH v3 3/3] Turn off test_uffdio_wp if CONFIG_PTE_MARKER_UFFD_WP is not configured.
Date: Wed, 26 Jun 2024 09:05:13 -0400
Message-ID: <20240626130513.120193-3-audra@redhat.com>
In-Reply-To: <20240626130513.120193-1-audra@redhat.com>
References: <20240626130513.120193-1-audra@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

If CONFIG_PTE_MARKER_UFFD_WP is disabled, then we turn off three features
in userfaultfd_api (UFFD_FEATURE_WP_HUGETLBFS_SHMEM,
UFFD_FEATURE_WP_UNPOPULATED, and UFFD_FEATURE_WP_ASYNC). Currently this
test always will call uffdio_regsiter with the flag
UFFDIO_REGISTER_MODE_WP. However, the kernel ensures in vma_can_userfault
that if the feature UFFD_FEATURE_WP_HUGETLBFS_SHMEM is disabled, only
allow the VM_UFFD_WP on anonymous vmas, meaning our call to
uffdio_regsiter will fail. We still want to be able to run the test even
if we have CONFIG_PTE_MARKER_UFFD_WP disabled, so check to see if the
feature UFFD_FEATURE_WP_HUGETLBFS_SHMEM has been turned off in the test
and if so, disable us from calling uffdio_regsiter with the flag
UFFDIO_REGISTER_MODE_WP.

Signed-off-by: Audra Mitchell <audra@redhat.com>
---
 tools/testing/selftests/mm/uffd-stress.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/selftests/mm/uffd-stress.c b/tools/testing/selftests/mm/uffd-stress.c
index b9b6d858eab8..3266ae885f75 100644
--- a/tools/testing/selftests/mm/uffd-stress.c
+++ b/tools/testing/selftests/mm/uffd-stress.c
@@ -419,6 +419,9 @@ static void parse_test_type_arg(const char *raw_type)
 	test_uffdio_wp = test_uffdio_wp &&
 		(features & UFFD_FEATURE_PAGEFAULT_FLAG_WP);
 
+	if (test_type != TEST_ANON && !(features & UFFD_FEATURE_WP_HUGETLBFS_SHMEM))
+		test_uffdio_wp = false;
+
 	close(uffd);
 	uffd = -1;
 }
-- 
2.44.0


