Return-Path: <linux-kselftest+bounces-14569-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 946119435AB
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jul 2024 20:32:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4A861C20AA7
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jul 2024 18:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C67054642D;
	Wed, 31 Jul 2024 18:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="pglm4eTS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4BA133CFC;
	Wed, 31 Jul 2024 18:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722450758; cv=none; b=HPod9VXc7lezeZx7Xhqhdcnmt+kxqRLJguj97n61I45ELsNtq9hl+p3ouj0J4b/ifHNSKEl0I5R4H/1AGYOKSZRntC4saLfIMDG9wCZU2Je7JWZThEa54yF9Jy/L2yMu7Ol17gtI4J3WPNJP/oTBfB4NB8BFU/HjBYKw2nA0gGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722450758; c=relaxed/simple;
	bh=Jx1R63m4/GBsikaaf5rMEZyFIwEDFZJIJSsCyVsCjUM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=e0baOcprXG8hzZWzdNrftH1DzkOZ8gO0KUG8fb/GAUJPvkGLfjVRT+fdv3Y0rdDATV2x6BifMIwpX8V/PgByr8SD3KvptHB37AI9bijZ+FNMKNEPwEUyQRy0ut75bMS7B+wf03CdL+j98i6MLnCp3zGiitEf0p8uECEBDtkfn9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=pglm4eTS; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1722450753;
	bh=Jx1R63m4/GBsikaaf5rMEZyFIwEDFZJIJSsCyVsCjUM=;
	h=From:Subject:Date:To:Cc:From;
	b=pglm4eTSgAO+Gf3mELqwTr1QPjIZBfN/dVl2tuWLP1QxqTxgh8qOg3KuyOHJ5BGZ3
	 nDUKuc7yInIsxVNvKhR+6kVaNbHIgCIxhKKVknCDpfwKUYG3Q1n6jfxTEnGyKE85sP
	 lOfdPuE1d6/P1K8mkwzrRtNhWVzFXecwjdH35DoU=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH 0/2] tools/nolibc: add support for [v]sscanf()
Date: Wed, 31 Jul 2024 20:32:06 +0200
Message-Id: <20240731-nolibc-scanf-v1-0-f71bcc4abb9e@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIACaDqmYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDE0MT3bz8nMykZN3i5MS8NN00w5QkM0tjgxSDZDMloJaCotS0zAqwcdG
 xtbUAemBG4l4AAAA=
To: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1722450752; l=706;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=Jx1R63m4/GBsikaaf5rMEZyFIwEDFZJIJSsCyVsCjUM=;
 b=ivAWux8Jg5F7PTeF8oPRndoW4IYYDY3WIT3VTPyRVlpJ1OaxQNMEuefY6NKxECvukXyGBQzgR
 PlCKau2+SjFCyS5yoQlgrSO0Eep+G6XuyrQjcPMDrElaZr1Plv1on3L
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The implementation is limited and only supports numeric arguments.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
Thomas Weißschuh (2):
      tools/nolibc: add support for [v]sscanf()
      Revert "selftests: kselftest: Fix build failure with NOLIBC"

 tools/include/nolibc/stdio.h                 | 93 ++++++++++++++++++++++++++++
 tools/testing/selftests/kselftest.h          |  5 --
 tools/testing/selftests/nolibc/nolibc-test.c | 59 ++++++++++++++++++
 3 files changed, 152 insertions(+), 5 deletions(-)
---
base-commit: ae1f550efc11eaf1496c431d9c6e784cb49124c5
change-id: 20240414-nolibc-scanf-f1db6930d0c6

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


