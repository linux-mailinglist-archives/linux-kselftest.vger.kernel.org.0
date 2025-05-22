Return-Path: <linux-kselftest+bounces-33550-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D7CBAC189B
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 May 2025 01:55:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9301E1721DA
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 May 2025 23:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99D542E3387;
	Thu, 22 May 2025 23:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Gm251MBb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A072DFA4A
	for <linux-kselftest@vger.kernel.org>; Thu, 22 May 2025 23:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747957975; cv=none; b=RxQpv0K5RAb8xA0q377GCmXcqlvOy8cjbdwVnFDHSrxxmVy53w+dU3EBCwWmj3dSRhLmXcMrzyPSEKR2pGnT9RJ5A9QnMQ9BrvgvMdnEhyHCFsIc3M5nZkQQKhNAzHek9twdy6NdTBF5wYa7v7Q0FJUfHAUu0aXJ+r+Zrlkryms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747957975; c=relaxed/simple;
	bh=gmLT2D1WB9vmr8rFdHxMOpHNwXh7MFDJ6xUGtYQhimw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ffLwYXER97s1e5cAHQNEWlP8XK8hL1+mmPYh53umMtZ1s8SraQDwy8wtDlwCibBk0ce27Ez7XF8WmxIZwSuix7KwSIDptMpxviFE36FClFjaJxu7pfR0+m2wGHYorQlci5WJHar5+YXs6RsHygXZvByT75o2gJ7S3pIbezyoE6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Gm251MBb; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-30e895056f0so9151077a91.3
        for <linux-kselftest@vger.kernel.org>; Thu, 22 May 2025 16:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747957972; x=1748562772; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=jjMNjs+bdNtZTb3Wdy6sSLCs56ksmcfEkIHqJR2gBFc=;
        b=Gm251MBbxSTPwRH8ghuckno+ronDdEVl9sRm7VO9nmeiheBfzwBds6nbGRsRwcK7yd
         waCOi+bmfnP5ESrxPGUNt/ILIpm4yL8O/zCKI88eggpbSfA+oP4+ormkJhme3Do7huYt
         w51fnUMn7VRahjSMoyFfxbtlrdSysOJjoqXf4aaAjGu9ZuhkV9ClZw4ax+NqABswOwqX
         FC/W5QndXARcH0lEWopnRD0yHOPHaBneQcYSyuM6VFS04Nw7i9zqLXZVwa7QO2LurjDU
         1d+4C3XWtG+oy3HZFOV0l+GEhj9eyi1UvZUt7mIebsMmWRcqXumfC2Kt6/SF79hAPmrr
         l0UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747957972; x=1748562772;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jjMNjs+bdNtZTb3Wdy6sSLCs56ksmcfEkIHqJR2gBFc=;
        b=kOIbXl2O9IYy4rHEp9zuh5equh7ibKymfwrRHmXHyQcR4fMYyZin5vu+L2cCB+TdVw
         HQ+tSk/NXUO8TO6Yv/371nBPhSpGizfi4CV0FEHHbnU5eoKnY6YNXT2OkAya+LFac/2Z
         PQGOJudNvlAsKtCuDoyAZEkioIr9HWm+cOFYyfo9zGlRC1ZwKWwuKX0EReV8TN9vE6uH
         IEtLvQponbqL7Tf4rfLsYC3wsiM26/gnnCszUCGhs5tRHzwIRUI2Ni49dEnU0z/kmqz3
         if3LIgaSkdfdXGtVwasfw4WHlZEMWYMSXsemiX0ikix2NO49dgEYs6ZAHw4WuTOt7iwI
         5ceg==
X-Forwarded-Encrypted: i=1; AJvYcCW7v4GUoxpH6+L4AdlqW3J6pa7g5gQtrWA4ZZvFnSuAU60+ELL36e72l0gtJosPeUBOyap1XrJ4lYMy3VvYD+Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4qUx+uw0PLZE66BkdJY/ADzsex8PLnHzvOcBzTcED8EM1NOpS
	sJNKSxtdzhgxgfh0FBiGom6i4ta2mZH826d90SoiT6T+HmqZVJBh2JPbIseZXSF3V2iynIRG5bz
	bw58JPg==
X-Google-Smtp-Source: AGHT+IH+y/4Vqk1KMF3LjOCFUbppIPh5ZUErAvUoiEDW2SE/2hXGiqyTLKxlZ9Xh8ZuSjxO0WF45GST49oM=
X-Received: from pjbdy5.prod.google.com ([2002:a17:90b:6c5:b0:2fc:1356:bcc3])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:510f:b0:2ff:58e1:2bb1
 with SMTP id 98e67ed59e1d1-310e973e510mr1311217a91.32.1747957972660; Thu, 22
 May 2025 16:52:52 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 22 May 2025 16:52:21 -0700
In-Reply-To: <20250522235223.3178519-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250522235223.3178519-1-seanjc@google.com>
X-Mailer: git-send-email 2.49.0.1151.ga128411c76-goog
Message-ID: <20250522235223.3178519-12-seanjc@google.com>
Subject: [PATCH v3 11/13] KVM: selftests: Assert that eventfd() succeeds in
 Xen shinfo test
From: Sean Christopherson <seanjc@google.com>
To: "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, 
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, 
	Paolo Bonzini <pbonzini@redhat.com>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Shuah Khan <shuah@kernel.org>, 
	Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Sean Christopherson <seanjc@google.com>
Cc: linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	xen-devel@lists.xenproject.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, K Prateek Nayak <kprateek.nayak@amd.com>, 
	David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="UTF-8"

Assert that eventfd() succeeds in the Xen shinfo test instead of skipping
the associated testcase.  While eventfd() is outside the scope of KVM, KVM
unconditionally selects EVENTFD, i.e. the syscall should always succeed.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/x86/xen_shinfo_test.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86/xen_shinfo_test.c b/tools/testing/selftests/kvm/x86/xen_shinfo_test.c
index 287829f850f7..34d180cf4eed 100644
--- a/tools/testing/selftests/kvm/x86/xen_shinfo_test.c
+++ b/tools/testing/selftests/kvm/x86/xen_shinfo_test.c
@@ -548,14 +548,11 @@ int main(int argc, char *argv[])
 
 	if (do_eventfd_tests) {
 		irq_fd[0] = eventfd(0, 0);
+		TEST_ASSERT(irq_fd[0] >= 0, __KVM_SYSCALL_ERROR("eventfd()", irq_fd[0]));
+
 		irq_fd[1] = eventfd(0, 0);
+		TEST_ASSERT(irq_fd[1] >= 0, __KVM_SYSCALL_ERROR("eventfd()", irq_fd[1]));
 
-		/* Unexpected, but not a KVM failure */
-		if (irq_fd[0] == -1 || irq_fd[1] == -1)
-			do_evtchn_tests = do_eventfd_tests = false;
-	}
-
-	if (do_eventfd_tests) {
 		irq_routes.info.nr = 2;
 
 		irq_routes.entries[0].gsi = 32;
-- 
2.49.0.1151.ga128411c76-goog


