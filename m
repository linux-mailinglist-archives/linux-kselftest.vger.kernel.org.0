Return-Path: <linux-kselftest+bounces-9238-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BC1C8B9013
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 May 2024 21:32:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D94C1C20A9B
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 May 2024 19:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ACB216086C;
	Wed,  1 May 2024 19:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a0pL17zF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83BBE12FB21;
	Wed,  1 May 2024 19:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714591923; cv=none; b=gJgMFp+GnOCXTF8I7wlYvFkh/XHHovpcWfKfuaKU22kMaQFyxsQh4fOypb5vauAZhYOfuXLwV+oeFCw1DafauxAibyfz0iTY6I7rg05AfcQBKx6rhd32YrvXAoJ90+paz3ZX0JyVoL/gQrnXw94Y/GmVdXZD18BxEW4FdCbL3Yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714591923; c=relaxed/simple;
	bh=IYmmU+NuTbvqIuAc6tjcsiAZkPW0JNhm8ZfoHMTeGZg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hHZUALF9QAD2vrFbN2fE/v1D1CGtgihiI7jKcrOUsYZfJrEXg/bXUSF4P41X7NLTGnNxvb6yC0ucweIU0FEZYOxUAzwDXTAxWylLfKQ3owU5gNDVMzf2jIYl6fxxOGqKKO3LIZjLFp/J/AqNGrKg39fs0KZ6HjWNh09tqP1XfTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a0pL17zF; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6a05f376effso55452246d6.0;
        Wed, 01 May 2024 12:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714591920; x=1715196720; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AvK/+TT3eyfVBvg3l4D5twtFYStPyDuLHedQhz3UJMs=;
        b=a0pL17zFsm/hweR0bHTiRS3JUwJXi36BVPfnSihLiCWeni+OxKS8F3ZX9xoCLUBTkt
         QijFEMVEeYJSyop86be7wge7nnBKewW+Ioq+oeYT7UbthRBpDT/BMAvz2PIxdrrOXXyg
         aNHpmhmqgD/xDNp82Q4BAScvDYorrYmEz+kwbmhaEALlXxxe8SkHbr0fmA7mlzlQltlN
         TcIviAlnG6Mx1ZCRI0K70oO9gHCW9VEcjm91UkkVLLZwZ3A9GIitvEuBawjlOGHwrejm
         eyvNDXDGKDJcD/ppeBl2+/czI73HOtURFfxs6xkjL3Z+UmKiZ6fXRzkTfjIhOVQiPuEx
         Ydgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714591920; x=1715196720;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AvK/+TT3eyfVBvg3l4D5twtFYStPyDuLHedQhz3UJMs=;
        b=mCVdxYvz1FTFRt+2Y+/owVVNftZmJzYtOuhvmg9PXZEFbqpQy0j4Fu/HhL4UVFOKAh
         CAtTqoi4ZdPVihwdMhMa5PbX4Nd9dzI281+sqiM1oR5Rh9KFfGUXYDxHW58Y76r5wf1K
         aMnJ2EbYz05Ze8MTSEkEcs6NmNbQ90+YSKhung2pi6yAVXc/DZRpk/laya4eIq+6YSmM
         I8uehAb2NISO+CCQ/QDsfBhNTe1HeZsGU3GmvpSdUqZI6/awbxkLROMGQSH6m3F1QfGd
         VVhHr9pleV+2uTKSsGNuzv9mg2/A5J9LHiwWw0fszrl0sTLGGzq0nmefdphHLqD5oMD8
         81JQ==
X-Forwarded-Encrypted: i=1; AJvYcCWIxufZpJdJokH9djJf/ifkkNUN4zvP9OiBoB9685cnLHwi8M8j3MIDMnDv20Fh8p/IxC0qajaZjuAhaQmL51/blrvNStUqrqFW77Di7glL
X-Gm-Message-State: AOJu0YzGPWUbQFva4YYEbPIUW2KNXlyhPIpXdwo60OdGfx2zGxA3xKAg
	R46nUshkiWsHo/TvvgUM8ek2kWvnmnl2kkHB+nspDV5fVA8k2o+tzAEiBA==
