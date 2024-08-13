Return-Path: <linux-kselftest+bounces-15244-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E3A91950A94
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Aug 2024 18:43:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41FD0B22BE9
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Aug 2024 16:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFB4F1A2C14;
	Tue, 13 Aug 2024 16:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0o6diiGw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f201.google.com (mail-il1-f201.google.com [209.85.166.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 607661CA9F
	for <linux-kselftest@vger.kernel.org>; Tue, 13 Aug 2024 16:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723567397; cv=none; b=kZ40YHvjJHiyiiehULQ1DlJ6P2adby0A1Fm2N/HhBodg8NQ94A4KisT0Folaq98tuwPh+sPoznTb9g7eG/YttR5cduHhf3Otfe5ANSXu9IXXOMShNZcdLzuO+xMNgZsXIJdRcChPdORDxR9kpmOI71K6dZrLjPeYBOO8aZnJ+ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723567397; c=relaxed/simple;
	bh=+8Jotfh4jL/fBqNPpnZwk5SliEZbhTClP2DNYMZh29I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ioaqzeafZRciPGs2DmN0/aZ38dwuOiN0BEF+cKnbDCWw/32/OUd4WKd69jWm8NZ0gWQHoI+KtVCiuCWhp+PJRkcVPWUpr8okYKEHeRifLYK9LwXgHTNfSZ67uxSf7DV34fVEjKI+HFVSVZnhyq3YYJfViJKijjyX4OSFcksa2YY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0o6diiGw; arc=none smtp.client-ip=209.85.166.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Received: by mail-il1-f201.google.com with SMTP id e9e14a558f8ab-39915b8e08dso81603925ab.0
        for <linux-kselftest@vger.kernel.org>; Tue, 13 Aug 2024 09:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723567395; x=1724172195; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=O4hjHwnogfh1FVF5nIyMDpPAAJmvxrrYhDd4vDZwnNI=;
        b=0o6diiGwJcbDZnsecGRejYYWJJq5uZL6FGcnkSpSBVeV89y4DNGAMxf2i9C6MbzIJ7
         e4nsJDgRY1rBnERGfp6z01Ai5GHTcG7Ss3cXrlPp4ACfkQelQbvj+3euO9MS5SO6dZdA
         jQ0D9q7yl9x537VO64bVxmyGNsLl29yv5KAydNOTnTp5kgeQsdXx/84XUn5XuQReyc4h
         wUxzo9u1Jf3QhZwwJHSPHmk+NhhH9XgjKonnNDzmdV0lY2FAHbpqvom5jJGroTxW1RiL
         Xn0Uu3/5HSd/qf46rebeDAahH3Lea9H2hcvQAJ6VRKzbvpt7DvLx9ddujzOpYWZHYewO
         YFxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723567395; x=1724172195;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O4hjHwnogfh1FVF5nIyMDpPAAJmvxrrYhDd4vDZwnNI=;
        b=e7QAm+FppIkThdOmAG4tGufVja1qtRVnXyrdjspjeZoCY7wpG1xv3jUckj62hlODjc
         jj+Qlz6wCuoTIQ9bTBmdp358+55sM6RNwCBAUYHVdGD+ClVGmlho2GfJHX4bRS5jHGOC
         NqPGejnAwrE3eX4kmdnums/hWjGcQ1AF1P76ic9Hoe4qSwMHwX8RmRENbIe46aQo0HEa
         AtWc46Z4x649sfGvF7acHsVkW/+DQva81CtYsgJyTeM+R+6pvCEfUmjRVlpe6zhvrlLL
         USj6YC6oWrlg2b2f0cPTJgn22oSVbGjzuFXLNYuLC9E83DpJP75JuGfffpne8CrZ+xZN
         J4LA==
X-Forwarded-Encrypted: i=1; AJvYcCUH8AymTZm1Rj7lnHzpjh87xGUB+9cUSC4I4xCpNFnOpXvi4hmSmINCIdTRFcNW+C8exRA6jSqPGlIeNumedU4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWwmMK3i7dUmzMCYhke3JuEzVkK3ReP0OiYpccuC1vWTjluzQG
	lWwAJO8UhH0CPQziX30TLCggksyWOzc9hytLzny46oIjn+q3jp1g3gz67yP7fGm2jWQMdM/ciiw
	ZSJdghbJ9DCt07ezuZ79FpQ==
X-Google-Smtp-Source: AGHT+IH9sFuwwZm2IzNPjr75f0WTGkljO5daIy5Ohio798p0uPQPFiZA8ni/huUlI+/Kd2HlFr4VhkfAuQWlzAKSFw==
X-Received: from coltonlewis-kvm.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:14ce])
 (user=coltonlewis job=sendgmr) by 2002:a05:6e02:12e1:b0:39a:e800:eec9 with
 SMTP id e9e14a558f8ab-39d124ce491mr169325ab.4.1723567395730; Tue, 13 Aug 2024
 09:43:15 -0700 (PDT)
Date: Tue, 13 Aug 2024 16:42:40 +0000
In-Reply-To: <20240813164244.751597-1-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240813164244.751597-1-coltonlewis@google.com>
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
Message-ID: <20240813164244.751597-3-coltonlewis@google.com>
Subject: [PATCH 2/6] KVM: x86: selftests: Define AMD PMU CPUID leaves
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
index a0c1440017bb..9d87b5f8974f 100644
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
+#define	X86_FEATURE_PERF_MON_V2		KVM_X86_CPU_FEATURE(0x80000022, 0, EAX, 0)
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
2.46.0.76.ge559c4bf1a-goog


