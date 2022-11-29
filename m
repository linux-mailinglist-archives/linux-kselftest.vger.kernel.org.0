Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 987E763CADC
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Nov 2022 23:00:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235992AbiK2V7i (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 29 Nov 2022 16:59:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237112AbiK2V7f (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 29 Nov 2022 16:59:35 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF5736F362
        for <linux-kselftest@vger.kernel.org>; Tue, 29 Nov 2022 13:59:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 665A4B8197E
        for <linux-kselftest@vger.kernel.org>; Tue, 29 Nov 2022 21:59:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A296EC433C1;
        Tue, 29 Nov 2022 21:59:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669759172;
        bh=6udGwnhhmnC8hQnb07bd9QEJydLU3UUA1u2UiRGtEqM=;
        h=From:To:Cc:Subject:Date:From;
        b=L5UaQ7X53RsOt6eHQsMMEQSwSpQ93o0iPavHcMVRW8CTKicJKCQa+ZhQLH8OmjUHn
         r06RDCPWBIc2j95XLZG6Tt0h5c4nGZ7jf0sjauLSvyf9r0GRgb1qAJOZV1zGaIvKUu
         FUuVn7oQBV6QzrUhDtN34G5bWdL5vnCxJyUAEKmHYrYYj3hgcnmOrhU4sEKKeXWHFv
         DPHwiAzvwTBqJ9j3pFsEpdcXDvLwmz1JKbDpEL0XYaeQRQh9wsAZNu8IkuACS7Zhfm
         mRNCaIqY0553tzRWsk+T09/hVvC4CYMjyBgr5JK6IvNCYBYkX7uTzHx893RnJ3OUdq
         YuxcfpLBhl9jg==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH v2 0/3] kselftest/arm64: fp-stress performance improvements
Date:   Tue, 29 Nov 2022 21:59:22 +0000
Message-Id: <20221129215926.442895-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=914; i=broonie@kernel.org; h=from:subject; bh=6udGwnhhmnC8hQnb07bd9QEJydLU3UUA1u2UiRGtEqM=; b=owGbwMvMwMWocq27KDak/QLjabUkhuS2hl0zGt59z1rvW9ZxVaf+yGnHvYu6b9ubzGlfZ2HZ4Mpw Q3xeJ6MxCwMjF4OsmCLL2mcZq9LDJbbOfzT/FcwgViaQKQxcnAIwkcU87H8FmFcZqTTt41c9Xu0coV C9It3dsj8wOFdeLsEie1WQ0xmWb0t1o7OWRa6ytmVjapzg76IfWvfBqPxKQtVLzQO+C5lkVihNtPJL fvFad/1qJae7NW57Dur+2mFX4zj/jUj7M/6rMoxpnGytMWZ71K96X047eXP3SekjvPq7ak/8sXj1+u 0arYzZDm8NDOV2Kq2fyjgjV2Tt+cfNJw5zMrbPjdjfaf9O3f7IKS/Pl492n3k991Kmat1NVSfpT3f+ ik9ljvaOn+YZ73EluffvXd+cUMO79QWFTovfFrseXHls/qv+Zxu5X821PMfNddEnvz9X0kAzfPon+Q 8nvW4ftRSfo6dm4mW4SVscaJw6AA==
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This series contains a few improvements to fp-stress performance, only
noticable on emulated platforms which both run more slowly and are
stressed far more by fp-stress due to supporting more VLs for SVE and
SME.  The bulk of the improvement comes from the first patch which
reduces the amount of time the main fp-stress executable is swamped by
load from the child processes during startup, the other two patches are
much more marginal.

v2:
 - Rebase onto arm64/for-next/selftests

Mark Brown (3):
  kselftest/arm64: Hold fp-stress children until they're all spawned
  kselftest/arm64: Don't drain output while spawning children
  kselftest/arm64: Allow epoll_wait() to return more than one result

 tools/testing/selftests/arm64/fp/fp-stress.c | 74 +++++++++++++++-----
 1 file changed, 57 insertions(+), 17 deletions(-)


base-commit: 642978981ec8a79da00828c696c58b3732b993a6
-- 
2.30.2

