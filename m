Return-Path: <linux-kselftest+bounces-28253-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8E65A4F182
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Mar 2025 00:32:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BA58188B8DB
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Mar 2025 23:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF56520012D;
	Tue,  4 Mar 2025 23:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sblSl5Eg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF831FE476;
	Tue,  4 Mar 2025 23:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741131129; cv=none; b=b7KsKMPbnUt2+xMjxwlPEgZ+Q4v73vMRmehtV2ZkeQYR5+w2MaPI+M0+1jUFAmULkhiL+wzgEoShJi2BbR3cOV3fn64YRkNpR3Vh1GQqTSJLkWlZVNfNlcJtkzdHWx2OFUlQ2+tK+PbfWxqgnKUzBYklZupzZGmYvJY8Tfbmi2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741131129; c=relaxed/simple;
	bh=DcEhDL7xUpR6ZoXA/blbO23dGfFud/i7veyogmnyzxU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r8LR0EFTuPkOXTu247LhTwumOh8ynF6XnayDq++FXUVvOQl+Fv4PTZ+T1tYPKe5+z/ZITHvk1GUHeDP5V20chjHiCQdAgNNX7zgEP+H8mLJgnLWQBu97O95zTgBLemXw7GmbRm5Z/QkK4GvcgsqFLBrTL83Zlhu1cN/AaZvDCQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sblSl5Eg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6F13C4CEEA;
	Tue,  4 Mar 2025 23:32:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741131129;
	bh=DcEhDL7xUpR6ZoXA/blbO23dGfFud/i7veyogmnyzxU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sblSl5EgJK4eru7nTY8aXQ53jWajnQAqK9fl6h3O5fvhuzgl4MbFs+eKdEE/KSHxR
	 0GwDetUoV9bEzf938oxohotWgiWTjyOOb8TX+mhmjQkbn4OWsr1kkrlQoHMKcuoDvf
	 flm4OazMShTSQ23UwndOdfvR7TdciDVRwJyYmckdn7BBVKxEVO74qXf2+Mz/Az41Nt
	 L8yjtYe3RO3VoV+qhyGAVqZVKcCsDsaZhLWeXk1beyvJ+OMyHOybC/CNVpQxNADr9j
	 lTX6B13MUAeqWxwyexdAM+SsLJQlxGyjj2PdTXtJ3gvAyafZifHPfLTS3rfylZ9ikY
	 9izPnyLo7lFZQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH net-next 2/2] selftests: net: bpf_offload: add 'libbpf_global' to ignored maps
Date: Tue,  4 Mar 2025 15:32:04 -0800
Message-ID: <20250304233204.1139251-2-kuba@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250304233204.1139251-1-kuba@kernel.org>
References: <20250304233204.1139251-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After installing pahole on the CI image we have a new map created
by libbpf. Ignore it otherwise we see:

  Exception: Time out waiting for map counts to stabilize want 2, have 3

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: shuah@kernel.org
CC: linux-kselftest@vger.kernel.org
CC: bpf@vger.kernel.org
---
 tools/testing/selftests/net/bpf_offload.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/net/bpf_offload.py b/tools/testing/selftests/net/bpf_offload.py
index 4a9be8c49561..b2c271b79240 100755
--- a/tools/testing/selftests/net/bpf_offload.py
+++ b/tools/testing/selftests/net/bpf_offload.py
@@ -712,6 +712,7 @@ _, base_maps = bpftool("map")
 base_map_names = [
     'pid_iter.rodata', # created on each bpftool invocation
     'libbpf_det_bind', # created on each bpftool invocation
+    'libbpf_global',
 ]
 
 # Check netdevsim
-- 
2.48.1


