Return-Path: <linux-kselftest+bounces-34459-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 450BEAD1AF1
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Jun 2025 11:47:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEE4F188D6DA
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Jun 2025 09:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B664254858;
	Mon,  9 Jun 2025 09:46:44 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CFAF25229E;
	Mon,  9 Jun 2025 09:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749462404; cv=none; b=F6LFEAsDhSf+yA8VNqW5PUf8ZFsm3FjBT9hD4DTTWkPcWSnoFmGpTpFDWJkpBR4pIASzw3AcAZ3Nm5hTR96t8cCJlZPSwaQtGnUI4xcx8mHJhAcmkqS3OC+U/2azx4vd35oUEHirRrQBMf9jqVq7RyXkJMl1Uh9s3jW7SPigFeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749462404; c=relaxed/simple;
	bh=rK5iNrQXNmGjsm3EwSsVPBRLrssPEdm7gAva0cMhNJ0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QzfHpWM6er838GxLLa9Xat6epnLafhyc5dm21kp7rzk/byzpGT9/jowtZehC7L4SZdYAxs2XnAL4SCpVSTUz4Ade9W5Bjk16eDNzSRA2PNrxnjQddVBcTl4uEdTDwSO2ELZTswXbNHf6pSjiPpnhF7AWx5MATqWXx0yTjp91siE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-605b9488c28so6607157a12.2;
        Mon, 09 Jun 2025 02:46:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749462400; x=1750067200;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fGkA44rePRDCbPLT2KhTInQAdoee0hKuzwt/FTEhp5s=;
        b=LosZ68w8mLPJc5XBOYytpNHqwbYDpxg4nBpCSHW5KECZg81bWum6LrI2qIRf/HzYyr
         n6YodP8BvK6c4ELkZptpexCijscNyjSpZc4Gacz4C217a1fFmOuhpMcQLqVrBpvMlTHW
         kVLZ9Tc4Oq6RBDEVRFnv+04FON0/JRgCchSmrFQfLOyXk1XGkTFkwS14/Xbk8iHFNF5v
         SySzwkZkBMcFZoVJA3Cxw6HYy4kmnGwBYyPTRs9K8FBzRhpISBIybjpnUZM0VqxVRwEe
         9Y30z/dkKxKi00zVctGVBPvxedaMHaSDHuaoxxEdTKDnZ1cdEKp6mvCNDF4IRkl5qpDk
         Q7qg==
X-Forwarded-Encrypted: i=1; AJvYcCUEyTqeifxy1Vf+AaX2NGqZeTb6+zmF8oT//Wd/zvx7dtvwNDmWF+xUQHHKUXK/aEDSlxwlZIoIOfWMRNLcHEJX@vger.kernel.org, AJvYcCXosf52KVPDqm4mIDosNSUd6YK6KlFDqRxM8yMMKqOTvhVmdbam9b016EjW9/60gKxZS5l5vxeP6wV4M+I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJ2EPplhgoDvhOjh4R358Zsljb+siMAouH/Hp+O6ttyvIuU6Ov
	CCjxP9OE5ZQm90BgYKNkmgdGoU94Yv2Xvii8j9IX14ncRyuJ2OW9+t6ErpJi0Q==
X-Gm-Gg: ASbGncvfcxCPwWNZwqSjt0MMx/Fniyanahw+rBls31tsMH7rtrjDXpKOQ+qKsXsSOSx
	+lvodguw2h8rjzobQ7pqPjfX5g7C7lN250lhvaj08zm1VyD2G8rY/OH/mADYPPWauNcrU4xat3t
	aO10NfJTHcEUk8NlAKyMuvo81sFbqfNaa0bsQ9UzvzJ+1ZykJsG5p+0TXsG/9e4Pb7F8bBdsBAE
	HiQDXj7uq5I+jJXBGrzXlttg9ie9psaylVg6evCymGY5gHwIV3hgvaS4TCOHbBNCJdA8+FakW+3
	X6hbEvfne13AMKC204u2k9pZ88roqlsOBlDNFFHKHx4j26oGujsM
X-Google-Smtp-Source: AGHT+IHyJ16iuYdiFip6UzogqzRlHrpf7OsB+MxsamQLuEK8zCIB0j6nguuIZMadwangwG+iG7AqEQ==
X-Received: by 2002:a05:6402:270e:b0:5ff:ef06:1c52 with SMTP id 4fb4d7f45d1cf-6077351188amr11563906a12.3.1749462399961;
        Mon, 09 Jun 2025 02:46:39 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:7::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-607fbbdaadbsm827266a12.51.2025.06.09.02.46.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jun 2025 02:46:39 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Mon, 09 Jun 2025 02:46:29 -0700
