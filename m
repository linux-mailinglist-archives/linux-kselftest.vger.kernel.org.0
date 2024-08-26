Return-Path: <linux-kselftest+bounces-16325-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A4C5895F78A
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Aug 2024 19:12:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D4AD1F22CCF
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Aug 2024 17:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2BD7199246;
	Mon, 26 Aug 2024 17:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jERFKK3D"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90B9C19922D;
	Mon, 26 Aug 2024 17:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724692298; cv=none; b=pU0k6Y3QfteZUDeWbiV0YV/FrUfrPGBgUJ+U7o+nK1sjOEiCARINtbdUK1hlq45I4amNf5hWdLzQdV52qefOXUIxZ6xsnCI50BpQ1Yc3TxhYMMM4JHiw+CnkBVSKcPjYR9ZSSnjS3StM9jmwSqaNZhIuTVewfDbnc0SUHDbUdHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724692298; c=relaxed/simple;
	bh=6NiB15fQCRB/0hRYTV+4kq369qwgSUxD5vrznyR2mH0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=M1VmggVpeAPygEylFtHtp7behCD4b6J5tFOfh44nPPPxf/e1J+3viyImNhZ6Uk7rYYKtnrESnmnLnJzsEMCgrqlCgrq4TSmkbezG2RD3zcFY3YQBDusLN3MpYuVKZXFX1+60F7H3Jw7KmfLnNqqGRmUo3IUpCuvdEIWGSAoUWho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jERFKK3D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75DE6C8402C;
	Mon, 26 Aug 2024 17:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724692298;
	bh=6NiB15fQCRB/0hRYTV+4kq369qwgSUxD5vrznyR2mH0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=jERFKK3DC/5Wx1g8Hb9YIWVcJ1GalNCiZ+Ayq4W9qxybtj4Hic58xpJKU3Y+7ywZu
	 QpbsSBDJg5JHJT55qqgNO6Km65AOyqsD1Nc2Ay6j4pVEAjBxgYn4/+vJ+MsT1lt6Fp
	 ZayT/89UEXbj02dPnLB5+IChG7Gl7CXb378bbIv7F6u6xXluirwNqkAscMDEiu6lec
	 HgkgnqpBGuDPzpISLxZkoDlmq6pYDtrRvkeNMJus83R+h/NM7idWkt9hE6Exr3DtVH
	 jq5fKkEpCo34HzzoAQfb0WzWgPCVL1sFehG7lWN40djBLwRpkRPDTgdlpaqpVmIBns
	 L5a57YtG0ng7A==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 26 Aug 2024 19:11:20 +0200
Subject: [PATCH net 3/4] mptcp: sched: check both backup in retrans
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240826-net-mptcp-close-extra-sf-fin-v1-3-905199fe1172@kernel.org>
References: <20240826-net-mptcp-close-extra-sf-fin-v1-0-905199fe1172@kernel.org>
In-Reply-To: <20240826-net-mptcp-close-extra-sf-fin-v1-0-905199fe1172@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Florian Westphal <fw@strlen.de>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1429; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=6NiB15fQCRB/0hRYTV+4kq369qwgSUxD5vrznyR2mH0=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmzLc9Yo4eisWUEwLiIkSMono08U10yqCQph28U
 pRD0XpCqBaJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZsy3PQAKCRD2t4JPQmmg
 c/ftD/sE5jmfMkV1GkX+dIVKrDCA8K+8EtEA3yeXzWWyMczPeAaE7Awp+qFEW41Tt3mvY2CJxDB
 K25s05tG1mo7qBkgQgyTlM9zEYdr5KvEqGB30XK/fHW1jB6qcnMNv60bNZPRjICXkeXYW7gDX3h
 suq0I665JGolq+jf0GdGSpifeY6nbinEh2iXdSkfG2xPwd0NM+36QghrKsCcKeo3g2/p6HDOLhv
 42nZ/ZNUz8UK9Vd2zjONphXFW3fr8+ZUEI/Y5MC7151URzUa0qg5p11+VvU4D69u1nTBP4a0haf
 j6WWwMfFx59VV/QppnQVnHag0nsr8mGJQPYlaaQFCUpntkdEb0aJKPORRZuWh63E4IEUvp6DwYm
 /UzdqZv/e1jnEa+AHVhQMZ7kHv+fITaQgUeIpJfsq7EdMm3Fca2Te4IdtAoORuhf5pAGqkY3NKV
 +nyKSW3Ptu4tNfb7+rJnp60caOTARM/CNpaFM5mXcLnAqOZ7S8Fi7mA6sS8VL9B/rsxknCa/xXx
 gY4sR+JwSpI0Is4mNpcQWH6deB/t+1fH/EjhZyVmyEfo/58KfBS2WDYBm5dQpJ1PuKVOAZ6ohTj
 qA2OM6LPeWfjThKn4Pz0J4rmxsZFeg+SAJVgLlDw4ysttffxRTtyQe37eGPPQRZfdtzXVtOEHHo
 phpbzc9cxJZhQ1Q==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

The 'mptcp_subflow_context' structure has two items related to the
backup flags:

 - 'backup': the subflow has been marked as backup by the other peer

 - 'request_bkup': the backup flag has been set by the host

Looking only at the 'backup' flag can make sense in some cases, but it
is not the behaviour of the default packet scheduler when selecting
paths.

As explained in the commit b6a66e521a20 ("mptcp: sched: check both
directions for backup"), the packet scheduler should look at both flags,
because that was the behaviour from the beginning: the 'backup' flag was
set by accident instead of the 'request_bkup' one. Now that the latter
has been fixed, get_retrans() needs to be adapted as well.

Fixes: b6a66e521a20 ("mptcp: sched: check both directions for backup")
Cc: stable@vger.kernel.org
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/protocol.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 151e82e2ff2e..34fec753b9c1 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2326,7 +2326,7 @@ struct sock *mptcp_subflow_get_retrans(struct mptcp_sock *msk)
 			continue;
 		}
 
-		if (subflow->backup) {
+		if (subflow->backup || subflow->request_bkup) {
 			if (!backup)
 				backup = ssk;
 			continue;

-- 
2.45.2


