Return-Path: <linux-kselftest+bounces-18538-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7B98989213
	for <lists+linux-kselftest@lfdr.de>; Sun, 29 Sep 2024 02:00:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77307282FEB
	for <lists+linux-kselftest@lfdr.de>; Sun, 29 Sep 2024 00:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCCE918654;
	Sun, 29 Sep 2024 00:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lkcamp.dev header.i=@lkcamp.dev header.b="MwJp+lmQ";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="WhG8M+pU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E6323A6
	for <linux-kselftest@vger.kernel.org>; Sun, 29 Sep 2024 00:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727568039; cv=none; b=hSRxNH8lgyUDF95itagmSglKgNzJwPabCxJss6Ka/TCAzleILM0MuEF2ZrG/W44UuE2gVn5P5p4UHcVPJSVKXuUOSYsIuvvuacaDWPfVXopwbaTsn85adryiDnne675HdaBRHZdWp/m9RIVWf08oRoM/xfStRsvJoNRU2hyVsdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727568039; c=relaxed/simple;
	bh=qnt8JOsglnwzOFAC+5xIC5C60u7IzbBOrel4S8SbeGc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LqnHLPBtdG3F9mC0P4c9EAn5g+3nBxHHql5VlIGaQbMlEIE6qVaqA8SVmMTM2jVJQWw4WyyYf58bFuKoFqT1kBad4r/d3W2ow8VqPlMf2j1dlo5IUxws16+0fP6uygvQ2JsiEcfst/vtsAXwHPvcDi4l+t7dz3+YcW4CFbbOX/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lkcamp.dev; spf=pass smtp.mailfrom=lkcamp.dev; dkim=pass (2048-bit key) header.d=lkcamp.dev header.i=@lkcamp.dev header.b=MwJp+lmQ; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=WhG8M+pU; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lkcamp.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lkcamp.dev
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=MwJp+lmQeQkphmDS/ozWktcXzZYUHs1Pa34ZxpOB4hpJErHFXkRgIq9DsE9n18FKg+9Ago/bmNBcy3e/ZbGxEdWP/eU6F4FYzHAlN7VOfRg0OtdE3OfnkfDh8eTp17YMGrixflRgVUXyqQDOndBJ9Wb8YZ54Ou6qPj2xmcDtN81pWpEs9mOOz7WemDFhuWMVl2cwUuwMGd/cSbFqCiPl3KTkmPe+XUHsK+AK4xIRTje024FbnWKvhas5zaxasfenBH1b+Xb256hsOh4qaqUhT+RYG0wVAnDE0bPzkBpLlOTikK1jJBr5QamqAqQFux71l0FzVvAkFHsFqpTQOkL5Qg==; s=purelymail1; d=lkcamp.dev; v=1; bh=qnt8JOsglnwzOFAC+5xIC5C60u7IzbBOrel4S8SbeGc=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=WhG8M+pUv5xZI4XCZk5uw+BJJkEmsv73/KYfrActX8LRA9ZQ9b3a741ZqNoHZuFHXXacJ255FCZ9Wk/ltAPqh4f/7PWo732NQ9xe6qEED9HCRU/odi5dZZ2MfrXwEwSaKpOCU0Goezc5/b/XjEsILv4HmJeghEThG8lyj8jmTFbwMiSnBZEJOoMaPcIkaLMNhO5OmbBUecq8UibLpBGq/06+cUc03HpsslHVC5fh1gNKC3bZfaY79YrUdPFTIkM7EEL3xAGe5X+SqTRDGjCTPVL/vibJpCA6KBaDG0NClEuH45yOPBHCdM5gmNsZnVaGPla/JsediR1YhNtsDVhsaQ==; s=purelymail1; d=purelymail.com; v=1; bh=qnt8JOsglnwzOFAC+5xIC5C60u7IzbBOrel4S8SbeGc=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 48571:7130:null:purelymail
X-Pm-Original-To: linux-kselftest@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 1507990812;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Sun, 29 Sep 2024 00:00:28 +0000 (UTC)
From: Pedro Orlando <porlando@lkcamp.dev>
To: Gabriel Krisman Bertazi <krisman@kernel.org>,
	David Gow <davidgow@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	linux-fsdevel@vger.kernel.org,
	~lkcamp/patches@lists.sr.ht,
	linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com
Cc: Pedro Orlando <porlando@lkcamp.dev>,
	Gabriela Bittencourt <gbittencourt@lkcamp.dev>,
	Danilo Pereira <dpereira@lkcamp.dev>
Subject: [PATCH v2 2/2] unicode: kunit: change tests filename and path
Date: Sat, 28 Sep 2024 20:58:28 -0300
Message-Id: <20240928235825.96961-3-porlando@lkcamp.dev>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240928235825.96961-1-porlando@lkcamp.dev>
References: <20240928235825.96961-1-porlando@lkcamp.dev>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail
Content-Type: text/plain; charset=UTF-8

From: Gabriela Bittencourt <gbittencourt@lkcamp.dev>

Change utf8 kunit test filename and path to follow the style
convention on Documentation/dev-tools/kunit/style.rst

Co-developed-by: Pedro Orlando <porlando@lkcamp.dev>
Signed-off-by: Pedro Orlando <porlando@lkcamp.dev>
Co-developed-by: Danilo Pereira <dpereira@lkcamp.dev>
Signed-off-by: Danilo Pereira <dpereira@lkcamp.dev>
Signed-off-by: Gabriela Bittencourt <gbittencourt@lkcamp.dev>
---
 fs/unicode/Makefile                                | 2 +-
 fs/unicode/{ =3D> tests}/.kunitconfig                | 0
 fs/unicode/{utf8-selftest.c =3D> tests/utf8_kunit.c} | 0
 3 files changed, 1 insertion(+), 1 deletion(-)
 rename fs/unicode/{ =3D> tests}/.kunitconfig (100%)
 rename fs/unicode/{utf8-selftest.c =3D> tests/utf8_kunit.c} (100%)

diff --git a/fs/unicode/Makefile b/fs/unicode/Makefile
index 37bbcbc628a1..d95be7fb9f6b 100644
--- a/fs/unicode/Makefile
+++ b/fs/unicode/Makefile
@@ -4,7 +4,7 @@ ifneq ($(CONFIG_UNICODE),)
 obj-y=09=09=09+=3D unicode.o
 endif
 obj-$(CONFIG_UNICODE)=09+=3D utf8data.o
-obj-$(CONFIG_UNICODE_NORMALIZATION_KUNIT_TEST) +=3D utf8-selftest.o
+obj-$(CONFIG_UNICODE_NORMALIZATION_KUNIT_TEST) +=3D tests/utf8_kunit.o
=20
 unicode-y :=3D utf8-norm.o utf8-core.o
=20
diff --git a/fs/unicode/.kunitconfig b/fs/unicode/tests/.kunitconfig
similarity index 100%
rename from fs/unicode/.kunitconfig
rename to fs/unicode/tests/.kunitconfig
diff --git a/fs/unicode/utf8-selftest.c b/fs/unicode/tests/utf8_kunit.c
similarity index 100%
rename from fs/unicode/utf8-selftest.c
rename to fs/unicode/tests/utf8_kunit.c
--=20
2.34.1


