Return-Path: <linux-kselftest+bounces-8986-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 762878B4609
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Apr 2024 13:23:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32BD92860BB
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Apr 2024 11:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C117D524B1;
	Sat, 27 Apr 2024 11:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="P5e726Zn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 177D44D9F5;
	Sat, 27 Apr 2024 11:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714216889; cv=none; b=FtpoUNCbpqqZ31REew9fzrwJlau4KnBGB4KA2FQhVE3Ryy7y21BDpK15JqL8aVkU781cP8MKh9C7SwAV3AxjYIfCnvIz9F50qD8ar5QlsS5eO1Q53gQ7lhqzNuJtDtDCuGDLR/U3Y+4WiiUSv7soZqxIssWVMYPI7bjeP5xftfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714216889; c=relaxed/simple;
	bh=Zrx9q62WJW6pWUZYF2Lg4VuDOV8UN/CIkuY5rhw8cas=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WM1GSbfd7jISXZnlimLQJMfwpYbi6wmOhvC4a0vZVJ+eaiLoNRLQCH/+2ECvg2a6IG8+wSV6k49ZB91u8SYW0EH9XdHSndG0oAzrhBiFNWuhUDp7rOBkDq2U/fhuGsqyySMWSIeYQr2jWWUsYPTbLRoeaRyrOFPp+Q/mIhC5O4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=P5e726Zn; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description;
	bh=ZpNomMRa2id5zPy3uu/7WlNQs2+Ve/lVe7RTlRU/TCQ=; b=P5e726Zn287QWUIywqUUMok6cr
	mFX9PX9/WjdggP8DqaC9Na67zIm8JunytAQqfKLrigRJPBy0Tk7HzIjpvW7PIVBsssWHlGgoEW3Pk
	qeZFurlNf1niUoaH54dhiNVbsOFAYV8f8ajB7Za6RsU0vEjGIL9Bm06hJpiCnZWwi6n8Gb6DyIleM
	j6dNDzO0Oi2wOeo0R9TeyDXgitvl7vamDM2iQvMNwxUvileve48xXx3saRdGTpgylRnZaBhK47JjE
	Qs1T96GUptokrFzLuqOVXY96pzgCS3FGHp90QHhgMLPbcNHJ4JGmbOBuOylug3SwxLMunvq82AOYr
	MYiW80gQ==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s0g5i-0000000FeZi-0paA;
	Sat, 27 Apr 2024 11:21:03 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s0g5g-000000002bd-1pCW;
	Sat, 27 Apr 2024 12:19:36 +0100
From: David Woodhouse <dwmw2@infradead.org>
To: kvm@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Sean Christopherson <seanjc@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Paul Durrant <paul@xen.org>,
	Shuah Khan <shuah@kernel.org>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Oliver Upton <oliver.upton@linux.dev>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	jalliste@amazon.co.uk,
	sveith@amazon.de,
	zide.chen@intel.com,
	Dongli Zhang <dongli.zhang@oracle.com>
Subject: [PATCH v2 10/15] KVM: x86: Simplify and comment kvm_get_time_scale()
Date: Sat, 27 Apr 2024 12:05:07 +0100
Message-ID: <20240427111929.9600-11-dwmw2@infradead.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240427111929.9600-1-dwmw2@infradead.org>
References: <20240427111929.9600-1-dwmw2@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: David Woodhouse <dwmw2@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by desiato.infradead.org. See http://www.infradead.org/rpr.html

From: David Woodhouse <dwmw@amazon.co.uk>

Commit 3ae13faac400 ("KVM: x86: pass kvm_get_time_scale arguments in hertz")
made this function take 64-bit values in Hz rather than 32-bit kHz. Thus
making it entrely pointless to shadow its arguments into local 64-bit
variables. Just use scaled_hz and base_hz directly.

Also rename the 'tps32' variable to 'base32', having utterly failed to
think of any reason why it might have been called that in the first place.
This could probably have been eliminated too, but it helps to make the
code clearer and *might* just help a naïve 32-bit compiler realise that it
doesn't need to do full 64-bit shifts.

