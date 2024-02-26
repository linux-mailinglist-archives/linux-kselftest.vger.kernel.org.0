Return-Path: <linux-kselftest+bounces-5442-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE223867BC7
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Feb 2024 17:24:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6FC11C2A7C6
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Feb 2024 16:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1132E12E1F0;
	Mon, 26 Feb 2024 16:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="xZDChlsE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-42ae.mail.infomaniak.ch (smtp-42ae.mail.infomaniak.ch [84.16.66.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB7F012D75E
	for <linux-kselftest@vger.kernel.org>; Mon, 26 Feb 2024 16:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708964639; cv=none; b=E+R6NCcl2krPiMkeoYtFzXpRXlBjEFKhbnufKzKeir36IIYj9Q64AGtZJa4atgws30nBI10Dw0fAFP7gI88BWY4TUZ48VyXq/xVCtg7qLCpcuZE8AGqjLjs3AD7z1XupJ2nQYreRIzTYrOyXvINvBAtJkTd2X9+hVlrDEKrS10E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708964639; c=relaxed/simple;
	bh=olTfBIftIqoEp/VOpd1IMdJpxpy9THNXLqxVEH7X7MA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o7CCyY9M8+Yt3CQrQUxlLBS45Cn2VFf9L2WuZchuo9b4Ohx+61+Wzjl5DwJln94FkY8zhqYnOWz/AJxLyVOd9/9m7F8cEFzU2Mf+kZGbj/1Jx5YZqYTFTNh4dNh7pF7ThT3OM4vyuz3zEpIlutGRFp+VVv3KdJOaa17f3VfMv1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=xZDChlsE; arc=none smtp.client-ip=84.16.66.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [10.4.36.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Tk5XK1qpszMpp1c;
	Mon, 26 Feb 2024 17:23:45 +0100 (CET)
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4Tk5XJ2PmTzMpsDh;
	Mon, 26 Feb 2024 17:23:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1708964625;
	bh=olTfBIftIqoEp/VOpd1IMdJpxpy9THNXLqxVEH7X7MA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=xZDChlsEztJl/3JzQC3Bn0c7msXOSlb54AMYIWcWZux52vvfqgon1+CEliOtKCA45
	 eMnXxs1tNnsEop7VQ2Z+0WvzcU5AjBbdkBrocJ4XX8Omt4CKGSH4CrW8ytlWLnOhe8
	 OfjmD8h155QlFnNOglWeBImQq28ksGZA+KxKIYoI=
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Jakub Kicinski <kuba@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	Shuah Khan <shuah@kernel.org>,
	davem@davemloft.net
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Will Drewry <wad@chromium.org>,
	edumazet@google.com,
	jakub@cloudflare.com,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH 0/2] Merge TEST_F_FORK() into TEST_F()
Date: Mon, 26 Feb 2024 17:23:33 +0100
Message-ID: <20240226162335.3532920-1-mic@digikod.net>
In-Reply-To: <20240223160259.22c61d1e@kernel.org>
References: <20240223160259.22c61d1e@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Hi,

This is a long due cleanup to merge TEST_F_FORK() into TEST_F().

This should simplify Jakub's patches by removing the step counter:
https://lore.kernel.org/r/20240220192235.2953484-1-kuba@kernel.org

Regards,

Mickaël Salaün (2):
  selftests/landlock: Redefine TEST_F() as TEST_F_FORK()
  selftests/harness: Merge TEST_F_FORK() into TEST_F()

 tools/testing/selftests/kselftest_harness.h | 56 +++++++++-----------
 tools/testing/selftests/landlock/common.h   | 58 +--------------------
 2 files changed, 27 insertions(+), 87 deletions(-)

-- 
2.44.0


