Return-Path: <linux-kselftest+bounces-6015-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 826B68742D4
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Mar 2024 23:38:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B44231C22E8D
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Mar 2024 22:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 250FC1C6BE;
	Wed,  6 Mar 2024 22:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DIUpxR3V"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F891B806
	for <linux-kselftest@vger.kernel.org>; Wed,  6 Mar 2024 22:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709764690; cv=none; b=aWBYzzPRTdPEX/ipIcNXDgePNHkzGvZnFRzp1J7ilnwnvZ8E27M4hJdMew2ETGDdVnl2RbFXD/xk/EBfLMsFGxhAVpPCXhgk2LnA1eqOXRDf7BlylybWZlyfVoYzarEiGC4NgfgsNzNIV1laahHKi0SKe81+NIB+kGDB5BOaPWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709764690; c=relaxed/simple;
	bh=QMHws1QctT5NyUyniNy/i1yS7FjuctqycFRrFidhZb8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fu0m+qnK1qjt7O050v5dx1nSGSGdpvq2phttzMUiV8XPrmFSVjDeHZos8UK9hVpxk5yaNjxfvTy8vh5x4kId8Th/I+pNeNtqf1Ny/k1aRqk5Maa4dBtEhhOrmJGpz6oAD2KZCIwCJKVkEkDwkdLsBDGAvhtKGHqrea4f3OI8dXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DIUpxR3V; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709764687;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WhvHTa8E6KIfz47SC53e3jlZc8KPDvEvRYf6GRtCMqU=;
	b=DIUpxR3VFiTfKNEbbarPUtDc0HfThXwcU7So/bFDJNIxQDCQilXTg9p/T86YqP2tfEi8VM
	tHS4JecbYe9bySOD50oY+lKsMlCJwMNu6bkW4ldC1qDsK8sLidYoEEUUws74dJAtEmx+Vn
	IHAjRp4Qun/64B9zaD8O086NdyRD7qc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-QO_v-DYrOPqLzMUdIsx2gA-1; Wed, 06 Mar 2024 17:38:03 -0500
X-MC-Unique: QO_v-DYrOPqLzMUdIsx2gA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A430E857A81;
	Wed,  6 Mar 2024 22:38:02 +0000 (UTC)
Received: from localhost.redhat.com (unknown [10.22.9.120])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 1E907111D793;
	Wed,  6 Mar 2024 22:38:02 +0000 (UTC)
From: Nico Pache <npache@redhat.com>
To: linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: ben@decadent.org.uk,
	shuah@kernel.org,
	akpm@linux-foundation.org,
	usama.anjum@collabora.com
Subject: [PATCH v2 1/3] selftests/mm: Dont fail testsuite due to a lack of hugepages
Date: Wed,  6 Mar 2024 15:37:12 -0700
Message-ID: <20240306223714.320681-2-npache@redhat.com>
In-Reply-To: <20240306223714.320681-1-npache@redhat.com>
References: <20240306223714.320681-1-npache@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

On systems that have large core counts and large page sizes, but limited
memory, the userfaultfd test hugepage requirement is too large.

Exiting early due to missing one test's requirements is a rather aggressive
strategy, and prevents a lot of other tests from running. Remove the
early exit to prevent this.

Fixes: ee00479d6702 ("selftests: vm: Try harder to allocate huge pages")
Signed-off-by: Nico Pache <npache@redhat.com>
---
 tools/testing/selftests/mm/run_vmtests.sh | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/mm/run_vmtests.sh b/tools/testing/selftests/mm/run_vmtests.sh
index 246d53a5d7f28..727ea22ba408e 100755
--- a/tools/testing/selftests/mm/run_vmtests.sh
+++ b/tools/testing/selftests/mm/run_vmtests.sh
@@ -173,7 +173,6 @@ if [ -n "$freepgs" ] && [ -n "$hpgsize_KB" ]; then
 	if [ "$freepgs" -lt "$needpgs" ]; then
 		printf "Not enough huge pages available (%d < %d)\n" \
 		       "$freepgs" "$needpgs"
-		exit 1
 	fi
 else
 	echo "no hugetlbfs support in kernel?"
-- 
2.44.0


