Return-Path: <linux-kselftest+bounces-557-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CDDD7F780F
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Nov 2023 16:44:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1DAE281353
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Nov 2023 15:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D56F531751;
	Fri, 24 Nov 2023 15:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="qam3F906"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD7CE1BCD
	for <linux-kselftest@vger.kernel.org>; Fri, 24 Nov 2023 07:44:00 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1cf80a7be0aso16743565ad.1
        for <linux-kselftest@vger.kernel.org>; Fri, 24 Nov 2023 07:44:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1700840640; x=1701445440; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=meBAQ3i5bzteTDjsadEVqP3IdyNZUBxruoeAMf+7W4k=;
        b=qam3F906LMRyLWAhhlGWfMRMmxHneO5O/2B11kLv9M99EnjJsSBqlyeT6HrIQG2ZDi
         XYNegTrx04O1mZE+NHyQngFQsXa/HUPrlynIF1aOHzQQKIo8TcJzp1K6GqoHqzsnz1g2
         m+QEr1ilS5wPIJanPxwRPhRksHsUz9EQ+XY/8xH38V2ZCKo2UdT79w5lLlDOm5kpjsTQ
         2Uwjv2wbpZM4DL96f8EgAwuUcrXJq3WZarkgyPWHywtxZlSP6oDcCco3WpQsxEPAkByd
         LO1mluHnyFntGE4yBztOSXI1DV8U5qxGTgdCiePbHxRi0wJxOiNDo1TxyJRUXBjhs1AQ
         HclQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700840640; x=1701445440;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=meBAQ3i5bzteTDjsadEVqP3IdyNZUBxruoeAMf+7W4k=;
        b=VVLOPLq9c5iqjn5yq4CM0B+oUFBQxPzwi885GT9VYEcmor25RtlUT/hJh3kbxYN0Ti
         4WXF+vzhIPuJMAKk3QsuLGoEI+Da38ZOWM8t4pDX95FA0AfHvFN+kdRCYu0SQ6GZ6mQf
         5LQLrq9tS1NAD2lzg0krSYoefBlY5GePFzSNtRCUyniJPMSJGFn8ifyAe+ium2lnbUiq
         PoEgRH4L46HDKIlm/7cJfYLenitc0BN1xno34Q9b2b67QN65mU69YOaGqnNurA7y2AwS
         h2YvMkhIPLw/GWy/5b3N/kIGvadn5OCcOLGV+n/15CS5mb2A/sfhIzpCwEM78D9Q4gCy
         GCgA==
X-Gm-Message-State: AOJu0YyNr7qO+lqWxWaN5Gv2WY/SLP0hTOZMyj101DMUhE94SE1OGLzd
	JmCSyMxhJD2Be+pzflUMcdPV4g==
X-Google-Smtp-Source: AGHT+IEI/gV9/wjUMlivgVIkBGWHfGfGb1pfZNnDlb9nUwelvrY0VHUqAQAEdEhIc9BPVn6KNayM2w==
X-Received: by 2002:a17:902:e752:b0:1cf:6aae:5998 with SMTP id p18-20020a170902e75200b001cf6aae5998mr4296165plf.0.1700840638351;
        Fri, 24 Nov 2023 07:43:58 -0800 (PST)
Received: from rogue-one.tail33bf8.ts.net ([201.17.86.134])
        by smtp.gmail.com with ESMTPSA id g6-20020a170902740600b001cf9eac2d3asm1919743pll.118.2023.11.24.07.43.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 07:43:57 -0800 (PST)
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
	Pedro Tammela <pctammela@mojatatu.com>
Subject: [PATCH net-next 4/5] selftests: tc-testing: cleanup on Ctrl-C
Date: Fri, 24 Nov 2023 12:42:47 -0300
Message-Id: <20231124154248.315470-5-pctammela@mojatatu.com>
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

Cleanup net namespaces and other resources if we get a SIGINT (Ctrl-C).
As user visible resources are allocated on a per test basis, it's only
required to catch this condition when (possibly) running tests.

So far calling post_suite is enough to free up anything that might
linger.

A missing keyword replacement for nsPlugin is also included.

Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
---
 tools/testing/selftests/tc-testing/plugin-lib/nsPlugin.py | 2 +-
 tools/testing/selftests/tc-testing/tdc.py                 | 6 +++++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/tc-testing/plugin-lib/nsPlugin.py b/tools/testing/selftests/tc-testing/plugin-lib/nsPlugin.py
index dc7a0597cf44..77b1106b8388 100644
--- a/tools/testing/selftests/tc-testing/plugin-lib/nsPlugin.py
+++ b/tools/testing/selftests/tc-testing/plugin-lib/nsPlugin.py
@@ -78,7 +78,7 @@ class SubPlugin(TdcPlugin):
             print('{}.post_suite'.format(self.sub_class))
 
         # Make sure we don't leak resources
-        cmd = "$IP -a netns del"
+        cmd = self._replace_keywords("$IP -a netns del")
 
         if self.args.verbose > 3:
             print('_exec_cmd:  command "{}"'.format(cmd))
diff --git a/tools/testing/selftests/tc-testing/tdc.py b/tools/testing/selftests/tc-testing/tdc.py
index c5ec861687b6..caeacc691587 100755
--- a/tools/testing/selftests/tc-testing/tdc.py
+++ b/tools/testing/selftests/tc-testing/tdc.py
@@ -1018,7 +1018,11 @@ def main():
     if args.verbose > 2:
         print('args is {}'.format(args))
 
-    set_operation_mode(pm, parser, args, remaining)
+    try:
+        set_operation_mode(pm, parser, args, remaining)
+    except KeyboardInterrupt:
+        # Cleanup on Ctrl-C
+        pm.call_post_suite(None)
 
 if __name__ == "__main__":
     main()
-- 
2.40.1


