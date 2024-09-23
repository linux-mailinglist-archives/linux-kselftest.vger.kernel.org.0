Return-Path: <linux-kselftest+bounces-18244-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4744397EFD6
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Sep 2024 19:31:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61F071C213BB
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Sep 2024 17:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5BA319B3F6;
	Mon, 23 Sep 2024 17:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lkcamp.dev header.i=@lkcamp.dev header.b="MXhb+Uhx";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="iZs8KkIb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D7B219F133
	for <linux-kselftest@vger.kernel.org>; Mon, 23 Sep 2024 17:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727112678; cv=none; b=jhM1/sF9HKmipBpFVnmxTs1EmOO9GBvPwNAaoguIbVvRDDWSP7zDZwx3bhCHjVbbcU4RuKbeCMsAbYpMAmzoavyu3lSiKoMyr+J2tl+1EnpJXkYrGgUpWSwaJonbJ4JP0gOUEpUB44GBvvyew53n3FDx/uVZeSH3jqETbH7WQ1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727112678; c=relaxed/simple;
	bh=DXxQj1hxlXiQFyw3DluJzXQsZoPxIxUHINDJ+HFBwc4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gadZAuonGs5/TWiXYesiv0LFPSTs3OQhz/kILdNM/npJKrIiToj2frnU/MI8k3fWJboxIId3i9BebxwYJVPRISvtrv2Q2BquTDiQmXetV7Yu4eMh4lmXsgYOSI33Bs9Mj6mSMyy/sptbr0falFR/Z3CsVrfzahB1g9S3JgY5cIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lkcamp.dev; spf=pass smtp.mailfrom=lkcamp.dev; dkim=pass (2048-bit key) header.d=lkcamp.dev header.i=@lkcamp.dev header.b=MXhb+Uhx; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=iZs8KkIb; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lkcamp.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lkcamp.dev
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=MXhb+Uhx7SjZ6t0zHy/ts/rLolT7qvjdB8LHS5E2B8sLEYrmnrgBTbJ2A1vgTVxr+cRTmQpTwpOOhIrQ0xYVABx0hgfxI1ASWhV6OczAcJf0YPy6PBUvkSkfXhNx4agxkGh5cDtskxtCrTwggIvcjuYBxIGr0PSxg2E3UTCiCehN363fQptvUduAg6gd23ZOx2rCMTpQ7l32FMuG+VmfWOZWzkO+x9gqQEn6L91KEVCHy1WiuOAFAJTees5uktpBSkhWC1kY2Wi0erwhsTU3ua5csvIbmse8mzstu2uUK1vxUIEI3ejeYIbv9R4SMNh8w0bH3cV9cSJx6ejZg8D9Nw==; s=purelymail3; d=lkcamp.dev; v=1; bh=DXxQj1hxlXiQFyw3DluJzXQsZoPxIxUHINDJ+HFBwc4=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=iZs8KkIbifaWdCcUwGEhecIVO57ruZKNS6T7lG/z6ctPRLyzQMQlvJJXYINEJIg+zbph3UMl2qQ4RwyuCyrW3y2lSsEDM8lftN0jIQpbeTSpKFMQOHsJTqn2p8Nml+c0XgT/JTHSmQTdevS31Sp+zsNN5kXAagy8mwhYsM5NEN6rdEBSb0C0J4XTW9nOtYAbOtD7rAuvy2g2H6uyG1nlIIO3oqVr6CzV4Gnh4tZkBFpT4z9/ctAzFi07w284SZKVtb2k+mbug+n5ZqRkjKEP2nJom+KfQuOPlAYa6uPZGwSz97NaGkPhyhYg2KJy7SMETSPWH33cBE/R8K+NNlYwzw==; s=purelymail3; d=purelymail.com; v=1; bh=DXxQj1hxlXiQFyw3DluJzXQsZoPxIxUHINDJ+HFBwc4=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 40598:7130:null:purelymail
X-Pm-Original-To: linux-kselftest@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -1005398190;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Mon, 23 Sep 2024 17:31:03 +0000 (UTC)
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
Subject: [PATCH 0/2] unicode: kunit: refactor selftest to kunit tests
Date: Mon, 23 Sep 2024 14:34:52 -0300
Message-ID: <20240923173454.264852-1-gbittencourt@lkcamp.dev>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail
Content-Type: text/plain; charset=UTF-8

Hey all,

We are making these changes as part of a KUnit Hackathon at LKCamp [1].

This patch sets out to refactor fs/unicode/utf8-selftest.c to KUnit tests.

The first commit is the refactoring itself from self test into KUnit, while
the second one applies the naming style conventions.

We appreciate any feedback and suggestions. :)

(Resending patch series with the right lists on cc: kselftest and
 kunit-dev).

[1] https://lkcamp.dev/about/

Co-developed-by: Pedro Orlando <porlando@lkcamp.dev>
Co-developed-by: Danilo Pereira <dpereira@lkcamp.dev>
Signed-off-by: Pedro Orlando <porlando@lkcamp.dev>
Signed-off-by: Danilo Pereira <dpereira@lkcamp.dev>
Signed-off-by: Gabriela Bittencourt <gbittencourt@lkcamp.dev>

Gabriela Bittencourt (2):
  unicode: kunit: refactor selftest to kunit tests
  unicode: kunit: change tests filename and path

 fs/unicode/Kconfig                            |   5 +-
 fs/unicode/Makefile                           |   2 +-
 fs/unicode/tests/.kunitconfig                 |   3 +
 .../{utf8-selftest.c =3D> tests/utf8_kunit.c}   | 152 ++++++++----------
 4 files changed, 76 insertions(+), 86 deletions(-)
 create mode 100644 fs/unicode/tests/.kunitconfig
 rename fs/unicode/{utf8-selftest.c =3D> tests/utf8_kunit.c} (63%)

--=20
2.46.1


