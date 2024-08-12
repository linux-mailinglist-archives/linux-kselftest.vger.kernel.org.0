Return-Path: <linux-kselftest+bounces-15165-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BFD694F56E
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Aug 2024 18:57:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ACAE7B23F34
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Aug 2024 16:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 183531891C6;
	Mon, 12 Aug 2024 16:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N9KMtxGA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44021187868
	for <linux-kselftest@vger.kernel.org>; Mon, 12 Aug 2024 16:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723481836; cv=none; b=tJkLYQDChRtgcX0vEFIvaBR/kvlhUusC40sG3Tv46pUpmg8ARQHODJKjm0d0hsopPnLDz+iC/MZoHGhh7zu1fwidYt+qjuetlZJP52w+Jt8CcgVLClalTs6KLjj7OOzjDRDffB2bQWJ0ZxKkJ6CS+toe1xLhGp5R7l2qNtn+9xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723481836; c=relaxed/simple;
	bh=c61g+eokL94Qx6PmzIigqTzXiW/8xkkklC7HZgSgM7I=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=QSOwvpwDXN6g0UNLl7h3gy+1+BEdpqzbXeP4TXwYMj436XC2jRT9BCrYuJ8STmakQma7kGx6Y7tw+necOZ0XpuRBAcCOrbCmGkAjQVdwE7Q+qdRaspLFhmDjmPe8kbq0Zsea+J7gPtx3ivAuq/ATeod5BctmJVJUgqMsOliP+Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N9KMtxGA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723481833;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=T0qjEw70ZHVOEFltGvRQMTUfl+Sufy34ZqZlbYPxUE8=;
	b=N9KMtxGARi+T0G0FmGN3qrNIRsl0sdIVp1WoN8liGvO37dL+94dlB+P2bVwMwNym6mlCki
	dHwB97/QglnGwZWvtN51fDn5cBXkTmSmityFxIBRUvF4pQlA4r43lQKEgQpwexVFEVCKom
	diUMgzppfeRwc2aUcsLxnIWWx7yfXX0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-67-MFje33fIN-i5JGz0tdODdQ-1; Mon,
 12 Aug 2024 12:57:07 -0400
X-MC-Unique: MFje33fIN-i5JGz0tdODdQ-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 694CE1944EBC;
	Mon, 12 Aug 2024 16:57:03 +0000 (UTC)
Received: from asgard.redhat.com (unknown [10.45.242.9])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 097CB1955BCB;
	Mon, 12 Aug 2024 16:56:53 +0000 (UTC)
Date: Mon, 12 Aug 2024 18:56:50 +0200
From: Eugene Syromiatnikov <esyr@redhat.com>
To: linux-kselftest@vger.kernel.org
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Mark Brown <broonie@kernel.org>, Shuah Khan <shuah@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Peter Zijlstra <peterz@infradead.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>, linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: [PATCH v2] selftests: fix relative rpath usage
Message-ID: <20240812165650.GA5102@asgard.redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

The relative RPATH ("./") supplied to linker options in CFLAGS is resolved
relative to current working directory and not the executable directory,
which will lead in incorrect resolution when the test executables are run
from elsewhere.  Changing it to $ORIGIN makes it resolve relative
to the directory in which the executables reside, which is supposedly
the desired behaviour.  This patch also moves these CFLAGS to lib.mk,
so the RPATH is provided for all selftest binaries, which is arguably
a useful default.

Comparison of

    find -type f -perm /111 -print0 | sort -z | xargs -0 ldd 2>&1 | sed 's/([^)]*)//'

