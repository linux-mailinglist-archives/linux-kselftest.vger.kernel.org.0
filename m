Return-Path: <linux-kselftest+bounces-28902-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D0620A5F0AC
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Mar 2025 11:25:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D84871887768
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Mar 2025 10:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAE57266B47;
	Thu, 13 Mar 2025 10:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IXXT21G7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D36265CDE;
	Thu, 13 Mar 2025 10:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741861401; cv=none; b=Y3qI57w1Bf6NjjdHUnU2rIgnj6zzYXmDfnA1Uag/SLA5PHcV3syHc5tenVvugFCfCaVqiI5uJqzABsVXkW1xlTS/U07pfsPhXhQCyqyGKLu7Uq7vhE/CCytVRw2uwi8bZj4eCjByxY1cVWgZEaqWTzBm2AgVXB0dyuvTdAXKqN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741861401; c=relaxed/simple;
	bh=XtTYwEcZZnc9UQ2sTu/aXOfhvB29s8o6zKX6nWCP6SA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AFluSTWEqOVnDjCDtXmfL4zHAlrRjcjj+pAMOR/jdECExe3nyu9KFrsy+q7tfkjRbL+z0QyIxsl9muzCjgpSl9vqRlRfzeQu6gA209GyvyT6FBNNr/4ZYuDsLHF0RFr1l4tbyoUFyIfW3FPYgcoGFYhmiO5c7YHn9k7WvZNsPE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IXXT21G7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C40F5C4CEFA;
	Thu, 13 Mar 2025 10:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741861401;
	bh=XtTYwEcZZnc9UQ2sTu/aXOfhvB29s8o6zKX6nWCP6SA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=IXXT21G7XoZlgyq2TTSIo/soI4YgyGz073ICJeF40vxudxpmD+g70UoIJtxNFyYPa
	 /DmfzR+tulAViMz+8NMvsBS9bXSlaPYiFTRugm6Q++/dvtLYhE2vtqGTphH3EifMHi
	 WzNpgdU7upEcIwW20/2gTN32TbpUH3yDBUIVaRZGv90yixPYOMPfvxm123YZUwKG8L
	 vBnY/ON9LyTIO46aDUGCGWEPpZdGIcvI06SGwebsiGjX3CPT56rVLHz3DLAj1QdUt7
	 KzPXsqZkjKQp6qBT/k6AtAspj/XI7nLGOwtoEsTrYm0Np2rdFM1BpwmXHrE8CWTyv2
	 mFonuK7haD9AQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 13 Mar 2025 11:20:59 +0100
Subject: [PATCH net-next 10/12] mptcp: sysctl: map pm_type to path_manager
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250313-net-next-mptcp-pm-ops-intro-v1-10-f4e4a88efc50@kernel.org>
References: <20250313-net-next-mptcp-pm-ops-intro-v1-0-f4e4a88efc50@kernel.org>
In-Reply-To: <20250313-net-next-mptcp-pm-ops-intro-v1-0-f4e4a88efc50@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Geliang Tang <geliang@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1971; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=TPN8WFIxZ+4kfTdcjhcI3tFu52CcyhzVPD/IskqF4FE=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBn0rGbWmxTMMEnzt7kizMBEolkLdSZIaawXwOGG
 iet71dfA1OJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ9KxmwAKCRD2t4JPQmmg
 cynBEACVGc2Sksz1RogI6fTeHbxZM8vNgdF4rFCDRRL4Nued6nQOgjORKPizrvqG8gJlkQDUW9u
 uhBWvwJYG8/fsHbKCwsWymbDdkIUngM1pY+L1L+54UUsqrUmrYbWEzaPo6yqu+c9BZDn7jf41vn
 +PI2X8K8Ph+7PcoXI4ZbDWWLS50hbCbg1278rRuYoJEPGanYahrfZVGTRNo8YWFlOchqtqewnTJ
 Pc+L5/NmL06TNGE15EihBvh7gkksaPedgALAXnqpxUcYVnzeNTufhMHpz0M4PnjzVKZt/J4iweC
 rLIRuMFYfsPRul5DzBG2R7oCop9aIrOsVOy+WKel/MfywxIfJXtEQEAPy7uiVwq7+5Q7Phv927c
 W5HybhUbccYnwLjNu0drj/YNcivDGDi2dOG3xYcJN22uCY7yqsWGutEqjdztIhg3PwExubJtVpp
 03dpjf/qdhLmAga0HusEmTuwksESGiw3BJJkENxHc32bJrqpojP39uhUPvUgYvEx7YQjS+VJDY4
 5Bxg5+ANilo3QjVjKsO+VzbpAAFPDKRgeL0PdbgC3q1IIxAlCZ2n+O7GnxfFc5Lzq+zFHc+adVv
 r/WkcF0Z7L9qrXSaYRn16yfKqqWXgi6aEGm4raNl6Wvo7gZkiSktAylaXSPfAtJUYhiEbSv9PHr
 M7VkgipQLyyG9tg==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch adds a new proc_handler "proc_pm_type" for "pm_type" to
map old path manager sysctl "pm_type" to the newly added "path_manager".

	path_manager		   pm_type

	MPTCP_PM_TYPE_KERNEL    -> "kernel"
	MPTCP_PM_TYPE_USERSPACE -> "userspace"

It is important to add this to keep a compatibility with the now
deprecated pm_type sysctl knob.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/ctrl.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
index cb0811e636ff2f4bb981d2688eb8d07946fc1744..4d8b31f32eb50347d10db792f084e43c93f687c6 100644
--- a/net/mptcp/ctrl.c
+++ b/net/mptcp/ctrl.c
@@ -230,6 +230,29 @@ static int proc_path_manager(const struct ctl_table *ctl, int write,
 	return ret;
 }
 
+static int proc_pm_type(const struct ctl_table *ctl, int write,
+			void *buffer, size_t *lenp, loff_t *ppos)
+{
+	struct mptcp_pernet *pernet = container_of(ctl->data,
+						   struct mptcp_pernet,
+						   pm_type);
+	int ret;
+
+	ret = proc_dou8vec_minmax(ctl, write, buffer, lenp, ppos);
+	if (write && ret == 0) {
+		u8 pm_type = READ_ONCE(*(u8 *)ctl->data);
+		char *pm_name = "";
+
+		if (pm_type == MPTCP_PM_TYPE_KERNEL)
+			pm_name = "kernel";
+		else if (pm_type == MPTCP_PM_TYPE_USERSPACE)
+			pm_name = "userspace";
+		mptcp_set_path_manager(pernet->path_manager, pm_name);
+	}
+
+	return ret;
+}
+
 static struct ctl_table mptcp_sysctl_table[] = {
 	{
 		.procname = "enabled",
@@ -274,7 +297,7 @@ static struct ctl_table mptcp_sysctl_table[] = {
 		.procname = "pm_type",
 		.maxlen = sizeof(u8),
 		.mode = 0644,
-		.proc_handler = proc_dou8vec_minmax,
+		.proc_handler = proc_pm_type,
 		.extra1       = SYSCTL_ZERO,
 		.extra2       = &mptcp_pm_type_max
 	},

-- 
2.48.1


