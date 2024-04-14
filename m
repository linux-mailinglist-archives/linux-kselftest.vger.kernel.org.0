Return-Path: <linux-kselftest+bounces-7918-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0F1B8A4284
	for <lists+linux-kselftest@lfdr.de>; Sun, 14 Apr 2024 15:17:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CDFC28198B
	for <lists+linux-kselftest@lfdr.de>; Sun, 14 Apr 2024 13:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14C5B3613D;
	Sun, 14 Apr 2024 13:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="p0aiV/RL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A541EB21;
	Sun, 14 Apr 2024 13:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713100667; cv=none; b=JnR1wEk2VRhVou7jHyBVm6Ie4+bo+VGplP+VCuSgUSdbMWuD/BHjrmy7QR/x2Gnvvsit9zfE3f8YduvDFI7OQwPycsdzwoqlHN8gHcupkfrGQEpzL8B8uZL2OkT0oKxirc4g6LVl485DG589uv931PgbaqTDAiwSj5h7bq+xJg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713100667; c=relaxed/simple;
	bh=BtaW3Pbwpsp+5doDib3mpPMO6wUHiLYdjZxo+FwxRHw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eSpZLyB2yCEGZVFJlnJntSA6hZmYyFc6lRJhoCLiH7qsc0InavE+VxnFqLVnwjl2eHVLh4F8d2dR4a23wRJ8pBucLKq65zGOb0h8BVs4e6PFjnCjR1Mct9k2ptUedsxZ76vpmG1sClQ8Nv0wN5385/gDoxZOMWkwkaUkwTItDcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=p0aiV/RL; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1713100663;
	bh=BtaW3Pbwpsp+5doDib3mpPMO6wUHiLYdjZxo+FwxRHw=;
	h=From:To:Cc:Subject:Date:From;
	b=p0aiV/RLe9y9Fdmdshofpvig+S5UfiPJN+eboWcT5T7DMf006hEU3z8DlrPngs7XY
	 wpbzQLmYhNkZyTTr9TwZx5sWlU+F76bMZIJTA7eWEZK5GmlJRrXLbjhuZGXn3HBgb+
	 3YCLwwSN97/AsSYjlKtKgyF7FmQBvHcq0DEsUyd0Ju3ifXL7NsM8pVVv1lq6Pb7N7t
	 Tap5P7b2no1qV/Rv39MD12/qVADGXvJMGfzYdopw48p/AyAyiaqKG8intfEEcPyMHW
	 MX8U1kcR4mqPBYMPvjmUwM8GVapzyz30ja/g8SM+8A+RnA+5jtc5FNiWMT8azThq4g
	 S0BldiJ670J4w==
Received: from localhost.localdomain (ec2-34-240-57-77.eu-west-1.compute.amazonaws.com [34.240.57.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 7DBE43781104;
	Sun, 14 Apr 2024 13:17:41 +0000 (UTC)
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
To: Shuah Khan <shuah@kernel.org>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: kernel@collabora.com
Subject: [PATCH 0/4] selftest: x86: conform tests to TAP format output
Date: Sun, 14 Apr 2024 18:18:03 +0500
Message-Id: <20240414131807.2253344-1-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In this series, 4 tests are being conformed to TAP.

Muhammad Usama Anjum (4):
  selftests: x86: check_initial_reg_state: conform test to TAP format
    output
  selftests: x86: corrupt_xstate_header: conform test to TAP format
    output
  selftests: fsgsbase_restore: conform test to TAP format output
  selftests: entry_from_vm86: conform test to TAP format output

 .../selftests/x86/check_initial_reg_state.c   |  24 ++--
 .../selftests/x86/corrupt_xstate_header.c     |  30 +++--
 tools/testing/selftests/x86/entry_from_vm86.c | 109 ++++++++--------
 .../testing/selftests/x86/fsgsbase_restore.c  | 117 +++++++++---------
 4 files changed, 139 insertions(+), 141 deletions(-)

-- 
2.39.2


