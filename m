Return-Path: <linux-kselftest+bounces-2188-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 416918184CF
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Dec 2023 10:50:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAECD2858B9
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Dec 2023 09:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F31A614288;
	Tue, 19 Dec 2023 09:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="deSIWDRb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846DF14AA3;
	Tue, 19 Dec 2023 09:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-58e256505f7so2889409eaf.3;
        Tue, 19 Dec 2023 01:49:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702979380; x=1703584180; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KWclspkFdHwsQxe6p18VtffMIYQVTc/BhcjiGTJxCjs=;
        b=deSIWDRb4gBXph3RMqQWo39bxLFaiXeEKiE1A1TmcRaCAmi3zSe9nFsqooC5m2Nsjk
         qsQXhmz+lEYf/MWyGnnXsMHY1dPCcxpP8WnQ2WhyOJsetxgR5WYMlzexrKWiezIzv/9W
         LQR+/LU1W+CQQ4zZDPaqunzCjIIxs/ahxcTstSUcU9hRkti/Rj109t5oSHzpNkUhRgMT
         uXvkcLUu8FsTktc8drx1t7sETVgxFIBuqM851ZkZ7QY7S+/qq9HHScso6CMEm+FpKznr
         sPnLcEa0H/D0/IXNbVJ4BPssXV2xVfCSSo0aMkIwGdOt6+wDt/OiaOhD+OPAlucN17KM
         s4Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702979380; x=1703584180;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KWclspkFdHwsQxe6p18VtffMIYQVTc/BhcjiGTJxCjs=;
        b=kxCxFojjKEuvlChBuIcrXZa2p14c4HwvZyqKE1uJ7p/2kpWsNMfzqE0XO+ouG6B/+D
         bRmSZ4vqi1Fs8wRYH9Nqr9nIu5LtXaM5oy6xNqDqfsb5IcBbWtKDQ4i5v65q+F1UrnYw
         xPmLNS+ce7gUi9AJhPp6IzMJMJuVh9cOQZ6vjT8PVeekxyjJp+gN3NbkrDZ9zy2yee4h
         NWh+9jJeOZN7vwlWr7+XqrIEcUY2/apBvHH81HJ9JQizPJ+A5maoju/z/gd0kuvXNsQX
         aPzDhrbwhKn3811uEZw3Mhho6KnqSgMEIxRDMoKGAJGBV787xv1eZKasivxA0HHfHM44
         zIZQ==
X-Gm-Message-State: AOJu0YwETO84cpZVgXy2iLmZhLVo/MQkT3bx2wOWp4P3l6rQQQMxgnQ9
	cWfPS4hE2zxcVpsvwSCJis4/D1dWJz/2jPBomAY=
X-Google-Smtp-Source: AGHT+IH1F+4ruknGc0Qe8JnXSRT/68q+3Xl6WhB+9fx+vIag5oILYnt9HBq3qvnPXxNzxh1XYG7wSQ==
X-Received: by 2002:a05:6359:2d81:b0:170:7d81:a325 with SMTP id rn1-20020a0563592d8100b001707d81a325mr10215906rwb.43.1702979380674;
        Tue, 19 Dec 2023 01:49:40 -0800 (PST)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id ds17-20020a17090b08d100b0028b21d24ba6sm1076276pjb.15.2023.12.19.01.49.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 01:49:39 -0800 (PST)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	linux-kselftest@vger.kernel.org,
	Po-Hsu Lin <po-hsu.lin@canonical.com>,
	Florian Westphal <fw@strlen.de>,
	Martin KaFai Lau <kafai@fb.com>,
	Stefano Brivio <sbrivio@redhat.com>,
	Kees Cook <keescook@chromium.org>,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCH net-next 8/8] kselftest/runner.sh: add netns support
Date: Tue, 19 Dec 2023 17:48:56 +0800
Message-ID: <20231219094856.1740079-9-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231219094856.1740079-1-liuhangbin@gmail.com>
References: <20231219094856.1740079-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a variable RUN_IN_NETNS if the user wants to run all the selected tests
in namespace in parallel. With this, we can save a lot of testing time.

Note that some tests may not fit to run in namespace, e.g.
net/drop_monitor_tests.sh, as the dwdump needs to be run in init ns.

I also added another parameter -p to make all the logs reported separately
instead of mixing them in the stdout or output.log.

