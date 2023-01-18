Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9BF967122A
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Jan 2023 04:53:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbjARDw6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 17 Jan 2023 22:52:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjARDw4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 17 Jan 2023 22:52:56 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D83B53F81;
        Tue, 17 Jan 2023 19:52:55 -0800 (PST)
From:   Thomas =?utf-8?q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
        s=mail; t=1674013973;
        bh=1RCqqZydnDFaJZOYxPVplOG7gSvedFP5vnvPdym2MNk=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=Oom12uDZEeK8c+uFQ7KYGYIyqHwcp2ZSwuXw7cXNu1ulczqYtzPUedbNlUtbhXorS
         NNz13CSPU4OR/twlvI7sJU07iPrAerurNNi9NUFVMJhBO3SizaACCeic5Qa1PVyVQe
         p2NrPcgUx+e3HFDPLrI3DnZ5Nv6JhUEReLHYoEx4=
Date:   Wed, 18 Jan 2023 03:52:20 +0000
Subject: [PATCH 3/3] tools/resolve_btfids: align kbuild messages to standard
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Message-Id: <20230118-kbuild-alignment-v1-3-eb5e9fd55c92@weissschuh.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1674013966; l=957;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=1RCqqZydnDFaJZOYxPVplOG7gSvedFP5vnvPdym2MNk=;
 b=Obt7j+FeHbwpRmVExoT9rOQOGNSXFjjaJMIksWp8W4sLuwDgrtpS2uqhIZKLUmb7QDAzdQ95cWPM
 1Nksn1MlA61vBpCC2W73X/bGlu6pKqSBkOEDVsLjkbDgtHP1BCwG
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
 tools/bpf/resolve_btfids/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/bpf/resolve_btfids/Makefile b/tools/bpf/resolve_btfids/Makefile
index 19a3112e271a..f4106d514b9c 100644
--- a/tools/bpf/resolve_btfids/Makefile
+++ b/tools/bpf/resolve_btfids/Makefile
@@ -12,7 +12,7 @@ else
   ifeq ($(silent),1)
     msg =
   else
-    msg = @printf '  %-8s %s%s\n' "$(1)" "$(notdir $(2))" "$(if $(3), $(3))";
+    msg = @printf '  %-7s %s%s\n' "$(1)" "$(notdir $(2))" "$(if $(3), $(3))";
   endif
   MAKEFLAGS=--no-print-directory
 endif

-- 
2.39.1
