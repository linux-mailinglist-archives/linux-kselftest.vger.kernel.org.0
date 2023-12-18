Return-Path: <linux-kselftest+bounces-2170-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DBA3817D5F
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Dec 2023 23:45:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EF91285722
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Dec 2023 22:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7F4676080;
	Mon, 18 Dec 2023 22:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZXcKLRhH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5227449893
	for <linux-kselftest@vger.kernel.org>; Mon, 18 Dec 2023 22:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702939500;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pbnEmsD2M9UbQzTo/N0jD1EnHGTOOizhVyRqHmBooa4=;
	b=ZXcKLRhHb3dEX6Dw1MNhJA77/c7wiD2oGzEpW1cf1oGrJL/LN6kFOZ5nMz/CyzKYyGBQHj
	1vqTx5Y13hDIw8R/dOokEoj7dtdODnPs0dI8AjO8gvsgV5qgdDm3L3sHkthHnCEW0qAV7O
	qpXGcGVH9duCPDNDAQSeOATKr/DOBfg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-8XuqzW28MGWFYJY2pZBHxQ-1; Mon, 18 Dec 2023 17:44:56 -0500
X-MC-Unique: 8XuqzW28MGWFYJY2pZBHxQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 409D885A588;
	Mon, 18 Dec 2023 22:44:56 +0000 (UTC)
Received: from redhat.com (unknown [10.22.33.22])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id B8083492BF0;
	Mon, 18 Dec 2023 22:44:55 +0000 (UTC)
Date: Mon, 18 Dec 2023 17:44:54 -0500
From: Joe Lawrence <joe.lawrence@redhat.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>,
	Petr Mladek <pmladek@suse.com>
Cc: linux-kselftest@vger.kernel.org, live-patching@vger.kernel.org,
	linux-s390@vger.kernel.org
Subject: Re: selftests/livepatch fails on s390
Message-ID: <ZYDLZkXdJ22AXtLW@redhat.com>
References: <ZYAimyPYhxVA9wKg@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
 <cf087c7e-d24d-5cee-eadd-dd1fe26efe39@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cf087c7e-d24d-5cee-eadd-dd1fe26efe39@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

On Mon, Dec 18, 2023 at 11:44:23AM -0500, Joe Lawrence wrote:
> 
>  [ ... snip ... ]
> 
> If we pre-trim the timestamps, the output is what we expect:
> 
>   $ comm --nocheck-order -13 \
>       <(sed 's/^\[[ 0-9.]*\] //' /tmp/A) \
>       <(sed 's/^\[[ 0-9.]*\] //' /tmp/B)
>   message four
> 
> however, I'm not sure if that fix would easily apply.  It looks like I
> provided a disclaimer notice in check_result():
> 
> 	# Note: when comparing dmesg output, the kernel log timestamps
> 	# help differentiate repeated testing runs.  Remove them with a
> 	# post-comparison sed filter.
> 
> so I wonder if comm will get confused with repeated selftest runs?
> Using diff/comm was a trick that I surprised worked this long :) Maybe
> it can still hold, but I'll have to run a few experiements.

Hi Alexander,

I tested this idea and yeah, it breaks.  Google brought me back to
Petr's report from when way back when I tried to omit the timestamps:

  https://lore.kernel.org/all/20200617092352.GT31238@alley/

that was with diff and not comm, but I could trip up the latter command
with ~22 iterations of the selftests.

So I took a crack at refactoring: instead of saving intermediate
dmesg.saved files, on starting a test, the script logs and remembers a
LAST_DMESG entry.  When it later checks the test result, it dumps dmesg
starting from after LAST_DMESG entry.

This is *very* lightly tested, but I thought maybe you could give it a
spin.  Hopefully it's less brittle than diff/comm strategy.

-- Joe

-->8-- -->8-- -->8-- -->8-- -->8-- -->8-- -->8-- -->8-- -->8-- -->8--

diff --git a/tools/testing/selftests/livepatch/functions.sh b/tools/testing/selftests/livepatch/functions.sh
index c8416c54b463..b012723e631a 100644
--- a/tools/testing/selftests/livepatch/functions.sh
+++ b/tools/testing/selftests/livepatch/functions.sh
@@ -42,17 +42,6 @@ function die() {
 	exit 1
 }
 
-# save existing dmesg so we can detect new content
-function save_dmesg() {
-	SAVED_DMESG=$(mktemp --tmpdir -t klp-dmesg-XXXXXX)
-	dmesg > "$SAVED_DMESG"
-}
-
-# cleanup temporary dmesg file from save_dmesg()
-function cleanup_dmesg_file() {
-	rm -f "$SAVED_DMESG"
-}
-
 function push_config() {
 	DYNAMIC_DEBUG=$(grep '^kernel/livepatch' /sys/kernel/debug/dynamic_debug/control | \
 			awk -F'[: ]' '{print "file " $1 " line " $2 " " $4}')
@@ -99,7 +88,6 @@ function set_ftrace_enabled() {
 
 function cleanup() {
 	pop_config
-	cleanup_dmesg_file
 }
 
 # setup_config - save the current config and set a script exit trap that
@@ -280,7 +268,13 @@ function set_pre_patch_ret {
 function start_test {
 	local test="$1"
 
-	save_dmesg
+	# Dump something unique into the dmesg log, then stash the entry
+	# in LAST_DMESG.  The check_result() function will use it to
+	# find new kernel messages since the test started.
+	local timestamp="$(date --rfc-3339=ns)"
+	log "livepatch kselftest timestamp: $timestamp"
+	LAST_DMESG=$(dmesg | grep "livepatch kselftest timestamp: $timestamp")
+
 	echo -n "TEST: $test ... "
 	log "===== TEST: $test ====="
 }
@@ -291,11 +285,11 @@ function check_result {
 	local expect="$*"
 	local result
 
-	# Note: when comparing dmesg output, the kernel log timestamps
-	# help differentiate repeated testing runs.  Remove them with a
-	# post-comparison sed filter.
-
-	result=$(dmesg | comm --nocheck-order -13 "$SAVED_DMESG" - | \
+	# Test results include any new dmesg entry since LAST_DMESG, then:
+	# - include lines matching keywords
+	# - exclude lines matching keywords
+	# - filter out dmesg timestamp prefixes
+	result=$(dmesg | awk -v last_dmesg="$LAST_DMESG" 'p; $0 == last_dmesg { p=1 }' | \
 		 grep -e 'livepatch:' -e 'test_klp' | \
 		 grep -v '\(tainting\|taints\) kernel' | \
 		 sed 's/^\[[ 0-9.]*\] //')
@@ -306,8 +300,6 @@ function check_result {
 		echo -e "not ok\n\n$(diff -upr --label expected --label result <(echo "$expect") <(echo "$result"))\n"
 		die "livepatch kselftest(s) failed"
 	fi
-
-	cleanup_dmesg_file
 }
 
 # check_sysfs_rights(modname, rel_path, expected_rights) - check sysfs


