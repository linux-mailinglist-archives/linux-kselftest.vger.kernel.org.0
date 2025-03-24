Return-Path: <linux-kselftest+bounces-29679-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42D38A6E154
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Mar 2025 18:45:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F598189A069
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Mar 2025 17:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C732D26A0FC;
	Mon, 24 Mar 2025 17:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TrORQrF+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D94A526A0B0
	for <linux-kselftest@vger.kernel.org>; Mon, 24 Mar 2025 17:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742837619; cv=none; b=T+JHC9jJvCaDlabiBE3suSSx/JtnD9WQuXFESBXMUERekkZeKiwO18VA59IUSFFitYYREOS5idXeJyU1XOBW59SJUlrhmoPcGZukh5D2dxZ19Z6Ew2sW2mmlrj+TT5/LBbCP/vgIbw2G21JF0u/fWy3e5K0Lzah7QtOjTiYE5bM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742837619; c=relaxed/simple;
	bh=ivxGMo1giylgI8Vx9v7Az7fbPzotpOqbVmQ+M+xadOE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=USm+FNKfIeLG7XlJ1EvdCIMhrxY7aDWQCjWfHmyQZJ6WqT++sIGYJgcM5djMLkcfba6jnm9CxXMydBpvFON3h3aJhPBgKQgIqgWNRWHVB0elfXMRXYw8xAGwDL+CxJAR7tWze42Evggpacb++VpwIOmKO6SH8Rph5wtMACk5tA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TrORQrF+; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2ff62f96b10so8547920a91.0
        for <linux-kselftest@vger.kernel.org>; Mon, 24 Mar 2025 10:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742837617; x=1743442417; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=7tcfTvJa2x4r0LER3JMCH4ud8u11Uq3+9z/wHx+U/XQ=;
        b=TrORQrF+eaRefoHZrSYCjtjLO2o/lp0Nei0jMVrixSOtnEW3tIajPCEqCAiJkRWJnT
         tLVSgnFBMD87H8CnXwM91VC1hces2rXC9/5FO7gXstN7v7pEweeVxumEW9BmN/dOgTXh
         SkWUsr6Z0GWfFTo4Zjzm2C5AWwJuQqgyxRJkdbvfNxikFxnZuNWiNtwA2bO8yGWBQU9U
         3qRpJEEMdNVgodWueo6DMUO8KLDM+zPDQN5dFMAHUtMxXBptJLRJ84Wx2zG/JnPq15hI
         mp+I63E7Wfwd97adcqXIXEVs1TbExi349XqrwepRK1bc7+KsjCoiFSBc153mfDgsrWDU
         AMPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742837617; x=1743442417;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7tcfTvJa2x4r0LER3JMCH4ud8u11Uq3+9z/wHx+U/XQ=;
        b=UgYS/Fq6BcsWLspGE9KsJUbAAR8+mTQL4/zxXSUcWSiwnnGRzGhGMLzAjkShYJIelK
         8+PUxiW+KUvNjiedefoD5Ogl9cfJTgYQUoTt2D5QQDCjbbExsFElpBAs99fc1AndUOey
         8qrzsF5RaxJ+nZaWfX295ELNXm8HPrtnuTXF2OMWVYnaGCx36i0DdSPoSByK5/Tqca+4
         ImL7/TZfIxNe6IruWeEunduJTPXI7B6l6rxQBAf0RU8kqKCMgPnSWI6DeTHsHdoV9ry7
         wn6a4th9bbVl7K56bdg5ls/IHN17n6VvnU5NZUqE6AYuiuSeED944+Si5qMgnnj80I/+
         sLkw==
X-Forwarded-Encrypted: i=1; AJvYcCWMjmhBpTzPkJIfdifreUmxSmyRKRFDokWNEpnP9G2/gw5NUVPTgf/IY+edmGQmpWp/5P1zau2Hv8fGfHdXv7o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJ7CNVLIKWNf3B6AOxXaPzED2/URVD0ekBggPGVIp/EWwkIzvN
	sPsos0dv7P0DNZxMwa5GUrNXZNL9QfsWR3iX5npF7mf/g19cyYkbw1Nhr38N+2MNdXx0sdDpK7O
	n9LU1nw==
X-Google-Smtp-Source: AGHT+IG8VOxNV1nd1KcRz6bwFYrN07riyfvl55OXKVLtIrvOisrrUSvNGUFvmnaAyN7tlAD9BenuAvVLWJLD
X-Received: from pjbnb5.prod.google.com ([2002:a17:90b:35c5:b0:2fa:1481:81f5])
 (user=mizhang job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:224d:b0:2fa:3174:e344
 with SMTP id 98e67ed59e1d1-301d43a21f5mr24824003a91.14.1742837617363; Mon, 24
 Mar 2025 10:33:37 -0700 (PDT)
Reply-To: Mingwei Zhang <mizhang@google.com>
Date: Mon, 24 Mar 2025 17:31:08 +0000
In-Reply-To: <20250324173121.1275209-1-mizhang@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250324173121.1275209-1-mizhang@google.com>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Message-ID: <20250324173121.1275209-29-mizhang@google.com>
Subject: [PATCH v4 28/38] KVM: x86/pmu/svm: Set GuestOnly bit and clear
 HostOnly bit when guest writes to event selectors
From: Mingwei Zhang <mizhang@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, Liang@google.com, 
	Kan <kan.liang@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Mingwei Zhang <mizhang@google.com>, Yongwei Ma <yongwei.ma@intel.com>, 
	Xiong Zhang <xiong.y.zhang@linux.intel.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Jim Mattson <jmattson@google.com>, Sandipan Das <sandipan.das@amd.com>, 
	Zide Chen <zide.chen@intel.com>, Eranian Stephane <eranian@google.com>, 
	Das Sandipan <Sandipan.Das@amd.com>, Shukla Manali <Manali.Shukla@amd.com>, 
	Nikunj Dadhania <nikunj.dadhania@amd.com>
Content-Type: text/plain; charset="UTF-8"

From: Sandipan Das <sandipan.das@amd.com>

On AMD platforms, there is no way to restore PerfCntrGlobalCtl at
VM-Entry or clear it at VM-Exit. Since the register states will be
restored before entering and saved after exiting guest context, the
counters can keep ticking and even overflow leading to chaos while
still in host context.

To avoid this, intecept event selectors, which is already done by mediated
PMU. In addition, always set the GuestOnly bit and clear the HostOnly bit
for PMU selectors on AMD. Doing so allows the counters run only in guest
context even if their enable bits are still set after VM exit and before
host/guest PMU context switch.

Signed-off-by: Sandipan Das <sandipan.das@amd.com>
Signed-off-by: Mingwei Zhang <mizhang@google.com>
---
 arch/x86/kvm/svm/pmu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/svm/pmu.c b/arch/x86/kvm/svm/pmu.c
index 9feaca739b96..1a7e3a897fdf 100644
--- a/arch/x86/kvm/svm/pmu.c
+++ b/arch/x86/kvm/svm/pmu.c
@@ -165,7 +165,8 @@ static int amd_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 		data &= ~pmu->reserved_bits;
 		if (data != pmc->eventsel) {
 			pmc->eventsel = data;
-			pmc->eventsel_hw = data;
+			pmc->eventsel_hw = (data & ~AMD64_EVENTSEL_HOSTONLY) |
+					   AMD64_EVENTSEL_GUESTONLY;
 			kvm_pmu_request_counter_reprogram(pmc);
 		}
 		return 0;
-- 
2.49.0.395.g12beb8f557-goog


