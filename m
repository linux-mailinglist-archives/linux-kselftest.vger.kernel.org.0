Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43B1060117C
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Oct 2022 16:48:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbiJQOsI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 17 Oct 2022 10:48:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbiJQOsA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 17 Oct 2022 10:48:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 491636746C
        for <linux-kselftest@vger.kernel.org>; Mon, 17 Oct 2022 07:47:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CBD93B818FB
        for <linux-kselftest@vger.kernel.org>; Mon, 17 Oct 2022 14:47:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03557C433D6;
        Mon, 17 Oct 2022 14:47:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666018071;
        bh=HGaaOG41CsTwNR9I7wZCx6rAFooKsdSBQ3AEemjzm4k=;
        h=From:To:Cc:Subject:Date:From;
        b=rux0VwR9rOyzFDEpMgK/c6JJQ7MIKR7f+6VmDt7+FfsyHyE7ncFHtYZ9Ub5LZ1qk4
         WlJ+EwzrD9LE1HhHX86SL8TJbkCBKg3FjTtuO4fGTeFFB2dEgrijrT3vFWhl8KxBiF
         hwMyhN9KRrTf2Izd2qrHnPnVIIMNe8+5GJW0r9S2UGxdgXbLDA/qATwdAXkEdjxauH
         ZbkWWz9nalbKlKm3l2py2ZUa/b26yYBPsZD9sX32HDcCi8LjyHm6ZgxLjzKIACteR7
         EXVZf8kgbUu7CPVdwF1qxlUeh/LjU5UicxMt/LzHnL7VgBDUX5ONKLNGISayW+6t6F
         NpSq6nkOhEuvA==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH v1 0/2] kselftest/arm64: fp-stress output clarity improvements
Date:   Mon, 17 Oct 2022 15:45:51 +0100
Message-Id: <20221017144553.773176-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=527; i=broonie@kernel.org; h=from:subject; bh=HGaaOG41CsTwNR9I7wZCx6rAFooKsdSBQ3AEemjzm4k=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBjTWqeuHot/R5u37Q8NLJWqlCfa8ViAIM0JmZLi03W 1TrgYciJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCY01qngAKCRAk1otyXVSH0DSGCA CDdj8xx6rzv+kVDaOJ3kJHsFGxIvuZoWJQtoblpJDeV7ikdvQd0HcxM/mouhjaCxWrF/vMHczj2FU3 QWVod+riNbDYEq3l57GoDaVIJ2nW+s3TTW4zE9RY84Ygrd8D5CVDG0IViJc55cWAC9u00pjUzYvrox Lc6n4EuwS8FR9b0MmYnfqwY4uJSdAOXLAYuafL5QRG2/l6C4eBlCNCFX+X8G4Q/9G/35uGj7rhIwSQ ewUcKkBNL6a/iZOEW1Q+VWo5jqkAIHCkb/MIk/GRLOVLhqFv/iTRUCrFFcCYjfWKh40ZTsTWz1qF0Z vIxL+/5H097ZbJszHJqNJ09dRJ52Sm
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This series provides a couple of improvements to the output of
fp-stress, making it easier to follow what's going on and our
application of the timeout a bit more even.

Mark Brown (2):
  kselftest/arm64: Check that all children are producing output in
    fp-stress
  kselftest/arm64: Provide progress messages when signalling children

 tools/testing/selftests/arm64/fp/fp-stress.c | 26 ++++++++++++++++++++
 1 file changed, 26 insertions(+)


base-commit: 9abf2313adc1ca1b6180c508c25f22f9395cc780
-- 
2.30.2

