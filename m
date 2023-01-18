Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD95F67122F
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Jan 2023 04:53:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbjARDxA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 17 Jan 2023 22:53:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjARDw4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 17 Jan 2023 22:52:56 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71FF653F88;
        Tue, 17 Jan 2023 19:52:55 -0800 (PST)
From:   Thomas =?utf-8?q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
        s=mail; t=1674013973;
        bh=VPkw+CFKrjA0cPdq/u5VGCcCh6yOS2YGYVj7RG8ao0M=;
        h=From:Subject:Date:To:Cc:From;
        b=p5O0dSUSIlG0xpmCHxE0f1bI59w7GlMpK9kZrIo7JRdgikFFJ4FEXPnV50yY0Qzsp
         WocB82jcdn1s7N6J5poR93NuMfKakRdaaLusDl5SD6Tgl8TAb+OvbcsB5iKqdyo/HE
         u5i7xMBNz3LlEboiBCrNYZ1EFK58IMW2Tnqw6xMs=
Subject: [PATCH 0/3] align custom kbuild messages to standard layout
Date:   Wed, 18 Jan 2023 03:52:18 +0000
Message-Id: <20230118-kbuild-alignment-v1-0-eb5e9fd55c92@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAPJsx2MC/x2NwQrCQAwFf6XkbKBbsVR/RTxkt882uEbZbUUo/
 XeDxxkYZqOKoqh0aTYq+GjVlzmEQ0NpFpvAOjpT13bHNoSBH3HVPLJknewJWzhJSDgPkFPfk2dR
 KjgWsTR7aGvOLt8Fd/3+P9fbvv8AR1Hu43cAAAA=
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1674013966; l=1603;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=VPkw+CFKrjA0cPdq/u5VGCcCh6yOS2YGYVj7RG8ao0M=;
 b=fzmaTIEzM9UNJhAR0rXp3b0cFQKR+SxGqJl9VLhfb1aUxF6s7omM/5KFmqCI8bOn7FENNaqQsXma
 n3rnz0yeDjZU5Yq/QR2E3mnRHqwho7sgbw1BolMcTyPL9VZMdQTW
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

To: Alexei Starovoitov <ast@kernel.org>
To: Daniel Borkmann <daniel@iogearbox.net>
To: Andrii Nakryiko <andrii@kernel.org>
To: Martin KaFai Lau <martin.lau@linux.dev>
To: Song Liu <song@kernel.org>
To: Yonghong Song <yhs@fb.com>
To: John Fastabend <john.fastabend@gmail.com>
To: KP Singh <kpsingh@kernel.org>
To: Stanislav Fomichev <sdf@google.com>
To: Hao Luo <haoluo@google.com>
To: Jiri Olsa <jolsa@kernel.org>
To: Mykola Lysenko <mykolal@fb.com>
To: Shuah Khan <shuah@kernel.org>
Cc: bpf@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: linux-kbuild@vger.kernel.org
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>

---
Thomas Weißschuh (3):
      selftests/bpf: align kbuild messages to standard
      bpf: iterators: align kbuild messages to standard
      tools/resolve_btfids: align kbuild messages to standard

 kernel/bpf/preload/iterators/Makefile | 2 +-
 tools/bpf/resolve_btfids/Makefile     | 2 +-
 tools/testing/selftests/bpf/Makefile  | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)
---
base-commit: c1649ec55708ae42091a2f1bca1ab49ecd722d55
change-id: 20230118-kbuild-alignment-ca1ce98ea566

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>
