Return-Path: <linux-kselftest+bounces-44383-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E350AC1E792
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Oct 2025 06:57:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 210A54E263F
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Oct 2025 05:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A79C2F4A14;
	Thu, 30 Oct 2025 05:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Wh+J4Cdo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A7E42D063D
	for <linux-kselftest@vger.kernel.org>; Thu, 30 Oct 2025 05:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761803840; cv=none; b=oIXUgmk88hnB7RQJ5Jn2er82ZSXCvi0JrxYwNawtH1yC41xkAmIOdmc2GOdicM3Rxd1a6A+8BXJ2+wELrKhvwTyuCiZ8G7zNKIy+iTp5ygXkw0RoICUhXBJOMPey2p/bpel6RoSiO7/N+EOHi10ynAowMX0gF4ONSfUTtIz2dAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761803840; c=relaxed/simple;
	bh=6R8pG/tRTzNsUKnlVMNJEWzkJQEf3TAROqebWC6cqhg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=o/QwB5W5kFqhleEZVcQd/zNFUag645OI6q73jw91ZgSm/j8rnRzhKDwbpb3ONImOoua5oINkzQ6yuxh4575LK1tO4onZ768fuiWcfr400ycYmEYaygMKNiunnbecE9zXQLf4mFU6vgHtyOVH28mwUhZn99cz8pHW8bNLDlyb/+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--anubhavsinggh.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Wh+J4Cdo; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--anubhavsinggh.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-33bb4d11f5eso770917a91.3
        for <linux-kselftest@vger.kernel.org>; Wed, 29 Oct 2025 22:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761803838; x=1762408638; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9VEDGVLVJs2QlTOJvCsTEKqsco8Sca06dv1X5LS5W+Q=;
        b=Wh+J4Cdow/qNQdNkOZyV53fcVhJzZtLLVBW5LhE8j2YO3jeUrWbFZfEgDdJa7KPPS5
         6viiYpwq12W10QvferqaRRlPzKYxqJRlcwyOv9VdmXqxbkfSLOtsONapBZRh5mp2fCmE
         V5rX3N5isZnMb5nwbGmPHEKQZKFfqhnqFQRmgOzpmy1v9PxY1doN3Rud+GZFSiPFvemb
         q8IUKfUajsNqmB4LMGgNNWFy6Z/0DPksu1TV4QhuXJfkNpunwe3KRkCDAEP4VuWKKE2J
         tOjf0PbBtwnz82pAztSRuyIbqC09KNAqg1p7DQ7zgLfjnhhxdWhyuxuUSsmosxmcMzMj
         rHkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761803838; x=1762408638;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9VEDGVLVJs2QlTOJvCsTEKqsco8Sca06dv1X5LS5W+Q=;
        b=OwBxdKYaALoNDpSSJ1zWOmM4+eXy9zWEWGBf7lTpA5AT+ilwg286ymsvF8E23TuvGy
         aNVzZIC0vjnZAEdeWhJCwEtVl7BmAwczJfOQqUGOkglQz4P1v6g9ImhkU/HqqiRmKCIm
         cxjg6GWnfEfFHWQFXDbKM5HHrCNsSK6+4g0CDatqDtGwwPnzXuE4mR2PF77mCilV1XWq
         2EqwXQmS6RK1j2ySxsyyPxGTunQdcYE+Es6VgB3w5bl30VWj6am1DUqA0vk3cEunx548
         Vzn2Bf9ME6UgMxtMRhkje+syh37RU1aAhOKC4r7r3tYM3I0a4AnafutebxB+rX2Jxbmf
         WXyw==
