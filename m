Return-Path: <linux-kselftest+bounces-1504-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9CC880C5F0
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Dec 2023 11:09:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EE321F21551
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Dec 2023 10:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE4E3225D6;
	Mon, 11 Dec 2023 10:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d12gNZpV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C91F3106;
	Mon, 11 Dec 2023 02:09:36 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-6cebbf51742so2824374b3a.1;
        Mon, 11 Dec 2023 02:09:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702289375; x=1702894175; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=22zEJ+GxtUyJSFDLu51q+tPWKHq87+5dqP6gAdHZUr0=;
        b=d12gNZpVqJQmq9KdlsVx8RUMbWBUfCRQ/Pf+cOxkiWBkL1r+I89lA/xwlslwIe4h6K
         oqcz7Jtv1ZPO0yVNOSuAdtsXQ3QE0ptTAfr8W4k/G3PoSzO5aZGvgU40yMd4lKg1Yybr
         KSkbEyeHhS1ZeNp/fh46kFpIcl0AS8xGFj5z3oHBajcviq4Nbjr75MXLo9kWVZvQ2oYb
         RKu+YLibgxOLcmcVAA+Nnqc7ogAFsGer+U2oQYSG2xExFy4TnnEvX40nG2TLH7lFdDrx
         aaliXTWGPJBVIL3l0gi3zp4jzponDhNg2OkCGWTph9igx08JrwktjMzr0jTI3pXgXjpD
         dCjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702289375; x=1702894175;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=22zEJ+GxtUyJSFDLu51q+tPWKHq87+5dqP6gAdHZUr0=;
        b=tU3aNWkjHQBGkpHFRgY1vyr9BvsAzR8TSW4nNugTIDaYogaB1fLkzVBcg85WmwaQ1u
         romLemxy85rsFYKJUSm7EQfYI5tErDfFlCmFvIjGc96H6TOOEKluXyh8Mz7iPS6jTuyG
         9VL+C5ARDemKX2yaCKUJwfjLHisFdC1oR1eV+ogiW1MIxp47F/POS/KY6nIYQQ1JkXP6
         jF4KI471QdkX5jzTQTB/TKGrOCzcIFVP3nmR8M1etO3c81yeOwmV3Sg5V5+5rF6TEmqb
         SwyTt/B+JRIRFIpJjkW4mAuI9PEKx2nzg5sua+piaa5GdwwdTFCSkkTP73dU5c72eflA
         VKpg==
X-Gm-Message-State: AOJu0YxbY9CrE6TWXWpv7m67KdfyCxOgMdAxLzo2YI9A0cuJ24mt3pbi
	xVcNW0ycsVMv30p5jJ5uPxLpIJ1oKxhyjcF1
X-Google-Smtp-Source: AGHT+IE3msFSvAUEN478ioOTRxPoDnatWAnAGQSJ9dBUCPulodp8kc8Jtd5mQl+6y2GFsZmQHduI8A==
X-Received: by 2002:a05:6a20:3ca8:b0:18f:b899:8442 with SMTP id b40-20020a056a203ca800b0018fb8998442mr5245406pzj.6.1702289375462;
        Mon, 11 Dec 2023 02:09:35 -0800 (PST)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id o17-20020a656151000000b005c2420fb198sm5151733pgv.37.2023.12.11.02.09.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 02:09:35 -0800 (PST)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	linux-kselftest@vger.kernel.org,
	Po-Hsu Lin <po-hsu.lin@canonical.com>,
	Andrea Mayer <andrea.mayer@uniroma2.it>,
	Amit Cohen <amcohen@nvidia.com>,
	Nicolas Dichtel <nicolas.dichtel@6wind.com>,
	Roopa Prabhu <roopa@nvidia.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCH net-next 01/13] selftests/net: add variable NS_LIST for lib.sh
Date: Mon, 11 Dec 2023 18:09:13 +0800
Message-ID: <20231211100925.3249265-2-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231211100925.3249265-1-liuhangbin@gmail.com>
References: <20231211100925.3249265-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a global variable NS_LIST to store all the namespaces that setup_ns
created, so the caller could call cleanup_all_ns() instead of remember
all the netns names when using cleanup_ns().

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 tools/testing/selftests/net/lib.sh | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/testing/selftests/net/lib.sh b/tools/testing/selftests/net/lib.sh
index 518eca57b815..dca549443801 100644
--- a/tools/testing/selftests/net/lib.sh
+++ b/tools/testing/selftests/net/lib.sh
@@ -6,6 +6,8 @@
 
 # Kselftest framework requirement - SKIP code is 4.
 ksft_skip=4
+# namespace list created by setup_ns
+NS_LIST=""
 
 ##############################################################################
 # Helpers
@@ -56,6 +58,11 @@ cleanup_ns()
 	return $ret
 }
 
+cleanup_all_ns()
+{
+	cleanup_ns $NS_LIST
+}
+
 # setup netns with given names as prefix. e.g
 # setup_ns local remote
 setup_ns()
@@ -82,4 +89,5 @@ setup_ns()
 		ip -n "$ns" link set lo up
 		ns_list="$ns_list $ns"
 	done
+	NS_LIST="$NS_LIST $ns_list"
 }
-- 
2.43.0


