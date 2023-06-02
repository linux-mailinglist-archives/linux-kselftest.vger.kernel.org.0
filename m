Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A6AE720971
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Jun 2023 21:02:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236128AbjFBTCJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 2 Jun 2023 15:02:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235724AbjFBTCH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 2 Jun 2023 15:02:07 -0400
Received: from mail-40136.proton.ch (mail-40136.proton.ch [185.70.40.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAAD11A5;
        Fri,  2 Jun 2023 12:02:02 -0700 (PDT)
Date:   Fri, 02 Jun 2023 19:01:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rhysre.net;
        s=protonmail2; t=1685732519; x=1685991719;
        bh=C2QS5bMur8OIlVMgvGAIQpVXbcN3hut2o7OYj0Ps85k=;
        h=Date:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
         Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
        b=hb1jDB12okjd1GZPt82WIops7vdBFZLmoGanTrvn0AQXNw8UwPZZsqoadYEZA1D+1
         04dPtrzURPVLfxxuKC+dPw+9n1OdWyYhxyv5+tmU4BNExSY7ydzBN0Crd/AaVJC+nc
         y4cewhTe2f/3qQSFIM8azsahfLh127MGHk0LKbf5IFbBxjPPb53S287UzpTph+wOmj
         emHg9gU5Jk/oM9EOlhTjat17Ny4sIS/3aC4HrSs7lDAXEJKridxySVcWOYoLpIW5bd
         JJjc4HRYyKmxa8hmC3E4kshtfn5QnU0EFXmgNy+7dULUerUsmgdVo+RNsFEKvqb3sW
         1dk8ZGwzxVzMA==
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
Subject: [PATCH bpf v2 0/2] Fix elem_size not being set for inner maps
Message-ID: <20230602190110.47068-1-me@rhysre.net>
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

This patchset sets elem_size on the bpf_array object when allocating an
array or hash of maps to fix this and adds a selftest that accesses an
array map nested within a hash of maps at a nonzero index to prevent
regressions.

v1: https://lore.kernel.org/bpf/95b5da7c-ee52-3ecb-0a4e-f6a7a114f269@linux.=
dev/

Changelog:

v1 -> v2:

Address comments by Martin KaFai Lau:
- Directly use inner_array->elem_size instead of using round_up
- Move selftests to a new patch
- Use ASSERT_* macros instead of CHECK and remove duration
- Remove unnecessary usleep
- Shorten selftest name

Rhys Rustad-Elliott (2):
  bpf: Fix elem_size not being set for inner maps
  selftests/bpf: Add access_inner_map selftest

 kernel/bpf/map_in_map.c                       |  8 +++-
 .../bpf/prog_tests/inner_array_lookup.c       | 31 +++++++++++++
 .../bpf/progs/test_inner_array_lookup.c       | 45 +++++++++++++++++++
 3 files changed, 82 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/inner_array_look=
up.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_inner_array_look=
up.c

--=20
2.40.1