output before and after the change shows that only the binaries that
previously used RPATH of "," are affected and that the linker now able
to find the used dynamic libraries when the executable invoked outside
directory it resides in:

    $ diff -U 0 old_ldd new_ldd
    --- old_ldd     2024-08-12 08:00:16.093535910 -0400
    +++ new_ldd     2024-08-09 09:58:22.657883491 -0400
    @@ -10 +10 @@
    -       libatest.so => not found
    +       libatest.so => /home/build/linux/tools/testing/selftests/./alsa/libatest.so
    @@ -17 +17 @@
    -       libatest.so => not found
    +       libatest.so => /home/build/linux/tools/testing/selftests/./alsa/libatest.so
    @@ -24 +24 @@
    -       libatest.so => not found
    +       libatest.so => /home/build/linux/tools/testing/selftests/./alsa/libatest.so
    @@ -119 +119 @@
    -       liburandom_read.so => not found
    +       liburandom_read.so => /home/build/linux/tools/testing/selftests/./bpf/no_alu32/liburandom_read.so
    @@ -445 +445 @@
    -       liburandom_read.so => not found
    +       liburandom_read.so => /home/build/linux/tools/testing/selftests/./bpf/liburandom_read.so
    @@ -3321 +3321 @@
    -       librseq.so => not found
    +       librseq.so => /home/build/linux/tools/testing/selftests/./rseq/librseq.so
    @@ -3326 +3326 @@
    -       librseq.so => not found
    +       librseq.so => /home/build/linux/tools/testing/selftests/./rseq/librseq.so
    @@ -3331 +3331 @@
    -       librseq.so => not found
    +       librseq.so => /home/build/linux/tools/testing/selftests/./rseq/librseq.so
    @@ -3340 +3340 @@
    -       librseq.so => not found
    +       librseq.so => /home/build/linux/tools/testing/selftests/./rseq/librseq.so
    @@ -3345 +3345 @@
    -       librseq.so => not found
    +       librseq.so => /home/build/linux/tools/testing/selftests/./rseq/librseq.so
    @@ -3350 +3350 @@
    -       librseq.so => not found
    +       librseq.so => /home/build/linux/tools/testing/selftests/./rseq/librseq.so
    @@ -3355 +3355 @@
    -       librseq.so => not found
    +       librseq.so => /home/build/linux/tools/testing/selftests/./rseq/librseq.so
    @@ -3360 +3360 @@
    -       librseq.so => not found
    +       librseq.so => /home/build/linux/tools/testing/selftests/./rseq/librseq.so
    @@ -3365 +3365 @@
    -       librseq.so => not found
    +       librseq.so => /home/build/linux/tools/testing/selftests/./rseq/librseq.so

Some minimal testing is done to verify that it does not affect the
tests: alsa, rseq, and sched (which also had the RPATH tag but didn't
actually link against any locally built libraries) selftests are run
successfully before and after the change;  for the rest
of the selftests, there was no regression observed as well.

Discovered by the check-rpaths script[1][2] that checks for insecure
RPATH/RUNPATH[3], such as relative directories, during an attempt
to package BPF selftests for later use in CI:

    ERROR   0004: file '/usr/libexec/kselftests/bpf/urandom_read' contains an insecure runpath '.' in [.]

[1] https://github.com/rpm-software-management/rpm/blob/master/scripts/check-rpaths
[2] https://github.com/rpm-software-management/rpm/blob/master/scripts/check-rpaths-worker
[3] https://cwe.mitre.org/data/definitions/426.html

Signed-off-by: Eugene Syromiatnikov <esyr@redhat.com>
---
v2:
  - Consolidated the updated -L/-Wl,-rpath setting into lib.mk
  - Described the testing done in the commit message
v1: https://lore.kernel.org/lkml/20240808145639.GA20510@asgard.redhat.com/
    https://lore.kernel.org/lkml/20240808151335.GA5495@asgard.redhat.com/
    https://lore.kernel.org/lkml/20240808151621.GA10025@asgard.redhat.com/
    https://lore.kernel.org/lkml/20240808151621.GA10025@asgard.redhat.com/
---
 tools/testing/selftests/alsa/Makefile  | 1 -
 tools/testing/selftests/bpf/Makefile   | 5 ++---
 tools/testing/selftests/lib.mk         | 3 +++
 tools/testing/selftests/rseq/Makefile  | 2 +-
 tools/testing/selftests/sched/Makefile | 3 +--
 5 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/alsa/Makefile b/tools/testing/selftests/alsa/Makefile
