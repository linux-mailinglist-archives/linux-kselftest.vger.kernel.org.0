Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1AFD68CAB5
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Feb 2023 00:43:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbjBFXnt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 6 Feb 2023 18:43:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjBFXns (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 6 Feb 2023 18:43:48 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1292E93EC;
        Mon,  6 Feb 2023 15:43:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=7LhKrP+OMnczNpnIjHIKtPU0AEjCEtO5qg7hH6vxr+s=; b=1z526e5murJWIxQeGB/3s3xANE
        Z3s2q2JmA4TfkjPbb4b8CK0K2MellrJqP4TJqqoUbd/Ctv+IroFwBFakqjwDXO+dFkvTU6LRIvAtK
        BlsS5Ce+u0MvtE9DiY5ad98uqefmBhoOuKNMUX+o2hlwwCSAIkJsXrwdjQW4u8orw4FxS27kaO/fY
        xQakzMql2j8TCi0wRHi7rJpLVqFdwq1uH5Ny70o5zDm1V5j2SnbiwObPoIgOAXkw7ZJmgVXxVPLkY
        kCg9bgL7O+nEEE7oaXqJ3gPae0bo/0p3Lm021bCZqz20wUjgNlvOCS9+CnEtN+x8jBZ7HihdInBWB
        SFup6RIw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pPB9F-00ADBV-SJ; Mon, 06 Feb 2023 23:43:45 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     shuah@kernel.org, linux-kselftest@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, tiwai@suse.de, tianfei.zhang@intel.com,
        russell.h.weight@intel.com, keescook@chromium.org,
        tweek@google.com, a.manzanares@samsung.com, dave@stgolabs.net,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 1/2] selftests/kmod: increase the kmod timeout from 45 to 165
Date:   Mon,  6 Feb 2023 15:43:43 -0800
Message-Id: <20230206234344.2433950-2-mcgrof@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230206234344.2433950-1-mcgrof@kernel.org>
References: <20230206234344.2433950-1-mcgrof@kernel.org>
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

The default sefltests timeout is 45 seconds. If you run the kmod
selftests on your own with say:

./tools/testings/selftests/kmod.sh

Then the default timeout won't be in effect.

I've never ran kmod selftests using the generic make wrapper
(./tools/testing/selftests/run_kselftest.sh -s) util now
that I have support for it on kdevops [0]. And with that the
test is limitted to the default timeout which we quickly run
into. Bump this up to what I see is required on 8GiB / 8 vcpu
libvirt q35 guest as can be easily created now with kdevops.

To run selftests with kdevops:

make menuconfig # enable dedicated selftests and kmod test
make
make bringup
make linux
make selftests-kmod

This ends up taking about 280 seconds now, give or take add
50 seconds more more and we end up with 350. Document the
rationale.

[0] https://github.com/linux-kdevops/kdevops
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 tools/testing/selftests/kmod/settings | 4 ++++
 1 file changed, 4 insertions(+)
 create mode 100644 tools/testing/selftests/kmod/settings

diff --git a/tools/testing/selftests/kmod/settings b/tools/testing/selftests/kmod/settings
new file mode 100644
index 000000000000..6fca0f1a4594
--- /dev/null
+++ b/tools/testing/selftests/kmod/settings
@@ -0,0 +1,4 @@
+# measured from a manual run:
+# time ./tools/testing/selftests/kmod/kmod.sh
+# Then add ~50 seconds more gracetime.
+timeout=350
-- 
2.39.1

