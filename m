Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B5661219D6
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Dec 2019 20:20:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726692AbfLPTSo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 16 Dec 2019 14:18:44 -0500
Received: from mail-il1-f194.google.com ([209.85.166.194]:43102 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726510AbfLPTSo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 16 Dec 2019 14:18:44 -0500
Received: by mail-il1-f194.google.com with SMTP id v69so5145913ili.10
        for <linux-kselftest@vger.kernel.org>; Mon, 16 Dec 2019 11:18:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=b0bPLN5SC/JUxyNe5zd5G4JnOmCrsV5JAHwqQnxls/I=;
        b=cUG5s+X+poHDgIfqpZeTcLpjKmwBRRAbShTvIRovE09W/Y12Bu+1asGMKjowke85At
         yk+cmLoG8NRuPli4KN3+KU3jKH4IN8YvmKUbzkYjq9HlMAjI9ijXrN1q+JiDmlXgTYAV
         /xUD653vaHLTDTMMsQ1S82NWvl2gPI7MIze3A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=b0bPLN5SC/JUxyNe5zd5G4JnOmCrsV5JAHwqQnxls/I=;
        b=GbE5B4ANcv8F/NNE9MHUlypLTye75qtw9e/lY6M4X/k+ZK/MSU2sBLlFeHtICjMTlO
         QChqy9FCGyMYpVdoWT5C1VIF84GKTckTJl7ObYLe16G1vDUnvZQZzJnlzSA13QCZuAg/
         fJaQ0pzZ0+Lr5KkF/L1TJhH32OKdtdrx86825eOh/MOxnxfzC+J9HlxfflCMa/pCLDbY
         jjSpYZOEUk6CRkW8to18PkQK3e2GYSV+UyDkgT3rES+VOvk/vAwV/SA3zaMLPhu8d7Po
         Mn1P0YwKOlUu9yILGPknTfI51qbAsSqXxIMZKO6oEJLVzrIY3Oi3pCb0ecSAP74dmC0+
         usCA==
X-Gm-Message-State: APjAAAUCUG9CLfHl5D/kJ2pWi+9OMVAFsT5yfpz0+xYk/VmiyCFTTSQf
        M5MuuAUOSP/d1GVGOkerYfq7ig==
X-Google-Smtp-Source: APXvYqyBVVb7+uPaVUYuEid782dIYbWuLfwMhIH5T3fw2W4XVs+n3QA/tRU0fCORY2L/7gD1xws8Zg==
X-Received: by 2002:a92:84d1:: with SMTP id y78mr13619028ilk.69.1576523923730;
        Mon, 16 Dec 2019 11:18:43 -0800 (PST)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id v10sm4530979iol.85.2019.12.16.11.18.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2019 11:18:43 -0800 (PST)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     jpoimboe@redhat.com, jikos@kernel.org, mbenes@suse.cz,
        pmladek@suse.com, joe.lawrence@redhat.com, shuah@kernel.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] selftests: livepatch: Fix it to do root uid check and skip
Date:   Mon, 16 Dec 2019 12:18:40 -0700
Message-Id: <20191216191840.15188-1-skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

livepatch test configures the system and debug environment to run
tests. Some of these actions fail without root access and test
dumps several permission denied messages before it exits.

Fix test-state.sh to call setup_config instead of set_dynamic_debug
as suggested by Petr Mladek <pmladek@suse.com>

Fix it to check root uid and exit with skip code instead.

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 tools/testing/selftests/livepatch/functions.sh  | 15 ++++++++++++++-
 tools/testing/selftests/livepatch/test-state.sh |  3 +--
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/livepatch/functions.sh b/tools/testing/selftests/livepatch/functions.sh
index 31eb09e38729..a6e3d5517a6f 100644
--- a/tools/testing/selftests/livepatch/functions.sh
+++ b/tools/testing/selftests/livepatch/functions.sh
@@ -7,6 +7,9 @@
 MAX_RETRIES=600
 RETRY_INTERVAL=".1"	# seconds
 
+# Kselftest framework requirement - SKIP code is 4
+ksft_skip=4
+
 # log(msg) - write message to kernel log
 #	msg - insightful words
 function log() {
@@ -18,7 +21,16 @@ function log() {
 function skip() {
 	log "SKIP: $1"
 	echo "SKIP: $1" >&2
-	exit 4
+	exit $ksft_skip
+}
+
+# root test
+function is_root() {
+	uid=$(id -u)
+	if [ $uid -ne 0 ]; then
+		echo "skip all tests: must be run as root" >&2
+		exit $ksft_skip
+	fi
 }
 
 # die(msg) - game over, man
@@ -62,6 +74,7 @@ function set_ftrace_enabled() {
 #		 for verbose livepatching output and turn on
 #		 the ftrace_enabled sysctl.
 function setup_config() {
+	is_root
 	push_config
 	set_dynamic_debug
 	set_ftrace_enabled 1
diff --git a/tools/testing/selftests/livepatch/test-state.sh b/tools/testing/selftests/livepatch/test-state.sh
index dc2908c22c26..a08212708115 100755
--- a/tools/testing/selftests/livepatch/test-state.sh
+++ b/tools/testing/selftests/livepatch/test-state.sh
@@ -8,8 +8,7 @@ MOD_LIVEPATCH=test_klp_state
 MOD_LIVEPATCH2=test_klp_state2
 MOD_LIVEPATCH3=test_klp_state3
 
-set_dynamic_debug
-
+setup_config
 
 # TEST: Loading and removing a module that modifies the system state
 
-- 
2.20.1

