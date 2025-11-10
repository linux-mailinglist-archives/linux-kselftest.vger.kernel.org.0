Return-Path: <linux-kselftest+bounces-45250-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DEEEDC489B5
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Nov 2025 19:39:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7257F3BB1A3
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Nov 2025 18:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13B2832E130;
	Mon, 10 Nov 2025 18:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kqb52MrL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C9332E123;
	Mon, 10 Nov 2025 18:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762799062; cv=none; b=Je+sd7OOaBoGWkT2YpHZg0smRfLL9PaU9BaSphovabHfGQzJ1/gKMs9vn5flpp20ZKG0+8qvYkMz/DxBE/q4Sw0yqK1iaKOl8xcTMin6YZO85B2A8GDlW0fjAyyhfwDfuY7zSyaNnIuo1RY7Ql86Jgs/MdxP6RA392DZxsjinbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762799062; c=relaxed/simple;
	bh=g3SLcGsDjlMGBKQSfIm6bhEChbau24P2JJ1zVw2RPNo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gAKL3tzjl+Pc575wS4kD+ulJqgGXhdnY6XMC8sPM8nDDQUa+Gdlt/ZnE2NpzzfKfcq19Ahgqj898Xx9Li2OM0gwFyUFVa2ayVZ+kcCPxH68FtKguSwT4DL7SGbdT/zgP+dW3TGLnlwp6meWSu/WiR9gefHBmehLJk2T0CQO47C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kqb52MrL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28480C19423;
	Mon, 10 Nov 2025 18:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762799061;
	bh=g3SLcGsDjlMGBKQSfIm6bhEChbau24P2JJ1zVw2RPNo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=kqb52MrLpMVv8hVC8I38cc9DMNTYlG1SxBo9B9ODTbSVeqagIBhW5cOFVXH1Ryg4l
	 +0klC1hmhhV9CVIePFoJVuuu/HW79gTVhDEppqK93dgzR2VQrZwzuFeBWovfTXgtSQ
	 VQxyaqUYT1afmXkkZuDDABje40IpiFicbJZPD6fO7pkpqejNGLLwMArrrN7YSXLNfV
	 IF2Hi+/g/PcsQ4mQUbeZ9765FtaJNOH/C/MXxaz6ljdaW3Kr82zmMxQ2Yg3Ok4t0sK
	 v3Vwg/kurLxFjjo9nyPwOI1WM8Z7lMD1Uc8Qn5pLLp9W91TBFkHOTI5FIkDVp1DlTN
	 UZT3sjBX7q9sw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 10 Nov 2025 19:23:44 +0100
Subject: [PATCH net 5/6] selftests: mptcp: connect: trunc: read all recv
 data
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251110-net-mptcp-sft-join-unstable-v1-5-a4332c714e10@kernel.org>
References: <20251110-net-mptcp-sft-join-unstable-v1-0-a4332c714e10@kernel.org>
In-Reply-To: <20251110-net-mptcp-sft-join-unstable-v1-0-a4332c714e10@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2803; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=g3SLcGsDjlMGBKQSfIm6bhEChbau24P2JJ1zVw2RPNo=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDKFdA9HytzIfXnOue3P4dVaRyNXLp/oOnuy7bwDHBaFj
 k4MiwOudpSyMIhxMciKKbJIt0Xmz3xexVvi5WcBM4eVCWQIAxenAEzkoAcjw/pzqaIrMl+3+abo
 JW9ksZ93oNnxScxrjgOTb/mw82kq5TH80zmqXV/GcbZqt5i9Qsuvu52STNxv2y95JNm6vxPR/2b
 OCwA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

MPTCP Join "fastclose server" selftest is sometimes failing because the
client output file doesn't have the expected size, e.g. 296B instead of
1024B.

When looking at a packet trace when this happens, the server sent the
expected 1024B in two parts -- 100B, then 924B -- then the MP_FASTCLOSE.
It is then strange to see the client only receiving 296B, which would
mean it only got a part of the second packet. The problem is then not on
the networking side, but rather on the data reception side.

When mptcp_connect is launched with '-f -1', it means the connection
might stop before having sent everything, because a reset has been
received. When this happens, the program was directly stopped. But it is
also possible there are still some data to read, simply because the
previous 'read' step was done with a buffer smaller than the pending
data, see do_rnd_read(). In this case, it is important to read what's
left in the kernel buffers before stopping without error like before.

SIGPIPE is now ignored, not to quit the app before having read
everything.

Fixes: 6bf41020b72b ("selftests: mptcp: update and extend fastclose test-cases")
Cc: stable@vger.kernel.org
Reviewed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_connect.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/testing/selftests/net/mptcp/mptcp_connect.c
index b148cadb96d0..fc7e22b503d3 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
@@ -710,8 +710,14 @@ static int copyfd_io_poll(int infd, int peerfd, int outfd,
 
 				bw = do_rnd_write(peerfd, winfo->buf + winfo->off, winfo->len);
 				if (bw < 0) {
-					if (cfg_rcv_trunc)
-						return 0;
+					/* expected reset, continue to read */
+					if (cfg_rcv_trunc &&
+					    (errno == ECONNRESET ||
+					     errno == EPIPE)) {
+						fds.events &= ~POLLOUT;
+						continue;
+					}
+
 					perror("write");
 					return 111;
 				}
@@ -737,8 +743,10 @@ static int copyfd_io_poll(int infd, int peerfd, int outfd,
 		}
 
 		if (fds.revents & (POLLERR | POLLNVAL)) {
-			if (cfg_rcv_trunc)
-				return 0;
+			if (cfg_rcv_trunc) {
+				fds.events &= ~(POLLERR | POLLNVAL);
+				continue;
+			}
 			fprintf(stderr, "Unexpected revents: "
 				"POLLERR/POLLNVAL(%x)\n", fds.revents);
 			return 5;
@@ -1433,7 +1441,7 @@ static void parse_opts(int argc, char **argv)
 			 */
 			if (cfg_truncate < 0) {
 				cfg_rcv_trunc = true;
-				signal(SIGPIPE, handle_signal);
+				signal(SIGPIPE, SIG_IGN);
 			}
 			break;
 		case 'j':

-- 
2.51.0


