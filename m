Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CFC2592FE2
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Aug 2022 15:27:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231461AbiHON0t (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 15 Aug 2022 09:26:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241665AbiHON0k (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 15 Aug 2022 09:26:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 271AA1F2E5
        for <linux-kselftest@vger.kernel.org>; Mon, 15 Aug 2022 06:26:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CEB14B80EB7
        for <linux-kselftest@vger.kernel.org>; Mon, 15 Aug 2022 13:26:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B2C7C433C1;
        Mon, 15 Aug 2022 13:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660569997;
        bh=hQtpv+f9/lUjYTQ+EmlG0no7n45aG9wRUp5mFMa3zYU=;
        h=From:To:Cc:Subject:Date:From;
        b=np/5jRSEd+Fe8EI7+pi/E9U+IA1OpnIJdzVQ9G1cZIsOeQXAHHZo7axRE7nZSgvKk
         ER9zTYOAZQcvk4wy7v4o4MTfbdiAFhmUFyvf3QOLKEATBrJWbSgxJhHZ5ulpc7r9VU
         g22n+kPhrObITCLdtfxDk/lR/1+jpeoQ7YpisPqcrXRY8LH9MB3SFzxIi37jwNUQM/
         Ga/f+Y4c7Qd75z25/pQsWGGXlVpY18NAy0Qfkcrye2Vbisj4mmZstW9Mn6QHG/ggH8
         EgzdcAXQQeQaar6F21ShhWdapc6c8LikNz7BkIa+Yco3hzSxEvW6AnrSljZrkafozM
         XjdABSIuBs56Q==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc:     Marc Zyngier <maz@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Zhang Lei <zhang.lei@jp.fujitsu.com>,
        linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH v2 0/3] arm64/sve: Document our actual SVE syscall ABI
Date:   Mon, 15 Aug 2022 14:26:19 +0100
Message-Id: <20220815132622.220118-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1290; i=broonie@kernel.org; h=from:subject; bh=hQtpv+f9/lUjYTQ+EmlG0no7n45aG9wRUp5mFMa3zYU=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBi+kl69Q8hVlkFldjqsWyhIA+3Qk2Gw8isfOOuNKMi 6TJWfxaJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYvpJegAKCRAk1otyXVSH0NLiB/ 4nYnwb1DbbiC/St7K0DinUvXHbOeccOmvFTZSRqyYuJzUBj1ZqbEu8AsbrUAWJ1O7iLkunHwMb82PG JCjmZVT4ERJfCFx8DeSHYAj5KY+e302+eX/jDZQWU+/l1WIpGDdLh1pqe40G5fB3UmqhIZjbATVW6a KBQMUdS5jvfRI4JxQ+hySb4+6WgqfnCHDgLbPjkVi24fxEmurkLprkvHTcB+VQtEQ/wJ38aBlS2iYR CZ+r8DhWgOT+J1+4gEpaow46vGptW7sOCSvTRJ/FFKWNgKOGxJEcO2RtPa47CmTvA/CAiqmtq3lbJ4 Vn36KEGqOdlk+PO8UfZra+pnpTvSHH
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Currently our SVE syscall ABI documentation does not reflect the actual
implemented ABI, it says that register state not shared with FPSIMD
becomes undefined on syscall when in reality we always clear it. Since
changing this would cause a change in the observed kernel behaviour
there is a substantial desire to avoid taking advantage of the
documented ABI so instead let's document what we actually do so it's
clear that it is in reality an ABI.

There has been some pushback on tightening the documentation in the past
but it is hard to see who that helps, it makes the implementation
decisions less clear and makes it harder for people to discover and make
use of the actual ABI. The main practical concern is that qemu's user
mode does not currently flush the registers.

v2:
 - Rebase onto v6.0-rc1.

Mark Brown (3):
  kselftest/arm64: Correct buffer allocation for SVE Z registers
  arm64/sve: Document our actual ABI for clearing registers on syscall
  kselftest/arm64: Enforce actual ABI for SVE syscalls

 Documentation/arm64/sve.rst                   |  2 +-
 .../testing/selftests/arm64/abi/syscall-abi.c | 61 ++++++++++++-------
 2 files changed, 41 insertions(+), 22 deletions(-)


base-commit: 568035b01cfb107af8d2e4bd2fb9aea22cf5b868
-- 
2.30.2

