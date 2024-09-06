Return-Path: <linux-kselftest+bounces-17392-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5DA396F4E7
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Sep 2024 15:00:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2E771C24715
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Sep 2024 13:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A5D01CDA1B;
	Fri,  6 Sep 2024 13:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k11X7UMY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B1B1CCB37;
	Fri,  6 Sep 2024 13:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725627650; cv=none; b=syimzL+4nBwzFY3xp2h3UoLid/J7J3WYiN5mJ9Ibb8QkHCInngj0GE5xvEDZJCuGr2hYWVtx3VlZspRjwxlOhFnRiAziKybYuBgpdZkApwZ1P50KV3hhepAPFP6ZLLzq/3NpY9HVVa016yQcUAfYGpaE/5YzPVVrY5vPiwsAHyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725627650; c=relaxed/simple;
	bh=IxqmJ2aBpGqM30mv7r+ou/hAbtXsh6zJU+QgP43Z8jU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PbUhJET2Po41GbZv9S28HI0XjoR26ytDPX6UYINdGUdwytN318J4JRgW+Q26izCGjcX31+ZOMb2i6AFpEY7mX+fIBfTlaYvMiJCPUNU7T2vmRJcQ0pfQJlg7y5QpUHaJUh+msZINYuwjVtvZMGv/OVGn+5UP1leVaivReXz5z/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k11X7UMY; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725627649; x=1757163649;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=IxqmJ2aBpGqM30mv7r+ou/hAbtXsh6zJU+QgP43Z8jU=;
  b=k11X7UMYNGYStyHNFTpwidFFjFI6na3i1tJ4EZc8MESScy3MOnR0GKos
   74ncRnKRk+YT+W5Vz53TwzfuSHeW5cy9F0J8oh0OEaNuNlcKA3tgH1Zhs
   VNsFlNz1iJEI9k6kPplDt2MAMnq3Fg9MY5NvmOVxtOdtzgycrRKYzuay5
   r+OedX1oxm69Hq5SC10N7tk2Pb1M5J/8bwihOVar3BPgNhRTEFVdQRgAr
   XgCsqTPsr0Y+sV7uNYmz/Fx/gN7WchfbklWkza810CNrXAPErLU7DuH6w
   CoNGMJ23BbYrbot+3YvInG+Y2WS1GBg1EqSKxfQlJLz7x5VGhf9oSTWYc
   w==;
X-CSE-ConnectionGUID: GzaQNaSeT/SMWR3JtwA/Rw==
X-CSE-MsgGUID: TyH/iSUzQbq1tf+1plQYNA==
X-IronPort-AV: E=McAfee;i="6700,10204,11187"; a="34959876"
X-IronPort-AV: E=Sophos;i="6.10,207,1719903600"; 
   d="scan'208";a="34959876"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2024 06:00:47 -0700
X-CSE-ConnectionGUID: SfnFIX3yRC6ClsGuVTXf/w==
X-CSE-MsgGUID: bUyXa9k8Q6mncniJXlRbSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,207,1719903600"; 
   d="scan'208";a="65929487"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO localhost.localdomain) ([10.245.115.59])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2024 06:00:39 -0700
From: Adrian Hunter <adrian.hunter@intel.com>
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>
Cc: Zhenyu Wang <zhenyuw@linux.intel.com>,
	kvm@vger.kernel.org,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	H Peter Anvin <hpa@zytor.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: [PATCH 0/3] KVM: x86: Fix Intel PT Host/Guest mode when host tracing also
Date: Fri,  6 Sep 2024 16:00:23 +0300
Message-ID: <20240906130026.10705-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit

Hi

There is a long-standing problem whereby running Intel PT on host and guest
in Host/Guest mode, causes VM-Entry failure.

The motivation for this patch set is to provide a fix for stable kernels
prior to the advent of the "Mediated Passthrough vPMU" patch set:

	https://lore.kernel.org/kvm/20240801045907.4010984-1-mizhang@google.com/

which would render a large part of the fix unnecessary but likely not be
suitable for backport to stable due to its size and complexity.

Ideally, this patch set would be applied before "Mediated Passthrough vPMU"

Note that the fix does not conflict with "Mediated Passthrough vPMU", it
is just that "Mediated Passthrough vPMU" will make the code to stop and
restart Intel PT unnecessary.


Adrian Hunter (3):
      KVM: x86: Fix Intel PT IA32_RTIT_CTL MSR validation
      KVM: x86: Fix Intel PT Host/Guest mode when host tracing also
      KVM: selftests: Add guest Intel PT test

 arch/x86/events/intel/pt.c                         | 131 ++++++-
 arch/x86/events/intel/pt.h                         |  10 +
 arch/x86/include/asm/intel_pt.h                    |   4 +
 arch/x86/kvm/vmx/vmx.c                             |  26 +-
 arch/x86/kvm/vmx/vmx.h                             |   1 -
 tools/testing/selftests/kvm/Makefile               |   1 +
 .../selftests/kvm/include/x86_64/processor.h       |   1 +
 tools/testing/selftests/kvm/x86_64/intel_pt.c      | 381 +++++++++++++++++++++
 8 files changed, 532 insertions(+), 23 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/x86_64/intel_pt.c

base-commit: d45aab436cf06544abeeffc607110f559a3af3b4


Regards
Adrian

