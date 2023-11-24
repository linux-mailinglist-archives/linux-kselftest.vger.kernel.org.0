Return-Path: <linux-kselftest+bounces-554-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74B247F7804
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Nov 2023 16:43:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2927A28105F
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Nov 2023 15:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AB9831732;
	Fri, 24 Nov 2023 15:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="G3gH/Zts"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5C4F19B2
	for <linux-kselftest@vger.kernel.org>; Fri, 24 Nov 2023 07:43:47 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1cfaaa79766so3169595ad.3
        for <linux-kselftest@vger.kernel.org>; Fri, 24 Nov 2023 07:43:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1700840627; x=1701445427; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GHXRjbF4FK0x25SPkE0rzr/gozBo2w/FyphnZEoI1JI=;
        b=G3gH/Zts4FXqiiVv/KUaDyoZHJhnNw456SDIhwXU1uHkBtMjk8a2VnrH5CEhKA7xes
         7npj8w6MAeXMRtL+lpb/Ka8UiKcqITVmusp2tbUIoZ8XEcKUqgtef9lJn0MT5EbCPjen
         pb5a604LiCG4lOMncXHoI26UW2EoBonJRHudjENO3esUkPQbmDbFn6JFyLzrQoTDIc4n
         Cot9+CCJrYnpvhAHgaImrl6RzyavdZzo9B85FEpFJEDm/0YRWcl8ckYYsXnyb3aAQr1c
         NVLVfs4dwIesCGtWV21D3WFHMFTYIe5Q7VpbRENLOWevRVMM5/TjPJfSHgPDyy8R0gF1
         OSVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700840627; x=1701445427;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GHXRjbF4FK0x25SPkE0rzr/gozBo2w/FyphnZEoI1JI=;
        b=kheWVFDvV3ggzqz30hUHxN8K6UjzZqbp768lfrrGOtA0PgymkO2ikq4JfMFmbEbLST
         AbULQZKu6o9Ac7B3WVv/W+6PJwqHsipu2Q76VOn5JUr8CrxrpYPNaOFlJClNJ1nMijLE
         v9OTFKDGZ/vL39jqG4SU6enzxdQw5KM5ZGE+t6ElKA+kKGjs9NsaMRFJ57bOTOPfc/IQ
         O2qbIkJmwn/sJOTgphRNu36CAgSeqGnjUtxFRz+vgC7ncyhsw+qd9pgXEBIlxix/Ijr/
         NddDFJWL4E9L7pVr9duy2wWlBk/otHypHdZa1hyG7itPhlPetB56ddCMpBAzMVtuw5MB
         1HeQ==
X-Gm-Message-State: AOJu0Yyovn++xeJX6st9RLPJrofyAqqlR9wwXE7avuuolwdwqncRsUN0
	HORW+PVji2uBbMnewS43ziawYw==
X-Google-Smtp-Source: AGHT+IGADI4SbDEek9IpA5X++dRMOmqbyuC2DMEf12tlqQgDeGsl6SI4kOp2xfOVVuaSvm0NC6L/7A==
X-Received: by 2002:a17:902:f68e:b0:1cf:8364:ec24 with SMTP id l14-20020a170902f68e00b001cf8364ec24mr3922437plg.4.1700840627221;
        Fri, 24 Nov 2023 07:43:47 -0800 (PST)
Received: from rogue-one.tail33bf8.ts.net ([201.17.86.134])
        by smtp.gmail.com with ESMTPSA id g6-20020a170902740600b001cf9eac2d3asm1919743pll.118.2023.11.24.07.43.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 07:43:46 -0800 (PST)
From: Pedro Tammela <pctammela@mojatatu.com>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	linux-kselftest@vger.kernel.org,
	bpf@vger.kernel.org,
	llvm@lists.linux.dev,
	Pedro Tammela <pctammela@mojatatu.com>,
	Davide Caratti <dcaratti@redhat.com>
Subject: [PATCH net-next 1/5] selftests: tc-testing: remove buildebpf plugin
Date: Fri, 24 Nov 2023 12:42:44 -0300
Message-Id: <20231124154248.315470-2-pctammela@mojatatu.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231124154248.315470-1-pctammela@mojatatu.com>
References: <20231124154248.315470-1-pctammela@mojatatu.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As tdc only tests loading/deleting and anything more complicated is
better left to the ebpf test suite, provide a pre-compiled version of
'action.c' and don't bother compiling it in kselftests or on the fly
at all.

