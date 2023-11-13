Return-Path: <linux-kselftest+bounces-49-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C4D67EA180
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Nov 2023 17:49:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C84F41C20935
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Nov 2023 16:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9FD921376;
	Mon, 13 Nov 2023 16:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="avIvyR61"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C64DA22314;
	Mon, 13 Nov 2023 16:49:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B910C433C8;
	Mon, 13 Nov 2023 16:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699894189;
	bh=eN+xX6DmUW4iySUtNTiONSvtkTg9S6O6PBUBb147Eow=;
	h=From:Date:Subject:To:Cc:From;
	b=avIvyR61/qpH8sMkK5TySTf9QqQRTNhm6CCgNiCyQYw7syiLyphx8flR2lZ9Yv85m
	 lV0YT/otAlBX7lZc864yYFV2MDmeZqYf73cuKyeDEVGhOpiFmORUIBeHfstFQWgdA6
	 zT5IzrPFPHHqqRF6CDyVXO+Sw7+xGkquzagbuSga+fqbt1JaM61z10O95aSSZZgi6O
	 FLUSD6hJyDlqFtAgz2a1PnMeGvxklCTX3DxFZ8nQyk7mWeFonchrWbLQS3c7QiMYYD
	 Gu29JQpM9qQjcrHz/yIC6e/ckxWujGejSZ3++4XclFkAHYCcF/ik79VoypWUM6oxPI
	 FlgYsAuQL749g==
From: Mark Brown <broonie@kernel.org>
Date: Mon, 13 Nov 2023 16:49:39 +0000
Subject: [PATCH v3] KVM: selftests: Initialise dynamically allocated
 configuration names
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231113-kvm-get-reg-list-str-init-v3-1-eaf67d660007@kernel.org>
X-B4-Tracking: v=1; b=H4sIAKJTUmUC/33NzQ6CMAzA8VchO1uzDwT05HsYD8A6WMBhumXRE
 N7dQWKiF47/pv11Zh7JomeXbGaE0Xo7uRTqkLG2r12HYHVqJrlUggsJQ3xAhwEIOxitD+ADgXU
 2QFm0FeocxVkXLN0/CY19bfbtnrpP2xO9t1dRrNOvqnbUKEAAV7lRJTemqpvrgORwPE7UsZWN8
 pcq9yiZKETFG6GNwhP/o5Zl+QBsbdwUDgEAAA==
To: Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 Haibo Xu <haibo1.xu@intel.com>, Andrew Jones <ajones@ventanamicro.com>, 
 Anup Patel <anup@brainfault.org>
Cc: kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=1754; i=broonie@kernel.org;
 h=from:subject:message-id; bh=eN+xX6DmUW4iySUtNTiONSvtkTg9S6O6PBUBb147Eow=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlUlOqoiyBDrdYWAjOBCW2b9i4B4vofjjc4HPqvJKu
 pAzk0t2JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZVJTqgAKCRAk1otyXVSH0OOZB/
 4nq6XYAh18ZoaB/hR7LIT1WSxn7QP6lJZvnPindbQDfDezh7DP8KYko76+qS1yOnYVD7AyD3n0m+dT
 o++expDxd1wdBHAl6nt//u5job1n+Qj5MwdjGNnZAYVawCDaClBZxS4/uXwjVPko9cQBewoVJ9EtnR
 Xj+IQ4rie8MlWrGzn5naoisp8SmVoBgA6kBPZ3rHSt5u0Mfj7vLa0R8ZZ6Tr55KTmBHgHwMwJ0fdiS
 NNeOCE8hmr0QcBNWLgBTsjHla7lhykQ24dnpmt3psXPS32LgHpHyt4YPPWnksHlXU43KhjXO92br+K
 mbfcGlrnrIjtbBjknJEfGwpH9G1Kl7
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

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
Changes in v3:
- Rebase this bugfix onto v6.7-rc1
- Link to v2: https://lore.kernel.org/r/20231017-kvm-get-reg-list-str-init-v2-1-ee30b1df3e50@kernel.org

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
base-commit: b85ea95d086471afb4ad062012a4d73cd328fa86
change-id: 20231012-kvm-get-reg-list-str-init-76c8ed4e19d6

Best regards,
-- 
Mark Brown <broonie@kernel.org>


