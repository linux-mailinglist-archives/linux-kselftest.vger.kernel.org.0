Return-Path: <linux-kselftest+bounces-20679-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8412E9B0973
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Oct 2024 18:14:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B617A1C22DF2
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Oct 2024 16:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FC4518870D;
	Fri, 25 Oct 2024 16:14:36 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEDE17082B;
	Fri, 25 Oct 2024 16:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729872876; cv=none; b=q/tdXG6BFai0myho7Pbu3TCcJ7/pqc6uMjxXA6nImxsP5bIw/rSEeVeV9vbEdJszke6Mipr4khSxIELR107UsVEN6Af2p5eKtNcgRcQRot8S8MsVhprvhiUN62wy70ZLIEuw4x+e9QzgusptlVtk+UGrevme/fWuOT8xQW1z5CE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729872876; c=relaxed/simple;
	bh=iRMbskNOi1COk9/chyRw3Ro2vtmKl+VeKlcxOeCGirw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eWkILdKerdtdHN27+E1UsRoX5Qyla5UQpGn5mU7v4+Um4vg5ojqubqxJZK+3OKJfAkuD98XKDVbRgyBIQ+G7qpNRVbSPRxPhevalplhgIdehTSJm7S25rCV6wLo3iRdLdD//fN96xtvlRKfm6geHzt35t7HiRlzCMvEufA7Q/kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a9a156513a1so324918566b.0;
        Fri, 25 Oct 2024 09:14:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729872872; x=1730477672;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mck4w3ufI078SKMeX83WF7cSZnSJ+nv2Om7NNhnVrpk=;
        b=XJgUPcH4TB8sPgyRYfLXKYOPwjoSNfpkmF8VH0Ot6M2hUkfPVELcpgmgqprkyfHvjP
         DaFzA8FY4NieSMIRdAxkUTYCzuR6r4i9l6rxTWBkOhnNUi5OZ5xJLm19yXDolhie6y9O
         mtkRK3bkEnv+dT6fj6fu599S3Q2ZtZHSMtzH+v1JE+CTiUBXUqoztuU3pdivgDG6uls9
         MsE22eUmqmdIkKKqlbeR2ctLSYoe3MsU7L+EccmtuTv5wsMu/QCicvBEto2WIeJG8Spd
         vtCHWPkpv0aDTICVOg2307+BGeEvwHltcVDF3URzL/HgrHp/tCYgRlWlfyeNFu28P9Dr
         59gQ==
X-Forwarded-Encrypted: i=1; AJvYcCUe2mtskcZrAUpcmIo4xyUCFZv0bVuAI1w/+6Es/Q+9mtgCOu5vrZH6IRtcJJnmpt+MRhSYhmXxyNcdp7peOAna@vger.kernel.org, AJvYcCV/px/iBpdrF+gBIPhAj4L8aX7UksLzAqjDALCawE2Cc946FeSS2f2m9fb/PJ8/vyDC9HygDEK8@vger.kernel.org, AJvYcCXvFpAdp5wwWJnF6RlO/X6z3xyuJv5I7H3ewnPrPK+Omdrx1FlieywldbioJ98wvSOwrXelpMD0cjsDL7Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIsKrNS5mbDVpJV0ot3OTkGpHZ/dRHSpl7zJTBNlxWv+wnsWwj
	0sXjdaFOoTJgKVuumo3njwcl78yaBY/L2Mo7mRYhRSiVi0qLanEU
X-Google-Smtp-Source: AGHT+IE9wvNdJoZ1wRErVgzp/oeZPvFb/8mAxNhzhoaQkWN3SgsihpQE4oSqzeuHnBY2hgMpTI0hUg==
X-Received: by 2002:a17:907:9452:b0:a99:60c8:f2c4 with SMTP id a640c23a62f3a-a9ad2730bc2mr522796066b.15.1729872872050;
        Fri, 25 Oct 2024 09:14:32 -0700 (PDT)
Received: from localhost (fwdproxy-lla-112.fbsv.net. [2a03:2880:30ff:70::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9b1dec773fsm87395566b.18.2024.10.25.09.14.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 09:14:31 -0700 (PDT)
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
Date: Fri, 25 Oct 2024 09:14:14 -0700
Message-ID: <20241025161415.238215-2-leitao@debian.org>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241025161415.238215-1-leitao@debian.org>
References: <20241025161415.238215-1-leitao@debian.org>
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


