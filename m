Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05A758AF98
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Aug 2019 08:13:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727836AbfHMGMT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 13 Aug 2019 02:12:19 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:38666 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727485AbfHMGMS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 13 Aug 2019 02:12:18 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7D68wde022017;
        Tue, 13 Aug 2019 06:11:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2019-08-05;
 bh=1nCZBmer4tuZfGj4X7/H4PALF0jE4YsRRquvWXv0zVg=;
 b=YmoF9KiaMHCxdHUaXog9rNzz2szEp6tFHb5QH0erJtblSLpiIUy3J9IPMO0ufXroDwE+
 Ugz8ZuoY8NtfLK87dkL/9Jt/oprgtqDmlQFw00Ofe5UNll7UeUm22neDpUWAEApRLhw3
 /Ya2KaIYdaQ5MB7pV6ELykxJ4crsaAWPJ9k2Mp1F3kNGB0hjU9DEo5FUQ2qqK528dAh9
 JZoAlTp3aFAfEh465bN44rXVvM/5m17uxw5kZnSEBlXZqsYOHntaiCKZO7oOJ0kwKqHJ
 1CPNFVt13YWDZ6a6bK7A7rCLPP7gRwOQfKDk5eX1G9ekdOltQDdROcAsvv26nqbNsBPa 6w== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2018-07-02;
 bh=1nCZBmer4tuZfGj4X7/H4PALF0jE4YsRRquvWXv0zVg=;
 b=fzC+CrPQTX3tB3BBPPNvKWnaLblL0DVRoP4FjOSw8ZRuv7AXsAy5dxah3qnCSzd/R5Mf
 jnxRT0eWZwvuO3h1IZVCSr89hePEeC8P1PoY4kmuwSiEhCbIyQeNzUtMbinDjmjThmlR
 DAkmFzOqX++HQMTbgGsCebW145+QkrTBvBcvZ+bNO95sMhmS06X4E7bnYDwiEBv6q+FJ
 o0MOcAneMv9dACGKc95zAt5WWxLPoNID5ocSQv3ozvOz+8p0jFCKIsCv7a5QMMtx8hJc
 MXaJTYsuXrtUcLaxEImIL3lAAeegxfjuo5Z+maSzwWqzU81RkTuUPfCPPChbG4oFM7fp HQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2u9pjqbvpv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Aug 2019 06:11:58 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7D68ZEh049809;
        Tue, 13 Aug 2019 06:11:57 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2u9k1w41xf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Aug 2019 06:11:57 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x7D6Bu10011420;
        Tue, 13 Aug 2019 06:11:56 GMT
