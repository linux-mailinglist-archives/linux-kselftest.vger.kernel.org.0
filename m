Return-Path: <linux-kselftest+bounces-34369-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 02B2FACEE78
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Jun 2025 13:22:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F8B7188B410
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Jun 2025 11:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F4E31C863A;
	Thu,  5 Jun 2025 11:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RQok4Xd7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7A0129A2;
	Thu,  5 Jun 2025 11:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749122540; cv=none; b=XxbW9cd4kYd0Mr8s6A8Rv8C6VJwmfuJotWYOOx4rVFJGnF3FGDHkTgKepYLNukF6a5uE5QY+3aaY4Li0hE8Wryb4gnNqocdH5qYsOMYzTDlJOK8b5cYO+MjzVYET0VwLi/Btmxlm04b0bvNPyRSDx9MdTJ7tYztarvKcnfyYB4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749122540; c=relaxed/simple;
	bh=yY8+MZcom4p8eZD59ml9kP0HBRqB7B5hYU9ut5wEL0I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lhjlKB0TvCgnz0GUITP6qHLM/SVXgEIEBU8HoVqJP/GhQd1Wq7m39srnA4IyPiTCetuPJ0oSzdf74cqZP6dOuymjgt7b3RfrfamMGnMJ1SM3/5UWrVgGRxptsPOmlTE4/6z//bwLLPHVkOcYjvk5NBvqcywqyGrYe7yx1HRRDn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RQok4Xd7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52461C4CEE7;
	Thu,  5 Jun 2025 11:22:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749122539;
	bh=yY8+MZcom4p8eZD59ml9kP0HBRqB7B5hYU9ut5wEL0I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=RQok4Xd7tgCPfouwWY9B4smjWEhSN/Rmsy1q2kPNOv20qSUfuCOlAw0fCpVKD3ZQI
	 R6SmBwBBd9j27ZohHFNw8JnSRmfrKJDyqlY8gaVayfWHOYkuGFlq+mgL2g1AuLpJKj
	 ImH0yAn256LUQYbYeN4TjfKsqY9GVyZOGAe42NprTUADuvre/dTFI8kvn3O/UD2m2O
	 QbzeR7OSXn1NwQWsMGxW/B19bdFvdgjJENn07LP6NFx6VbAwmOBDffApYPtsUxBxge
	 2gL+7KBX7lScSwu8Je9AFncJQvi3lucIw0clzZkMfYznX2mokF0umCyotvzwgIhoTU
	 itSy16vQtGDTg==
Message-ID: <aaa49f30-d571-4c7e-8135-691252ebc3c2@kernel.org>
Date: Thu, 5 Jun 2025 12:22:15 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 2/2] selftests/bpf: Add test for bpftool
 access to read-only protected maps
To: Slava Imameev <slava.imameev@crowdstrike.com>, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, shuah@kernel.org,
 bpf@vger.kernel.org
Cc: martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, mykolal@fb.com,
 justin.deschamp@crowdstrike.com, mark.fontana@crowdstrike.com,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20250530164844.74734-1-slava.imameev@crowdstrike.com>
 <20250530164844.74734-2-slava.imameev@crowdstrike.com>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <20250530164844.74734-2-slava.imameev@crowdstrike.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2025-05-31 02:48 UTC+1000 ~ Slava Imameev <slava.imameev@crowdstrike.com>
> Add selftest cases that validate bpftool's expected behavior when
> accessing maps protected from modification via security_bpf_map.
> 
> The test includes a BPF program attached to security_bpf_map with two maps:
> - A protected map that only allows read-only access
> - An unprotected map that allows full access
> 
> The test script attaches the BPF program to security_bpf_map and
> verifies that for the bpftool map command:
> - Read access works on both maps
> - Write access fails on the protected map
> - Write access succeeds on the unprotected map
> - These behaviors remain consistent when the maps are pinned
> 
> Signed-off-by: Slava Imameev <slava.imameev@crowdstrike.com>


Thanks a lot for these tests!


