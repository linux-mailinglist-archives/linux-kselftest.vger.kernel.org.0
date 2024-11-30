Return-Path: <linux-kselftest+bounces-22639-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8E119DF023
	for <lists+linux-kselftest@lfdr.de>; Sat, 30 Nov 2024 12:34:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F035AB21ADD
	for <lists+linux-kselftest@lfdr.de>; Sat, 30 Nov 2024 11:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6DBD1974FE;
	Sat, 30 Nov 2024 11:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MKaRTT+6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF20414B959;
	Sat, 30 Nov 2024 11:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732966428; cv=none; b=laMtaBeUSrwx58BTdENGm7n/wBkxdm0aJykjUpDlrg/8ajqpEBeSedXuX5L2zlGEi+cVQ/tCM90U/0bCjEPAD7PZ62jw1zn5oV/tdiill+QBYva7weQ5WX26h3b4l6CIYwXvnUPEf/DFwOfBNOGStAvpKirpYzPYnYslOaXAWrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732966428; c=relaxed/simple;
	bh=0j3tdra+ltz7wC7HcXn6qt6O0YvoCNWrBSttLfbUiJU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HObGio9s5sWctB2+fNjUwgwwUJLfXyhMSjGC1XpfV6msW/SPmySwBcWbpsDDV2njchojHi/NE++Fpzuodq1azHq7hHYj4vmoBGwbEXSJB4nq5/yDTP67ttoKJrv9FwakPteJctidNE6CcUQ8/KqcNB5L91MSUYxDu78dWt5o1uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MKaRTT+6; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-434a2f3bae4so24839375e9.3;
        Sat, 30 Nov 2024 03:33:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732966425; x=1733571225; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KznO62qCJv+6BDEEPXmID3KRaxfXIzTf99/wITYjG4M=;
        b=MKaRTT+69YFyMPQu4yUV9BYEiQoSOMrhT0hqB8k52L/aJAhqQTlNHJCjbUt+otllxG
         cQnvBGzqCDWKym/f12kyAvNXuUxBgXB8vZ9zy+5aCX46z8dQZuwWcvQtEE/G7B4iobNQ
         Ws1yD0tXq4Y4XD4lpOvW4inS6pLp3GW+/rBiDomSAgq8VcyAd6Ke0FakoA2PqGsF/fRL
         CFcg3jbFEqcb/cBs25eztZu9C823oMIMVZMswY3tGbtOgtbeFk/2kKqnNCUXR1SqmWjQ
         +iutiS3dSjDJI55kn6I7yoqBfDDHNnm7vC9Q6ZFREtyGbsBhKvkG5nXU7BG1eapLqFs4
         w4kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732966425; x=1733571225;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KznO62qCJv+6BDEEPXmID3KRaxfXIzTf99/wITYjG4M=;
        b=MNxrY7J7B8IQJXDpA3oMzm/n06KahDaM31Ce1cQ4ziixu0R1fJBEqgB3hTIO5DVbr4
         g3UrhKTkrCHT4hTqmfyZjw8DgF2Y73g8S1SUcOwrw+fDykCgMjoU5wGY7gcjxytvSwtR
         /P8U42tthE45izkBG2/fNbiLm3N0nOxtN7/DC6LLJWr80tsWtYJB8hj8E99UVglzv2lA
         bHF8oDgdsK2DdbYhazvNFu1re1Ak+hfEWYeV0kfv8Ir2omATQst0GGBeO6Sj3x0qWbHw
         MUTPkFSIKgijTRZ+OUtW9uYnxb5Bei9dv2tna5YuxPBCS9WePdHePRELURMz+oO6kA7T
         x9Qg==
