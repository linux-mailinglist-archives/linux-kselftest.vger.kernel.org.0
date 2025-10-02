Return-Path: <linux-kselftest+bounces-42677-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15C27BB4522
	for <lists+linux-kselftest@lfdr.de>; Thu, 02 Oct 2025 17:27:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB68F32526C
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 Oct 2025 15:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ECD81ACEDC;
	Thu,  2 Oct 2025 15:26:45 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65FC41C84BD
	for <linux-kselftest@vger.kernel.org>; Thu,  2 Oct 2025 15:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759418805; cv=none; b=uLvOCyyOj/ddK0ucqC4FeqQzlTNy+V+VC0AdjCs9qLca9saqbAGC4BVrRlo2Pj0Rr+s480eYi1BO0r9kRZuJb4P39uoACzlhaUM8M54G9dIicOJnFByriCa+XZxWe++4ZqwtPZTgU2bYoo4duYpeuPKJAplN7Go2CWQDz5TnNqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759418805; c=relaxed/simple;
	bh=Z86lLnI5Tm3fzb69918VDPeWt3usJ2k/s66dsD2rV1E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=B2UNQSbEx69pk7Te2sRq8WacD6F2QAcCgef6SnSu+E7hS/eyL5e54MAuQQMtp+lJ2XDcT1tC/rlRAdm8RXU/AAs/VDcGv7wn0CcMpxfXZLTw0HpwV3C6H7Il0wpS0ghBhpBVDvQQjo0QQ7cgv6tj0d8W1sbMSKNYLLcVWZy47YM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-63163a6556bso2472837a12.1
        for <linux-kselftest@vger.kernel.org>; Thu, 02 Oct 2025 08:26:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759418801; x=1760023601;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fV7gueGwrkVggKjpKT46wk+Vba2utbQt9f8Z8d2dnHs=;
        b=vt3aIayNRUKrQs9Mn5JgG8a7cFrs+YMP6Thl078YFNs2BTCMoi0ImYNSUlMlFD0kX9
         Gq1Ouec0QpsE4XW1y5gl4B9qyqLPmECZjqvMp8SESl0lkiu/Jnr6wMnYKKNBL8Fuav3V
         hSf0VuY/VwoAKYNYMMb09o8I6o8Yiy/bCNqHLHvgPt/i4MD6DJEcSnYxlYx++keI3XWM
         JLm68HAJ3OezUC5jgmIcLVs9BUbBWBxk0LcR+BN3lh9YIHVyPfcA2OxK3sR6spmqco22
         7McSqL8GB5wOlMeMT4lNCUxPeM/vNW2XiP8XX2s6r+S0lrkYoSE/6d3hgY8pG4jQtMJH
         VTLg==
X-Forwarded-Encrypted: i=1; AJvYcCVy/tvhZWgCYv0AQWIT9svifyv5ID2QGi8SoO8j42RsSnLpaO9wr0F+mPgkBWENh6veh+zYgNOTRusDrEjakwM=@vger.kernel.org
X-Gm-Message-State: AOJu0YywDb8/d6A4OxKKsDeyLaocE2AkNglXWdkgeqL/kDIBWmFpQDsu
	cqJUAcuFmkKbSRkxHkC50jbiDWEbg9iPBFKqGPXUC9OJE/Pomhv4cbss
X-Gm-Gg: ASbGncsxBNLvMsVa74Ol91oSpM/6ZMfoOLcj6O79Ot1kV+FWskgB0s6MMj5AD3DrVWa
	8H7mo6ByIAGUAA+5IlnwApIyGnfLKj8lHqD08TR+RvUOpMgEAkAeSbiAi3OGbsZGBBdXjGPlpn0
	pWYuxqjFFNJG2IQwuZMtQ5XkQNiL5fZILtmrTeNgBPdTzxYyEBoagjpD4rBLe/87s7SAgaT2uPJ
	6zxn8NDmMvqgJtKZ/WzlPrIIZOL4i6hezyfm1paXfFVx7N2GvM05Sgkt5Xa7QcIhULwjrmgRXPn
	ZFTHIb/hmnmqWPA3I6fSmM2ZtsA6ph8uxfCJBs/0FtjcN2SfEDgTkgqn8NR43uLLKNkeeeVnGAN
	AVaGd84FcLP0zZEDoapydcj6Ns2pijxMZgkHp0w==
X-Google-Smtp-Source: AGHT+IHu4WE80t/90uYDNyDhdDM+IRvgxuoF7rHrcmkwwOikdOlCR5zfrTQPjaAV6zMrz5FIvlZlJA==
X-Received: by 2002:a17:907:728e:b0:b3d:73e1:d809 with SMTP id a640c23a62f3a-b46ea414aefmr989484766b.48.1759418800558;
        Thu, 02 Oct 2025 08:26:40 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:73::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b4869c4e613sm217854966b.81.2025.10.02.08.26.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 08:26:40 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Thu, 02 Oct 2025 08:26:26 -0700
