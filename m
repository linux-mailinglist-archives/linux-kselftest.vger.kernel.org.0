Return-Path: <linux-kselftest+bounces-8913-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E1E08B364E
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Apr 2024 13:09:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E7021F21C58
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Apr 2024 11:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D988144D3C;
	Fri, 26 Apr 2024 11:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="cYEkVXJg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC95E1448DA;
	Fri, 26 Apr 2024 11:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714129765; cv=none; b=lC3MOtIIlLEHtJ20Llyla93ObMwLqs4faV8OQ7GKNHR4g8Yl5RRbMculW/ZKHJ/MPVtH8nZO8DPxhiwkL4T8N0CCupvtYx3vSgAbSrGxXN+IAij2sQ6fn8TbX/r5iCtgcvV9j9d4ywcvMhu9zZcCAkZfwE3snK+Ue+zf6A3Aea8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714129765; c=relaxed/simple;
	bh=mCOsbA8XTKfUjIjHhFRg2pqvJ8L43G6NbXQZAzF3Vbw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=jHAFU/zu0L2ZDYKWmtByWdD0txxt0RXfeY3v/jpSo0q+BM2RxzCfl9C2oT9aSSGrmn6qoWKwmu8DWVzGlBZ/k+agz7rELos5mbOZc1m716kzCUDTpS5eOUqoA0X3HDhwqCGnANnUrGCvvLMilqT4jGF7qHi2l9CS4vrf3m6A0+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=cYEkVXJg; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1714129754;
	bh=mCOsbA8XTKfUjIjHhFRg2pqvJ8L43G6NbXQZAzF3Vbw=;
	h=From:Subject:Date:To:Cc:From;
	b=cYEkVXJgCHc2zQ0Uy+af5TwlHgFUDQO659R9n1CDJvIpA0aws4La6bfXs4cZ9ye7V
	 9j+/o/SR6AXuc7k8lCiLn7lM6vEImqnlw3PgG7EOgKzff/nxKt3l1mlsRxaVQ5hAIZ
	 S9ZgbSkVQOyZkxXBM+J9Dn9WbcMzm7aX1AtOX1jU=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH 0/3] tools/nolibc: implement strerror()
Date: Fri, 26 Apr 2024 13:08:55 +0200
Message-Id: <20240426-nolibc-strerror-v1-0-76a4c9c5271d@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAEeLK2YC/x3MTQqAIBBA4avErBPMn4KuEi3KxhoIjTEiEO+et
 PwW72VIyIQJxiYD40OJYqjo2gbcsYQdBW3VoKQy0igrQjxpdSLdjMyRRT94s/pFaqkt1Opi9PT
 +x2ku5QOeU4b4YQAAAA==
To: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1714129753; l=851;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=mCOsbA8XTKfUjIjHhFRg2pqvJ8L43G6NbXQZAzF3Vbw=;
 b=uJgbfX+df3lXaHIUXo8lzKb+2Xco784o6dJ2+5XYn2lpezgnzrZpQqhqx91S1CcZvxK1fdVuO
 +o0j1pXXfUMCc5sL9ZdTBZEihrkQZxbFzFLE2cFabAykFCVLU3nVHn2
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Adds a simple implementation of strerror() and makes use of it in
kselftests.

Shuah, could you Ack patch 3?
Willy, this should work *without* your Ack.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
Thomas Weißschuh (3):
      selftests/nolibc: introduce condition to run tests only on nolibc
      tools/nolibc: implement strerror()
      selftests: kselftest: also use strerror() on nolibc

 tools/include/nolibc/stdio.h                 | 10 ++++++++
 tools/testing/selftests/kselftest.h          |  8 -------
 tools/testing/selftests/nolibc/nolibc-test.c | 36 ++++++++++++++++++----------
 3 files changed, 33 insertions(+), 21 deletions(-)
---
base-commit: a3063ba97f31e0364379a3ffc567203e3f79e877
change-id: 20240425-nolibc-strerror-67f4bfa03035

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


