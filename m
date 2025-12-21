Return-Path: <linux-kselftest+bounces-47785-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DC47CD3B43
	for <lists+linux-kselftest@lfdr.de>; Sun, 21 Dec 2025 05:02:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 80FBB3025A44
	for <lists+linux-kselftest@lfdr.de>; Sun, 21 Dec 2025 04:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8686221554;
	Sun, 21 Dec 2025 04:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A7TMyPPl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 702F31F1537
	for <linux-kselftest@vger.kernel.org>; Sun, 21 Dec 2025 04:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766289671; cv=none; b=AL7Y0WGRgZ2gKy5NaxSnOkhqFIHswfKZH0f8SztI1frvkGMk78FMsLGCdO6bw//kBwjXyeLOJCtLD/YsRX5uKr/+eAVamvP589/G+kc8wTgV1tfrtuX3hXjWwVLCU1wO8KANBIO2P7fRmLI+eUFD4NAo4NV20KaFWXSEfe8e53c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766289671; c=relaxed/simple;
	bh=sNRhi07sM7BxccIDiBPW0tajnnU/5rzKCaVAUizWtSo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gVUBQU5HLcUX8S+kB7CWusGc/jAZCKRQmzoB/A2A68URoC8QozRPVCbF3y2k9uyL9KQ8xCHpuv5FHfixLzOBkWbW8wul65Y6/dxWw+k5QOI+FZhcDh5EERr0vJOwTYVVyjglhE0Da0pul04P+dbgry2br0W+spxL9Y5LsfDF6xY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A7TMyPPl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766289667;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c5NL9N/IUDBs7/Z6XlfTuHg0dH+EQZ0MpUNMh8FEJWo=;
	b=A7TMyPPliiHA953RnrNrYOUBhqiOdYJktywHY/6oQaSP8XUi8sGEKIOI0fbWoKPXgbtuQk
	IS9knME+5sfIcayM80mZrgSyK/rKOMAplbG9n9baH+NqJgdQHICYgWfAcduGuXNIQYMO4Y
	Uu3sa88Z7H4zAO/cb7b8WOBdDYB1Pxc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-403-5wP8BfWWPlORz9ZR1kdH1Q-1; Sat,
 20 Dec 2025 23:01:04 -0500
X-MC-Unique: 5wP8BfWWPlORz9ZR1kdH1Q-1
X-Mimecast-MFC-AGG-ID: 5wP8BfWWPlORz9ZR1kdH1Q_1766289662
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 76A311956095;
	Sun, 21 Dec 2025 04:01:02 +0000 (UTC)
Received: from dell-per7425-02.rhts.eng.pek2.redhat.com (dell-per7425-02.rhts.eng.pek2.redhat.com [10.73.116.18])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CB04D1953984;
	Sun, 21 Dec 2025 04:00:56 +0000 (UTC)
From: Chunyu Hu <chuhu@redhat.com>
To: akpm@linux-foundation.org,
	david@kernel.org,
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
	chuhu@redhat.com,
	Luiz Capitulino <luizcap@redhat.com>
Subject: [PATCH v2 5/5] selftests/mm: fix comment for check_test_requirements
Date: Sun, 21 Dec 2025 12:00:25 +0800
Message-ID: <20251221040025.3159990-5-chuhu@redhat.com>
In-Reply-To: <20251221040025.3159990-4-chuhu@redhat.com>
References: <20251221040025.3159990-1-chuhu@redhat.com>
 <20251221040025.3159990-2-chuhu@redhat.com>
 <20251221040025.3159990-3-chuhu@redhat.com>
 <20251221040025.3159990-4-chuhu@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

The test supports arm64 as well so the comment is incorrect. And there's
a check for arm64 in va_high_addr_switch.c.

CC: Luiz Capitulino <luizcap@redhat.com>
Fixes: 983e760bcdb6 ("selftest/mm: va_high_addr_switch: add ppc64 support check")
Fixes: f556acc2facd ("selftests/mm: skip test for non-LPA2 and non-LVA systems")
Signed-off-by: Chunyu Hu <chuhu@redhat.com>
---
 tools/testing/selftests/mm/va_high_addr_switch.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/mm/va_high_addr_switch.sh b/tools/testing/selftests/mm/va_high_addr_switch.sh
index a0c93d348b11..9492c2d72634 100755
--- a/tools/testing/selftests/mm/va_high_addr_switch.sh
+++ b/tools/testing/selftests/mm/va_high_addr_switch.sh
@@ -61,9 +61,9 @@ check_supported_ppc64()
 
 check_test_requirements()
 {
-	# The test supports x86_64 and powerpc64. We currently have no useful
-	# eligibility check for powerpc64, and the test itself will reject other
-	# architectures.
+	# The test supports x86_64, powerpc64 and arm64. There's check for arm64
+	# in va_high_addr_switch.c. The test itself will reject other architectures.
+
 	case `uname -m` in
 		"x86_64")
 			check_supported_x86_64
-- 
2.49.0


