Return-Path: <linux-kselftest+bounces-23718-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F4929FA111
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Dec 2024 15:46:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C36971890883
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Dec 2024 14:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A96991FA8D4;
	Sat, 21 Dec 2024 14:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="st0i8CzQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B448F1F239D;
	Sat, 21 Dec 2024 14:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734792276; cv=none; b=Ls/6XFi7zzPAxWkOiObDGp3oHsJnsESulbC/x25L4CWrGfolpa0dq0SMpGdQGVpXl9juIU1c51OQ0I2/07KJq+a/ansVlRWSZKl0as808a6LJ9+W10afQbh3lxXfBUhc8FFvcLgXTZZYXNmgmijRSsdsaHrhjB+Ml26c3OecmqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734792276; c=relaxed/simple;
	bh=8sEohOXFcgWEpRoGJM9TirpXvqQhi1CABSHHAxol18U=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=BeDqLODm/B/s0YTOL/kQhMV+AGQ4lcKbpk/KE64SmwCiEQgmf+sdzaIJx00HHR7wZFldA1OZSRkiZsRxpZlOLw5lm2Z8qtBXvllX0pqKdVzfaiTj2ujCb5mmvSpsAJvv5kjyFLR5jnfmSUPEW3EMeYdERKnfMTX2CKuWPBgmL7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=st0i8CzQ; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1734792272;
	bh=8sEohOXFcgWEpRoGJM9TirpXvqQhi1CABSHHAxol18U=;
	h=From:Subject:Date:To:Cc:From;
	b=st0i8CzQElWUfNAztv59168LO+QexAAWVLoEFuAORTprvyKW/JxjN1lfKrEgqyODO
	 G9YmkBAQN/AzbrZpnWGhp3EHXtmMhqhTzneIkULwuKr1hnFbvbeQYmEY0kRNKI6dba
	 RPyvvmKNOKJbs0RUnUj6OiaSBgUD0GZqHpctFjdM=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH 0/6] selftests/nolibc: wire up riscv32
Date: Sat, 21 Dec 2024 15:44:27 +0100
Message-Id: <20241221-nolibc-rv32-v1-0-d9ef6dab7c63@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAEvUZmcC/x3MQQqAIBBA0avIrBNydJFdJVqUjTUQGgoSiHdPW
 r7F/xUyJaYMs6iQqHDmGDrUIMBdWzhJ8tENOKJRqKwM8ebdyVQ0Suf9tGlC1NZAL55Ent//tqy
 tfSxJNm1dAAAA
X-Change-ID: 20241219-nolibc-rv32-cff8a3e22394
To: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-riscv@lists.infradead.org, Zhangjin Wu <falcon@tinylab.org>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734792271; l=1009;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=8sEohOXFcgWEpRoGJM9TirpXvqQhi1CABSHHAxol18U=;
 b=74mc5mwJR9/bsqPQMEmWFdGt6ROOaaFrQQ6Ams9v3xE+uI1rX5t5F1eQwzlb3rKt5dMrkw7i9
 I4H+2gV/jkeDfKEWPfY+SCU64GiUfK/XMF34pW2QP1Q/d1xTpvtKgZv
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Nolibc has support for riscv32. But the testsuite did not allow to test
it so far. Add a test configuration.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
Thomas Weißschuh (6):
      tools/nolibc: add support for waitid()
      selftests/nolibc: use waitid() over waitpid()
      selftests/nolibc: use a pipe to in vfprintf tests
      selftests/nolibc: skip tests for unimplemented syscalls
      selftests/nolibc: rename riscv to riscv64
      selftests/nolibc: add configurations for riscv32

 tools/include/nolibc/sys.h                   | 18 ++++++++++++
 tools/testing/selftests/nolibc/Makefile      | 11 +++++++
 tools/testing/selftests/nolibc/nolibc-test.c | 44 ++++++++++++++++------------
 tools/testing/selftests/nolibc/run-tests.sh  |  2 +-
 4 files changed, 56 insertions(+), 19 deletions(-)
---
base-commit: 499551201b5f4fd3c0618a3e95e3d0d15ea18f31
change-id: 20241219-nolibc-rv32-cff8a3e22394

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