Subject: [PATCH net v6 2/4] selftest: netcons: refactor target creation
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251002-netconsole_torture-v6-2-543bf52f6b46@debian.org>
References: <20251002-netconsole_torture-v6-0-543bf52f6b46@debian.org>
In-Reply-To: <20251002-netconsole_torture-v6-0-543bf52f6b46@debian.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>, 
 david decotigny <decot@googlers.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, asantostc@gmail.com, efault@gmx.de, 
 calvin@wbinvd.org, kernel-team@meta.com, calvin@wbinvd.org, 
 jv@jvosburgh.net, Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.15-dev-dd21f
X-Developer-Signature: v=1; a=openpgp-sha256; l=2493; i=leitao@debian.org;
 h=from:subject:message-id; bh=Z86lLnI5Tm3fzb69918VDPeWt3usJ2k/s66dsD2rV1E=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBo3pmspZB8YD2VU7zArjltNHoR3Lv5JL4ulcLK/
 0QwucYTe+CJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaN6ZrAAKCRA1o5Of/Hh3
 bQu3EACLUz67wGRPN9BfvCvd4welZkaPX5R64wU0e0JPLIx8IybZT4DThQgjZo+SHbCPnOyyPev
 ci4ZZlxLvQY4DX3zszY5Hj9mgzp87uLLiP3U76hnN8sKyVemm4b/JOmIxlYBkHmRzBozg/3BIdf
 M/zs9uXms2MrN5+lkmoN9+d6hyA/fmULTbHc2nH3ZRI2VJsembz116cS2ncRS1Df00uSRZrvt0d
 XCrlOLp/Rj3oUD8wDWzBE6ou7D8RLTS5TKLlZh+GxiRiBnUk4ycTfVu7tenhr/16hseDacUDnr8
 +eyro2kmx3Ipi5gdesBRat4P7xzhiIuIkNYvNPUc0bnUiD75e2XSdBOk9kNofP4i1oisZcU8pMX
 QaQVX0mVWr4URMEkJTgOSU6it8h2vsVmQCZgKdnJAHZ5s293JNNuzjGHXuLsmvg5mJDRP/lp2jQ
 rmSrW4caPmcJpPSFFTBkkKF/1dFHCfBx5gX3Z/9Dvv/xdGJx/kB1CBLG+JfQybzTuKzZom7g2xV
 UjxMbgw9yk/XNOKu+02TMxwBhdZeQwEgf5xefelb5sMfUAE/0dQUUE6SoL+LgDLxZuAfkGerS7i
 +xnCrjc34r35cViwnYkLXkMwz7VhF82gBaoTm+n6I8zi+pakdwjeBX+lACJc+LFmVMxMP3DNmci
 1+VcNwkEQj2XmLw==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Extract the netconsole target creation from create_dynamic_target(), by
moving it from create_dynamic_target() into a new helper function. This
enables other tests to use the creation of netconsole targets with
arbitrary parameters and no sleep.

The new helper will be utilized by forthcoming torture-type selftests
that require dynamic target management.

Signed-off-by: Breno Leitao <leitao@debian.org>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh | 30 +++++++++++++++++++-----------
 1 file changed, 19 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh b/tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh
index 8e1085e896472..9b5ef8074440c 100644
--- a/tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh
+++ b/tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh
@@ -113,31 +113,39 @@ function set_network() {
 	configure_ip
 }
 
-function create_dynamic_target() {
-	local FORMAT=${1:-"extended"}
+function _create_dynamic_target() {
+	local FORMAT="${1:?FORMAT parameter required}"
+	local NCPATH="${2:?NCPATH parameter required}"
 
 	DSTMAC=$(ip netns exec "${NAMESPACE}" \
 		 ip link show "${DSTIF}" | awk '/ether/ {print $2}')
 
 	# Create a dynamic target
-	mkdir "${NETCONS_PATH}"
+	mkdir "${NCPATH}"
 
-	echo "${DSTIP}" > "${NETCONS_PATH}"/remote_ip
-	echo "${SRCIP}" > "${NETCONS_PATH}"/local_ip
-	echo "${DSTMAC}" > "${NETCONS_PATH}"/remote_mac
-	echo "${SRCIF}" > "${NETCONS_PATH}"/dev_name
+	echo "${DSTIP}" > "${NCPATH}"/remote_ip
+	echo "${SRCIP}" > "${NCPATH}"/local_ip
+	echo "${DSTMAC}" > "${NCPATH}"/remote_mac
+	echo "${SRCIF}" > "${NCPATH}"/dev_name
 
 	if [ "${FORMAT}" == "basic" ]
 	then
 		# Basic target does not support release
-		echo 0 > "${NETCONS_PATH}"/release
-		echo 0 > "${NETCONS_PATH}"/extended
+		echo 0 > "${NCPATH}"/release
+		echo 0 > "${NCPATH}"/extended
 	elif [ "${FORMAT}" == "extended" ]
 	then
-		echo 1 > "${NETCONS_PATH}"/extended
+		echo 1 > "${NCPATH}"/extended
 	fi
 
-	echo 1 > "${NETCONS_PATH}"/enabled
+	echo 1 > "${NCPATH}"/enabled
+
+}
+
+function create_dynamic_target() {
+	local FORMAT=${1:-"extended"}
+	local NCPATH=${2:-"$NETCONS_PATH"}
+	_create_dynamic_target "${FORMAT}" "${NCPATH}"
 
 	# This will make sure that the kernel was able to
 	# load the netconsole driver configuration. The console message

-- 
2.47.3


