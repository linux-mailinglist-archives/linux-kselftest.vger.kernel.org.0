Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6462767122C
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Jan 2023 04:53:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbjARDw7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 17 Jan 2023 22:52:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjARDw4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 17 Jan 2023 22:52:56 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AE6B53E75;
        Tue, 17 Jan 2023 19:52:55 -0800 (PST)
From:   Thomas =?utf-8?q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
        s=mail; t=1674013973;
        bh=KpYnQTE7Q4vLwsdxk/CiqAMvN8ld8VPSFFsnhjdwuic=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=iEqeZkH/XiKYxvb2LtOoBlTVvjZA737gnaycON7XLqEdz55zqLSs1JwreM83YeQOB
         KVEmyLCjrYx/+tY0PEpz3bDvxM2BAuAp9//Kg6KIbsQeyJG/4P5LXtT9WcQnPfLkl+
         TCCZ0cfMsiM/RzE/LhzJgSW4irYaW4G9hnOmPoug=
Date:   Wed, 18 Jan 2023 03:52:19 +0000
Subject: [PATCH 2/3] bpf: iterators: align kbuild messages to standard
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Message-Id: <20230118-kbuild-alignment-v1-2-eb5e9fd55c92@weissschuh.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1674013966; l=976;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=KpYnQTE7Q4vLwsdxk/CiqAMvN8ld8VPSFFsnhjdwuic=;
 b=ub6o/8GBy8+Ikdjoq2W3KoUA+ZWNBi74hbqLchtpOsuWFSbxoJLYgi3sROXhZpJZq+b2HBhXFeHx
 4UsNeBpsBDKBPvTVpDR9YpaGW1LPntvNhJxIHIrggghl7AB3A6Ck
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
 kernel/bpf/preload/iterators/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/preload/iterators/Makefile b/kernel/bpf/preload/iterators/Makefile
index 6762b1260f2f..7c6bb9d010ca 100644
--- a/kernel/bpf/preload/iterators/Makefile
+++ b/kernel/bpf/preload/iterators/Makefile
@@ -26,7 +26,7 @@ Q =
 msg =
 else
 Q = @
-msg = @printf '  %-8s %s%s\n' "$(1)" "$(notdir $(2))" "$(if $(3), $(3))";
+msg = @printf '  %-7s %s%s\n' "$(1)" "$(notdir $(2))" "$(if $(3), $(3))";
 MAKEFLAGS += --no-print-directory
 submake_extras := feature_display=0
 endif

-- 
2.39.1
