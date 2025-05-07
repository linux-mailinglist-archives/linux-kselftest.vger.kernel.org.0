Return-Path: <linux-kselftest+bounces-32577-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A351AAE091
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 May 2025 15:20:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5EC2980122
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 May 2025 13:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D96B0288CA7;
	Wed,  7 May 2025 13:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RfQk/EqI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644F4287513;
	Wed,  7 May 2025 13:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746623995; cv=none; b=MTL9Qm7BpQGTjiccIQjwlbBTvgeh9q+4u1b5KDBCc8fogNViQrvHcq7ZkVlFGOtQhN+vRlGd8++zQisCKivD//yuqppl/4Sd9z6C7ZArBCuzQpERFPemtUrXTC/BBx4v2CeRVspjhuyEH8DxdvI+YxDCMlsFr3X4H/ISAePRoVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746623995; c=relaxed/simple;
	bh=pGCESf98a2q8tFRVKDwEPR9HphxMHhS6pJq4K4rLTvg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uWMwkPieI8t/E2t3CnMKFkMEI1fCPbyhnee8Jpv0s2XsVK74q3tisHXFJytKrQOXJgIB24WJpMR14RLTr9JmzxjFChIGJ3nohEEkTx0P8AMQgViEJJeu4J4KAaUVyLEe4terRP6wDb5LKHdjZvB+vm1Qr6Zu9Rm3ufH+9PiIaAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RfQk/EqI; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-30a9cd61159so825363a91.1;
        Wed, 07 May 2025 06:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746623993; x=1747228793; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZWIeCnEAL6ezhpEyDQ2QxTqdF36G5ahedpjkpixynRI=;
        b=RfQk/EqI1wYNF0KDxiaLV5z1SgT20HEpEU0MB0RTVUAk3rX+RAL5JZUl9qPs69XDc/
         8DdmBHuZ5+OvutQDOVOENMPprT2X5xMTpkAP1oA9gVrnSTo5ERBxkbcwj/YpvH0c/Sq6
         j6KsDHvYbcuvOSX/JEQheUTs827agGuazXSeCugIuXKfgxPgIy8ZPLkaHPSffJFPMrAc
         jcze5yPsbSvbzPOLhQcjhLw6t3CvAZR7XAAoOuYxlPFf9I5gRy1ehv2sFCvxX7ge+YVN
         WVywqRlN1vNWzb13Pu+prfipXIEEUgHZe+VTGX4YEtCXtXXbeW3KiJZuBKc3Vil7NIMo
         Heuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746623993; x=1747228793;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZWIeCnEAL6ezhpEyDQ2QxTqdF36G5ahedpjkpixynRI=;
        b=YrMtRfNtnMXhZ4snfwQYvWbKdmyUr2HMptUJs4IO3pB73r7yil+gfFLsTMNCi+4tiQ
         VUQSN+6PAHiSsZdzMXrnuuB2NVDxHCbSkzCUd9LrnVLiTGyLAoGy/II2wr60BFZ3+iEj
         rJYtMltZ8O5mPKTpnouPviKzymmWhuvQ6cR/lHSSwPEV1m0DC4naQ31J9cm8WY8uPqKd
         ZzaKsPZttt0akDHWjMR8PjXSfMrOJdU4ezpyVEvOIZ8GLJYE/kZ5/FTfy5iJ2TaG0kDc
         pEgVYJWWxjTNmD3XMYMm9rgEO0oCVgOUK8vQOrGsY2kK40+48PKYvs8GjBfhxdp5SjZs
         vMTQ==
X-Forwarded-Encrypted: i=1; AJvYcCUemC3H47whS+RKNgoGowNa0kBOzf1CgSgqASnhSFO0l4XoRs1DROurJkpBKSdKDMkkdlf5f34EU3njVEfcfgk=@vger.kernel.org, AJvYcCUsEJOGJ5l+EH3hG4g/Fk7cp6noQz9+QibwhPlkCfARvvyxLC7W8sDk9tpYwwTaUw237mI1MlIdATTnc/qEM2P6@vger.kernel.org
X-Gm-Message-State: AOJu0YwPTct5yLKqukUtHrBnWL2sJXYfislD46VB3J3hz4Ak4IKcjzAY
	BTC/ca1/5MEWGvls0/QPCI5UJvJKyZcyga1WbFmzwqcQhNsUs3s59xGULeOV
X-Gm-Gg: ASbGncskaoTYrBShWpTSL5qoFeCiyNSJM9iG5THFy9hY7mJuMMG2L/H7EJf41X8kHSd
	edrltXFZxYJH3Rwq36P4Ks0CAQlkfZTr1hiwrj6PWktU7U4bJHwlimIOj+lvfVut9yh08WztPoK
	6uKaW/OyhmXTc8MnHGGlV+GKJKInweeLtDqse6oRbpjTQJDjd7VwNdB1gBq9aqm0KWvIFZUODFV
	vmWbxlWIZb9jrHraHC015T5ljQFY02ONb8yj2wzfNm0/wZL4/j988VBzTRb/s0SG4Hf5EnyYrDa
	cf9zcS1n+MCWt2uGPTSsY7VhU3gB4NfPI170fBJ29p4ICEQ7sYhd9xYRyNdP
X-Google-Smtp-Source: AGHT+IGWaWfGTs4mdubVYu6seZegE278kHJcKhUfM24Xyh9AmlVDo+zcwuC5LDbCC8DzofCmSPW9EQ==
X-Received: by 2002:a17:90b:2e45:b0:30a:9feb:1e0f with SMTP id 98e67ed59e1d1-30aaecdc652mr4538239a91.5.1746623993354;
        Wed, 07 May 2025 06:19:53 -0700 (PDT)
Received: from fedora.dns.podman ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22e5e93ee88sm17414765ad.86.2025.05.07.06.19.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 06:19:52 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Andrea Mayer <andrea.mayer@uniroma2.it>,
	Paolo Lungaroni <paolo.lungaroni@uniroma2.it>,
	linux-kselftest@vger.kernel.org,
	mptcp@lists.linux.dev,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCH net-next 6/6] selftests: mptcp: remove rp_filter configuration
Date: Wed,  7 May 2025 13:18:56 +0000
Message-ID: <20250507131856.78393-7-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250507131856.78393-1-liuhangbin@gmail.com>
References: <20250507131856.78393-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove the manual rp_filter configuration from MPTCP tests, as it is now
handled by setup_ns.

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 tools/testing/selftests/net/mptcp/mptcp_lib.sh | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index 99c87cd6e255..55212188871e 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -479,8 +479,6 @@ mptcp_lib_ns_init() {
 	local netns
 	for netns in "${@}"; do
 		ip netns exec "${!netns}" sysctl -q net.mptcp.enabled=1
-		ip netns exec "${!netns}" sysctl -q net.ipv4.conf.all.rp_filter=0
-		ip netns exec "${!netns}" sysctl -q net.ipv4.conf.default.rp_filter=0
 	done
 }
 
-- 
2.46.0


