Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 524F268CAB9
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Feb 2023 00:43:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbjBFXnu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 6 Feb 2023 18:43:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbjBFXnt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 6 Feb 2023 18:43:49 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1356521A2A;
        Mon,  6 Feb 2023 15:43:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=dQCN92gZ84v6HDSKoASE5PxXDBBa11ONqvVvpDD1xFs=; b=QDT+xtrgd8n4Pz27QVT0CFiD73
        YtM6Xxw3CiAfaXaq+kv3W9cZMmxPDYJXhA3JCSKg8cLbH2untbuQrH1E/4bVZtzmwbXEaDqgHI/ya
        8ZLorucCSuTfqnRgYfERjwSfvW+UiRGPKHyDOl1Vb4C2WRLm1KvxvTN4pp0E8toVLUbcqjolQdhK5
        DIvz+kX5bXa9H0MALjMfg7Cms8QIf+U7N7SFQcIHpA6fTfStEx5yRAZ8kuqyd5aFjc+C38QEax+eQ
        kBNksGxo9jbBXT6+AkO3MGO8HJnTrJ0CN66uSsw0ts9/nczb1CmGv10q/ig5l8R/hlm0okq1zkoN6
        5kRvyxig==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pPB9F-00ADBT-Ph; Mon, 06 Feb 2023 23:43:45 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     shuah@kernel.org, linux-kselftest@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, tiwai@suse.de, tianfei.zhang@intel.com,
        russell.h.weight@intel.com, keescook@chromium.org,
        tweek@google.com, a.manzanares@samsung.com, dave@stgolabs.net,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 0/2] selftests: bump timeout for firmware and kmod
Date:   Mon,  6 Feb 2023 15:43:42 -0800
Message-Id: <20230206234344.2433950-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Shuah,

I'd like this to go through your tree as this is timeout related.

In order to help me help developers run tests against the components
I maintain much easily I have enabled selftests support on kdevops [0].
kdevops deals with abstractsions like letting you pick virtualization
or cloud solutions to run the tests using kconfig, installs all
dependencies for you, and with just a few make target commands can get
you the latest linux-next tested against selftests.

If other find this useful and would like support for their selftests on
kdevops feel free to send patches. Eventually the idea is to be able to
run as many selftests in parallel using different guests for each main
selftest to speed up tests.

Prior to this I used to run tests manually, now the selftests helpers
are used (./tools/testing/selftests/run_kselftest.sh -s) and with this
the default selftest timeout is hit. This just increases that for the few
selftests I help maintain where obviously its not enough anymore.

Note: on the firmware side I am spotting an OOM triggered by running
tests in a loop, so far I hit in the android configuration but its
not clear if the issue is just for that setup.

[0] https://github.com/linux-kdevops/kdevops

Luis Chamberlain (2):
  selftests/kmod: increase the kmod timeout from 45 to 165
  selftests/firmware: increase timeout from 165 to 230

 tools/testing/selftests/firmware/settings | 8 +++++++-
 tools/testing/selftests/kmod/settings     | 4 ++++
 2 files changed, 11 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/kmod/settings

-- 
2.39.1

