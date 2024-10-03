Return-Path: <linux-kselftest+bounces-18945-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6339898E8B8
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Oct 2024 05:13:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24B82287EF5
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Oct 2024 03:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42F7F18054;
	Thu,  3 Oct 2024 03:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Lfai5xiL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB7620309
	for <linux-kselftest@vger.kernel.org>; Thu,  3 Oct 2024 03:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727925205; cv=none; b=ZEl4CEhFQX2EbFgK6EjKJtnHnC2ZyDsMaTTvRDg8uL13Nq4iFZ4e2nqIeamyNm+CQmV+7edog58/M72JQikHYaziTHMKvgWEWXbOjQf9CFN/A/BD1WAxv6ioPIzvUfOlwb0gTuK6bkfKzfMU/HfJFqfaPgcJSy/PhcS9PIqY0D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727925205; c=relaxed/simple;
	bh=bERMapEBkq80KwLiL5wH+eyoveOTA8BFK6BZqXxwQTE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YA2kemffsQYh/zpQMUb/2FoGIvts9HZDvYM4oDNCp2prFU1Lb529I2TikDYaGLg+hzQ0yD7z1HLlNOVHspXEvkRNPOOdgqJJ9f1u1KHlyRIeIBtMtTV47bf9vbl7LAUEqu37fBe4sOeijlykhnB3Is0G1LsHP43qG9h/oszAGcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=Lfai5xiL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C342EC4CEC2;
	Thu,  3 Oct 2024 03:13:23 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Lfai5xiL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1727925202;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WkV2muTqJsirevVqiDwiX5daLLurajzXmoxxyTZLZig=;
	b=Lfai5xiL11dSWm8U+JeeBE/+dTTqZf9MFQPZoVNbiHF9OhCsmVkwlBO9767gwmsVjYFv1Z
	3brmk2b+xw08zKIO0CAy+HUrZ0tlSX7H2IkoDZPl75Fvj5zdTqr22NxW6qJYA8UHFUryWV
	PR5LDnRvMX0qI79g0yUrKQUKfAYp0H8=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 97a87992 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 3 Oct 2024 03:13:21 +0000 (UTC)
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: skhan@linuxfoundation.org,
	greg@kroah.com,
	linux-kselftest@vger.kernel.org
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH kselftest 0/3] getrandom & chacha cleanups
Date: Thu,  3 Oct 2024 05:13:04 +0200
Message-ID: <20241003031307.2236454-1-Jason@zx2c4.com>
In-Reply-To: <Zv20olVBlnxL9UnS@zx2c4.com>
References: <Zv20olVBlnxL9UnS@zx2c4.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Shuah,

I've now read your email several times trying to figure out what you
meant and what your objections are. This series is my best attempt at
trying to satisfy that. But my understanding still has a lot of question
marks, so I may have missed your point here. Nonetheless, maybe this
moves things forward a bit.

Jason

Cc: Shuah Khan <skhan@linuxfoundation.org>
Cc: Greg KH <greg@kroah.com>

Jason A. Donenfeld (3):
  selftests: vDSO: condition chacha build on chacha implementation
  selftests: vDSO: unconditionally build getrandom test
  selftests: vDSO: improve getrandom and chacha error messages

 tools/testing/selftests/vDSO/Makefile         |  4 +-
 .../testing/selftests/vDSO/vdso_test_chacha.c | 27 ++++---
 .../selftests/vDSO/vdso_test_getrandom.c      | 75 ++++++++-----------
 3 files changed, 52 insertions(+), 54 deletions(-)

-- 
2.46.0


