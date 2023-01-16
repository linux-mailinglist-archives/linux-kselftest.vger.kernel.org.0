Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B538D66C5FB
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jan 2023 17:13:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232787AbjAPQNB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 16 Jan 2023 11:13:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232790AbjAPQMK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 16 Jan 2023 11:12:10 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2768C2A9BA;
        Mon, 16 Jan 2023 08:07:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5A724B8100C;
        Mon, 16 Jan 2023 16:07:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34275C4339C;
        Mon, 16 Jan 2023 16:07:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673885256;
        bh=MPucUh5nMM1iQ9zAE7rDc23uTz6TPGd3yaLu/ElA83s=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=iuOyXvjIV7xA5YHyOtZzbazrfBaesm1aSLxmOLv+7UEcDHQqVkztJvkvlVWg/aiwz
         umNBYV3RfSQvHR24d5GtwqZUTswgEYivz1k6Mk+GQtfAVSkEMvv2arKs2gBzL90lQb
         owTWqSLvpxC3I5gUNRKgrnTnroEUSi9o11+TJFdwomnad5wZb5gBDHGIrGr/N5cKFu
         cl8Jv/5jSwRbEtzL8Ju26OZYPsqXPzgrnhmqP1cP2+Qu3KVnAsMbbZSxIW/s5CWEb/
         0Teb+VYZOrNE79mRNpVvNjAhnIA9jg9tKkokZVNq7FK6FIkWNmkoKdNQdBMDJziJ8Y
         gtEWdUgL8KTEw==
From:   Mark Brown <broonie@kernel.org>
Date:   Mon, 16 Jan 2023 16:04:52 +0000
Subject: [PATCH v4 17/21] kselftest/arm64: Teach the generic signal context
 validation about ZT
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20221208-arm64-sme2-v4-17-f2fa0aef982f@kernel.org>
References: <20221208-arm64-sme2-v4-0-f2fa0aef982f@kernel.org>
In-Reply-To: <20221208-arm64-sme2-v4-0-f2fa0aef982f@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        Shuah Khan <shuah@kernel.org>
Cc:     Alan Hayward <alan.hayward@arm.com>,
        Luis Machado <luis.machado@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvmarm@lists.linux.dev, linux-kselftest@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.12-dev-77e06
X-Developer-Signature: v=1; a=openpgp-sha256; l=3173; i=broonie@kernel.org;
 h=from:subject:message-id; bh=MPucUh5nMM1iQ9zAE7rDc23uTz6TPGd3yaLu/ElA83s=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBjxXWuq2xm82pLoA5y4Nkh8zSmq241XVVBVuB49Z3T
 Kn55b76JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCY8V1rgAKCRAk1otyXVSH0H+4B/
 0TJKtvtGUngMnoljDrMhE54f7qgIHgtQFbRCW5MHO4mNhVzojOEDeZBSMgZ/gM1lINqpSeQBzJLuuO
 rz6jBjT0mqTKWTOcYIcmfQRER45aGIW8Br9+gOkLkCX7KCziXkbynS5FcuneqG7Y2ZXF++6nUxbKjQ
 I0Dh5p46O70Q+sr25BfinhqPgae7lNldZ14JVIQns75nV9E1YQ2n61evx96nTtMTtX4cYchXyxLRMa
 bTgVCEc0sAM47krNzmUJWCxvL00v/cMixnIzJAIDtjgveWKogEJT/DYlsEiIXUG8FvbPsfcg2Xe322
 fUE4/oIev2uAhlJ4MArQTIjR8sqPpl
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add ZT to the set of signal contexts that the shared code understands and
validates the form of.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../selftests/arm64/signal/testcases/testcases.c   | 36 ++++++++++++++++++++++
 .../selftests/arm64/signal/testcases/testcases.h   |  1 +
 2 files changed, 37 insertions(+)

diff --git a/tools/testing/selftests/arm64/signal/testcases/testcases.c b/tools/testing/selftests/arm64/signal/testcases/testcases.c
index d2eda7b5de26..27d495fa52f8 100644
--- a/tools/testing/selftests/arm64/signal/testcases/testcases.c
+++ b/tools/testing/selftests/arm64/signal/testcases/testcases.c
@@ -108,6 +108,26 @@ bool validate_za_context(struct za_context *za, char **err)
 	return true;
 }
 
+bool validate_zt_context(struct zt_context *zt, char **err)
+{
+	if (!zt || !err)
+		return false;
+
+	/* If the context is present there should be at least one register */
+	if (zt->nregs == 0) {
+		*err = "no registers";
+		return false;
+	}
+
+	/* Size should agree with the number of registers */
+	if (zt->head.size != ZT_SIG_CONTEXT_SIZE(zt->nregs)) {
+		*err = "register count does not match size";
+		return false;
+	}
+
+	return true;
+}
+
 bool validate_reserved(ucontext_t *uc, size_t resv_sz, char **err)
 {
 	bool terminated = false;
@@ -117,6 +137,7 @@ bool validate_reserved(ucontext_t *uc, size_t resv_sz, char **err)
 	struct extra_context *extra = NULL;
 	struct sve_context *sve = NULL;
 	struct za_context *za = NULL;
+	struct zt_context *zt = NULL;
 	struct _aarch64_ctx *head =
 		(struct _aarch64_ctx *)uc->uc_mcontext.__reserved;
 	void *extra_data = NULL;
@@ -177,6 +198,13 @@ bool validate_reserved(ucontext_t *uc, size_t resv_sz, char **err)
 			za = (struct za_context *)head;
 			new_flags |= ZA_CTX;
 			break;
+		case ZT_MAGIC:
+			if (flags & ZT_CTX)
+				*err = "Multiple ZT_MAGIC";
+			/* Size is validated in validate_za_context() */
+			zt = (struct zt_context *)head;
+			new_flags |= ZT_CTX;
+			break;
 		case EXTRA_MAGIC:
 			if (flags & EXTRA_CTX)
 				*err = "Multiple EXTRA_MAGIC";
@@ -234,6 +262,9 @@ bool validate_reserved(ucontext_t *uc, size_t resv_sz, char **err)
 		if (new_flags & ZA_CTX)
 			if (!validate_za_context(za, err))
 				return false;
+		if (new_flags & ZT_CTX)
+			if (!validate_zt_context(zt, err))
+				return false;
 
 		flags |= new_flags;
 
@@ -245,6 +276,11 @@ bool validate_reserved(ucontext_t *uc, size_t resv_sz, char **err)
 		return false;
 	}
 
+	if (terminated && (flags & ZT_CTX) && !(flags & ZA_CTX)) {
+		*err = "ZT context but no ZA context";
+		return false;
+	}
+
 	return true;
 }
 
diff --git a/tools/testing/selftests/arm64/signal/testcases/testcases.h b/tools/testing/selftests/arm64/signal/testcases/testcases.h
index 040afded0b76..a08ab0d6207a 100644
--- a/tools/testing/selftests/arm64/signal/testcases/testcases.h
+++ b/tools/testing/selftests/arm64/signal/testcases/testcases.h
@@ -18,6 +18,7 @@
 #define SVE_CTX		(1 << 1)
 #define ZA_CTX		(1 << 2)
 #define EXTRA_CTX	(1 << 3)
+#define ZT_CTX		(1 << 4)
 
 #define KSFT_BAD_MAGIC	0xdeadbeef
 

-- 
2.34.1

