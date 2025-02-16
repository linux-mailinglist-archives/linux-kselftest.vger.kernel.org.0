Return-Path: <linux-kselftest+bounces-26748-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5E74A3755C
	for <lists+linux-kselftest@lfdr.de>; Sun, 16 Feb 2025 17:02:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5A9316EE4F
	for <lists+linux-kselftest@lfdr.de>; Sun, 16 Feb 2025 16:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90D7878F4B;
	Sun, 16 Feb 2025 16:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="bQIvUn1b"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA48355887
	for <linux-kselftest@vger.kernel.org>; Sun, 16 Feb 2025 16:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.77.79.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739721733; cv=none; b=hlGomLrwAU6tMv060cydjnU9l3bTrJZnRYXKG1cBZMMFb0h6o660W0wBfWHCaiG3KLxtxrDmXxE9z4lcV6Ni5i40z89UeqQisYE+aOMPRX3aTWURcylbacl6L9XwpijvlTCp8/WgsbkyUQFDaxCn6VGIIsfkU8rMqpuUyXA1bOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739721733; c=relaxed/simple;
	bh=DrFpAuUgCojBbVhqy3e9tBdipAyeY0/uf6RSS7XXZXE=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=C11pogMcsaAqFb8D4Gx/z/g87n+IRA9Yimp8b2K58ta6NRlI4n4/GkQ3uyOxtZLd3mfJyCJ4M5lzV8GWxfYTZOKCBQDdxAyORi+fD8nFa1/otXEDfgzfwVprqdNhJt568bnHph9kfzBFShlwCmW9G0Igo6oxVNWxTAgZ35cj7nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=bQIvUn1b; arc=none smtp.client-ip=51.77.79.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1739721715; x=1739980915;
	bh=DrFpAuUgCojBbVhqy3e9tBdipAyeY0/uf6RSS7XXZXE=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector:
	 List-Unsubscribe:List-Unsubscribe-Post;
	b=bQIvUn1b2Bz+L/WRubshu912FBI8lqNHdwFsI5zLlKDa5V7Jcxxaun8Q11TTLWToD
	 HewzcKXQMvDit9Bb/Vhqfm+xNh6D3GF/2B3bQ7RZlhrFG5Ip95f391Aj3FE8B2Wxgp
	 NxrFUSinxW6dJ7NKxeEvhQnG9e1m+SlKn3BLjMp1omCRfRCJ9Tu9iI7b3D251nIbIR
	 sXBB7/Rb+Gz7kHWpjE/fbnRQ6R7d80vyW1xnAid1P8nCRXIWfktiJP+/+ie0M6lR+2
	 XUVLr27MxIIQToYcsJXEp5NCwEoYKQS2Mq0+bNs3VAIfvKcvxCETkGo3eoQ00+7gti
	 mCBWbSb/3epLA==
Date: Sun, 16 Feb 2025 16:01:49 +0000
To: shuah@kernel.org
From: Imanol <imvalient@protonmail.com>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, Imanol <imvalient@protonmail.com>
Subject: [PATCH] selftests/core: fix repeated word in close_range_test.c comment
Message-ID: <20250216160114.83221-1-imvalient@protonmail.com>
Feedback-ID: 28866602:user:proton
X-Pm-Message-ID: 1368527d4ae133340ed3f0d12103bec4f24af3d3
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Fixes a minor grammatical issue in a comment in close_range_test.c
where "and and" was mistakenly repeated.

Signed-off-by: Imanol <imvalient@protonmail.com>
---
 tools/testing/selftests/core/close_range_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/core/close_range_test.c b/tools/testin=
g/selftests/core/close_range_test.c
index e0d9851fe1c9..c19e8d037211 100644
--- a/tools/testing/selftests/core/close_range_test.c
+++ b/tools/testing/selftests/core/close_range_test.c
@@ -506,7 +506,7 @@ TEST(close_range_cloexec_unshare_syzbot)
=20
 =09/*
 =09 * Create a huge gap in the fd table. When we now call
-=09 * CLOSE_RANGE_UNSHARE with a shared fd table and and with ~0U as upper
+=09 * CLOSE_RANGE_UNSHARE with a shared fd table and with ~0U as upper
 =09 * bound the kernel will only copy up to fd1 file descriptors into the
 =09 * new fd table. If the kernel is buggy and doesn't handle
 =09 * CLOSE_RANGE_CLOEXEC correctly it will not have copied all file
--=20
2.43.0



