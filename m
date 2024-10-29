Return-Path: <linux-kselftest+bounces-20914-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A5909B452D
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 10:03:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E9D2281E81
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 09:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21EB020492F;
	Tue, 29 Oct 2024 09:02:49 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99212040A1;
	Tue, 29 Oct 2024 09:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730192569; cv=none; b=X/hJErnByqUNsV1wgJuNt4Z9lYLlC1fvzJgbuaUSV//JiexINqW8hoZzU1SUHtYsWHQqfU+9Gq1/4xYKi0VmuiiPkT7mpw1OquX+8DBUUinyIdkMJ12G5G9o/483DtoeLPqkkXFv9cNdzyZjblhbcxAYHNtydhPpwlo6Jh55uMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730192569; c=relaxed/simple;
	bh=Ub3JOupuqWjUk3HULuyE8gnjOQk5DyjDLzJSHSx0fE8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nz2Ed70vkLNsiWl2IKnfLdtrtBngP2b84SKjQnaggJdSDBFiXhnBJQ2mD6X9w5XuSFvgTtQKNwiUAnb/RqzMPDdiz7WT52qEUa0SUrhfw7m1CkM2UNOwwiKG5neVQiGuec79/MNZBNfc1f0vWFbJDpEJkcJ/Fe0U2z41scTzkzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a9a2209bd7fso784124066b.2;
        Tue, 29 Oct 2024 02:02:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730192565; x=1730797365;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h8KmgzHmXCIHO7IwqRFHxFBLUuOqlLnQ0ZWza/gvri4=;
        b=XrHoWHRepwIFbqYjJf021Qc33f86n3rTgXiDtYJP43jD2kRiueJSCofnrmNv+ZHdrh
         YRCs6BANZ0T5GPSoahcTVcj9dRqUYxPAYGC9dmgwbaevV4/fbANCxtfXKDjK0Sjn/HRm
         fRuac4Q2vROxDaLSxGVKoTvNvRGp1/p6e1Wx8pz6O6rgHant599xcmkZbqRx8PjIoxZX
         HkwqDGnnvQzESZcjPodYHILd+vJlWpmN/0vSgsEmdX2P3ubQ+BFxbpQMx95c7rzQimdM
         rvWOz3vJrG3r2YXvGHEwLw+Ost6qO/YHl4bvTnETfhF8BXrYGy/7gp8yggm9tiQ/JVWz
         +VLw==
X-Forwarded-Encrypted: i=1; AJvYcCVHonJoIKPjFW649jSGdeyR+XFSVUvb6tab9ORqBV001LKZ1glPPKMdHe+PhAcePjTLSIxO4UTL@vger.kernel.org, AJvYcCVdWqusD0SI1Sn70fpPrViQIL0zokv5aO7zL+u/UwhZSAOmITM6ePzu0GxNzBQKc89I00nfq9DgsK2GOuU=@vger.kernel.org, AJvYcCWeDYbuYmik3mYiImeQS3C6+NtfkRrnNmvH/8z6+a3RYjT+chAg/lkozeV8xj0T1lst+CbfiGimxeBxzNn5UyKS@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8SujbfGdg3OaLQtH17YlVh190lhMr+HbCfySyf2tqWYbF+K1w
	ihjDcPWS4ms4kCtkZ+caU/uWVW6dTPylVpDBOW8xFAH6jpsvE/32
X-Google-Smtp-Source: AGHT+IHBj130d7ta9XxkPZVQVBWQz+DEK1lCUO/wu21ZFXfZAhcZjnTyshCgfiAGmW3QyD2WW4+iOA==
X-Received: by 2002:a17:907:7f0e:b0:a9a:9df:5580 with SMTP id a640c23a62f3a-a9de5ce6778mr1049167266b.19.1730192564557;
        Tue, 29 Oct 2024 02:02:44 -0700 (PDT)