Having taken the time to reverse-engineer the function, add some comments
explaining it.

No functional change intended.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/kvm/x86.c | 60 ++++++++++++++++++++++++++++++++++++----------
 1 file changed, 47 insertions(+), 13 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index e09dc44978ea..ef3cd6113037 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -2375,32 +2375,66 @@ static uint32_t div_frac(uint32_t dividend, uint32_t divisor)
 	return dividend;
 }
 
+/*
+ * Calculate scaling factors to be applied with pvclock_scale_delta().
+ *
+ * The output of this function is a fixed-point factor which is used to
+ * scale a tick count at base_hz, to a tick count at scaled_hz, within
+ * the limitations of the Xen/KVM pvclock ABI.
+ *
+ * Mathematically, the factor is (*pmultiplier) >> (32 - *pshift).
+ *
+ * Working backwards, the div_frac() function divides (dividend << 32) by
+ * the given divisor, in other words giving dividend/divisor in the form
+ * of a 32-bit fixed-point fraction in the range 0 to 0x0.FFFFFFFF, which
+ * is (*pmultiplier >> 32).
+ *
+ * The rest of the function is shifting the scaled_hz and base_hz left or
+ * right as appropriate to ensure maximal precision within the constraints.
+ *
+ * The first constraint is that the result of the division *must* be less
+ * than 1, which means the dividend (derived from scaled_hz) must be greater
+ * than the divisor (derived from base_hz).
+ *
+ * The second constraint is that for optimal precision, the dividend (scaled)
+ * shouldn't be more than twice the divisor (base) — i.e. the top bit ought
+ * to be set in the resulting *pmultiplier.
+ */
 static void kvm_get_time_scale(uint64_t scaled_hz, uint64_t base_hz,
 			       s8 *pshift, u32 *pmultiplier)
 {
-	uint64_t scaled64;
 	int32_t  shift = 0;
-	uint64_t tps64;
-	uint32_t tps32;
+	uint32_t base32;
 
-	tps64 = base_hz;
-	scaled64 = scaled_hz;
-	while (tps64 > scaled64*2 || tps64 & 0xffffffff00000000ULL) {
-		tps64 >>= 1;
+	/*
+	 * Start by shifting the base_hz right until it fits in 32 bits, and
+	 * is lower than double the target rate. This introduces a negative
+	 * shift value which would result in pvclock_scale_delta() shifting
+	 * the actual tick count right before performing the multiplication.
+	 */
+	while (base_hz > scaled_hz*2 || base_hz & 0xffffffff00000000ULL) {
+		base_hz >>= 1;
 		shift--;
 	}
 
-	tps32 = (uint32_t)tps64;
-	while (tps32 <= scaled64 || scaled64 & 0xffffffff00000000ULL) {
-		if (scaled64 & 0xffffffff00000000ULL || tps32 & 0x80000000)
-			scaled64 >>= 1;
+	/* Now the shifted base_hz fits in 32 bits, copy it to base32 */
+	base32 = (uint32_t)base_hz;
+
+	/*
+	 * Next, shift the scaled_hz right until it fits in 32 bits, and ensure
+	 * that the shifted base_hz is not larger (so that the result of the
+	 * final division also fits in 32 bits).
+	 */
+	while (base32 <= scaled_hz || scaled_hz & 0xffffffff00000000ULL) {
+		if (scaled_hz & 0xffffffff00000000ULL || base32 & 0x80000000)
+			scaled_hz >>= 1;
 		else
-			tps32 <<= 1;
+			base32 <<= 1;
 		shift++;
 	}
 
 	*pshift = shift;
-	*pmultiplier = div_frac(scaled64, tps32);
+	*pmultiplier = div_frac(scaled_hz, base32);
 }
 
 #ifdef CONFIG_X86_64
-- 
2.44.0


