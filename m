Return-Path: <linux-kselftest+bounces-3656-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9E2083E9C2
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Jan 2024 03:33:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65AED2874F9
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Jan 2024 02:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3DEDA50;
	Sat, 27 Jan 2024 02:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W0Rqz6hb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C2F428F5;
	Sat, 27 Jan 2024 02:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706322794; cv=none; b=VvQVxkqSNfzG2JH9i6QpPHkybV9FX0SydWNMyCgYQVB8tC4H/Ni1u3qyK/1WP38qzvN4UqwUTPzWtoRe64JniczK35YwCJsbx7fiGIi8+CyJ8Y8IdDUG+oAEgXTHR8uWHhEut23dP3WdYFHDjRAuFZ83juNc5PqXsctJ5yNDt4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706322794; c=relaxed/simple;
	bh=C8ISVwuWHIOy++6drAVyvozcTyVp01A+kVBhAZT4Kbs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qxWJqEvLsUYjx6lnAyuCIhUfDE/QY1m2rRXYI+5N9XJz+s9yXUR9ZEwBOReigsZuzueOFy50fughbfNB/DEL4bLPrORcqi3F6vzbQHX1bDbfYcCSNcf4ia++jdxh9CXYrzNeKDglI11EAnG4OYtDHgxz+ExwLDNLaKVYF1MQKPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W0Rqz6hb; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-42a8af3c10cso1885111cf.0;
        Fri, 26 Jan 2024 18:33:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706322792; x=1706927592; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ebj/u0RaDMnkItOkG6xsV7v4uVxC3HRI3/eC3yZlwtc=;
        b=W0Rqz6hbvJwG9uhr450lY0MOb8h6vF5mIw/29hCImtRPblX2AiqdfsSYfytnseVaJL
         Vc0uoVCj3TDOxCAqkO5VzFGtmsfDw7mH3asG9jDZCRuG1zKC9QtXFAgto5Lpd1rDjHr3
         7OpaApvsQEIDZvhEG6WS2PmQZk41/WeQ/7pUguukykqKHcIkyV90nVcLjk1v/90jUvfR
         i5vEJ00HH2PAH3uFc8BLQ4YpORrx2eCf6TrEMRsYohpm2eMP/gyn5Z3iWmLlSgZwAUxg
         UuUwoY/jnTvjRqhDoWYuet+v9mv+lJd2d1EnlM6WFRB0IG03yxzJ2CKv7wFdirj3k10v
         s32A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706322792; x=1706927592;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ebj/u0RaDMnkItOkG6xsV7v4uVxC3HRI3/eC3yZlwtc=;
        b=hrSqHn9omqkDb5XJgnI5fZW3nwWoAiZRuY3Hadyb13Aj9MhpDG/A6llAQUi/kfJMGK
         uc2TBmwYrv+5YCUZtHXyHtlkor1gu191HheD11QnMcgaAf+ygNPoDu2VQQtaKWt6C86F
         xkWNKg/j7BwcIwwtlXETCsrFHR0dK1UUok3ZXwnPP0MbVh02ROfyVNqFULA4gFIDHwm2
         nphV0+fFUNBn9KP/4UmsRM5KO2WNTr2pxUL8u+GmsYX+MdGg+1Vlx8aAdtMwDhp4VtJL
         VThNlmn/GhPqf6AFnp4EYNu2gGfJX94BMQpMGPmyKuNwSFw1HOmWIXTcyqNvHavN6CqF
         B2GA==
X-Gm-Message-State: AOJu0YyHZqA9mu9a3PefeSvM+6P/MKKSfBh4ElkHQoNSEQnGq1zBX0c7
	Md1Qlw2awxjtd8RbkQZpe31bISR1CCvDDd1N6EhaJXMYazIJuIG6kkGNvHUa
