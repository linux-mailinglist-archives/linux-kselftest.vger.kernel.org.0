Return-Path: <linux-kselftest+bounces-40540-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27265B3FA3B
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 11:24:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07C35168603
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 09:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAAE12E1EFD;
	Tue,  2 Sep 2025 09:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="Q5BTvG0A"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out203-205-221-202.mail.qq.com (out203-205-221-202.mail.qq.com [203.205.221.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE7663D987;
	Tue,  2 Sep 2025 09:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756805050; cv=none; b=czyg8caX7weW0HYD/srftTTEhv4hN0a3GhX0suUZcD2vjZJ/q/4Z0LY3ypd++HSvOe8JNRtyatkC5u53Lvb4XFtfUQUFfh3j/Dw0NU80KX/WCuzGe7ydHewmomAxOUpBufeIQEIyqgFTcBNR3HiHlDoRWWw+ZbszDgA5f1B5/EU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756805050; c=relaxed/simple;
	bh=pPTR2DPjWLZI78Um/TK9fffQxLMetALz3OjN/SJclL8=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=mlK5LRNUlIS5Tg+S91xgvnM+5otgW08LIkWUQACsrar1qQMByB2dpk2HIa+BdwjN2QIMwrKqIfMKxT0vlaRFUh6Cn6BrlCmA72sHUo2Xrien/Rv5vPrm3Q7BxR6rgMlLCZ2BMiU66AhQ0uMSZkhwtkWUXvjhRd6kQiW0b+M8WjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=Q5BTvG0A; arc=none smtp.client-ip=203.205.221.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1756804739;
	bh=EpAarfKxM9Xf2n5id5G25GoKghSsP58gEeX99TV+bR4=;
	h=From:To:Cc:Subject:Date;
	b=Q5BTvG0AHk+LlRDP/VDDrPzYzeGvTV/OcbJL1FvpxBSXtLTRggnP3gCJPzeEITBt2
	 Hcqt7ZO5FRzYTUBDjvz2d5/KZzy+HS3g9+EkProBoxvFXOpE1p14QfaAD75gIJe+Iz
	 C3gZ+lzbBUIa/aGvKU40pDlFuQoVXn/JH+OohwuU=
Received: from NUC10 ([39.156.73.10])
	by newxmesmtplogicsvrsza56-0.qq.com (NewEsmtp) with SMTP
	id 4B722280; Tue, 02 Sep 2025 17:18:55 +0800
X-QQ-mid: xmsmtpt1756804735tlq9vma9p
Message-ID: <tencent_E3598F975B2A13AFC3A3E08837062E42A908@qq.com>
X-QQ-XMAILINFO: NMGzQWUSIfvTYId8edV+Tl6aZmURxcRHFXImvr8PRps3rdF3p9vcMWW80VYG5G
	 D81vFsFzsDVjC1LTGHQXYV4SH5riK/L5cfIoTJ+rDitDc2jqcIeSC+CwcTdNU3W0O6t2mO0BxSFQ
	 +irP8PtmoVN3xZngDZBHO10e2fZGCEdU6tI54g4irRcRKLguaRGE8ROp6dbVcKoVibtOmc8NVYDR
	 NIlx9S9riUWX8FXS3vjtfdums/y0tEj3oX62FcH4rA4FUaVTMmCGDfQ+Ez4QGhn9OJIGd4OhesJt
	 n8F5WCtgGf3L0LdmN9C1V+3kWEhXqIN8Hk6vc5wOLbcq+FT9LLsOiks35hDd8Ppu//6TWDAoRUH3
	 MKR9WZwjm+laioU/WWi0MfpD85QYQrR+rEf6c6eNxK4oWbly+vv+DF7h2CldLoot6xW/ghAUlPEX
	 1YxAkf90xlWxsk1gytTOAY/cnvF0zfbBhC7HWVyWaRi4NZhWqfsv0xvykpJ31S71I/C/n2hMolib
	 yPh94okuoYaM1BUiMudTKhuNCPUX8wdoqlX2T0MJR38/Bl9rT6StgD3NYmpH+EaSYbhaAwfYWGY8
	 tatgGSe+5sB2FscRADUd83uIJkL8ry8ckjgcnTMZdCcWel0BLfOvYIV/7MLraPMfLgKZJlcVGjKx
	 BBHkVqYmrj7OQUNFBJ+SCHTWys2tlRZA2GFKUo9t4+QgkQRhdo0/B1Og2KPaCpga1s/LGVW80zd0
	 gXSysHNqJZq5HlVlSWZhlggX6p9fbnr/0+ZIdhI8wwm43KpjV2SwvStSbwAhBiWXORLe/kRabCZI
	 m1c2cibIz9ixfoMVJqsYn5BCc2S4OLvKpva9Izi7bWzIaES3WmqKpDFNY7RjQdnos/7K0uBHVEw8
	 tOrLR2j41cSqvMoQHQM+OEVpyWQQAnjXBgQq6S2dClyA310HypC4UEMK8/EjpuOFUZXBqDvffv9m
	 uVNSjBNrfELbzk1Rpgzme+SFBkwHgfKDqLbc6va0JJCmn5PHnwBVBSAGe5NDHTo3fkgcjKHcbZ5R
	 O/1UNBP82EJMn0hVNOzI85LwhuV8/64FF/ttNUwgULGsrOhoatAWHLnJIGJvTXPzgyggDAUQ==
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
From: Rong Tao <rtoax@foxmail.com>
To: andrii@kernel.org,
	ast@kernel.org,
	vmalik@redhat.com
Cc: rtoax@foxmail.com,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>,
	Shuah Khan <shuah@kernel.org>,
	Rong Tao <rongtao@cestc.cn>,
	bpf@vger.kernel.org (open list:BPF [GENERAL] (Safe Dynamic Programs and Tools)),
	linux-kernel@vger.kernel.org (open list),
	linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK)
Subject: [PATCH bpf-next v3 0/2] bpf: Add kfunc bpf_strcasecmp()
Date: Tue,  2 Sep 2025 17:18:25 +0800
X-OQ-MSGID: <cover.1756804522.git.rtoax@foxmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Kfunc already support bpf_strcmp, this patchset introduce bpf_strcasecmp
and add some selftests.

Rong Tao (2):
  bpf: add bpf_strcasecmp kfunc
  selftests/bpf: Test kfunc bpf_strcasecmp

 kernel/bpf/helpers.c                          | 68 +++++++++++++------
 .../selftests/bpf/prog_tests/string_kfuncs.c  |  1 +
 .../bpf/progs/string_kfuncs_failure1.c        |  6 ++
 .../bpf/progs/string_kfuncs_failure2.c        |  1 +
 .../bpf/progs/string_kfuncs_success.c         |  5 ++
 5 files changed, 61 insertions(+), 20 deletions(-)

---
v3: Update prog_tests/string_kfuncs.c for "strcasecmp";
v2: Remove __ign prefix from __bpf_strcasecmp and add E2BIG failure test;
    https://lore.kernel.org/lkml/tencent_8646158457D4511C447C833B21B3ACF6CB07@qq.com/
v1: https://lore.kernel.org/lkml/tencent_5AE811A28781BE106AD6CDE59F4ADD2BFA06@qq.com/
-- 
2.51.0


