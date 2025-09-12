Return-Path: <linux-kselftest+bounces-41370-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2538DB54E07
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Sep 2025 14:35:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C121E1896376
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Sep 2025 12:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9A4C31B11E;
	Fri, 12 Sep 2025 12:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NxiTkL5M"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C52B31A072;
	Fri, 12 Sep 2025 12:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757679983; cv=none; b=qJIMMPKvfwoDJ9Tat2xxdjblqWnUgNwg9TLrbj7NTZhN7rG5eQ7W/aDsHJzd5lXRb5pAn4rIujgQBTAD5Qy2YD+au/KshIcBawgxg0wGkWnlKtnSOeQ7bgYgfe0HuocK27iIfcMVuRrGISBtiXbkgO6uHEX2rV76wdw8fOhWTK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757679983; c=relaxed/simple;
	bh=wIbaxBLYNY/0v1j60qZW6c3rwG3+xjsXEeNnYU0wxMM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=E0nivPNQQ2wgI9s5YNDHzCWV6mpEZz/rjJhFZ25m83pcZ/P6f17yy0ScWysX2mJzQWxE5u/BjVvNolwGGxFA1NWNcH+yd865nq+jynsvVAOqbSJk82jKU7ivFl+NDwME+5CCjYpha8NigQT6MhqU1r8VGdMdZS90mrC7TdmmsBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NxiTkL5M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDDA2C4CEF1;
	Fri, 12 Sep 2025 12:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757679983;
	bh=wIbaxBLYNY/0v1j60qZW6c3rwG3+xjsXEeNnYU0wxMM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=NxiTkL5MBj/Yk0X8fgirt3CI4DpP8W3KjGtMRxtSbRDDvS9UxmCF0Z3Zi2ydIJk1c
	 qFOyxhGgMBqJJzISJSeEutYk6zAKOiSqgjDVTwF9/myvcv1bOKrPSycHusc5R2qkNR
	 TC1UP1H2mAtUVk0jy56ifrKg4VQrkJJt/05RAMmFMKXm8ZQeewwvEnkNw9C4TWW0+V
	 tLtJa7RiuDTodfz9dgxlidNVrfXJ3SrXDLbNvMamV1zzjC82Z8IsVa5pIACkrFMzV2
	 z7dCxldSS5M3Rc8HqJZNxjv5fPSvcvsDkUHsvTWw4+ZjVEnxehMXu+wfVi5tGLX1IB
	 51AoM3V1I7q+A==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 12 Sep 2025 14:25:54 +0200
Subject: [PATCH net 5/5] selftests: mptcp: connect: print pcap prefix
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250912-net-mptcp-fix-sft-connect-v1-5-d40e77cbbf02@kernel.org>
References: <20250912-net-mptcp-fix-sft-connect-v1-0-d40e77cbbf02@kernel.org>
In-Reply-To: <20250912-net-mptcp-fix-sft-connect-v1-0-d40e77cbbf02@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1316; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=wIbaxBLYNY/0v1j60qZW6c3rwG3+xjsXEeNnYU0wxMM=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDKOCMZe6Fl68ROLZcre8+pPv7TEm7vUpmw0uG/32q5za
 0/t2vqUjhIWBjEuBlkxRRbptsj8mc+reEu8/Cxg5rAygQxh4OIUgIloSjP8s9+ur3qGscD6bXva
 ja95Z5ViJl4Penzo4c49RmmnFSJiyhm+V55g9Lf9kW9ycdrHxNyVjfcj7d4Vfvnhn13YWcaRacE
 IAA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

To be able to find which capture files have been produced after several
runs.

This prefix was not printed anywhere before.

While at it, always use the same prefix by taking info from ns1, instead
of "$connector_ns", which is sometimes ns1, sometimes ns2 in the
subtests.

Reviewed-by: Mat Martineau <martineau@kernel.org>
Reviewed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_connect.sh | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index c2ab9f7f0d2133559bb18ce884b613d21d1ec5f0..47ecb5b3836eb5c64787bda0f6f1cc7c3af338aa 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -211,6 +211,11 @@ if $checksum; then
 	done
 fi
 
+if $capture; then
+	rndh="${ns1:4}"
+	mptcp_lib_pr_info "Packet capture files will have this prefix: ${rndh}-"
+fi
+
 set_ethtool_flags() {
 	local ns="$1"
 	local dev="$2"
@@ -361,7 +366,6 @@ do_transfer()
 
 	if $capture; then
 		local capuser
-		local rndh="${connector_ns:4}"
 		if [ -z $SUDO_USER ] ; then
 			capuser=""
 		else

-- 
2.51.0