Subject: [PATCH net-next v3 4/4] selftests: netconsole: Add support for
 basic netconsole target format
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250609-netcons_ext-v3-4-5336fa670326@debian.org>
References: <20250609-netcons_ext-v3-0-5336fa670326@debian.org>
In-Reply-To: <20250609-netcons_ext-v3-0-5336fa670326@debian.org>
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
 Shuah Khan <shuah@kernel.org>, horms@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 gustavold@gmail.com, Usama Arif <usamaarif642@gmail.com>, 
 linux-kselftest@vger.kernel.org, kernel-team@meta.com
X-Mailer: b4 0.15-dev-42535
X-Developer-Signature: v=1; a=openpgp-sha256; l=4779; i=leitao@debian.org;
 h=from:subject:message-id; bh=rK5iNrQXNmGjsm3EwSsVPBRLrssPEdm7gAva0cMhNJ0=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBoRq14ythnWisF6ATN52SMsd+pOSHdCeZoMYPH1
 UBvuRIpEneJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaEateAAKCRA1o5Of/Hh3
 baw6D/0epElbEzK78YUu8xheHZbjvP0gaaVm1Q30exRMruW5/uaGOZTMCCcwnrK7CXBLiGu5Zeo
 axKd7MHGTg5zdzqLF7pNqI0+ibrr8HqY6UG1xLcJxHDtBkXrLT+pTf/ahmEKG+zQhLaH3E4Ts1P
 /qju2DNIHfxC2o2QqtTmB7+yXHVOC2Mgtp2f46bLds0DoBd3DPnsRmo3denJdEL87a0MoieiyAo
 FPkWbIOUDngYSmkNT9AonbB8ucB2DA6fBui0FTi+QfK/2lF9E20rdNFpxNJg8Rm271sYLK3BhZg
 JFxMNjQTBnfmAufsP1svPsa6zttNpO6dTIAPnkJh2KpP7lrfd8AjlTklK3wnGmy7Bm/HhJdqhX/
 Z0VJQ/gP6nnM9ARTUvWtC7VYCdh/GbHcReTKyggjsU1gi5BPmrzdrlmx52nPWCS7DrJx+vDDUSs
 ttX71QmtLt1NV3ApcEaCKuiLykLlZ4BqQ7Dbjh7QgeIIymS53+1HdnypIrj38YV1wk8t6vIZ72E
 vV9V/i90ncEnFwBJmGSWcq+Kl8v6JosfH0MBpXFFx0eMzVCC3U00JJvlrawFtrGQS5pEmmWYgWY
 Agp5rPcTBy+7p97zu025tt0QUjPdvFo2eHRGQgkA+l30QBnf2GCiOs55yf9WeTa1DNOqxMMKp/H
 Vj3hwYX3RihMU1Q==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Extend the netconsole selftest to validate both basic and extended
target formats. The basic format is a simpler variant that doesn't
support userdata or release functionality.

The test now validates that netconsole works correctly in both
configurations, improving test coverage for different netconsole
deployment scenarios.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 .../selftests/drivers/net/lib/sh/lib_netcons.sh    | 26 ++++++++++--
 .../testing/selftests/drivers/net/netcons_basic.sh | 48 ++++++++++++++--------
 2 files changed, 52 insertions(+), 22 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh b/tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh
