Return-Path: <linux-kselftest+bounces-13659-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF8B992F740
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Jul 2024 10:53:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D03C1C22083
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Jul 2024 08:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4899585C56;
	Fri, 12 Jul 2024 08:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="fjRyfh+Y"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3FD110A12;
	Fri, 12 Jul 2024 08:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720774407; cv=none; b=SLrYMrU+a5SkabIb+kkDfK5eCOXYdzvZpAS0KCaJhFfjXqAc8W5tQApjSZAOcG3cU7cq0l66x/5kLcHlQaF58c0SA07ryUIAr7BD9C0pMBPRz7vLzLRJtKUEz++bZ4w6n0C1FlcdpkMgJ0A9Rg9rIiH3kbMBe1F1WIwM+3hrQF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720774407; c=relaxed/simple;
	bh=rmwI2g7YTSzBgWpUzBrMfDbgFYsL4ffhSuuYZQcLBjY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JdKOgxKXkN9YnmyWQw3PzGP7nrGNZsKrVz7h/jYJ4vgmacqsbMNZyfcNBu2YWsSbkzI1KXgJd1CJIVW1TvkSwKwWh0aeauspL1B9Ols15tanvnD1gy7CF+rDSwdrS7+a2+bTwEyPY9HLBVtsy9iVlPbPNOwHkcysMrTXw9Z1+q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=fjRyfh+Y; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1720774404;
	bh=rmwI2g7YTSzBgWpUzBrMfDbgFYsL4ffhSuuYZQcLBjY=;
	h=From:To:Cc:Subject:Date:From;
	b=fjRyfh+YDKFt4kSjNcmg4+p8ijAe5yx8jEnaPa7Y5TmcW3wCnLxh/AiJEHjauAkm4
	 id2KMmOxL3OmQND3znO6Kt+vCOrO58DyPQ6EdFcUQuPyjH/x9S8t1h/4jo3Undrz+H
	 vxqoy0Png+q+3BKzV0QRFOmPnxcBppr8i30N93PfH/4NNkJEi78lkfhdgtppYogY+e
	 gmj9unbZoM9+ZJ3ARazRch0qQaQT3pSorApr2Ip1UHhHbQEeH/F4Uw63BvAmZDc0Sw
	 SiHwyL7OS6VFNcYr0WSKwnC6vtQ59tkl0B2oCsfv7ITeprZQEYvrkuYe4KgiJX1AH8
	 ndLRgD9X88VUQ==
Received: from localhost.localdomain (ec2-34-240-57-77.eu-west-1.compute.amazonaws.com [34.240.57.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id E26CE37821DB;
	Fri, 12 Jul 2024 08:53:21 +0000 (UTC)
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
To: Shuah Khan <shuah@kernel.org>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: kernel@collabora.com,
	"Chang S . Bae" <chang.seok.bae@intel.com>,
	Binbin Wu <binbin.wu@linux.intel.com>,
	Ingo Molnar <mingo@kernel.org>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH v3 0/4] selftest: x86: remove manual counting and increase maintainability
Date: Fri, 12 Jul 2024 13:53:13 +0500
Message-Id: <20240712085318.315386-1-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In this series, 4 tests are being conformed to TAP.

Changes since v1:
- Correct the description of patches with what improvements they are
  bringing and why they are required

Changes since v2:
- Correct the subject of series

Muhammad Usama Anjum (4):
  selftests: x86: check_initial_reg_state: remove manual counting and
    increase maintainability
  selftests: x86: corrupt_xstate_header: remove manual counting and
    increase maintainability
  selftests: x86: fsgsbase_restore: remove manual counting and increase
    maintainability
  selftests: x86: entry_from_vm86: remove manual counting and increase
    maintainability

 .../selftests/x86/check_initial_reg_state.c   |  24 ++--
 .../selftests/x86/corrupt_xstate_header.c     |  30 +++--
 tools/testing/selftests/x86/entry_from_vm86.c | 109 ++++++++--------
 .../testing/selftests/x86/fsgsbase_restore.c  | 117 +++++++++---------
 4 files changed, 139 insertions(+), 141 deletions(-)

-- 
2.39.2


