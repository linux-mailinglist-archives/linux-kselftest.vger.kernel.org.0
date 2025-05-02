Return-Path: <linux-kselftest+bounces-32176-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E2378AA71D2
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 May 2025 14:30:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FC2317AF03
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 May 2025 12:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE6A1252905;
	Fri,  2 May 2025 12:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bs/RvbP3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C224210185;
	Fri,  2 May 2025 12:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746188977; cv=none; b=CNJR4FJMOwvQeVNJEWQJ6bqKLQUkQ/d3cpZ8S3CPTIFICDzjhffj3+e1i/8rswPLpxLgwwymUllMCyVJeCPLGYt+KmrYQpOBrUM0JSTsG6qA07xDCasTIcGF+7lvlTiVXQmgL7Q5dDEwagXi5Gu4BWM5UxmqichZekCMxevdchc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746188977; c=relaxed/simple;
	bh=vK3ZgjmAYZDBT2TonfStj4hrwMJyCwyX8m+dP79eAlg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=VRLtEbW9BxNbWYoQDOeyNXXJWLWS9pKqGWjCE4BlVTeY26zWNU8HLPEMimdqTit+U3JyATAey4pinvGZmT2PW1gmhn8Er0aiDkuC69qX0hdjSuwbJbIU9/ajtMm7s7BSfW9yay/m/lbTz5NBpi4GhJkZO3OCmAZkPOmkuDtmWhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bs/RvbP3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62DDDC4CEE4;
	Fri,  2 May 2025 12:29:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746188976;
	bh=vK3ZgjmAYZDBT2TonfStj4hrwMJyCwyX8m+dP79eAlg=;
	h=From:Subject:Date:To:Cc:From;
	b=bs/RvbP37AM2ZNrVxSY7HAtmUH3aTSVEEWbyZ/jzpWRMO/j13LS1SG5Z+5t5Dqg1U
	 YfPhENQTb736rzznGOA3Paf0ThFVxxSueEiJNLCa6hxrGIzscdzFgf3ZO+FtkzNYnC
	 Njbj57V1ZKcJRHdZYcj/wDvPy4qbUq2/9piEqivbbBvCwNbtP55O1bZfFpgZKhIHFD
	 2bjxVJIdmwEG85z9oiYTTDprMtmuuarN44zYhST3ZZSLaYrrUMVWB8iYQ64uTnAtF8
	 MsKCZyRANuBCQs13hovlLU9dOw+2WLXXXRFcmul0fb/Ut3J1H3inV8nhewhiyoYigl
	 76WEfo9RP7miQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH net-next 0/7] selftests: mptcp: increase code coverage
Date: Fri, 02 May 2025 14:29:20 +0200
Message-Id: <20250502-net-next-mptcp-sft-inc-cover-v1-0-68eec95898fb@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKC6FGgC/zWMQQqAIBAAvxJ7bsE0CfpKdBBbaw+ZqIQQ/j0JO
 sxhDjMPJIpMCebugUg3J758k6HvwB7G74S8NQcppBZaSPSUGyXjGbINmFxG9hbtdVNEp2kzk1B
 6VBLaIkRyXL79An8Ja60vF909EXgAAAA=
X-Change-ID: 20250502-net-next-mptcp-sft-inc-cover-f5eda7035432
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Gang Yan <yangang@kylinos.cn>, Geliang Tang <geliang@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1550; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=vK3ZgjmAYZDBT2TonfStj4hrwMJyCwyX8m+dP79eAlg=;
 b=kA0DAAoWfCLwwvNHCpcByyZiAGgUuqWjxQyRvn/laj8FmQ6w7jPaW8zXy5Q1qlHLB2xsqQq+A
 Yh1BAAWCgAdFiEEG4ZZb5nneg10Sk44fCLwwvNHCpcFAmgUuqUACgkQfCLwwvNHCpc7rwD/a/we
 P6tFGdt6wv2sQXNYEi3F6UmW1f6UsVjG8awQNb8A/17Dm+NIFz9G9kk/2Ic1hk4G5dNc7Qva482
 JOfbzeBIG
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Here are various patches slightly improving MPTCP code coverage:

- Patch 1: avoid a harmless 'grep: write error' warning.

- Patch 2: use getaddrinfo() with IPPROTO_MPTCP in more places.

- Patch 3-6: prepare and add support to get info for a specific subflow
  when giving the 5-tuple.

- Patch 7: validate the previous patch and cover "subflow_get_info_size"
  in the kernel code (mptcp_diag.c).

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Gang Yan (5):
      selftests: mptcp: add struct params in mptcp_diag
      selftests: mptcp: refactor send_query parameters for code clarity
      selftests: mptcp: refactor NLMSG handling with 'proto'
      selftests: mptcp: add helpers to get subflow_info
      selftests: mptcp: add chk_sublfow in diag.sh

Geliang Tang (1):
      selftests: mptcp: sockopt: use IPPROTO_MPTCP for getaddrinfo

Matthieu Baerts (NGI0) (1):
      selftests: mptcp: info: hide 'grep: write error' warnings

 tools/testing/selftests/net/mptcp/diag.sh         |  32 +++
 tools/testing/selftests/net/mptcp/mptcp_diag.c    | 228 +++++++++++++++++++---
 tools/testing/selftests/net/mptcp/mptcp_inq.c     |  16 +-
 tools/testing/selftests/net/mptcp/mptcp_lib.sh    |   7 +-
 tools/testing/selftests/net/mptcp/mptcp_sockopt.c |  16 +-
 5 files changed, 257 insertions(+), 42 deletions(-)
---
base-commit: 630cb33ccfcd04563598d0f0edd96c94ddf3352d
change-id: 20250502-net-next-mptcp-sft-inc-cover-f5eda7035432

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>