X-Forwarded-Encrypted: i=1; AJvYcCXzaIj6VlYRcWa8Tw4ErcvXiKRFT7MAbij7gnotjSMWrYffUeCCxWzYz53TBwvgeYb3/L0wjvvg0gsYdd/id/8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwF8C7ocM6yDISVKjR1nOXvBKyx95UnC1GKcBhPg/8HbdCXY3dQ
	zCG2EsZPOuO2UEFjWJ1fKzR3dqBJwFGivnf3I+qiAAL+stJO4HMr9ralNZyOzEioHIiwdjvuqC/
	jgRXYn7bxv3b5WCZbEbooGVbA6nqQ5aZUWw==
X-Google-Smtp-Source: AGHT+IFtBRiZlB3pV9ozMP4vakNPJihdirBvsYkwCxIfJJ9TsPihH5B52AqKrcsOJZAqPDhUY3Gm+gftjQTazsw/0roa
X-Received: from pjbnr15.prod.google.com ([2002:a17:90b:240f:b0:32d:e264:a78e])
 (user=anubhavsinggh job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:518c:b0:338:3e6f:2d63 with SMTP id 98e67ed59e1d1-3404c3ff494mr2476345a91.6.1761803838208;
 Wed, 29 Oct 2025 22:57:18 -0700 (PDT)
Date: Thu, 30 Oct 2025 05:57:14 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.1.851.g4ebd6896fd-goog
Message-ID: <20251030055714.1553346-1-anubhavsinggh@google.com>
Subject: [PATCH net] selftests/net: fix out-of-order delivery of FIN in
 gro:tcp test
From: Anubhav Singh <anubhavsinggh@google.com>
To: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, Coco Li <lixiaoyan@google.com>, 
	Anubhav Singh <anubhavsinggh@google.com>
Content-Type: text/plain; charset="UTF-8"

Due to the gro_sender sending data packets and FIN packets
in very quick succession, these are received almost simultaneously
by the gro_receiver. FIN packets are sometimes processed before the
data packets leading to intermittent (~1/100) test failures.

This change adds a delay of 100ms before sending FIN packets
in gro:tcp test to avoid the out-of-order delivery. The same
mitigation already exists for the gro:ip test.

Fixes: 7d1575014a63 ("selftests/net: GRO coalesce test")
Reviewed-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Anubhav Singh <anubhavsinggh@google.com>
---
 tools/testing/selftests/net/gro.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/testing/selftests/net/gro.c b/tools/testing/selftests/net/gro.c
index 2b1d9f2b3e9e..3fa63bd85dea 100644
--- a/tools/testing/selftests/net/gro.c
+++ b/tools/testing/selftests/net/gro.c
@@ -989,6 +989,7 @@ static void check_recv_pkts(int fd, int *correct_payload,
 
 static void gro_sender(void)
 {
+	const int fin_delay_us = 100 * 1000;
 	static char fin_pkt[MAX_HDR_LEN];
 	struct sockaddr_ll daddr = {};
 	int txfd = -1;
@@ -1032,15 +1033,22 @@ static void gro_sender(void)
 		write_packet(txfd, fin_pkt, total_hdr_len, &daddr);
 	} else if (strcmp(testname, "tcp") == 0) {
 		send_changed_checksum(txfd, &daddr);
+		/* Adding sleep before sending FIN so that it is not
+		 * received prior to other packets.
+		 */
+		usleep(fin_delay_us);
 		write_packet(txfd, fin_pkt, total_hdr_len, &daddr);
 
 		send_changed_seq(txfd, &daddr);
+		usleep(fin_delay_us);
 		write_packet(txfd, fin_pkt, total_hdr_len, &daddr);
 
 		send_changed_ts(txfd, &daddr);
+		usleep(fin_delay_us);
 		write_packet(txfd, fin_pkt, total_hdr_len, &daddr);
 
 		send_diff_opt(txfd, &daddr);
+		usleep(fin_delay_us);
 		write_packet(txfd, fin_pkt, total_hdr_len, &daddr);
 	} else if (strcmp(testname, "ip") == 0) {
 		send_changed_ECN(txfd, &daddr);
-- 
2.51.1.851.g4ebd6896fd-goog


