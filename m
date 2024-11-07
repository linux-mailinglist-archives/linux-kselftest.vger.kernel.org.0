Return-Path: <linux-kselftest+bounces-21609-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ECE99C0787
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Nov 2024 14:33:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 275CCB2134B
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Nov 2024 13:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1696C212D1A;
	Thu,  7 Nov 2024 13:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lgHsPeCS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A60F210188;
	Thu,  7 Nov 2024 13:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730986260; cv=none; b=cBVH9wCxmQfQKdIGpNIozlv+goZKraQg+Q56hkYuES8vRijCl97bcrM4shV0FSxVTJrWU8CpJP6dhpyGKO+F8mkRo6fV2vN/nq/f+x/yhzBckuCpXeijxJraZKJOvmimPuFP3XhS4r0NTrnSc/MLCx4/ZzKGF+8SKOZsa9dGgKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730986260; c=relaxed/simple;
	bh=lksVcw2gq5LR6jEmpI4cHWB5J25IFrGgoWPkr++Yw/g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hcs3PZhd1S3CZYDis7NzF1+qT9Ljczl8J/BLpaQ4eYGNpC35WkARSGETWN4M0wdZikCZrwcyM9EUcppsC+j1Ft2KdhB8A1Ppx8YZuXihekbMs/1/lSyETr6ic9P5is2/9JfxHvuSz6u7WHRB7ERL9D1YUiWHNbkyWyAHEyL4++k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lgHsPeCS; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-2951f3af3ceso591199fac.1;
        Thu, 07 Nov 2024 05:30:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730986257; x=1731591057; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v/sPiX4msaWzkl3dC5zUiLMAXLFRKVpxYb5+istaczI=;
        b=lgHsPeCSOmcSPIhXl4P2G3P6TfI+Tvwe9+xQaaZ//uubt7nvT0DuJldnddEbiOve+c
         czlmQihzaLOSsZpfte8Fbw6pw//mBXZbZX8udxgYVUz+I43tqtcz6Vu+2H8iCjeIBbAp
         qVLHHsBWg71rVd/9Q0D28cc80Q9g70DOgKjfjMcqMRrL7N4uuuENKbWLCPSQ/93NncK4
         nIaMhq1v0QfddPXdr1U+7av4HN54Bs144U8VSvwtv1lEA+O4Xc2NYoXK/NVjJmmKiA57
         6lkBA64kPILMbv61t2rNOLM9O4FHYKocp0uObqvNbzItYOp/pwspeYQBntpTo8Kd4vM4
         Ae7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730986257; x=1731591057;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v/sPiX4msaWzkl3dC5zUiLMAXLFRKVpxYb5+istaczI=;
        b=AsAhs01fhepb6/csTRrG7DDHT/kLg687mTDNZripnwxAXggatAPQJLAgx5R9MzuO4v
         iMnbwByfTay9MQaTDjwXubP5mTsDozkqPQoJPVl56y9QO+OLoAFHpsznU8+jmrzD4dJr
         A/sM1ocTCvrtBJPeJXgc5Rpk8GaQk9cx0UA4lK0XsOA/s+S5w2grf/DRcGOcrAeKlQKs
         DzYeX/JfxYYHKR+KuHzrYI0Q32hWQNsKp+Lzi+t7XhFC5ZZ0/tbKkQXhzUFXQn2f4qO+
         HfNkXUU07bUM/dj6zsITl5kGcDaqbVrQwtZS1frInNfAxDSq8SNPJWIgkEiYNTDOZqjV
         1Xiw==
X-Forwarded-Encrypted: i=1; AJvYcCVRJU3WEG6g8N/tts2JdOnmprF2BLHzuJfFj3/3RVlSJyw1h1ywUmDmPWNnylpmXmJACybVK4LveTN+b+tD6iw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLDkwW4fj0ubHj1L+TNk0wk5ox/OKPF3/SOBjZngOmUUPKVddy
	8iZ+9CY1fVEhpkYwOxdbnmAq+4PEC6ze2kKodJCsdo9jgkOAxnla3zDH3k5AQpo=
X-Google-Smtp-Source: AGHT+IFRMc2iwIo5lsI6Tk3LdxarpcBShY9iMipSXsnnSJgSUBkktGhIsVkOAdRsmLaTWGO3LAHpNA==
X-Received: by 2002:a05:6870:3648:b0:25e:e6d:5247 with SMTP id 586e51a60fabf-2949ed975c5mr20120367fac.14.1730986257211;
        Thu, 07 Nov 2024 05:30:57 -0800 (PST)
Received: from nova-ws.. ([103.167.140.11])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7f41f65b5afsm1359303a12.76.2024.11.07.05.30.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 05:30:56 -0800 (PST)
From: Xiao Liang <shaw.leon@gmail.com>
To: netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCH net-next v2 7/8] tools/net/ynl: Add retry limit for async notification
Date: Thu,  7 Nov 2024 21:30:02 +0800
Message-ID: <20241107133004.7469-8-shaw.leon@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241107133004.7469-1-shaw.leon@gmail.com>
References: <20241107133004.7469-1-shaw.leon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since commit 1bf70e6c3a53 ("tools/net/ynl: improve async notification
handling"), check_ntf() would block indefinitely if there's no messages.
In some cases we want to set a limit on waiting time. This patch adds
max_reties parameter check_ntf(), and makes it stop when no message is
recievied in that number of consecutive retries.

Signed-off-by: Xiao Liang <shaw.leon@gmail.com>
---
 tools/net/ynl/lib/ynl.py | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/net/ynl/lib/ynl.py b/tools/net/ynl/lib/ynl.py
index 92f85698c50e..dff5166a4650 100644
--- a/tools/net/ynl/lib/ynl.py
+++ b/tools/net/ynl/lib/ynl.py
@@ -907,7 +907,8 @@ class YnlFamily(SpecFamily):
         msg['msg'] = attrs
         self.async_msg_queue.put(msg)
 
-    def check_ntf(self, interval=0.1):
+    def check_ntf(self, interval=0.1, max_retries=None):
+        retry = 0
         while True:
             try:
                 reply = self.sock.recv(self._recv_size, socket.MSG_DONTWAIT)
@@ -933,7 +934,11 @@ class YnlFamily(SpecFamily):
 
             try:
                 yield self.async_msg_queue.get_nowait()
+                retry = 0
             except queue.Empty:
+                retry += 1
+                if max_retries is not None and retry > max_retries:
+                    return
                 try:
                     time.sleep(interval)
                 except KeyboardInterrupt:
-- 
2.47.0