> ---
> Changes in v2:
> - fix for a test compilation error: "conflicting types for 'bpf_fentry_test1'"
> ---
> ---
>  tools/testing/selftests/bpf/Makefile          |   1 +
>  .../selftests/bpf/progs/security_bpf_map.c    |  56 +++++
>  .../testing/selftests/bpf/test_bpftool_map.sh | 208 ++++++++++++++++++
>  3 files changed, 265 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/progs/security_bpf_map.c
>  create mode 100755 tools/testing/selftests/bpf/test_bpftool_map.sh
> 
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> index cf5ed3bee573..731a86407799 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -109,6 +109,7 @@ TEST_PROGS := test_kmod.sh \
>  	test_xdping.sh \
>  	test_bpftool_build.sh \
>  	test_bpftool.sh \
> +	test_bpftool_map.sh \
>  	test_bpftool_metadata.sh \
>  	test_doc_build.sh \
>  	test_xsk.sh \
> diff --git a/tools/testing/selftests/bpf/progs/security_bpf_map.c b/tools/testing/selftests/bpf/progs/security_bpf_map.c
> new file mode 100644
> index 000000000000..09048c096ee4
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/security_bpf_map.c
> @@ -0,0 +1,56 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +#include "vmlinux.h"
> +#include <bpf/bpf_tracing.h>
> +#include <bpf/bpf_helpers.h>
> +
> +char _license[] SEC("license") = "GPL";
> +
> +#define EPERM 1 /* Operation not permitted */
> +
> +/* From include/linux/mm.h. */
> +#define FMODE_WRITE	0x2
> +
> +struct map;
> +
> +struct {
> +	__uint(type, BPF_MAP_TYPE_ARRAY);
> +	__type(key, __u32);
> +	__type(value, __u32);
> +	__uint(max_entries, 1);
> +} prot_map SEC(".maps");
> +
> +struct {
> +	__uint(type, BPF_MAP_TYPE_ARRAY);
> +	__type(key, __u32);
> +	__type(value, __u32);
> +	__uint(max_entries, 1);
> +} not_prot_map SEC(".maps");
> +
> +SEC("fmod_ret/security_bpf_map")
> +int BPF_PROG(fmod_bpf_map, struct bpf_map *map, int fmode)
> +{
> +	if (map == &prot_map) {
> +		/* Allow read-only access */
> +		if (fmode & FMODE_WRITE)
> +			return -EPERM;
> +	}
> +
> +	return 0;
> +}
> +
> +/*
> + * This program keeps references to maps. This is needed to prevent
> + * optimizing them out.
> + */
> +SEC("fentry/bpf_fentry_test1")
> +int BPF_PROG(bpf_map_test0, int a)
> +{
> +	__u32 key = 0;
> +	__u32 val1 = a;
> +	__u32 val2 = a + 1;
> +
> +	bpf_map_update_elem(&prot_map, &key, &val1, BPF_ANY);
> +	bpf_map_update_elem(&not_prot_map, &key, &val2, BPF_ANY);
> +	return 0;
> +}
> diff --git a/tools/testing/selftests/bpf/test_bpftool_map.sh b/tools/testing/selftests/bpf/test_bpftool_map.sh
> new file mode 100755
> index 000000000000..c7c7f3d2071e
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/test_bpftool_map.sh
> @@ -0,0 +1,208 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0
> +
> +# Kselftest framework requirement - SKIP code is 4.
> +ksft_skip=4
> +
> +PROTECTED_MAP_NAME="prot_map"
> +NOT_PROTECTED_MAP_NAME="not_prot_map"
> +BPF_FILE="security_bpf_map.bpf.o"
> +TESTNAME="security_bpf_map"
> +BPF_FS=$(awk '$3 == "bpf" {print $2; exit}' /proc/mounts)
> +BPF_DIR="$BPF_FS/test_$TESTNAME"
> +SCRIPT_DIR=$(dirname $(realpath "$0"))
> +BPF_FILE_PATH="$SCRIPT_DIR/$BPF_FILE"
> +# Assume the script is located under tools/testing/selftests/bpf/
> +KDIR_ROOT_DIR=$(realpath "$SCRIPT_DIR"/../../../../)
> +
> +_cleanup()
> +{
> +	set +eu
> +	[ -d "$TMPDIR" ] && rm -rf "$TMPDIR" 2> /dev/null
> +	[ -d "$BPF_DIR" ] && rm -rf "$BPF_DIR" 2> /dev/null
> +}
> +
> +cleanup_skip()
> +{
> +	echo "selftests: $TESTNAME [SKIP]"
> +	_cleanup
> +
> +	exit $ksft_skip
> +}
> +
> +cleanup()
> +{
> +	if [ "$?" = 0 ]; then
> +		echo "selftests: $TESTNAME [PASS]"
> +	else
> +		echo "selftests: $TESTNAME [FAILED]"
> +	fi
> +	_cleanup
> +}
> +
> +# Parameters:
> +#   $1: The top of kernel repository
> +#   $2: Output directory
> +build_bpftool()
> +{
> +	local kdir_root_dir="$1"
> +	local output_dir="$2"
> +	local pwd="$(pwd)"
> +	local ncpus=1
> +
> +	echo Building bpftool ...
> +
> +	#We want to start build from the top of kernel repository.
> +	cd "$kdir_root_dir"
> +	if [ ! -e tools/bpf/bpftool/Makefile ]; then
> +		echo bpftool files not found
> +		exit $ksft_skip
> +	fi
> +
> +	# Determine the number of CPUs for parallel compilation
> +	if command -v nproc >/dev/null 2>&1; then
> +		ncpus=$(nproc)
> +	fi
> +
> +	make -C tools/bpf/bpftool -s -j"$ncpus" OUTPUT="$output_dir"/ >/dev/null
> +	echo ... finished building bpftool
> +	cd "$pwd"
> +}


Given that you're reusing the BPF selftests infra, you shouldn't have to
rebuild bpftool as part of the test. It's already built from the
Makefile, and other tests just assume it's available already (see
test_bpftool.py, test_bpftool.sh).