Cc: Davide Caratti <dcaratti@redhat.com>
Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
---
 tools/testing/selftests/tc-testing/Makefile   |  29 +-------
 tools/testing/selftests/tc-testing/README     |   2 -
 .../testing/selftests/tc-testing/action-ebpf  | Bin 0 -> 856 bytes
 .../tc-testing/plugin-lib/buildebpfPlugin.py  |  67 ------------------
 .../tc-testing/tc-tests/actions/bpf.json      |  14 ++--
 .../tc-testing/tc-tests/filters/bpf.json      |  10 ++-
 tools/testing/selftests/tc-testing/tdc.sh     |   2 +-
 7 files changed, 11 insertions(+), 113 deletions(-)
 create mode 100644 tools/testing/selftests/tc-testing/action-ebpf
 delete mode 100644 tools/testing/selftests/tc-testing/plugin-lib/buildebpfPlugin.py

diff --git a/tools/testing/selftests/tc-testing/Makefile b/tools/testing/selftests/tc-testing/Makefile
index b1fa2e177e2f..e8b3dde4fa16 100644
--- a/tools/testing/selftests/tc-testing/Makefile
+++ b/tools/testing/selftests/tc-testing/Makefile
@@ -1,31 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
-include ../../../scripts/Makefile.include
 
-top_srcdir = $(abspath ../../../..)
-APIDIR := $(top_scrdir)/include/uapi
-TEST_GEN_FILES = action.o
+TEST_PROGS += ./tdc.sh
+TEST_FILES := action-ebpf tdc*.py Tdc*.py plugins plugin-lib tc-tests scripts
 
 include ../lib.mk
-
-PROBE := $(shell $(LLC) -march=bpf -mcpu=probe -filetype=null /dev/null 2>&1)
-
-ifeq ($(PROBE),)
-  CPU ?= probe
-else
-  CPU ?= generic
-endif
-
-CLANG_SYS_INCLUDES := $(shell $(CLANG) -v -E - </dev/null 2>&1 \
-	| sed -n '/<...> search starts here:/,/End of search list./{ s| \(/.*\)|-idirafter \1|p }')
-
-CLANG_FLAGS = -I. -I$(APIDIR) \
-	      $(CLANG_SYS_INCLUDES) \
-	      -Wno-compare-distinct-pointer-types
-
-$(OUTPUT)/%.o: %.c
-	$(CLANG) $(CLANG_FLAGS) \
-		 -O2 --target=bpf -emit-llvm -c $< -o - |      \
-	$(LLC) -march=bpf -mcpu=$(CPU) $(LLC_FLAGS) -filetype=obj -o $@
-
-TEST_PROGS += ./tdc.sh
-TEST_FILES := tdc*.py Tdc*.py plugins plugin-lib tc-tests scripts
diff --git a/tools/testing/selftests/tc-testing/README b/tools/testing/selftests/tc-testing/README
index be7b00799b3e..fc8e858ff119 100644
--- a/tools/testing/selftests/tc-testing/README
+++ b/tools/testing/selftests/tc-testing/README
@@ -195,8 +195,6 @@ directory:
       and the other is a test whether the command leaked memory or not.
       (This one is a preliminary version, it may not work quite right yet,
       but the overall template is there and it should only need tweaks.)
-  - buildebpfPlugin.py:
-      builds all programs in $EBPFDIR.
 
 
 ACKNOWLEDGEMENTS
diff --git a/tools/testing/selftests/tc-testing/action-ebpf b/tools/testing/selftests/tc-testing/action-ebpf
new file mode 100644
index 0000000000000000000000000000000000000000..4879479b2ee5c046279be0fe8f9ca313dfb7e618
GIT binary patch
literal 856
zcmb_ayKcfj5L_FFP=-`UX`o1n`2r$0A&n*IpgTFnLKX%`_!N;U`3b&--wH~R684VW
zGukMra)oDhcIIBb_s4kTdmixc;2Y|SRe;%r7+E=j7CQH2*%9vjGf8`~C9?lCIqPKq
z0V7lbI2>i;4uxB2IQfRywbcWscZm%V+i>M{cKD3|LY-|jB&p8JwOW?M`i`k`$r`e-
zC|*}8na?*>z5rF^X|}F1GK49FmEP#&8S!mp@PEb_r>Rd{&-q1E)skfwzsJ=^YYJZ^
zYA*SHxV}g7SDx>m{VgVh?O*Z}>URklWc~pgW_@`FFBFjbmFFLrY<w&cJ}6@0lM0^K
aydN`Ueu^4BW!vY^mI$NC86WSzL;VvvQZ+sR

