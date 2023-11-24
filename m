Return-Path: <linux-kselftest+bounces-556-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 558777F780C
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Nov 2023 16:44:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 112231F20F6A
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Nov 2023 15:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF53D31740;
	Fri, 24 Nov 2023 15:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="B/EgoYYR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F380D19A5
	for <linux-kselftest@vger.kernel.org>; Fri, 24 Nov 2023 07:43:54 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1cf89e31773so13658055ad.0
        for <linux-kselftest@vger.kernel.org>; Fri, 24 Nov 2023 07:43:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1700840634; x=1701445434; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QI5gs5undxsY3d7gpx1BT78LGzAvxgEfNmwdo9O1W20=;
        b=B/EgoYYRKvl2l91cJluzrTTyKLE2J2RXV1DiS9R8oYXA7TIhoDjFvvIhTqiSRy92gh
         rAK002tjsdojq+mS30lHTEr/bxRRnN/y79QfNlMq/pPmK/xX9UtWj9Koai8pshiPmOOv
         2OMuM/lyOqt9UhhXBFVX1Epq7P0k2WTBEPG68pB3XCkoBIhW9Qdtf1gtF4Y/YTgwfYAn
         6g6cuI17Dywzn0B5ftDPcUeM8b4NzFsNTKfD9p8xDOOfyK/ti0ONUFS8CE5O1/J0qiag
         tvaVf5DPWiPekY5C1IAjNwMCxyk8Q2s8io3asise1DmV5Ovk74v2LWeWtltPgmESVIPx
         RrNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700840634; x=1701445434;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QI5gs5undxsY3d7gpx1BT78LGzAvxgEfNmwdo9O1W20=;
        b=XujxOEc7TuAlB3lP67d29q+1N4d49KrcTrGsHa2V/QfoA6NBBgp21A3QU0cJ4SytmV
         YwkgNOvA7YG/Jyk3zerIz2376AkO0ucJkaEMWcukYYxyj75+VryA5hArm1eiYRmZvjiM
         nBZuXEFPq7+oXLwVOv+9G1GowjcS+vQ4HX2jW448RTD2sQpwQ/NrstGoPXGsw/t82YZw
         PKqIiOtBJLN4Oxzbq/ESViYsPLq91Nwh2qedRCg3JsIY5aGaBL//L4mi6PDZw58ox42i
         n7Tn6iXT2YKB7ws9w9KYeevdK5+NbI3S1GRHqJ33Gg3I3oKAcJlJqnQvtrgq0fKVQ4oj
         +MXA==
X-Gm-Message-State: AOJu0YxWmq1+ID2TMPpKDsilolcrAC0ZRZEipe1vFsn26+sZB9c3Stuu
	qdWmDGJbzKSlgD6e8FvPqD8XWg==
X-Google-Smtp-Source: AGHT+IHjL5+9IkJrkQHCVZiSdxWSDRWph5fyPR/F+l48erJe0XmC6bse9B75u6rGy8t52KT2Qxy76g==
X-Received: by 2002:a17:903:264f:b0:1cf:6584:4860 with SMTP id je15-20020a170903264f00b001cf65844860mr2968301plb.10.1700840634435;
        Fri, 24 Nov 2023 07:43:54 -0800 (PST)
Received: from rogue-one.tail33bf8.ts.net ([201.17.86.134])
        by smtp.gmail.com with ESMTPSA id g6-20020a170902740600b001cf9eac2d3asm1919743pll.118.2023.11.24.07.43.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 07:43:54 -0800 (PST)
From: Pedro Tammela <pctammela@mojatatu.com>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	linux-kselftest@vger.kernel.org,
	bpf@vger.kernel.org,
	llvm@lists.linux.dev,
	Pedro Tammela <pctammela@mojatatu.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net-next 3/5] selftests: tc-testing: prefix iproute2 functions with "ipr2"
Date: Fri, 24 Nov 2023 12:42:46 -0300
Message-Id: <20231124154248.315470-4-pctammela@mojatatu.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231124154248.315470-1-pctammela@mojatatu.com>
References: <20231124154248.315470-1-pctammela@mojatatu.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As suggested by Simon, prefix the functions that operate on iproute2
commands in contrast with the "nl" netlink prefix.

Cc: Simon Horman <horms@kernel.org>
Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
---
 .../selftests/tc-testing/plugin-lib/nsPlugin.py  | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/tc-testing/plugin-lib/nsPlugin.py b/tools/testing/selftests/tc-testing/plugin-lib/nsPlugin.py
index 65c8f3f983b9..dc7a0597cf44 100644
--- a/tools/testing/selftests/tc-testing/plugin-lib/nsPlugin.py
+++ b/tools/testing/selftests/tc-testing/plugin-lib/nsPlugin.py
@@ -37,7 +37,7 @@ class SubPlugin(TdcPlugin):
         if netlink == True:
             self._nl_ns_create()
         else:
-            self._ns_create()
+            self._ipr2_ns_create()
 
         # Make sure the netns is visible in the fs
         ticks = 20
@@ -71,7 +71,7 @@ class SubPlugin(TdcPlugin):
         if netlink == True:
             self._nl_ns_destroy()
         else:
-            self._ns_destroy()
+            self._ipr2_ns_destroy()
 
     def post_suite(self, index):
         if self.args.verbose:
@@ -161,7 +161,7 @@ class SubPlugin(TdcPlugin):
                     ticks -= 1
                     continue
 
-    def _ns_create_cmds(self):
+    def _ipr2_ns_create_cmds(self):
         cmds = []
 
         ns = self.args.NAMES['NS']
@@ -181,26 +181,26 @@ class SubPlugin(TdcPlugin):
 
         return cmds
 
-    def _ns_create(self):
+    def _ipr2_ns_create(self):
         '''
         Create the network namespace in which the tests will be run and set up
         the required network devices for it.
         '''
-        self._exec_cmd_batched('pre', self._ns_create_cmds())
+        self._exec_cmd_batched('pre', self._ipr2_ns_create_cmds())
 
     def _nl_ns_destroy(self):
         ns = self.args.NAMES['NS']
         netns.remove(ns)
 
-    def _ns_destroy_cmd(self):
+    def _ipr2_ns_destroy_cmd(self):
         return self._replace_keywords('netns delete {}'.format(self.args.NAMES['NS']))
 
-    def _ns_destroy(self):
+    def _ipr2_ns_destroy(self):
         '''
         Destroy the network namespace for testing (and any associated network
         devices as well)
         '''
-        self._exec_cmd('post', self._ns_destroy_cmd())
+        self._exec_cmd('post', self._ipr2_ns_destroy_cmd())
 
     @cached_property
     def _proc(self):
-- 
2.40.1


