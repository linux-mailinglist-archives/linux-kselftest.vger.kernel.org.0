Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C69851F7BFA
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Jun 2020 19:03:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726474AbgFLRDY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 12 Jun 2020 13:03:24 -0400
Received: from smtp.uniroma2.it ([160.80.6.16]:43544 "EHLO smtp.uniroma2.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726432AbgFLRDR (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 12 Jun 2020 13:03:17 -0400
X-Greylist: delayed 670 seconds by postgrey-1.27 at vger.kernel.org; Fri, 12 Jun 2020 13:02:58 EDT
Received: from localhost.localdomain ([160.80.103.126])
        by smtp-2015.uniroma2.it (8.14.4/8.14.4/Debian-8) with ESMTP id 05CGpXZu019363
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 12 Jun 2020 18:51:34 +0200
From:   Andrea Mayer <andrea.mayer@uniroma2.it>
To:     David Ahern <dsahern@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Shrijeet Mukherjee <shrijeet@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc:     Donald Sharp <sharpd@cumulusnetworks.com>,
        Roopa Prabhu <roopa@cumulusnetworks.com>,
        Dinesh Dutt <didutt@gmail.com>,
        Stefano Salsano <stefano.salsano@uniroma2.it>,
        Paolo Lungaroni <paolo.lungaroni@cnit.it>,
        Ahmed Abdelsalam <ahabdels@gmail.com>,
        Andrea Mayer <andrea.mayer@uniroma2.it>
Subject: [RFC,net-next, 5/5] selftests: add selftest for the VRF strict mode
Date:   Fri, 12 Jun 2020 18:49:37 +0200
Message-Id: <20200612164937.5468-6-andrea.mayer@uniroma2.it>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200612164937.5468-1-andrea.mayer@uniroma2.it>
References: <20200612164937.5468-1-andrea.mayer@uniroma2.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.100.0 at smtp-2015
X-Virus-Status: Clean
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The new strict mode functionality is tested in different configurations and
on different network namespaces.

Signed-off-by: Andrea Mayer <andrea.mayer@uniroma2.it>
---
 .../selftests/net/vrf_strict_mode_test.sh     | 390 ++++++++++++++++++
 1 file changed, 390 insertions(+)
 create mode 100755 tools/testing/selftests/net/vrf_strict_mode_test.sh

diff --git a/tools/testing/selftests/net/vrf_strict_mode_test.sh b/tools/testing/selftests/net/vrf_strict_mode_test.sh
new file mode 100755
index 000000000000..5274f4a1fba1
--- /dev/null
+++ b/tools/testing/selftests/net/vrf_strict_mode_test.sh
@@ -0,0 +1,390 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+# This test is designed for testing the new VRF strict_mode functionality.
+
+ret=0
+
+# identifies the "init" network namespace which is often called root network
+# namespace.
+INIT_NETNS_NAME="init"
+
+PAUSE_ON_FAIL=${PAUSE_ON_FAIL:=no}
+
+log_test()
+{
+	local rc=$1
+	local expected=$2
+	local msg="$3"
+
+	if [ ${rc} -eq ${expected} ]; then
+		nsuccess=$((nsuccess+1))
+		printf "\n    TEST: %-60s  [ OK ]\n" "${msg}"
+	else
+		ret=1
+		nfail=$((nfail+1))
+		printf "\n    TEST: %-60s  [FAIL]\n" "${msg}"
+		if [ "${PAUSE_ON_FAIL}" = "yes" ]; then
+			echo
+			echo "hit enter to continue, 'q' to quit"
+			read a
+			[ "$a" = "q" ] && exit 1
+		fi
+	fi
+}
+
+print_log_test_results()
+{
+	if [ "$TESTS" != "none" ]; then
+		printf "\nTests passed: %3d\n" ${nsuccess}
+		printf "Tests failed: %3d\n"   ${nfail}
+	fi
+}
+
+log_section()
+{
+	echo
+	echo "################################################################################"
+	echo "TEST SECTION: $*"
+	echo "################################################################################"
+}
+
+ip_expand_args()
+{
+	local nsname=$1
+	local nsarg=""
+
+	if [ "${nsname}" != "${INIT_NETNS_NAME}" ]; then
+		nsarg="-netns ${nsname}"
+	fi
+
+	echo "${nsarg}"
+}
+
+vrf_count()
+{
+	local nsname=$1
+	local nsarg="$(ip_expand_args ${nsname})"
+
+	ip ${nsarg} -o link show type vrf | wc -l
+}
+
+count_vrf_by_table_id()
+{
+	local nsname=$1
+	local tableid=$2
+	local nsarg="$(ip_expand_args ${nsname})"
+
+	ip ${nsarg} -d -o link show type vrf | grep "table ${tableid}" | wc -l
+}
+
+add_vrf()
+{
+	local nsname=$1
+	local vrfname=$2
+	local vrftable=$3
+	local nsarg="$(ip_expand_args ${nsname})"
+
+	ip ${nsarg} link add ${vrfname} type vrf table ${vrftable} &>/dev/null
+}
+
+add_vrf_and_check()
+{
+	local nsname=$1
+	local vrfname=$2
+	local vrftable=$3
+	local cnt
+	local rc
+
+	add_vrf ${nsname} ${vrfname} ${vrftable}; rc=$?
+
+	cnt=$(count_vrf_by_table_id ${nsname} ${vrftable})
+
+	log_test ${rc} 0 "${nsname}: add vrf ${vrfname}, ${cnt} vrfs for table ${vrftable}"
+}
+
+add_vrf_and_check_fail()
+{
+	local nsname=$1
+	local vrfname=$2
+	local vrftable=$3
+	local cnt
+	local rc
+
+	add_vrf ${nsname} ${vrfname} ${vrftable}; rc=$?
+
+	cnt=$(count_vrf_by_table_id ${nsname} ${vrftable})
+
+	log_test ${rc} 2 "${nsname}: CANNOT add vrf ${vrfname}, ${cnt} vrfs for table ${vrftable}"
+}
+
+del_vrf_and_check()
+{
+	local nsname=$1
+	local vrfname=$2
+	local nsarg="$(ip_expand_args ${nsname})"
+
+	ip ${nsarg} link del ${vrfname}
+	log_test $? 0 "${nsname}: remove vrf ${vrfname}"
+}
+
+config_vrf_and_check()
+{
+	local nsname=$1
+	local addr=$2
+	local vrfname=$3
+	local nsarg="$(ip_expand_args ${nsname})"
+
+	ip ${nsarg} link set dev ${vrfname} up && \
+		ip ${nsarg} addr add ${addr} dev ${vrfname}
+	log_test $? 0 "${nsname}: vrf ${vrfname} up, addr ${addr}"
+}
+
+read_strict_mode()
+{
+	local nsname=$1
+	local rval
+	local rc=0
+	local nsexec=""
+
+	if [ "${nsname}" != "${INIT_NETNS_NAME}" ]; then
+		# a custom network namespace is provided
+		nsexec="ip netns exec ${nsname}"
+	fi
+
+	rval="$(${nsexec} bash -c "cat /proc/sys/net/vrf/strict_mode" | \
+		grep -E "^[0-1]$")" &> /dev/null
+	if [ $? -ne 0 ]; then
+		# set errors
+		rval=255
+		rc=1
+	fi
+
+	# on success, rval can be only 0 or 1; on error, rval is equal to 255
+	echo ${rval}
+	return ${rc}
+}
+
+read_strict_mode_compare_and_check()
+{
+	local nsname=$1
+	local expected=$2
+	local res
+
+	res="$(read_strict_mode ${nsname})"
+	log_test ${res} ${expected} "${nsname}: check strict_mode=${res}"
+}
+
+set_strict_mode()
+{
+	local nsname=$1
+	local val=$2
+	local nsexec=""
+
+	if [ "${nsname}" != "${INIT_NETNS_NAME}" ]; then
+		# a custom network namespace is provided
+		nsexec="ip netns exec ${nsname}"
+	fi
+
+	${nsexec} bash -c "echo ${val} >/proc/sys/net/vrf/strict_mode" &>/dev/null
+}
+
+enable_strict_mode()
+{
+	local nsname=$1
+
+	set_strict_mode ${nsname} 1
+}
+
+disable_strict_mode()
+{
+	local nsname=$1
+
+	set_strict_mode ${nsname} 0
+}
+
+disable_strict_mode_and_check()
+{
+	local nsname=$1
+
+	disable_strict_mode ${nsname}
+	log_test $? 0 "${nsname}: disable strict_mode (=0)"
+}
+
+enable_strict_mode_and_check()
+{
+	local nsname=$1
+
+	enable_strict_mode ${nsname}
+	log_test $? 0 "${nsname}: enable strict_mode (=1)"
+}
+
+enable_strict_mode_and_check_fail()
+{
+	local nsname=$1
+
+	enable_strict_mode ${nsname}
+	log_test $? 1 "${nsname}: CANNOT enable strict_mode"
+}
+
+strict_mode_check_default()
+{
+	local nsname=$1
+	local strictmode
+	local vrfcnt
+
+	vrfcnt=$(vrf_count ${nsname})
+	strictmode=$(read_strict_mode ${nsname})
+	log_test ${strictmode} 0 "${nsname}: strict_mode=0 by default, ${vrfcnt} vrfs"
+}
+
+setup()
+{
+	modprobe vrf
+
+	ip netns add testns
+	ip netns exec testns ip link set lo up
+}
+
+cleanup()
+{
+	ip netns del testns 2>/dev/null
+
+	ip link del vrf100 2>/dev/null
+	ip link del vrf101 2>/dev/null
+	ip link del vrf102 2>/dev/null
+
+	echo 0 >/proc/sys/net/vrf/strict_mode 2>/dev/null
+}
+
+vrf_strict_mode_tests_init()
+{
+	vrf_strict_mode_check_support init
+
+	strict_mode_check_default init
+
+	add_vrf_and_check init vrf100 100
+	config_vrf_and_check init 172.16.100.1/24 vrf100
+
+	enable_strict_mode_and_check init
+
+	add_vrf_and_check_fail init vrf101 100
+
+	disable_strict_mode_and_check init
+
+	add_vrf_and_check init vrf101 100
+	config_vrf_and_check init 172.16.101.1/24 vrf101
+
+	enable_strict_mode_and_check_fail init
+
+	del_vrf_and_check init vrf101
+
+	enable_strict_mode_and_check init
+
+	add_vrf_and_check init vrf102 102
+	config_vrf_and_check init 172.16.102.1/24 vrf102
+
+	# the strict_modle is enabled in the init
+}
+
+vrf_strict_mode_tests_testns()
+{
+	vrf_strict_mode_check_support testns
+
+	strict_mode_check_default testns
+
+	enable_strict_mode_and_check testns
+
+	add_vrf_and_check testns vrf100 100
+	config_vrf_and_check testns 10.0.100.1/24 vrf100
+
+	add_vrf_and_check_fail testns vrf101 100
+
+	add_vrf_and_check_fail testns vrf102 100
+
+	add_vrf_and_check testns vrf200 200
+
+	disable_strict_mode_and_check testns
+
+	add_vrf_and_check testns vrf101 100
+
+	add_vrf_and_check testns vrf102 100
+
+	#the strict_mode is disabled in the testns
+}
+
+vrf_strict_mode_tests_mix()
+{
+	read_strict_mode_compare_and_check init 1
+
+	read_strict_mode_compare_and_check testns 0
+
+	del_vrf_and_check testns vrf101
+
+	del_vrf_and_check testns vrf102
+
+	disable_strict_mode_and_check init
+
+	enable_strict_mode_and_check testns
+
+	enable_strict_mode_and_check init
+	enable_strict_mode_and_check init
+
+	disable_strict_mode_and_check testns
+	disable_strict_mode_and_check testns
+
+	read_strict_mode_compare_and_check init 1
+
+	read_strict_mode_compare_and_check testns 0
+}
+
+vrf_strict_mode_tests()
+{
+	log_section "VRF strict_mode test on init network namespace"
+	vrf_strict_mode_tests_init
+
+	log_section "VRF strict_mode test on testns network namespace"
+	vrf_strict_mode_tests_testns
+
+	log_section "VRF strict_mode test mixing init and testns network namespaces"
+	vrf_strict_mode_tests_mix
+}
+
+vrf_strict_mode_check_support()
+{
+	local nsname=$1
+	local output
+	local rc
+
+	output="$(lsmod | grep '^vrf' | awk '{print $1}')"
+	if [ -z "${output}" ]; then
+		modinfo vrf || return $?
+	fi
+
+	# we do not care about the value of the strict_mode; we only check if
+	# the strict_mode parameter is available or not.
+	read_strict_mode ${nsname} &>/dev/null; rc=$?
+	log_test ${rc} 0 "${nsname}: net.vrf.strict_mode is available"
+
+	return ${rc}
+}
+
+if [ "$(id -u)" -ne 0 ];then
+	echo "SKIP: Need root privileges"
+	exit 0
+fi
+
+if [ ! -x "$(command -v ip)" ]; then
+	echo "SKIP: Could not run test without ip tool"
+	exit 0
+fi
+
+cleanup &> /dev/null
+
+setup
+vrf_strict_mode_tests
+cleanup
+
+print_log_test_results
+
+exit $ret
-- 
2.20.1

