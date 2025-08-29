Return-Path: <linux-kselftest+bounces-40292-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83FD2B3BD41
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Aug 2025 16:13:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C218A252B0
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Aug 2025 14:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E55B31E108;
	Fri, 29 Aug 2025 14:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="jbXl/IS9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.246.77.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A905931E0FD;
	Fri, 29 Aug 2025 14:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.246.77.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756476774; cv=none; b=phn8UfwF4e0t4Ye/FrAZnELaX4Jc5rgmZdO2fuBmA+P0WH2XeJ0CAkZrHIRKeSVUgfHeCtokGzIQf0GnBuLQO6IJ12lYwGO3HaEZ4W05nezo04xuMvPKrnLN/GHIfigLTu5n27Or4KTDIf+n1/b6MhOt3J8Xm7YWWDmPgj1rDY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756476774; c=relaxed/simple;
	bh=ch/WPJ0SpGlKhGdbMaEE09OSg0fskIs8Peezyjl3UVc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RlVMHjdZR7RYdMDeXHYOV8UJAWXDvlFcBFsSk7tfsM8uOdE1dCnic69YyN6OW0tP/cVVPBm2eGANab4LZKKWbAiU/W+s4XE56zBQGShWfbIGAjl0Jj7EdHD+ygbz7lAR5rrHPMyTK+rrly26vhMfkQF1WUE76q8bPeavnwfsE0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=jbXl/IS9; arc=none smtp.client-ip=44.246.77.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1756476772; x=1788012772;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+dXaDJZBFHeDcF9Dv8HHRJWOZiMC9GrTqoDlaXRW0MM=;
  b=jbXl/IS9+eQFkxIUozUzQvF0NP7irqrgYr6Zs0FNGV7mYIJ1TjOGH7lg
   P+lUsWb12zSR+YMbOXJdTNGG7nN//C0mUnSeo46Dym3kcjf3XzlvISsoz
   VFNGOONisRFT+Jl4aQQtb9DJm/JAq0XuxpOvwjJZat97rjcC2Kscrwj62
   w4W6aQ7j6lj3bAEHFgGEGufgpMlkcvewc1+YCFwfpiQxiiYpt8+2htSVi
   zz4PkOJekv1cRoKvBXKFHDktJ46779rG9gC51N6xbCTx8MjMAEIDLQhM4
   nzEQ6W2QScuneN1JvGfyhcVQWxYJb27d/0NP89LeHNqyvLUnVxB4QpaSC
   w==;
X-CSE-ConnectionGUID: h6plwO5yRFGsw022X0z4hg==
X-CSE-MsgGUID: +YOvAcYRRze0h8XS3xrFlA==
X-IronPort-AV: E=Sophos;i="6.18,221,1751241600"; 
   d="scan'208";a="2046458"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2025 14:12:50 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.38.20:63219]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.12.13:2525] with esmtp (Farcaster)
 id f3f00cc4-895b-4387-991c-0b829f105757; Fri, 29 Aug 2025 14:12:50 +0000 (UTC)
X-Farcaster-Flow-ID: f3f00cc4-895b-4387-991c-0b829f105757
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.17;
 Fri, 29 Aug 2025 14:12:50 +0000
Received: from dev-dsk-aqibaf-1b-17060f52.eu-west-1.amazon.com (10.253.72.42)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.17;
 Fri, 29 Aug 2025 14:12:48 +0000
From: Aqib Faruqui <aqibaf@amazon.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini
	<pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, <kvm@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <nh-open-source@amazon.com>, <aqibaf@amazon.com>
Subject: [PATCH 1/1] KVM: selftests: Fix force_emulation_prefix parameter type mismatch
Date: Fri, 29 Aug 2025 14:12:32 +0000
Message-ID: <20250829141233.58081-1-aqibaf@amazon.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D035UWA003.ant.amazon.com (10.13.139.86) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

Fix kvm_is_forced_enabled() to use get_kvm_param_bool() instead of
get_kvm_param_integer() when reading the "force_emulation_prefix" kernel
module parameter.

The force_emulation_prefix parameter is a boolean that accepts Y/N
values, but the function was incorrectly trying to parse it as an
integer using strtol().

Signed-off-by: Aqib Faruqui <aqibaf@amazon.com>
---
 tools/testing/selftests/kvm/include/x86/processor.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/include/x86/processor.h b/tools/testing/selftests/kvm/include/x86/processor.h
index 3f93d1b4f..8edf48b5a 100644
--- a/tools/testing/selftests/kvm/include/x86/processor.h
+++ b/tools/testing/selftests/kvm/include/x86/processor.h
@@ -1323,7 +1323,7 @@ static inline bool kvm_is_pmu_enabled(void)
 
 static inline bool kvm_is_forced_emulation_enabled(void)
 {
-	return !!get_kvm_param_integer("force_emulation_prefix");
+	return get_kvm_param_bool("force_emulation_prefix");
 }
 
 static inline bool kvm_is_unrestricted_guest_enabled(void)
-- 
2.47.3


