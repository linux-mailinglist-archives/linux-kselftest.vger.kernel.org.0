Return-Path: <linux-kselftest+bounces-48808-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C6BFD15FE4
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Jan 2026 01:30:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5F8AD3028D79
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Jan 2026 00:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B69020298C;
	Tue, 13 Jan 2026 00:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XxyHPfgB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4481D21C175
	for <linux-kselftest@vger.kernel.org>; Tue, 13 Jan 2026 00:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768264239; cv=none; b=k6t3BKLBM0bp0kWPq9DRg3d4PXT/MDgcqKei5q4hWxcDkwdcaqnOQLCIDKncjYplRR7V2NUESQYkryqxEjOVizD+XbpGhpft0nCTDFs/+qZa3uNCvLGsPNifnvkAX0GL5UTe0sCA13Bje9JHkxhpe5+8JRg5KG+7kR1HdAV7seM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768264239; c=relaxed/simple;
	bh=Qw7/+Bv+ZJMD1kWAfR4J104CN2SSeKSLv6Ry8RHEadY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HFRssbEUasCgf8o6yA4uELGPFgydFcajZ9RyAo+Z+eVApQTtMZtXu9mtd5nJjSI3zkwjIqdNOJRgk4XnelK6GuQKvV2d7tXNGlKDr6ggxp9l/iOuutOnkl7PsU2Y5aPYIo/0Y9ccmL8KhjfXWby9ACgrzbQ5uxxWm/NoF6JTuRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XxyHPfgB; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-81f4c1412b8so3950379b3a.2
        for <linux-kselftest@vger.kernel.org>; Mon, 12 Jan 2026 16:30:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768264237; x=1768869037; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NJJK++kQXOUcZj8a61efcbFZJy/eWmOFKG52r9Uc6nI=;
        b=XxyHPfgBIJi7r9yQ/TQJtNm85iewA0WxJFyBUiOm/X2KTne5JRi6W8vM1jPUFmsZhz
         74Z2fai4DoJ/rSoQEB5sshAJuLfFbpsJ7GpqNOwKhfH0Css2xj3J0f8ZHZPAZHGyZk7P
         O1bJHQrK3ETkNeusFyADwPIbxQxJ4PDyM76LRRG0MS/W24aksYWhDPY82f2rXAuNhelf
         PdJFth4TDaCZinVhEAgoC47A69NHlMNYLnZUDWxpUc8M5JXU4Mc1S+enL/iHUj+O1xkp
         sypge4SyFEcKR8YxbgLoarOc06HTAHMzmDoTOr0aVpSHoZa7rk76HadGZr9ZD2Zq5oe/
         pW7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768264237; x=1768869037;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NJJK++kQXOUcZj8a61efcbFZJy/eWmOFKG52r9Uc6nI=;
        b=QvCpEZQ5paGsER80D7rJnstvYqkPwH97/Khmb78oLAkkpCIupHuUGKCBUT0ky7UKZ1
         /iZJKn97ic6nv1Qfsc25HaywB5OHnDzY9SKWguYPVNB8QoAb/SHJB+YXbitydijBOQBE
         T8LnuRvnvsvb2c/pgNuNo/U4BP39Or7vQoBUljVjWJZNX7dWdnBxkuRK9UUPuiBU14mn
         5J6h2HaSefQJUH/UwjZrydH/yVdHkG+ryepFvt2Wm6UC0La+l3W6dRGwuy49Td1pQETx
         iO8buZb/EEP6M0AmCQOYSfN3NbyKzcWFnzqd42WM1vbMetNfxmMTomUoxZ9pLaxZLf2P
         7fww==
X-Forwarded-Encrypted: i=1; AJvYcCWM73Fj7D6NsgNJMEP6PEetl2kRjTSYzdasR/TLq49AomsyWHeISsUAQwqQPopzW7k4Pc76ZAYn5nQavJ81Z4Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmC4gCdlL7ZCnmll7KDzck9nkpBjgc7qLaISZQB3bvadMpDP8W
	+zmeDkikWsn6m96NetOAOgeVvLd5+IB5VhnKqJBp+R+Yx0ohhGurNGX09ZKGZSzTfO8wzpGVL66
	Z+pbteXZGZxA0mQ==
X-Google-Smtp-Source: AGHT+IGlqf3uE+IOk+ACZvlvsBJ+IigHxAa28NV4eSMRzjniHzTxU8YuH79977ClSL3jQcvpvl3/eJaX3Kig8Q==
X-Received: from pgeh4.prod.google.com ([2002:a05:6a02:53c4:b0:bd9:a349:94c3])
 (user=jmattson job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:329e:b0:35f:2293:877f with SMTP id adf61e73a8af0-3898f923821mr19441748637.33.1768264237450;
 Mon, 12 Jan 2026 16:30:37 -0800 (PST)
Date: Mon, 12 Jan 2026 16:29:56 -0800
In-Reply-To: <20260113003016.3511895-1-jmattson@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260113003016.3511895-1-jmattson@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260113003016.3511895-2-jmattson@google.com>
Subject: [PATCH 01/10] KVM: x86: nSVM: Add g_pat to fields copied by svm_copy_vmrun_state()
From: Jim Mattson <jmattson@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Shuah Khan <shuah@kernel.org>, Joerg Roedel <joro@8bytes.org>, 
	Avi Kivity <avi@redhat.com>, Alexander Graf <agraf@suse.de>, 
	"=?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?=" <rkrcmar@redhat.com>, David Hildenbrand <david@kernel.org>, Cathy Avery <cavery@redhat.com>, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Cc: Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"

The vmcb01 g_pat field holds the value of L1's IA32_PAT MSR. To
preserve this value through virtual SMM and serialization, add g_pat
to the fields copied by svm_copy_vmrun_state().

Signed-off-by: Jim Mattson <jmattson@google.com>
---
 arch/x86/kvm/svm/nested.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index f295a41ec659..a0e5bf1aba52 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -1090,6 +1090,7 @@ void svm_copy_vmrun_state(struct vmcb_save_area *to_save,
 	to_save->gdtr = from_save->gdtr;
 	to_save->idtr = from_save->idtr;
 	to_save->rflags = from_save->rflags | X86_EFLAGS_FIXED;
+	to_save->g_pat = from_save->g_pat;
 	to_save->efer = from_save->efer;
 	to_save->cr0 = from_save->cr0;
 	to_save->cr3 = from_save->cr3;
-- 
2.52.0.457.g6b5491de43-goog


