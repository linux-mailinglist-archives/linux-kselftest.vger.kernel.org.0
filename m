Return-Path: <linux-kselftest+bounces-49512-lists+linux-kselftest=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cKoZF1Svb2lBGgAAu9opvQ
	(envelope-from <linux-kselftest+bounces-49512-lists+linux-kselftest=lfdr.de@vger.kernel.org>)
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Jan 2026 17:37:40 +0100
X-Original-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C25947BB7
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Jan 2026 17:37:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DD17E5CBE3B
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Jan 2026 13:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 333A642DFE0;
	Tue, 20 Jan 2026 13:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rk8i5ZQN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 587923F0742
	for <linux-kselftest@vger.kernel.org>; Tue, 20 Jan 2026 13:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768916391; cv=none; b=E5NyGpXwo0iXn80V9aTXBhVVaWOz5wjFeHuKTrq3bCqKGeM6L528DOoB59eDi3uBI9/C+huBDG1kfcNGz7Q2avfEW4ebCiMmNI/GEavCUrMp0nBPwDtH5KIx+QV8a+rtHrNYL0aitV2xYM0aRurj3uAJB+EIEt3DogJYoYcMZSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768916391; c=relaxed/simple;
	bh=pbO8eNAYDGYW5sX787ND9xeTQ8SshIYR4qMQ+fZMQ60=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RpuzThj7Q6ybsw0Ol+mKiPEebq2ZdkfTDPlPjo2I8HgXcoQ9ebK9vUBMph1ssslaOcKqKSu2gaHLMBC1yQn02hyUy3LTI5uEMq6lMlkoo3aWvIPisZL6aSGfOY0xBeAv8NbO6JKDEA8Nlzp4kR2IFI5twVBBdIPhHidx+f610mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rk8i5ZQN; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-81f5381d168so4835440b3a.2
        for <linux-kselftest@vger.kernel.org>; Tue, 20 Jan 2026 05:39:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768916386; x=1769521186; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dsGr9dkGYMgZzi70MY6htwKKf+SUzE4Qn2hRD6kPTBw=;
        b=Rk8i5ZQNrtuVAcil/0lI5fJ6CJTtLsf2WRnIGSHPzhFwjUW9ciDwjRDvZuV55VuOYQ
         r4yBBRbkPWs0lANygYtCTHVnbT9fB/NG1+JfREoJUMl7dyAYj2idG0tP0mCT7NAHaIsX
         vndtwih30SIvIwV61xo+hlQyfxRHgj3onXeNI9ijvbp+us0+3BtQ5nZ+tUq/SctXaKEp
         CRr/dJ95S2TPwJNpm3gBQPqqHgV+t3gEkO/I/70xhU4YgAwgj1YHbcAeTsIDKBlcdwep
         TEs4f6f5S3whxXrnDpgYDpV4XG2yq28vgTRpX11Xk0rJqC11x1hhrEK0nveym3T7lfr8
         ocog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768916386; x=1769521186;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dsGr9dkGYMgZzi70MY6htwKKf+SUzE4Qn2hRD6kPTBw=;
        b=u6teP8Fsri1yg8rSX90vwkcgHyefJD8En7TPunf963mPx7H22nmFBDie6f7bm9/EEV
         70FOORh8mJdR6yvQmRIMqmiophg+hjeWd++rEpNtqmd7CNIlgSkVJ2iaLEmWp4uM+u/N
         B02qnFFDWIF9qay/bgrR7AKej5NTunwQuNQDKiSZprc9fJ1D1udzNRituXoMwCZ2NAEI
         27g5UAyQA5ER7tbJkxXC0xmtHmLSONEAXfWcQYOvgZbx7wJ3E0csONa4wElhdqENF3T0
         2MhSmHym6aZRInjT/UAwwsznKHbLxtsigO1aURwle/qpqyozghEByhMJrPQumGRotg/j
         9vhA==
X-Forwarded-Encrypted: i=1; AJvYcCVEE+0dHBQD+57XHmzSOqcbqJ5GD6EBpNArZ1gYq7e7cvttwbFeIUW1haskcFDXOePREkRUGTJkBKZsXjlF4hk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmAQlbsc4PBqjACTNV4FwMgQPseCMpb2AlcWDQG8L0DDIndDIF
	MvzJFt0zMEGBm5mrq57Ekb1pKKThBEOoiagO9VtbxLzTkNmFyQw59LIR
