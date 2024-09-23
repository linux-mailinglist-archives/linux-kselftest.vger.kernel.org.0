Return-Path: <linux-kselftest+bounces-18246-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CEE1697EFD9
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Sep 2024 19:31:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CD5B282904
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Sep 2024 17:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F68019F133;
	Mon, 23 Sep 2024 17:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lkcamp.dev header.i=@lkcamp.dev header.b="OmPqdtpm";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="eYSPNvDg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B62881AD7
	for <linux-kselftest@vger.kernel.org>; Mon, 23 Sep 2024 17:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727112684; cv=none; b=E3pWfEfNmpWfs0O5cJ6KyhSUYhCEhtz2MNCkM1Zvqi0JPSrRkiPJNnrOb7eL/vpqUEapacCi8nhxBb8q65xQ/h4HcDFMugUeZbZ8prMRw62gKHu9cixSza/rFyS3mm3amNDeXiUb/kUXZXOS4+Yd51E096SkmUJuLlymBlzXZiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727112684; c=relaxed/simple;
	bh=2nL+gJE/xUGOiECsRdkY2s0zPbV1/VkEl3IslBMeitQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EwVu1MAX46JBUqGJXoXiwAgkEXNKYT50tK48FM6CYm1iMGrUQj1997ce/5ifEo65biXhlbZFlNHDupBZ/q/VT9ZsmNZgAPa79FjYA55rIPz8GJMBfAvWl6M0mHN3N1HAQ7aSKjANo2oR5oWlLKjx7wc9QxIngG1zJhzUG2wDpDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lkcamp.dev; spf=pass smtp.mailfrom=lkcamp.dev; dkim=pass (2048-bit key) header.d=lkcamp.dev header.i=@lkcamp.dev header.b=OmPqdtpm; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=eYSPNvDg; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lkcamp.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lkcamp.dev
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=OmPqdtpmz6efyksDBUQRS60DihVRA8nbZkrLCv3lixKlera9U5lNVDkslyuA1Y188JNhYhoFQWSc0cb5xU929V8AmIlJte2EPNo1vWioA1HGWI0B5R4w07xIOyGFTu3uoPI/KPj5Y14g7pHA6tohSFNU+uBE97/4Ww59bhNozVaNj5in6Iy4PEWNJwZr6EnLruO8F/I50ApqsDBMAv7D/NKwNWI8MLIsVNCAYSLjhJOa8pijTdGDyy/ZCvPeHQHYhLaCbSweZVUCumlldi0HAUhzEFk4GwEZgj9cgOPKi/2MQNQBklp0ZvtFCb5UjoS0mIGTNP/uyj3fv+1tNB3uyw==; s=purelymail3; d=lkcamp.dev; v=1; bh=2nL+gJE/xUGOiECsRdkY2s0zPbV1/VkEl3IslBMeitQ=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=eYSPNvDgAyv26z29oMilC/m4jGEcDCkWtcbcm7he1RgpwBBiX5DiBhOblYdgLMJLbgMvoAnafgtofN8OkzbRvh100UYiQHpjoj8piOqc4GmndysAoMcqHXfIYHn3Rj9vUv8GhDnvE4AvgB1c/NZef08hr5ZBJZz+bXHaltrp+oLMikqSHZN1SrCY0z2CJk4XavBjnxBw/eL0CX8T/fEuXEksO5mlkcD8SFBujm7aR7Svof6SPKnYtC7oIk5MOm67r/uozZH/g6EELWdYArTcTwrH76NR4eA4srvhA80YofQs4JHtwwjuYP3K7uVkjSQo9c3tjuxb9KyMXh9nm+vvMg==; s=purelymail3; d=purelymail.com; v=1; bh=2nL+gJE/xUGOiECsRdkY2s0zPbV1/VkEl3IslBMeitQ=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 40598:7130:null:purelymail
X-Pm-Original-To: linux-kselftest@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -1005398190;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Mon, 23 Sep 2024 17:31:09 +0000 (UTC)
From: Gabriela Bittencourt <gbittencourt@lkcamp.dev>
To: Gabriel Krisman Bertazi <krisman@kernel.org>,
	David Gow <davidgow@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	linux-fsdevel@vger.kernel.org,
	~lkcamp/patches@lists.sr.ht
Cc: linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com,
	porlando@lkcamp.dev,
	dpereira@lkcamp.dev,
	gbittencourt@lkcamp.dev
Subject: [PATCH 2/2] unicode: kunit: change tests filename and path
Date: Mon, 23 Sep 2024 14:34:54 -0300
Message-ID: <20240923173454.264852-3-gbittencourt@lkcamp.dev>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20240923173454.264852-1-gbittencourt@lkcamp.dev>
References: <20240923173454.264852-1-gbittencourt@lkcamp.dev>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail
Content-Type: text/plain; charset=UTF-8

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
2.46.1


