Return-Path: <linux-kselftest+bounces-526-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5F107F6FB4
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Nov 2023 10:29:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC4331C210AC
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Nov 2023 09:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BED05156F3;
	Fri, 24 Nov 2023 09:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jjRTupfw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF383130;
	Fri, 24 Nov 2023 01:29:36 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1cf6af8588fso14319845ad.0;
        Fri, 24 Nov 2023 01:29:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700818176; x=1701422976; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mSdx8GS+b0xUE5GZ/iaHB/fey9E+HXntCQjcqFbcipY=;
        b=jjRTupfwFqUfSX4scMXujqz85zvGkgmMF6KK2f9Q2+6RcgXVIXwKe6toHmngvPmrha
         4C21koQZrgA3AzKfDGSqVmgpxJhf2Y3Itj498K5SJhx10ksSld0NVUecr+fnS6DkB9Mc
         Jlv3pJdwlLXi5t7E1WYx+U8O6Fxj9WrdaG4UTiUynPc73OFbbnPnUyrhtYPeSjDPpXIW
         ANrhfQntaHN/YIFgwqVOxmMP7LoC+WuUXkyzOAi1+sAbvoAq9NRUQElJyVTpVwkZEwOw
         eQJLc3xLDZdHAnfvSPSro6/PSDFUf8tYRgheInlzeSB8rMq6a4KzUkQwMQKRFSOaVRHK
         U/RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700818176; x=1701422976;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mSdx8GS+b0xUE5GZ/iaHB/fey9E+HXntCQjcqFbcipY=;
        b=dcAZgyRPDP6Hpecchlt2bcJCqt85e+yVyY5nVvQNbqDsGfvgoWpCMFtTNvyUz0zaIt
         ZouwSGZA+iy1XFWtq98eU9XoGQX3zqWTOJF5m6GzHr2Gp/CeqKq04YGVragL9LhtOSzV
         SiAUYmOYZ11FXyFZVsS0PFvUMikZWt8Mzn2W1YzzhyJoTBxk9Jwz6kRHfKRoTIapBOuo
         seLrzAjU56tJUn07qARbW4Zzbfh6h6hk3sWCIOf+CKkE31O8wyYvwMEfGoJjiGutZGIm
         mxaFYASDMEM4tMX3kys/3v2d/qU3uwAgOmGmknJdEbZUxYxVK/Y/ssSBNJi9Zbpnh5kF
         Ee8Q==
X-Gm-Message-State: AOJu0YzgZ0dKtEOvCcpyHDo4mMBcAA7xFRPxGdc6iisaKVwd0x8v2miE
	urpi4olQiyzGhb0EyNDcShLuKhJyaEiIleGy
X-Google-Smtp-Source: AGHT+IFCQZNBLV9O8UbqkiJCD4D3mxCEcqaOQwkJTwBnH+Thg2Ta2dxntEx7G8i34L4EbU9DoMG8MA==
X-Received: by 2002:a17:902:da82:b0:1cc:5674:9184 with SMTP id j2-20020a170902da8200b001cc56749184mr2337054plx.31.1700818176096;
        Fri, 24 Nov 2023 01:29:36 -0800 (PST)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id o10-20020a170902d4ca00b001cfacc54674sm32679plg.106.2023.11.24.01.29.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 01:29:35 -0800 (PST)
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
	Guillaume Nault <gnault@redhat.com>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Mark Brown <broonie@kernel.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCH net-next 24/38] selftests/net: convert stress_reuseport_listen.sh to run it in unique namespace
Date: Fri, 24 Nov 2023 17:27:22 +0800
Message-ID: <20231124092736.3673263-25-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231124092736.3673263-1-liuhangbin@gmail.com>
References: <20231124092736.3673263-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Here is the test result after conversion.

]# ./stress_reuseport_listen.sh
listen 24000 socks took 0.47714

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
2.41.0


