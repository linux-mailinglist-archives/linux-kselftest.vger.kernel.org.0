Return-Path: <linux-kselftest+bounces-31423-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1389BA992DD
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Apr 2025 17:50:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 230971672BC
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Apr 2025 15:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3CBD2820D7;
	Wed, 23 Apr 2025 15:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S7N59Ytr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A9BC2820AC
	for <linux-kselftest@vger.kernel.org>; Wed, 23 Apr 2025 15:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745422168; cv=none; b=bxS8iXHrcuFuv24LYll3e6v0PHTjwZu+rTY3MWd5hxTHZU/grKVY2gHxr70vc4/WS+VofBQhb7/QGl/P6oENmY86D/zGLGGC5pf0j4g1fvS5ZkN42pzQEY3OvX7va9VeLDdB8i9BK9tKM7tgvpZIVlSRpj6uwLXqq3yX/xwJE0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745422168; c=relaxed/simple;
	bh=7tyYd8/WWjtTTKFWw+oD7+lCXM1UFswEbQCLL4JpYK0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PDu5F22BqlDqxN44ShIYfv5lQuQzCi814Vy4o8It7/21e7JHlJDKvnnqgo3NGcZNW+UZezah+c7vwMDX7LWGRFF9+c/X6kVOxuDUXeiJVn0CLHKxlPmPYEdkTlNWRP11hfRn5SQ1k/UdS16/JbQtBg6r9CczYAdwjMM+aJQjAr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=S7N59Ytr; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-73917303082so4610322b3a.3
        for <linux-kselftest@vger.kernel.org>; Wed, 23 Apr 2025 08:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745422166; x=1746026966; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e/ciVbsL9E+/civAz5HmUVHufr3bRpQ65pGuVHW5bCE=;
        b=S7N59YtrrV2feCtuOZmHnccLusxUXrTckzletlGn9Pw3RdnSKJ5+ss0zjnwj1cgn25
         yYQmoc5tGP1Z/bATT8LIi1qnfGK3gq+Fqg8m2Wfz5Xk3wnmoD5zimXC9707ZbQytOR+7
         o18G9mzJ+ExkHaXuwqsrOg+9vo9wWRlECdGOXDFqOtUdm3xNFZL5pwCHli/W3j297bOs
         wAj7xAsR+bbOFRpVDEVCQRC0Z7kWduN89Fj3PgiKr+SN+BeC1ZO/JQ5lBBQkK/BuM7XF
         b6J1vRKB9iCfRzP4Rlvh/PZbcGFLuyNszzXDL4xehpErXVfGnQQWyF11py1PzsVkHdEV
         5jdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745422166; x=1746026966;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=e/ciVbsL9E+/civAz5HmUVHufr3bRpQ65pGuVHW5bCE=;
        b=vFTOZfyyh6lJt7FKkvRCtcXySkV5tXJYQtwsJoPEcEox5MVaGTRBcdrzy9MqCSlr1/
         3VLrnR5LMe7tUrNK/f3Mj2MvOyE/Gy7Zn3RjaTrtquq67No/B8eF3F6jiTGn1YZpCmbj
         WXNqf07sKZDLsfSsR0h5TFRT5KWpBLy9+UuWArNo1mUh7I0qlBsrBvWdD8z7O4cjyUej
         1LtI7g1hM3CqVAoSyob3zWToJt5pet4+mbto6uJ+Wd4MDuge+NXc4tt5fVtnm2ppkkFl
         BlTcD2igKfqGYO3jxLh5r7WBkB6f/WjJyvsr9hdrhYV/htd+21IjifXtp79i8p7/DPsU
         9jxQ==
X-Forwarded-Encrypted: i=1; AJvYcCWlUmHElnro0gJeWhlvh5dg2U8JNIlo7zdKRHk1ssQZsNZqNKzJsnpS5u8kn3BxYTElPP1GRNswUZptdBZifW8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLixURKylWgSK8zpM7KpBQG6PEGeT9NDFCw+oyctkIkdYU1WK5
	7PbdQCBYFYhVleny+E5YUaBtVyEkgSpyljPx4ma6/J/bcX3bgA+5EHad5y7G2t4bBaMCTvujU7H
	d/Q==
X-Google-Smtp-Source: AGHT+IFvMyzHs0jMD7T18ZwTYJ9lm8AXPz2gW99+UB2nn3KAXaBAX+lpyE8o2K/04Z7bT0N2PiSTsZCjzB8=
X-Received: from pfbem8.prod.google.com ([2002:a05:6a00:3748:b0:739:9e9:feea])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3e28:b0:736:4bd3:ffab
 with SMTP id d2e1a72fcca58-73dc1591d84mr25297228b3a.17.1745422166356; Wed, 23
 Apr 2025 08:29:26 -0700 (PDT)
Date: Wed, 23 Apr 2025 08:29:24 -0700
In-Reply-To: <52276154-79b0-4029-8087-77ca499a12ce@amd.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250324130248.126036-1-manali.shukla@amd.com>
 <20250324130248.126036-4-manali.shukla@amd.com> <b03f3593-e56b-4a98-8ddd-e54fe7885c81@intel.com>
 <52276154-79b0-4029-8087-77ca499a12ce@amd.com>
