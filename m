Return-Path: <linux-kselftest+bounces-540-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCE9B7F6FD9
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Nov 2023 10:31:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBBAE1C210AC
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Nov 2023 09:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 016F4171A3;
	Fri, 24 Nov 2023 09:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZcqC6wJC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E01D10E7;
	Fri, 24 Nov 2023 01:30:37 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1cf6bdf8274so19666595ad.1;
        Fri, 24 Nov 2023 01:30:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700818236; x=1701423036; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=duX0Wmbx1MdXQmSsGeJq/IxxlguI9DSP3X41UJZyQfY=;
        b=ZcqC6wJCXzyrPRnoQPtMiBVUkixUoDBc1QqNLS1/bsBx1WF3IFMFCBr9hxas3EyAz9
         bI1MbAAnFKWP6Z1xGkDlrGq14THpMcSlnwtZP0OPYtZPJdFD+4EktKxgqV2S7D5mjYQp
         lIQaEVuXLw+/QWauMwHE/bXlOYcTHXYiNm6WPww55wRz7KdZuWwIjqoU6Bv35BD+KkPD
         TLlqMNe8bzVzE0n49UU9RHI6vkTA+/YumVAfpwiaxR01Ep9Web0VG6B5UJSFR8G5voTL
         JJFWn4y8shawJlayseLhuZyljPM4HJjTrNgoV5VrdqW3ZrWJH2QycyIpoKvpyVAT5w6B
         LMNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700818236; x=1701423036;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=duX0Wmbx1MdXQmSsGeJq/IxxlguI9DSP3X41UJZyQfY=;
        b=rvDFxjprURG39VYM3m0Ua6xrQ0tOHIyzBN8IBcDrgJJxCSZUk2q95AcaVv2wyN4ajJ
         zwSKs7PLHRhad4hsIMRaN2i7nN5gsUyyhwdjOVt6607W22DFuiLEDY+3+1YgHxpahrzy
         BgCA41o+60SfnkTM2hROdaIlUukFwmbSMzKezTP8O7PFhAnYT6+txbD0Ir4afgna+gKF
         b6erBwe9uh81iZWB0OUjku4uD42iNUePOf677v2Nvx7bg4l3/gB6pkuv5XHV/EM+ZOif
         xpViXLC0vpPyxFce/5OUZOa+N/Bs5eGU/0kflHOzN1Xgq7mv0RsUonBqaX8zH4AXOoX3
         EPyw==
X-Gm-Message-State: AOJu0YzC1JexywR+20ZfzdXeigydlN59SKLU+et3IWiD+qUif83cBnvo
	u8J+/or07mgVXHPV1MBDs1BBJztR5FD+vonu
X-Google-Smtp-Source: AGHT+IEVpaxQ8GsEZG5j3IImyqKQwuQUt4aQ3k30sc2KjXvbhDfGkmuUB0DiDnXRayFt8EaOxPSfVQ==
X-Received: by 2002:a17:902:d50e:b0:1bd:e258:a256 with SMTP id b14-20020a170902d50e00b001bde258a256mr2609935plg.32.1700818236443;
        Fri, 24 Nov 2023 01:30:36 -0800 (PST)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id o10-20020a170902d4ca00b001cfacc54674sm32679plg.106.2023.11.24.01.30.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 01:30:35 -0800 (PST)
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
	Guillaume Nault <gnault@redhat.com>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Mark Brown <broonie@kernel.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCH net-next 38/38] kselftest/runner.sh: add netns support
Date: Fri, 24 Nov 2023 17:27:36 +0800
Message-ID: <20231124092736.3673263-39-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231124092736.3673263-1-liuhangbin@gmail.com>
References: <20231124092736.3673263-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a variable RUN_IN_NETNS if user want to run all the test in name
space in parallel. With this, we can save a lot of testing time.

Nit: the NUM in run_one is not used, rename it to test_num.

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 tools/testing/selftests/kselftest/runner.sh | 26 +++++++++++++++++++--
 tools/testing/selftests/run_kselftest.sh    |  4 ++++
 2 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kselftest/runner.sh b/tools/testing/selftests/kselftest/runner.sh
index cd2fb43eea61..4306b716c115 100644
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
 
@@ -141,6 +142,21 @@ run_one()
 	fi
 }
 
+run_in_netns()
+{
+	local netns=$(mktemp -u ${BASENAME_TEST}-XXXXXX)
+	local tmplog="/tmp/$(mktemp -u ${BASENAME_TEST}-XXXXXX)"
+	ip netns add $netns
+	if [ $? -ne 0 ]; then
+		echo "# Warning: Create namespace failed for $BASENAME_TEST"
+		echo "not ok $test_num selftests: $DIR: $BASENAME_TEST # Create NS failed"
+	fi
+	ip netns exec $netns bash -c "BASE_DIR=$BASE_DIR; source $BASE_DIR/kselftest/runner.sh; logfile=$logfile; run_one $DIR $TEST $test_num" &> $tmplog
+	ip netns del $netns &> /dev/null
+	cat $tmplog
+	rm -f $tmplog
+}
+
 run_many()
 {
 	echo "TAP version 13"
@@ -155,6 +171,12 @@ run_many()
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
index 92743980e553..637aaa9e474a 100755
--- a/tools/testing/selftests/run_kselftest.sh
+++ b/tools/testing/selftests/run_kselftest.sh
@@ -25,6 +25,7 @@ Usage: $0 [OPTIONS]
   -c | --collection COLLECTION	Run all tests from COLLECTION
   -l | --list			List the available collection:test entries
   -d | --dry-run		Don't actually run any tests
+  -n | --netns			Run each test in namespace
   -h | --help			Show this usage info
   -o | --override-timeout	Number of seconds after which we timeout
 EOF
@@ -53,6 +54,9 @@ while true; do
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
2.41.0


