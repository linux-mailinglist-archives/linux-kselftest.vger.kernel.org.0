Return-Path: <linux-kselftest+bounces-2396-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2497E81CCFD
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Dec 2023 17:28:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A02E0B24D59
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Dec 2023 16:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A5FC35EE5;
	Fri, 22 Dec 2023 16:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hQckwvTQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D0936091;
	Fri, 22 Dec 2023 16:22:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1466AC433C8;
	Fri, 22 Dec 2023 16:22:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703262164;
	bh=T6dY6Wn0lMSzd+TK/vbyQwemqYZKP9eb53Gdqzb2VIQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=hQckwvTQuJDOC4E1AaV09Pnr0S/aLijxBV3fJAKZvnGRyR8Js+PD6C8LaNH73iVzL
	 0lFfSRWFTs+Wk8hJ1HczRab+ZmXR9Q8BokGLCbdRIRSVXbXOnee39dTC9TY90zY66G
	 OqK8Nrbf/8HvEU4f69i2QMjHqczcoxIMkVTmtadNWEelzvk7U/E5sSo2RONmM8Lo3n
	 WgqEwC8RtaNF53nhpZbsZ7Aa063HUpdom3+XehNU01XlREnlnK84LFqMK1AfpacpFH
	 D8yPemgz6E4rpjfo8pwk6XyZgbUeIrwTYGlLOCV6oVhkWPiHQoHRg0ho+X2Xy5mLV5
	 fi6nCkyawTYXg==
From: Mark Brown <broonie@kernel.org>
Date: Fri, 22 Dec 2023 16:21:27 +0000
Subject: [PATCH RFC v2 19/22] KVM: arm64: Provide userspace access to ZT0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231222-kvm-arm64-sme-v2-19-da226cb180bb@kernel.org>
References: <20231222-kvm-arm64-sme-v2-0-da226cb180bb@kernel.org>
In-Reply-To: <20231222-kvm-arm64-sme-v2-0-da226cb180bb@kernel.org>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
 James Morse <james.morse@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-5c066
X-Developer-Signature: v=1; a=openpgp-sha256; l=3511; i=broonie@kernel.org;
 h=from:subject:message-id; bh=T6dY6Wn0lMSzd+TK/vbyQwemqYZKP9eb53Gdqzb2VIQ=;
 b=owGbwMvMwMWocq27KDak/QLjabUkhtTW7V1vnZQMDZ++lfmS4j3nF6fPHq181vbovx5vbHssK7ub
 sko7GY1ZGBi5GGTFFFnWPstYlR4usXX+o/mvYAaxMoFMYeDiFICJyDSw/zOdkqG8+0VCWKf31IYcT4
 bVXue189WOvJqfK+Cz+JhGfqc56wTT/Oe/NzQt5D2xTSH7VarJl3w9+yfcBfN4zdZztsyUqXt8Ufbe
 27BS83MzuJm3VCz0+2n+i8HH+3G/UfTq20xNdx3OTIkO4M270bLu38Gth2utc1OVm2ssdU8GuD+88p
 BZ4EVGUUnbo/l8cv8Fr3d4LlqeaaTM5CEUVLr2YAhDW4BSxQPrdjvBpviOy2Uq1Ua/b+/fo/EnN96j
 dMUTfYl6+Qfqy+o8+iMTtrV9vK+ZPVU2Utl3ir1k5+95MXavtB5VVRxlNZm5YuP/gJ1GSqXbt4e6fr
 71qkV1Z5/MOs2paa2WEsuqbswGAA==
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

ZT0 is a single register with a refreshingly fixed size 512 bit register
which is like ZA accessible only when PSTATE.ZA is set. Add support for it
to the userspace API, as with ZA we allow the regster to be read or written
regardless of the state of PSTATE.ZA in order to simplify userspace usage.
The value will be reset to 0 whenever PSTATE.ZA changes from 0 to 1,
userspace can read stale values but these are not observable by the guest
without manipulation of PSTATE.ZA by userspace.

