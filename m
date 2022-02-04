Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AD3C4A9FDC
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Feb 2022 20:18:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232185AbiBDTSB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 4 Feb 2022 14:18:01 -0500
Received: from mga11.intel.com ([192.55.52.93]:61194 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231728AbiBDTSA (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 4 Feb 2022 14:18:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644002280; x=1675538280;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=n8C5babs3ZkUMBv/nFFD9Th7rXCW1erD1QQPKYBJ0M4=;
  b=ZhvrEyrdhxUzGgdKhWpdRWKC9Zak42FFay9JzQQ7VYhxjxLQOf+1bXRt
   71qO7Us2A2SWCetd97zw/V39SrVwd3tZgIeGbnb4KvZvUuYZc3M1lkjlx
   qC1uiQWYiDQIjOvL9HPqwmXrGBTabUG+H4zGNaQ7ktBWs1xtqfgzS3QMQ
   6mychpwHabOv92UKYCtqQ3ZbvPSn+R1kEOFwJ3flu9BzPRysK3rVeaj5w
   ndRXekg9RnqmhZejeU1xmdKSzB5s/kiq/B3n+6TIaRZ4rRAWgFk7uOwo6
   rcItNkSKi0I9z5VjnM2029m9aYD6v1H96svHDsUjIQrKxQ1CDpVR3dylW
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10248"; a="246017063"
X-IronPort-AV: E=Sophos;i="5.88,343,1635231600"; 
   d="scan'208";a="246017063"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2022 11:18:00 -0800
X-IronPort-AV: E=Sophos;i="5.88,343,1635231600"; 
   d="scan'208";a="524412811"
Received: from rchatre-ws.ostc.intel.com ([10.54.69.144])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2022 11:17:59 -0800
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     shuah@kernel.org, linux-kselftest@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ram Pai <linuxram@us.ibm.com>,
        Sandipan Das <sandipan@linux.ibm.com>,
        Florian Weimer <fweimer@redhat.com>,
        "Desnes A. Nunes do Rosario" <desnesn@linux.vnet.ibm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michal Suchanek <msuchanek@suse.de>, linux-mm@kvack.org,
        "Chang S . Bae" <chang.seok.bae@intel.com>,
        Borislav Petkov <bp@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>
Subject: [PATCH 0/3] selftests: Remove duplicate CPUID wrappers
Date:   Fri,  4 Feb 2022 11:17:08 -0800
Message-Id: <cover.1644000145.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

A few tests that require running CPUID do so with a private
implementation of a wrapper for CPUID. This duplication of
the CPUID wrapper should be avoided but having one is also
unnecessary because of the existence of a macro that can
be used instead.

This series replaces private CPUID wrappers with calls
to the __cpuid_count() macro from cpuid.h as made available
by gcc and clang/llvm.

Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Ram Pai <linuxram@us.ibm.com>
Cc: Sandipan Das <sandipan@linux.ibm.com>
Cc: Florian Weimer <fweimer@redhat.com>
Cc: "Desnes A. Nunes do Rosario" <desnesn@linux.vnet.ibm.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Michal Suchanek <msuchanek@suse.de>
Cc: linux-mm@kvack.org
Cc: Chang S. Bae <chang.seok.bae@intel.com>
Cc: Borislav Petkov <bp@suse.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org
Cc: Andy Lutomirski <luto@kernel.org>

Reinette Chatre (3):
  selftests/vm/pkeys: Use existing __cpuid_count() macro
  selftests/x86/amx: Use existing __cpuid_count() macro
  selftests/x86/corrupt_xstate_header: Use existing __cpuid_count()
    macro

 tools/testing/selftests/vm/pkey-x86.h         | 22 +++---------------
 tools/testing/selftests/x86/amx.c             | 23 +++++--------------
 .../selftests/x86/corrupt_xstate_header.c     | 17 ++------------
 3 files changed, 11 insertions(+), 51 deletions(-)

-- 
2.25.1

