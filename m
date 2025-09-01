Return-Path: <linux-kselftest+bounces-40417-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EB9BB3DEB3
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Sep 2025 11:40:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23EEC3A5A94
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Sep 2025 09:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA71B3054E9;
	Mon,  1 Sep 2025 09:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PA5DV3WK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 939BB2FF16F;
	Mon,  1 Sep 2025 09:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756719601; cv=none; b=eUcIB6Y15knpAlPykjzNdy32+FnGY3sVQZnx65YeMfd/wrAO6hfRe1hRwRYAG17D16gYzlye0BT5J33qmN+OVqXOtxZpqhuYaVIbSjjgFrbWNYffxEAV8gzRJ8kGQqgE5I6LtC8t6zi0hqTmgJ4l8/ri+YCcJTMi0VPHZwIsGyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756719601; c=relaxed/simple;
	bh=A5Tl+xbMpqKmmcwfLLF9FVQa1SsSWKl0bEyUbormmWU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=NVpngQsA7AeCUFM+/TSMwATA4lJordaZgg54H1AtYcWQ1PMdEEwWd/dLl6KdaAa1dw28aTdwov5HmfrrUUBmUF+b4QfVcUIbKqo10dQo85mU6BtLCTV/bkVDJjtw7934RDakcH8pXLhpp1gdtdizHQ5NoFnzlKF75gaKWtVSB7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PA5DV3WK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D54D4C4CEF0;
	Mon,  1 Sep 2025 09:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756719600;
	bh=A5Tl+xbMpqKmmcwfLLF9FVQa1SsSWKl0bEyUbormmWU=;
	h=From:Subject:Date:To:Cc:From;
	b=PA5DV3WK15MlJ2GaGAu+Fy+5qwrJOXW6XfiU5TuPF/s0hRJhQCAjVDKNj1Xx/vdoD
	 1waJuLa/O+KsoKJKCTLoZF0stpatnHWN7ccf2J26+Vn0jBbg7OHmO6Wh1rsfgHwP56
	 Yb6ayWBBaNk8Oe46iTNSTFOk6aCW3YSju2hOnYD1Xn3vr0SxMdvpDU4sS3+CiGskR8
	 0PTIGry1hNqEyXrwfBJiEyE+9x1oZ4aFQAgnjvKCLwtd61RwlA+30DjuBiNjFM8n3W
	 h+zR9L7nmMyYW9jp58H1XecLcuHZ7/HQsL085zrFfxxL18lpo64Fd0OD7x/EvWJA66
	 eaybc+HsPCGsg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH net-next 0/6] mptcp: misc. features for v6.18
Date: Mon, 01 Sep 2025 11:39:09 +0200
Message-Id: <20250901-net-next-mptcp-misc-feat-6-18-v1-0-80ae80d2b903@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAL1ptWgC/zWMMQqEMBAAvyJb30KycBr9ilwR4ka3MIYkSED8+
 wXBYoopZi7InIQzTN0FiU/JcoQm+tOB22xYGWVpDqToqwyNGLg0asE9Fhdxl+zQsy3YozY4EHl
 rBtsrr6E9YmIv9fnP8Kbwu+8/Su9uoHkAAAA=
X-Change-ID: 20250829-net-next-mptcp-misc-feat-6-18-722fa87a60f1
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Eric Biggers <ebiggers@kernel.org>, Christoph Paasch <cpaasch@openai.com>, 
 Gang Yan <yangang@kylinos.cn>, Geliang Tang <geliang@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1463; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=A5Tl+xbMpqKmmcwfLLF9FVQa1SsSWKl0bEyUbormmWU=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDK2Zj75+3Bdm8TZJ981i79oS83s2T9h3nSFvC0++zZJ7
 5SzPtxU0lHKwiDGxSArpsgi3RaZP/N5FW+Jl58FzBxWJpAhDFycAjCRQi2G/2Fbwy6dV10iFGx5
 iGGJ2cyyljOyAqd1Qjf8m6eVcTOCiYXhn2VxweyARbevL81RLlGt+SLmvNng2bWVzwxjzG0Dt6j
 t4AMA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

This series contains 4 independent new features:

- Patch 1: use HMAC-SHA256 library instead of open-coded HMAC.

- Patches 2-3: make ADD_ADDR retransmission timeout adaptive + simplify
  selftests.

- Patch 4: selftests: check for unexpected fallback counter increments.

- Patches 5-6: record subflows in RPS table, for aRFS support.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Christoph Paasch (2):
      net: Add rfs_needed() helper
      mptcp: record subflows in RPS table

Eric Biggers (1):
      mptcp: use HMAC-SHA256 library instead of open-coded HMAC

Gang Yan (1):
      selftests: mptcp: add checks for fallback counters

Geliang Tang (2):
      mptcp: make ADD_ADDR retransmission timeout adaptive
      selftests: mptcp: remove add_addr_timeout settings

 Documentation/networking/mptcp-sysctl.rst       |   8 +-
 include/net/rps.h                               |  85 ++++++++++------
 net/mptcp/crypto.c                              |  35 +------
 net/mptcp/pm.c                                  |  28 +++++-
 net/mptcp/protocol.c                            |  21 ++++
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 126 +++++++++++++++++++++++-
 6 files changed, 231 insertions(+), 72 deletions(-)
---
base-commit: d23ad54de795ec0054f90ecb03b41e8f2c410f3a
change-id: 20250829-net-next-mptcp-misc-feat-6-18-722fa87a60f1

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>


