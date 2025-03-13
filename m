Return-Path: <linux-kselftest+bounces-28901-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 56620A5F0A8
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Mar 2025 11:24:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4159189DB09
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Mar 2025 10:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 330A7264FB8;
	Thu, 13 Mar 2025 10:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tapMjnJv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C8A264FBB;
	Thu, 13 Mar 2025 10:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741861388; cv=none; b=URkgdE1QU6O/9Nmp+vVAxIeUQMwV3hSI9/01Fed9n89OVaMCOoUdtednYU76I6dXVRxIYOYzuqSWeybmXtbjAOdQxtKLTpUl6LBffqIFLkX9EIyK8tsSZDN7k/ZANXDHdIsSNxGKzLtwBDapDTjYK4IG8jPvFAIl0ge54WyzQrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741861388; c=relaxed/simple;
	bh=6Zp16z/ZwuPo+7pikO6ZPdmlCGAFpXQpgVlmCPw52Nk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WfNy7bVidNqOwsrjQgutamEtgow9slAfl7VQEO5erMwHz8tYH4Sb3YF0L6Z5Pf4RvGNfSdG9TE0iULAwzEz1QV0LxbcKGOnbkF/H4LunpUTDa96W+a3J3w/lK3sWcku1kdCarsdXoWxQm0IZUHvUwEVvE9FYAku2bhCB+kE5Br8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tapMjnJv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22F59C4CEEE;
	Thu, 13 Mar 2025 10:22:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741861387;
	bh=6Zp16z/ZwuPo+7pikO6ZPdmlCGAFpXQpgVlmCPw52Nk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=tapMjnJvWODZjFnwLDKVu0YIGbvhMwYGSsMLqXXpyC4pe/twr9oARc+CaoV8WmthL
	 7TLcWckcqVVkE93QYIpKMefdZSH/nMFXKHfZv6pOQ+s6xBNq3izLjPYMP4HZAYUUyb
	 c1x+sx/lz91fIFEt8jlHcKwdJfNkLAQS8fn5WxDYRrgQauYES3LV59OyS93TZ+Z9lW
	 iL5MBYbKriTrUCQkwK9FtlAQny7MsHYxKHsHIbS+uJQb+URtc+UhT9MUR7an6JXyuC
	 BD3oAwMaDt/lrDqpbDfhzUYSvpgOn+Imo6udNx3xVLcFZLTYxp0/7okvt74NiRRpbK
	 BqcyIibAaaU1g==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 13 Mar 2025 11:20:58 +0100
Subject: [PATCH net-next 09/12] mptcp: sysctl: map path_manager to pm_type
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250313-net-next-mptcp-pm-ops-intro-v1-9-f4e4a88efc50@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1935; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=N2IFQOAThQfqK56P4258QGBDUIyIuKIiQtU284cvhaU=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBn0rGb1qvk/gHu2DPAgDn+va9otI+QEv5kDubbI
 R//Amrijz2JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ9KxmwAKCRD2t4JPQmmg
 czzkEACNho9pTZuUCE5oBMuFhM1yQYTE6ogu5Dl9RazH4ETr8ODlcJf+1/QqwZFZlaKKJnN5yGu
 thgYrjYBxnZZ24munheEpeG1BbjeWNEWtfvbsOigVnXKELB1L3hrZhMndNG6exJN862K6faH817
 E3L6bTPQ2LIDKQhnlA8EjdoWD4ozAUWhcRgJVTGr8EHPsUVUABpxJGFUsgg3J2IqQKVhCqHW79a
 Y9HiVOgl5ufc8pNzwHuETqXHnPs9oqdv96yYDif7owWSghjH2BebTGaLmZGWvBD2BdMASNnxmwu
 i7rk2ehnX5mdc/vUygK+//YwsHeiFmuixZr0WOXm9Nuaz1EIXnVOU0KZUxRCNhiC+fJjklhEaOZ
 bduZLG4lMFcxSjnbX7fRcMjZ8WNNC/+KKOfcKCoTceEJpiVfJaF2R5FHjfxEeC5fWKIEE14CqFU
 nWGb9UnbZyxVJKh7NQdcDhFUwVLQMQIj2E8WFevDas6oAQotT2fldTIe6LzBmB/zvYhiRwfUK35
 LjJnF+U23AwwrXQNv+t2dPxh26invwmaU21p69XdgSmwtQaOo/ZJK2rLl6yww1xwtt5A6hAj+//
 +aaMMJaB9MvZ7l5R/0zjoGazcqmt6DcsuiBmcmrkfpP46bWP5Y9xfaS65Vaqw+E9BxnJPS/bP28
 ZSXya5d1J3gRqBA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch maps the newly added path manager sysctl "path_manager"
to the old one "pm_type".

	path_manager   pm_type

	"kernel"    -> MPTCP_PM_TYPE_KERNEL
	"userspace" -> MPTCP_PM_TYPE_USERSPACE
	others      -> __MPTCP_PM_TYPE_NR

It is important to add this to keep a compatibility with the now
deprecated pm_type sysctl knob.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/ctrl.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
index 4209dc7f97048d27deea1923742dfd5ebd710694..cb0811e636ff2f4bb981d2688eb8d07946fc1744 100644
--- a/net/mptcp/ctrl.c
+++ b/net/mptcp/ctrl.c
@@ -200,6 +200,9 @@ static int mptcp_set_path_manager(char *path_manager, const char *name)
 static int proc_path_manager(const struct ctl_table *ctl, int write,
 			     void *buffer, size_t *lenp, loff_t *ppos)
 {
+	struct mptcp_pernet *pernet = container_of(ctl->data,
+						   struct mptcp_pernet,
+						   path_manager);
 	char (*path_manager)[MPTCP_PM_NAME_MAX] = ctl->data;
 	char pm_name[MPTCP_PM_NAME_MAX];
 	const struct ctl_table tbl = {
@@ -211,8 +214,18 @@ static int proc_path_manager(const struct ctl_table *ctl, int write,
 	strscpy(pm_name, *path_manager, MPTCP_PM_NAME_MAX);
 
 	ret = proc_dostring(&tbl, write, buffer, lenp, ppos);
-	if (write && ret == 0)
+	if (write && ret == 0) {
 		ret = mptcp_set_path_manager(*path_manager, pm_name);
+		if (ret == 0) {
+			u8 pm_type = __MPTCP_PM_TYPE_NR;
+
+			if (strncmp(pm_name, "kernel", MPTCP_PM_NAME_MAX) == 0)
+				pm_type = MPTCP_PM_TYPE_KERNEL;
+			else if (strncmp(pm_name, "userspace", MPTCP_PM_NAME_MAX) == 0)
+				pm_type = MPTCP_PM_TYPE_USERSPACE;
+			pernet->pm_type = pm_type;
+		}
+	}
 
 	return ret;
 }

-- 
2.48.1


