Return-Path: <linux-kselftest+bounces-18117-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4483D97C108
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Sep 2024 22:54:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09F2F283C27
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Sep 2024 20:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B2DF1CB50C;
	Wed, 18 Sep 2024 20:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="14FFCqNg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f73.google.com (mail-io1-f73.google.com [209.85.166.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88571CB316
	for <linux-kselftest@vger.kernel.org>; Wed, 18 Sep 2024 20:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726692842; cv=none; b=CChNjaE412T8Z2ZzrE7JFcyS+9LUraX56pm2yfR8aHpEpIWcwye2iAEUiGL1Dwj/kBUqprK6xoicB2ZBR8Ut0ceJdQM2fU3cBeq+h3xBK6Vf04Gz5znv8eEvX1b1CSeLd8IZ7NjnGZRVi94qIudIJV9/NcWeAOcVhIzEb68oN5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726692842; c=relaxed/simple;
	bh=JPGg+ZlqNk//a2GulWytBxkzfd4Br7410I6/OYnAg4s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UuSknLx/KGT5tFCgIBHjo82OrfVpuscw9XaWu1mQ5AIxcm2aCe3gZhpBdC2h96qPFc160eK+dFPhLWRBt8YUE5snawbya6vn2BMAuinaMmmsYRGnHRV6hyMcrQYCe2Ky0GLAXUcon545nDsFYdd8umGzYzhZA+M/L427blYW6aI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=14FFCqNg; arc=none smtp.client-ip=209.85.166.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Received: by mail-io1-f73.google.com with SMTP id ca18e2360f4ac-82cedb7a183so31130739f.0
        for <linux-kselftest@vger.kernel.org>; Wed, 18 Sep 2024 13:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726692840; x=1727297640; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=J2FbusX2TPbhEhWZxjbHNZM35iEkPfYNW6xaREjlVQ0=;
        b=14FFCqNgqTnCkGZglX6mNKtBQP7o9Rj8pzQCC6EDRe8kqZCS4Aoe7PLGJRSb5DA7Ju
         zG5UgsBxoTX9qP0exYO40pYLHG3xz/Ef90J9qEsS/ZgQlG3d6ZbKU4fccLUa8EfrntaR
         mQ4lNdqd90+AGDM5UiFUtPwXUge4boAp9B/zA2sZNKvE/Wta3C4lgC2F4PlF8ZPAkiKR
         aP2ea/r2qGjREBwOKKYvn42g37xuJNkluCXZGodspzbQXUxhou55qABw0GpViapLsNa6
         QsMY3ZqaE9NRQY0w2DLbSUv2HmdefYl/d6BWApsx320FDAyR6TKgMfW/PKl8AaX8J773
         rCrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726692840; x=1727297640;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J2FbusX2TPbhEhWZxjbHNZM35iEkPfYNW6xaREjlVQ0=;
        b=JZ/YlMgAmSihTD6sXGQLkmizy4m4yPwC9xzhACZiS9n5XxCUaQjquRCxUj3tMCTB3G
         9IUUUQS6WnZDzwApcktFaXS6Hdyd17I8AKqVl0dNLV9/dngubtEhfMoc6vNvmUD63RSv
         odErmp1kde9THP+pLYl7jjlHjyTSPo61HSFnpG5wKZdCV4p+dQfr/MkDYgWe0kkv78ZX
         j0yJUDEwNsyLocXWq3AKiCk9DkrCTnI2tyVUlwjPvc9THXjjvp/67ykQ0fpulXShHO/6
         PpbQwCI+31fv1zlX4kIuxq2qbMRRBjSlUwFPicD7wNetJcc+wvP2EadS40q2wyGdRDYj
         P/EQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4W7LiZ8K7/nIX3ShFNiL1vD7b3SUfB3JoMdBuMGSmP1GeebLSkbl1S+SdgWNntxpti71ewHktMo31GL3/e98=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWhw0fXYwFgR3esEcJC8lNbMkxIJYgMAJ4ZHilNeg17q4hkCZf
	J9E7fRg3T2B9CCFdS3XDrIdbwrnO5g+6sZ8BFTxoH8HcR+iLNG4rghplEMEJ9DS6r6ldM/omW/S
	vh2jzUO6qsgjeRAm3Sp+91A==
X-Google-Smtp-Source: AGHT+IEvUPVfFuL/BWdy23uUJAus9euW9RtBbSMsXFnhdcw15adjkZURp2tQfRtwVR8mu7U0IOUcvqwQaEDvYgdK9w==
X-Received: from coltonlewis-kvm.c.googlers.com ([fda3:e722:ac3:cc00:11b:3898:ac11:fa18])
 (user=coltonlewis job=sendgmr) by 2002:a05:6638:3722:b0:4c0:a8a5:81f5 with
 SMTP id 8926c6da1cb9f-4d361346b3amr476142173.4.1726692839979; Wed, 18 Sep
 2024 13:53:59 -0700 (PDT)
