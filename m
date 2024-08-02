Return-Path: <linux-kselftest+bounces-14734-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CBD2946323
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Aug 2024 20:27:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 703571C21457
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Aug 2024 18:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D8241547DA;
	Fri,  2 Aug 2024 18:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EEbJIoLi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f202.google.com (mail-il1-f202.google.com [209.85.166.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB5521C199
	for <linux-kselftest@vger.kernel.org>; Fri,  2 Aug 2024 18:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722623010; cv=none; b=XTxtHCOSdMsfq9q0vUy7zkmJsmIjEyTxz2PaGecnckLrgZRPvADtKKInPxxlddXHYakecCjfXrVTFE27WZe+9OYvhVGdnSp9pQrR56FgYT2xY452l2WE4RYI0o6Z4BUsCcXyEfw8vrqYVfHr7ATqvceXr9nsVAIxelt3SMZTOUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722623010; c=relaxed/simple;
	bh=UOPSp+FZQmDfF+51Ouz9o/l/tRhvkbieD1vkglnMcTs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Ok62SLFg+VNt68Bzt690yAtCEilMzQOHYe5B3DXcUZ8PHUI7S8AjIdCuhFG+b8oFzU6tj1onqDRBHeieMZjyeYfnRFq1DxaGo7pcas8odbqeLllK8EXyBqs/rXkaWBu40Z+w9EX+X86zwSuCeX16XPOpL1Ui90Lys7ocBzLd9iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EEbJIoLi; arc=none smtp.client-ip=209.85.166.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Received: by mail-il1-f202.google.com with SMTP id e9e14a558f8ab-39a29e7099dso126305705ab.3
        for <linux-kselftest@vger.kernel.org>; Fri, 02 Aug 2024 11:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722623006; x=1723227806; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=RRuHJt5f8UEqRhMujJ6ws/U8D/VRWtkp4PLpixwqCfM=;
        b=EEbJIoLi7tDpUs3YagyATJ9PkDEBXm3frUm283OcfDXwaPgkS6eaYiaqQqBVz8Dj7K
         cRMO3FUMR9e12FiZfeZKOo6H0yx8TMhmT8rKQK6y3QDStTQenDI70LnF44dlzGJrJHhD
         rMJFCpq9zfTlwdNoF3KlcLZUwKM/RS1+uIntc1T0zqzbV/4y9I21I4WhoFzHpYQU4Hmm
         fjT0YTD7coohMATEubq6MUbioOgIqrQZsu/o3VwnAk7TyiGKSK9eDEoyE4vT9fyFmGxf
         9fY9Cm23v0qU1GSVn/oIOQVIHEXy7uMjy+LZ92Tv8toDlGcG34VI1jovmM8p5i1Rtmlo
         /hYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722623006; x=1723227806;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RRuHJt5f8UEqRhMujJ6ws/U8D/VRWtkp4PLpixwqCfM=;
        b=YKDsBT1mT9B5wJSXkXjNknl8FrWP1ZEK+277WhpOIt8cniijcbkk5IOG1/AlY5Da2l
         yO1X9BV32tOgirXmHlRupnZRN6FKXaSMTymwRnxcyi76jfqJi3d5ujb7UY2+APN7mjxz
         Fv9pmNjdYXZOaoZld6s9ADpCk9cAYuqxzO0I1SheNCD8MAClCJNJO8Z92Uo1gf49LdIc
         ToONv+7dkN5ukrd7Qipl2czsAR8qk2oZS7VE4wU+kC+pinqCk6dT3N1IgUdjnHu2enhe
         sCdM02Kcivf8IafvZ8ToBMfbCR0KN7k8PoiA3HgKu1LW18Ua75QQqmMNSBcChIFi3nHv
         KAUg==
X-Forwarded-Encrypted: i=1; AJvYcCXavDt+FfMwsmm7MTWUh/VmpN8B8bD4zIWmGWUvoF2MwqEJqmxZxTaHNOqMKXu6FYBw+cGJ1BwWS1O/7GXTupF6X8sJH35uxroqgCPxo4CM
X-Gm-Message-State: AOJu0YznncXwJ7JTG5RBKjgADgyKt8MJkEJEJZlxGoOQXxcjbNko+wbK
	kYKY9vkws80x4xb1zeA95fXjiWYNuo/SLGGgjRkApqRT0yxjPYKbYHk6LnRTxk11kJz7LDCOydC
	rUvV+UbwBmx0nDkz2CASGZA==
X-Google-Smtp-Source: AGHT+IH+qdsE9Pulh3jM+KdRLjaVJ8bLIzcSeaVMDxPEcgK7lwNWqj77zoW2jB061hVe9Kxx3aBXWT8ru/NX+/TVIw==
X-Received: from coltonlewis-kvm.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:14ce])
 (user=coltonlewis job=sendgmr) by 2002:a05:6e02:1561:b0:397:2946:c83c with
 SMTP id e9e14a558f8ab-39b1fc4cdf8mr3543775ab.4.1722623006552; Fri, 02 Aug
 2024 11:23:26 -0700 (PDT)
Date: Fri,  2 Aug 2024 18:22:36 +0000
In-Reply-To: <20240802182240.1916675-1-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240802182240.1916675-1-coltonlewis@google.com>
X-Mailer: git-send-email 2.46.0.rc2.264.g509ed76dc8-goog
Message-ID: <20240802182240.1916675-3-coltonlewis@google.com>
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
2.46.0.rc2.264.g509ed76dc8-goog