X-Forwarded-Encrypted: i=1; AJvYcCUVQDlRt1IoIdf43FG6SjfjkBnf2C0cOtWsaBmQviIKMzpgjQRr65IL3yAv7M9RpUsMnoUsz/IQ@vger.kernel.org, AJvYcCVngEbZGmpZGzTC2wnXEIuWlYNcxUFNtdHGNxh9eN9kOTD0bVt50cPEYq6bmUUo8lwEjlPxI/iBOZ5Rw9Q=@vger.kernel.org, AJvYcCWM0rrNcyoIGPTSoVmWK7vmLjSc1o9Al+8PC4+nUfx5JvHXlMLan9RZ9gY5ePcb0Am7nsSh9NFtwbhpvsxk6Qhp@vger.kernel.org
X-Gm-Message-State: AOJu0YyhvncXExnvV1/EAtCKFtuQ0hWCrvlbVYozKKVuH8VfN09cEdNJ
	LXzsHy0enRXM+R9CZ/KhuHhTmys4Zi8BSacU6ibyhbiwg6p3kiro
X-Gm-Gg: ASbGncvcDEEGHbihIZeQiBTDHgZZb4b7CakZ4EII7jqotfRhUgfWbvNwbMgjtuHOAiw
	v1owHVjI1w3i/UOYr7ryrf7tO45b2EI9OZe1v0Vq5HzMNsrn+DwKC5ZOXPxZNGV1ls7RWyJMgTY
	E1tNrT3SnzaSKMTdg9DKJlZC6vcMF9WM779V5TngDqzIp647jX859cw0RnEkUYrMmp/EEgl3Dl6
	cNGqAPg7/fO9YOvSA5LnAhn5EZALfAv4fdVQsPlptg1HpGydV/ge30OJPrjgtHAbMOCE7/mZ8sG
	sqc6UFQ4gTYAPOaaMeA=
X-Google-Smtp-Source: AGHT+IHTHejoUNDBj6zPjtKoB8j4qcQmWCwAmVpw9OBbEvuuPy6jVok440aAll3fixhxQxcdTqKMwA==
X-Received: by 2002:a05:600c:1d8d:b0:42c:b905:2bf9 with SMTP id 5b1f17b1804b1-434a9dc7875mr158069385e9.16.1732966425103;
        Sat, 30 Nov 2024 03:33:45 -0800 (PST)
Received: from localhost.localdomain (93-34-91-161.ip49.fastwebnet.it. [93.34.91.161])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-434aa77ffb0sm113506365e9.20.2024.11.30.03.33.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Nov 2024 03:33:44 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Petr Machata <petrm@nvidia.com>,
	Benjamin Poirier <bpoirier@nvidia.com>,
	Hangbin Liu <liuhangbin@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Ido Schimmel <idosch@nvidia.com>,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [net PATCH 2/2] selftests: forwarding: local_termination: sleep before starting tests
Date: Sat, 30 Nov 2024 12:33:10 +0100
Message-ID: <20241130113314.6488-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241130113314.6488-1-ansuelsmth@gmail.com>
References: <20241130113314.6488-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It seems real hardware requires some time to stabilize and actually
works after an 'ip link up'. This is not the case for veth as everything
is simulated but this is a requirement for real hardware to permit
receiving packet.

Without this the very fist test for unicast always fails on real
hardware. With the introduced sleep of one second after mc_route_prepare,
the test corretly pass as the packet can correctly be delivered.

Cc: stable@vger.kernel.org
Fixes: 90b9566aa5cd ("selftests: forwarding: add a test for local_termination.sh")
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 tools/testing/selftests/net/forwarding/local_termination.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/net/forwarding/local_termination.sh b/tools/testing/selftests/net/forwarding/local_termination.sh
index c35548767756..8923c741ce4b 100755
--- a/tools/testing/selftests/net/forwarding/local_termination.sh
+++ b/tools/testing/selftests/net/forwarding/local_termination.sh
@@ -182,6 +182,8 @@ run_test()
 	mc_route_prepare $send_if_name
 	mc_route_prepare $rcv_if_name
 
+	sleep 1
+
 	send_uc_ipv4 $send_if_name $rcv_dmac
 	send_uc_ipv4 $send_if_name $MACVLAN_ADDR
 	send_uc_ipv4 $send_if_name $UNKNOWN_UC_ADDR1
-- 
2.45.2