X-Google-Smtp-Source: AGHT+IFqzF+4yncrf0c4kNpTQSNzy8ZNSti343o8z6T1GaeJYUNHUV2eVF1sQX5XZW7PrL+ZPjePQg==
X-Received: by 2002:a05:6214:529c:b0:6a0:b3de:e3b2 with SMTP id kj28-20020a056214529c00b006a0b3dee3b2mr3579674qvb.52.1714591920051;
        Wed, 01 May 2024 12:32:00 -0700 (PDT)
Received: from willemb.c.googlers.com.com (164.146.150.34.bc.googleusercontent.com. [34.150.146.164])
        by smtp.gmail.com with ESMTPSA id u6-20020a0cee86000000b006a0f057489fsm907965qvr.125.2024.05.01.12.31.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 12:31:59 -0700 (PDT)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	linux-kselftest@vger.kernel.org,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next] selftests/net: skip partial checksum packets in csum test
Date: Wed,  1 May 2024 15:30:22 -0400
Message-ID: <20240501193156.3627344-1-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Willem de Bruijn <willemb@google.com>

Detect packets with ip_summed CHECKSUM_PARTIAL and skip these. These
should not exist, as the test sends individual packets between two
hosts. But if (HW) GRO is on, with randomized content sometimes
subsequent packets can be coalesced.

In this case the GSO packet checksum is converted to a pseudo checksum
in anticipation of sending out as TSO/USO. So the field will not match
the expected value.

Do not count these as test errors.

Signed-off-by: Willem de Bruijn <willemb@google.com>
---
 tools/testing/selftests/net/csum.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/csum.c b/tools/testing/selftests/net/csum.c
index 90eb06fefa59..b9f3fc3c3426 100644
--- a/tools/testing/selftests/net/csum.c
+++ b/tools/testing/selftests/net/csum.c
@@ -682,7 +682,7 @@ static int recv_verify_packet_ipv6(void *nh, int len)
 }
 
 /* return whether auxdata includes TP_STATUS_CSUM_VALID */
-static bool recv_verify_packet_csum(struct msghdr *msg)
+static uint32_t recv_get_packet_csum_status(struct msghdr *msg)
 {
 	struct tpacket_auxdata *aux = NULL;
 	struct cmsghdr *cm;
@@ -706,7 +706,7 @@ static bool recv_verify_packet_csum(struct msghdr *msg)
 	if (!aux)
 		error(1, 0, "cmsg: no auxdata");
 
-	return aux->tp_status & TP_STATUS_CSUM_VALID;
+	return aux->tp_status;
 }
 
 static int recv_packet(int fd)
@@ -716,6 +716,7 @@ static int recv_packet(int fd)
 	char ctrl[CMSG_SPACE(sizeof(struct tpacket_auxdata))];
 	struct pkt *buf = (void *)_buf;
 	struct msghdr msg = {0};
+	uint32_t tp_status;
 	struct iovec iov;
 	int len, ret;
 
@@ -737,6 +738,17 @@ static int recv_packet(int fd)
 		if (len == -1)
 			error(1, errno, "recv p");
 
+		tp_status = recv_get_packet_csum_status(&msg);
+
+		/* GRO might coalesce randomized packets. Such GSO packets are
+		 * then reinitialized for csum offload (CHECKSUM_PARTIAL), with
+		 * a pseudo csum. Do not try to validate these checksums.
+		 */
+		if (tp_status & TP_STATUS_CSUMNOTREADY) {
+			fprintf(stderr, "cmsg: GSO packet has partial csum: skip\n");
+			continue;
+		}
+
 		if (cfg_family == PF_INET6)
 			ret = recv_verify_packet_ipv6(buf, len);
 		else
@@ -753,7 +765,7 @@ static int recv_packet(int fd)
 		 * Do not fail if kernel does not validate a good csum:
 		 * Absence of validation does not imply invalid.
 		 */
-		if (recv_verify_packet_csum(&msg) && cfg_bad_csum) {
+		if (tp_status & TP_STATUS_CSUM_VALID && cfg_bad_csum) {
 			fprintf(stderr, "cmsg: expected bad csum, pf_packet returns valid\n");
 			bad_validations++;
 		}
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


