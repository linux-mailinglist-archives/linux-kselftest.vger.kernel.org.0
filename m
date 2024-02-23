Return-Path: <linux-kselftest+bounces-5376-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CD97861D6B
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Feb 2024 21:20:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C8361C2320E
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Feb 2024 20:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 735E914CAAF;
	Fri, 23 Feb 2024 20:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g+8CQiAr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F2411482E7;
	Fri, 23 Feb 2024 20:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708719562; cv=none; b=Kpd9dthbLnVbr+s7FL3GPAnvVAP8U9Jfkc18DlXQ5M+o1CGAWV0JfwpbHECCQyTyA4qEHpSY9D3krdTX2Li0XuV9IbaRLiW4npJfALmvsUSaqxdY76Osy2fCFp/7wbwuUnkahYWXJIF9sjzWnm3jBy7RzZZOAkSEH7k3ssjCDtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708719562; c=relaxed/simple;
	bh=ex5Mx41Huuyac9Z1t6Hplat3p104iUTSd3x7QbmwmXw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kFbQ2F00yUKJBvzbgZnL0CCJcZ+oD13CWTXUMUJDJhLrMrvkQID6KsFR40NVNnb6XV4WtWuKIDVi/SzmvxH3coq9LLmRYzGYNPUCSln0YsP9vidBJ2uv3mSBTw3oMrC5pDRzRUzWsa94Wq4GstAq65xHtiTvpS+hNpnNcxMIMyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g+8CQiAr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7DFDC433A6;
	Fri, 23 Feb 2024 20:19:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708719559;
	bh=ex5Mx41Huuyac9Z1t6Hplat3p104iUTSd3x7QbmwmXw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=g+8CQiArye+DO1altSNKA2pHE6/CVJ8dBcJ8uERLs1l1aQMa9TQnrC9oBxTdeGTxn
	 kZfF+JWFwJuCF6SY39MMojutzhl9+wMO6kOQLwnhzSf9So1F2626akwca1SDdVepsY
	 Lc6+6bfAH4uA2hVTveowTdADnqf9qmKlKVK5Z0SzhH53069c8uPILYGjTC2reJWu4w
	 Okd74OQwxz1L6zCzfhNNPHhAn6D7IULbVlw3NGu9SFDib6TbQW3GtlQqyU6OlLZknU
	 SrS9i6fhtliFBW4KOGpYr+8AJHOifJbBrxA4ZB4Ym8EZmEHCvpku2tNHRTTm6QgOqB
	 s57YCIQEqgZ4g==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 23 Feb 2024 21:17:58 +0100
Subject: [PATCH net-next 6/8] selftests: mptcp: simult flows: define
 missing vars
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240223-upstream-net-next-20240223-misc-improvements-v1-6-b6c8a10396bd@kernel.org>
References: <20240223-upstream-net-next-20240223-misc-improvements-v1-0-b6c8a10396bd@kernel.org>
In-Reply-To: <20240223-upstream-net-next-20240223-misc-improvements-v1-0-b6c8a10396bd@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Geliang Tang <tanggeliang@kylinos.cn>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=989; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=2oYftnUEdCOqYjlwEKhBo9GZ+yt54Ro8QzaHPbeEHDw=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBl2P2qhModMrd0L3Jfk2V/fsVAoLJ/rWnDu47Ga
 z1TigPE3v6JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZdj9qgAKCRD2t4JPQmmg
 czExD/9nDo2PBkCGwWlY2ZMJ+4FQUqW27Yzuav0MeJiUw8BtHFmrcpP/mrvl8FJKbWGf4G34SO/
 577+eLbnMhpGGFHLTdjVlRqIhHA3uxMCxqMCA8IksyexEI4VuFYyzIyQbkAqBJr6rbc5Bmi3ox0
 lbFpgWzikW4A2cFVPfn051YtpNl/MI13hnnGIXWcoyNw5VnvQDOYDBAp6BYBXNBzpYNnspuJWAT
 VBp+7ebPfcKnnVacVKiKFHLOcgLox8tM4g7IDZUewIwz2ngyYAYJ9dzm/staAAam5QQVjSfyhjM
 6rLVDqewwQEVwweOfhpzQENcGIaEP48cLqfIhXoECNi1Yd8+lRIOGkmRph/haXm2mm0FXpcQFh9
 +Ge3pDEW6UIFuVOYe2dBFFqTp8dV1vDvcR7CwI8bUkO0rgaeViIhexmwc4rkFbajwExZrV4zi0o
 WDOOko0jChKgFbSdGWNiTuQ18MWBaoQiKnzQvgtUUo5PQWeQjx20XnmE9nDl9DEbn5Ri3KmT881
 2+Fmdq9kM5QmGaN504qA3L0HbbKoeRyZs6ekOh3OhhhHGInZY4155WS1UapNu4OlsZ5vu+oeTu+
 0XuVgFoNDaPhD0UWTKQSMC9xluGPo/na4KPjMvHkezs4uSfPRfQCrYrJRTkwf2dlOGr735gZPfD
 nz+mFUU26vA7M4w==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Geliang Tang <tanggeliang@kylinos.cn>

The variables 'large', 'small', 'sout', 'cout', 'capout' and 'size' are
used in multiple functions, so they should be clearly defined as global
variables at the top of the file.

This patch redefines them at the beginning of simult_flows.sh.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/simult_flows.sh | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/simult_flows.sh b/tools/testing/selftests/net/mptcp/simult_flows.sh
index 8f9ddb3ad4fe..ed0165c15a24 100755
--- a/tools/testing/selftests/net/mptcp/simult_flows.sh
+++ b/tools/testing/selftests/net/mptcp/simult_flows.sh
@@ -16,6 +16,12 @@ test_cnt=1
 ret=0
 bail=0
 slack=50
+large=""
+small=""
+sout=""
+cout=""
+capout=""
+size=0
 
 usage() {
 	echo "Usage: $0 [ -b ] [ -c ] [ -d ]"

-- 
2.43.0


