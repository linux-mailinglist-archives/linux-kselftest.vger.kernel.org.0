Return-Path: <linux-kselftest+bounces-48916-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F16BAD1D67F
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Jan 2026 10:12:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4CFBA30245C8
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Jan 2026 09:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5902B381719;
	Wed, 14 Jan 2026 08:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="D94Rtc98"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE5235EDA3;
	Wed, 14 Jan 2026 08:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768381192; cv=none; b=RtFcb9O7rjsVXWxFq4b1SzIhxsywmm4K3q9e/ESwYSro4uNZ/6nN42vqim2h9lqHpCoDQCTgU1f/zdH2pJ8wd/uWYBBpgaVxaZDYqgYlaTHQrOys8md+gZ7JELkv7L636dC+F+7SdFVVqQdSO0tkzAbd5bPn1SNdiqtlH219DAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768381192; c=relaxed/simple;
	bh=+QQgEf1Y/XnGVu++CXloRLQoIT5Nyn8siqamkif/2cw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sq0neero2YgT5bxezy6GmuCwJoKSBlGDETjQ6c9tcl698wP/0TwAZ3ULuEtOimdAw1+H7lKNDYZGV7KOY8RcAm5VYTZnwqacsiZRM77PaHrV4AAuEdvpoUiWUkFzuD3/hiH+SVJ08YHE45k7s6GMEiilzuMG7iMXpcAQTC2dG7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=D94Rtc98; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 530BE4E420D2;
	Wed, 14 Jan 2026 08:59:43 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 2A2616074A;
	Wed, 14 Jan 2026 08:59:43 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 496BC103C837F;
	Wed, 14 Jan 2026 09:59:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1768381182; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=dUCnkB6VNpqbfeiNJ2XDuKKIu5INNxLaLuHfVEMFXL0=;
	b=D94Rtc98NOGhG/x2cHAL8V3P7+NOOvheePy8m7d7hmA0fDW83eNWjRIudJhPFB4GZyjsJd
	smnht+kRopDPe+yzbvGUdWcaWKJ4IV3iSB4zEvs1Vft0Z0MUzCC5svyibg+Eb+M53jpOdi
	OtxGKH8QvD/iUqU4nzDMbRhIPAJVSHnevWN9bJHgOmLUoqV8gdrmTiwZl2/Iu37HkOqOQ8
	4mwBxSjVOeMnYMAnnMDEM+W0XmKKW6Y98WWJFxCqetKhHXBzAXybxeqWfkVcEEDvTRBNDl
	UWk+yqq5Z7BxXDHiv0LpziAQoZXtgcVGEB2dWnXeoY+ZXe+FY94L+wT+sWCl/w==
From: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Date: Wed, 14 Jan 2026 09:59:15 +0100
Subject: [PATCH bpf-next 4/4] selftests/bpf: remove converted bpftool test
 scripts
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260114-bpftool-tests-v1-4-cfab1cc9beaf@bootlin.com>
References: <20260114-bpftool-tests-v1-0-cfab1cc9beaf@bootlin.com>
In-Reply-To: <20260114-bpftool-tests-v1-0-cfab1cc9beaf@bootlin.com>
To: Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: ebpf@linuxfoundation.org, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

Now that test_bpftool_map.sh and test_bpftool_metadata.sh are integrated
into test_bpftool runner, remove those.

Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
---
 tools/testing/selftests/bpf/Makefile               |   2 -
 tools/testing/selftests/bpf/test_bpftool_map.sh    | 398 ---------------------
 .../testing/selftests/bpf/test_bpftool_metadata.sh |  85 -----
 3 files changed, 485 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index a1fe94efa53c..daa25d6c8fbb 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -109,8 +109,6 @@ TEST_PROGS := test_kmod.sh \
 	test_xdping.sh \
 	test_bpftool_build.sh \
 	test_bpftool.sh \
-	test_bpftool_map.sh \
-	test_bpftool_metadata.sh \
 	test_doc_build.sh \
 	test_xsk.sh \
 	test_xdp_features.sh
