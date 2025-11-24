Return-Path: <linux-kselftest+bounces-46366-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0003C7EF8D
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Nov 2025 06:05:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D7DC3A457A
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Nov 2025 05:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB34D2BE048;
	Mon, 24 Nov 2025 05:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KQB7eXhE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B5F229D29A
	for <linux-kselftest@vger.kernel.org>; Mon, 24 Nov 2025 05:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763960704; cv=none; b=QwP8cIKca5M8oUETI40jKq2GCwEvqL3ivAnMLgMuWFxdRas55Pq0QUoJGUyDInRfS+lXIk/kDZj3YC1nZ7gR23hE9sJXqj0c+CyNevo32taaE3wP1nDQs9JMNu+ZmzcfVMqWz5qCwTSLIZS2MI95/FXvbjjB83sdZZ2VmAL9k2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763960704; c=relaxed/simple;
	bh=jgunH0PsWpK/zSQyPSuaVv0R9gIIlbDMFDceS4blm88=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=f5GkjIifUqbkTtOuj7LtLn4wBlONC0D/sA2UyDvxmNw5UQwY/8aeFkfq7PCqF5CaCX3wh0fUG7qpGG3XCRY3TKLzzNPXq+KjkkBUaDAikZdU1f5gJgmI528vXd0QtxVDo3xfB7zRpu3k7DhQ7R0q6WJWKOuwHB4ZcYiCA1+yAIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KQB7eXhE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763960701;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ZARig0mkAfhyVpxziKpIN9dzSGezkpNssMMdRVlHTnA=;
	b=KQB7eXhEu+eUrK/dnHCRbEqbAjq1CYW4uOwje5nlfDQjcTJqI/KikJ5lkQ4XzycytJGe48
	Z5SLw1HVW+gCN83A/1npQ4tF53qtIMoA9gw0C4VFIrG2xLEQxqDP+R3NyrFJG1sekIUOir
	4Jm/l/U9appbvYZQwiLUB7Wx4l46e5Q=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-212-yT4DBRBiPsS6WRYmBD1DXg-1; Mon,
 24 Nov 2025 00:04:55 -0500
X-MC-Unique: yT4DBRBiPsS6WRYmBD1DXg-1
X-Mimecast-MFC-AGG-ID: yT4DBRBiPsS6WRYmBD1DXg_1763960694
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E0F55195609F;
	Mon, 24 Nov 2025 05:04:53 +0000 (UTC)
Received: from gshan-thinkpadx1nanogen2.rmtau.csb (unknown [10.64.136.67])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EC4D619560A7;
	Mon, 24 Nov 2025 05:04:49 +0000 (UTC)
From: Gavin Shan <gshan@redhat.com>
To: kvmarm@lists.linux.dev
Cc: kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pbonzini@redhat.com,
	shuah@kernel.org,
	seanjc@google.com,
	shan.gavin@gmail.com
Subject: [PATCH] KVM: selftests: Fix core dump in rseq_test
Date: Mon, 24 Nov 2025 15:04:27 +1000
Message-ID: <20251124050427.1924591-1-gshan@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

In commit 0297cdc12a87 ("KVM: selftests: Add option to rseq test to
override /dev/cpu_dma_latency"), a 'break' is missed before the option
'l' in the argument parsing loop, which leads to an unexpected core
dump in atoi_paranoid(). It tries to get the latency from non-existent
argument.

  host$ ./rseq_test -u
  Random seed: 0x6b8b4567
  Segmentation fault (core dumped)

Add a 'break' before the option 'l' in the argument parsing loop to avoid
the unexpected core dump.

Fixes: 0297cdc12a87 ("KVM: selftests: Add option to rseq test to override /dev/cpu_dma_latency")
Cc: stable@vger.kernel.org # v6.15+
Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 tools/testing/selftests/kvm/rseq_test.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/kvm/rseq_test.c b/tools/testing/selftests/kvm/rseq_test.c
index 1375fca80bcdb..f80ad6b47d16b 100644
--- a/tools/testing/selftests/kvm/rseq_test.c
+++ b/tools/testing/selftests/kvm/rseq_test.c
@@ -215,6 +215,7 @@ int main(int argc, char *argv[])
 		switch (opt) {
 		case 'u':
 			skip_sanity_check = true;
+			break;
 		case 'l':
 			latency = atoi_paranoid(optarg);
 			break;
-- 
2.51.1


