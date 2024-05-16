Return-Path: <linux-kselftest+bounces-10280-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A65A8C7012
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 May 2024 03:42:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4E451F22193
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 May 2024 01:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D38BA1362;
	Thu, 16 May 2024 01:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TO03+x3r"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C8C10FA;
	Thu, 16 May 2024 01:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715823725; cv=none; b=KBfkhD1nndymmVjIYeZszwK1YcUx6Z9K/ILaAOxuvfqsm+o3bvteV9UI8K+YsUxqe2c4OWtIGd5ASQ/UHKgHV54vzjiyetja6qqJNvWYI+JnlCS7l752czhqV6vfbuvAUUo8uB2CClb3vlNnuAbNcGPBI7nR3PEc9tbsX49YWFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715823725; c=relaxed/simple;
	bh=xk386NB5B+OYNSRRJVYypSTewBpx9zOWjLdaiL1ocTI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XysZexdc2+gZXaJAq1XqvZDZC0h0hlS8vt/35tlLdBx6LPzPZbLoZ9Q10xwCwG8RNHTRVFG9GKbp70PZaGNCgjNgaZjaAfxuphAtt5jL5D0XOJN+7XesfcuEu/Wo2zw43e+qr52Amglpe0QVNy4RV7tbHx6RIeiia9i9C+9Ntbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TO03+x3r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E34CC116B1;
	Thu, 16 May 2024 01:41:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715823725;
	bh=xk386NB5B+OYNSRRJVYypSTewBpx9zOWjLdaiL1ocTI=;
	h=From:To:Cc:Subject:Date:From;
	b=TO03+x3rDgELssLHtutB/zQR3GH6iKSsR0LaRtbxO+VmxVnWceAD+XaXLHb2A/gsK
	 rs4XwwCbTqluqj4MkFL45bOQ1GyKtxKCeWX6P+E1N7ZBbFCnz3DMOBfH8wvAPGAR/7
	 bZzoyjtQd1fVoW/7/j1CRdUMsxOAgXxAOtS6eCljnKXQHQpvj8tEUCpk3bEbkQzROx
	 l6UOqfJXJMezKXwaRPMvoSAivCyJZTRXOxC2d7N57pbl8xWu+9Cxf0IYayq9zkia11
	 Ezw8LNDo7FzOG+3z1j4WYm9b8tglkvDz1Un77a+JDtb+pXkvSMBxqLvCb3D43tdny5
	 d8CdqGStsXnFA==
From: Geliang Tang <geliang@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Mykola Lysenko <mykolal@fb.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next] selftests/bpf: Enable INET_XFRM_TUNNEL in config
Date: Thu, 16 May 2024 09:41:53 +0800
Message-ID: <acb442e38544bc5c60dcaa61d56ca1e6bbbc82fe.1715823610.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

The kconfigs CONFIG_INET_XFRM_TUNNEL and CONFIG_INET6_XFRM_TUNNEL are
needed by test_tunnel tests. This patch enables them together with the
dependent kconfigs CONFIG_INET_IPCOMP and CONFIG_INET6_IPCOMP.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/config | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/bpf/config b/tools/testing/selftests/bpf/config
index eeabd798bc3a..8aa56e6bdac1 100644
--- a/tools/testing/selftests/bpf/config
+++ b/tools/testing/selftests/bpf/config
@@ -95,3 +95,7 @@ CONFIG_XDP_SOCKETS=y
 CONFIG_XFRM_INTERFACE=y
 CONFIG_TCP_CONG_DCTCP=y
 CONFIG_TCP_CONG_BBR=y
+CONFIG_INET_IPCOMP=y
+CONFIG_INET_XFRM_TUNNEL=y
+CONFIG_INET6_IPCOMP=y
+CONFIG_INET6_XFRM_TUNNEL=y
-- 
2.43.0


