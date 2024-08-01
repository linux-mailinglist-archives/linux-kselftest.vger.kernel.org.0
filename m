Return-Path: <linux-kselftest+bounces-14660-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE9BA945048
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Aug 2024 18:14:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 130632833DC
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Aug 2024 16:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77D5A1B4C42;
	Thu,  1 Aug 2024 16:13:55 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 900A61B372C;
	Thu,  1 Aug 2024 16:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722528835; cv=none; b=ix5dwsQWtouYddg1wPKQuJFWocoyuMgjLpA1r6VoQnm/Osi5krZ082uiXudXm3MKocZborqrHBCT+xWN9ge8CXmNSzyt4NrjCjch1FJZA+mQYJHassAndiVDyp/PVMXHGQsCNy79LU9XlAy3/fY8C5uVMqTdsAa2SSKgiWV7QVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722528835; c=relaxed/simple;
	bh=zS9pPlHOmO0BZ7xmcFWzDSiTDOZYmnzfdggcHye1Fn4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GluhVOYcbwSktBzmsiFu97kWmviX3M9iOVWPgB7eA/xTsavYN0qDysEdmRlSY3hJBKwwMs4pZ74m2UTAO+/rA2QrYrA3d6jzii1hc1ge3Io9qxca81bvyDGyEGDSIN42JLKJcQiIW+S1gsS9+qCMjqHJDWO5i2tRnK7ATwxRV30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a7ab5fc975dso651863266b.1;
        Thu, 01 Aug 2024 09:13:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722528832; x=1723133632;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5/RdmcqVIP5R/Ggm/1sHWuedrazo6kwvVFmS0MKY894=;
        b=De0rtEmbDYvER43Ki+HOQJbPU6Bm1tvYUGJbZI/n6fXwyg9+I4EY01gdhHZ/tKc5Xl
         wECfRysMdWzBy0VbGgxicdZ5FFX0+NEulxa9syzQvbXd1rtcx+64FMy+A5BIGWAnTRPy
         tDAlwGF5fJkDwHrRJFyumSe9KV8wnt50iMg6siBqesZ3q89qk2lYOI+LHj9qHcrLbMpP
         VAjP8GFyFevUQakfpKiZ5t6wTEO23X3DiVOOwikk1Sk2ZHztbOS9eqOu5kKB/IQ7b4Ym
         IUHlVmhJaVWKwNmO/ttAPUS8lCufs7bE3EKATn9hZTIuVuU/Fp8/0UIKrnSFHjA2x12K
         N8lA==
X-Forwarded-Encrypted: i=1; AJvYcCXZj4d/ZYswejlLIdt7k4wYIJJ9Fjfea47ukSZPNLs61UWEcBVSXJAkiIuLUzgV522X09QTWIzAPIY7CCcC73PsYWaovJdciYeFWk6oerf1NTQyTG8rIaUM+NwmPDjIRjeTSehKrEvReSul2FrAsKzMoFMVTqX+kTO/6wiHQUgWszl8Ix1f
X-Gm-Message-State: AOJu0Yz/zw4oh1sdAoHNRwujC2Ir3oB23xwd3X7ohecRkt0rHkRuJy0I
	oGgXCG41ewPgfMZiivsoxi03Abg6OuOyfzew0WgEoSpdOHUxTRhw
X-Google-Smtp-Source: AGHT+IG/AFrPnvzzN/amAsAUv4ipt+ECA8EtiB7HwaDCZ+4l9+dJ1jQQevf/LknK3BxjRYbQ7q3D+A==
X-Received: by 2002:a17:907:934a:b0:a7a:a5ed:43d0 with SMTP id a640c23a62f3a-a7dc5071046mr55940666b.47.1722528831525;
        Thu, 01 Aug 2024 09:13:51 -0700 (PDT)
