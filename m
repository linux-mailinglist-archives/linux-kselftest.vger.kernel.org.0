Return-Path: <linux-kselftest+bounces-29886-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55E3DA74CB4
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Mar 2025 15:32:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA0101722DB
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Mar 2025 14:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FEA921C9FF;
	Fri, 28 Mar 2025 14:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XOgJHHmH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DAA921C9EA;
	Fri, 28 Mar 2025 14:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743172098; cv=none; b=RFZt5AYi1jHSwBOi9HkRAgughSigZmPlepUa0wHAY+rM+wQnWaeNX8/xwQUDLQt0PC93EjtqppGtE/tLmBtcdOjzBd7zhh00bD3ovogkt2W6Gqt7QS9V2Wm+ggDd8qSQRJrc8pmz3AhGNw92ZKvLSOpBnlw3NFA9+dGx2Mqg3yY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743172098; c=relaxed/simple;
	bh=pR7ZsBtXGnaffvDzR3G0f+xtFYL/1NJWJsq/1XvaP14=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TttubRbLtcu7W9CKcrWHZLUxqC4stBw9M969mdqCFvT4fhGAZny4ykPsflGF43SMxOLGAx6Elu4nz0Arx5H4vOH5SV4DgGOOMNCSVBcaqqK6OFXqt5jHCY02F9VLqTusSxtJAeGgtLpJ3LoMMBGEXwxScRIDDXKEjWEIBEN4xuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XOgJHHmH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32AACC4CEEA;
	Fri, 28 Mar 2025 14:28:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743172097;
	bh=pR7ZsBtXGnaffvDzR3G0f+xtFYL/1NJWJsq/1XvaP14=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=XOgJHHmHqS7/tfLxYg9SAp5uZMO2fkVPNFIBycOsswwoXPofe46AwJaWteldjBC0f
	 KDpr5xj2PKw25vGwOH5445L7xWUi5c9PAKFN+7XnL7rzkQa0+hcphN36Xr7NsVN6ir
	 L8f3N6G0+5zKJVGfinLdfszK/55goH+bAfOZ4T/1bF2YjVgTp0E3Vg//p3X8TYHmqn
	 H1Wpfa1Ldfy4/ho5E6QgeVawjRmnAjQcRywlrgdCKfW0HZQW3QpUtnZp6E2vUa6QDo
	 wXMD+ccmebSgJPgNR3RbZaSR1VS14Y7xCwLi6lG2QxKRmkJYWghooy+dj0oHmLg3DB
	 VowqV7jyxk+YQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 28 Mar 2025 15:27:18 +0100
Subject: [PATCH net 3/4] selftests: mptcp: close fd_in before returning in
 main_loop
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250328-net-mptcp-misc-fixes-6-15-v1-3-34161a482a7f@kernel.org>
References: <20250328-net-mptcp-misc-fixes-6-15-v1-0-34161a482a7f@kernel.org>
In-Reply-To: <20250328-net-mptcp-misc-fixes-6-15-v1-0-34161a482a7f@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Florian Westphal <fw@strlen.de>, Shuah Khan <shuah@kernel.org>, 
 Dmytro Shytyi <dmytro@shytyi.net>, Gang Yan <yangang@kylinos.cn>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, stable@vger.kernel.org, 
 Cong Liu <liucong2@kylinos.cn>, Geliang Tang <geliang@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1319; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=BATmZiZuy/W/ffocjWue1jFUcQe06Xg/5usGzRn674w=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBn5rHsARxaxO00MS0AB6QHgVg6IwYBz4m0aRpHO
 vWjhh3OHcKJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ+ax7AAKCRD2t4JPQmmg
 c9cKD/0RWsgah9b5ObqcTpttQVC8TRcZlz5IQMiEyoH25Ki7UTrez92SHxAgw4L5axK6J4R5YlZ
 kr5TnM5j3iqMmXc+mGRkSPJlkM8k4wCzdGuUX/kw8wkQ9y5kz7XNCGRj84P6rrmP5A2hpcSHNM/
 ygZjtap6mSsBhIih8Apl0/KASYihnzBuqtpHpJIYS6Q7+wczHvpHx3KLYRo3UR/Hsq1GqzuPAKO
 RAVU0gIQZUBcWPGmVTgE7HvzV5kPkSeFQk9sS1TVLWaepESnrg4V0/BUKeCevKUE86uwg0vVNdh
 P0jd0L55nrCBrOSQeizvkrQKLUrlhlboJ9PglWCFhIEhxtSkfP38EfGE3u0Fp9fpaJUjJZIyR2r
 +Fv8EW32R4esU8srm++oqjR0MfP+X15tZdMM0FTCw7C8hhtpWTzofjrB/dHdya3vrJfj8FDDhDr
 54QGX2mU9vwsUMj36syTUZNUGEWjFaxkTpic2TUmU3cdghVULjPP1Ubp2lxPts/PYTH1H4TxTn4
 jYKkr4TohX8ZtfzdHYyuS6eAYzBBbogjaoNrgOW2Yr9O9BnuRdBiqtPN9pDoYLdhT3UDPiox5ns
 u9hiDhchLlF8jFdeK68K8Sfs0utVcFjulpDsl6leG4yFLpDc1An0vgoBdRtEdT6glHKRG5V7HKb
 8yPlYVO/iXSpihw==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Geliang Tang <tanggeliang@kylinos.cn>

The file descriptor 'fd_in' is opened when cfg_input is configured, but
not closed in main_loop(), this patch fixes it.

Fixes: 05be5e273c84 ("selftests: mptcp: add disconnect tests")
Cc: stable@vger.kernel.org
Co-developed-by: Cong Liu <liucong2@kylinos.cn>
Signed-off-by: Cong Liu <liucong2@kylinos.cn>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_connect.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/testing/selftests/net/mptcp/mptcp_connect.c
index 893dc36b12f607bec56a41c9961eff272a7837c7..c83a8b47bbdfa5fcf1462e2b2949b41fd32c9b14 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
@@ -1299,7 +1299,7 @@ int main_loop(void)
 
 	ret = copyfd_io(fd_in, fd, 1, 0, &winfo);
 	if (ret)
-		return ret;
+		goto out;
 
 	if (cfg_truncate > 0) {
 		shutdown(fd, SHUT_WR);
@@ -1320,7 +1320,10 @@ int main_loop(void)
 		close(fd);
 	}
 
-	return 0;
+out:
+	if (cfg_input)
+		close(fd_in);
+	return ret;
 }
 
 int parse_proto(const char *proto)

-- 
2.48.1


