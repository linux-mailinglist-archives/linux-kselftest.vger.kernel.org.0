Return-Path: <linux-kselftest+bounces-29667-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 954D0A6E11C
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Mar 2025 18:39:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E3CB174021
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Mar 2025 17:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C691267B13;
	Mon, 24 Mar 2025 17:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IA7hcS2r"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0974A26773C
	for <linux-kselftest@vger.kernel.org>; Mon, 24 Mar 2025 17:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742837600; cv=none; b=UGjlO7wwmZi6tyYw30rKHXoBQd+ugoO2ew/x4fVLom+Z3dNjA6DoeZF8XkURu1ht2MfonA5tpro5UBFHcqauaj5D0G+o12FtDl95VO5PuLVuRmK1yBg/5an9cnq0yvEwvg1B3uCg19neWrM9rP+uiee7kj8+htAAPVl0PdvUseY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742837600; c=relaxed/simple;
	bh=b8kfH1giQMSXfOU3H4wI9RK8POw0T6oW++CyqKtBnX4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=iwYzSCMNVsET5+fw18iYPXGuemwYn2OL3Dci/5aH3j+mtg6/86Rku1CJaK/AnJH9+HN4WesjCTGVYcWvzfqgRUj3vOMV/PNS3rNrX5PZDxnQ6BC9dI2S/xT7yHmcv07SQNLp+tPQlyIOgoKVri8whXHoPe8NgJqM35mG/Tt6obk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IA7hcS2r; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2ff8340d547so8785121a91.2
        for <linux-kselftest@vger.kernel.org>; Mon, 24 Mar 2025 10:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742837598; x=1743442398; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=bMvztk4Ls/rO+e5Y79A5cu9f2ky21aF113lmuU+q7KE=;
        b=IA7hcS2rbox46IneULeeUT7ooW/SC3Kl4OLoLiTfiHgx9EoZScPA8Z2hfrVoTXbE1Z
         qZ71qmHX7FzbU4vMr03IqxXwwOgP1dAxD4ygoEIgIee6xE8bepwc+oeP61W8O/PK6XgC
         Wt2iCjdcxQFru3prWrGCMnLbHJwWJrBsnHB8ilCMD/sc7rfC8QkgbUKiRyW6NoKD6056
         K8sYqQneeUMSa7EpNYby36tTO+5ineU9F6PMqvLqsMhhxChin7PYPRUMHXr7YkJlkfw5
         Xgv8lFfn0qUAgdsZVa/a/G+uIntikYqD4GVdGQhbx8g8jqsSNu98+cx2alvYmMzx99xs
         T1pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742837598; x=1743442398;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bMvztk4Ls/rO+e5Y79A5cu9f2ky21aF113lmuU+q7KE=;
        b=bw8f9d/mH+M0UZDiSMeb+pdvbTHndBTSCNCavxjjHDn5ucgMwD57PaXPIagvz0LtJE
         KnsD/Gd1sKl7Ht7jip+gkzhSkEJeigC1IWMNRImnQurIVnO4ePUVdAzHZ0RCOhYnfLdi
         IM9OQKPfWOLVIULGbLmzFWxtPWCGPn0VLFGS5qvG9XMK7tzyy11a/mtINHe7PjNzqivd
         9tiWujjwdY32ZA0zRLiyen2ycm4x28C0i1WHlw4QXW1O/Y9EjtknN9MJeDyxclMtNJk9
         Y5RndNBAUSkSJeSPe3qy9FmUjXRgMvADHv20JN3lx2bPoJEflIW+ezO/pfewVFPo7gWu
         LX3g==
X-Forwarded-Encrypted: i=1; AJvYcCUzIpc2TxaHoWa2XNPAey26auA4FpCVlDn0G2muI//yneaBjVcEMwBaGX0982Cg8hv7tyhoUNEz4V6UilUSdss=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx61lMA3v+cgYHXH8JP4MQwBLDAQfyLJfTEmkZKUnYbcIMFs8sK
	sMuQFRlZyvUVmeqvHWObMSvPkaYozZZdjMhCwbgWj3wSFq1r40Td8wlSb9soGY+JqiZ4kDn/Bbl
	5vQ96sA==
X-Google-Smtp-Source: AGHT+IFuXYKM2/ft8zmuifG//R7KBXVtO7yRI38c7kXk4CZuqSwM8AkIrVF15vqaI/zOHCFLN1phpoVdAyVd
X-Received: from pjd6.prod.google.com ([2002:a17:90b:54c6:b0:2e5:5ffc:1c36])
 (user=mizhang job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2b4e:b0:2ef:19d0:2261
 with SMTP id 98e67ed59e1d1-3030fe956damr23161099a91.16.1742837598383; Mon, 24
 Mar 2025 10:33:18 -0700 (PDT)
Reply-To: Mingwei Zhang <mizhang@google.com>
Date: Mon, 24 Mar 2025 17:30:56 +0000
In-Reply-To: <20250324173121.1275209-1-mizhang@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250324173121.1275209-1-mizhang@google.com>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Message-ID: <20250324173121.1275209-17-mizhang@google.com>
Subject: [PATCH v4 16/38] KVM: x86: Rename vmx_vmentry/vmexit_ctrl() helpers
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

From: Dapeng Mi <dapeng1.mi@linux.intel.com>

Rename the two helpers vmx_vmentry/vmexit_ctrl() to
vmx_get_initial_vmentry/vmexit_ctrl() to represent their real meaning.

No functional change intended.

Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Mingwei Zhang <mizhang@google.com>
---
 arch/x86/kvm/vmx/vmx.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index a4b5b6455c7b..acd3582874b9 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -4424,7 +4424,7 @@ static u32 vmx_pin_based_exec_ctrl(struct vcpu_vmx *vmx)
 	return pin_based_exec_ctrl;
 }
 
-static u32 vmx_vmentry_ctrl(void)
+static u32 vmx_get_initial_vmentry_ctrl(void)
 {
 	u32 vmentry_ctrl = vmcs_config.vmentry_ctrl;
 
@@ -4441,7 +4441,7 @@ static u32 vmx_vmentry_ctrl(void)
 	return vmentry_ctrl;
 }
 
-static u32 vmx_vmexit_ctrl(void)
+static u32 vmx_get_initial_vmexit_ctrl(void)
 {
 	u32 vmexit_ctrl = vmcs_config.vmexit_ctrl;
 
@@ -4806,10 +4806,10 @@ static void init_vmcs(struct vcpu_vmx *vmx)
 	if (vmcs_config.vmentry_ctrl & VM_ENTRY_LOAD_IA32_PAT)
 		vmcs_write64(GUEST_IA32_PAT, vmx->vcpu.arch.pat);
 
-	vm_exit_controls_set(vmx, vmx_vmexit_ctrl());
+	vm_exit_controls_set(vmx, vmx_get_initial_vmexit_ctrl());
 
 	/* 22.2.1, 20.8.1 */
-	vm_entry_controls_set(vmx, vmx_vmentry_ctrl());
+	vm_entry_controls_set(vmx, vmx_get_initial_vmentry_ctrl());
 
 	vmx->vcpu.arch.cr0_guest_owned_bits = vmx_l1_guest_owned_cr0_bits();
 	vmcs_writel(CR0_GUEST_HOST_MASK, ~vmx->vcpu.arch.cr0_guest_owned_bits);
-- 
2.49.0.395.g12beb8f557-goog


