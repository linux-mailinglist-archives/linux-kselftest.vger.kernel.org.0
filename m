Return-Path: <linux-kselftest+bounces-18536-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FF6F98920D
	for <lists+linux-kselftest@lfdr.de>; Sun, 29 Sep 2024 02:00:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E8CA1C20F4A
	for <lists+linux-kselftest@lfdr.de>; Sun, 29 Sep 2024 00:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 420CF188591;
	Sat, 28 Sep 2024 23:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lkcamp.dev header.i=@lkcamp.dev header.b="ZwFqGiBw";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="P5fAhA7G"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C0AE146A69
	for <linux-kselftest@vger.kernel.org>; Sat, 28 Sep 2024 23:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727567998; cv=none; b=eMbVoGWN0FMwDkVTubp4QVsYHj1i9v6iR2YG0h8h1nzff1azXE+TWBlvYJ/fH8M735yGKF7HcFaM+f20ylOV9l2oyFl+pwyYmVXOW/e1KooTdfAhFDKAHbwQQzb358Ye6qwRuSWcJ/FsgijRoMw/TS4j/OH1MaOY/AokZAoOxp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727567998; c=relaxed/simple;
	bh=bCmg4cHcYwrdNuYIol7Lkn8j0eN4jWb29bm4oleYH3Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Eunwk2kq8PbZSrC1MW9AkMEMpkCpyElHvJRv5OC1ny39gsF6M0RtYqUVtfNjTE28baiSIfUktjIJV/sueBd6aw77/UX81Zsf4HVuqHaoh/L6bAzm74Rr/ccxBtuIM0CT9P7tPmw/6t95Rl+bJog7V79EVbpjq9TxtqY2opmFwrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lkcamp.dev; spf=pass smtp.mailfrom=lkcamp.dev; dkim=pass (2048-bit key) header.d=lkcamp.dev header.i=@lkcamp.dev header.b=ZwFqGiBw; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=P5fAhA7G; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lkcamp.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lkcamp.dev
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=ZwFqGiBwKitlZdl6dHnV+qjD45D97odR+3lRtoZICwTMvpLhnocm/fQ9wq9u2jFICkJGXVuWNFiJVusik2mBmpKVi6yL5DXVLDia9HAfYF68EudLUSD82T87xl1UYBWE3FO/NKHZ18iHEXppPHp4uxEikBrbqtOtqlxGZSt7l0JeIKHV3SVu4VYEr2fN7YToQhCIAW/wNqEttW91TBlYNqbO9Nx4nrjB5SKMPUSqe/CVgri/RYxVLIzJefBjYW9ZrvQ1OR4EQK5npz6BgwcXHAqo4LpjMmx2khzAHVuMEFWcr8hXom5MqHmJDp9N1IsVePd95bwaskJRHoKdLY3WmA==; s=purelymail1; d=lkcamp.dev; v=1; bh=bCmg4cHcYwrdNuYIol7Lkn8j0eN4jWb29bm4oleYH3Y=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=P5fAhA7G9DD2UoOnoSSL/3MogMwN9LwTyWISvfy7hFue03dXFkcqUeMP+xuIXqJATDHcEBPM+xTGHX8Qnbp8EbSbY13gib+vBRkT330lLNjzKuS2TayHbpQ53FIEFcUca29mhdp03tDN8ZghSQT2u1qRr39K78S4DKX+YdQzPSK/C0sqCKflib5CXlikQ6VaUEFh0N7/a2ymPjWFw+bksTYyUPuqy1OSZc2UPsyX9FOumgxiZGBrl9esSU4WjfHdE6bsH0ERPiZD1I70zqDLJSlbevOfqhppFqEv2+2Y3VQYwYEn/DoBWcGanAdpn8xvfMuoB+V4WG4mfygleMNjvA==; s=purelymail1; d=purelymail.com; v=1; bh=bCmg4cHcYwrdNuYIol7Lkn8j0eN4jWb29bm4oleYH3Y=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 48571:7130:null:purelymail
X-Pm-Original-To: linux-kselftest@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 1507990812;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Sat, 28 Sep 2024 23:59:39 +0000 (UTC)
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
Subject: [PATCH v2 0/2] unicode: kunit: refactor selftest to kunit tests
Date: Sat, 28 Sep 2024 20:58:24 -0300
Message-Id: <20240928235825.96961-1-porlando@lkcamp.dev>
X-Mailer: git-send-email 2.34.1
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

The main benefit of this change is that we can leverage KUnit's
test suite for quickly compiling and testing the functions in utf8,
instead of compiling the kernel and loading the previous utf8-selftest
module, as well as adopting a pattern across all kernel tests.

The first commit is the refactoring itself from self test into KUnit,
which kept the original test logic intact -- maintaining the purpose
of the original tests -- with the added benefit of including these
tests into the KUnit test suite.

The second commit applies the naming style and file path conventions
defined on Documentation/dev-tools/kunit/style.rst

We appreciate any feedback and suggestions. :)

[1] https://lkcamp.dev/about/

Co-developed-by: Pedro Orlando <porlando@lkcamp.dev>
Signed-off-by: Pedro Orlando <porlando@lkcamp.dev>
Co-developed-by: Danilo Pereira <dpereira@lkcamp.dev>
Signed-off-by: Danilo Pereira <dpereira@lkcamp.dev>
Signed-off-by: Gabriela Bittencourt <gbittencourt@lkcamp.dev>

Gabriela Bittencourt (2):
  unicode: kunit: refactor selftest to kunit tests
  unicode: kunit: change tests filename and path

 fs/unicode/Kconfig                            |   5 +-
 fs/unicode/Makefile                           |   2 +-
 fs/unicode/tests/.kunitconfig                 |   3 +
 .../{utf8-selftest.c =3D> tests/utf8_kunit.c}   | 149 ++++++++----------
 4 files changed, 76 insertions(+), 83 deletions(-)
 create mode 100644 fs/unicode/tests/.kunitconfig
 rename fs/unicode/{utf8-selftest.c =3D> tests/utf8_kunit.c} (64%)

--=20
2.34.1


