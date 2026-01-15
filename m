Return-Path: <linux-kselftest+bounces-49071-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 001D8D293C0
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jan 2026 00:23:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D73BB30AEEC7
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Jan 2026 23:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AF1E330D35;
	Thu, 15 Jan 2026 23:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ar9iMgRm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A2CF289E06
	for <linux-kselftest@vger.kernel.org>; Thu, 15 Jan 2026 23:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768519338; cv=none; b=H+LoryrHtOD53FI4MlVLidgmUggvzYqXLBBFrf+kgYojnX10GlbRzVjqvcb0v7D688m4950bfoiSXlzoOtxsjm9CQx16W4bNAkQ+oZsPrP2Ol1+QaNLEs/iUktvFNK30IxOuWdeyNompHRhIR/aybuoJMZ9HTHkt76TQzQbQly4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768519338; c=relaxed/simple;
	bh=RW48TPdvb5xAKUsQXmeyEK97Shn/whfhWqOquQdudkY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WDMh86hgawbGSgO4Vg3X9l7vr7GeSKCstD8DPN1nfUkBoJXza7EnV+gwqfD9cgyHGhDZzTK6Emt6sWm7LyjOp1fZBQDCZBs8+UCH0XEINjL17art+qN3BxGWI7+X8I0K11Kvme8E+XG3uwBtfZbHK0/prONjQAXsRWBWI5SXMo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ar9iMgRm; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2a0d59f0198so14903815ad.1
        for <linux-kselftest@vger.kernel.org>; Thu, 15 Jan 2026 15:22:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768519335; x=1769124135; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hfgEug5UPVe3ZZ5958Qf800gsqyZ1Jrc8uLtmlr2csE=;
        b=Ar9iMgRmnrh1Wc8H6dATOsRGGYYYd4CVfdMM+XOTV5Pj+epYwDPzORfcL7rrW2bxdI
         rNKd8qq2ga+qFKLeGEe+Tp4RC7YZlyVly6sgw4jlHh44cCHpf3EcPvnpipIzqSlHFtba
         OnQ2DjogB9TmJo0w/zBxqE3cWU/QE/jOUqAnYEmEx8t/Jvpu1Io2TYAfLSdeLl0uDEYl
         asVxCSh5lE9eNw/C8EyX0T0HqRf+H6a9JXHdE6m5qEvTMmKaJVKT1k9W2wsdb61YdChU
         wbfUjZH1CtTznDkqi0ktroCQYi2eYfUDpGMipfGgwktIvOTFZiao7gjx1SVEAoz5xZcS
         skOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768519335; x=1769124135;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hfgEug5UPVe3ZZ5958Qf800gsqyZ1Jrc8uLtmlr2csE=;
        b=wKMwQLrSlifbV3IzGmDn/4etJg+8uQU6AXfKrZzDzDFScDs9GUkZSRp939NDraEjzg
         OB7vTqUDqgt0Bg+uSaTxItkpJ0XeH65iIMVn9/7DrSG4co7O+am9sPdiNVVQFJ6DclQX
         GTSzdBF8BaeL53QR2LP8pfwep/kPkWzny4cdEPTy0fuMekPAwzrlpyqT7cTXXwyD9sM3
         mWyfSYX2k6b/AvGvWP7NcF2258JbB3l7LYU7Ak1KiUFJ+yHbGXdfP2dVnhVZ7w1mY4s/
         zW3tAWOUMy6sKdUeLySHqdnXKn8Kv686BbVoKx9E2LWQjVAVCfb0Z5C95De5j+uvaX4D
         gchA==
X-Forwarded-Encrypted: i=1; AJvYcCVJ6/n9f3CL5x3obDhQorlO2KxsR2Nmdaq7rHKzpaYCmqVd1O5efbVnj8gHMUCrp2L1AVCacYYhKd+EfFVzCe8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyA9o66GdMJuOel6ccQLZhhrsZwFligICu428XTuW/7ELEY+WXW
	aSo/teg7T9SDg+oCthg5eNEf3jcgNO6VaXgIRyYg0iMmqr7MJY5duxjeAwOgJ4Iy77l6ofG9Z9g
	nO59jb6Kfpaq3ag==
X-Received: from pleo7.prod.google.com ([2002:a17:903:2107:b0:29f:1738:99f3])
 (user=jmattson job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:22cb:b0:295:5da6:6011 with SMTP id d9443c01a7336-2a7174fa899mr10665615ad.11.1768519334810;
 Thu, 15 Jan 2026 15:22:14 -0800 (PST)
Date: Thu, 15 Jan 2026 15:21:41 -0800
In-Reply-To: <20260115232154.3021475-1-jmattson@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260115232154.3021475-1-jmattson@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260115232154.3021475-3-jmattson@google.com>
Subject: [PATCH v2 2/8] KVM: x86: nSVM: Cache g_pat in vmcb_save_area_cached
From: Jim Mattson <jmattson@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Shuah Khan <shuah@kernel.org>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc: Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"

To avoid TOCTTOU issues, all fields in the vmcb12 save area that are
subject to validation must be copied to svm->nested.save prior to
validation, since vmcb12 is writable by the guest. Add g_pat to this set in
preparation for validting it.

Fixes: 3d6368ef580a ("KVM: SVM: Add VMRUN handler")
Signed-off-by: Jim Mattson <jmattson@google.com>
---
 arch/x86/kvm/svm/nested.c | 2 ++
 arch/x86/kvm/svm/svm.h    | 1 +
 2 files changed, 3 insertions(+)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index f295a41ec659..07a57a43fc3b 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -506,6 +506,8 @@ static void __nested_copy_vmcb_save_to_cache(struct vmcb_save_area_cached *to,
 
 	to->dr6 = from->dr6;
 	to->dr7 = from->dr7;
+
+	to->g_pat = from->g_pat;
 }
 
 void nested_copy_vmcb_save_to_cache(struct vcpu_svm *svm,
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index 7d28a739865f..39138378531e 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -145,6 +145,7 @@ struct vmcb_save_area_cached {
 	u64 cr0;
 	u64 dr7;
 	u64 dr6;
+	u64 g_pat;
 };
 
 struct vmcb_ctrl_area_cached {
-- 
2.52.0.457.g6b5491de43-goog