Message-ID: <aAkHVFTqybGc-mc8@google.com>
Subject: Re: [PATCH v4 3/5] KVM: SVM: Enable Bus lock threshold exit
From: Sean Christopherson <seanjc@google.com>
To: Manali Shukla <manali.shukla@amd.com>
Cc: Xiaoyao Li <xiaoyao.li@intel.com>, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, pbonzini@redhat.com, nikunj@amd.com, 
	thomas.lendacky@amd.com, bp@alien8.de
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 23, 2025, Manali Shukla wrote:
> On 4/16/2025 11:30 AM, Xiaoyao Li wrote:
> >> =C2=A0 +=C2=A0=C2=A0=C2=A0 if (cpu_feature_enabled(X86_FEATURE_BUS_LOC=
K_THRESHOLD)) {
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pr_info("Bus Lock Threshol=
d supported\n");
> >=20
> > It will be printed every time kvm-amd.ko module gets loaded.
> >=20
> > I think it's for your development and debug purpose. Comparing to the
> > existing features in svm_set_cpu_caps(), nothing makes it special for
> > BUS_LOCK_THRESHOLD to require a kernel message. So I think we can just
> > remove it.
>=20
> I didn't add this for development and debug purpose. I added this pr_info=
()
> to make it easy to find whether BUS Lock threshold is supported or not fr=
om
> dmesg.  I can remove it if you think it is not required.

Please remove it.  The user typically doesn't care.

> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kvm_caps.has_bus_lock_exit=
 =3D true;
> >=20
> > Besides, this patch doesn't ensure the bisectability. It allows userspa=
ce
> > to enable KVM_BUS_LOCK_DETECTION_EXIT and set intercept of
> > INTERCEPT_BUSLOCK but without providing the handler.
> >=20
> > So either move next patch before it or just merge them.
> >=20
>=20
> Oh.., my bad, I will move the next patch before this one in v5.

No, do exactly as I suggested in v3.

 : I vote to split this into two patches: one to add the architectural coll=
ateral,
 : with the above as the changelog, and a second to actually implement supp=
ort in
 : KVM.  Having the above background is useful, but it makes it quite hard =
to find
 : information on the KVM design and implementation.

I want this (and any other arch collateral I'm missing) in a separate patch=
 so
that the background on what the hardware feature does is captured.  But I s=
ee no
reason to split KVM's implementation into multiple patches.

diff --git a/arch/x86/include/asm/svm.h b/arch/x86/include/asm/svm.h
index 2b59b9951c90..d1819c564b1c 100644
--- a/arch/x86/include/asm/svm.h
+++ b/arch/x86/include/asm/svm.h
@@ -116,6 +116,7 @@ enum {
        INTERCEPT_INVPCID,
        INTERCEPT_MCOMMIT,
        INTERCEPT_TLBSYNC,
+       INTERCEPT_BUSLOCK,
 };


@@ -158,7 +159,9 @@ struct __attribute__ ((__packed__)) vmcb_control_area {
        u64 avic_physical_id;   /* Offset 0xf8 */
        u8 reserved_7[8];
        u64 vmsa_pa;            /* Used for an SEV-ES guest */
-       u8 reserved_8[720];
+       u8 reserved_8[16];
+       u16 bus_lock_counter;   /* Offset 0x120 */
+       u8 reserved_9[702];
        /*
         * Offset 0x3e0, 32 bytes reserved
         * for use by hypervisor/software.
diff --git a/arch/x86/include/uapi/asm/svm.h b/arch/x86/include/uapi/asm/sv=
m.h
index 1814b413fd57..abf6aed88cee 100644
--- a/arch/x86/include/uapi/asm/svm.h
+++ b/arch/x86/include/uapi/asm/svm.h
@@ -95,6 +95,7 @@
 #define SVM_EXIT_CR14_WRITE_TRAP               0x09e
 #define SVM_EXIT_CR15_WRITE_TRAP               0x09f
 #define SVM_EXIT_INVPCID       0x0a2
+#define SVM_EXIT_BUS_LOCK                      0x0a5
 #define SVM_EXIT_NPF           0x400
 #define SVM_EXIT_AVIC_INCOMPLETE_IPI           0x401
 #define SVM_EXIT_AVIC_UNACCELERATED_ACCESS     0x402
@@ -224,6 +225,7 @@
        { SVM_EXIT_CR4_WRITE_TRAP,      "write_cr4_trap" }, \
        { SVM_EXIT_CR8_WRITE_TRAP,      "write_cr8_trap" }, \
        { SVM_EXIT_INVPCID,     "invpcid" }, \
+       { SVM_EXIT_BUS_LOCK,     "buslock" }, \
        { SVM_EXIT_NPF,         "npf" }, \
        { SVM_EXIT_AVIC_INCOMPLETE_IPI,         "avic_incomplete_ipi" }, \
        { SVM_EXIT_AVIC_UNACCELERATED_ACCESS,   "avic_unaccelerated_access"=
 }, \


