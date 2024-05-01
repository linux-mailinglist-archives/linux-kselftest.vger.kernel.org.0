Return-Path: <linux-kselftest+bounces-9197-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA1BB8B89FA
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 May 2024 14:29:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26F471C2104F
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 May 2024 12:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B5B484E0A;
	Wed,  1 May 2024 12:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="I6qmm694"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BFD9824A3;
	Wed,  1 May 2024 12:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714566553; cv=none; b=aPpLa6N7hwBa/IWBFfdQXBLO1qAvHLCwx0vl4t4Hs1Y94LPSQ3l43kVkhwJGrSehPr1huoHfMJ6F1RKuop286y7tdGYKQmwFspAIvPOc26fkTP8XeyK9aIxqU6438pa2sH557T9UIDVCPYU2Jty3B86oofQlXf79fganWUwHS9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714566553; c=relaxed/simple;
	bh=uEklwwrSAICg3ZJuH9aSGtaFDX9QNKm+bswdtOYKTyQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Mrz/niueWkbDQuWmJVKRIC1mx7cdHsPBGZWpTQ3vXF++rFkXL3D0icxeo2Vl8jFMsPQ6U5nXMZyU09CpSyv94bEbObxinITJ63C9ZxxJ5HlP0B+cAcvEcj7Zzebd3EiDCjzSD/xpNs24F9lD/zG9+QvM0Yr6rS2LAte2mw+Hfz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=I6qmm694; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1714566550;
	bh=uEklwwrSAICg3ZJuH9aSGtaFDX9QNKm+bswdtOYKTyQ=;
	h=From:To:Cc:Subject:Date:From;
	b=I6qmm694cZMVt0apM2hmsxcVPdsMUQBd5aILDQHHntoBcm69Y0sT1V9VQa4QvK/R9
	 nVYmPk9Gcsi/9OumIJ4lxmVR270mZo5M0EUMJhNlyw5Z/Cmqeag99TYLneOpnPEGWr
	 rOsFtZhtq9BUpzVRAroeGTnomZdT+4obv/0iMviG9jA/LfloyqdMnv8R0qzUN7DWQ5
	 sgnCixGApLNBc69tavPi67dgDyx4E7PG0KUwhb05Up+3q1fi4btnW7xTKVpHFIilHx
	 nnldKuqqA3+Efn2oghgRcxsgu3VHop8kFmUrD2K/+WI/cGq5Zld3uE4fouI0pPwhMI
	 6floVzBTjdzAg==
Received: from localhost.localdomain (broslavsky.collaboradmins.com [68.183.210.73])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 9BC2F3781FE9;
	Wed,  1 May 2024 12:29:06 +0000 (UTC)
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
To: Shuah Khan <shuah@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	"Mike Rapoport (IBM)" <rppt@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Alexey Dobriyan <adobriyan@gmail.com>,
	Binbin Wu <binbin.wu@linux.intel.com>,
	"Chang S. Bae" <chang.seok.bae@intel.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Cc: kernel@collabora.com
Subject: [PATCH 0/8] selftests: x86: build suite with clang
Date: Wed,  1 May 2024 17:29:10 +0500
Message-Id: <20240501122918.3831734-1-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series fixes build errors found by clang to allow the x86 suite to
get built with the clang.

Unfortunately, there is one bug [1] in the clang becuase of which
extended asm isn't handled correctly by it and build fails for
sysret_rip.c. Hence even after this series the build of this test would
fail with clang. Should we disable this test for now when clang is used
until the bug is fixed in clang? Not sure. Any opinions?

[1] https://github.com/llvm/llvm-project/issues/53728

Muhammad Usama Anjum (8):
  selftests: x86: Remove dependence of headers file
  selftests: x86: check_initial_reg_state: remove -no-pie while using
    -static
  selftests: x86: test_vsyscall: remove unused function
  selftests: x86: fsgsbase_restore: fix asm directive from =rm to =r
  selftests: x86: syscall_arg_fault_32: remove unused variable
  selftests: x86: test_FISTTP: use fisttps instead of ambigous fisttp
  selftests: x86: fsgsbase: Remove unused function and variable
  selftests: x86: amx: Remove unused functions

 tools/testing/selftests/x86/Makefile            |  9 +++++----
 tools/testing/selftests/x86/amx.c               | 16 ----------------
 tools/testing/selftests/x86/fsgsbase.c          |  6 ------
 tools/testing/selftests/x86/fsgsbase_restore.c  |  2 +-
 tools/testing/selftests/x86/syscall_arg_fault.c |  1 -
 tools/testing/selftests/x86/test_FISTTP.c       |  8 ++++----
 tools/testing/selftests/x86/test_vsyscall.c     |  5 -----
 7 files changed, 10 insertions(+), 37 deletions(-)

-- 
2.39.2


