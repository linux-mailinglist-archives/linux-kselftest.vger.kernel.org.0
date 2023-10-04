Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A25777B7FAF
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Oct 2023 14:48:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242481AbjJDMsx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 4 Oct 2023 08:48:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242492AbjJDMsv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 4 Oct 2023 08:48:51 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E15E7C4;
        Wed,  4 Oct 2023 05:48:46 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D12F5C433C7;
        Wed,  4 Oct 2023 12:48:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696423726;
        bh=tDwOoIJ/B2p6zbJHMaqLiy/PTVxQiTe4yPxgshPYk9A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L4uwjBukmVUGsEbMlX3f/oNaINq7CZiCraPRbLyVM9PS7UUToiaWhDIPmjRBEDw0k
         7jNADEE4nVQwHp4tG+0PQozeKDGX7JebR6NBird+eR7p6fpD8c8o3EwUsXa0kUJA5r
         wnNLBgsUkVkyquQdtPcQt+fystj9PkXA2nv6j6UOIF2bpmf/KSbsA1nHKxt3qG7wlL
         CpJVzu8VRItV5Z5ZU9gQ1/ZRnjNPodeEda8ycNNV5jW/axwK06E/4CNQZi7hIZp7C+
         cFJADpOZ8Bs6RcPp3FQvdyMWfLIpg4vF7mbXhvN10LabFORCvE2VaWmgxc6gsEaMkT
         5FdZjwTCzquZw==
From:   =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
To:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org, Shuah Khan <shuah@kernel.org>
Cc:     =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
        bpf@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH 1/2] kbuild: Let builtin have precedence over modules for kselftest-merge
Date:   Wed,  4 Oct 2023 14:48:36 +0200
Message-Id: <20231004124837.56536-2-bjorn@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231004124837.56536-1-bjorn@kernel.org>
References: <20231004124837.56536-1-bjorn@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Björn Töpel <bjorn@rivosinc.com>

The kselftest-merge target walks all kselftests configs, and merges
them. However, builtin does not have precedence over modules. This
breaks some of the tests, e.g.:

$ grep CONFIG_NF_NAT tools/testing/selftests/{bpf,net}/config
tools/testing/selftests/bpf/config:CONFIG_NF_NAT=y
tools/testing/selftests/net/config:CONFIG_NF_NAT=m

Here, the net config will set NF_NAT to module, which makes it clunky
to run the BPF tests.

Add '-y' to scripts/kconfig/merge_config.sh.

Signed-off-by: Björn Töpel <bjorn@rivosinc.com>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 373649c7374e..170fb2f5e378 100644
--- a/Makefile
+++ b/Makefile
@@ -1368,7 +1368,7 @@ PHONY += kselftest-merge
 kselftest-merge:
 	$(if $(wildcard $(objtree)/.config),, $(error No .config exists, config your kernel first!))
 	$(Q)find $(srctree)/tools/testing/selftests -name config | \
-		xargs $(srctree)/scripts/kconfig/merge_config.sh -m $(objtree)/.config
+		xargs $(srctree)/scripts/kconfig/merge_config.sh -y -m $(objtree)/.config
 	$(Q)$(MAKE) -f $(srctree)/Makefile olddefconfig
 
 # ---------------------------------------------------------------------------
-- 
2.39.2

