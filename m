Return-Path: <linux-kselftest+bounces-41249-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DC39B5344D
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Sep 2025 15:50:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBB46163090
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Sep 2025 13:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B9E732A807;
	Thu, 11 Sep 2025 13:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ECG4N7vw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA4A3314CB
	for <linux-kselftest@vger.kernel.org>; Thu, 11 Sep 2025 13:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757598588; cv=none; b=nnaiIfsiuEeBG7pioHH3zu6FwHp81krHs1lPS8iM6sdcpY3IyVi5ZeECjztXAOCIllyL6+rErtjNCwb7rGnUshQQ7ututLDLNZo0J2SX/jgy9ls0NkU/lqDZZ4UAtBnp9fnzfKB3zVF0aQI0m4pyODmmdBjY9oLYBoUooLnnt0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757598588; c=relaxed/simple;
	bh=coVlvw6nAsqruPp9BB3WURmrEJc6EQqZ8wGP1yqmBOA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=W6iNWF6SwSvci2NNTV5IZCnLrVv59emXoayZ2ttaFJxQtXyzzyMHjqThDJQSBRFy+bo3VionAITOMKRu/HhRA2421Y9Rh05rADt8EOBx49KuVY7P3s7mVIXHh79u35pH8ihI4F6dcKV8bBLoFXLHFGt5Xkv2598MNwSxOnXPCKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ECG4N7vw; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-45cb659e858so5860505e9.2
        for <linux-kselftest@vger.kernel.org>; Thu, 11 Sep 2025 06:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757598585; x=1758203385; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0QS0X9ggn6fxbGpDUqeyaduaSpB6sZdnskQczeYDZPM=;
        b=ECG4N7vwVdv1rIhMetFwojqGdO0xKMZZYQAmjCAwQCOnF5zIYlXQKPfD4H19ZNOfWL
         ogxeaiXK4e89DTx+fG0LISmonTg0HOXaAe6nmpnPNStwNzpZcVsxca/cFiK1T5FcZ417
         SW0m7cAdM1eDu8BBl/tK01Vy7Y8zEWBwXNDrfIXtoZhCm1KJscCcfumK7fttNfSGQDXi
         QgdHh2U6HTeE8Lg0TcPxQZW6Q79gu8Ypmx2JpUh3FK2/IwptgESwMu7efuqZVMoOvZvF
         oLwvySCgQA6pLPsuAOBsZufdtPWq/6mKm3gMi/unzEGGjGEU3aTfQuLx6gaBBuX/lMTY
         3cug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757598585; x=1758203385;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0QS0X9ggn6fxbGpDUqeyaduaSpB6sZdnskQczeYDZPM=;
        b=j/oT+zUuS0IfJrr6O0xOpK2dtPfttg2HYxb0S4Yjm0V3w7S+VuCIbjwxfH07+vL89b
         5O/1DCxrqllddNAPameCx6hXT0HiKk/nCOvv/lEod5lXiM05+EGU/UZx2TwYe7ulVRRe
         sUTouS1t480WtnfVy1JpMpIEwcHqcPqVcPbOGt/Ok8KAjD4f2N9N0PxmmOjWe/K1hj6t
         ywIdZ53a8Si0czOsKQCTw6eAtLnJXC7HP1cFuRO9hLYhxreZ8XDVU6iIdyRulsseWyhG
         pePYJgJdJ+wcYhXfC+pLFFZIRFhgAf62tmITDNIWFh3hg0gC2Q61kr4YH42fp8x/WjWx
         32tA==
X-Forwarded-Encrypted: i=1; AJvYcCVIfB5HfpqEH922e27Cjcx30aP6O5MdzVLPrGPiBAqHrM0VRl6rSblhFODn8cS5G9O4uKUuGGJOh80mRSZyc5Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1/UizVLwTw4u2ycgmeJmoRU9879iIAA3lGYeGYaoiY8UT7sdc
	4BfyoOuGapGPi+X43nlgs8XHLWQMwygD7dRqIYgsd2DDvlCIRkdVeFzE
X-Gm-Gg: ASbGncsTLl8cSGKXapm9pnsF7DRizmsW6K4yM8wIQvQtp3FcjnBmYY/ifXvIzPBartQ
	LqYjCEO+mQaKKTWzmczst7EWulXqYgZATSYIyR3T+KOtLdkKTg1WKKL0Y5B5CLWOD7C8KzWtoti
	fsT7JAuyS97ShlihUkt1QxY03MoS3I4FwQnDTl4Yft1Yo7mVdaS+asViBUe43F2zmFO8jO4hdTV
	jK8geph/hBLZHeGPEON2a/bW/slcdaV6HUHqkSunyifnT/DsHFGL5kSb39KccrlL2FBcX9ACTUQ
	UJnC953nUB7JUfVfhKJFcF389OVNa19EP/hRdwvhHTBVrskX73ZA/9GxGVM2xcNNLVYtykERlIY
	WSln+jy+vw3Fo6Ch6XDUZaelE8ZzECpJKBEORq1W6BZxYfoVQD4lpMMoCo0cRL74yZpIpptY8
