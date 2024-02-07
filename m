Return-Path: <linux-kselftest+bounces-4274-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECA1B84D148
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Feb 2024 19:37:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13A7B1C2207C
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Feb 2024 18:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D23C439856;
	Wed,  7 Feb 2024 18:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DYCiA3wm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E5DC405E6
	for <linux-kselftest@vger.kernel.org>; Wed,  7 Feb 2024 18:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707331028; cv=none; b=eptRJlwx7qGgORIYzgRui9Of+6OxzpgpaLlAXZsnpVUOXmlhd5PS5euL1yRgYp8ZYHiANT9IImjbXCgWZ+3+P2O4hLFtuzYNDJdmJXNTgG0yGQ4gPVV+HBsbrmkmAYhPexFl+RRfZMk6DLmm7fWKKSIlBA5w2/gNX73O7Cy17lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707331028; c=relaxed/simple;
	bh=m/i5sMPBt1+3JO6Q2iXN1WvpBHVaWfpDYedxyd/lIQo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mgfu0m2Ep9XsQ2BteR4dYIXYToYxLolGUFr+0toWrxPHQUqqMv57PZfVcnQyj0EzJqGMVFP+8vi9QndYZZTikJKlcrpeCYd7ysVRt2Dywge6N5Nr0cjNajcAmU+jc63Asv99i4JG+P4vE9hpZOeXEywKXqAVYnnVuSQIKaAc6Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DYCiA3wm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707331025;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=zLIjr/OYq0QQZi5Oxih3797SDEnIF4gpI6RRxiaId+U=;
	b=DYCiA3wm7X4hTd9hizkTz050bJnNF6kfcNk3Nh4ZQxmQDm1Dlo9vQT0hLjSTpesDBN1W3j
	TTbtfNiMYcCxH1cmSmoBwJuvBeVVbuF0/wGBxrnb1O2kKIlWXQqO/2pbJ7GAap4N8YdJk/
	Dxdq6nT+Qj4IyUlG5wnf7Sp3kNY4l2g=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-AwZNPHxVPoyxbuoumUO-tA-1; Wed, 07 Feb 2024 13:37:02 -0500
X-MC-Unique: AwZNPHxVPoyxbuoumUO-tA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3C0D28D1380;
	Wed,  7 Feb 2024 18:37:02 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.200])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 7EB1F1C05E0F;
	Wed,  7 Feb 2024 18:37:00 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	Coco Li <lixiaoyan@google.com>,
	linux-kselftest@vger.kernel.org,
	Matthieu Baerts <matttbe@kernel.org>
Subject: [PATCH net v2] selftests: net: cope with slow env in gro.sh test
Date: Wed,  7 Feb 2024 19:36:46 +0100
Message-ID: <c777f75ac70e70aabf1398cefa5c51c0f4ea00f2.1707330768.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

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
Reviewed-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
v1 -> v2:
  - replace the '-a' operator with '&&' - Mattbe

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
index 19352f106c1d..3190b41e8bfc 100755
--- a/tools/testing/selftests/net/gro.sh
+++ b/tools/testing/selftests/net/gro.sh
@@ -31,6 +31,10 @@ run_test() {
       1>>log.txt
     wait "${server_pid}"
     exit_code=$?
+    if [[ ${test} == "large" && -n "${KSFT_MACHINE_SLOW}" ]]; then
+        echo "Ignoring errors due to slow environment" 1>&2
+        exit_code=0
+    fi
     if [[ "${exit_code}" -eq 0 ]]; then
         break;
     fi
-- 
2.43.0


