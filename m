Return-Path: <linux-kselftest+bounces-1795-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06F488109D7
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Dec 2023 07:09:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39370282089
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Dec 2023 06:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE746DDA3;
	Wed, 13 Dec 2023 06:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GTphdjNl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B928798;
	Tue, 12 Dec 2023 22:09:11 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id 5614622812f47-3ba1be5ad0aso1068651b6e.0;
        Tue, 12 Dec 2023 22:09:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702447750; x=1703052550; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=22zEJ+GxtUyJSFDLu51q+tPWKHq87+5dqP6gAdHZUr0=;
        b=GTphdjNlGB67w4llq3mWYP/Tsk41b8WhOxUu/ayMHJPOZTqHlLiYde5UYrrmet8xMW
         SMhOhih2947pSpXnB0RGV7aDSlFNpYg9QKeD5wGhRQalFY3UQ3KvE8WVi8LTLFe88+Th
         j66ut4otkKu9Wf+ao7ZJPLaA7NpBSzrJuhVYNfSO+9mgZHEqb2kLtil3EZRGo8UNGnQD
         0rH/Jc7nw9CxxtU6HvWAoqPoliyiW6BF6UlA2GC88kxmFauPTCTRjvdfDPH1hiWhkywE
         Bm6luNu4lk6JNHHEQrat2arl24OgHyQ8pq6z0M8A4OH14gUaMG067Af/oeIyeXZ7IIUz
         AeOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702447750; x=1703052550;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=22zEJ+GxtUyJSFDLu51q+tPWKHq87+5dqP6gAdHZUr0=;
        b=pqt6TR3RkOh70bByKTFJIPfezEYsHGG2E7V9CiUISOHCg96/ryaOes607i4movDGpx
         TAeA2nov0iJwQHE4jwHIzkApRrFEGVfU0biee0eAOdA9fFYeUOjTUyXIZXroQ/LLjpE8
         IxR0lc+JaCEqWeet+unXnLEbCUHnpwZOBVMTN5lv3PxetLi/Q6QyTHMLxm5bq3ZbSgbK
         LnGVkIPOy1N8jvWk0VeMVkPqW6x39HuQtBSvM7LrQYfOIruf9u/Cgf/62uXsaPijcda6
         sENKj08GNVvCfUH7VwUXEI9JOZlaLvzEBz/RLxLVov99CCUL+sGFj7eE/njQ9XSc1Xip
         8Wvg==
X-Gm-Message-State: AOJu0Yyc0zRBMaoZF+jGgqAjLqaJwc+DW5EAOeAYWJQKB7cq7Eq4FKAR
	YdsjlgDV7JGXOgAC5vH2fDu8bi/IY+mff9sJtmo=
X-Google-Smtp-Source: AGHT+IGtNmHDDuYXmYjwcRc6YHzYxPA8y2S4bsA+hmFiAEL2bvOaRKJxHUqm2wx5Q0W9SlHGhhm9rA==
X-Received: by 2002:a05:6808:1898:b0:3b8:b063:5d5d with SMTP id bi24-20020a056808189800b003b8b0635d5dmr7918878oib.68.1702447750195;
        Tue, 12 Dec 2023 22:09:10 -0800 (PST)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id kq9-20020a056a004b0900b006cef5e5a968sm6890084pfb.201.2023.12.12.22.09.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 22:09:09 -0800 (PST)
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
Subject: [PATCHv2 net-next 01/13] selftests/net: add variable NS_LIST for lib.sh
Date: Wed, 13 Dec 2023 14:08:44 +0800
Message-ID: <20231213060856.4030084-2-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231213060856.4030084-1-liuhangbin@gmail.com>
References: <20231213060856.4030084-1-liuhangbin@gmail.com>
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


