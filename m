Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4E60671227
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Jan 2023 04:52:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbjARDw5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 17 Jan 2023 22:52:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjARDw4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 17 Jan 2023 22:52:56 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3655353B11;
        Tue, 17 Jan 2023 19:52:54 -0800 (PST)
From:   Thomas =?utf-8?q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
        s=mail; t=1674013973;
        bh=LeJ7gI3yR8MhBw3LdfOaYZv4aNx3sO+fd4js1DkSvTk=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=aumQF/TcOjSY7DpoHL3bnZxTpOw/p54FeLWG97HAHPjnEQg+txWdK/gPtO0W6i45g
         ttGko7iGFV+IRqIv/PWxgpsZFqZQVDNc4k2SWr8vmNOvUmmXwOINTXMuRB6Uib9wS+
         +vs31as6Dd2UkdP8QgBGnOGSI94HSa1ddvleySLE=
Date:   Wed, 18 Jan 2023 03:52:18 +0000
Subject: [PATCH 1/3] selftests/bpf: align kbuild messages to standard
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Message-Id: <20230118-kbuild-alignment-v1-1-eb5e9fd55c92@weissschuh.net>
References: <20230118-kbuild-alignment-v1-0-eb5e9fd55c92@weissschuh.net>
In-Reply-To: <20230118-kbuild-alignment-v1-0-eb5e9fd55c92@weissschuh.net>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>
Cc:     bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        Thomas =?utf-8?q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.11.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1674013966; l=1017;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=LeJ7gI3yR8MhBw3LdfOaYZv4aNx3sO+fd4js1DkSvTk=;
 b=tBkx8uRJ5OT383z4h0Cc9/q/mtXjwWDwrQNqqqE2xzO28njGH8YjaQGfK9uXkZWjeYduZGVCJKh+
 gjzRUk+FDKlW2QIxzV1YJHjlJpynKpzqgtgWZbeHfRXVfDgDKrQT
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The common layout for kbuild messages is as follows:

- 2 spaces
- 7 or more characters for the action
- 1 space
- name of the file being built/generated

The custom message formatting included an additional space in the action
part, which leads to misalignments with the rest of kbuild.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/testing/selftests/bpf/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index c22c43bbee19..5190c19295d4 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -98,7 +98,7 @@ Q =
 msg =
 else
 Q = @
-msg = @printf '  %-8s%s %s%s\n' "$(1)" "$(if $(2), [$(2)])" "$(notdir $(3))" "$(if $(4), $(4))";
+msg = @printf '  %-7s%s %s%s\n' "$(1)" "$(if $(2), [$(2)])" "$(notdir $(3))" "$(if $(4), $(4))";
 MAKEFLAGS += --no-print-directory
 submake_extras := feature_display=0
 endif

-- 
2.39.1
