Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F2954712F1
	for <lists+linux-kselftest@lfdr.de>; Sat, 11 Dec 2021 09:49:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbhLKItf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 11 Dec 2021 03:49:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbhLKItf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 11 Dec 2021 03:49:35 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A0FEC061746
        for <linux-kselftest@vger.kernel.org>; Sat, 11 Dec 2021 00:49:35 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id g25-20020a25b119000000b005c5e52a0574so20851704ybj.5
        for <linux-kselftest@vger.kernel.org>; Sat, 11 Dec 2021 00:49:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=SrNa6exOHutT9geCBxzlhw7Uajzqri7l4YdB9tBFads=;
        b=GPEel5AcZBhdC3IwbTcZBfQcaGHipcfdC1f7PADb1EnkVRN4MAO3BFaSTtKl7nh+jG
         eRSL76x2ZdwB+AqMJ7Te02wIrOhxklbALNaj2k1RyPGvy5C118/Q47nVgNUv3jvi9RdW
         9HvE4r6rrUZ23VFOQd0nvFr5ph/vUnMEsc7Z1yyR5G/eQK+CtX4oUC7FY4x7d+v5CuvO
         UcQagyiHHmwmn/yITvZarTOX+ibhEbVRficV+vwcSepfvt7gcm3Q1ahkxYxpQLfdTGwO
         TTe5H0yZwZ1C5ZGQSDeLFIGclrvnIO6otVzKQqDgga3lNx2tsDeA0vzugijZe4JWtR3C
         +ycw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=SrNa6exOHutT9geCBxzlhw7Uajzqri7l4YdB9tBFads=;
        b=US15sFO8ebbhxyUE4tE0gAtgvrrWp+aSfwPuAvrdMqMvtywPd72Ndc7CRcsmAoVPGn
         s0HRvPLRTDkZQQK8k6xmcC57dhlkvd/hz8f3LNw583ovGeAxnjjqNTbGqi/QESB8zrgK
         x8vxobvTZe91LCIUdxlNCFWyd/dyrDCYD4Idq6Ex8K2PLVCy2n23pO9wbHz2ELS2a/y3
         AAoTCdFCjkAxrU4gFJ2+h7NbO/i/sQaQFTwaxIzyGO81/rl8akUSqjqtyrV+GyeLBqYW
         ysi/LuTweXceNE94ek8ujDfAbq7KdfkIxnLDbDFpEAwir8z3LD5TbckOmrR71vlFoaWq
         vffA==
X-Gm-Message-State: AOAM531MPa58UBevJe3akp7+TNzauY+eVZqAB0zmxJWg1vOEejwZ9N6a
        0Msam2p5sv6NcQnRaQzKvZmeawg4BpYLpw==
X-Google-Smtp-Source: ABdhPJxbvkfX1BIPcCXSGvyHbXF8UF5q5bOpkmkwWeHhRSXRyVU6mjxtQ/urM4KvPuCKzoI5DB5cPgxAhoGO1w==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a25:ac24:: with SMTP id
 w36mr19470213ybi.118.1639212574168; Sat, 11 Dec 2021 00:49:34 -0800 (PST)
Date:   Sat, 11 Dec 2021 08:49:28 +0000
Message-Id: <20211211084928.410669-1-davidgow@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
Subject: [PATCH] kunit: tool: Default --jobs to number of CPUs
From:   David Gow <davidgow@google.com>
To:     Brendan Higgins <brendanhiggins@google.com>,
        Daniel Latypov <dlatypov@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     David Gow <davidgow@google.com>, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The --jobs parameter for kunit_tool currently defaults to 8 CPUs,
regardless of the number available. For systems with significantly more
(or less), this is not as efficient. Instead, default --jobs to the
number of CPUs present in the system: while there are as many
superstitions as to exactly what the ideal jobs:CPU ratio is, this seems
sufficiently sensible to me.

Signed-off-by: David Gow <davidgow@google.com>
---
 tools/testing/kunit/kunit.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
index 68e6f461c758..2cb6c7db5683 100755
--- a/tools/testing/kunit/kunit.py
+++ b/tools/testing/kunit/kunit.py
@@ -310,7 +310,7 @@ def add_build_opts(parser) -> None:
 	parser.add_argument('--jobs',
 			    help='As in the make command, "Specifies  the number of '
 			    'jobs (commands) to run simultaneously."',
-			    type=int, default=8, metavar='jobs')
+			    type=int, default=os.cpu_count(), metavar='jobs')
 
 def add_exec_opts(parser) -> None:
 	parser.add_argument('--timeout',
-- 
2.34.1.173.g76aa8bc2d0-goog