X-Google-Smtp-Source: AGHT+IFNNNmoDMaiLwtDUu3F/l93u30ohFmaZcpwi8LsB2GCj8jLScee70K+1o9ZTJ5T9w+mmGeR0g==
X-Received: by 2002:a05:600c:4709:b0:45b:8477:de1a with SMTP id 5b1f17b1804b1-45dddea648emr170375255e9.7.1757598584916;
        Thu, 11 Sep 2025 06:49:44 -0700 (PDT)
Received: from f4d4888f22f2.ant.amazon.com.com ([15.248.2.27])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e760778915sm2608361f8f.12.2025.09.11.06.49.43
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 11 Sep 2025 06:49:44 -0700 (PDT)
From: Jack Thomson <jackabt.amazon@gmail.com>
To: maz@kernel.org,
	oliver.upton@linux.dev,
	pbonzini@redhat.com
Cc: joey.gouly@arm.com,
	suzuki.poulose@arm.com,
	yuzenghui@huawei.com,
	catalin.marinas@arm.com,
	will@kernel.org,
	shuah@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	isaku.yamahata@intel.com,
	roypat@amazon.co.uk,
	kalyazin@amazon.co.uk,
	jackabt@amazon.com
Subject: [PATCH 2/6] KVM: arm64: Add KVM_PGTABLE_WALK_PRE_FAULT walk flag
Date: Thu, 11 Sep 2025 14:46:44 +0100
Message-Id: <20250911134648.58945-3-jackabt.amazon@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250911134648.58945-1-jackabt.amazon@gmail.com>
References: <20250911134648.58945-1-jackabt.amazon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jack Thomson <jackabt@amazon.com>

Don't return -EAGAIN from stage2_map_walker_try_leaf during
KVM_PRE_FAULT_MEMORY.

During pre-faults, user_abort() is retried upon returning -EAGAIN,
meaning the ioctl would get stuck in an infinite loop if userspace
tries to pre-fault already existing mappings

Signed-off-by: Jack Thomson <jackabt@amazon.com>
---
 arch/arm64/include/asm/kvm_pgtable.h | 3 +++
 arch/arm64/kvm/hyp/pgtable.c         | 6 +++++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/kvm_pgtable.h b/arch/arm64/include/asm/kvm_pgtable.h
index 2888b5d03757..0789671d1c4f 100644
--- a/arch/arm64/include/asm/kvm_pgtable.h
+++ b/arch/arm64/include/asm/kvm_pgtable.h
@@ -296,6 +296,8 @@ typedef bool (*kvm_pgtable_force_pte_cb_t)(u64 addr, u64 end,
  * @KVM_PGTABLE_WALK_SKIP_CMO:		Visit and update table entries
  *					without Cache maintenance
  *					operations required.
+ * @KVM_PGTABLE_WALK_PRE_FAULT		Indicates the page-table walk was
+ *					invoked from a pre-fault request.
  */
 enum kvm_pgtable_walk_flags {
 	KVM_PGTABLE_WALK_LEAF			= BIT(0),
@@ -305,6 +307,7 @@ enum kvm_pgtable_walk_flags {
 	KVM_PGTABLE_WALK_HANDLE_FAULT		= BIT(4),
 	KVM_PGTABLE_WALK_SKIP_BBM_TLBI		= BIT(5),
 	KVM_PGTABLE_WALK_SKIP_CMO		= BIT(6),
+	KVM_PGTABLE_WALK_PRE_FAULT		= BIT(7),
 };
 
 struct kvm_pgtable_visit_ctx {
diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
index c351b4abd5db..140dccec2c5b 100644
--- a/arch/arm64/kvm/hyp/pgtable.c
+++ b/arch/arm64/kvm/hyp/pgtable.c
@@ -914,9 +914,13 @@ static int stage2_map_walker_try_leaf(const struct kvm_pgtable_visit_ctx *ctx,
 	 * same mapping or only change the access permissions. Instead,
 	 * the vCPU will exit one more time from guest if still needed
 	 * and then go through the path of relaxing permissions.
+	 *
+	 * When walking in the context of a pre-fault request, if the
+	 * mapping already exists we can return 0, as there's nothing
+	 * to do.
 	 */
 	if (!stage2_pte_needs_update(ctx->old, new))
-		return -EAGAIN;
+		return (ctx->flags & KVM_PGTABLE_WALK_PRE_FAULT) ? 0 : -EAGAIN;
 
 	/* If we're only changing software bits, then store them and go! */
 	if (!kvm_pgtable_walk_shared(ctx) &&
-- 
2.43.0


