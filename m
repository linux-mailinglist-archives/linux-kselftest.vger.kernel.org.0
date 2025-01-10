Return-Path: <linux-kselftest+bounces-24211-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C6174A09169
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Jan 2025 14:06:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97DB7188AE42
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Jan 2025 13:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D47B920DD47;
	Fri, 10 Jan 2025 13:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="y6R/VRrv";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zIwLeQlH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4533A20C024;
	Fri, 10 Jan 2025 13:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736514378; cv=none; b=L7PVOG4ao1ezC1ztq5fvWi+1vCS1lTuKAAQ7Zvx1xmUBTfc6EvlVzvQZxIPejBu4/z+Gg3XDJNqmvSFe1MPqfhokJjPprId+LITSpJdEamFlzVD6UtzjLknHPpfYyjSqVsDFnGx4H3gm5ohaZ6HenKPpOyUm+F4uC2J/CuuqmoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736514378; c=relaxed/simple;
	bh=Sm0PwuQVte7XgbVjXyiHOsXJPFjpuw/9FI9ZkNuRORk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Lnz0svQQw/LpW6PSNB5VGZlW8sdSsmsLqjn60mGP+97pGEH4k6KSKnH24758OVbRRjQB4r92Ref44rdRs2RBf+xd994Vl1EmF1WJFVUP7bGeBAwhfLNBmHlIsY/U+zo6DvxPwCXeBYYPKl2qNQT/1Ua0IUX6AD+K9y/TJdgYlpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=y6R/VRrv; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zIwLeQlH; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1736514374;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=hr6uhuBMBGWM5gCFEu7lA3MvYpepc6DeWCXpBbX8k8U=;
	b=y6R/VRrvBuUbBCwqYt1vy+AblejtqeTeIATftwuhB05oxyehbDT5Nu8zcuLU1bN7aRkxUg
	HtQw8v1Y+5jbRGJCMq0I0U4q3Gsm72IR61aVqtvYvYldl0G27V6OJ4kzN054WpewbOEUZ3
	FW9FR3kXgEfUkj1BiNQb+VRR/zBdhqH5AWG+0C9QEvSrRgiTSxK1qjvoEeQlVPjE2e1rpX
	J/vN91ULKrQGt1Fpsrm2ioc+hlF13d2qDlaR0xzpHxDSv9HmVyuxF2TYhr/IHO6VJVK23m
	1iZ6uizCOKFYTgagImTW1MNHShGPC3w6SUyFOLZ+2548a8zhHBQ9GEZdK6x+4w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1736514374;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=hr6uhuBMBGWM5gCFEu7lA3MvYpepc6DeWCXpBbX8k8U=;
	b=zIwLeQlHVlCdEsUilfgbRnxBL2G3jpoalSJDa4O4dHHh9JPJCmy+1NNbyTHZTlo14wDYMn
	ZYtxLh0Om0uaIBBA==
Subject: [PATCH v2 0/3] selftests/mm: virtual_address_range: Reduce memory
 usage and avoid VVAR access
Date: Fri, 10 Jan 2025 14:05:49 +0100
Message-Id: <20250110-virtual_address_range-tests-v2-0-262a2bf3c3d0@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAC0bgWcC/42NWwqDMBBFtyL5bkqMj9h+dR9FJG0mdUBimYnBI
 u69qSvo5zlczt0EAyGwuBabIEjIOIcM+lSI52jDCyS6zEIr3ahSGZmQ4mKnwTpHwDzQMYrAkeW
 l6erKtK23FyNy4U3gcT3q9z7ziBxn+hxnqfzZ/7qplEpWXVVb7R+18XCbMCyR5oDr2YHo933/A
 uHfB5TKAAAA
X-Change-ID: 20250107-virtual_address_range-tests-95843766fa97
To: Andrew Morton <akpm@linux-foundation.org>, 
 Shuah Khan <shuah@kernel.org>, Dev Jain <dev.jain@arm.com>, 
 Thomas Gleixner <tglx@linutronix.de>, David Hildenbrand <david@redhat.com>
Cc: linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
 kernel test robot <oliver.sang@intel.com>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1736514373; l=1221;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=Sm0PwuQVte7XgbVjXyiHOsXJPFjpuw/9FI9ZkNuRORk=;
 b=0MGnfl/mOOpYHNMAN/TGe0wEWb8OEbo+Wd8yCQEVr/8tilq6PHxZS2/XtQpyjXGH7/HZDzQFu
 T3UYHV4OGPwBtVBoPAkfXpidwHxsPuiEwQ+lcsBOcBJup31Xju9PBPt
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

The selftest started failing since commit e93d2521b27f
("x86/vdso: Split virtual clock pages into dedicated mapping")
was merged. While debugging I stumbled upon some memory usage
optimizations.

With these test now runs on a VM with only 60MiB of memory.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
Changes in v2:
- Drop /dev/null usage
- Avoid overcommit restrictions by dropping PROT_WRITE
- Avoid high memory usage due to PTEs
- Link to v1: https://lore.kernel.org/r/20250107-virtual_address_range-tests-v1-0-3834a2fb47fe@linutronix.de

---
Thomas Weißschuh (3):
      selftests/mm: virtual_address_range: mmap() without PROT_WRITE
      selftests/mm: virtual_address_range: Unmap chunks after validation
      selftests/mm: virtual_address_range: Avoid reading VVAR mappings

 tools/testing/selftests/mm/config                  |  1 +
 tools/testing/selftests/mm/virtual_address_range.c | 34 +++++++++++++++++++---
 2 files changed, 31 insertions(+), 4 deletions(-)
---
base-commit: 32af4d2269d20fe2f8d32aaa456cad8e40abd365
change-id: 20250107-virtual_address_range-tests-95843766fa97

Best regards,
-- 
Thomas Weißschuh <thomas.weissschuh@linutronix.de>


