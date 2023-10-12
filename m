Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84D607C7A51
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Oct 2023 01:19:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443065AbjJLXTk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 12 Oct 2023 19:19:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443006AbjJLXTj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 12 Oct 2023 19:19:39 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 072F8BE;
        Thu, 12 Oct 2023 16:19:37 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9493C433C7;
        Thu, 12 Oct 2023 23:19:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697152777;
        bh=W+HLtEgsaqMQgpJ9qQLMNO8wc9NamWUTclvh2/EECcI=;
        h=From:Date:Subject:To:Cc:From;
        b=eb0HV6fAD9Rk6Ik8iOB/zut66wHHTy9vzdNAuU5Y37dCLkEEqtrBdj+6zurj+g7dD
         Zu0rApQ6FX+i6Uq/XP9m5V/XLARKXGhxcrocsOImcvu6nWIXNnT5yvdgQW0ZwrmX5f
         K5rQe/z0omYrjx8I4DPCk9BIwIbMXHc+/z6X3nzbLm1ys8qjG6sxJB7HNbEpwg8E8B
         8DeS7j2oeeGjRRqhRf3ctj0UeMGSvQLNU4v1uv3DsoCCfTx6qEbNzm9WXszuAXzJAs
         5RMIldw/KTn8cjcTYcngTLS4YMoMJ1Hb8ng/vttPfvPkb2VfjmtBdOwA0+Thja2GmI
         cRmfxNQ+amu9g==
From:   Mark Brown <broonie@kernel.org>
Date:   Fri, 13 Oct 2023 00:19:30 +0100
Subject: [PATCH] KVM: selftests: Initialise dynamically allocated
 configuration names
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231013-kvm-get-reg-list-str-init-v1-1-034f370ff8ab@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAF/KGUC/x3MQQqDMBBG4avIrDtgUrG1VykuJPmbDtVYZoIUx
 Ls3uPwW7+1kUIHRo9lJsYnJmivcpaHwnnICS6wm3/qra53nz7ZwQmFF4lmssBVlyVL41oc7Ygc
 3xJ5q/1W85He+n+Nx/AG3n083awAAAA==
To:     Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Haibo Xu <haibo1.xu@intel.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Anup Patel <anup@brainfault.org>
Cc:     kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=1387; i=broonie@kernel.org;
 h=from:subject:message-id; bh=W+HLtEgsaqMQgpJ9qQLMNO8wc9NamWUTclvh2/EECcI=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlKH8GuYwP3eqfpIbuiJvsgr1BzuWfe3QnN66dqLNE
 ekce7+uJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZSh/BgAKCRAk1otyXVSH0K++B/
 9ysGHgribz8lwpyjHgElOFHnYUyx4g0hlrceRYQ6SlK0TR0BBFnZs828NRW/ucIoiP8C2TPiRi8g+Q
 SeNjf+rFX7OqiXR8av/SUp78fgsSPHHm2xN53+yAQXt0PFQdGjcbcI4dLZe2x14W+suWr2eVKhdNZF
 WZgGM9X0vYrdRJHXEFMMFW9zPT98d5ypP0/9f4CqGKNAGoQ2rNigsdeHRJdIlT0GkU/nSp5yXbJRsN
 nNp8SG7EMdvwa7/4u62MX29zih0e9gsYED3yThnmnq4nthilSWhBP2PNRSYedodFyzwJT1mrogfSy6
 pdJwqNge1SGhOjx/i9zdf8zMu/sBIg
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

When we dynamically generate a name for a configuration in get-reg-list
we use strcat() to append to a buffer allocated using malloc() but we
never initialise that buffer. Since malloc() offers no guarantees
regarding the contents of the memory it returns this can lead to us
corrupting, and likely overflowing, the buffer:

  vregs: PASS
  vregs+pmu: PASS
  sve: PASS
  sve+pmu: PASS
  vregs+pauth_address+pauth_generic: PASS
  X�vr+gspauth_addre+spauth_generi+pmu: PASS

Initialise the buffer to an empty string to avoid this.

Fixes: 17da79e009c37 ("KVM: arm64: selftests: Split get-reg-list test code")
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/kvm/get-reg-list.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/kvm/get-reg-list.c b/tools/testing/selftests/kvm/get-reg-list.c
index be7bf5224434..dd62a6976c0d 100644
--- a/tools/testing/selftests/kvm/get-reg-list.c
+++ b/tools/testing/selftests/kvm/get-reg-list.c
@@ -67,6 +67,7 @@ static const char *config_name(struct vcpu_reg_list *c)
 
 	c->name = malloc(len);
 
+	c->name[0] = '\0';
 	len = 0;
 	for_each_sublist(c, s) {
 		if (!strcmp(s->name, "base"))

---
base-commit: 6465e260f48790807eef06b583b38ca9789b6072
change-id: 20231012-kvm-get-reg-list-str-init-76c8ed4e19d6

Best regards,
-- 
Mark Brown <broonie@kernel.org>