Nit: the NUM in run_one is not used, rename it to test_num.

Acked-by: David Ahern <dsahern@kernel.org>
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 tools/testing/selftests/kselftest/runner.sh | 38 +++++++++++++++++++--
 tools/testing/selftests/run_kselftest.sh    | 10 +++++-
 2 files changed, 45 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/kselftest/runner.sh b/tools/testing/selftests/kselftest/runner.sh
index cd2fb43eea61..74954f6a8f94 100644
--- a/tools/testing/selftests/kselftest/runner.sh
+++ b/tools/testing/selftests/kselftest/runner.sh
@@ -6,6 +6,7 @@ export skip_rc=4
 export timeout_rc=124
 export logfile=/dev/stdout
 export per_test_logging=
+export RUN_IN_NETNS=
 
 # Defaults for "settings" file fields:
 # "timeout" how many seconds to let each test run before running
@@ -47,7 +48,7 @@ run_one()
 {
 	DIR="$1"
 	TEST="$2"
-	NUM="$3"
+	local test_num="$3"
 
 	BASENAME_TEST=$(basename $TEST)
 
@@ -141,6 +142,33 @@ run_one()
 	fi
 }
 
+in_netns()
+{
+	local name=$1
+	ip netns exec $name bash <<-EOF
+		BASE_DIR=$BASE_DIR
+		source $BASE_DIR/kselftest/runner.sh
+		logfile=$logfile
+		run_one $DIR $TEST $test_num
+	EOF
+}
+
+run_in_netns()
+{
+	local netns=$(mktemp -u ${BASENAME_TEST}-XXXXXX)
+	local tmplog="/tmp/$(mktemp -u ${BASENAME_TEST}-XXXXXX)"
+	ip netns add $netns
+	if [ $? -ne 0 ]; then
+		echo "# Warning: Create namespace failed for $BASENAME_TEST"
+		echo "not ok $test_num selftests: $DIR: $BASENAME_TEST # Create NS failed"
+	fi
+	ip -n $netns link set lo up
+	in_netns $netns &> $tmplog
+	ip netns del $netns &> /dev/null
+	cat $tmplog
+	rm -f $tmplog
+}
+
 run_many()
 {
 	echo "TAP version 13"
@@ -155,6 +183,12 @@ run_many()
 			logfile="/tmp/$BASENAME_TEST"
 			cat /dev/null > "$logfile"
 		fi
-		run_one "$DIR" "$TEST" "$test_num"
+		if [ -n "$RUN_IN_NETNS" ]; then
+			run_in_netns &
+		else
+			run_one "$DIR" "$TEST" "$test_num"
+		fi
 	done
+
+	wait
 }
diff --git a/tools/testing/selftests/run_kselftest.sh b/tools/testing/selftests/run_kselftest.sh
index 92743980e553..a28c1416cb89 100755
--- a/tools/testing/selftests/run_kselftest.sh
+++ b/tools/testing/selftests/run_kselftest.sh
@@ -20,11 +20,13 @@ usage()
 {
 	cat <<EOF
 Usage: $0 [OPTIONS]
-  -s | --summary		Print summary with detailed log in output.log
+  -s | --summary		Print summary with detailed log in output.log (conflict with -p)
+  -p | --per_test_log		Print test log in /tmp with each test name (conflict with -s)
   -t | --test COLLECTION:TEST	Run TEST from COLLECTION
   -c | --collection COLLECTION	Run all tests from COLLECTION
   -l | --list			List the available collection:test entries
   -d | --dry-run		Don't actually run any tests
+  -n | --netns			Run each test in namespace
   -h | --help			Show this usage info
   -o | --override-timeout	Number of seconds after which we timeout
 EOF
@@ -41,6 +43,9 @@ while true; do
 			logfile="$BASE_DIR"/output.log
 			cat /dev/null > $logfile
 			shift ;;
+		-p | --per-test-log)
+			per_test_logging=1
+			shift ;;
 		-t | --test)
 			TESTS="$TESTS $2"
 			shift 2 ;;
@@ -53,6 +58,9 @@ while true; do
 		-d | --dry-run)
 			dryrun="echo"
 			shift ;;
+		-n | --netns)
+			RUN_IN_NETNS=1
+			shift ;;
 		-o | --override-timeout)
 			kselftest_override_timeout="$2"
 			shift 2 ;;
-- 
2.43.0


