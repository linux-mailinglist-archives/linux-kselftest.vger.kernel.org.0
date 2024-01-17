Return-Path: <linux-kselftest+bounces-3162-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE3B6830B45
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Jan 2024 17:38:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 633771F2BDDA
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Jan 2024 16:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64B6D249E8;
	Wed, 17 Jan 2024 16:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bayT4rGV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B839A241E9
	for <linux-kselftest@vger.kernel.org>; Wed, 17 Jan 2024 16:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705509385; cv=none; b=VSpuG5ByAvsLLMiC4cP7S8lR2Nq86oCRtu7El5lINxdV4xrM0MhBlMZsO+BaUAO9VtAK/5kXtWmFiSQIXPoWMUh8Lyou9nIO9u7we12thzIa2daiKCIe8UjZkM0omFblHaFS6puuMJ2GWrRl6jqsq9nAzPG8ywQ2zDb3G4r34/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705509385; c=relaxed/simple;
	bh=BaKtGrLRrsyMl7efMCkHzm2H6pXTqNSWhWDk1P/kMOg=;
	h=DKIM-Signature:Received:X-MC-Unique:Received:Received:From:To:Cc:
	 Subject:Date:Message-Id:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Scanned-By; b=TA3etORnwJKFXWqhkdb8KUm6mgezUAT3LKAVK7P5xww6MIda6XLS6fsx2D/zZcbFt9mdM+P6jLdLeCkNaWkpUv2kVfCB7IJdM7cJVK3hwnmXphn3+KVj4vrsnsUzSU741CWqMcl5atXp71uqzUJNHnplEJfwENuauNc7XfoSLAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bayT4rGV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705509382;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=55mOiYryAKVg43LXJjjfXDXa8cEy1gWQGp1PtwK9/yc=;
	b=bayT4rGV11oQdMPgQPxuctKIDg13JxuylE0eFGapHed99v+1FOYEK21lpR6iYo0omag5Cw
	UOudbZT5dremYYT4vmzpB20EQp3QXlYLYHaXwKqLSHS0PP5ZepUwO0YqnnAxc5So4p4wdB
	vR4gLIZaahoHETBKqAQn6Gnx2y5lONA=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-685-XuKyGuYONhafxTxTf8BZKg-1; Wed,
 17 Jan 2024 11:36:19 -0500
X-MC-Unique: XuKyGuYONhafxTxTf8BZKg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3138C2813007;
	Wed, 17 Jan 2024 16:36:18 +0000 (UTC)
Received: from llong.com (unknown [10.22.16.147])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 915741121312;
	Wed, 17 Jan 2024 16:36:16 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Tejun Heo <tj@kernel.org>,
	Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Neeraj Upadhyay <quic_neeraju@quicinc.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Shuah Khan <shuah@kernel.org>
Cc: cgroups@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Mrunal Patel <mpatel@redhat.com>,
	Ryan Phillips <rphillips@redhat.com>,
	Brent Rowsell <browsell@redhat.com>,
	Peter Hunt <pehunt@redhat.com>,
	Cestmir Kalina <ckalina@redhat.com>,
	Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Alex Gladkov <agladkov@redhat.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Phil Auld <pauld@redhat.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>,
	Daniel Bristot de Oliveira <bristot@kernel.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Costa Shulyupin <cshulyup@redhat.com>,
	Waiman Long <longman@redhat.com>
Subject: [RFC PATCH 8/8] cgroup/cpuset: Update test_cpuset_prs.sh to handle cpuset.cpus.isolation_full
Date: Wed, 17 Jan 2024 11:35:11 -0500
Message-Id: <20240117163511.88173-9-longman@redhat.com>
In-Reply-To: <20240117163511.88173-1-longman@redhat.com>
References: <20240117163511.88173-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

Add a new "-F" option to cpuset.cpus.isolation_full to enable
cpuset.cpus.isolation_full for trying out the effect of enabling
full CPU isolation.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 .../selftests/cgroup/test_cpuset_prs.sh       | 23 ++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/cgroup/test_cpuset_prs.sh b/tools/testing/selftests/cgroup/test_cpuset_prs.sh
index b5eb1be2248c..2a8f0cb8d252 100755
--- a/tools/testing/selftests/cgroup/test_cpuset_prs.sh
+++ b/tools/testing/selftests/cgroup/test_cpuset_prs.sh
@@ -32,6 +32,7 @@ NR_CPUS=$(lscpu | grep "^CPU(s):" | sed -e "s/.*:[[:space:]]*//")
 PROG=$1
 VERBOSE=0
 DELAY_FACTOR=1
+ISOLATION_FULL=
 SCHED_DEBUG=
 while [[ "$1" = -* ]]
 do
@@ -44,7 +45,10 @@ do
 		-d) DELAY_FACTOR=$2
 		    shift
 		    ;;
-		*)  echo "Usage: $PROG [-v] [-d <delay-factor>"
+		-F) ISOLATION_FULL=1
+		    shift
+		    ;;
+		*)  echo "Usage: $PROG [-v] [-d <delay-factor>] [-F]"
 		    exit
 		    ;;
 	esac
@@ -108,6 +112,22 @@ console_msg()
 	pause 0.01
 }
 
+setup_isolation_full()
+{
+	ISOL_FULL=${CGROUP2}/cpuset.cpus.isolation_full
+	if [[ -n "$ISOLATION_FULL" ]]
+	then
+		echo 1 > $ISOL_FULL
+		set -- $(cat $ISOL_FULL)
+		ISOLATION_FLAGS=$2
+		[[ $VERBOSE -gt 0 ]] && {
+			echo "Full CPU isolation flags: $ISOLATION_FLAGS"
+		}
+	else
+		echo 0 > $ISOL_FULL
+	fi
+}
+
 test_partition()
 {
 	EXPECTED_VAL=$1
@@ -930,6 +950,7 @@ test_inotify()
 }
 
 trap cleanup 0 2 3 6
+setup_isolation_full
 run_state_test TEST_MATRIX
 test_isolated
 test_inotify
-- 
2.39.3


