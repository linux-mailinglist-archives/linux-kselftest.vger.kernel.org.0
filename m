Return-Path: <linux-kselftest+bounces-3498-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D42CE83B59F
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jan 2024 00:36:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5B8F1C2298B
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jan 2024 23:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 595A9136664;
	Wed, 24 Jan 2024 23:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mmWMscii"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8E413541D;
	Wed, 24 Jan 2024 23:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706139393; cv=none; b=iIZcTYpbNwFrRzkvY2JX7qdx6sdHO06VBZgNlKFDcL2ybuq05ZdteNGzvOtX0T7cbczpdQPPQE5zByE/kzK7wKhF3nN6CrLtQk4uDmLdmvUEjbql9V+bbh+PhX8VMZYlyX0KsOavOjLirKY46yKBdwPdFhL2pbsdAtsbMBmZVRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706139393; c=relaxed/simple;
	bh=TV6VcTbovvsUyu3ybeDvps8UTz3a8gTAzqnBwryEDsQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hPPAKZAxElpCnjjArEGpgTkafSMFX+wyq3HcuwVwslNyZdA84aPxepnfD5QIEcU4Qgb2N4oqeEXEzmJ7+JWVyhvUaMjO9ngcPaOww2zN/tZYtaQfntCVJx4payjyVEjKwc5kkEau+Y5H2pqCeTcnyjVvlVlrdI0fb7n4x2aeLGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mmWMscii; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52B06C433F1;
	Wed, 24 Jan 2024 23:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706139392;
	bh=TV6VcTbovvsUyu3ybeDvps8UTz3a8gTAzqnBwryEDsQ=;
	h=From:To:Cc:Subject:Date:From;
	b=mmWMsciixDMgdND5ie66waz8p4/BytOa3hb9yU6ppue16t1doZIftQUevD414bNYn
	 RH/3Juo0mMku51WAJIRRP0CYqac5cMN5Qx8ma0jjI2F23LBcczw4Vx5DsOw+n+s1PN
	 CZz8ytwDGiulHRIBgUc25COCLgp9GQVIeMzcVF34HBorf03v1Al8uJ7WehbRvBdRaf
	 s8GaJwnAHUxm2KLQyD62APvLbMx0nAkISJQVVml81aZrrpxJmt7wFb841+gzPptQt1
	 utMAy3INd5FDXYCFxD1oubvJYS4gsnWiU/n1OWMh+tMbQT2KC+12be3GI//DtRJSX5
	 ttpTgh2KsOR9w==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	shuah@kernel.org,
	0x7f454c46@gmail.com,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net] selftests: tcp_ao: set the timeout to 2 minutes
Date: Wed, 24 Jan 2024 15:36:30 -0800
Message-ID: <20240124233630.1977708-1-kuba@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The default timeout for tests is 45sec, bench-lookups_ipv6
seems to take around 50sec when running in a VM without
HW acceleration. Give it a 2x margin and set the timeout
to 120sec.

Fixes: d1066c9c58d4 ("selftests/net: Add test/benchmark for removing MKTs")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
Long story short I looked at the output for bench-lookups_ipv6
and it seems to be a trivial timeout problem. With this we're at
22/24 passing for TCP AO, the reset case failures aren't as obvious...

CC: shuah@kernel.org
CC: 0x7f454c46@gmail.com
CC: linux-kselftest@vger.kernel.org
---
 tools/testing/selftests/net/tcp_ao/settings | 1 +
 1 file changed, 1 insertion(+)
 create mode 100644 tools/testing/selftests/net/tcp_ao/settings

diff --git a/tools/testing/selftests/net/tcp_ao/settings b/tools/testing/selftests/net/tcp_ao/settings
new file mode 100644
index 000000000000..6091b45d226b
--- /dev/null
+++ b/tools/testing/selftests/net/tcp_ao/settings
@@ -0,0 +1 @@
+timeout=120
-- 
2.43.0