X-Google-Smtp-Source: AGHT+IEKjEAqpJT889TV+z+M5vooLQ1IFU50yZKze+NsEDmuiY1wp6soe5giuZz1NxdDmyEynrVasg==
X-Received: by 2002:a05:622a:1485:b0:42a:6d3e:6b13 with SMTP id t5-20020a05622a148500b0042a6d3e6b13mr1048357qtx.74.1706322792173;
        Fri, 26 Jan 2024 18:33:12 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVbYvcY13SWFodmSqxeAgtJ4YBzoiGQZ/VcK1jqbpCDDPDlj/g9+sSs8shVdNyV0Eke2N2hX89RCdxxHqTM1aAsRlA+KhC8bQ2SYOUHdHaVj1uMBiCIpDSqbW7F0hnx9t9LCPFa4/kgOUK+qgqc7/cpplzO4PWOry5PqgGEA/jtEJjiMyiUV+D6btWlo7N6yzUyHH9XFVskb9SCfK0=
Received: from willemb.c.googlers.com.com (131.65.194.35.bc.googleusercontent.com. [35.194.65.131])
        by smtp.gmail.com with ESMTPSA id q17-20020a05622a031100b00419732075b4sm1073321qtw.84.2024.01.26.18.33.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 18:33:11 -0800 (PST)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	linux-kselftest@vger.kernel.org,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next] selftests/net: calibrate fq_band_pktlimit
Date: Fri, 26 Jan 2024 21:33:03 -0500
Message-ID: <20240127023309.3746523-1-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Willem de Bruijn <willemb@google.com>

This test validates per-band packet limits in FQ. Packets are dropped
rather than enqueued if the limit for their band is reached.

This test is timing sensitive. It queues packets in FQ with a future
delivery time to fill the qdisc.

The test failed in a virtual environment (vng). Increase the delays
to make it more tolerant to environments with timing variance.

Signed-off-by: Willem de Bruijn <willemb@google.com>
---
 tools/testing/selftests/net/fq_band_pktlimit.sh | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/net/fq_band_pktlimit.sh b/tools/testing/selftests/net/fq_band_pktlimit.sh
index 24b77bdf41ff..977070ed42b3 100755
--- a/tools/testing/selftests/net/fq_band_pktlimit.sh
+++ b/tools/testing/selftests/net/fq_band_pktlimit.sh
@@ -8,7 +8,7 @@
 # 3. send 20 pkts on band A: verify that  0 are queued, 20 dropped
 # 4. send 20 pkts on band B: verify that 10 are queued, 10 dropped
 #
-# Send packets with a 100ms delay to ensure that previously sent
+# Send packets with a delay to ensure that previously sent
 # packets are still queued when later ones are sent.
 # Use SO_TXTIME for this.
 
@@ -29,19 +29,21 @@ ip -6 addr add fdaa::1/128 dev dummy0
 ip -6 route add fdaa::/64 dev dummy0
 tc qdisc replace dev dummy0 root handle 1: fq quantum 1514 initial_quantum 1514 limit 10
 
-./cmsg_sender -6 -p u -d 100000 -n 20 fdaa::2 8000
+DELAY=400000
+
+./cmsg_sender -6 -p u -d "${DELAY}" -n 20 fdaa::2 8000
 OUT1="$(tc -s qdisc show dev dummy0 | grep '^\ Sent')"
 
-./cmsg_sender -6 -p u -d 100000 -n 20 fdaa::2 8000
+./cmsg_sender -6 -p u -d "${DELAY}" -n 20 fdaa::2 8000
 OUT2="$(tc -s qdisc show dev dummy0 | grep '^\ Sent')"
 
-./cmsg_sender -6 -p u -d 100000 -n 20 -P 7 fdaa::2 8000
+./cmsg_sender -6 -p u -d "${DELAY}" -n 20 -P 7 fdaa::2 8000
 OUT3="$(tc -s qdisc show dev dummy0 | grep '^\ Sent')"
 
 # Initial stats will report zero sent, as all packets are still
-# queued in FQ. Sleep for the delay period (100ms) and see that
+# queued in FQ. Sleep for at least the delay period and see that
 # twenty are now sent.
-sleep 0.1
+sleep 0.6
 OUT4="$(tc -s qdisc show dev dummy0 | grep '^\ Sent')"
 
 # Log the output after the test
-- 
2.43.0.429.g432eaa2c6b-goog


