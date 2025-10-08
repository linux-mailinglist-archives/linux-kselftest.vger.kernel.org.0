Return-Path: <linux-kselftest+bounces-42877-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D61ABC563E
	for <lists+linux-kselftest@lfdr.de>; Wed, 08 Oct 2025 16:09:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5F74D4F9B4B
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Oct 2025 14:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A94A628DB71;
	Wed,  8 Oct 2025 14:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CZzRYAGh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76A0419D8BC;
	Wed,  8 Oct 2025 14:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759932430; cv=none; b=l+uf/pAQrxr0dTtabvNT2EH0iPBxxn9RDCXLGVn8IcUnQ7yJT2Q+VIPbFfaLRQ24vsN6TatcYJqFDVC2j61hEG/MQU/SGZhflO2XdF/qiw2/UI/0Ew6NepLIPnrR3uIT9Xe4dCWHAKz/TyJwmxzjurYs4x4Tiz1/knruwy6M/8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759932430; c=relaxed/simple;
	bh=lf0jeq9WuhFVs0GcKHKg/KFcIfzovNAOJpAH5WgAu18=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=bz7zATNAS6Mx+0gLq/+exz1fBo5AYZTD5FVVOR4abzcrE/5AxDepYcsz9d1I0hC5rCuDw7EWfZsAHuLYNPwKWCGn7jnEHyDvLdfa9W95nyoORsh9wQ+aVm+zP7IthUOCEaHNZVZpxyvEGKHHjiKA9Q5VZl0mwIHBmWqSI+imwhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CZzRYAGh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EABBC4CEE7;
	Wed,  8 Oct 2025 14:07:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759932429;
	bh=lf0jeq9WuhFVs0GcKHKg/KFcIfzovNAOJpAH5WgAu18=;
	h=From:Subject:Date:To:Cc:From;
	b=CZzRYAGhJwSr3h4vIwTR1NjIwRxGwxYkflJZTdPYZ7G3Yg5GTdcup75QZ9xw7QXvt
	 Jk65mTziqgK4QpR2r22sEZ46aVPdB1Uqr4pBGaF99uiM1CcCKiwnYnJqRblBcdyJt3
	 6qjzdmEUm6sPI9rfbvxwPD+jciok+9WX3bbUSEkuU3ueIkAyiUInbeY2NHi/aAXkJc
	 7Gq/T6ZmIOQM4exqrS1zccyrbIdvMbEEZhWEVhRd/CnHB7sjQCFYSvQmxJlmXzepoC
	 syG5WPBsfd9rOouVRISsNG+tkBquqcLgbdWHlMyyZdTY8wdtXppk4n2NHqVI0eIp4n
	 +IPWVN93SMavQ==
From: Benjamin Tissoires <bentiss@kernel.org>
Subject: [PATCH 0/2] HID: multitouch: fix sticky-fingers quirks
Date: Wed, 08 Oct 2025 16:06:57 +0200
Message-Id: <20251008-fix-sticky-fingers-v1-0-760f1f26fce3@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAFw5mgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDSyMz3bTMCt3ikszk7EogEyhfVKxrkZhqYWFibAakjJSAGguKUoGqwIZ
 Gx9bWAgDHC/siZAAAAA==
X-Change-ID: 20250926-fix-sticky-fingers-8ae88436ae82
To: Jiri Kosina <jikos@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: Peter Hutterer <peter.hutterer@who-t.net>, linux-input@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Benjamin Tissoires <bentiss@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759932427; l=1455;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=lf0jeq9WuhFVs0GcKHKg/KFcIfzovNAOJpAH5WgAu18=;
 b=Aui5tcxP2bok6t05J0c3uNo4z/zejX2OQNo6bnYM4OpR4lhnEYe4A8VWcw84uVFf2TfxwjrrN
 XPalj8161a3BRnu0Dmkam5Bq8CyO3Jn/WCLLi75PkBZI+kjUDj/iguD
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

According to Peter, we've had for a very long time an issue on some
mutltiouch touchpads where the fingers were stuck in a scrolling mode,
or 3 fingers gesture mode. I was unable to debug it because it was
rather hard to reproduce.

Recently, some people raised the issue again on libinput, and this time
added a recording of the actual bug.

It turns out that the sticky finger quirk that was introduced back in
2017 was only checking the last report, and that those missing releases
also happen when moving from 3 to 1 finger (only 1 is released instead
of 2).

This solution seems to me to be the most sensible, because we could also
add the NSMU quirk to win8 multitouch touchpads, but this would involve
a lot more computations at each report for rather annoying corner cases.

Link: https://gitlab.freedesktop.org/libinput/libinput/-/issues/1194
Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
---
Benjamin Tissoires (2):
      HID: multitouch: fix sticky fingers
      selftests/hid: add tests for missing release on the Dell Synaptics

 drivers/hid/hid-multitouch.c                       | 27 ++++++-----
 .../testing/selftests/hid/tests/test_multitouch.py | 55 ++++++++++++++++++++++
 2 files changed, 69 insertions(+), 13 deletions(-)
---
base-commit: 54ba6d9b1393a0061600c0e49c8ebef65d60a8b2
change-id: 20250926-fix-sticky-fingers-8ae88436ae82

Best regards,
-- 
Benjamin Tissoires <bentiss@kernel.org>


