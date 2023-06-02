Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9DA2720975
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Jun 2023 21:02:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237099AbjFBTCT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 2 Jun 2023 15:02:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235724AbjFBTCS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 2 Jun 2023 15:02:18 -0400
Received: from mail-40136.proton.ch (mail-40136.proton.ch [185.70.40.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34A681A5;
        Fri,  2 Jun 2023 12:02:14 -0700 (PDT)
Date:   Fri, 02 Jun 2023 19:02:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rhysre.net;
        s=protonmail2; t=1685732532; x=1685991732;
        bh=qwJrB1rSHhtigPMUxFREYjzwXVOIGX9DwM84ViT8rlQ=;
        h=Date:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=TWTUdY86ogG/W4OnKSmncDWoqvLBmdCDQHIyHPA4MGwrgGf5KYTqLUDsanWXdVdPU
         E6fbZTJew93KYnRPoyU09EWzlkXZ/hqR1YZu/AKyF42CEYNk8uyDNUiSnsL3r3GvYE
         p+mY589WGka9/iA3gv92KIx2IyhNgkusZ6nG5XgnQJAifGPJIvvwgfwI27WUzFDTzd
         HeHBqsHmeDqB2hSZm/BHDVz4jy1PtA+6zyZ1Y3sYY/+4fZPTYXamtTPbrrEVa61xa/
         e7YkKYtgM6/QhGXo9YfVpj0WpT/AzUEf+ts1SsDb0aVf5ZbjXm7ElebicnQexjeP/3
         di22FBEMTqO1Q==
From:   Rhys Rustad-Elliott <me@rhysre.net>
Cc:     Rhys Rustad-Elliott <me@rhysre.net>,
        Alexei Starovoitov <ast@kernel.org>,
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
Subject: [PATCH bpf v2 1/2] bpf: Fix elem_size not being set for inner maps
Message-ID: <20230602190110.47068-2-me@rhysre.net>
In-Reply-To: <20230602190110.47068-1-me@rhysre.net>
References: <20230602190110.47068-1-me@rhysre.net>
Feedback-ID: 51368404:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,MISSING_HEADERS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
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
of maps to fix this.

Fixes: d937bc3449fa ("bpf: make uniform use of array->elem_size everywhere =
in arraymap.c")
Signed-off-by: Rhys Rustad-Elliott <me@rhysre.net>
---
 kernel/bpf/map_in_map.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/map_in_map.c b/kernel/bpf/map_in_map.c
index 2c5c64c2a53b..cd5eafaba97e 100644
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
+=09=09inner_array_meta->elem_size =3D inner_array->elem_size;
 =09=09inner_map_meta->bypass_spec_v1 =3D inner_map->bypass_spec_v1;
-=09=09container_of(inner_map_meta, struct bpf_array, map)->index_mask =3D
-=09=09     container_of(inner_map, struct bpf_array, map)->index_mask;
 =09}
=20
 =09fdput(f);
--=20
2.40.1