> +
> +# Function to test map access with configurable write expectations
> +# Parameters:
> +#   $1: Map name
> +#   $2: Whether write should succeed (true/false)
> +#   $3: bpftool path
> +#   $4: BPF_DIR
> +test_map_access() {
> +	local map_name="$1"
> +	local write_should_succeed="$2"
> +	local bpftool_path="$3"
> +	local pin_path="$4/${map_name}_pinned"
> +	local key="0 0 0 0"
> +	local value="1 1 1 1"
> +
> +	echo "Testing access to map: $map_name"
> +
> +	# Test read access to the map
> +	if "$bpftool_path" map lookup name "$map_name" key $key; then
> +		echo "  Read access to $map_name succeeded"
> +	else
> +		echo "  Read access to $map_name failed"
> +		exit 1
> +	fi
> +
> +	# Test write access to the map
> +	if "$bpftool_path" map update name "$map_name" key $key value $value; then
> +		if [ "$write_should_succeed" = "true" ]; then
> +			echo "  Write access to $map_name succeeded as expected"
> +		else
> +			echo "  Write access to $map_name succeeded but should have failed"
> +			exit 1
> +		fi
> +	else
> +		if [ "$write_should_succeed" = "true" ]; then
> +			echo "  Write access to $map_name failed but should have succeeded"
> +			exit 1
> +		else
> +			echo "  Write access to $map_name failed as expected"
> +		fi
> +	fi


Can we try to delete an item as well, please?


> +
> +	# Pin the map to the BPF filesystem
> +	"$bpftool_path" map pin name "$map_name" "$pin_path"
> +	if [ -e "$pin_path" ]; then
> +		echo "  Successfully pinned $map_name to $pin_path"
> +	else
> +		echo "  Failed to pin $map_name"
> +		exit 1
> +	fi
> +
> +	# Test read access to the pinned map
> +	if "$bpftool_path" map lookup pinned "$pin_path" key $key; then
> +		echo "  Read access to pinned $map_name succeeded"
> +	else
> +		echo "  Read access to pinned $map_name failed"
> +		exit 1
> +	fi
> +
> +	# Test write access to the pinned map
> +	if "$bpftool_path" map update pinned "$pin_path" key $key value $value; then
> +		if [ "$write_should_succeed" = "true" ]; then
> +			echo "  Write access to pinned $map_name succeeded as expected"
> +		else
> +			echo "  Write access to pinned $map_name succeeded but should have failed"
> +			exit 1
> +		fi
> +	else
> +		if [ "$write_should_succeed" = "true" ]; then
> +			echo "  Write access to pinned $map_name failed but should have succeeded"
> +			exit 1
> +		else
> +			echo "  Write access to pinned $map_name failed as expected"
> +		fi
> +	fi


Maybe refactor lookup/update as a function that you can call before and
after pinning the map? (I don't mind much.)


> +
> +	echo "  Finished testing $map_name"
> +	echo
> +}
> +
> +check_root_privileges() {
> +	if [ $(id -u) -ne 0 ]; then
> +		echo "Need root privileges"
> +		exit $ksft_skip
> +	fi
> +}
> +
> +check_bpffs() {
> +	if [ -z "$BPF_FS" ]; then
> +		echo "Could not run test without bpffs mounted"


Why not? Bpftool will attempt to mount it for you if it's not available
(create_and_mount_bpffs_dir()).

You could mount it manually to a specific location and unmount it during
 the clean-up phase, if you wanted to be sure that the test doesn't have
any side effect on the filesystem.


> +		exit $ksft_skip
> +	fi
> +}
> +
> +create_tmp_dir() {
> +	TMPDIR=$(mktemp -d)
> +	if [ $? -ne 0 ] || [ ! -d "$TMPDIR" ]; then
> +		echo "Failed to create temporary directory"
> +		exit $ksft_skip
> +	fi
> +}
> +
> +locate_or_build_bpftool() {
> +	if ! bpftool version > /dev/null 2>&1; then
> +		build_bpftool "$KDIR_ROOT_DIR" "$TMPDIR"
> +		BPFTOOL_PATH="$TMPDIR"/bpftool
> +	else
> +		echo "Using bpftool from PATH"
> +		BPFTOOL_PATH="bpftool"
> +	fi
> +}
> +
> +set -eu
> +
> +trap cleanup_skip EXIT
> +
> +check_root_privileges
> +
> +check_bpffs
> +
> +create_tmp_dir
> +
> +locate_or_build_bpftool
> +
> +mkdir "$BPF_DIR"
> +
> +trap cleanup EXIT
> +
> +# Load and attach the BPF programs to control maps access
> +"$BPFTOOL_PATH" prog loadall "$BPF_FILE_PATH" "$BPF_DIR"/prog autoattach
> +
> +# Test protected map (write should fail)
> +test_map_access "$PROTECTED_MAP_NAME" "false" "$BPFTOOL_PATH" "$BPF_DIR"
> +
> +# Test not protected map (write should succeed)
> +test_map_access "$NOT_PROTECTED_MAP_NAME" "true" "$BPFTOOL_PATH" "$BPF_DIR"


We could also test map creation here (possibly even with inner maps).


> +
> +exit 0


Thanks,
Quentin

