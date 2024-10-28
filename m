Return-Path: <linux-kselftest+bounces-20824-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2064C9B3543
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Oct 2024 16:48:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC5611F22C17
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Oct 2024 15:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42D441DE8A9;
	Mon, 28 Oct 2024 15:48:22 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E44351DD9A6;
	Mon, 28 Oct 2024 15:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730130502; cv=none; b=HiSZ6V5ivpFhBL3LpYCa998kbH69d0oj6vJALQHYyIh+zqZRnKnIBF3+vwRFYZqfw0dZFwaGTC0NZVkQ2A3pVF+vnPN+tuiSiK7VBCYMFn0cP21/A6I7CToI5FbqewoNxla+9fim1PrfuVaApVoq6+3mzTlF8BjFy0LUVfIqfHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730130502; c=relaxed/simple;
	bh=iRMbskNOi1COk9/chyRw3Ro2vtmKl+VeKlcxOeCGirw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=asONvB8YB7VO+qPMN6uLz2tLO8NTyOU+Y7fgNTijyKiy4+iKDs+MvvhGRQ2WhcQRCfpNTdzoeIdicVTZ19GHVOyDNmzXBs4X/m6uGwhgEgnUEoKaq/ah2m/4dhReZby5NzHst68jRmy+rdEC3vpvy3lmMdQWSf96VgMikBy6rVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a9a68480164so619966466b.3;
        Mon, 28 Oct 2024 08:48:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730130498; x=1730735298;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mck4w3ufI078SKMeX83WF7cSZnSJ+nv2Om7NNhnVrpk=;
        b=tI5cipQXKt7Sml3YNuXMqPxqRBF8S7QDMZ95b3u7gU10SCz8CG0cGt0cb/PZU+UIJE
         eA69XUMCRmGSxTFyy9hvYyv/ehNErIHSnIFis8OQNVhmZKLtOym3k8hCdVx36ezWqtLh
         IsgJE2bweaZBnw4OhWBTc/gxk/Dr3EsatlisrN14DxIihtty+m6npkc5J8+2HxV/2ZAB
         wMIkPsr0onW56Z4WOr4Rxux9uo8tUerjCKxKXCprTyLUfJVsd6aUFCfx0uSnVc7DOyIy
         YK/SFPcMBWdNDHiioUpxS6pi7yrmVYw4Sdo2Ls0RrzTOq0rJdO1GkgIa6CcoHZs6pn+Q
         Rgmg==
X-Forwarded-Encrypted: i=1; AJvYcCW1BGve53HkUwrVqbvWcyorfHvEOPcJZ8C2r8GRbpRDOqnpHopsDkUDEiL25kHxij+3bgyQtuEV@vger.kernel.org, AJvYcCWe0PPQ71L9BAYFmN7wN3yvnyz2i9JBql5rUIyQ2aizb3FXdhqgnQ2xVOTZHdAGeZC1gGGtTlqmtyJpV8Y=@vger.kernel.org, AJvYcCXyN7gEx/9bS1X/tltorx/eYY+XDqykmTcPtvAkn0ArpA4VvxMHhLpi5DscTGD+ZmRJj8qVJ2yc7QHlWOg5bL1n@vger.kernel.org
X-Gm-Message-State: AOJu0YzY+eQmuh50Vu0Zjwi1seDT6Nj14X00msGwprnNdsQvonmo/66N
	iW9HOTHeZlImJchzhP3OQu0xErnhmNABqOHjgidFEijIBNA3hA6n
X-Google-Smtp-Source: AGHT+IF9agDdl0/P9I2Zf1bDBpMBM95RnAdE2sUsJ51gnEaVaQWprEyEfmAsqxf4tSFGoUPmTqRhjg==
X-Received: by 2002:a17:907:6eac:b0:a9a:7f91:8c76 with SMTP id a640c23a62f3a-a9de5a3e0ebmr973835466b.0.1730130497908;
        Mon, 28 Oct 2024 08:48:17 -0700 (PDT)
Received: from localhost (fwdproxy-lla-004.fbsv.net. [2a03:2880:30ff:4::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9b30d6fefesm384648166b.165.2024.10.28.08.48.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 08:48:17 -0700 (PDT)
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
Subject: [PATCH net-next 2/2] net: netconsole: selftests: Add userdata validation
Date: Mon, 28 Oct 2024 08:48:04 -0700
Message-ID: <20241028154805.1394611-2-leitao@debian.org>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241028154805.1394611-1-leitao@debian.org>
References: <20241028154805.1394611-1-leitao@debian.org>
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
index 4ad1e216c6b0..d182dcc2a10b 100755
--- a/tools/testing/selftests/drivers/net/netcons_basic.sh
+++ b/tools/testing/selftests/drivers/net/netcons_basic.sh
@@ -26,10 +26,13 @@ DSTIP=192.168.2.2
 
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


