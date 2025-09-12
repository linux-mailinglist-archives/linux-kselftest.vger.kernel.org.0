Return-Path: <linux-kselftest+bounces-41367-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF1FDB54DD8
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Sep 2025 14:33:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A80A9463BD9
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Sep 2025 12:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71E66315761;
	Fri, 12 Sep 2025 12:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q12h2N4Y"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F3C830ACEC;
	Fri, 12 Sep 2025 12:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757679976; cv=none; b=nswzLEs4Ohar7uVUmObOSioOvLbVkqLCQ8K/XozMcnCgPvIOSk5DWlSOD/5GuW/+SSM6YOCtWcZcmD8gPkJ7l//wj4LVTC05ca+dtyyoNH6p/PU3bUjlaFhnAz7kY19aDSVI+TUJ6r/G+2au0yhBHXXXuD56VXXaZI6weuhXznE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757679976; c=relaxed/simple;
	bh=Fy6guyyjWyQEIlYBDQ+OzM2U/OcwiT5QN5SsCJ/oC60=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LO4dR0U4FQ2z5s1a4GlfL61FZDXY+9a/SNOuTVICc3f3lnuNmmPLyxwwyQ9I0sQjjJT7TO8bBozorL8Gp1M+2X+YsLx3nWFJ0EHc/y0j2ggOlEiupgm55orHPfgrhS/X6eA7ZbyQNLMLn+ixqhNG1ime+zQMMyvnYS3ZDFS6Nm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q12h2N4Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61F11C4CEF9;
	Fri, 12 Sep 2025 12:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757679974;
	bh=Fy6guyyjWyQEIlYBDQ+OzM2U/OcwiT5QN5SsCJ/oC60=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=q12h2N4Yg926Y2t0POfhqThzYO1rCpnsMvtuU/154iW9W6xh6CPfTtsS8fM89i7EN
	 QYzvJY7QjXFn2oBFGtyvpYuoiw4pxurKK/KjIMxeaSEyF3VxDjmIZezwiZxC4Tylph
	 UaxT4UCpRuXErSOQdBuwWfveHVqJlrNZLvxpn+gHK+oEuB/4Sh/qfalH5VtRm5/UnF
	 ge6IQ6sWhboKnwqesXSm7HFYL9/vkwZi/SZnoklh23h+nFqsMDGf8JjosjZet02qS+
	 KFsXWPKHdc0FuYNTr0BhaNKkn5LjuYvkagM40gfz+oQqcc0gw1rcZzuWze8hOqae21
	 pRj5ogblNsBWg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 12 Sep 2025 14:25:51 +0200
Subject: [PATCH net 2/5] selftests: mptcp: connect: catch IO errors on
 listen side
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250912-net-mptcp-fix-sft-connect-v1-2-d40e77cbbf02@kernel.org>
References: <20250912-net-mptcp-fix-sft-connect-v1-0-d40e77cbbf02@kernel.org>
In-Reply-To: <20250912-net-mptcp-fix-sft-connect-v1-0-d40e77cbbf02@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2271; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=Fy6guyyjWyQEIlYBDQ+OzM2U/OcwiT5QN5SsCJ/oC60=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDKOCEYdUwjSYf74cbnn89kyb94UffW/JVf3sC2tnXudr
 fPSm3MudZSyMIhxMciKKbJIt0Xmz3xexVvi5WcBM4eVCWQIAxenAExE/Twjw3LOLt+/J++cnszn
 ypdoUio7b9Gljfo/fnLHesf3iLeusmdkeLtSauW2Q4/WFLCFHpy/aa/KlB4Vg1MyjK9NvhQkC1p
 N5wMA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

IO errors were correctly printed to stderr, and propagated up to the
main loop for the server side, but the returned value was ignored. As a
consequence, the program for the listener side was no longer exiting
with an error code in case of IO issues.

Because of that, some issues might not have been seen. But very likely,
most issues either had an effect on the client side, or the file
transfer was not the expected one, e.g. the connection got reset before
the end. Still, it is better to fix this.

The main consequence of this issue is the error that was reported by the
selftests: the received and sent files were different, and the MIB
counters were not printed. Also, when such errors happened during the
'disconnect' tests, the program tried to continue until the timeout.

Now when an IO error is detected, the program exits directly with an
error.

Fixes: 05be5e273c84 ("selftests: mptcp: add disconnect tests")
Cc: stable@vger.kernel.org
Reviewed-by: Mat Martineau <martineau@kernel.org>
Reviewed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_connect.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/testing/selftests/net/mptcp/mptcp_connect.c
index 4f07ac9fa207cb08a934582b98d688d0b9512f97..1408698df0999730d9a9a4ad6a6362a4ab122d54 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
@@ -1093,6 +1093,7 @@ int main_loop_s(int listensock)
 	struct pollfd polls;
 	socklen_t salen;
 	int remotesock;
+	int err = 0;
 	int fd = 0;
 
 again:
@@ -1125,7 +1126,7 @@ int main_loop_s(int listensock)
 		SOCK_TEST_TCPULP(remotesock, 0);
 
 		memset(&winfo, 0, sizeof(winfo));
-		copyfd_io(fd, remotesock, 1, true, &winfo);
+		err = copyfd_io(fd, remotesock, 1, true, &winfo);
 	} else {
 		perror("accept");
 		return 1;
@@ -1134,10 +1135,10 @@ int main_loop_s(int listensock)
 	if (cfg_input)
 		close(fd);
 
-	if (--cfg_repeat > 0)
+	if (!err && --cfg_repeat > 0)
 		goto again;
 
-	return 0;
+	return err;
 }
 
 static void init_rng(void)

-- 
2.51.0


