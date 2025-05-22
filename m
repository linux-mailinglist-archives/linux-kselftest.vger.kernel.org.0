Return-Path: <linux-kselftest+bounces-33549-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A9882AC1897
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 May 2025 01:55:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F47B1C020F9
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 May 2025 23:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE9B72D1F59;
	Thu, 22 May 2025 23:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1Sekf+m9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9FAE2D4B6E
	for <linux-kselftest@vger.kernel.org>; Thu, 22 May 2025 23:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747957973; cv=none; b=oTeaYHWTyX1mHTjZ0rIvw0iS2HLmgqSItOy0MZpHZ0inNhrVphbohAv241xc+nmKOhppAXFRFC8AkVM2+FlDA0n3nP88oZdfDHTDy/ZlQrhLh3uMM6kyV8WGuYYlsgnXkVbDeqyNtaXRSYDi6Kj16dZY6uCiuR4nqRAquS+fK/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747957973; c=relaxed/simple;
	bh=P37+G4c2/Xetu+3X+HtrukOmywQ+BBmCzZW3DWLRSak=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uPuKHxPaPvt6ai2Y3jN4RlP5gP9s8DnZCNVOlvUckzdxcD0QWSmhI0844cUzp/Y0+LJDz3TPFTyB/0duymndqKpFBmbhzGcTGU1ycAzX7TwrqvDu5du0v4t9V+T/s3eQGi4ltt61C8Vws9JHohK9jVlrvtHKBsvMK+dbLuKFvtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1Sekf+m9; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-30ec5cc994eso4775836a91.2
        for <linux-kselftest@vger.kernel.org>; Thu, 22 May 2025 16:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747957971; x=1748562771; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=pJUovYaxFJgcXRp1TDFKS/NrFefgEp1AkGzEV1OM9Zc=;
        b=1Sekf+m9GkXG15cXDUMyCMD51s3BnD9WoIxFeWw5vLuRptVdU/uXyPjCz/SCAEqHHN
         0AzLN1TH4qZiY4z8w5yjG32rRgpSPndz5EPnnLOQ1TMe9NRwfWSvruPPZyzVnDaTh/q5
         vvvStG7IcHJAOS9zC5bU6x/90qdqPm0lgTrZhvEtK0SYsYXW3OHIvIxtsxeo+O+hwIFE
         rAL6r5r1par1TFEweY4yfZFor1c/oTqCCEiDoOC8+XAOiIBrl2KR9RRJExE+ABH/L5S+
         +euBQR6f6p25nUNARjqefdJRJ090BsZLawko2yPLN/g8yFgVL81ok6c6HQZNOppDfGrb
         GQ9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747957971; x=1748562771;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pJUovYaxFJgcXRp1TDFKS/NrFefgEp1AkGzEV1OM9Zc=;
        b=AngAftIouWaxqPfqeVjKBPSlHLeCD14pfxdrCONooKtcxedlLqrq4PJb/bIWJK9o2C
         wD3bMKenexUrOqa5iPTnOG4yD/YXweKHn0WHek3WVXRFP8Kvekqv8wyau+5tq0Syw0gI
         R2lBI3Vc+i4DXpqVAHRplALImEW0S2PgiAcLg2zhAf+/YQgGOj0L3cSTlYI2/J+Osccv
         SRwdzMdrt4wL2T2ObZx9Mn3iCJM77Iep5rU4NnZhhVzk2ayJFbG8e+e22O2WxtA9+mXN
         CmMiufxI0Gc08/bPqUcNTjDZFmBf6TydyzBQYw4g79X+mgji5TXyPXonhzAKpMgRhhYb
         eSbw==
X-Forwarded-Encrypted: i=1; AJvYcCU/hcyN8B77ZLM7eevsZXZ6s+E5rhnwVmbjFEFXqVIF06nhbRDC+x8gtVkwiuSOXxxH0a+JMz+vUny16tSF/0A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXvs4yPJGI9nt10RjfMz/mahTZh8ZMa9l9+CNf77c7bH1V1/71
	/r6Q2sQFfBCx8Kj/kzKAiwtGLuW0TGfcRH9A9tz9XB+nYiNoAytZVWm9qfxO6iOnsZbDw9LUD97
	EvuuiRQ==
X-Google-Smtp-Source: AGHT+IEDndqxTWcCtq5oGwy52YECfaW+Ize1PqvGwCK7FSF7/oiShVYNO6fCIsKX/sBpVCvd/V18cyz4IiY=
X-Received: from pjx8.prod.google.com ([2002:a17:90b:5688:b0:30a:31eb:ec8e])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:33c2:b0:2ee:edae:780
 with SMTP id 98e67ed59e1d1-30e7d548c90mr43873310a91.15.1747957970976; Thu, 22
 May 2025 16:52:50 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 22 May 2025 16:52:20 -0700
In-Reply-To: <20250522235223.3178519-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250522235223.3178519-1-seanjc@google.com>
X-Mailer: git-send-email 2.49.0.1151.ga128411c76-goog
Message-ID: <20250522235223.3178519-11-seanjc@google.com>
Subject: [PATCH v3 10/13] KVM: Drop sanity check that per-VM list of irqfds is unique
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

Now that the eventfd's waitqueue ensures it has at most one priority
waiter, i.e. prevents KVM from binding multiple irqfds to one eventfd,
drop KVM's sanity check that eventfds are unique for a single VM.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 virt/kvm/eventfd.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/virt/kvm/eventfd.c b/virt/kvm/eventfd.c
index 7b2e1f858f6d..d5258fd16033 100644
--- a/virt/kvm/eventfd.c
+++ b/virt/kvm/eventfd.c
@@ -288,7 +288,6 @@ static void kvm_irqfd_register(struct file *file, wait_queue_head_t *wqh,
 {
 	struct kvm_irqfd_pt *p = container_of(pt, struct kvm_irqfd_pt, pt);
 	struct kvm_kernel_irqfd *irqfd = p->irqfd;
-	struct kvm_kernel_irqfd *tmp;
 	struct kvm *kvm = p->kvm;
 
 	/*
@@ -328,16 +327,6 @@ static void kvm_irqfd_register(struct file *file, wait_queue_head_t *wqh,
 	if (p->ret)
 		goto out;
 
-	list_for_each_entry(tmp, &kvm->irqfds.items, list) {
-		if (irqfd->eventfd != tmp->eventfd)
-			continue;
-
-		WARN_ON_ONCE(1);
-		/* This fd is used for another irq already. */
-		p->ret = -EBUSY;
-		goto out;
-	}
-
 	list_add_tail(&irqfd->list, &kvm->irqfds.items);
 
 out:
-- 
2.49.0.1151.ga128411c76-goog


