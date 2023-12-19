Return-Path: <linux-kselftest+bounces-2184-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 05A548184C6
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Dec 2023 10:49:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 948211F268BD
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Dec 2023 09:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DE4513FFC;
	Tue, 19 Dec 2023 09:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dOsmmrZC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE45014A81;
	Tue, 19 Dec 2023 09:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-59082c4aadaso2902354eaf.0;
        Tue, 19 Dec 2023 01:49:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702979364; x=1703584164; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O5vxiul68UUq7JIxAGkLhv/RlMa8nWcUJYgyt5si0Ac=;
        b=dOsmmrZCtWHNOufWcL0BBX2WtswxV/cBV/RZ/JymQjG3gQlG22p/0eF/u5IGr1nC4R
         RYCWCWrBPcu7AtEvyStO9YcsBV+QJ3WGea0lcZQ5GxPzYTMM/SsYN7jxB2ZVc1BxqivQ
         fhUX1vGfBA1WcCfpQ9ra0VBusn5Op8G/sZvED6c45BV7mGyNoyH9sFiv3Veln+zqyfGy
         s7SyZ85UUPsXHceocD/fBNZvL/ToLgCFY0MnDKEfgRzeM9ogjuFrr4bnkaYjjQwCLBI2
         t8mpmbWk1C6TKc8vJTc5IHWJji/3UDFihUKmJeyNXJNxI7UD6yQsliHSEB6moX/k8z41
         AUiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702979364; x=1703584164;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O5vxiul68UUq7JIxAGkLhv/RlMa8nWcUJYgyt5si0Ac=;
        b=wiW5f+57BzKSanC8VoEtlm/BAM9giFKTGPA2cNJ/vKOOcCp/6LGBh3tO0TxS8oLMZi
         n//SLw82DvKbfblBkki9fciwy6tkW3/T/NCG6KGaLcvtOnAI92mUJCcDpPsyMOuNEEyg
         SSwDkwu7WaZEFwp/VwHTBn9AJgg0TDuPfAT4p8YwPA4EswuSMjQ6ic7qjGpwXsEvB7Qj
         ca+yRh6I4ltk6Jkltqfep82z4oXxnJ2qBE7Aw1NCICWZq1fZekDn6cWy6lftVGrxfCuF
         I5Bf9guXUBcqXYq0zCHwk/gC/CT0XYaw3YcTTj/5zQ2DkaPqqWfAv5T6Q0DbI5idYSWI
         VWxw==
X-Gm-Message-State: AOJu0YxgbivwmCLVUXECLrY4SvwNVqjPAtL9bnoKIf9VKhoLs9t7bYs2
	RXY2ZVe0XNoH5rumHeWUkKahv3V1sw2fbMziHkQ=
X-Google-Smtp-Source: AGHT+IGDR7QXLAsme5W+PS5J+crSxMckw6cDDgk6OKxxSPG+K9Yo81vh3Fp9pd88l90I7lXGFRiDTw==
X-Received: by 2002:a05:6358:6f1c:b0:172:aebe:6995 with SMTP id r28-20020a0563586f1c00b00172aebe6995mr4240677rwn.62.1702979364068;
        Tue, 19 Dec 2023 01:49:24 -0800 (PST)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id ds17-20020a17090b08d100b0028b21d24ba6sm1076276pjb.15.2023.12.19.01.49.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 01:49:23 -0800 (PST)
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
	Florian Westphal <fw@strlen.de>,
	Martin KaFai Lau <kafai@fb.com>,
	Stefano Brivio <sbrivio@redhat.com>,
	Kees Cook <keescook@chromium.org>,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCH net-next 4/8] selftests/net: convert stress_reuseport_listen.sh to run it in unique namespace
Date: Tue, 19 Dec 2023 17:48:52 +0800
Message-ID: <20231219094856.1740079-5-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231219094856.1740079-1-liuhangbin@gmail.com>
References: <20231219094856.1740079-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Here is the test result after conversion.

 # ./stress_reuseport_listen.sh
 listen 24000 socks took 0.47714

Acked-by: David Ahern <dsahern@kernel.org>
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 tools/testing/selftests/net/stress_reuseport_listen.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/stress_reuseport_listen.sh b/tools/testing/selftests/net/stress_reuseport_listen.sh
index 4de11da4092b..94d5d1a1c90f 100755
--- a/tools/testing/selftests/net/stress_reuseport_listen.sh
+++ b/tools/testing/selftests/net/stress_reuseport_listen.sh
@@ -2,18 +2,18 @@
 # SPDX-License-Identifier: GPL-2.0
 # Copyright (c) 2022 Meta Platforms, Inc. and affiliates.
 
-NS='stress_reuseport_listen_ns'
+source lib.sh
 NR_FILES=24100
 SAVED_NR_FILES=$(ulimit -n)
 
 setup() {
-	ip netns add $NS
+	setup_ns NS
 	ip netns exec $NS sysctl -q -w net.ipv6.ip_nonlocal_bind=1
 	ulimit -n $NR_FILES
 }
 
 cleanup() {
-	ip netns del $NS
+	cleanup_ns $NS
 	ulimit -n $SAVED_NR_FILES
 }
 
-- 
2.43.0


