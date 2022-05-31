Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E88A538E9A
	for <lists+linux-kselftest@lfdr.de>; Tue, 31 May 2022 12:16:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245561AbiEaKQH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 31 May 2022 06:16:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245518AbiEaKQF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 31 May 2022 06:16:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DE5AD5D5D1
        for <linux-kselftest@vger.kernel.org>; Tue, 31 May 2022 03:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653992162;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=M1kB8ZZo8rCb8OUyXMF5UTU/yK+Hwc81SWjBycNX2aY=;
        b=XwmOhP0ujHNdpzemRqeWLlZsi9jGn+QmnVGytgXVK2djY1o+Qt0XhxVXUQfgRXoMe2v804
        dPK1M9Qw2bAv0xz2+jhXTumwTanMXAdYDAmvup5hNwri4PnsSKxfqjQEPBzjOGCl+B5unF
        zAEw1PvIF2tUjOgLCoAZGvK6VNlKsKQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-615-Ej3U1626PNedjkFLRq1Vcg-1; Tue, 31 May 2022 06:15:59 -0400
X-MC-Unique: Ej3U1626PNedjkFLRq1Vcg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BC9C0811E81;
        Tue, 31 May 2022 10:15:58 +0000 (UTC)
Received: from thuth.com (unknown [10.39.194.45])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7B226492C3B;
        Tue, 31 May 2022 10:15:56 +0000 (UTC)
From:   Thomas Huth <thuth@redhat.com>
To:     kvm@vger.kernel.org,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Hildenbrand <david@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Janis Schoetterl-Glausch <scgl@linux.ibm.com>,
        linux-s390@vger.kernel.org
Subject: [PATCH v4 0/4] KVM: s390: selftests: Provide TAP output in tests
Date:   Tue, 31 May 2022 12:15:50 +0200
Message-Id: <20220531101554.36844-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
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

v4:
 - Rebased to include test_termination() now in the memop test
 - Reworked the extension capability check in the memop test

v3:
 - Added comments / fixed cosmetics according to Janosch's and
   Janis' reviews of the v2 series
 - Added Reviewed-by tags from the v2 series

v2:
 - Reworked the extension checking in the first patch
 - Make sure to always print the TAP 13 header in the second patch
 - Reworked the SKIP printing in the third patch

Thomas Huth (4):
  KVM: s390: selftests: Use TAP interface in the memop test
  KVM: s390: selftests: Use TAP interface in the sync_regs test
  KVM: s390: selftests: Use TAP interface in the tprot test
  KVM: s390: selftests: Use TAP interface in the reset test

 tools/testing/selftests/kvm/s390x/memop.c     | 95 +++++++++++++++----
 tools/testing/selftests/kvm/s390x/resets.c    | 38 ++++++--
 .../selftests/kvm/s390x/sync_regs_test.c      | 87 +++++++++++++----
 tools/testing/selftests/kvm/s390x/tprot.c     | 29 +++++-
 4 files changed, 197 insertions(+), 52 deletions(-)

-- 
2.31.1