While there is currently only one ZT register the naming as ZT0 and the
instruction encoding clearly leave room for future extensions adding more
ZT registers. This encoding can readily support such an extension if one is
introduced.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/asm/kvm_host.h |  2 ++
 arch/arm64/include/uapi/asm/kvm.h |  2 ++
 arch/arm64/kvm/guest.c            | 13 +++++++++++--
 3 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index a1aa9471084d..6a5002ab8042 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -855,6 +855,8 @@ void vcpu_fp_guest_to_user(struct kvm_vcpu *vcpu);
 	} else {							\
 		__vcpu_vq = vcpu_sme_max_vq(vcpu);			\
 		__size_ret = ZA_SIG_REGS_SIZE(__vcpu_vq);		\
+		if (system_supports_sme2())				\
+			__size_ret += ZT_SIG_REG_SIZE;			\
 	}								\
 									\
 	__size_ret;							\
diff --git a/arch/arm64/include/uapi/asm/kvm.h b/arch/arm64/include/uapi/asm/kvm.h
index 00fb2ea4c057..58640aeb88e4 100644
--- a/arch/arm64/include/uapi/asm/kvm.h
+++ b/arch/arm64/include/uapi/asm/kvm.h
@@ -371,6 +371,8 @@ struct kvm_arm_counter_offset {
 	 (((n) & (KVM_ARM64_SME_MAX_ZAHREG - 1)) << 5) |		\
 	 ((i) & (KVM_ARM64_SVE_MAX_SLICES - 1)))
 
+#define KVM_REG_ARM64_SME_ZTREG_SIZE	(512 / 8)
+
 /* Vector lengths pseudo-register: */
 #define KVM_REG_ARM64_SME_VLS		(KVM_REG_ARM64 | KVM_REG_ARM64_SME | \
 					 KVM_REG_SIZE_U512 | 0xffff)
diff --git a/arch/arm64/kvm/guest.c b/arch/arm64/kvm/guest.c
index cb38af891387..fba5ff377b8b 100644
--- a/arch/arm64/kvm/guest.c
+++ b/arch/arm64/kvm/guest.c
@@ -587,7 +587,6 @@ static int sme_reg_to_region(struct vec_state_reg_region *region,
 	const u64 zah_id_min = KVM_REG_ARM64_SME_ZAHREG(0, 0);
 	const u64 zah_id_max = KVM_REG_ARM64_SME_ZAHREG(za_h_max - 1,
 						       SVE_NUM_SLICES - 1);
-
 	unsigned int reg_num;
 
 	unsigned int reqoffset, reqlen; /* User-requested offset and length */
@@ -598,14 +597,24 @@ static int sme_reg_to_region(struct vec_state_reg_region *region,
 	reg_num = (reg->id & SVE_REG_ID_MASK) >> SVE_REG_ID_SHIFT;
 
 	if (reg->id >= zah_id_min && reg->id <= zah_id_max) {
-		/* ZA is exposed as SVE vectors ZA.H[n] */
 		if (!vcpu_has_sme(vcpu) || (reg->id & SVE_REG_SLICE_MASK) > 0)
 			return -ENOENT;
 
+		/* ZA is exposed as SVE vectors ZA.H[n] */
 		reqoffset = ZA_SIG_ZAV_OFFSET(vq, reg_num) -
 			ZA_SIG_REGS_OFFSET;
 		reqlen = KVM_SVE_ZREG_SIZE;
 		maxlen = SVE_SIG_ZREG_SIZE(vq);
+	} if (reg->id == KVM_REG_ARM64_SME_ZT_BASE) {
+		/* ZA is exposed as SVE vectors ZA.H[n] */
+		if (!vcpu_has_sme2(vcpu) ||
+		    (reg->id & SVE_REG_SLICE_MASK) > 0 ||
+		    reg_num > 0)
+			return -ENOENT;
+
+		/* ZT0 is stored after ZA */
+		reqlen = KVM_REG_ARM64_SME_ZTREG_SIZE;
+		maxlen = KVM_REG_ARM64_SME_ZTREG_SIZE;
 	} else {
 		return -EINVAL;
 	}

-- 
2.30.2


