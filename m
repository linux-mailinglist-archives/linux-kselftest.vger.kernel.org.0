Return-Path: <linux-kselftest+bounces-13654-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98D5492F72D
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Jul 2024 10:47:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D7F7282D2C
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Jul 2024 08:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98DCF85C56;
	Fri, 12 Jul 2024 08:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="5QEh0OqJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 083CB5C8EF;
	Fri, 12 Jul 2024 08:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720774032; cv=none; b=lQuidqYEbKDVx80c3pD8iF52FbE7laagoVPsd+L428AvxKqRTuTnOQnp+2tQ2hcN+k/Fe4isP/90g/LE5eopVtdEm04OsV4QbD/WQSQS3eoS73Eu63qajB92KWHbwxoM2tPqNd1WJgGiAmorJdYxYHd9cmiNbxWqpKnX5B4UkV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720774032; c=relaxed/simple;
	bh=lhVeTZU/ILs7wBADY1AG0PVPU1TReLjvRvX/AiocPPA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HY0IGmDXry5vAC+mHcsr/2XV97pmiUkjbjsGxAiRntGxSL3UPZ7OqXig2+462qmvBJSngcLoORBLzOWopujpZcJfxVb14hxixp6wNk6GmJd/1omAPH3mgrmWRg/jJDlXKZS8FIMNSiAVxEJ+P6wrKi6xegd9qCq2HE/8qUPelV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=5QEh0OqJ; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1720774028;
	bh=lhVeTZU/ILs7wBADY1AG0PVPU1TReLjvRvX/AiocPPA=;
	h=From:To:Cc:Subject:Date:From;
	b=5QEh0OqJLIsysV1lxvNJHKzqnvoBuz8scmWLRKTMkjhOJX/uiFyJ/iD8tauBv68DX
	 JJEeg2m0VSSYVa2n7NoVQkhDcCoDjDFsCjgA4lP9LSYd7YEXfioylJGC7sKzyclVrF
	 qEMod9FnAD0ZMGsfT8P1l+UaJX+zmUXnoZ/ubCMdRtWbRJ37l7ehY10qXEjBKDNYfA
	 AChQb9AsvC4DIRAjfii51J/xRkvyFqe2s4gsetQWKQvsMVqdssaUvzP2R5lY/O+C2F
	 VjUm1gDL73kRF1r7zrDM9EMBKVHFeUszbQpmNEGzCjzjCO9yo4igIcXdVnJpW9ODon
	 Khkq8CLG1/ysA==
Received: from localhost.localdomain (ec2-34-240-57-77.eu-west-1.compute.amazonaws.com [34.240.57.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id DF41937821DB;
	Fri, 12 Jul 2024 08:47:05 +0000 (UTC)
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
Subject: [PATCH v2 0/4] selftest: x86: conform tests to TAP format output
Date: Fri, 12 Jul 2024 13:46:21 +0500
Message-Id: <20240712084625.297249-1-usama.anjum@collabora.com>
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


