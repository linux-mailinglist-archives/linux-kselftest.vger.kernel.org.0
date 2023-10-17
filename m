Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 338CC7CC9C5
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Oct 2023 19:22:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234304AbjJQRWU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 17 Oct 2023 13:22:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbjJQRWT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 17 Oct 2023 13:22:19 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71D5994;
        Tue, 17 Oct 2023 10:22:18 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1DDEC433C7;
        Tue, 17 Oct 2023 17:22:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697563338;
        bh=AqQvqXpBdDwQ1bSutr+7JjsmD9aFJQI9wkzLVRowwi4=;
        h=From:Date:Subject:To:Cc:From;
        b=p1azuokVOEAWEJdrYmvKxX0sn1rYFF2CFBrJOlyv+k1ZcOYVlvMngX7VJKOzq0r3h
         eRev0ON4tkw/z3lUf/be+0sRlGXalz4Dk6nFPQ75rtNK5hq33f6GsvWRjxGsRnySUX
         8YebPiV6t5F7eAUyNjm0apondcJKDTuFtPfWEai1qcsSuP0UnmMcvDuAmwC/vys3kx
         L5cYLC6I21b7yQBz573ZlPH96K8sNLzpQR1NfAXa1llYEE/vSqSbqolHWd8R8Gyuxh
         bFHoVN5S+j+zMi9u+BIBL9gKclwN3yusCM4lrYrjFqAT6wXA6755j739vNrtGnCTku
         KoSwjoeAruK0w==
From:   Mark Brown <broonie@kernel.org>
Date:   Tue, 17 Oct 2023 18:22:01 +0100
Subject: [PATCH v2] KVM: selftests: Initialise dynamically allocated
 configuration names
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231017-kvm-get-reg-list-str-init-v2-1-ee30b1df3e50@kernel.org>
X-B4-Tracking: v=1; b=H4sIALjCLmUC/32NzQ6CMBCEX4X07Jr+EEBPvofhgLAtG7CQbdNoC
 O9uJfHq8ZvMfLOJgEwYxLXYBGOiQIvPoE+F6MfOOwQaMgsttVFSaZjSExxGYHQwU4gQIgN5ilB
 XfYNDieoyVCLvV0ZLr8N9bzOPub3w+7hK6pv+rOaPNSlQIE1pTS2tbbrHbUL2OJ8XdqLd9/0D1
 /s0g8MAAAA=
To:     Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Haibo Xu <haibo1.xu@intel.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Anup Patel <anup@brainfault.org>
Cc:     kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=1595; i=broonie@kernel.org;
 h=from:subject:message-id; bh=AqQvqXpBdDwQ1bSutr+7JjsmD9aFJQI9wkzLVRowwi4=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlLsLGqB2SxRIjasfLDomMD3wyf0dEHwGneDeBeeGt
 1upbc0iJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZS7CxgAKCRAk1otyXVSH0N5eB/
 sEcJpkSMLVRTIa8dZjGtSsrneIR07N4VVGdxY/8NuKNsBOyYifRdrL+bQ9oJaFbOM4ixxcGxBxxGqW
 qGOxZIOPrHQ00IE46XNnvVRKR93Mf8MgDFqjfNjL37sfB8i7GSmE22XXmQCdrGk+BosOIV+U41+KAL
 deH/BJL6KwLSbj4jmqUOK7Ww1ft1J9qex7wHrYX/XfEErR4ZzE59Rf3YySzpVAYRqOruNw7AJFvssP
 VfdOIqu9riy+T0eLH8WGhIptLiZPc5za7GG3MY94Qyj/PQqFH2yJe9xKxyqOwUNhp8PnOF6Trmy+uO
 +GsaaE5m/KV7L9jN93tJdi9ZbCOt35
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

Fixes: 2f9ace5d4557 ("KVM: arm64: selftests: get-reg-list: Introduce vcpu configs")
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
Changes in v2:
- Update Fixes: tag.
- Link to v1: https://lore.kernel.org/r/20231013-kvm-get-reg-list-str-init-v1-1-034f370ff8ab@kernel.org
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

