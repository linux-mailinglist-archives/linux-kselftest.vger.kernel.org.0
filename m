Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A10B843D118
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Oct 2021 20:51:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243621AbhJ0Sxm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 27 Oct 2021 14:53:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:33186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231897AbhJ0Sxl (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 27 Oct 2021 14:53:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 80FAB610C7;
        Wed, 27 Oct 2021 18:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635360676;
        bh=TI/C1cFpzlA/vIxcq5mLhNWbKbVY/Dn4YookoS/nBsg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nJbL/8Kbwm3UUJ+bluQNwNeKSYCh0Owocv0BF3DyYQa/cD83AkrA1tWdZ2QLzC7HZ
         ytYooZVHL9mPwr6hAy8zsWeJ2zr5kuivR/tnlYvAbXudoLtnvn0DSlVA9ILxIozxK5
         sVxXoWvV5NIeAa6jgvzLTHigJRAhZqplYUaLd9hSApm5JPdyIr87CMr0gAsRGNVmpw
         T/DKAKlGRJU1Axr+IV0/Q1Eqsemtf1myz1uckNR4M5Wy9u2nY/xOoQHVCau2T0wmjm
         Qc4yM0pJT1uXXNHDiyFzTJqwlg15RipxKzzGYlVO7RZoSY5Ae3wt20olULsZKKABHO
         gxiyk8USXz0jQ==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     Alan Hayward <alan.hayward@arm.com>,
        Luis Machado <luis.machado@arm.com>,
        Salil Akerkar <Salil.Akerkar@arm.com>,
        Basant Kumar Dwivedi <Basant.KumarDwivedi@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH v5 08/38] arm64: Document boot requirements for FEAT_SME_FA64
Date:   Wed, 27 Oct 2021 19:43:54 +0100
Message-Id: <20211027184424.166237-9-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211027184424.166237-1-broonie@kernel.org>
References: <20211027184424.166237-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1279; h=from:subject; bh=TI/C1cFpzlA/vIxcq5mLhNWbKbVY/Dn4YookoS/nBsg=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBheZ3tce28ENPwBRIQfjkdKks+PShWlmA4SD3InADF SFkgGD+JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYXmd7QAKCRAk1otyXVSH0F4VB/ 0Z9ene4fS/6J2hbk7VibxyWsfK+V0uJ3cTcuNdIO431aOf8I0sVd27WxrQ6jkUwqLCbLb1cjbMSvOR cXlVlGDEK+scDBvv68FGmW/4fFVUlMX3gKUfw+yL0KjF6d3xUIy4R02Wv/qxJxkzsrmQWEx20CVptJ ZPviP4w1yH1yI0cBst3sOHxx937xKW12726YI2SPKboK49HMfXK5uRiKbuO4veIzW7fL0QbAK7scoj Dr57JVWI0M1PMigMjYu+JN8/22SknuxFACTlyRTJOZ4M0mgE5+QCvGXl8rPCoQj+ZkAW8rr+IxVvbc 4XAXvvOQxS0vFDCS0ibzH6G8uQeVZ0
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The EAC1 release of the SME specification adds the FA64 feature which
requires enablement at higher ELs before lower ELs can use it. Document
what we require from higher ELs in our boot requirements.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/arm64/booting.rst | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/arm64/booting.rst b/Documentation/arm64/booting.rst
index 3f9d86557c5e..52d060caf8bb 100644
--- a/Documentation/arm64/booting.rst
+++ b/Documentation/arm64/booting.rst
@@ -340,6 +340,16 @@ Before jumping into the kernel, the following conditions must be met:
     - SMCR_EL2.LEN must be initialised to the same value for all CPUs the
       kernel will execute on.
 
+  For CPUs with the Scalable Matrix Extension FA64 feature (FEAT_SME_FA64)
+
+  - If EL3 is present:
+
+    - SMCR_EL3.FA64 (bit 31) must be initialised to 0b1.
+
+ - If the kernel is entered at EL1 and EL2 is present:
+
+    - SMCR_EL2.FA64 (bit 31) must be initialised to 0b1.
+
 The requirements described above for CPU mode, caches, MMUs, architected
 timers, coherency and system registers apply to all CPUs.  All CPUs must
 enter the kernel in the same exception level.  Where the values documented
-- 
2.30.2

