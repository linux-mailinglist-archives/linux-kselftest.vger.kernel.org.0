Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFD8B6FD0EA
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 May 2023 23:21:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235910AbjEIVVS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 9 May 2023 17:21:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235904AbjEIVU3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 9 May 2023 17:20:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5A4359CB;
        Tue,  9 May 2023 14:20:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D5FA563738;
        Tue,  9 May 2023 21:20:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3D66C43446;
        Tue,  9 May 2023 21:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683667202;
        bh=djH6aZW19S3vEZiHpsXq509OwDWDfSJMc0qTNyzHOh0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HSL4Usxfvc0EcUjWOTzv/tcG5QO7uMRB3H6uA3lq7oNCM2F7OBaCMbYT5Zumdq5vt
         aOHsW5Dq1ij6LvgSS7bewnDp7dQOJ0yYOYJpPBIDYlwG/mjGBpaGBY1NTnJ+4uUYmW
         ux+qQvm2JpwJpc7Am6zCm6rHfpCaI0piEcP5XrqhquThgPXjdOravBCv7iCgSWop5y
         H40XWvsRyfUlu4WNkyeTTA1LaC8tCteYV6yF3BvcHWTQklgxIUVfrXCjW8mXXR59ST
         RGwSvqW7f2TiPTKynROr/fTWlmV1mn0x7Sh7U+FcDElE8GGsihWdNX7loy2MhlFCOd
         5t2reQkciO/Dg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ivan Orlov <ivan.orlov0322@gmail.com>,
        Sean Christopherson <seanjc@google.com>,
        Sasha Levin <sashal@kernel.org>, pbonzini@redhat.com,
        shuah@kernel.org, dmatlack@google.com, vannapurve@google.com,
        kvm@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH AUTOSEL 6.2 02/18] KVM: selftests: Add 'malloc' failure check in vcpu_save_state
Date:   Tue,  9 May 2023 17:19:40 -0400
Message-Id: <20230509211958.21596-2-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230509211958.21596-1-sashal@kernel.org>
References: <20230509211958.21596-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Ivan Orlov <ivan.orlov0322@gmail.com>

[ Upstream commit 735b0e0f2d001b7ed9486db84453fb860e764a4d ]

There is a 'malloc' call in vcpu_save_state function, which can
be unsuccessful. This patch will add the malloc failure checking
to avoid possible null dereference and give more information
about test fail reasons.

Signed-off-by: Ivan Orlov <ivan.orlov0322@gmail.com>
Link: https://lore.kernel.org/r/20230322144528.704077-1-ivan.orlov0322@gmail.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/kvm/lib/x86_64/processor.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/kvm/lib/x86_64/processor.c b/tools/testing/selftests/kvm/lib/x86_64/processor.c
index acfa1d01e7df0..d9365a9d1c490 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/processor.c
@@ -950,6 +950,7 @@ struct kvm_x86_state *vcpu_save_state(struct kvm_vcpu *vcpu)
 	vcpu_run_complete_io(vcpu);
 
 	state = malloc(sizeof(*state) + msr_list->nmsrs * sizeof(state->msrs.entries[0]));
+	TEST_ASSERT(state, "-ENOMEM when allocating kvm state");
 
 	vcpu_events_get(vcpu, &state->events);
 	vcpu_mp_state_get(vcpu, &state->mp_state);
-- 
2.39.2

