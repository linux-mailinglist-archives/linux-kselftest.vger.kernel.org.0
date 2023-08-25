Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0D5D78822F
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Aug 2023 10:37:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232097AbjHYIgp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 25 Aug 2023 04:36:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243164AbjHYIgl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 25 Aug 2023 04:36:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 596971FF2;
        Fri, 25 Aug 2023 01:36:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DEA6E658D7;
        Fri, 25 Aug 2023 08:36:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65603C433C8;
        Fri, 25 Aug 2023 08:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692952598;
        bh=A5qs9JLQ8UvtNLpXY7FnhnNvX77wp2ipfpBxERGZ0DQ=;
        h=From:Subject:Date:To:Cc:From;
        b=HvOz4rwJL/x0ecFpDxN5vAg8/6JN3zZv20FLAsu9vbn+tje/ztTo1Gt14JbZmoBrE
         C75n0hsd6Z4+EZ/VJKTtCSyvW/bHdHsbb+SMZ3oOyqwLwIBpVvRs93ot5T3SMTQmY5
         VVbyCHDekfqgLPwixxXfwoh2gnPc5ENzWAqRL68tiE35kYF4HG54Yn2CNy5FVW/XW0
         TWmLb0NF9vmGaXV9sG5617ydGVzzLRMz8XzMeEwJppCZ6PkLRW1oX57+zY0K9o7Hcg
         NQZyvRqI2v6sBx0bjc9E0+LjQJMGk50YSGGD1Rug0OYQEdG8VdQXBNMy33WZNzI18V
         N3IvKiVyAABEA==
From:   Benjamin Tissoires <bentiss@kernel.org>
Subject: [PATCH 0/3] selftests/hid: assorted fixes
Date:   Fri, 25 Aug 2023 10:36:30 +0200
Message-Id: <20230825-wip-selftests-v1-0-c862769020a8@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAA5o6GQC/x2N0QqDMAwAf0XyvECXrbrtV4YPrUYNlE4a5wbiv
 xt8vIPjNlAuwgqvaoPCq6h8ssH1UkE3hTwySm8M5OjmHuTxJzMqp2FhXRSfofGOoq/9ncCaGJQ
 xlpC7yar8TcnkXHiQ/zl5t/t+APSVCmB0AAAA
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Justin Stitt <justinstitt@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     linux-input@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        Benjamin Tissoires <bentiss@kernel.org>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1692952596; l=1243;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=A5qs9JLQ8UvtNLpXY7FnhnNvX77wp2ipfpBxERGZ0DQ=;
 b=ccYwms0vlpIn6jUy7zMtCp+W+bFOYkfXtsYzeRxpiTh+0dOvS360JPafsrpoGqK9jTaBb/dkO
 uvGOfqXkW3eD9VuPRFtLdQeuXGqamhivrK9sv8wWuyN00IDnsGawhkQ
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

These fixes have been triggered by [0]:
basically, if you do not recompile the kernel first, and are
running on an old kernel, vmlinux.h doesn't have the required
symbols and the compilation fails.

The tests will fail if you run them on that very same machine,
of course, but the binary should compile.

And while I was sorting out why it was failing, I realized I
could do a couple of improvements on the Makefile.

[0] https://lore.kernel.org/linux-input/56ba8125-2c6f-a9c9-d498-0ca1c153dcb2@redhat.com/T/#t

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
---
Benjamin Tissoires (3):
      selftests/hid: ensure we can compile the tests on kernels pre-6.3
      selftests/hid: do not manually call headers_install
      selftests/hid: force using our compiled libbpf headers

 tools/testing/selftests/hid/Makefile                | 10 ++++------
 tools/testing/selftests/hid/progs/hid.c             |  3 ---
 tools/testing/selftests/hid/progs/hid_bpf_helpers.h | 20 ++++++++++++++++++++
 3 files changed, 24 insertions(+), 9 deletions(-)
---
base-commit: 1d7546042f8fdc4bc39ab91ec966203e2d64f8bd
change-id: 20230825-wip-selftests-9a7502b56542

Best regards,
-- 
Benjamin Tissoires <bentiss@kernel.org>

