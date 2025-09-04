Return-Path: <linux-kselftest+bounces-40800-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 721D5B444EE
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Sep 2025 20:01:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04BF63BAD41
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Sep 2025 18:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6896E341AB6;
	Thu,  4 Sep 2025 18:00:59 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 758DD1A9F90;
	Thu,  4 Sep 2025 18:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757008859; cv=none; b=rUaGzYdH6FPswkI+blUu2orVgNqwyGIq1W7XH65qyKfd+z/COMUhN4GMoZW24U0gzXgwc+fwTAVCBk1n5Ik91sO5hT6xvPprhe3mGmUq747PSiJAe5t6cchK+jARekUE4Z9urhmBUOuqMEv8qkYL93giqMIpIT/X8UCcFUveKRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757008859; c=relaxed/simple;
	bh=EWRGVYbzjKHznInjRONuXtYIkysZPWgAaf+XG+yvXcU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MnxMflV/tHQTmL4xnxpSqS8Z65ToErzYUDS3sVFlXZ8aW09uwygzkgKRNn1m8dsjZ9IY98UgUTVyBNAn6WJ8YpWQbGJ7q29Nq/vnwl2Czll/rOVpYmZjHiOWjfKCnirShcwXHW8SWxuCIjnKddRAglJBGOSRCwdsLpLXDOOohAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b00a9989633so235392266b.0;
        Thu, 04 Sep 2025 11:00:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757008856; x=1757613656;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=459waJuUGWapraaUHEaPCUC2CtqoaRCHyhregbFJ7zg=;
        b=FXMEqIRx8H6Xrue9S/EAr6h/ShVidK8W5YLmnoGAhI9y5JQgIPsoEWYKAQUFgolbJx
         GTChb2gsT3LrOIoJvMwm3F3DH9tMMCzPlzpwlM/NrXG5dk6WIDfDajD5iBjgvoCcPwPU
         UIYg8x9v4IRjqjNX+fPC68zgzjVp4c8M93TNywybihy2yAf3i3sZbWrhn2d/7Qq/ghZU
         SapmNc/4aYWQCad3Y7Ex76vDG9AD2LSFTmSQvB5IWXGfik7q2tIHpOt1ozwORMnBLs84
         rzDYdU6lLsJ/2XYBtF1C8mHWTjOshdsjUSJLnNnbcgfAYDO33qfrfAeyN3WGaZAidlAy
         ejNg==
X-Forwarded-Encrypted: i=1; AJvYcCUD41aIpVEKGE2ygqaj7Oy6IH6qOGsCQLp0Tzx4+aip3aspEvPT2Xbfjr1h4vbQ99N7/QgVUTFE@vger.kernel.org, AJvYcCV4zZS2tgHnfVJcpc8q0fSv7dQWVJeTv2EGlQoDvCo8yeKY3Fun/zpn1UH15IUKGlulZq9HlH0xOY5oyR2d3PI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4D6YMMVAJ5qOdI6c9PhF8O3Ias3Ei8suVON2dm9f83fPuwozu
	jxdPmW2P/KyhP+o3tRBDlXOLIhcsm1EMNLnAVfzI1bD1ubD/wP5xjeA0
X-Gm-Gg: ASbGnctxd5IfZvuDJ4xJ9xR+r2Mh4Nn9i9JF4DrsxH+s9qFF6hJmVDug0uI/gv2lqmt
	RLCkFS5MYcD+qHfSPmaST4xrMn082vhE4feuWOJHIE41mjcXhI6ZaiBPpVqUstTBwZkIAPHjdGH
	Z2H6PVCe4rA6h3eN/sppbmUzAaB2DxZg/O6ZesQEE8KiEZkEo4IhOuiPHDDJMYC/YUax3Fo7VB1
	i9hNWjFVt7B1rul1A/iaryXY3AQbBMCvUNZYbpURbiZR3n3pSUquGivJIROp/9r8DdObEFB6f+R
	c+Ew7ZK4R5h497CI/nzJAm2NAV1mJ2Owtn7JhHDFbQC7ujqphoicFVOL60sYRke7EPKYeenpybf
	Uvka3mnUdHX99BxhnoXYozOVTVtvDkw8Kpw==
