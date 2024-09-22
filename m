Return-Path: <linux-kselftest+bounces-18201-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C21097E437
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Sep 2024 01:27:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10D621F21261
	for <lists+linux-kselftest@lfdr.de>; Sun, 22 Sep 2024 23:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2195880611;
	Sun, 22 Sep 2024 23:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lkcamp.dev header.i=@lkcamp.dev header.b="h/WJXJZR";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="vWpyJ0i4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D6B7F7C3
	for <linux-kselftest@vger.kernel.org>; Sun, 22 Sep 2024 23:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727047631; cv=none; b=ii5+kYYIUEtYvohOLSXdV5KVKydj6v49pCt5JJZ/0w4YXQq7FoxRllxkKuhODyuVpVaJr4CNVsBGaBEMfpfXou8Cb0VH23ma1/IVoaAgcTX1aPh+hPpG/W+4Kpjrxn6Mtgz7LxaLZuLrhUVUVQ3dKTSxcXnzxk1k4dTuMUqAdMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727047631; c=relaxed/simple;
	bh=9YL4wAd4v+E4FK1bs4+yob1Kh/6TWXfN7JoWPVrcA58=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iUGVammlNBwszC49qjW1I8y7tb7ZsXSaZOCO7NU/UESoCI05nI7qus2FRLcVEAq0PWsCR2ITVVBWdVbBjxuDpjXIMNFJq5x8yNZqHF6m1Jx+hDfxhCs/wace0X5Rb2nRlyhhDPpHz2ZmVnNIKEPiqmUOnxDp6NSgMjt3NWZE4Hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lkcamp.dev; spf=pass smtp.mailfrom=lkcamp.dev; dkim=pass (2048-bit key) header.d=lkcamp.dev header.i=@lkcamp.dev header.b=h/WJXJZR; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=vWpyJ0i4; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lkcamp.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lkcamp.dev
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=h/WJXJZRi4V8mTZyPC4ljRfMJMzd0yLj10ITGPw02M3O9hyOPlBP0k34iDuntDYHZdeTmKfYHCM1z9YJBJ1+IUmmwd3Qz3BXQivnQgxC4tGEPofgp3G3QVe2osqW2zQkR3qebrpugIBUPRJD5MCArE86QCzvF7iRigP2I04vuGD5pl1X6fYnrjobcic/JJ/+YoJTC68il/svn2TF4DEgevmlicPPtPxGn/o5OtNoogNeZzshnj1BcnveKoZ3BhBR11tA4Q4aRDFp1XeJj3pV7pQ3NNKlcYbGP9MD9G3qVfaYeYW6B0FYq256CmsHGqmS/qHdde8xgHHdTIo39dEZ5w==; s=purelymail3; d=lkcamp.dev; v=1; bh=9YL4wAd4v+E4FK1bs4+yob1Kh/6TWXfN7JoWPVrcA58=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=vWpyJ0i45wcQEWFFjkwUSooNU3Bs32QvAT4/+pswbw/7psc9V3jQoXvZ3OTmhbl439O1Eh27Br/3DoPuXxOItqSlDg+L9n7Yq666clSXJCFve7K8dp3gnvC7yPMUYbX3ehlOf646ol0WpRYYbKO3dJhWIu7BcxJ2TEdmomPANygKU4VZeskOjuYPGXHwajQy2rw2c8knv/BP3wgQk8mO9f5jCmNFA46AjspNs9HbllOj/EbctcG/ISHfXyxp0pyx4ZRP5vsQo711XVrgPiV6UrTcBq+0GJEPCkbTtSWK8WXH/fTO08cl4jUuib5Gav2jpG6jQYGeTMsR14/A6nz4BA==; s=purelymail3; d=purelymail.com; v=1; bh=9YL4wAd4v+E4FK1bs4+yob1Kh/6TWXfN7JoWPVrcA58=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 40580:7130:null:purelymail
X-Pm-Original-To: linux-kselftest@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 163052307;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Sun, 22 Sep 2024 23:26:51 +0000 (UTC)
From: Vinicius Peixoto <vpeixoto@lkcamp.dev>
To: Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>,
	Rae Moar <rmoar@google.com>,
	linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	~lkcamp/patches@lists.sr.ht
Cc: Vinicius Peixoto <vpeixoto@lkcamp.dev>
Subject: [PATCH 0/1] Add KUnit tests for lib/crc16.c
Date: Sun, 22 Sep 2024 20:26:39 -0300
Message-ID: <20240922232643.535329-1-vpeixoto@lkcamp.dev>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail
Content-Type: text/plain; charset=UTF-8

Hi all,

This patch was developed during a hackathon organized by LKCAMP [1],
with the objective of writing KUnit tests, both to introduce people to
the kernel development process and to learn about different subsystems
(with the positive side effect of improving the kernel test coverage, of
course).

We noticed there were tests for CRC32 in lib/crc32test.c and thought it
would be nice to have something similar for CRC16, since it seems to be
widely used in network drivers (as well as in some ext4 code).

Although this patch turned out quite big, most of the LOCs come from
tables containing randomly-generated test data that we use to validate
the kernel's implementation of CRC-16.

We would really appreciate any feedback/suggestions on how to improve
this. Thanks! :-)

Vinicius Peixoto (1):
  lib/crc16_kunit.c: add KUnit tests for crc16

 lib/Kconfig.debug |   8 +
 lib/Makefile      |   1 +
 lib/crc16_kunit.c | 715 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 724 insertions(+)
 create mode 100644 lib/crc16_kunit.c

--=20
2.43.0


