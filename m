Return-Path: <linux-kselftest+bounces-4196-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6663E84B990
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Feb 2024 16:29:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14B7B292951
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Feb 2024 15:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F3F413399B;
	Tue,  6 Feb 2024 15:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fmLWp/3d"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E346C1332A1
	for <linux-kselftest@vger.kernel.org>; Tue,  6 Feb 2024 15:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707233272; cv=none; b=M0adRY+cMTS8Hd4xc1snp/o/4QylZSLRof1+USEI8K4Snzzg1TzFJAEZJ0dzi98WSmNkwS5eWEkZjfGgKntdyW8T4emc+oWkLDA+amlrZuNywD5oI/93lDw75Ef6+E5X2d3tqs2mbZRb6Qn2DANo9dCLYEdAytKlXaROfHSXUuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707233272; c=relaxed/simple;
	bh=9u1dMsiaosyRB4lzwc8Ed34DePp+0a7Z2kA4o0DY4Bk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D58V6eD/nxDQTi4Dem41lse6sYj5wA21exsrx6d+MrFKXBed3RvSk2gacNcMRsATlAKM2hBm7E2Z8lh4NgEjYZEoe4ni38i2JLmE99twS7IrATlCjW2IlD+PFDgLL/hS6Oo0eJOHzqi/vUIluCtLqbuZnWsiQt+GtTF5LWQDp1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fmLWp/3d; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707233268;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Fq9scFE4YcfgjmX5UvcXbGzet+l7McK0LQVifIhtSf0=;
	b=fmLWp/3dPg3rPqhbQ6JtJRUfkV4lNcTs9Vqa0uVOCJKtmodP+9qNOg+5EEGFKQtNdhnTj8
	kh3xpAtPmFqWVCIN6/a5HlEP4wcT3EyhvJ9Ujd6FRKT0eOkCkzQaLGQaLfAWtx+JhX4Ljv
	77IF7G4D8VomezwKqagXMxsxFoy2x7g=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-609-H-uMpYSFOsya9Z7DSAkaPQ-1; Tue,
 06 Feb 2024 10:27:45 -0500
X-MC-Unique: H-uMpYSFOsya9Z7DSAkaPQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9F6CF3813BD1;
	Tue,  6 Feb 2024 15:27:44 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.225.229])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 200282166B31;
	Tue,  6 Feb 2024 15:27:42 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	Coco Li <lixiaoyan@google.com>,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net] selftests: net: cope with slow env in gro.sh test
Date: Tue,  6 Feb 2024 16:27:40 +0100
Message-ID: <117a20b1b09addb804b27167fafe1a47bfb2b18e.1707233152.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

The gro self-tests sends the packets to be aggregated with
multiple write operations.

When running is slow environment, it's hard to guarantee that
the GRO engine will wait for the last packet in an intended
train.

The above causes almost deterministic failures in our CI for
the 'large' test-case.

Address the issue explicitly ignoring failures for such case
in slow environments (KSFT_MACHINE_SLOW==true).

Fixes: 7d1575014a63 ("selftests/net: GRO coalesce test")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
Note that the fixes tag is there mainly to justify targeting the net
tree, and this is aiming at net to hopefully make the test more stable
ASAP for both trees.

I experimented with a largish refactory replacing the multiple writes
with a single GSO packet, but exhausted by time budget before reaching
any good result.
---
 tools/testing/selftests/net/gro.sh | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/net/gro.sh b/tools/testing/selftests/net/gro.sh
index 19352f106c1d..114b5281a3f5 100755
--- a/tools/testing/selftests/net/gro.sh
+++ b/tools/testing/selftests/net/gro.sh
@@ -31,6 +31,10 @@ run_test() {
       1>>log.txt
     wait "${server_pid}"
     exit_code=$?
+    if [ ${test} == "large" -a -n "${KSFT_MACHINE_SLOW}" ]; then
+        echo "Ignoring errors due to slow environment" 1>&2
+        exit_code=0
+    fi
     if [[ "${exit_code}" -eq 0 ]]; then
         break;
     fi
-- 
2.43.0


