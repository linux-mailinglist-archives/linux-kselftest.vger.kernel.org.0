Return-Path: <linux-kselftest+bounces-41677-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7829CB7EBD6
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Sep 2025 14:58:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEBF95255D8
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Sep 2025 12:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60ED337C0F1;
	Wed, 17 Sep 2025 12:52:21 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29790328992
	for <linux-kselftest@vger.kernel.org>; Wed, 17 Sep 2025 12:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758113541; cv=none; b=HYxE9dKaL060kYfDezB0z8rbI3A+IOQQj0H6DIV7VbM8b6gQWO/XZd74pE4eyzP9Po0VGZD5B/KV868z4CBlUpxSEzCEJAccT+uwB2dJsIwmDuM5PJBdtWD6oFq+fJzHIz7ygKHExCE4seA3C31Ey+lpj52TFOh2QC6juwku3+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758113541; c=relaxed/simple;
	bh=g8Rymja0V72nq6OnDIyWQadzgQlOQaCKBNDvE6hktyo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lFCRWf2dhBLKrYsHzE7vFEKBzB5Yn0UwaYWia7NNCxFCRxpajssKQTLxxJK9o8o8kjQQn7t+f39EgoasKltlEtyHDqeMg2SHb+bRYcG+GguSSkKdktkpCKp7IDeygl9PzlWTlqUAQDtHkH+nLf09uWz8MleIBrEWuBztnNcnnBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-62f1987d547so4784152a12.2
        for <linux-kselftest@vger.kernel.org>; Wed, 17 Sep 2025 05:52:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758113536; x=1758718336;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hnf8G2/o1fozlbYtBL0vduYZr+SYz2Fp67m1oGmqTd0=;
        b=ghTmCO8MqjCpZlIDugcjRlneT2ouzx1RRzOHDzT/PmIHsLdR9axyMpPtD1Teu0Kw42
         W0wGP9FxVFXOWv04RYPGlQhlBfQhpAcKVWZ5hujBb7zK5MSIXjrqGp64IICmQXI+R+VZ
         W5uLB2ZCAwkSI5+BApysKa7ILQkFLwEPI5E9dJuk2/tObhLAE525bP9PTYeBteQj/TYp
         OyMZEhvmEaccJO4Hc6sL447gPX2yrE2tBm8sN8F53HrF/purSS0TSyUnkJFQcslk2nJO
         O3T0Kzvu3uEFD0pxtlXOo4O/FlhrQUZW/pSWAZP+WDh/5Jkly8hlXg6iNAY90fc0H4Bq
         XU1Q==
X-Forwarded-Encrypted: i=1; AJvYcCXDguIkgavKNr2dmw8cUCoEYwDluEfvg9EBA3tjRtTIOM+2OBKd1ja2GH/82diXRK3Dh2kjNgibrAawBTv+UUo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzK8v16avnJlMAVKJRcrVGREnzdzFWVFoUa6SoTG4lk06Dh25aK
	Gs2Pol6lkTk8wPIsZ+yzIqM5adcQpmn34C1hp0F2KZs0xjigJJQnleYO
X-Gm-Gg: ASbGncvI7ptoeU/9/HtNMLh43ftnHKoYkzNZkhH8CklXFiFZu/zBSOE6CI7tO07igyd
	26jWf9CbXs2UmXL0WPQexBJEZrsnsEhgHN7XQgQ6wBB1jvsyiDp449RMZM0hO+dETsXIOZUodcg
	yzTWg/wHzwA3Kj/pJiZWQhzjM/0zD/anxfc0eh+Ldf7yu37kDdrx7wTQZtJ0MMG0Vf4rr/b3UkD
	HhkKExPKuLxWS/Hx0yOQFOyqbfBAAsKh/1kAz8k10MMNut9XZbm/S16R9tzwq0uD/O1XrVjWQPI
	BBJ3cfjvEtqrzqmj7Cw3BqxdZMA8XvJ8H19QhuVsj3v/H5wPxPRwCFPQkaxgys78HKL5pavNa9D
	nGlZL3E+I5fvt
X-Google-Smtp-Source: AGHT+IHhku+j1T36cuiJ0d0xS73leySID7J8LR0tE9XWMEffbke5MNL3JEXPU6e9cXah2ZqkPOnqwg==
X-Received: by 2002:a05:6402:440b:b0:62f:4040:bf70 with SMTP id 4fb4d7f45d1cf-62f844623abmr2323884a12.24.1758113536187;
        Wed, 17 Sep 2025 05:52:16 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:7::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-62ec33ae181sm13708626a12.22.2025.09.17.05.52.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 05:52:15 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Wed, 17 Sep 2025 05:51:43 -0700
Subject: [PATCH net v4 2/4] selftest: netcons: refactor target creation
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250917-netconsole_torture-v4-2-0a5b3b8f81ce@debian.org>
References: <20250917-netconsole_torture-v4-0-0a5b3b8f81ce@debian.org>
In-Reply-To: <20250917-netconsole_torture-v4-0-0a5b3b8f81ce@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2478; i=leitao@debian.org;
 h=from:subject:message-id; bh=g8Rymja0V72nq6OnDIyWQadzgQlOQaCKBNDvE6hktyo=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBoyq77IMhtUQqCc1NMy3UCs+bE/0aGxgsG0YiA8
 DmMgqxfUzOJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaMqu+wAKCRA1o5Of/Hh3
 bRoYEACuWR2zXSe2VYyFo8PEEJn1uxZuK7cjyF2DM6sRI2XkJ9D2Q3fkIJwoh3eyBqL/1JBFxfB
 dmC0MO3m/91VTRaZlsz/0V4wtxbZa4jIp1H5KqUJzyYJM3i8V6Nfl7P4y2mT0OZl5uljSS4nS4K
 iC1/fK0DFD8CAuCITL/t5CVb1cLNRgCvDtD7r+zqi5KbS8LedlR1a3YfrEWc+xFXPmsWs07H+6p
 kf7/Du8ZyUNSxdJVmi6jCEpFBFi+8fEwQZZvgaDjuinbCgyFcpVpWvgxkWZ9a0yTgvd/PzINR31
 T6U8Ohqb3iAr6kMNg3DhY21ilX4kr9DP0e5H4n18Swg4zHNEz546ZG0U8Aecv5vnjrs6PzFcwNg
 0TfRSuPok/492DnJlhjR9O8NO8k5RQEion/wMJLkB33bY4Ea86TNfEGRqlld7K4LS1RKlt2E61v
 yDLP3iKGake9vzG9FDVUR3MzW+MiWlv6UmqJ5ysUv9bV0tGqTnDsusSVRn+7mJltwDjuI6ApIzu
 ZLGAgtEI1rCmxVpABdLerok/V7c/7Gy2y9pryuhG3Vwtf9PxtieNB7Kb0DZRfaKNcLmuk55enF4
 S9PDa0/5Rg8HXEXMUigcm/HrJOPPoQvMMDYOUoEhxpYeeIGSGKQ/RNMmikDPVLnCl1z204whjuV
 K/ONcQy8cr40z+g==
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
 .../selftests/drivers/net/lib/sh/lib_netcons.sh    | 30 ++++++++++++++--------
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