literal 0
HcmV?d00001

diff --git a/tools/testing/selftests/tc-testing/plugin-lib/buildebpfPlugin.py b/tools/testing/selftests/tc-testing/plugin-lib/buildebpfPlugin.py
deleted file mode 100644
index d34fe06268d2..000000000000
--- a/tools/testing/selftests/tc-testing/plugin-lib/buildebpfPlugin.py
+++ /dev/null
@@ -1,67 +0,0 @@
-'''
-build ebpf program
-'''
-
-import os
-import signal
-from string import Template
-import subprocess
-import time
-from TdcPlugin import TdcPlugin
-from tdc_config import *
-
-class SubPlugin(TdcPlugin):
-    def __init__(self):
-        self.sub_class = 'buildebpf/SubPlugin'
-        self.tap = ''
-        super().__init__()
-
-    def pre_suite(self, testcount, testidlist):
-        super().pre_suite(testcount, testidlist)
-
-        if self.args.buildebpf:
-            self._ebpf_makeall()
-
-    def post_suite(self, index):
-        super().post_suite(index)
-
-        self._ebpf_makeclean()
-
-    def add_args(self, parser):
-        super().add_args(parser)
-
-        self.argparser_group = self.argparser.add_argument_group(
-            'buildebpf',
-            'options for buildebpfPlugin')
-        self.argparser_group.add_argument(
-            '--nobuildebpf', action='store_false', default=True,
-            dest='buildebpf',
-            help='Don\'t build eBPF programs')
-
-        return self.argparser
-
-    def _ebpf_makeall(self):
-        if self.args.buildebpf:
-            self._make('all')
-
-    def _ebpf_makeclean(self):
-        if self.args.buildebpf:
-            self._make('clean')
-
-    def _make(self, target):
-        command = 'make -C {} {}'.format(self.args.NAMES['EBPFDIR'], target)
-        proc = subprocess.Popen(command,
-            shell=True,
-            stdout=subprocess.PIPE,
-            stderr=subprocess.PIPE,
-            env=os.environ.copy())
-        (rawout, serr) = proc.communicate()
-
-        if proc.returncode != 0 and len(serr) > 0:
-            foutput = serr.decode("utf-8")
-        else:
-            foutput = rawout.decode("utf-8")
-
-        proc.stdout.close()
-        proc.stderr.close()
-        return proc, foutput
diff --git a/tools/testing/selftests/tc-testing/tc-tests/actions/bpf.json b/tools/testing/selftests/tc-testing/tc-tests/actions/bpf.json
index 91832400ddbd..6e00bf32ef9a 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/actions/bpf.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/actions/bpf.json
@@ -54,9 +54,6 @@
             "actions",
             "bpf"
         ],
-        "plugins": {
-                "requires": "buildebpfPlugin"
-        },
         "setup": [
             [
                 "$TC action flush action bpf",
@@ -65,10 +62,10 @@
                 255
             ]
         ],
-        "cmdUnderTest": "$TC action add action bpf object-file $EBPFDIR/action.o section action-ok index 667",
+        "cmdUnderTest": "$TC action add action bpf object-file $EBPFDIR/action-ebpf section action-ok index 667",
         "expExitCode": "0",
         "verifyCmd": "$TC action get action bpf index 667",
-        "matchPattern": "action order [0-9]*: bpf action.o:\\[action-ok\\] id [0-9].* tag [0-9a-f]{16}( jited)? default-action pipe.*index 667 ref",
+        "matchPattern": "action order [0-9]*: bpf action-ebpf:\\[action-ok\\] id [0-9].* tag [0-9a-f]{16}( jited)? default-action pipe.*index 667 ref",
         "matchCount": "1",
         "teardown": [
             "$TC action flush action bpf"
@@ -81,9 +78,6 @@
             "actions",
             "bpf"
         ],
-        "plugins": {
-                "requires": "buildebpfPlugin"
-        },
         "setup": [
             [
                 "$TC action flush action bpf",
@@ -92,10 +86,10 @@
                 255
             ]
         ],
