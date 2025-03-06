Return-Path: <linux-kselftest+bounces-28431-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13F02A558CB
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Mar 2025 22:30:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16E0A3A4132
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Mar 2025 21:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51D8D25D54C;
	Thu,  6 Mar 2025 21:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="NRltbskW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D55F1F63F0;
	Thu,  6 Mar 2025 21:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741296640; cv=none; b=hFDqtK58CYD4XXoO2IRvJNkus0YGafLZ06bcrYdkohzfpWWlDS8Ut7stkvyEb+/f+sGlBS4axWfYU1Y8qE4tDtUi8FxqCjbwDEJb79SQcx9hI6Mf1uunOJFK5nXn2CIEHSK9eBNzYd/sR0rkLLOeayt96I2mLsKOfhFAJyCVsQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741296640; c=relaxed/simple;
	bh=fx3T++XA1b7rABpHHhBVZ/BYs0pW9GWFRxD8niUUCjY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=pOd1VTmdNGk9UY6IH4Mqp12cq+dNb3gi7CxsjfbQJKkvLYBu4zld2hrT3P623ZWe6fE4dVpLqOKeUZpw56t5RbnaJl+Xp6m8FjEAbSfivIaHn7UxZ7I9+Y3uTefvpze+CMOFZ8VLCLsVJB1Nij+YrMSIdEqHrT0odoXj7A+BcT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=NRltbskW; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1741296635;
	bh=fx3T++XA1b7rABpHHhBVZ/BYs0pW9GWFRxD8niUUCjY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=NRltbskW+zyjX/q01O5S4kR5XmEc5hBLX2nqrzNViyQi38caVis3lKVqnU7tgrO+i
	 xxVJd9oM6UaisQcY1SRmt4tcbhps/DMBhbJ8IY0OcJOsQLJGefyTxasERrUXaBxvGi
	 epuDtW4eyW7WJFjqULanGwnJf48UHxdnYrax420Q=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>, 
 Louis Taylor <louis@kragniz.eu>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
In-Reply-To: <20250306184147.208723-1-louis@kragniz.eu>
References: <20250306184147.208723-1-louis@kragniz.eu>
Subject: Re: [PATCH v3 1/5] tools/nolibc: add support for openat(2)
Message-Id: <174129663441.867213.12146313045124477794.b4-ty@weissschuh.net>
Date: Thu, 06 Mar 2025 22:30:34 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.14.2


On Thu, 06 Mar 2025 18:41:18 +0000, Louis Taylor wrote:
> openat is useful to avoid needing to construct relative paths, so expose
> a wrapper for using it directly.
> 
> 

Applied, thanks!

[1/5] tools/nolibc: add support for openat(2)
      commit: b2edaad7f5192a79384b7d0bec62312b668da463
[2/5] tools/nolibc: always use openat(2) instead of open(2)
      commit: fbd4f52f5bf76e6ef63d7ebee16d404c6c8cfebb
[3/5] tools/nolibc: process open() vararg as mode_t
      commit: 90e1f9f7440cba79716a9d5b0c9df2ce6a661197
[4/5] tools/nolibc: drop outdated example from overview comment
      commit: 00e03fea969efd46b104acd271e7f7e08e7c23bf
[5/5] selftests/nolibc: use O_RDONLY flag instead of 0
      commit: 6e406202a44a1a37176da0333cec10d5320c4b33

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