diff --git a/tools/testing/selftests/bpf/test_bpftool_map.sh b/tools/testing/selftests/bpf/test_bpftool_map.sh
deleted file mode 100755
index 515b1df0501e..000000000000
--- a/tools/testing/selftests/bpf/test_bpftool_map.sh
+++ /dev/null
@@ -1,398 +0,0 @@
-#!/bin/sh
-# SPDX-License-Identifier: GPL-2.0
-
-# Kselftest framework requirement - SKIP code is 4.
-ksft_skip=4
-
-TESTNAME="bpftool_map"
-BPF_FILE="security_bpf_map.bpf.o"
-BPF_ITER_FILE="bpf_iter_map_elem.bpf.o"
-PROTECTED_MAP_NAME="prot_map"
-NOT_PROTECTED_MAP_NAME="not_prot_map"
-BPF_FS_TMP_PARENT="/tmp"
-BPF_FS_PARENT=$(awk '$3 == "bpf" {print $2; exit}' /proc/mounts)
-BPF_FS_PARENT=${BPF_FS_PARENT:-$BPF_FS_TMP_PARENT}
-# bpftool will mount bpf file system under BPF_DIR if it is not mounted
-# under BPF_FS_PARENT.
-BPF_DIR="$BPF_FS_PARENT/test_$TESTNAME"
-SCRIPT_DIR=$(dirname $(realpath "$0"))
-BPF_FILE_PATH="$SCRIPT_DIR/$BPF_FILE"
-BPF_ITER_FILE_PATH="$SCRIPT_DIR/$BPF_ITER_FILE"
-BPFTOOL_PATH="bpftool"
-# Assume the script is located under tools/testing/selftests/bpf/
-KDIR_ROOT_DIR=$(realpath "$SCRIPT_DIR"/../../../../)
-
-_cleanup()
-{
-	set +eu
-
-	# If BPF_DIR is a mount point this will not remove the mount point itself.
-	[ -d "$BPF_DIR" ] && rm -rf "$BPF_DIR" 2> /dev/null
-
-	# Unmount if BPF filesystem was temporarily created.
-	if [ "$BPF_FS_PARENT" = "$BPF_FS_TMP_PARENT" ]; then
-		# A loop and recursive unmount are required as bpftool might
-		# create multiple mounts. For example, a bind mount of the directory
-		# to itself. The bind mount is created to change mount propagation
-		# flags on an actual mount point.
-		max_attempts=3
-		attempt=0
-		while mountpoint -q "$BPF_DIR" && [ $attempt -lt $max_attempts ]; do
-			umount -R "$BPF_DIR" 2>/dev/null
-			attempt=$((attempt+1))
-		done
-
-		# The directory still exists. Remove it now.
-		[ -d "$BPF_DIR" ] && rm -rf "$BPF_DIR" 2>/dev/null
-	fi
-}
-
-cleanup_skip()
-{
-	echo "selftests: $TESTNAME [SKIP]"
-	_cleanup
-
-	exit $ksft_skip
-}
-
-cleanup()
-{
-	if [ "$?" = 0 ]; then
-		echo "selftests: $TESTNAME [PASS]"
-	else
-		echo "selftests: $TESTNAME [FAILED]"
-	fi
-	_cleanup
-}
-
-check_root_privileges() {
-	if [ $(id -u) -ne 0 ]; then
-		echo "Need root privileges"
-		exit $ksft_skip
-	fi
-}
-
-# Function to verify bpftool path.
-# Parameters:
-#   $1: bpftool path
-verify_bpftool_path() {
-	local bpftool_path="$1"
-	if ! "$bpftool_path" version > /dev/null 2>&1; then
-		echo "Could not run test without bpftool"
-		exit $ksft_skip
-	fi
-}
-
-# Function to verify BTF support.
-# The test requires BTF support for fmod_ret programs.
-verify_btf_support() {
-	if [ ! -f /sys/kernel/btf/vmlinux ]; then
-		echo "Could not run test without BTF support"
-		exit $ksft_skip
-	fi
-}
-
-# Function to initialize map entries with keys [0..2] and values set to 0.
-# Parameters:
-#  $1: Map name
-#  $2: bpftool path
-initialize_map_entries() {
-	local map_name="$1"
-	local bpftool_path="$2"
-
-	for key in 0 1 2; do
-		"$bpftool_path" map update name "$map_name" key $key 0 0 0 value 0 0 0 $key
-	done
-}
-
-# Test read access to the map.
-# Parameters:
-#   $1: Name command (name/pinned)
-#   $2: Map name
-#   $3: bpftool path
-#   $4: key
-access_for_read() {
-	local name_cmd="$1"
-	local map_name="$2"
-	local bpftool_path="$3"
-	local key="$4"
-
-	# Test read access to the map.
-	if ! "$bpftool_path" map lookup "$name_cmd" "$map_name" key $key 1>/dev/null; then
-		echo " Read access to $key in $map_name failed"
-		exit 1
-	fi
-
-	# Test read access to map's BTF data.
-	if ! "$bpftool_path" btf dump map "$name_cmd" "$map_name" 1>/dev/null; then
-		echo " Read access to $map_name for BTF data failed"
-		exit 1
-	fi
-}
-
-# Test write access to the map.
-# Parameters:
-#   $1: Name command (name/pinned)
-#   $2: Map name
-#   $3: bpftool path
-#   $4: key
-#   $5: Whether write should succeed (true/false)
-access_for_write() {
-	local name_cmd="$1"
-	local map_name="$2"
-	local bpftool_path="$3"
-	local key="$4"
-	local write_should_succeed="$5"
-	local value="1 1 1 1"
-
-	if "$bpftool_path" map update "$name_cmd" "$map_name" key $key value \
-			$value 2>/dev/null; then
-		if [ "$write_should_succeed" = "false" ]; then
-			echo " Write access to $key in $map_name succeeded but should have failed"
-			exit 1
-		fi
-	else
-		if [ "$write_should_succeed" = "true" ]; then
-			echo " Write access to $key in $map_name failed but should have succeeded"
-			exit 1
-		fi
-	fi
-}
-
-# Test entry deletion for the map.
-# Parameters:
-#   $1: Name command (name/pinned)
-#   $2: Map name
-#   $3: bpftool path
-#   $4: key
-#   $5: Whether write should succeed (true/false)
-access_for_deletion() {
-	local name_cmd="$1"
-	local map_name="$2"
-	local bpftool_path="$3"
-	local key="$4"
-	local write_should_succeed="$5"
-	local value="1 1 1 1"
-
-	# Test deletion by key for the map.
-	# Before deleting, check the key exists.
-	if ! "$bpftool_path" map lookup "$name_cmd" "$map_name" key $key 1>/dev/null; then
-		echo " Key $key does not exist in $map_name"
-		exit 1
-	fi
-
-	# Delete by key.
-	if "$bpftool_path" map delete "$name_cmd" "$map_name" key $key 2>/dev/null; then
-		if [ "$write_should_succeed" = "false" ]; then
-			echo " Deletion for $key in $map_name succeeded but should have failed"
-			exit 1
-		fi
-	else
-		if [ "$write_should_succeed" = "true" ]; then
-			echo " Deletion for $key in $map_name failed but should have succeeded"
-			exit 1
-		fi
-	fi
-
-	# After deleting, check the entry existence according to the expected status.
-	if "$bpftool_path" map lookup "$name_cmd" "$map_name" key $key 1>/dev/null; then
-		if [ "$write_should_succeed" = "true" ]; then
-			echo " Key $key for $map_name was not deleted but should have been deleted"
-			exit 1
-		fi
-	else
-		if [ "$write_should_succeed" = "false" ]; then
-			echo "Key $key for $map_name was deleted but should have not been deleted"
-			exit 1
-		fi
-	fi
-
-	# Test creation of map's deleted entry, if deletion was successful.
-	# Otherwise, the entry exists.
-	if "$bpftool_path" map update "$name_cmd" "$map_name" key $key value \
-				$value 2>/dev/null; then
-		if [ "$write_should_succeed" = "false" ]; then
-			echo " Write access to $key in $map_name succeeded after deletion attempt but should have failed"
-			exit 1
-		fi
-	else
-		if [ "$write_should_succeed" = "true" ]; then
-			echo " Write access to $key in $map_name failed after deletion attempt but should have succeeded"
-			exit 1
-		fi
-	fi
-}
-
-# Test map elements iterator.
-# Parameters:
-#   $1: Name command (name/pinned)
-#   $2: Map name
-#   $3: bpftool path
-#   $4: BPF_DIR
-#   $5: bpf iterator object file path
-iterate_map_elem() {
-	local name_cmd="$1"
-	local map_name="$2"
-	local bpftool_path="$3"
-	local bpf_dir="$4"
-	local bpf_file="$5"
-	local pin_path="$bpf_dir/map_iterator"
-
-	"$bpftool_path" iter pin "$bpf_file" "$pin_path" map "$name_cmd" "$map_name"
-	if [ ! -f "$pin_path" ]; then
-		echo " Failed to pin iterator to $pin_path"
-		exit 1
-	fi
-
-	cat "$pin_path" 1>/dev/null
-	rm "$pin_path" 2>/dev/null
-}
-
-# Function to test map access with configurable write expectations
-# Parameters:
-#   $1: Name command (name/pinned)
-#   $2: Map name
-#   $3: bpftool path
-#   $4: key for rw
-#   $5: key to delete
-#   $6: Whether write should succeed (true/false)
-#   $7: BPF_DIR
-#   $8: bpf iterator object file path
-access_map() {
-	local name_cmd="$1"
-	local map_name="$2"
-	local bpftool_path="$3"
-	local key_for_rw="$4"
-	local key_to_del="$5"
-	local write_should_succeed="$6"
-	local bpf_dir="$7"
-	local bpf_iter_file_path="$8"
-
-	access_for_read "$name_cmd" "$map_name" "$bpftool_path" "$key_for_rw"
-	access_for_write "$name_cmd" "$map_name" "$bpftool_path" "$key_for_rw" \
-		"$write_should_succeed"
-	access_for_deletion "$name_cmd" "$map_name" "$bpftool_path" "$key_to_del" \
-		"$write_should_succeed"
-	iterate_map_elem "$name_cmd" "$map_name" "$bpftool_path" "$bpf_dir" \
-		"$bpf_iter_file_path"
-}
-
-# Function to test map access with configurable write expectations
-# Parameters:
-#   $1: Map name
-#   $2: bpftool path
-#   $3: BPF_DIR
-#   $4: Whether write should succeed (true/false)
-#   $5: bpf iterator object file path
-test_map_access() {
-	local map_name="$1"
-	local bpftool_path="$2"
-	local bpf_dir="$3"
-	local pin_path="$bpf_dir/${map_name}_pinned"
-	local write_should_succeed="$4"
-	local bpf_iter_file_path="$5"
-
-	# Test access to the map by name.
-	access_map "name" "$map_name" "$bpftool_path" "0 0 0 0" "1 0 0 0" \
-		"$write_should_succeed" "$bpf_dir" "$bpf_iter_file_path"
-
-	# Pin the map to the BPF filesystem
-	"$bpftool_path" map pin name "$map_name" "$pin_path"
-	if [ ! -e "$pin_path" ]; then
-		echo " Failed to pin $map_name"
-		exit 1
-	fi
-
-	# Test access to the pinned map.
-	access_map "pinned" "$pin_path" "$bpftool_path" "0 0 0 0" "2 0 0 0" \
-		"$write_should_succeed" "$bpf_dir" "$bpf_iter_file_path"
-}
-
-# Function to test map creation and map-of-maps
-# Parameters:
-#   $1: bpftool path
-#   $2: BPF_DIR
-test_map_creation_and_map_of_maps() {
-	local bpftool_path="$1"
-	local bpf_dir="$2"
-	local outer_map_name="outer_map_tt"
-	local inner_map_name="inner_map_tt"
-
-	"$bpftool_path" map create "$bpf_dir/$inner_map_name" type array key 4 \
-		value 4 entries 4 name "$inner_map_name"
-	if [ ! -f "$bpf_dir/$inner_map_name" ]; then
-		echo " Failed to create inner map file at $bpf_dir/$outer_map_name"
-		return 1
-	fi
-
-	"$bpftool_path" map create "$bpf_dir/$outer_map_name" type hash_of_maps \
-		key 4 value 4 entries 2 name "$outer_map_name" inner_map name "$inner_map_name"
-	if [ ! -f "$bpf_dir/$outer_map_name" ]; then
-		echo " Failed to create outer map file at $bpf_dir/$outer_map_name"
-		return 1
-	fi
-
-	# Add entries to the outer map by name and by pinned path.
-	"$bpftool_path" map update pinned "$bpf_dir/$outer_map_name" key 0 0 0 0 \
-		value pinned "$bpf_dir/$inner_map_name"
-	"$bpftool_path" map update name "$outer_map_name" key 1 0 0 0 value \
-		name "$inner_map_name"
-
-	# The outer map should be full by now.
-	# The following map update command is expected to fail.
-	if "$bpftool_path" map update name "$outer_map_name" key 2 0 0 0 value name \
-		"$inner_map_name" 2>/dev/null; then
-		echo " Update for $outer_map_name succeeded but should have failed"
-		exit 1
-	fi
-}
-
-# Function to test map access with the btf list command
-# Parameters:
-#   $1: bpftool path
-test_map_access_with_btf_list() {
-	local bpftool_path="$1"
-
-	# The btf list command iterates over maps for
-	# loaded BPF programs.
-	if ! "$bpftool_path" btf list 1>/dev/null; then
-		echo " Failed to access btf data"
-		exit 1
-	fi
-}
-
-set -eu
-
-trap cleanup_skip EXIT
-
-check_root_privileges
-
-verify_bpftool_path "$BPFTOOL_PATH"
-
-verify_btf_support
-
-trap cleanup EXIT
-
-# Load and attach the BPF programs to control maps access.
-"$BPFTOOL_PATH" prog loadall "$BPF_FILE_PATH" "$BPF_DIR" autoattach
-
-initialize_map_entries "$PROTECTED_MAP_NAME" "$BPFTOOL_PATH"
-initialize_map_entries "$NOT_PROTECTED_MAP_NAME" "$BPFTOOL_PATH"
-
-# Activate the map protection mechanism. Protection status is controlled
-# by a value stored in the prot_status_map at index 0.
-"$BPFTOOL_PATH" map update name prot_status_map key 0 0 0 0 value 1 0 0 0
-
-# Test protected map (write should fail).
-test_map_access "$PROTECTED_MAP_NAME" "$BPFTOOL_PATH" "$BPF_DIR" "false" \
- "$BPF_ITER_FILE_PATH"
-
-# Test not protected map (write should succeed).
-test_map_access "$NOT_PROTECTED_MAP_NAME" "$BPFTOOL_PATH" "$BPF_DIR" "true" \
- "$BPF_ITER_FILE_PATH"
-
-test_map_creation_and_map_of_maps "$BPFTOOL_PATH" "$BPF_DIR"
-
-test_map_access_with_btf_list "$BPFTOOL_PATH"
-
-exit 0
diff --git a/tools/testing/selftests/bpf/test_bpftool_metadata.sh b/tools/testing/selftests/bpf/test_bpftool_metadata.sh
deleted file mode 100755
index b5520692f41b..000000000000
--- a/tools/testing/selftests/bpf/test_bpftool_metadata.sh
+++ /dev/null
@@ -1,85 +0,0 @@
-#!/bin/sh
-# SPDX-License-Identifier: GPL-2.0
-
-# Kselftest framework requirement - SKIP code is 4.
-ksft_skip=4
-
-BPF_FILE_USED="metadata_used.bpf.o"
-BPF_FILE_UNUSED="metadata_unused.bpf.o"
-
-TESTNAME=bpftool_metadata
-BPF_FS=$(awk '$3 == "bpf" {print $2; exit}' /proc/mounts)
-BPF_DIR=$BPF_FS/test_$TESTNAME
-
-_cleanup()
-{
-	set +e
-	rm -rf $BPF_DIR 2> /dev/null
-}
-
-cleanup_skip()
-{
-	echo "selftests: $TESTNAME [SKIP]"
-	_cleanup
-
-	exit $ksft_skip
-}
-
-cleanup()
-{
-	if [ "$?" = 0 ]; then
-		echo "selftests: $TESTNAME [PASS]"
-	else
-		echo "selftests: $TESTNAME [FAILED]"
-	fi
-	_cleanup
-}
-
-if [ $(id -u) -ne 0 ]; then
-	echo "selftests: $TESTNAME [SKIP] Need root privileges"
-	exit $ksft_skip
-fi
-
-if [ -z "$BPF_FS" ]; then
-	echo "selftests: $TESTNAME [SKIP] Could not run test without bpffs mounted"
-	exit $ksft_skip
-fi
-
-if ! bpftool version > /dev/null 2>&1; then
-	echo "selftests: $TESTNAME [SKIP] Could not run test without bpftool"
-	exit $ksft_skip
-fi
-
-set -e
-
-trap cleanup_skip EXIT
-
-mkdir $BPF_DIR
-
-trap cleanup EXIT
-
-bpftool prog load $BPF_FILE_UNUSED $BPF_DIR/unused
-
-METADATA_PLAIN="$(bpftool prog)"
-echo "$METADATA_PLAIN" | grep 'a = "foo"' > /dev/null
-echo "$METADATA_PLAIN" | grep 'b = 1' > /dev/null
-
-bpftool prog --json | grep '"metadata":{"a":"foo","b":1}' > /dev/null
-
-bpftool map | grep 'metadata.rodata' > /dev/null
-
-rm $BPF_DIR/unused
-
-bpftool prog load $BPF_FILE_USED $BPF_DIR/used
-
-METADATA_PLAIN="$(bpftool prog)"
-echo "$METADATA_PLAIN" | grep 'a = "bar"' > /dev/null
-echo "$METADATA_PLAIN" | grep 'b = 2' > /dev/null
-
-bpftool prog --json | grep '"metadata":{"a":"bar","b":2}' > /dev/null
-
-bpftool map | grep 'metadata.rodata' > /dev/null
-
-rm $BPF_DIR/used
-
-exit 0

-- 
2.52.0


