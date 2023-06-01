Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C7C1718F64
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Jun 2023 02:08:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbjFAAIg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 31 May 2023 20:08:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjFAAIg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 31 May 2023 20:08:36 -0400
Received: from mail-4018.proton.ch (mail-4018.proton.ch [185.70.40.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B41FF124;
        Wed, 31 May 2023 17:08:31 -0700 (PDT)
Date:   Thu, 01 Jun 2023 00:08:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rhysre.net;
        s=protonmail2; t=1685578109; x=1685837309;
        bh=ZmyJWhx3fktYZQdFy32ON1t+Qe9jELp1qwHtWiiLc5o=;
        h=Date:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
         Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
        b=YqKetOG3WbWUUv3XHh2wvRPvRb8Gty+KWMZ92uXnAXBtKzh3jY8TBgGg5BQUJ7J8c
         oPyHeFmv2QS3b1UQg62ZrWtNAfKA4P7YVvee0kYKlN0tvScB9E3TqXvRulDKCGYGig
         e4yBS/4o3qFRpMBrJDGinbdLB/ducPL2ii/NwKyE2rjn7R7N5QmOqaCAqKYQ0WPFC0
         eW9exkcABk04r3r/b5QLorTeQtN5B9PeVRuMEBDKtg63WWYyy7qkFsitKupsxyCFQs
         beGXFRzFIiqTmTgLh96Mugy3NF17FEJUN6E6TT4gT81JlnL50favtern6UshI65JPb
         4MWmjoV3TdJgA==
From:   Rhys Rustad-Elliott <me@rhysre.net>
Cc:     me@rhysre.net, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH bpf] bpf: Fix elem_size not being set for inner maps
Message-ID: <20230601000713.506358-1-me@rhysre.net>
Feedback-ID: 51368404:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,MISSING_HEADERS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Commit d937bc3449fa ("bpf: make uniform use of array->elem_size
everywhere in arraymap.c") changed array_map_gen_lookup to use
array->elem_size instead of round_up(map->value_size, 8) as the element
size when generating code to access a value in an array map.

array->elem_size, however, is not set by bpf_map_meta_alloc when
initializing an BPF_MAP_TYPE_ARRAY_OF_MAPS or BPF_MAP_TYPE_HASH_OF_MAPS.
This results in array_map_gen_lookup incorrectly outputting code that
always accesses index 0 in the array (as the index will be calculated
via a multiplication with the element size, which is incorrectly set to
0).

Set elem_size on the bpf_array object when allocating an array or hash
of maps and add a selftest that accesses an inner map at a nonzero index
to prevent regressions.

Fixes: d937bc3449fa ("bpf: make uniform use of array->elem_size everywhere =
in arraymap.c")
Signed-off-by: Rhys Rustad-Elliott <me@rhysre.net>
---
 kernel/bpf/map_in_map.c                       |  8 +++-
 .../map_in_map_inner_array_lookup.c           | 33 ++++++++++++++
 .../test_map_in_map_inner_array_lookup.c      | 45 +++++++++++++++++++
 3 files changed, 84 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/map_in_map_inner=
_array_lookup.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_map_in_map_inner=
_array_lookup.c

diff --git a/kernel/bpf/map_in_map.c b/kernel/bpf/map_in_map.c
index 2c5c64c2a53b..8d65b12e0834 100644
--- a/kernel/bpf/map_in_map.c
+++ b/kernel/bpf/map_in_map.c
@@ -69,9 +69,13 @@ struct bpf_map *bpf_map_meta_alloc(int inner_map_ufd)
 =09/* Misc members not needed in bpf_map_meta_equal() check. */
 =09inner_map_meta->ops =3D inner_map->ops;
 =09if (inner_map->ops =3D=3D &array_map_ops) {
+=09=09struct bpf_array *inner_array_meta =3D
+=09=09=09container_of(inner_map_meta, struct bpf_array, map);
+=09=09struct bpf_array *inner_array =3D container_of(inner_map, struct bpf=
_array, map);
+
+=09=09inner_array_meta->index_mask =3D inner_array->index_mask;
+=09=09inner_array_meta->elem_size =3D round_up(inner_map->value_size, 8);
 =09=09inner_map_meta->bypass_spec_v1 =3D inner_map->bypass_spec_v1;
-=09=09container_of(inner_map_meta, struct bpf_array, map)->index_mask =3D
-=09=09     container_of(inner_map, struct bpf_array, map)->index_mask;
 =09}
=20
 =09fdput(f);
diff --git a/tools/testing/selftests/bpf/prog_tests/map_in_map_inner_array_=
lookup.c b/tools/testing/selftests/bpf/prog_tests/map_in_map_inner_array_lo=
okup.c
new file mode 100644
index 000000000000..264d4788e5fd
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/map_in_map_inner_array_lookup.=
c
@@ -0,0 +1,33 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <test_progs.h>
+
+#include "test_map_in_map_inner_array_lookup.skel.h"
+
+static int duration;
+
+void test_map_in_map_inner_array_lookup(void)
+{
+=09int map1_fd, err;
+=09int key =3D 3;
+=09int val =3D 1;
+=09struct test_map_in_map_inner_array_lookup *skel;
+
+=09skel =3D test_map_in_map_inner_array_lookup__open_and_load();
+=09if (CHECK(!skel, "skel_open", "failed to open&load skeleton\n"))
+=09=09return;
+
+=09err =3D test_map_in_map_inner_array_lookup__attach(skel);
+=09if (CHECK(err, "skel_attach", "skeleton attach failed: %d\n", err))
+=09=09goto cleanup;
+
+=09map1_fd =3D bpf_map__fd(skel->maps.inner_map1);
+=09bpf_map_update_elem(map1_fd, &key, &val, 0);
+=09usleep(1);
+=09/* Probe should have set the element at index 3 to 2 */
+=09bpf_map_lookup_elem(map1_fd, &key, &val);
+=09CHECK(val !=3D 2, "inner1", "got %d !=3D exp %d\n", val, 2);
+
+cleanup:
+=09test_map_in_map_inner_array_lookup__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/test_map_in_map_inner_array_=
lookup.c b/tools/testing/selftests/bpf/progs/test_map_in_map_inner_array_lo=
okup.c
new file mode 100644
index 000000000000..c2c8f2fa451d
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_map_in_map_inner_array_lookup.=
c
@@ -0,0 +1,45 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+
+struct inner_map {
+=09__uint(type, BPF_MAP_TYPE_ARRAY);
+=09__uint(max_entries, 5);
+=09__type(key, int);
+=09__type(value, int);
+} inner_map1 SEC(".maps");
+
+struct outer_map {
+=09__uint(type, BPF_MAP_TYPE_HASH_OF_MAPS);
+=09__uint(max_entries, 3);
+=09__type(key, int);
+=09__array(values, struct inner_map);
+} outer_map1 SEC(".maps") =3D {
+=09.values =3D {
+=09=09[2] =3D &inner_map1,
+=09},
+};
+
+SEC("raw_tp/sys_enter")
+int handle__sys_enter(void *ctx)
+{
+=09int outer_key =3D 2, inner_key =3D 3;
+=09int *val;
+=09void *map;
+
+=09map =3D bpf_map_lookup_elem(&outer_map1, &outer_key);
+=09if (!map)
+=09=09return 1;
+
+=09val =3D bpf_map_lookup_elem(map, &inner_key);
+=09if (!val)
+=09=09return 1;
+
+=09if (*val =3D=3D 1)
+=09=09*val =3D 2;
+
+=09return 0;
+}
+
+char _license[] SEC("license") =3D "GPL";
--=20
2.40.1


