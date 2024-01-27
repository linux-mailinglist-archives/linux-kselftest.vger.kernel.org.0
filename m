Return-Path: <linux-kselftest+bounces-3655-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE15983E9BD
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Jan 2024 03:32:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A9DF1F2761C
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Jan 2024 02:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D212965C;
	Sat, 27 Jan 2024 02:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OXyYgYsH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A1A2B65D;
	Sat, 27 Jan 2024 02:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706322744; cv=none; b=e4b5EzqECp+d8KSFhE0qcOl7M2Z4g/ssX9B98amL52mCO/2XnLk94WOI5JK4+QStCZLrEIlQ4czl3jaAnQ1NSS34ogghZIUZwJMBE705uVVJM+R+0rQ9yYMDEMUjArXOXZUjf1NjUDzNalolOf13aL3XwFfkESZyw+IWYRunKb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706322744; c=relaxed/simple;
	bh=r7RAxwquJVP5asbAoDhEWhNoTCGJG26QY0llMRexe80=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RCHHziCr/aeon25Z9zWgjbejJUs5AixumVoSakfmfFLY+HnTCaLNJS4dGO/gktEy6u2PCZ7W+qWm+GHR00PU1hd9bWBu9DpaVlZbefVD63Pt8E8b4Gjs3Nk+LyQrIpsrMlxgcIPyzf+aKlnMggdRQYoorV0E3UhBStcsF+0dttw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OXyYgYsH; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-680b1335af6so20440816d6.1;
        Fri, 26 Jan 2024 18:32:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706322742; x=1706927542; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3Ji269MoVqaoZ+crSZez3EPRGEYWBb0tQGgumN9NBik=;
        b=OXyYgYsHTlw49drir6bETGz0nY+k2Y2N4CfcAmBTPbzy/dHGRQHKwNj5JA3437Lui2
         vx0yg1YOyHIo6rIi8Em4lYlj2XlqwlcG0ryfjicoPqBEHdXo7DR5oYhPlBkYBG2RovPN
         lHyjyTIjTww6yFS9wDH6E+kbfv2ngnqlaR7mJojHOBi4SXR47SLNt/JNxwYdIYt126/A
         pelAcD55P7hE70JnZz0ikqmsa3w0mIHFMd6l1KeMTHdhvH0Ijtxrh6j36raH5dcf2BtH
         wXXPd5kKdDncyqA4b9Rtdq4iswQa3kROdfSpDtQQ3XJmMseTBAdMM6VyeEGhmJrfDfSm
         a+fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706322742; x=1706927542;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3Ji269MoVqaoZ+crSZez3EPRGEYWBb0tQGgumN9NBik=;
        b=gDtOn3AEBqt8KMUbIaNtmn1GzmGTGOnJ9HjQu/CSvgUCcCkFINflxfOniY10Isjvea
         kn3RG8UonqOJq9HhK2p1IbA52GkqO/53CkfWJfGO8Le4plES6SXsOPmHlCjm98xd2D4y
         6rVZWVnroFIs4Uz6TVhAVDHKq9bWd7NSL9SkYoXaBlTVzVnNzl4QQLXhGH5WeSdyCPMX
         uZbrmAbSzxQL+gTh2taLXlTKkSQ18k8kp6tf2YFu+0Fn5mDBNIffORkflG7ns6tG5XfP
         lrxKLLAT48/9RJ7UMBubyGJjVBqIpcLrmUjjDnIEIjScpFlXBsqojDUw0geRWBcoQI7L
         WcNQ==
X-Gm-Message-State: AOJu0YwsrNJ5GNuDSHhswCV5+UmghXSdErVxf7x0A/8hb31VInNPtvn6
	4JM6LXpCby6Dh9kzKHv0xVzemvBnpURZKO3gtUIWB/hlv3fVAFQvnZZTVVWC
X-Google-Smtp-Source: AGHT+IEW/cKR+QgbsF6tBE6UZV1sdPCV+cbFdVwauRAC0X1wn/CvvRVxmBLKE0xjqBtEzJXKssQMyQ==
X-Received: by 2002:a0c:9d47:0:b0:681:96fd:8b97 with SMTP id n7-20020a0c9d47000000b0068196fd8b97mr2499705qvf.64.1706322742130;
        Fri, 26 Jan 2024 18:32:22 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXd5cTdLVaK8xHJhiHYZMg8F7fukntKEX8Q/fYIftDku0pdHnoD0Aawy9xis2f5PRn1tPu2rUwbcc6TQnFV81GCY7tqi7aRaEiKIXjzEtRV8JF3I3FpsR/8qBHrB3QXibpvfkyd4Jf+xS8V131Hh+H1Lr8MxO/BogkIo7iYBJxyL4Qh5hKEpTDYJue4mGI5MciYfCQBjAxsuf+ejFU=
Received: from willemb.c.googlers.com.com (131.65.194.35.bc.googleusercontent.com. [35.194.65.131])
        by smtp.gmail.com with ESMTPSA id d20-20020a0cdb14000000b00681617e4a72sm1020770qvk.68.2024.01.26.18.32.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 18:32:21 -0800 (PST)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	linux-kselftest@vger.kernel.org,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next] selftests/net: calibrate txtimestamp
Date: Fri, 26 Jan 2024 21:31:51 -0500
Message-ID: <20240127023212.3746239-1-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Willem de Bruijn <willemb@google.com>

The test sends packets and compares enqueue, transmit and Ack
timestamps with expected values. It installs netem delays to increase
latency between these points.

The test proves flaky in virtual environment (vng). Increase the
delays to reduce variance. Scale measurement tolerance accordingly.

Time sensitive tests are difficult to calibrate. Increasing delays 10x
also increases runtime 10x, for one. And it may still prove flaky at
some rate.

Signed-off-by: Willem de Bruijn <willemb@google.com>
---
 tools/testing/selftests/net/txtimestamp.sh | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/net/txtimestamp.sh b/tools/testing/selftests/net/txtimestamp.sh
index 31637769f59f..25baca4b148e 100755
--- a/tools/testing/selftests/net/txtimestamp.sh
+++ b/tools/testing/selftests/net/txtimestamp.sh
@@ -8,13 +8,13 @@ set -e
 
 setup() {
 	# set 1ms delay on lo egress
-	tc qdisc add dev lo root netem delay 1ms
+	tc qdisc add dev lo root netem delay 10ms
 
 	# set 2ms delay on ifb0 egress
 	modprobe ifb
 	ip link add ifb_netem0 type ifb
 	ip link set dev ifb_netem0 up
-	tc qdisc add dev ifb_netem0 root netem delay 2ms
+	tc qdisc add dev ifb_netem0 root netem delay 20ms
 
 	# redirect lo ingress through ifb0 egress
 	tc qdisc add dev lo handle ffff: ingress
@@ -24,9 +24,11 @@ setup() {
 }
 
 run_test_v4v6() {
-	# SND will be delayed 1000us
-	# ACK will be delayed 6000us: 1 + 2 ms round-trip
-	local -r args="$@ -v 1000 -V 6000"
+	# SND will be delayed 10ms
+	# ACK will be delayed 60ms: 10 + 20 ms round-trip
+	# allow +/- tolerance of 8ms
+	# wait for ACK to be queued
+	local -r args="$@ -v 10000 -V 60000 -t 8000 -S 80000"
 
 	./txtimestamp ${args} -4 -L 127.0.0.1
 	./txtimestamp ${args} -6 -L ::1
-- 
2.43.0.429.g432eaa2c6b-goog