X-Google-Smtp-Source: AGHT+IFG96x9+hmd3HCFTPQlZzkUtuhxREt1yTfU/jsOZTgQ9ijbuZZE98ghypqaQRZPSkxLsYVs3A==
X-Received: by 2002:a17:907:7e93:b0:afd:d62f:aa4a with SMTP id a640c23a62f3a-b04930b436dmr59750666b.9.1757008855551;
        Thu, 04 Sep 2025 11:00:55 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:9::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b04110b94cbsm1257139366b.93.2025.09.04.11.00.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 11:00:55 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Thu, 04 Sep 2025 11:00:40 -0700
Subject: [PATCH net-next v2 1/2] selftest: netcons: refactor target
 creation
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250904-netconsole_torture-v2-1-5775ed5dc366@debian.org>
References: <20250904-netconsole_torture-v2-0-5775ed5dc366@debian.org>
In-Reply-To: <20250904-netconsole_torture-v2-0-5775ed5dc366@debian.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, asantostc@gmail.com, efault@gmx.de, 
 calvin@wbinvd.org, kernel-team@meta.com, Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.15-dev-dd21f
X-Developer-Signature: v=1; a=openpgp-sha256; l=2432; i=leitao@debian.org;
 h=from:subject:message-id; bh=EWRGVYbzjKHznInjRONuXtYIkysZPWgAaf+XG+yvXcU=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBoudPUZZqljD5URdD+uIenEMe7tUQWpVub81qWW
 DGlxoreVk+JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaLnT1AAKCRA1o5Of/Hh3
 bZ71D/9zLH23nfh2FekoBhwVMbTnRuGnLQPAi+Ne6hv1vPzX2aVQtvYmmc0wGGgtrCWL8K10VC/
 uC8kFOwLEnuefjzyCnPRq7yjLn50hjRceEJOA855Z9m3+Ssu2PefE1A47UqJvhe/UxYblu5vLn2
 BRWRSVzZeA7bTrcMSIGshNLahcDp4Q9UOakCVZcrGbMJl/+Ff5JqBzWEXVzOhJY9T+/TvNDyh5h
 IgaHhaA8A+859kkdvRxMFUL/UlNs1hm67b8cTLg3SCr6fdAm5UYCaX15E3qlu0ZF30S/3SmNG0K
 WhIjhURrZDoU0v+r5CcrmYiec6qsez5zCZ2WMZR458i9UjsVE2g53E9xbS42B/GTQC3+DS5hDK0
 0WIEx4Yi47qMsg2NqwPoj4/v3lAru1xdRq+bMbvHI/TRyjAZmH4V+UHWaLFsK6tWua8fQmes9io
 1OHbrQ/9YOfvvxNLHRbjZZFWabhqYM9dcr0tx5Teq2RwYuys82TIQUVT06ejcCnWDUvlb0188AH
 MVbayfcfSLX5aZ0sUUSFOxGeeg662G3gijjArdcRovzVJuen0F58QEoLrgAKsJ0apI2d4Bynwh3
 3RrBMgxmoMhWgSsmRfN4p8umZwpOt9F6vKFCpjcLn61Dh7MQvhNmoXOSFd/H/sL/gWMIuY5BKE7
 Rh5pyVAZRFq+YAA==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Extract the netconsole target creation from create_dynamic_target(), by
moving it from create_dynamic_target() into a new helper function. This
enables other tests to use the creation of netconsole targets with
arbitrary parameters and no sleep.

The new helper will be utilized by forthcoming torture-type selftests
that require dynamic target management.

Signed-off-by: Breno Leitao <leitao@debian.org>
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


