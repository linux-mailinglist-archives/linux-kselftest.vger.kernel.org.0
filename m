Return-Path: <linux-kselftest+bounces-9644-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 443118BEDC5
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 May 2024 22:06:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7667D1C21C07
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 May 2024 20:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B40FC16F847;
	Tue,  7 May 2024 19:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tsss8UTa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D01F16F283
	for <linux-kselftest@vger.kernel.org>; Tue,  7 May 2024 19:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715111727; cv=none; b=JtQz2JTaAdjhM0AzW/3J4u0LzSIKssZths6kKg1ZsMD1im7MvHBPhJk9QuskZ5I31phEV1jtlORXvmu6Fkf/SuZ8jarsYlLSmx83a2FUGOlJXuvYKUgG1xM064heb4NaTCseN9CqAAZKrGgQ7wUS3zsmg07Zd5/tptEZguFiF+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715111727; c=relaxed/simple;
	bh=qkKdzACF1keOV6J4gFQTNFSJosbImY3UiiUaqJIsSvI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LQdqHRJOo757zloB1vXeBLeK6aHOafO6t2vBxLv8U/E9Wy9Zn/0yhx3PQ8qH2MfjMjummGx/tEfzXN4sfxPOJnj/GEwmCW5vu7FHXD0LqolSdmIRrpWNijGYsxjwSfIRrbjbT/rMI3PP6MCkQhpY5y0zUheBiogQX3+asfJxvzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Tsss8UTa; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715111723;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=udTceohd6Xr0o0t6E07fDA2ozt9gdMnkrdCtTzzon0Y=;
	b=Tsss8UTaR+9ak9f6HqX51/XRUjICsw/HQKdiupO8ORB1LB8svo2vxW1vec19M74mUO0oAq
	YBOMXMTcl8ZaXsLlxDoUHUtH0UqecuxGulyh/GEv7+TjZGKFJly8swMkpsMC7cp/LSNpVZ
	/nIVsY634AZcBcXFIVwzzoLTy0r17zA=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-677-1kGYvzdaMBCNdauAjag6xQ-1; Tue,
 07 May 2024 15:55:17 -0400
X-MC-Unique: 1kGYvzdaMBCNdauAjag6xQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 524043803523;
	Tue,  7 May 2024 19:55:17 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.18.45])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 16DA220B96E0;
	Tue,  7 May 2024 19:55:17 +0000 (UTC)
From: Audra Mitchell <audra@redhat.com>
To: viro@zeniv.linux.org.uk
Cc: brauner@kernel.org,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	raquini@redhat.com
Subject: [PATCH 2/2] Update uffd-stress to handle EINVAL for unset config features
Date: Tue,  7 May 2024 15:55:10 -0400
Message-ID: <20240507195510.283744-2-audra@redhat.com>
In-Reply-To: <20240507195510.283744-1-audra@redhat.com>
References: <20240507195510.283744-1-audra@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

Now that we have updated userfaultfd_api to correctly return
EIVAL when a feature is requested but not available, let's fix
the uffd-stress test to only set the UFFD_FEATURE_WP_UNPOPULATED
feature when the config is set. In addition, still run the test if
the CONFIG_PTE_MARKER_UFFD_WP is not set, just dont use the corresponding
UFFD_FEATURE_WP_UNPOPULATED feature.

Signed-off-by: Audra Mitchell <audra@redhat.com>
---
 tools/testing/selftests/mm/uffd-stress.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/mm/uffd-stress.c b/tools/testing/selftests/mm/uffd-stress.c
index f78bab0f3d45..b9b6d858eab8 100644
--- a/tools/testing/selftests/mm/uffd-stress.c
+++ b/tools/testing/selftests/mm/uffd-stress.c
@@ -38,6 +38,8 @@
 
 #ifdef __NR_userfaultfd
 
+uint64_t features;
+
 #define BOUNCE_RANDOM		(1<<0)
 #define BOUNCE_RACINGFAULTS	(1<<1)
 #define BOUNCE_VERIFY		(1<<2)
@@ -247,10 +249,14 @@ static int userfaultfd_stress(void)
 	unsigned long nr;
 	struct uffd_args args[nr_cpus];
 	uint64_t mem_size = nr_pages * page_size;
+	int flags = 0;
 
 	memset(args, 0, sizeof(struct uffd_args) * nr_cpus);
 
-	if (uffd_test_ctx_init(UFFD_FEATURE_WP_UNPOPULATED, NULL))
+	if (features & UFFD_FEATURE_WP_UNPOPULATED && test_type == TEST_ANON)
+		flags = UFFD_FEATURE_WP_UNPOPULATED;
+
+	if (uffd_test_ctx_init(flags, NULL))
 		err("context init failed");
 
 	if (posix_memalign(&area, page_size, page_size))
@@ -385,8 +391,6 @@ static void set_test_type(const char *type)
 
 static void parse_test_type_arg(const char *raw_type)
 {
-	uint64_t features = UFFD_API_FEATURES;
-
 	set_test_type(raw_type);
 
 	if (!test_type)
@@ -409,8 +413,8 @@ static void parse_test_type_arg(const char *raw_type)
 	 * feature.
 	 */
 
-	if (userfaultfd_open(&features))
-		err("Userfaultfd open failed");
+	if (uffd_get_features(&features))
+		err("failed to get available features");
 
 	test_uffdio_wp = test_uffdio_wp &&
 		(features & UFFD_FEATURE_PAGEFAULT_FLAG_WP);
-- 
2.44.0


