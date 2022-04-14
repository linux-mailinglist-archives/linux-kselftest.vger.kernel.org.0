Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40CCF500B93
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Apr 2022 12:53:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235449AbiDNKz4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 14 Apr 2022 06:55:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231356AbiDNKz4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 14 Apr 2022 06:55:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 11ABF6CA43
        for <linux-kselftest@vger.kernel.org>; Thu, 14 Apr 2022 03:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649933611;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=wGTC8YdoFFJEehDC62YTwnFgx/8DYsgeo2XMnZbUSUA=;
        b=B9UsGbr1yHKcCeMES06NiejPpkEXM4sW+5UVKRs7gt0za+VaUZ0biR8rx1NCfxXTGNvqIB
        X7W1/TW14hRkxEgmcWn+j/SYHgz2FjWADEwrYOqDE6TDRB1/iydze6mgcn9wgVKUyQz6oU
        Qnn9h0g3ZmUZRB3y6Q1F1JjBxW/56e8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-211-RdiYgWRjMZG0kGpwe-6ctQ-1; Thu, 14 Apr 2022 06:53:25 -0400
X-MC-Unique: RdiYgWRjMZG0kGpwe-6ctQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4F286811E7A;
        Thu, 14 Apr 2022 10:53:25 +0000 (UTC)
Received: from thuth.com (dhcp-192-232.str.redhat.com [10.33.192.232])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0987CC28114;
        Thu, 14 Apr 2022 10:53:23 +0000 (UTC)
From:   Thomas Huth <thuth@redhat.com>
To:     kvm@vger.kernel.org,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Hildenbrand <david@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Janis Schoetterl-Glausch <scgl@linux.ibm.com>
Subject: [PATCH 0/4] KVM: s390: selftests: Provide TAP output in tests
Date:   Thu, 14 Apr 2022 12:53:18 +0200
Message-Id: <20220414105322.577439-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This patch series is motivated by Shuah's suggestion here:

 https://lore.kernel.org/kvm/d576d8f7-980f-3bc6-87ad-5a6ae45609b8@linuxfoundation.org/

Many s390x KVM selftests do not output any information about which
tests have been run, so it's hard to say whether a test binary
contains a certain sub-test or not. To improve this situation let's
add some TAP output via the kselftest.h interface to these tests,
so that it easier to understand what has been executed or not.

Thomas Huth (4):
  KVM: s390: selftests: Use TAP interface in the memop test
  KVM: s390: selftests: Use TAP interface in the sync_regs test
  KVM: s390: selftests: Use TAP interface in the tprot test
  KVM: s390: selftests: Use TAP interface in the reset test

 tools/testing/selftests/kvm/s390x/memop.c     | 90 +++++++++++++++----
 tools/testing/selftests/kvm/s390x/resets.c    | 38 ++++++--
 .../selftests/kvm/s390x/sync_regs_test.c      | 86 +++++++++++++-----
 tools/testing/selftests/kvm/s390x/tprot.c     | 12 ++-
 4 files changed, 179 insertions(+), 47 deletions(-)

-- 
2.27.0

