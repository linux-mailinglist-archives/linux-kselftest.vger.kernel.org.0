Return-Path: <linux-kselftest+bounces-15671-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00C5495728E
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Aug 2024 19:58:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1AAB281142
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Aug 2024 17:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E866D18757F;
	Mon, 19 Aug 2024 17:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="mcictMM/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C7C8D531
	for <linux-kselftest@vger.kernel.org>; Mon, 19 Aug 2024 17:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724090328; cv=none; b=h54hUk5ctWEXyXmEibFDxNn+aovWH4hi51nTg1k2Owkf5DyTyOACUO+TFIHStlhdmvH3Bxa8UgE3qHHiln/v+xqFSd3CX1muFJBc6UKum/3N2M8lrTsGtNLfZqa3cW7MLy7mwmW0kleCFKrmtibbJDOYoIIG6IolONDC6CXIEok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724090328; c=relaxed/simple;
	bh=yLyg9V7XhkvVXxauBZI5xtyTwT6dA9OEKL3nbZMAijo=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=fADV4XL8iuzfP6/6nO+bCIhrg3E1i5fMa5f3Gli6yAusN3FJlwnfXaOTZzEbJugeKAHOTtUhaebPAsG1gSkMsldqH5O1ho9E6P3wR1oTT+aGZu4uQ05LY0zYch5vjcFjP8HwT+9M2r01R5t4IWEhrkM8FRAXPH8xgJuGzfRNnoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=mcictMM/; arc=none smtp.client-ip=185.70.40.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1724090320; x=1724349520;
	bh=yLyg9V7XhkvVXxauBZI5xtyTwT6dA9OEKL3nbZMAijo=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=mcictMM//pGL+W+7t4/Sa+T5rP98itAqQ/FXUfTGlUBUUNxusdEamApWh744ne16k
	 6QHulSwI44w4d44QgpmR2O7h4g0MxtGh1xyds86pbAFhr/tp9cWJ6jHh3CJ6RWo815
	 SyhZFuq4Y1yrczAPBgfiJt98chBfy1jgHn/FnxXD++hMX4QUJEYiqUbdPLtQzYbsoG
	 ZpKlcGfXz9fjuEQG+kTvlckoAlOAYkuuCA/3nN1VAO04Ij5pm58FGzOPmNr63XUOy7
	 27Q47uEdEpiU+Iv9EH/mYhzdeKRdjPp9JUNNtno8PK4ZLTi1bFQ8wH/KzZ7lIFjj+0
	 zv/O2Xwi43CBQ==
Date: Mon, 19 Aug 2024 17:58:34 +0000
To: anna-maria@linutronix.de, frederic@kernel.org, tglx@linutronix.de, jstultz@google.com, sboyd@kernel.org, shuah@kernel.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
From: Piotr Zalewski <pZ010001011111@proton.me>
Cc: Piotr Zalewski <pZ010001011111@proton.me>, Shuah Khan <skhan@linuxfoundation.org>
Subject: [PATCH] kselftest: timers: Fix const correctness
Message-ID: <20240819174814.139344-3-pZ010001011111@proton.me>
Feedback-ID: 53478694:user:proton
X-Pm-Message-ID: 0c572e0225d05ecc79ba83a6ca58e75e9ec342dc
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Make timespec pointers, pointers to const in checklist function. As a
consequence, make list parameter in checklist function pointer to const
as well. Const-correctness increases readability.

Improvement was found by running cppcheck tool on the patched file as
follows:
```
cppcheck --enable=3Dall \
=09tools/testing/selftests/timers/threadtest.c \
=09--suppress=3DmissingIncludeSystem \
=09--suppress=3DunusedFunction
```

Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Piotr Zalewski <pZ010001011111@proton.me>
---
 tools/testing/selftests/timers/threadtest.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/timers/threadtest.c b/tools/testing/se=
lftests/timers/threadtest.c
index 76b38e41d9c7..d5564bbf0e50 100644
--- a/tools/testing/selftests/timers/threadtest.c
+++ b/tools/testing/selftests/timers/threadtest.c
@@ -38,10 +38,10 @@ struct timespec global_list[LISTSIZE];
 int listcount =3D 0;
=20
=20
-void checklist(struct timespec *list, int size)
+void checklist(const struct timespec *list, int size)
 {
 =09int i, j;
-=09struct timespec *a, *b;
+=09const struct timespec *a, *b;
=20
 =09/* scan the list */
 =09for (i =3D 0; i < size-1; i++) {
--=20
2.46.0