X-Gm-Gg: AZuq6aLxT1XGrl/GnFWqUuWKmqFs/EN9dJZ6oysSdF+KluIrVeWLL1LyWfe9lZBdAuQ
	U5bc++cxguMj9e/ZrSTeOSd6ntPKbc8PzzdmQEaTYv/th/YB4PKQQ0aK9gWXrqnfjlkzMq+mvie
	GDkN8zlezgjAm4ia5PUKhc9e8ANmHGEsYREx6+cWYAHcFM1kKZoEiStXCehKtEwMexsPI/e1R+G
	3P/Jn9zIafTbtudvHasRFHhdMw0EXpueFL9Y4Z82x9B+XnUgsS5qtkC6Mspr4gRJXHWfX6wGY5i
	YItg2yIS1Fk+GjVAfjO5KupJ5fZj3tU1N0AJ8g8KmC3qwTfLglO/h8XlCeAExOJOqVXXF3PuDEn
	HWd5nhrQpJMKDpFqp/1eHtdTJPjUVOAlCn05dqUxRPx9r6NilS5/EtEC8/coKn6QFwRSJEjD2fB
	0=
X-Received: by 2002:a05:6a00:1a89:b0:81f:b1d4:b486 with SMTP id d2e1a72fcca58-81fe87b2883mr1615438b3a.8.1768916385606;
        Tue, 20 Jan 2026 05:39:45 -0800 (PST)
Received: from ap.. ([182.213.254.91])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-81fa1094e23sm12322373b3a.4.2026.01.20.05.39.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 05:39:44 -0800 (PST)
From: Taehee Yoo <ap420073@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	horms@kernel.org,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org
Cc: ap420073@gmail.com
Subject: [PATCH net v2] selftests: net: amt: wait longer for connection before sending packets
Date: Tue, 20 Jan 2026 13:39:30 +0000
Message-ID: <20260120133930.863845-1-ap420073@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-49512-lists,linux-kselftest=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	FROM_NEQ_ENVFROM(0.00)[ap420073@gmail.com,linux-kselftest@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-kselftest];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 0C25947BB7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Both send_mcast4() and send_mcast6() use sleep 2 to wait for the tunnel
connection between the gateway and the relay, and for the listener
socket to be created in the LISTENER namespace.

However, tests sometimes fail because packets are sent before the
connection is fully established.

Increase the waiting time to make the tests more reliable, and use
wait_local_port_listen() to explicitly wait for the listener socket.

Fixes: c08e8baea78e ("selftests: add amt interface selftest script")
Signed-off-by: Taehee Yoo <ap420073@gmail.com>
---

v2:
 - Add wait_local_port_listen() to both send_mcast4() and send_mcast6()

 tools/testing/selftests/net/amt.sh | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/amt.sh b/tools/testing/selftests/net/amt.sh
index 3ef209cacb8e..663744305e52 100755
--- a/tools/testing/selftests/net/amt.sh
+++ b/tools/testing/selftests/net/amt.sh
@@ -73,6 +73,8 @@
 #       +------------------------+
 #==============================================================================
 
+source lib.sh
+
 readonly LISTENER=$(mktemp -u listener-XXXXXXXX)
 readonly GATEWAY=$(mktemp -u gateway-XXXXXXXX)
 readonly RELAY=$(mktemp -u relay-XXXXXXXX)
@@ -246,14 +248,15 @@ test_ipv6_forward()
 
 send_mcast4()
 {
-	sleep 2
+	sleep 5
+	wait_local_port_listen ${LISTENER} 4000 udp
 	ip netns exec "${SOURCE}" bash -c \
 		'printf "%s %128s" 172.17.0.2 | nc -w 1 -u 239.0.0.1 4000' &
 }
 
 send_mcast6()
 {
-	sleep 2
+	wait_local_port_listen ${LISTENER} 6000 udp
 	ip netns exec "${SOURCE}" bash -c \
 		'printf "%s %128s" 2001:db8:3::2 | nc -w 1 -u ff0e::5:6 6000' &
 }
-- 
2.43.0


