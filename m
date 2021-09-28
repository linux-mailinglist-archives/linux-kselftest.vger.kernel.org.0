Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 271B041A87E
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Sep 2021 08:03:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239707AbhI1GFS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 28 Sep 2021 02:05:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:49598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239641AbhI1GAz (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 28 Sep 2021 02:00:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 06045613A5;
        Tue, 28 Sep 2021 05:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632808643;
        bh=e6yFJVoIJ96XBkS7+SSJkBO8zHdUj/CN3HzDX2Y/KWs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DFx1JyIDSrCAy0assFWwtkRaOKyc/NcMghjoSdUZa0d61X1zja6sMjAFyDGxmFspP
         1IpVWmecQVPtp3UeN+Me+bYcmRbAT9aMYxFdAOAVzp4DIBrZX0/AGNbHemnX7qmosF
         xZzYrqQik0kyo9THONTB/qfZVQFYXK/AQDt3GxtnXKOIsbF0tIfURzXQIzw0kCN8Ud
         rIpwJqmu2JOtWrLSeVqeLyTgA+UKpUf6W731Cd/r5Db37A/49gYx4H37VGL5BDjxcG
         VrDU0dEPid0LcDmJvGGrl1Owa8vz0bQ98q88VPLDaJ6UPZhXkMl9KEOfsGojuhkqOA
         juMHv/MhuV3nQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Li Zhijian <lizhijian@cn.fujitsu.com>,
        Philip Li <philip.li@intel.com>,
        kernel test robot <lkp@intel.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, shuah@kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 08/10] selftests: be sure to make khdr before other targets
Date:   Tue, 28 Sep 2021 01:57:14 -0400
Message-Id: <20210928055716.172951-8-sashal@kernel.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210928055716.172951-1-sashal@kernel.org>
References: <20210928055716.172951-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Li Zhijian <lizhijian@cn.fujitsu.com>

[ Upstream commit 8914a7a247e065438a0ec86a58c1c359223d2c9e ]

LKP/0Day reported some building errors about kvm, and errors message
are not always same:
- lib/x86_64/processor.c:1083:31: error: ‘KVM_CAP_NESTED_STATE’ undeclared
(first use in this function); did you mean ‘KVM_CAP_PIT_STATE2’?
- lib/test_util.c:189:30: error: ‘MAP_HUGE_16KB’ undeclared (first use
in this function); did you mean ‘MAP_HUGE_16GB’?

Although kvm relies on the khdr, they still be built in parallel when -j
is specified. In this case, it will cause compiling errors.

Here we mark target khdr as NOTPARALLEL to make it be always built
first.

CC: Philip Li <philip.li@intel.com>
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/lib.mk | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
index a5d40653a921..9700281bee4c 100644
--- a/tools/testing/selftests/lib.mk
+++ b/tools/testing/selftests/lib.mk
@@ -26,6 +26,7 @@ include $(top_srcdir)/scripts/subarch.include
 ARCH		?= $(SUBARCH)
 
 .PHONY: khdr
+.NOTPARALLEL:
 khdr:
 	make ARCH=$(ARCH) -C $(top_srcdir) headers_install
 
-- 
2.33.0

