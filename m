Return-Path: <linux-kselftest+bounces-3889-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F76E844A6C
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jan 2024 22:51:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D28621C2107A
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jan 2024 21:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D2BA3A8C0;
	Wed, 31 Jan 2024 21:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VZH/AQB1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD04E3A297;
	Wed, 31 Jan 2024 21:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706737837; cv=none; b=uhExG/tCHmGbSs2r8lRP1mZ95thWEJw5LrAwnQa1frmA5l+pfct9ZXgYhYdq2O9RRndr25qZf+hwHO9ISXHgyukIDZfD2aGyuuFVryH46Hsq/juoeT0DVAEx4D0ysSvxHeY0s5gh50cUlpd4NLg7DezMt57LPArKf0eaWiSiSw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706737837; c=relaxed/simple;
	bh=5I5llBhTBkCmK0s7KWB8ojoj8fai4KIqQBLePXNkM3Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=D2rroDKp96kWOjLK7tWCdkLkZ/u3Sb+W2xnnHeS8Yi/hXLuyMnLxJn0LRnm4Oh785Is25CqCzpZGIapv1ltZBHap3c5WAQWqiy/x1mqhTm9F6ykdquLZDhDhtFMoRHksaFGMLRBCliu7bddeYO6lLkoJLMVI6tVE9GaGjODfm/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VZH/AQB1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 017A3C433C7;
	Wed, 31 Jan 2024 21:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706737836;
	bh=5I5llBhTBkCmK0s7KWB8ojoj8fai4KIqQBLePXNkM3Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=VZH/AQB1HTIqKoAi8L0V1p3SiGvI19V2+zWvLE3ayRxUvLpsKPpZ2iMmb4GnB9oJi
	 NIWXLusim+ivzhAzFyj5A/lJBz3X0i9BncZvPTH3yR7B0A9Yh/+cSodXkzXwlFNSGv
	 VdEbP3Wb/if8ye69tobjLmDUR83zKD1GM/fUhbvC+zLN8T86KNXWWViQT3D+Hr/IwS
	 rN/96gr9QdMyS/XljBpAVutW1L4+3gAccZKec1UtEua+vwdqk7CREiaMoHeeBLNyhB
	 wlO0JYWH+QPnX/uan2avcjYw1bNhE09XdQYLXf453mBfba9JUGaxJDs5VDEB3olO+P
	 WffR/VoQCfKVQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 31 Jan 2024 22:49:48 +0100
Subject: [PATCH net 3/9] selftests: mptcp: add missing kconfig for NF
 Filter in v6
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240131-upstream-net-20240131-mptcp-ci-issues-v1-3-4c1c11e571ff@kernel.org>
References: <20240131-upstream-net-20240131-mptcp-ci-issues-v1-0-4c1c11e571ff@kernel.org>
In-Reply-To: <20240131-upstream-net-20240131-mptcp-ci-issues-v1-0-4c1c11e571ff@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang.tang@linux.dev>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, stable@vger.kernel.org, 
 Geliang Tang <geliang@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1107; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=5I5llBhTBkCmK0s7KWB8ojoj8fai4KIqQBLePXNkM3Y=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBlusCgR8RgTQHbONhBRVmM2S0ggDA/5vmN8cGmt
 Pyg5HRagK6JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZbrAoAAKCRD2t4JPQmmg
 c8OdD/9RAu55NsbSe+vJrAYMbKNyV1Nq/mJhjcAPUkT671MytoyenLK9Fs7b8J7vkA3EsyYKYj0
 iIaU3axNzUJ4gKZWG9L8/9wGr/9pq6A0vIfuAK1kCTVyPu0XPIeswK0M4oCRZ24e9XdthtbGjVo
 ZtLU/2DCq4eAW2dEK/or/9R0Wj5QOB/KLl5VcJRozEjDjQuGb881+cZPkc7b1H70sIELtttqo5F
 06zsOK4AZyzJCS570/W4tITSpa8FLs/ZPfQMMRlCIVKps3Vn8RT0S/VUQnykrd/+82U7ciIfDA2
 HC5uSvtmxG8Mu7iHyL0krvyVZicFoXCzgtmyRsoKtPft/9Ai/Wa0hJe+uWjaUQIpgINuJf/iSLI
 CTiehkRhEV6uNvJT+hvAU5+h488oBdSWWKKgxpYfxg1igh9uVtXZLz2atYaZyUisYDt1Pwt190O
 CCmzZ9f1wo4ApqgGLqc8W6aVIuXouX4K/shweEA6Hd4phTgkbnvJlQic+XHaK5HJtSn+fZef4up
 fB4uYouUzCfTqv+9Z5lweyi8NmpHBorckBUHCaB4uLSleBWciRkHvW8jQAc3w8XbgckbbQCl3Ct
 NbHXErQipa5tL0Hgm5niibA5gqHMiE7U3mmjt2zm3jKOPgfsW5b6u9/URFKJYGpfFNznyeuUjNi
 gMRgHQInjz+jhPg==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Since the commit mentioned below, 'mptcp_join' selftests is using
IPTables to add rules to the Filter table for IPv6.

It is then required to have IP6_NF_FILTER KConfig.

This KConfig is usually enabled by default in many defconfig, but we
recently noticed that some CI were running our selftests without them
enabled.

Fixes: 523514ed0a99 ("selftests: mptcp: add ADD_ADDR IPv6 test cases")
Cc: stable@vger.kernel.org
Reviewed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/config | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/net/mptcp/config b/tools/testing/selftests/net/mptcp/config
index 2a00bf4acdfa..26fe466f803d 100644
--- a/tools/testing/selftests/net/mptcp/config
+++ b/tools/testing/selftests/net/mptcp/config
@@ -25,6 +25,7 @@ CONFIG_IP_MULTIPLE_TABLES=y
 CONFIG_IP_NF_FILTER=m
 CONFIG_IP_NF_TARGET_REJECT=m
 CONFIG_IPV6_MULTIPLE_TABLES=y
+CONFIG_IP6_NF_FILTER=m
 CONFIG_NET_ACT_CSUM=m
 CONFIG_NET_ACT_PEDIT=m
 CONFIG_NET_CLS_ACT=y

-- 
2.43.0


