Return-Path: <linux-kselftest+bounces-48915-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BC425D1D57F
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Jan 2026 10:04:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 02329308B7C4
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Jan 2026 08:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FFA43815E8;
	Wed, 14 Jan 2026 08:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="rjWoZByx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE333225415
	for <linux-kselftest@vger.kernel.org>; Wed, 14 Jan 2026 08:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768381189; cv=none; b=Y7sQ6t0DDHVu2pjRhsEwp7Hm3scPEJ/bjfYNTWnvf60L8um2++xtuZcEtpgZ2kPuaReLWkaZAvJw55DrW2iepNWiDLr1hXx7Id3Gl8g4J9ILIDk63PVmRiN9MtmU1ln473uoRu3QHljGXngPI3RWp2PcZzMeHrhrHWmK1MquPNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768381189; c=relaxed/simple;
	bh=pF6GTNh+YrF6fCPuY/fGt+pk0amUlEXY6u+97ttpg5M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=R4gP13Mv2fMHoobYfgQiEELjuq7tud05JF3G+b95Tfl0V1Mtus886RHVszm6p1tfVlS82v6T655Re9DC2Y8flGSVzZn+di3fW3wV9USvEjgY/uRGA9iX5h3xgso3k7iPW0hr+iqIwLOh/4ArD24kBrqy8PKBqxkPcDGkjCnrTbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=rjWoZByx; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 3248E1A27E1;
	Wed, 14 Jan 2026 08:59:41 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 094866074A;
	Wed, 14 Jan 2026 08:59:41 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C4BA4103C8744;
	Wed, 14 Jan 2026 09:59:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1768381179; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=fn4bq2kcP/cFXCxYv1aQ9Vv1ntTqnx0kn8qj9OdtK5U=;
	b=rjWoZByxsGSf3X+3j8F5YT0rOePv+vXyZbabJ/DZZ6pWHS5JzK9jthr1ffzZEjAVW2ewS0
	JdjVOp0ud8GQfwN2dgPgMpkVX/G/LD8qIii4vAjiknBPlwQtRl5OTgIQ31f+lT0t2TKGPa
	NkPLl8MiTWRbIDUQzRjHK7h+8D8R56mNlxoTs6K5T8UHvSSEIaMc3Wo+o1d8WhNgL+wyJV
	sOd2GJCDyNXR17adEWqn7UmPsreAg8xPQMmva9LHNlh/X4lGS57MRkRRItm+Q93YoMHc3R
	2Tjh8Q+rdRT1MP82sYKK/4SEWikHc5WhlzBWzSZ5osocAxPeVH6lJAWiE6RuwA==
From: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Date: Wed, 14 Jan 2026 09:59:14 +0100
Subject: [PATCH bpf-next 3/4] selftests/bpf: add bpftool map manipulations
 tests
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260114-bpftool-tests-v1-3-cfab1cc9beaf@bootlin.com>
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

The test_bpftool_map.sh script tests that maps read/write accesses
are being properly allowed/refused by the kernel depending on a specific
fmod_ret program being attached on security_bpf_map function.

Rewrite this test to integrate it in the new test_bpftool runner. The
new test spawns a few subtests:

  #1/1	maps_access/unprotected_unpinned: OK
  #1/2	maps_access/unprotected_pinned: OK
  #1/3	maps_access/protected_unpinned: OK
  #1/4	maps_access/protected_pinned: OK
  #1/5	maps_access/nested_maps: OK
  #1/6	maps_access/btf_list: OK
  #1	maps_access: OK
  #2/1	metadata/metadata_unused: OK
  #2/2	metadata/metadata_used: OK
  #2	metadata: OK
  Summary: 2 PASSED, 0 FAILED

Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
---
 .../bpf/bpftool_tests/bpftool_maps_access.c        | 370 +++++++++++++++++++++
 1 file changed, 370 insertions(+)