-        "cmdUnderTest": "$TC action add action bpf object-file $EBPFDIR/action.o section action-ko index 667",
+        "cmdUnderTest": "$TC action add action bpf object-file $EBPFDIR/action-ebpf section action-ko index 667",
         "expExitCode": "255",
         "verifyCmd": "$TC action get action bpf index 667",
-        "matchPattern": "action order [0-9]*: bpf action.o:\\[action-ko\\] id [0-9].*index 667 ref",
+        "matchPattern": "action order [0-9]*: bpf action-ebpf:\\[action-ko\\] id [0-9].*index 667 ref",
         "matchCount": "0",
         "teardown": [
             [
diff --git a/tools/testing/selftests/tc-testing/tc-tests/filters/bpf.json b/tools/testing/selftests/tc-testing/tc-tests/filters/bpf.json
index 013fb983bc3f..725d406a30ac 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/filters/bpf.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/filters/bpf.json
@@ -52,17 +52,16 @@
         ],
         "plugins": {
             "requires": [
-               "buildebpfPlugin",
                "nsPlugin"
             ]
         },
         "setup": [
             "$TC qdisc add dev $DEV1 ingress"
         ],
-        "cmdUnderTest": "$TC filter add dev $DEV1 parent ffff: handle 1 protocol ip prio 100 bpf object-file $EBPFDIR/action.o section action-ok",
+        "cmdUnderTest": "$TC filter add dev $DEV1 parent ffff: handle 1 protocol ip prio 100 bpf object-file $EBPFDIR/action-ebpf section action-ok",
         "expExitCode": "0",
         "verifyCmd": "$TC filter get dev $DEV1 parent ffff: handle 1 protocol ip prio 100 bpf",
-        "matchPattern": "filter parent ffff: protocol ip pref 100 bpf chain [0-9]+ handle 0x1 action.o:\\[action-ok\\].*tag [0-9a-f]{16}( jited)?",
+        "matchPattern": "filter parent ffff: protocol ip pref 100 bpf chain [0-9]+ handle 0x1 action-ebpf:\\[action-ok\\].*tag [0-9a-f]{16}( jited)?",
         "matchCount": "1",
         "teardown": [
             "$TC qdisc del dev $DEV1 ingress"
@@ -77,17 +76,16 @@
         ],
         "plugins": {
             "requires": [
-               "buildebpfPlugin",
                "nsPlugin"
             ]
         },
         "setup": [
             "$TC qdisc add dev $DEV1 ingress"
         ],
-        "cmdUnderTest": "$TC filter add dev $DEV1 parent ffff: handle 1 protocol ip prio 100 bpf object-file $EBPFDIR/action.o section action-ko",
+        "cmdUnderTest": "$TC filter add dev $DEV1 parent ffff: handle 1 protocol ip prio 100 bpf object-file $EBPFDIR/action-ebpf section action-ko",
         "expExitCode": "1",
         "verifyCmd": "$TC filter get dev $DEV1 parent ffff: handle 1 protocol ip prio 100 bpf",
-        "matchPattern": "filter parent ffff: protocol ip pref 100 bpf chain [0-9]+ handle 0x1 action.o:\\[action-ko\\].*tag [0-9a-f]{16}( jited)?",
+        "matchPattern": "filter parent ffff: protocol ip pref 100 bpf chain [0-9]+ handle 0x1 action-ebpf:\\[action-ko\\].*tag [0-9a-f]{16}( jited)?",
         "matchCount": "0",
         "teardown": [
             "$TC qdisc del dev $DEV1 ingress"
diff --git a/tools/testing/selftests/tc-testing/tdc.sh b/tools/testing/selftests/tc-testing/tdc.sh
index 4dbe50bde5a0..407fa53822a0 100755
--- a/tools/testing/selftests/tc-testing/tdc.sh
+++ b/tools/testing/selftests/tc-testing/tdc.sh
@@ -64,5 +64,5 @@ try_modprobe sch_hfsc
 try_modprobe sch_hhf
 try_modprobe sch_htb
 try_modprobe sch_teql
-./tdc.py -J`nproc` -c actions --nobuildebpf
+./tdc.py -J`nproc` -c actions
 ./tdc.py -J`nproc` -c qdisc
-- 
2.40.1


