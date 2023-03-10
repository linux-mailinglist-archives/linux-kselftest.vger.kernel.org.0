Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7622F6B50D6
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Mar 2023 20:21:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230199AbjCJTVF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 10 Mar 2023 14:21:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230089AbjCJTVE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 10 Mar 2023 14:21:04 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0507A1219FC;
        Fri, 10 Mar 2023 11:21:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 95A8861D48;
        Fri, 10 Mar 2023 19:21:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44CECC433D2;
        Fri, 10 Mar 2023 19:21:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678476063;
        bh=OPYTUHEh3fWGMz9beNtrfmOvpvbY+exzeFoxVvvoHlU=;
        h=From:To:Cc:Subject:Date:From;
        b=XRia1pWIrpsaa4D3TyRv+H4JZ/INpBgBIi6UAWXjR8wMRYHOeVuPcbxmIRYJ+HxEw
         OpmuBnJPwy+b/XBgzNS4gSOTsRcRdmtxDmKvUipE/5BmpQ6yGtjvEkI0qr7RpTXL3o
         mTdqWdd5QpoVywr9m1v4iH1udSyfN0vYHuSV0sZfQzeu+XfmBwU4Pp/4TGYfC/x4Uq
         4VJOr7+mst4J+yKLii1RbtZ6aZUu6c8tEIeTLs+NKQ1EioJ7TLoRH+rOx2GYVkt8M6
         tWWdjnKOMy33TYC8ry/H5u4Ngbhcl0z8ZRlsVpZYJQXv9Edm8R1g58uMBgYBxAEXcs
         oEwlaptNZoomA==
From:   Ross Zwisler <zwisler@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ross Zwisler <zwisler@google.com>,
        "Tobin C. Harding" <me@tobin.cc>,
        Andrew Morton <akpm@linux-foundation.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Tycho Andersen <tycho@tycho.pizza>, kvm@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH v3 0/3] use canonical ftrace path whenever possible
Date:   Fri, 10 Mar 2023 12:20:47 -0700
Message-Id: <20230310192050.4096886-1-zwisler@kernel.org>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Ross Zwisler <zwisler@google.com>

v2 here:
https://lore.kernel.org/linux-trace-kernel/20230215223350.2658616-1-zwisler@google.com/

Changes since v2:
 * Dropped patches that have been accepted into maintainer trees.
 * Collected Acked-by and Reviewed-by tags from Paolo, Mukesh and Steven.
   Thank you for the reviews!

Ross Zwisler (3):
  selftests: use canonical ftrace path
  leaking_addresses: also skip canonical ftrace path
  tools/kvm_stat: use canonical ftrace path

 scripts/leaking_addresses.pl                      |  1 +
 tools/kvm/kvm_stat/kvm_stat                       |  2 +-
 tools/testing/selftests/mm/protection_keys.c      |  4 ++--
 tools/testing/selftests/user_events/dyn_test.c    |  2 +-
 tools/testing/selftests/user_events/ftrace_test.c | 10 +++++-----
 tools/testing/selftests/user_events/perf_test.c   |  8 ++++----
 6 files changed, 14 insertions(+), 13 deletions(-)


base-commit: 55a21105ecc156495446d8ae75d7d73f66baed7b
-- 
2.40.0.rc1.284.g88254d51c5-goog

