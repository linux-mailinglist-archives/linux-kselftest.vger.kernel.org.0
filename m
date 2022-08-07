Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCC0958BB43
	for <lists+linux-kselftest@lfdr.de>; Sun,  7 Aug 2022 16:29:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232569AbiHGO3F (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 7 Aug 2022 10:29:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233894AbiHGO3E (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 7 Aug 2022 10:29:04 -0400
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [IPv6:2a0c:5a00:149::26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E33426461
        for <linux-kselftest@vger.kernel.org>; Sun,  7 Aug 2022 07:29:01 -0700 (PDT)
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
        by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <mhal@rbox.co>)
        id 1oKhH1-007poH-Ba; Sun, 07 Aug 2022 16:28:59 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
        s=selector1; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject
        :Cc:To:From; bh=hU8RmU3mC43bYO/3II8WhH3BjhmQ39MPcPi1Fs4z90o=; b=kdGHXWPABwzkv
        snV9+B7bi8mk0yStz3gU1V8mWdloaNsP+AcqnU94TPhO1Ks7XysD+pvgTR6Vi4NcbhtKCGhDOmRYB
        ZJtQQalEPmlre/thYvya302UEd+uJ+C3kWY5l2y7qsFR1S2CHZxzKyQfyL5dvn8RIV0YJqiRVF1T8
        V1nsqD6ZqrV9jpFTJ3biNFl3sFyarGJY/XJmJvZlY04pSDtjd1jLc9fhuxV6PDk1ssVcGU7jM0Bfg
        vTqRpVreOAA0Qj9gegx2O5E95m7xLUo5Pj0ZY+BJUb2PQZ5B69IbxLzMJhYI2kOTH6H/kk8Cocn2j
        BPcZiYWIrWyg5TA47nfSg==;
Received: from [10.9.9.74] (helo=submission03.runbox)
        by mailtransmit02.runbox with esmtp (Exim 4.86_2)
        (envelope-from <mhal@rbox.co>)
        id 1oKhH1-0007k8-0P; Sun, 07 Aug 2022 16:28:59 +0200
Received: by submission03.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.90_1)
        id 1oKhGh-0002az-98; Sun, 07 Aug 2022 16:28:39 +0200
From:   Michal Luczaj <mhal@rbox.co>
To:     seanjc@google.com
Cc:     kvm@vger.kernel.org, pbonzini@redhat.com, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, mhal@rbox.co
Subject: [kvm-unit-tests PATCH v2 0/5] Test for illegal LEA & related fixes
Date:   Sun,  7 Aug 2022 16:28:27 +0200
Message-Id: <20220807142832.1576-1-mhal@rbox.co>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Is this a correct way to put Sean's and Paolo's patches into this
series? I wasn't sure which patches are accepted or what is the current
base-commit, but I haven't seen the tip of kvm-unit-tests repo moving,
so here is it.

Michal Luczaj (3):
  x86: emulator.c cleanup: Save and restore exception handlers
  x86: emulator.c cleanup: Use ASM_TRY() for the UD_VECTOR cases
  x86: Test emulator's handling of LEA with /reg

Paolo Bonzini (1):
  x86: Introduce ASM_TRY_FEP() to handle exceptions thrown by
    FEP-triggered emulator

Sean Christopherson (1):
  x86: Dedup 32-bit vs. 64-bit ASM_TRY() by stealing kernel's
    __ASM_SEL()

 lib/x86/desc.h      |  22 +++----
 lib/x86/processor.h |  12 ++++
 x86/emulator.c      | 136 ++++++++++++++++++++++++--------------------
 3 files changed, 93 insertions(+), 77 deletions(-)

-- 
2.37.1

