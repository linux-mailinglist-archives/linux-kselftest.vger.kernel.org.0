Return-Path: <linux-kselftest+bounces-1561-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AFD880CA90
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Dec 2023 14:10:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25509281801
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Dec 2023 13:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFD443D96B;
	Mon, 11 Dec 2023 13:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GnwrpM9N"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F1B23D3BD;
	Mon, 11 Dec 2023 13:10:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C0A1C433C8;
	Mon, 11 Dec 2023 13:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702300218;
	bh=eN+xX6DmUW4iySUtNTiONSvtkTg9S6O6PBUBb147Eow=;
	h=From:Date:Subject:To:Cc:From;
	b=GnwrpM9N1KHskL0ItU5RfVm6tiiamVasCF5XI3q2oqOCYLQQsdeyEAELevJZReSEt
	 1sG0pLtmb6hXzqCxqVpevH375oT26qR6f++eQ/c01GrKzYh3BEVNWccCk1zNFvUJhP
	 IxpUkrJVeSE6T0D3oQzsFsvCrVV7RV8ZlbP4+ZW98RHzaWTJTUg/gdN3z7JYXliwY8
	 Smi676PBEx5wEYAZZzsSVruBCi3LUf3SA0e0TPnqvKhsYiYp97YI1uAfW+ruJgP7dI
	 XEfAPaQAmH3bbYofYJnmkvk7peaQ7oMlrwy7Ms1i3Et7FLBiMwWAzVeyWL09r9hZ0l
	 ywHMyLdVPn6zw==
From: Mark Brown <broonie@kernel.org>
Date: Mon, 11 Dec 2023 13:08:55 +0000
Subject: [PATCH RESEND v3] KVM: selftests: Initialise dynamically allocated
 configuration names
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231211-kvm-get-reg-list-str-init-v3-1-6554c71c77b1@kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 Haibo Xu <haibo1.xu@intel.com>, Andrew Jones <ajones@ventanamicro.com>, 
 Anup Patel <anup@brainfault.org>
Cc: kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-5c066
X-Developer-Signature: v=1; a=openpgp-sha256; l=1754; i=broonie@kernel.org;
 h=from:subject:message-id; bh=eN+xX6DmUW4iySUtNTiONSvtkTg9S6O6PBUBb147Eow=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBldwo35IUcY6oNTJ2v6bW/nJJU3aNtV6hPHyuPoXmM
 jPdqsNCJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZXcKNwAKCRAk1otyXVSH0IF/B/
 0c7d7J486YSDJ+Oc8P2P4naqawpIeasFieXQgYjUPg9+qbMhD+8uicOI6zb+yfZu4r1g5Vln7DxbBT
 ZWGKK9OseW5cEGQwReDbJJxilNJ7IbG/mSdEhcPS/bd70N+504CuCHzw+Tk+F91kA1+hIniVchID9Z
 o2pz9kM6OAYVGfnChlqKblwrnBM+43eroWz+YGd3WCWVO92NrulsrbRR0NG+fzRXk/sdwJQwFNMRvl
 evQcp1xUfIrtBCI2uYrwmjE283O1pZA/rcZFbN55/JkWqO9F0eTgEeKaRSRqws4ckEn74L8C7Wbr4r
 2+azED66yUak8FbJi2v6luHBgrNdlo
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


