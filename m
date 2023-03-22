Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FC8C6C4E64
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Mar 2023 15:48:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231887AbjCVOsH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 22 Mar 2023 10:48:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231543AbjCVOrx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 22 Mar 2023 10:47:53 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D42A21E5F3;
        Wed, 22 Mar 2023 07:46:28 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id cn12so28334510edb.4;
        Wed, 22 Mar 2023 07:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679496334;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rLmkUGsjVKN4NZf9Xwc68SFWMoDmXlx37mUEv+QwNDs=;
        b=SfTs+c817QkFkmtH//ktryjgBJ3/o2Pj5C9ikp9Le++n2Ykm9Y5EQNgikfOy8eUjk9
         RkSFSmqvIbvwxyEie+7wkWesrZg/vRENcgAklTF3n98xNsY07sQyR8LLMBnxMZyiLRrk
         53zYL8EhW/C8FTySSs/JgyJk187s/eaRaxeBy3l0LeHqqHarwNFe5omlsia5W+B4H0Kv
         P9BvilEYSsxjzbzibSNR/y0ejfGnV084SY8SSHCvRPTaztrKC7w8IvXDl5Zohvv/+ari
         eekCiWFQqOjDlaww9HEm44n/ifgcTrcSPT0qczEeXFtRD3am2bdWiCQfX0dPy1QdzMd0
         CGZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679496334;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rLmkUGsjVKN4NZf9Xwc68SFWMoDmXlx37mUEv+QwNDs=;
        b=LeD0aT8RH6csZHe8xMs+n9Rz2KP8rq9ZdAt3pybg07VwjLiJqPb228PCK/4oWD5h/O
         X3hzdLqEcQ9FvP8N1ikUCthITwtdWZ5rj++1iAnw+ZhTnj046oMFzV4+zxCgkjCAQIxK
         RA/M66lgB907IEq68rVjo+hKo/6uUWLvyprjelOMFcsLZEegVudg59KWIl8qvRkaCYbL
         kGXV74GqLFF9upSxHZvaO4Cbrid0Qq7HW+02yps4l19DsyTga+XOENYhFNAXg5n67X62
         WzlkugRVLzh6D258+iPqut8PtYSqQyI0JtIpYs3/5viAC9UXi+CxxB0Qef8mchyBx8q3
         bKSQ==
X-Gm-Message-State: AO0yUKXCAFFZNd/026g75DWZnwHX9B2JbySNK4249+cAH5Y+FHuJbCqD
        dPtqyiZdy0j8PSd+XfnqRLM=
X-Google-Smtp-Source: AK7set/eNEzNh4JcOxymfhGwBqM5daoKmgX/0uSzD/XkdVZ0pb4jAN1GI3sQMn0JGiwqY3Zd5TaEyA==
X-Received: by 2002:a17:906:209:b0:932:170:e07b with SMTP id 9-20020a170906020900b009320170e07bmr5657820ejd.7.1679496334548;
        Wed, 22 Mar 2023 07:45:34 -0700 (PDT)
Received: from ivan-HLYL-WXX9.. ([178.160.196.94])
        by smtp.gmail.com with ESMTPSA id z26-20020a17090674da00b009310d4dece9sm7298268ejl.62.2023.03.22.07.45.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 07:45:34 -0700 (PDT)
From:   Ivan Orlov <ivan.orlov0322@gmail.com>
To:     pbonzini@redhat.com, shuah@kernel.org, seanjc@google.com,
        dmatlack@google.com, vannapurve@google.com
Cc:     Ivan Orlov <ivan.orlov0322@gmail.com>, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        himadrispandya@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH] selftests: kvm: Add 'malloc' failure check in vcpu_save_state
Date:   Wed, 22 Mar 2023 18:45:28 +0400
Message-Id: <20230322144528.704077-1-ivan.orlov0322@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

There is a 'malloc' call in vcpu_save_state function, which can
be unsuccessful. This patch will add the malloc failure checking
to avoid possible null dereference and give more information
about test fail reasons.

Signed-off-by: Ivan Orlov <ivan.orlov0322@gmail.com>
---
 tools/testing/selftests/kvm/lib/x86_64/processor.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/kvm/lib/x86_64/processor.c b/tools/testing/selftests/kvm/lib/x86_64/processor.c
index c39a4353ba19..827647ff3d41 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/processor.c
@@ -954,6 +954,7 @@ struct kvm_x86_state *vcpu_save_state(struct kvm_vcpu *vcpu)
 	vcpu_run_complete_io(vcpu);
 
 	state = malloc(sizeof(*state) + msr_list->nmsrs * sizeof(state->msrs.entries[0]));
+	TEST_ASSERT(state, "-ENOMEM when allocating kvm state");
 
 	vcpu_events_get(vcpu, &state->events);
 	vcpu_mp_state_get(vcpu, &state->mp_state);
-- 
2.34.1