Date: Wed, 18 Sep 2024 20:53:15 +0000
In-Reply-To: <20240918205319.3517569-1-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240918205319.3517569-1-coltonlewis@google.com>
X-Mailer: git-send-email 2.46.0.662.g92d0881bb0-goog
Message-ID: <20240918205319.3517569-3-coltonlewis@google.com>
Subject: [PATCH v2 2/6] KVM: x86: selftests: Define AMD PMU CPUID leaves
From: Colton Lewis <coltonlewis@google.com>
To: kvm@vger.kernel.org
Cc: Mingwei Zhang <mizhang@google.com>, Jinrong Liang <ljr.kernel@gmail.com>, 
	Jim Mattson <jmattson@google.com>, Aaron Lewis <aaronlewis@google.com>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Colton Lewis <coltonlewis@google.com>
Content-Type: text/plain; charset="UTF-8"

This defined the CPUID calls to determine what extensions and
properties are available. AMD reference manual names listed below.

* PerfCtrExtCore (six core counters instead of four)
* PerfCtrExtNB (four counters for northbridge events)
* PerfCtrExtL2I (four counters for L2 cache events)
* PerfMonV2 (support for registers to control multiple
  counters with a single register write)
* LbrAndPmcFreeze (support for freezing last branch recorded stack on
  performance counter overflow)
* NumPerfCtrCore (number of core counters)
* NumPerfCtrNB (number of northbridge counters)

Signed-off-by: Colton Lewis <coltonlewis@google.com>
---
 tools/testing/selftests/kvm/include/x86_64/processor.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/x86_64/processor.h b/tools/testing/selftests/kvm/include/x86_64/processor.h
index a0c1440017bb..44ddfc4c1673 100644
--- a/tools/testing/selftests/kvm/include/x86_64/processor.h
+++ b/tools/testing/selftests/kvm/include/x86_64/processor.h
@@ -183,6 +183,9 @@ struct kvm_x86_cpu_feature {
 #define	X86_FEATURE_GBPAGES		KVM_X86_CPU_FEATURE(0x80000001, 0, EDX, 26)
 #define	X86_FEATURE_RDTSCP		KVM_X86_CPU_FEATURE(0x80000001, 0, EDX, 27)
 #define	X86_FEATURE_LM			KVM_X86_CPU_FEATURE(0x80000001, 0, EDX, 29)
+#define	X86_FEATURE_PERF_CTR_EXT_CORE	KVM_X86_CPU_FEATURE(0x80000001, 0, ECX, 23)
+#define	X86_FEATURE_PERF_CTR_EXT_NB	KVM_X86_CPU_FEATURE(0x80000001, 0, ECX, 24)
+#define	X86_FEATURE_PERF_CTR_EXT_L2I	KVM_X86_CPU_FEATURE(0x80000001, 0, ECX, 28)
 #define	X86_FEATURE_INVTSC		KVM_X86_CPU_FEATURE(0x80000007, 0, EDX, 8)
 #define	X86_FEATURE_RDPRU		KVM_X86_CPU_FEATURE(0x80000008, 0, EBX, 4)
 #define	X86_FEATURE_AMD_IBPB		KVM_X86_CPU_FEATURE(0x80000008, 0, EBX, 12)
@@ -195,6 +198,8 @@ struct kvm_x86_cpu_feature {
 #define	X86_FEATURE_VGIF		KVM_X86_CPU_FEATURE(0x8000000A, 0, EDX, 16)
 #define X86_FEATURE_SEV			KVM_X86_CPU_FEATURE(0x8000001F, 0, EAX, 1)
 #define X86_FEATURE_SEV_ES		KVM_X86_CPU_FEATURE(0x8000001F, 0, EAX, 3)
+#define	X86_FEATURE_PERFMON_V2		KVM_X86_CPU_FEATURE(0x80000022, 0, EAX, 0)
+#define	X86_FEATURE_PERF_LBR_PMC_FREEZE	KVM_X86_CPU_FEATURE(0x80000022, 0, EAX, 2)
 
 /*
  * KVM defined paravirt features.
@@ -281,6 +286,8 @@ struct kvm_x86_cpu_property {
 #define X86_PROPERTY_GUEST_MAX_PHY_ADDR		KVM_X86_CPU_PROPERTY(0x80000008, 0, EAX, 16, 23)
 #define X86_PROPERTY_SEV_C_BIT			KVM_X86_CPU_PROPERTY(0x8000001F, 0, EBX, 0, 5)
 #define X86_PROPERTY_PHYS_ADDR_REDUCTION	KVM_X86_CPU_PROPERTY(0x8000001F, 0, EBX, 6, 11)
+#define X86_PROPERTY_NUM_PERF_CTR_CORE		KVM_X86_CPU_PROPERTY(0x80000022, 0, EBX, 0, 3)
+#define X86_PROPERTY_NUM_PERF_CTR_NB		KVM_X86_CPU_PROPERTY(0x80000022, 0, EBX, 10, 15)
 
 #define X86_PROPERTY_MAX_CENTAUR_LEAF		KVM_X86_CPU_PROPERTY(0xC0000000, 0, EAX, 0, 31)
 
-- 
2.46.0.662.g92d0881bb0-goog