index 2d5dd3297693c..71a5a8b1712c0 100644
--- a/tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh
+++ b/tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh
@@ -95,6 +95,8 @@ function set_network() {
 }
 
 function create_dynamic_target() {
+	local FORMAT=${1:-"extended"}
+
 	DSTMAC=$(ip netns exec "${NAMESPACE}" \
 		 ip link show "${DSTIF}" | awk '/ether/ {print $2}')
 
@@ -106,6 +108,16 @@ function create_dynamic_target() {
 	echo "${DSTMAC}" > "${NETCONS_PATH}"/remote_mac
 	echo "${SRCIF}" > "${NETCONS_PATH}"/dev_name
 
+	if [ "${FORMAT}" == "basic" ]
+	then
+		# Basic target does not support release
+		echo 0 > "${NETCONS_PATH}"/release
+		echo 0 > "${NETCONS_PATH}"/extended
+	elif [ "${FORMAT}" == "extended" ]
+	then
+		echo 1 > "${NETCONS_PATH}"/extended
+	fi
+
 	echo 1 > "${NETCONS_PATH}"/enabled
 }
 
@@ -159,6 +171,7 @@ function listen_port_and_save_to() {
 
 function validate_result() {
 	local TMPFILENAME="$1"
+	local FORMAT=${2:-"extended"}
 
 	# TMPFILENAME will contain something like:
 	# 6.11.1-0_fbk0_rc13_509_g30d75cea12f7,13,1822,115075213798,-;netconsole selftest: netcons_gtJHM
@@ -176,10 +189,15 @@ function validate_result() {
 		exit "${ksft_fail}"
 	fi
 
-	if ! grep -q "${USERDATA_KEY}=${USERDATA_VALUE}" "${TMPFILENAME}"; then
-		echo "FAIL: ${USERDATA_KEY}=${USERDATA_VALUE} not found in ${TMPFILENAME}" >&2
-		cat "${TMPFILENAME}" >&2
-		exit "${ksft_fail}"
+	# userdata is not supported on basic format target,
+	# thus, do not validate it.
+	if [ "${FORMAT}" != "basic" ];
+	then
+		if ! grep -q "${USERDATA_KEY}=${USERDATA_VALUE}" "${TMPFILENAME}"; then
+			echo "FAIL: ${USERDATA_KEY}=${USERDATA_VALUE} not found in ${TMPFILENAME}" >&2
+			cat "${TMPFILENAME}" >&2
+			exit "${ksft_fail}"
+		fi
 	fi
 
 	# Delete the file once it is validated, otherwise keep it
diff --git a/tools/testing/selftests/drivers/net/netcons_basic.sh b/tools/testing/selftests/drivers/net/netcons_basic.sh
index d2f0685d24ba3..40a6ac6191b8b 100755
--- a/tools/testing/selftests/drivers/net/netcons_basic.sh
+++ b/tools/testing/selftests/drivers/net/netcons_basic.sh
@@ -32,23 +32,35 @@ check_for_dependencies
 echo "6 5" > /proc/sys/kernel/printk
 # Remove the namespace, interfaces and netconsole target on exit
 trap cleanup EXIT
-# Create one namespace and two interfaces
-set_network
-# Create a dynamic target for netconsole
-create_dynamic_target
-# Set userdata "key" with the "value" value
-set_user_data
-# Listed for netconsole port inside the namespace and destination interface
-listen_port_and_save_to "${OUTPUT_FILE}" &
-# Wait for socat to start and listen to the port.
-wait_local_port_listen "${NAMESPACE}" "${PORT}" udp
-# Send the message
-echo "${MSG}: ${TARGET}" > /dev/kmsg
-# Wait until socat saves the file to disk
-busywait "${BUSYWAIT_TIMEOUT}" test -s "${OUTPUT_FILE}"
-
-# Make sure the message was received in the dst part
-# and exit
-validate_result "${OUTPUT_FILE}"
 
+# Run the test twice, with different format modes
+for FORMAT in "basic" "extended"
+do
+	echo "Running with target mode: ${FORMAT}"
+	# Create one namespace and two interfaces
+	set_network
+	# Create a dynamic target for netconsole
+	create_dynamic_target "${FORMAT}"
+	# Only set userdata for extended format
+	if [ "$FORMAT" == "extended" ]
+	then
+		# Set userdata "key" with the "value" value
+		set_user_data
+	fi
+	# Listed for netconsole port inside the namespace and destination interface
+	listen_port_and_save_to "${OUTPUT_FILE}" &
+	# Wait for socat to start and listen to the port.
+	wait_local_port_listen "${NAMESPACE}" "${PORT}" udp
+	# Send the message
+	echo "${MSG}: ${TARGET}" > /dev/kmsg
+	# Wait until socat saves the file to disk
+	busywait "${BUSYWAIT_TIMEOUT}" test -s "${OUTPUT_FILE}"
+
+	# Make sure the message was received in the dst part
+	# and exit
+	validate_result "${OUTPUT_FILE}" "${FORMAT}"
+	cleanup
+done
+
+trap - EXIT
 exit "${ksft_pass}"

-- 
2.47.1