Received: from localhost (fwdproxy-lla-007.fbsv.net. [2a03:2880:30ff:7::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9b1f029537sm451502966b.52.2024.10.29.02.02.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 02:02:43 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: kuba@kernel.org,
	horms@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	matttbe@kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Shuah Khan <shuah@kernel.org>
Cc: thepacketgeek@gmail.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	davej@codemonkey.org.uk,
	vlad.wing@gmail.com,
	max@kutsevol.com,
	kernel-team@meta.com,
	aehkn@xenhub.one,
	linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK)
Subject: [PATCH net-next v2 2/2] net: netconsole: selftests: Add userdata validation
Date: Tue, 29 Oct 2024 02:00:29 -0700
Message-ID: <20241029090030.1793551-3-leitao@debian.org>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241029090030.1793551-1-leitao@debian.org>
References: <20241029090030.1793551-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend netcons_basic selftest to verify the userdata functionality by:
 1. Creating a test key in the userdata configfs directory
 2. Writing a known value to the key
 3. Validating the key-value pair appears in the captured network output

This ensures the userdata feature is properly tested during selftests.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 .../selftests/drivers/net/netcons_basic.sh    | 29 +++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/tools/testing/selftests/drivers/net/netcons_basic.sh b/tools/testing/selftests/drivers/net/netcons_basic.sh
index 8d28e5189e91..182eb1a97e59 100755
--- a/tools/testing/selftests/drivers/net/netcons_basic.sh
+++ b/tools/testing/selftests/drivers/net/netcons_basic.sh
@@ -26,10 +26,13 @@ DSTIP=192.0.2.2
 
 PORT="6666"
 MSG="netconsole selftest"
+USERDATA_KEY="key"
+USERDATA_VALUE="value"
 TARGET=$(mktemp -u netcons_XXXXX)
 DEFAULT_PRINTK_VALUES=$(cat /proc/sys/kernel/printk)
 NETCONS_CONFIGFS="/sys/kernel/config/netconsole"
 NETCONS_PATH="${NETCONS_CONFIGFS}"/"${TARGET}"
+KEY_PATH="${NETCONS_PATH}/userdata/${USERDATA_KEY}"
 # NAMESPACE will be populated by setup_ns with a random value
 NAMESPACE=""
 
@@ -122,6 +125,8 @@ function cleanup() {
 
 	# delete netconsole dynamic reconfiguration
 	echo 0 > "${NETCONS_PATH}"/enabled
+	# Remove key
+	rmdir "${KEY_PATH}"
 	# Remove the configfs entry
 	rmdir "${NETCONS_PATH}"
 
@@ -136,6 +141,18 @@ function cleanup() {
 	echo "${DEFAULT_PRINTK_VALUES}" > /proc/sys/kernel/printk
 }
 
+function set_user_data() {
+	if [[ ! -d "${NETCONS_PATH}""/userdata" ]]
+	then
+		echo "Userdata path not available in ${NETCONS_PATH}/userdata"
+		exit "${ksft_skip}"
+	fi
+
+	mkdir -p "${KEY_PATH}"
+	VALUE_PATH="${KEY_PATH}""/value"
+	echo "${USERDATA_VALUE}" > "${VALUE_PATH}"
+}
+
 function listen_port_and_save_to() {
 	local OUTPUT=${1}
 	# Just wait for 2 seconds
@@ -146,6 +163,10 @@ function listen_port_and_save_to() {
 function validate_result() {
 	local TMPFILENAME="$1"
 
+	# TMPFILENAME will contain something like:
+	# 6.11.1-0_fbk0_rc13_509_g30d75cea12f7,13,1822,115075213798,-;netconsole selftest: netcons_gtJHM
+	#  key=value
+
 	# Check if the file exists
 	if [ ! -f "$TMPFILENAME" ]; then
 		echo "FAIL: File was not generated." >&2
@@ -158,6 +179,12 @@ function validate_result() {
 		exit "${ksft_fail}"
 	fi
 
+	if ! grep -q "${USERDATA_KEY}=${USERDATA_VALUE}" "${TMPFILENAME}"; then
+		echo "FAIL: ${USERDATA_KEY}=${USERDATA_VALUE} not found in ${TMPFILENAME}" >&2
+		cat "${TMPFILENAME}" >&2
+		exit "${ksft_fail}"
+	fi
+
 	# Delete the file once it is validated, otherwise keep it
 	# for debugging purposes
 	rm "${TMPFILENAME}"
@@ -220,6 +247,8 @@ trap cleanup EXIT
 set_network
 # Create a dynamic target for netconsole
 create_dynamic_target
+# Set userdata "key" with the "value" value
+set_user_data
 # Listed for netconsole port inside the namespace and destination interface
 listen_port_and_save_to "${OUTPUT_FILE}" &
 # Wait for socat to start and listen to the port.
-- 
2.43.5


