Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EE976D3802
	for <lists+linux-kselftest@lfdr.de>; Sun,  2 Apr 2023 15:02:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230360AbjDBNCy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 2 Apr 2023 09:02:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbjDBNCx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 2 Apr 2023 09:02:53 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89F8C10A89;
        Sun,  2 Apr 2023 06:02:52 -0700 (PDT)
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1680440570;
        bh=jGJ6EiY3Winw0q2v+5CI2620DGzPf3nK0gGxSUtKjAs=;
        h=From:Subject:Date:To:Cc:From;
        b=ZJ0rL9KnuyeHKFzSy7q0YfATKGDvwG6NhfNZIpo6eVMLSBpVxTC/HDGx35OJcpTVN
         dOt5Veh2RE3nJFjsJJHOHYywE8m/Td7Wf5A4ApNajFiKg8Ga1mmQutmr3cZCXu2+mU
         VqD3EJaUTfcoTVQBx2EA2WdHEsT5Kt4JZ5CuQk/A=
Subject: [PATCH v2 0/3] tools/nolibc: add testcases for vfprintf
Date:   Sun, 02 Apr 2023 13:02:44 +0000
Message-Id: <20230328-nolibc-printf-test-v2-0-f72bdf210190@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAPR8KWQC/x2N0QqDMAwAf0XyvECNCLJfGXtoa9RAidJ0YyD++
 4KPd3DcCcZV2ODZnVD5Kya7OtCjg7xFXRlldgYKNISBJtS9SMp4VNG2YGNrGEaax5gy9f0EHqZ
 ojKlGzZun+inF5VF5kd99er2v6w9E92fReQAAAA==
To:     Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1680440570; l=1057;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=jGJ6EiY3Winw0q2v+5CI2620DGzPf3nK0gGxSUtKjAs=;
 b=UQup0goPbq+gsa8fg/qhuwxM4NAL2GpAzORdVA+22mLKPuKAXEhZvGry+MQ+s8OtuZZwKJnAN
 XZhAyWjb6a+AYDgZmaX21o86VkiuSQ/jdwpVZiftKPAW1PgRVJ/8SQJ
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

vfprintf() is complex and so far did not have proper tests.

This series is based on the "dev" branch of the RCU tree.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
Changes in v2:
- Include <sys/mman.h> for tests.
- Implement FILE* in terms of integer pointers.
- Provide fdopen() and fileno().
- Link to v1: https://lore.kernel.org/lkml/20230328-nolibc-printf-test-v1-0-d7290ec893dd@weissschuh.net/

---
Thomas Weißschuh (3):
      tools/nolibc: add wrapper for memfd_create
      tools/nolibc: implement fd-based FILE streams
      tools/nolibc: add testcases for vfprintf

 tools/include/nolibc/stdio.h                 | 60 +++++++++++----------
 tools/include/nolibc/sys.h                   | 23 ++++++++
 tools/testing/selftests/nolibc/nolibc-test.c | 78 ++++++++++++++++++++++++++++
 3 files changed, 134 insertions(+), 27 deletions(-)
---
base-commit: a63baab5f60110f3631c98b55d59066f1c68c4f7
change-id: 20230328-nolibc-printf-test-052d5abc2118

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>

