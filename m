Return-Path: <linux-kselftest+bounces-31028-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61DD4A91134
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Apr 2025 03:34:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBFBC19072C9
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Apr 2025 01:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C388F1AAA32;
	Thu, 17 Apr 2025 01:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="hkUrl3Li"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 489821DB148
	for <linux-kselftest@vger.kernel.org>; Thu, 17 Apr 2025 01:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744853595; cv=none; b=frQQxDV4Xpna+8T5UescO4/P0qT5s9DTTarTzY/rytrzheBVNQJoDcqZOA+dKyCHUrCbKqS7mxSOFIx4EPZXt+46jTORCL1Ld5aWzLG76zXsF+LvI5U+EOYL+EX+po2WsXNHEShLO2vEblkv1qMsY2xyazEwQ5leZ2Ih1aFSaTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744853595; c=relaxed/simple;
	bh=HDQGG1Q34BlSkCWW84cNeWYaQgfA3isd36S41ZwwwX8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O4wHXhSyVvGS5pAKKTFjxwn/+PClUtmFlx1LW50vRbr7MdEYSSc68Vq3IMsVwtt0GdxSkqQ6Hw6JqE50ZU4mdqO5+WfoI3dUlmDJGuqIsbz3ZrSCKa2NM7PZDtJtTuzgPbwOtATL0ccnWSfJLBj6CMSO3ksylsj+WB/pZb3n+qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=hkUrl3Li; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-227b828de00so2898145ad.1
        for <linux-kselftest@vger.kernel.org>; Wed, 16 Apr 2025 18:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1744853593; x=1745458393; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T9lrbIvu6zRRiCj4HgSRrtBo19PyxJ2njnhqzeLily8=;
        b=hkUrl3LiEJHREHfPNkhc2sQgCARPtZWI8yljzopy2FWFpAPbqq4sKtNwsLZe5pvUE3
         9IT5cOffJqq0SXyWpZlcz1TX5BHxwDA0KtUXi24A2/sgRUsc2a+NGQYFDyb8aKySkiy7
         vILEHcsZod/awwSFn7Z8ixz0BG4KkSowIUvmU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744853593; x=1745458393;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T9lrbIvu6zRRiCj4HgSRrtBo19PyxJ2njnhqzeLily8=;
        b=QRQrkHpPxQr/8viJF6NngBLNjdpPkRg3GvYRL4Vl/C7u9m03X/TczXZ5gQVhzXRUK0
         bSJB2xCvEEA0/SkoWE7a8a82l3TTQovnxjQsF0QqRKE1wLWfRoQeHrT2eaxGJGpS+qk4
         7kbq4ZH6Bjd213lIjFP+mfw5a1Yw9peW7NZzJ43ZLEmyKT3FjaLA+DrmEd5nwEPyMdjw
         rsdqYgjqDcqAsjxyshpkz4hjVWCEz/MLN5XC74PRyXmSQVf9ctulBCoyTryeBHhcEuKM
         lNXttOkybsV7p3aT5OprW/B/DAMYRadfkLkHIuDzZ3JEObfLODdp1jw90P3zr3/IbNdu
         3KMw==
X-Forwarded-Encrypted: i=1; AJvYcCUYtSFR7rWufZDmUwTioQI4/UvL/9yvTtirGscfQHTAFdyyiGoaLCE36C3HkOwq3FFZJONRtRebARObqInmcbE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2IV1Te5amrfio+pEw4dKn2zQzwmfZtEh91kzhbpLnrCCo8VeT
	EBOPH6YvUAYiAP0oNekCc4GtAlJepSYxOblBbf6B3tRV/e1423qrTtU7kmxTZK9zynpFudQsvOe
	K
X-Gm-Gg: ASbGncs1boTw2qBoL5KprxdXCvXpEaYoQAhBzhzmBTsh+Aa9wm7Xb/et1fwfXOOQt2b
	pAcchv6J2DLOYElk+m29o/5GZvToWBsH6MYOq9AzbG97aKPZi+1kB/F2FQ4eHhN41adTEKX17Nn
	kUzOIS4Qk4qszsU+4DbRWXB7AYM+pDgJlpFoXA4iDesFPD29kDK9zQEq4jEL1vhKQJUBcWp3r5h
	bk2Umw3rIisDmpKpmsk6veng6RCeeJv0T3UjPvd7U9vL5G+CWlDc4v1mbOmqNlV58N9a3Cfa405
	vQN5SQrwwMLqCFYHAZUgOgIdW0dlq9lCh5vb8fTF1ReFO4mt
X-Google-Smtp-Source: AGHT+IGIfvnYetCCtpkkTem0fvDPcVdKvorATj17pj9pyflpstgaWD/lkjveVAKVWM6ThAFzVxniww==
X-Received: by 2002:a17:902:d4ce:b0:220:c63b:d93c with SMTP id d9443c01a7336-22c3598533cmr61830925ad.44.1744853593562;
        Wed, 16 Apr 2025 18:33:13 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c33ef11c7sm21349505ad.37.2025.04.16.18.33.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 18:33:13 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	Joe Damato <jdamato@fastly.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Xiao Liang <shaw.leon@gmail.com>,
	Willem de Bruijn <willemb@google.com>,
	linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next v2 3/4] selftests: net: Allow custom net ns paths
Date: Thu, 17 Apr 2025 01:32:41 +0000
Message-ID: <20250417013301.39228-4-jdamato@fastly.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250417013301.39228-1-jdamato@fastly.com>
References: <20250417013301.39228-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend NetNSEnter to allow custom paths in order to support, for
example, /proc/self/ns/net.

Signed-off-by: Joe Damato <jdamato@fastly.com>
---
 tools/testing/selftests/net/lib/py/netns.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/lib/py/netns.py b/tools/testing/selftests/net/lib/py/netns.py
index 8e9317044eef..8d5c26317cb0 100644
--- a/tools/testing/selftests/net/lib/py/netns.py
+++ b/tools/testing/selftests/net/lib/py/netns.py
@@ -35,8 +35,8 @@ class NetNS:
 
 
 class NetNSEnter:
-    def __init__(self, ns_name):
-        self.ns_path = f"/run/netns/{ns_name}"
+    def __init__(self, ns_name, ns_path="/run/netns/"):
+        self.ns_path = f"{ns_path}{ns_name}"
 
     def __enter__(self):
         self.saved = open("/proc/thread-self/ns/net")
-- 
2.43.0