Received: from abi.no.oracle.com (/10.172.144.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 12 Aug 2019 23:11:55 -0700
From:   Knut Omang <knut.omang@oracle.com>
To:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linux-doc@vger.kernel.org, linux-kbuild@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shreyans Devendra Doshi <0xinfosect0r@gmail.com>,
        Alan Maguire <alan.maguire@oracle.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Hidenori Yamaji <hidenori.yamaji@sony.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Timothy Bird <Tim.Bird@sony.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>, Daniel Vetter <daniel@ffwll.ch>,
        Stephen Boyd <sboyd@kernel.org>,
        Knut Omang <knut.omang@oracle.com>
Subject: [RFC 17/19] ktf: Toplevel ktf Makefile/makefile includes and scripts to run from kselftest
Date:   Tue, 13 Aug 2019 08:09:32 +0200
Message-Id: <79b7a9ac73c098d3d6ed7a4dde6952b655232b1c.1565676440.git-series.knut.omang@oracle.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.92d76bb4f6dcedc971d0b72a49e8e459a98bca54.1565676440.git-series.knut.omang@oracle.com>
References: <cover.92d76bb4f6dcedc971d0b72a49e8e459a98bca54.1565676440.git-series.knut.omang@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9347 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908130067
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9347 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908130067
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Signed-off-by: Knut Omang <knut.omang@oracle.com>
---
 tools/testing/selftests/ktf/Makefile            |  21 ++++-
 tools/testing/selftests/ktf/scripts/ktf_syms.mk |  16 +++-
 tools/testing/selftests/ktf/scripts/runtests.mk |   3 +-
 tools/testing/selftests/ktf/scripts/runtests.sh | 100 +++++++++++++++++-
 tools/testing/selftests/ktf/scripts/top_make.mk |  14 ++-
 5 files changed, 154 insertions(+)
 create mode 100644 tools/testing/selftests/ktf/Makefile
 create mode 100644 tools/testing/selftests/ktf/scripts/ktf_syms.mk
 create mode 100644 tools/testing/selftests/ktf/scripts/runtests.mk
 create mode 100755 tools/testing/selftests/ktf/scripts/runtests.sh
 create mode 100644 tools/testing/selftests/ktf/scripts/top_make.mk

diff --git a/tools/testing/selftests/ktf/Makefile b/tools/testing/selftests/ktf/Makefile
new file mode 100644
index 0000000..0fef39c
--- /dev/null
+++ b/tools/testing/selftests/ktf/Makefile
@@ -0,0 +1,21 @@
+
+ifneq ($(TARGETS),)
+# We end up here if called from selftests/Makefile
+# Invoke our "module target" to get everything built
+all:
+	$(Q)$(MAKE) -C $(abs_objtree) M=tools/testing/selftests/ktf
+
+clean:
+	$(Q)$(MAKE) -C $(abs_objtree) M=tools/testing/selftests/ktf clean
+
+run_tests:
+	@echo "running tests"
+	$(MAKE) BUILD=$(abs_objtree)/tools/testing/selftests -f scripts/runtests.mk $@
+
+endif
+obj-m += kernel/
+obj-m += selftest/
+obj-m += examples/
+obj-m += lib/
+obj-m += user/
+
diff --git a/tools/testing/selftests/ktf/scripts/ktf_syms.mk b/tools/testing/selftests/ktf/scripts/ktf_syms.mk
new file mode 100644
index 0000000..a332223
--- /dev/null
+++ b/tools/testing/selftests/ktf/scripts/ktf_syms.mk
@@ -0,0 +1,16 @@
+ktf_symfile=$(shell (cd $(srctree)/$(src) && ls ktf_syms.txt 2> /dev/null || true))
+ktf_syms = $(ktf_symfile:%.txt=%.h)
+
+ifneq ($(ktf_symfile),)
+
+$(obj)/self.o: $(obj)/$(ktf_syms)
+
+ktf_scripts = $(srctree)/$(src)/../scripts
+
+$(obj)/$(ktf_syms): $(srctree)/$(src)/ktf_syms.txt $(ktf_scripts)/resolve
+	@echo "  KTFSYMS $@"
+	$(Q)$(ktf_scripts)/resolve $(ccflags-y) $< $@
+
+clean-files += $(ktf_syms)
+
+endif
diff --git a/tools/testing/selftests/ktf/scripts/runtests.mk b/tools/testing/selftests/ktf/scripts/runtests.mk
new file mode 100644
index 0000000..7fd3651
--- /dev/null
+++ b/tools/testing/selftests/ktf/scripts/runtests.mk
@@ -0,0 +1,3 @@
+TEST_PROGS := scripts/runtests.sh
+
+include ../lib.mk
diff --git a/tools/testing/selftests/ktf/scripts/runtests.sh b/tools/testing/selftests/ktf/scripts/runtests.sh
new file mode 100755
index 0000000..3396aec
--- /dev/null
+++ b/tools/testing/selftests/ktf/scripts/runtests.sh
@@ -0,0 +1,100 @@
+#!/bin/bash -e
+
+verbose=1
+
+# Convenience function to return a string that
+# is a reverse list of the incoming arguments:
+#
+reverse()
+{
+    args=($*)
+    for (( i=((${#args[*]} - 1)); i >= 0; i-- )); do
+	echo ${args[$i]}
+    done
+}
+
+# Set paths to a particular module - if no path is set to a module, use modprobe:
+#
+declare -A a_mpath
+mpath()
+{
+    local module="$1"
+    local mpath="$2"
+    [[ $mpath != "" ]] || fail "Usage: mpath module path"
+
+    a_mpath[$module]="$BUILD/$mpath"
+}
+
+# Set parameters to load a given module with for test purposes:
+declare -A a_params
+params()
+{
+    local module="$1"
+    shift
+    a_params[$module]="$*"
+}
+
+log()
+{
+    (( $verbose )) && echo $*
+}
+
+mod_probe()
+{
+    local fm=""
+    local name="$1"
+    shift
+
+    mp=${a_mpath[$name]}
+    if [[ $mp != "" ]]; then
+	fm="$mp"
+    fi
+
+    is_loaded=$(lsmod | egrep "^$name" || true)
+    if [[ $is_loaded != "" ]]; then
+	echo "Module \"$name\" is already loaded!" 1>&2
+	return 0
+    fi
+
+    if [[ $fm == "" ]]; then
+	log "Modprobing $name"
+	$sudo modprobe $name ${a_params[$name]}
+    else
+	fm=${a_mpath[$name]}
+        log "Insmod'ing module \"$name\"" 1>&2
+	$sudo insmod $fm ${a_params[$name]}
+    fi
+}
+
+# If/when more modules are to be loaded, this could go in a config file
+# but for the purpose of this example, just do it inline:
+#
+mpath ktf 	ktf/kernel/ktf.ko
+mpath selftest	ktf/selftest/selftest.ko
+
+load_modules="ktf selftest"
+
+unload_modules=$(reverse $load_modules)
+
+sudo=""
+if [[ $USER != "root" ]]; then
+    sudo="sudo"
+fi
+
+for m in $load_modules; do
+    mod_probe $m
+done
+
+if [[ $GTEST_PATH == "" ]];then
+    echo "Set environment variable GTEST_PATH to point to your googletest build!"
+    exit 1
+fi
+
+export LD_LIBRARY_PATH="$BUILD/ktf/lib:$GTEST_PATH/lib64:$GTEST_PATH/lib"
+$BUILD/ktf/user/ktftest || stat=$?
+
+for m in $unload_modules; do
+    $sudo rmmod $m
+done
+
+exit $stat
diff --git a/tools/testing/selftests/ktf/scripts/top_make.mk b/tools/testing/selftests/ktf/scripts/top_make.mk
new file mode 100644
index 0000000..978068e
--- /dev/null
+++ b/tools/testing/selftests/ktf/scripts/top_make.mk
@@ -0,0 +1,14 @@
+ifneq ($(TARGETS),)
+# We end up here if called from selftests/Makefile
+# Invoke our "module target" to get everything built
+all:
+	$(Q)$(MAKE) -C $(abs_objtree) M=tools/testing/selftests/ktf
+
+clean:
+	$(Q)$(MAKE) -C $(abs_objtree) M=tools/testing/selftests/ktf clean
+
+run_tests:
+	@echo "running tests"
+	$(MAKE) BUILD=$(abs_objtree)/tools/testing/selftests -f scripts/runtests.mk $@
+
+endif
-- 
git-series 0.9.1
