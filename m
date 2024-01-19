Return-Path: <linux-kselftest+bounces-3257-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32434833006
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Jan 2024 21:58:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 612531C2184D
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Jan 2024 20:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21AFA56472;
	Fri, 19 Jan 2024 20:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="apdLSeSl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 840AE57861
	for <linux-kselftest@vger.kernel.org>; Fri, 19 Jan 2024 20:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705697890; cv=none; b=RBbWF6KrWLJXrk1k3uytRhg7KIiWefDFySJcixmliid7Lp18KZTN4VrMcrne3gy2bdFkC93rymtulsb2ZGhhyPHUGcdNbfcUVanjoI942ZL7M4SUPvUotHrHCQRdJJ3p3XzFEvdAqVE4BwXAndvWPoMCJQbyB0/iIRZt7YN4o1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705697890; c=relaxed/simple;
	bh=0Z1mM8NNpnZ3fU/VyC3BK1Nb8rohKjTqsZIj6MBAYNw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OSj2nXNv1ebN7rEmojyRAeLhyah+O+PCnb0Mn+lU5CRVCX6QH1r2CnNqZatTkgTAzVJAGMl3VWyV34hJNf3+gsJj7taaV0Mlh9eSZTSoyK3Bp1OjcCrdllM6F5KYEeRj6crQOFp6b/csBaNMZpWPt8l6Y2MmUW5nu5WyrRWwz+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=apdLSeSl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705697887;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=0i1x7JQBWi+X6u0NziMYKO320yAB1+oNZDpaubKiGtc=;
	b=apdLSeSluCjmFpKj9wEcB8K6nwTa5xWd35Sfn1wQOZfYMvIRqEtLncPqenu9iuEDd0v+Ah
	f1t8Wd04y1YGEot3owuDwB3F9uMbNlqvZbpPKpyrOghbXkKHXUMxktUQ9q9jfXnPCAybf2
	ISQ6wdLnxr2r46NdY+rQta6YXxrGvwk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-551-TSUcBbBAMPOZA-Ux8uhT3g-1; Fri, 19 Jan 2024 15:58:04 -0500
X-MC-Unique: TSUcBbBAMPOZA-Ux8uhT3g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9146A85A589;
	Fri, 19 Jan 2024 20:58:03 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.32.201])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 2EF561C05E0F;
	Fri, 19 Jan 2024 20:58:03 +0000 (UTC)
From: Audra Mitchell <audra@redhat.com>
To: shuah@kernel.org
Cc: akpm@linux-foundation.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	raquini@redhat.com
Subject: [PATCH] selftests/mm: Update va_high_addr_switch.sh to check CPU for la57 flag
Date: Fri, 19 Jan 2024 15:58:01 -0500
Message-ID: <20240119205801.62769-1-audra@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

In order for the page table level 5 to be in use, the CPU must have the
setting enabled in addition to the CONFIG option. Check for the flag to be
set to avoid false test failures on systems that do not have this cpu flag
set.

Signed-off-by: Audra Mitchell <audra@redhat.com>
---
 tools/testing/selftests/mm/va_high_addr_switch.sh | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/testing/selftests/mm/va_high_addr_switch.sh b/tools/testing/selftests/mm/va_high_addr_switch.sh
index 45cae7cab27e..a0a75f302904 100755
--- a/tools/testing/selftests/mm/va_high_addr_switch.sh
+++ b/tools/testing/selftests/mm/va_high_addr_switch.sh
@@ -29,9 +29,15 @@ check_supported_x86_64()
 	# See man 1 gzip under '-f'.
 	local pg_table_levels=$(gzip -dcfq "${config}" | grep PGTABLE_LEVELS | cut -d'=' -f 2)
 
+	local cpu_supports_pl5=$(awk '/^flags/ {if (/la57/) {print 0;}
+		else {print 1}; exit}' /proc/cpuinfo 2>/dev/null)
+
 	if [[ "${pg_table_levels}" -lt 5 ]]; then
 		echo "$0: PGTABLE_LEVELS=${pg_table_levels}, must be >= 5 to run this test"
 		exit $ksft_skip
+	elif [[ "${cpu_supports_pl5}" -ne 0 ]]; then
+		echo "$0: CPU does not have the necessary la57 flag to support page table level 5"
+		exit $ksft_skip
 	fi
 }
 
-- 
2.43.0