diff --git a/tools/testing/selftests/bpf/bpftool_tests/bpftool_maps_access.c b/tools/testing/selftests/bpf/bpftool_tests/bpftool_maps_access.c
new file mode 100644
index 000000000000..da4277c79e22
--- /dev/null
+++ b/tools/testing/selftests/bpf/bpftool_tests/bpftool_maps_access.c
@@ -0,0 +1,370 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <bpf/libbpf.h>
+#include <bpftool_helpers.h>
+#include <stdlib.h>
+#include <test_bpftool.h>
+#include <assert_helpers.h>
+#include <linux/bpf.h>
+#include <unistd.h>
+#include <fcntl.h>
+#include <stdint.h>
+#include <sys/stat.h>
+#include <stdbool.h>
+#include <bpf/bpf.h>
+#include "security_bpf_map.skel.h"
+
+#define PROTECTED_MAP_NAME	"prot_map"
+#define UNPROTECTED_MAP_NAME	"not_prot_map"
+#define BPF_ITER_FILE		"bpf_iter_map_elem.bpf.o"
+#define BPFFS_PIN_DIR		"/sys/fs/bpf/test_bpftool_map"
+#define INNER_MAP_NAME		"inner_map_tt"
+#define OUTER_MAP_NAME		"outer_map_tt"
+
+#define MAP_NAME_MAX_LEN	64
+#define PATH_MAX_LEN		128
+
+enum map_protection {
+	PROTECTED,
+	UNPROTECTED
+};
+
+struct test_desc {
+	char *name;
+	enum map_protection protection;
+	struct bpf_map *map;
+	char *map_name;
+	bool pinned;
+	char pin_path[PATH_MAX_LEN];
+	bool write_must_fail;
+};
+
+static struct security_bpf_map *general_setup(void)
+{
+	struct security_bpf_map *skel;
+	uint32_t key, value;
+	int ret, i;
+
+	skel = security_bpf_map__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open and load skeleton"))
+		goto end;
+
+	struct bpf_map *maps[] = {skel->maps.prot_map, skel->maps.not_prot_map};
+
+	ret = security_bpf_map__attach(skel);
+	if (!ASSERT_OK(ret, "attach maps security programs"))
+		goto end_destroy;
+
+	for (i = 0; i < sizeof(maps)/sizeof(struct bpf_map *); i++) {
+		for (key = 0; key < 2; key++) {
+			int ret = bpf_map__update_elem(maps[i], &key,
+					sizeof(key), &key, sizeof(key),
+					0);
+			if (!ASSERT_OK(ret, "set initial map value"))
+				goto end_destroy;
+		}
+	}
+
+	key = 0;
+	value = 1;
+	ret = bpf_map__update_elem(skel->maps.prot_status_map, &key,
+			sizeof(key), &value, sizeof(value), 0);
+	if (!ASSERT_OK(ret, "configure map protection"))
+		goto end_destroy;
+
+	if (!ASSERT_OK(mkdir(BPFFS_PIN_DIR, S_IFDIR), "create bpffs pin dir"))
+		goto end_destroy;
+
+	return skel;
+end_destroy:
+	security_bpf_map__destroy(skel);
+end:
+	return NULL;
+}
+
+static void general_cleanup(struct security_bpf_map *skel)
+{
+	rmdir(BPFFS_PIN_DIR);
+	security_bpf_map__destroy(skel);
+}
+
+static void update_test_desc(struct security_bpf_map *skel,
+			      struct test_desc *test)
+{
+	/* Now that the skeleton is loaded, update all missing fields to
+	 * have the subtest properly configured
+	 */
+	if (test->protection == PROTECTED) {
+		test->map = skel->maps.prot_map;
+		test->map_name = PROTECTED_MAP_NAME;
+	} else {
+		test->map = skel->maps.not_prot_map;
+		test->map_name = UNPROTECTED_MAP_NAME;
+	}
+}
+
+static int test_setup(struct security_bpf_map *skel, struct test_desc *desc)
+{
+	int ret;
+
+	update_test_desc(skel, desc);
+
+	if (desc->pinned) {
+		ret = snprintf(desc->pin_path, PATH_MAX_LEN, "%s/%s", BPFFS_PIN_DIR,
+				desc->name);
+		if (!ASSERT_GT(ret, 0, "format pin path"))
+			return 1;
+		ret = bpf_map__pin(desc->map, desc->pin_path);
+		if (!ASSERT_OK(ret, "pin map"))
+			return 1;
+	}
+
+	return 0;
+}
+
+static void test_cleanup(struct test_desc *desc)
+{
+	if (desc->pinned)
+		bpf_map__unpin(desc->map, NULL);
+}
+
+static int lookup_map_value(char *map_handle)
+{
+	char cmd[MAX_BPFTOOL_CMD_LEN];
+	int ret = 0;
+
+	ret = snprintf(cmd, MAX_BPFTOOL_CMD_LEN, "map lookup %s key 0 0 0 0",
+			map_handle);
+	if (!ASSERT_GT(ret, 0, "format map lookup cmd"))
+		return 1;
+	return run_bpftool_command(cmd);
+}
+
+static int read_map_btf_data(char *map_handle)
+{
+	char cmd[MAX_BPFTOOL_CMD_LEN];
+	int ret = 0;
+
+	ret = snprintf(cmd, MAX_BPFTOOL_CMD_LEN, "btf dump map %s",
+			map_handle);
+	if (!ASSERT_GT(ret, 0, "format map btf dump cmd"))
+		return 1;
+	return run_bpftool_command(cmd);
+}
+
+static int write_map_value(char *map_handle)
+{
+	char cmd[MAX_BPFTOOL_CMD_LEN];
+	int ret = 0;
+
+	ret = snprintf(cmd, MAX_BPFTOOL_CMD_LEN,
+		       "map update %s key 0 0 0 0 value 1 1 1 1", map_handle);
+	if (!ASSERT_GT(ret, 0, "format value write cmd"))
+		return 1;
+	return run_bpftool_command(cmd);
+}
+
+static int delete_map_value(char *map_handle)
+{
+	char cmd[MAX_BPFTOOL_CMD_LEN];
+	int ret = 0;
+
+	ret = snprintf(cmd, MAX_BPFTOOL_CMD_LEN,
+		       "map delete %s key 0 0 0 0", map_handle);
+	if (!ASSERT_GT(ret, 0, "format value deletion cmd"))
+		return 1;
+	return run_bpftool_command(cmd);
+}
+
+static int iterate_on_map_values(char *map_handle, char *iter_pin_path)
+{
+	char cmd[MAX_BPFTOOL_CMD_LEN];
+	int ret = 0;
+
+
+	ret = snprintf(cmd, MAX_BPFTOOL_CMD_LEN, "iter pin %s %s map %s",
+		       BPF_ITER_FILE, iter_pin_path, map_handle);
+	if (!ASSERT_GT(ret, 0, "format iterator cration cmd"))
+		return 1;
+	ret = run_bpftool_command(cmd);
+	if (ret)
+		return ret;
+	ret = snprintf(cmd, MAP_NAME_MAX_LEN, "cat %s", iter_pin_path);
+	if (ret < 0)
+		goto cleanup;
+	ret = system(cmd);
+
+cleanup:
+	unlink(iter_pin_path);
+	return ret;
+}
+
+static int create_inner_map(void)
+{
+	char cmd[MAX_BPFTOOL_CMD_LEN];
+	int ret = 0;
+
+	ret = snprintf(
+		cmd, MAX_BPFTOOL_CMD_LEN,
+		"map create %s/%s type array key 4 value 4 entries 4 name %s",
+		BPFFS_PIN_DIR, INNER_MAP_NAME, INNER_MAP_NAME);
+	if (!ASSERT_GT(ret, 0, "format inner map create cmd"))
+		return 1;
+	return run_bpftool_command(cmd);
+}
+
+static int create_outer_map(void)
+{
+	char cmd[MAX_BPFTOOL_CMD_LEN];
+	int ret = 0;
+
+	ret = snprintf(
+		cmd, MAX_BPFTOOL_CMD_LEN,
+		"map create %s/%s type hash_of_maps key 4 value 4 entries 2 name %s inner_map name %s",
+		BPFFS_PIN_DIR, OUTER_MAP_NAME, OUTER_MAP_NAME, INNER_MAP_NAME);
+	if (!ASSERT_GT(ret, 0, "format outer map create cmd"))
+		return 1;
+	return run_bpftool_command(cmd);
+}
+
+static void delete_pinned_map(char *map_name)
+{
+	char pin_path[PATH_MAX_LEN];
+	int ret;
+
+	ret = snprintf(pin_path, PATH_MAX_LEN, "%s/%s", BPFFS_PIN_DIR,
+		       map_name);
+	if (ret >= 0)
+		unlink(pin_path);
+}
+
+static int add_outer_map_entry(int key)
+{
+	char cmd[MAX_BPFTOOL_CMD_LEN];
+	int ret = 0;
+
+	ret = snprintf(
+		cmd, MAX_BPFTOOL_CMD_LEN,
+		"map update pinned %s/%s key %d 0 0 0 value name %s",
+		BPFFS_PIN_DIR, OUTER_MAP_NAME, key, INNER_MAP_NAME);
+	if (!ASSERT_GT(ret, 0, "format outer map value addition cmd"))
+		return 1;
+	return run_bpftool_command(cmd);
+}
+
+static void test_basic_access(struct test_desc *desc)
+{
+	char map_handle[MAP_NAME_MAX_LEN];
+	char iter_pin_path[PATH_MAX_LEN];
+	int ret;
+
+	if (desc->pinned)
+		ret = snprintf(map_handle, MAP_NAME_MAX_LEN, "pinned %s",
+			       desc->pin_path);
+	else
+		ret = snprintf(map_handle, MAP_NAME_MAX_LEN, "name %s",
+			       desc->map_name);
+	if (!ASSERT_GT(ret, 0, "format map handle"))
+		return;
+
+	ret = lookup_map_value(map_handle);
+	ASSERT_OK(ret, "read map value");
+
+	ret = read_map_btf_data(map_handle);
+	ASSERT_OK(ret, "read map btf data");
+
+	ret = write_map_value(map_handle);
+	ASSERT_OK(desc->write_must_fail ? !ret : ret, "write map value");
+
+	ret = delete_map_value(map_handle);
+	ASSERT_OK(desc->write_must_fail ? !ret : ret, "delete map value");
+	/* Restore deleted value */
+	if (!ret)
+		write_map_value(map_handle);
+
+	ret = snprintf(iter_pin_path, PATH_MAX_LEN, "%s/iter", BPFFS_PIN_DIR);
+	if (ASSERT_GT(ret, 0, "format iter pin path")) {
+		ret = iterate_on_map_values(map_handle, iter_pin_path);
+		ASSERT_OK(ret, "iterate on map values");
+	}
+}
+
+static void test_create_nested_maps(void)
+{
+	if (!ASSERT_OK(create_inner_map(), "create inner map"))
+		return;
+	if (!ASSERT_OK(create_outer_map(), "create outer map"))
+		goto end_cleanup_inner;
+	ASSERT_OK(add_outer_map_entry(0), "add a first entry in outer map");
+	ASSERT_OK(add_outer_map_entry(1), "add a second entry in outer map");
+	ASSERT_NEQ(add_outer_map_entry(2), 0, "add a third entry in outer map");
+
+	delete_pinned_map(OUTER_MAP_NAME);
+end_cleanup_inner:
+	delete_pinned_map(INNER_MAP_NAME);
+}
+
+static void test_btf_list(void)
+{
+	ASSERT_OK(run_bpftool_command("btf list"), "list btf data");
+}
+
+static struct test_desc tests[] = {
+	{
+		.name = "unprotected_unpinned",
+		.protection = UNPROTECTED,
+		.map_name = UNPROTECTED_MAP_NAME,
+		.pinned = false,
+		.write_must_fail = false,
+	},
+	{
+		.name = "unprotected_pinned",
+		.protection = UNPROTECTED,
+		.map_name = UNPROTECTED_MAP_NAME,
+		.pinned = true,
+		.write_must_fail = false,
+	},
+	{
+		.name = "protected_unpinned",
+		.protection = PROTECTED,
+		.map_name = UNPROTECTED_MAP_NAME,
+		.pinned = false,
+		.write_must_fail = true,
+	},
+	{
+		.name = "protected_pinned",
+		.protection = PROTECTED,
+		.map_name = UNPROTECTED_MAP_NAME,
+		.pinned = true,
+		.write_must_fail = true,
+	}
+};
+
+static const size_t tests_count = ARRAY_SIZE(tests);
+
+void test_maps_access(void)
+{
+	struct security_bpf_map *skel;
+	struct test_desc *current;
+	int i;
+
+	skel = general_setup();
+	if (!ASSERT_OK_PTR(skel, "prepare programs"))
+		goto cleanup;
+
+	for (i = 0; i < tests_count; i++) {
+		current = &tests[i];
+		test__start_subtest(current->name);
+		if (ASSERT_OK(test_setup(skel, current), "subtest setup"))
+			test_basic_access(current);
+		test_cleanup(current);
+	}
+	test__start_subtest("nested_maps");
+	test_create_nested_maps();
+	test__start_subtest("btf_list");
+	test_btf_list();
+
+cleanup:
+	general_cleanup(skel);
+}
+

-- 
2.52.0