index c1ce39874e2b..68a1651360e5 100644
--- a/tools/testing/selftests/alsa/Makefile
+++ b/tools/testing/selftests/alsa/Makefile
@@ -6,7 +6,6 @@ LDLIBS += $(shell pkg-config --libs alsa)
 ifeq ($(LDLIBS),)
 LDLIBS += -lasound
 endif
-CFLAGS += -L$(OUTPUT) -Wl,-rpath=./
 
 LDLIBS+=-lpthread
 
diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 81d4757ecd4c..a152c12b8a3b 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -239,9 +239,8 @@ $(OUTPUT)/urandom_read: urandom_read.c urandom_read_aux.c $(OUTPUT)/liburandom_r
 	$(call msg,BINARY,,$@)
 	$(Q)$(CLANG) $(CLANG_TARGET_ARCH) \
 		     $(filter-out -static,$(CFLAGS) $(LDFLAGS)) $(filter %.c,$^) \
-		     -lurandom_read $(filter-out -static,$(LDLIBS)) -L$(OUTPUT) \
-		     -fuse-ld=$(LLD) -Wl,-znoseparate-code -Wl,--build-id=sha1 \
-		     -Wl,-rpath=. -o $@
+		     -lurandom_read $(filter-out -static,$(LDLIBS)) \
+		     -fuse-ld=$(LLD) -Wl,-znoseparate-code -Wl,--build-id=sha1 -o $@
 
 $(OUTPUT)/sign-file: ../../../../scripts/sign-file.c
 	$(call msg,SIGN-FILE,,$@)
diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
index d6edcfcb5be8..d75a20bb569c 100644
--- a/tools/testing/selftests/lib.mk
+++ b/tools/testing/selftests/lib.mk
@@ -199,6 +199,9 @@ clean: $(if $(TEST_GEN_MODS_DIR),clean_mods_dir)
 # Build with _GNU_SOURCE by default
 CFLAGS += -D_GNU_SOURCE=
 
+# Simplify usage of libraries built alongside the test executables
+CFLAGS += -L$(OUTPUT) -Wl,-rpath=\$$ORIGIN/
+
 # Enables to extend CFLAGS and LDFLAGS from command line, e.g.
 # make USERCFLAGS=-Werror USERLDFLAGS=-static
 CFLAGS += $(USERCFLAGS)
diff --git a/tools/testing/selftests/rseq/Makefile b/tools/testing/selftests/rseq/Makefile
index 5a3432fceb58..887b45d4a675 100644
--- a/tools/testing/selftests/rseq/Makefile
+++ b/tools/testing/selftests/rseq/Makefile
@@ -6,7 +6,7 @@ endif
 
 top_srcdir = ../../../..
 
-CFLAGS += -O2 -Wall -g -I./ $(KHDR_INCLUDES) -L$(OUTPUT) -Wl,-rpath=./ \
+CFLAGS += -O2 -Wall -g -I./ $(KHDR_INCLUDES) \
 	  $(CLANG_FLAGS) -I$(top_srcdir)/tools/include
 LDLIBS += -lpthread -ldl
 
diff --git a/tools/testing/selftests/sched/Makefile b/tools/testing/selftests/sched/Makefile
index 099ee9213557..0e4581ded9d6 100644
--- a/tools/testing/selftests/sched/Makefile
+++ b/tools/testing/selftests/sched/Makefile
@@ -4,8 +4,7 @@ ifneq ($(shell $(CC) --version 2>&1 | head -n 1 | grep clang),)
 CLANG_FLAGS += -no-integrated-as
 endif
 
-CFLAGS += -O2 -Wall -g -I./ $(KHDR_INCLUDES) -Wl,-rpath=./ \
-	  $(CLANG_FLAGS)
+CFLAGS += -O2 -Wall -g -I./ $(KHDR_INCLUDES) $(CLANG_FLAGS)
 LDLIBS += -lpthread
 
 TEST_GEN_FILES := cs_prctl_test
-- 
2.28.0