Received: from localhost (fwdproxy-lla-005.fbsv.net. [2a03:2880:30ff:5::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acac61218sm923403266b.94.2024.08.01.09.13.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 09:13:51 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: kuba@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	Shuah Khan <shuah@kernel.org>
Cc: thevlad@fb.com,
	thepacketgeek@gmail.com,
	riel@surriel.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	paulmck@kernel.org,
	davej@codemonkey.org.uk,
	linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK)
Subject: [PATCH net-next 1/6] net: netconsole: selftests: Create a new netconsole selftest
Date: Thu,  1 Aug 2024 09:11:58 -0700
Message-ID: <20240801161213.2707132-2-leitao@debian.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801161213.2707132-1-leitao@debian.org>
References: <20240801161213.2707132-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adds a selftest that creates two virtual interfaces, assigns one to a
new namespace, and assigns IP addresses to both.

It listens on the destination interface using netcat and configures a
dynamic target on netconsole, pointing to the destination IP address.

The test then checks if the message was received properly on the
destination interface.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 MAINTAINERS                                   |   1 +
 .../net/netconsole/basic_integration_test.sh  | 153 ++++++++++++++++++
 2 files changed, 154 insertions(+)
 create mode 100755 tools/testing/selftests/net/netconsole/basic_integration_test.sh

diff --git a/MAINTAINERS b/MAINTAINERS
index c0a3d9e93689..59207365c9f5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15768,6 +15768,7 @@ M:	Breno Leitao <leitao@debian.org>
 S:	Maintained
 F:	Documentation/networking/netconsole.rst
 F:	drivers/net/netconsole.c
+F:	tools/testing/selftests/net/netconsole/
 
 NETDEVSIM
 M:	Jakub Kicinski <kuba@kernel.org>
diff --git a/tools/testing/selftests/net/netconsole/basic_integration_test.sh b/tools/testing/selftests/net/netconsole/basic_integration_test.sh
new file mode 100755
index 000000000000..fbabbc633451
--- /dev/null
+++ b/tools/testing/selftests/net/netconsole/basic_integration_test.sh
@@ -0,0 +1,153 @@
+#!/usr/bin/env bash
+# SPDX-License-Identifier: GPL-2.0
+
+# This test creates two virtual interfaces, assigns one of them (the "destination
+# interface") to a new namespace, and assigns IP addresses to both interfaces.
+#
+# It listens on the destination interface using netcat (nc) and configures a
+# dynamic target on netconsole, pointing to the destination IP address.
+#
+# Finally, it checks whether the message was received properly on the
+# destination interface.  Note that this test may pollute the kernel log buffer
+# (dmesg) and relies on dynamic configuration and namespaces being configured."
+#
+# Author: Breno Leitao <leitao@debian.org>
+
+SCRIPTDIR=$(dirname "$(readlink -e "${BASH_SOURCE[0]}")")
+
+# Simple script to test dynamic targets in netconsole
+SRCIF="veth0"
+SRCIP=192.168.1.1
+
+DSTIF="veth1"
+DSTIP=192.168.1.2
+
+PORT="6666"
+MSG="netconsole selftest"
+TARGET=$(mktemp -u netcons_XXXXX)
+NETCONS_CONFIGFS="/sys/kernel/config/netconsole"
+FULLPATH="${NETCONS_CONFIGFS}"/"${TARGET}"
+# This will be have some tmp values appened to it in set_network()
+NAMESPACE="netconsns"
+
+# Used to create and delete namespaces
+source "${SCRIPTDIR}"/../lib.sh
+
+function set_network() {
+	# this is coming from lib.sh
+	setup_ns "${NAMESPACE}"
+	NAMESPACE=${NS_LIST[0]}
+	ip link add "${SRCIF}" type veth peer name "${DSTIF}"
+
+	# "${DSTIF}"
+	ip link set "${DSTIF}" netns "${NAMESPACE}"
+	ip netns exec "${NAMESPACE}" ip addr add "${DSTIP}"/24 dev "${DSTIF}"
+	ip netns exec "${NAMESPACE}" ip link set "${DSTIF}" up
+
+	# later, configure "${SRCIF}"
+	ip addr add "${SRCIP}"/24 dev "${SRCIF}"
+	ip link set "${SRCIF}" up
+}
+
+function create_dynamic_target() {
+	DSTMAC=$(ip netns exec "${NAMESPACE}" ip link show "${DSTIF}" | awk '/ether/ {print $2}')
+
+	# Create a dynamic target
+	mkdir ${FULLPATH}
+
+	echo ${DSTIP} > ${FULLPATH}/remote_ip
+	echo ${SRCIP} > ${FULLPATH}/local_ip
+	echo ${DSTMAC} > ${FULLPATH}/remote_mac
+	echo "${SRCIF}" > ${FULLPATH}/dev_name
+
+	echo 1 > ${FULLPATH}/enabled
+}
+
+function cleanup() {
+	echo 0 > "${FULLPATH}"/enabled
+	rmdir "${FULLPATH}"
+	# This will delete DSTIF also
+	ip link del "${SRCIF}"
+	# this is coming from lib.sh
+	cleanup_all_ns
+}
+
+function listen_port() {
+	OUTPUT=${1}
+	echo "Saving content in ${OUTPUT}"
+	timeout 2 ip netns exec "${NAMESPACE}" nc -u -l "${PORT}" | sed '/^$/q' > ${OUTPUT}
+}
+
+function validate_result() {
+	TMPFILENAME=/tmp/"${TARGET}"
+
+	# sleep until the file isc reated
+	sleep 1
+	# Check if the file exists
+	if [ ! -f "$TMPFILENAME" ]; then
+	    echo "FAIL: File was not generate." >&2
+	    return ${ksft_fail}
+	fi
+
+	if ! grep -q "${MSG}" "${TMPFILENAME}"; then
+	    echo "FAIL: ${MSG} not found in ${TMPFILENAME}" >&2
+	    cat ${TMPFILENAME} >&2
+	    return ${ksft_fail}
+	fi
+
+	rm ${TMPFILENAME}
+	return ${ksft_pass}
+}
+
+function check_for_dependencies() {
+	if [ "$(id -u)" -ne 0 ]; then
+		echo "This script must be run as root" >&2
+		exit 1
+	fi
+
+	if ! which nc > /dev/null ; then
+		echo "SKIP: nc(1) is not available" >&2
+		exit ${ksft_skip}
+	fi
+
+	if ! which ip > /dev/null ; then
+		echo "SKIP: ip(1) is not available" >&2
+		exit ${ksft_skip}
+	fi
+
+	if [ ! -d "${NETCONS_CONFIGFS}" ]; then
+		echo "SKIP: directory ${NETCONS_CONFIGFS} does not exist. Check if NETCONSOLE_DYNAMIC is enabled" >&2
+		exit ${ksft_skip}
+	fi
+
+	if ip link show veth0 2> /dev/null; then
+		echo "SKIP: interface veth0 exists in the system. Not overwriting it."
+		exit ${ksft_skip}
+	fi
+}
+
+# ========== #
+# Start here #
+# ========== #
+
+# Check for basic system dependency and exit if not found
+check_for_dependencies
+# Create one namespace and two interfaces
+set_network
+# Create a dynamic target for netconsole
+create_dynamic_target
+# Listed for netconsole port inside the namespace and destination interface
+listen_port /tmp/"${TARGET}" &
+# Wait for nc to start and listen to the port.
+sleep 1
+
+# Send the message
+echo "${MSG}: ${TARGET}" > /dev/kmsg
+
+# Make sure the message was received in the dst part
+validate_result
+ret=$?
+# Remove the namespace, interfaces and netconsole target
+cleanup
+
+exit ${ret}
-- 
2.43.0


