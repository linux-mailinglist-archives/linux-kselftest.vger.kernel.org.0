Return-Path: <linux-kselftest+bounces-47595-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 898EECC1BD0
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Dec 2025 10:22:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DC783303A0A0
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Dec 2025 09:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79C6D30CDB3;
	Tue, 16 Dec 2025 09:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="VIvtucJH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE3C3093BC;
	Tue, 16 Dec 2025 09:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765876584; cv=none; b=J8SOnoWawVFfgJ4CG6X/ovYADxOhUaI8YBUK2GqeU2e5Vyp+RlruAp7krinBQRhimauN38ZFjivaCd/n6M/Jc4TWpssAdpDs0pWH2EtbtesStgaj5LAUGg7msBhVeYlSYYeaonSOIW9tu1DbmCgeVgXTDoGs/qbCfwpv73GyxIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765876584; c=relaxed/simple;
	bh=hE6yKZM5VFUU9g5Ut7vj8ciu3CM9YnXgymPPny04Ff8=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=ASgIzxXh5h8EtXn5XrfqYHk1kJhumMZJ9sx/tUtpcNB94nuCJoyDkzeRH/o0Xyomsla6MFmo9qOB73C8t2Lg1wA3Jz++q01FtdyJOC3+spvlkcTlIgzBS21rzeEr5M/UcuZ6pkBmI0XgfWWDl2zSpkh3pV8w7jIZJpcquNqt9Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=VIvtucJH; arc=none smtp.client-ip=162.62.57.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1765876569;
	bh=Gbc9bPnrfRPoaB2OYtkgeu+e8NHYthlmb9JGZ43dfM4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VIvtucJHcBsxu4vqvUG+7b5F+acsNHz0w8IxzxhHTXIOub+jbkk2fREyTfe8X9i5I
	 HtM3GA2MHpzlJ6efpd7oQ/DwU75cVXtyUWrznjUsL4bbdCQQfHXvI6IGwvDGNsN5VR
	 EDovvXCrzqHoGm/CV+8qS/wkpJQgQ/ZUdsmJAsXo=
Received: from meizu-Precision-3660-casey.meizu.com ([14.21.33.152])
	by newxmesmtplogicsvrsza53-0.qq.com (NewEsmtp) with SMTP
	id 3FA2C669; Tue, 16 Dec 2025 17:15:58 +0800
X-QQ-mid: xmsmtpt1765876558tva5lblfr
Message-ID: <tencent_920541146CD237CFA8AF04A9F09DF4D4A907@qq.com>
X-QQ-XMAILINFO: MqG4KXyEKpQyVBcIPT9lZXmwY9ecNJW60MCq8VlPRGwmk//cmFs/bCuup94ZOY
	 GnXbBbt3oOO3wuHG/LaTlx9O8f8v0Vym2tX+HlJwUPpwRN796mjDM+WhIbAQrmIxmco83T9cMFKr
	 CpocAnDfY4z500DZyK3CWyMySxW7gkamlzbRPiogC/qInHrh2UQWNKYnWJf98hZ/qDB6BFTfnqot
	 Sm1GhzJnu1YpC/2Dq9nOM3vFBozXliu807o3FDhtfbWb4ueCXdGEswqAQFQmWwbsEUOzDxSoCE5r
	 5mqcdf/rVeAP75ulsRPcqaTHwKok+zkJqnOejA6CHfexLo8nDcd2gpoIp7mV/jr2af4ofvW3CvRF
	 JTZKt7dn/385LuX88XWHtZH1wEzTDWD6I3ry6v1Sp1EcPrKcBbrEkN9RkzaGwx5Aftt4R2oE87kh
	 Y0QzONO5IcFu+2232uvRd/7ve2HY5gBCYTOlMb+RZpcBX5dNncPxSxSwTT31YwAcUJ2wKP1SSKO9
	 Dk0XJZef3Be2f5R8zIFag77h173YbMjD123gLARLrRteLTihWgzxDGAnUihIqCecM2NxozMYHrQr
	 VWIYcQDrQKB5G1LfMUhQs6IRuSDfkCBJ+l8io6A2RI+GKECWj7d9Zdh4kHxsN6wsgcHBxDDGH9TC
	 i/D3uOYJJXSgrYsGHVXnHG6AOUUOgYdFDmkcZP4ffP9drpRSipUXNn22HHx1VcJHBmj1fT9XSjLT
	 Peh3gT6eGT8AG8owSY/SAEByjb2Ff2sHsqJ7nd7I6ikUEvWKs4csD+rJNu4ifaAWWWVGeKDoeekl
	 VaAIzP1RNGk7KAQ8b2EKqRYNwzoar3A3Wah8/LymLxhSKac3JVpvpUTaGyiratYihhLmRmbGVkfw
	 MM2UVDK5jNJ/niqrbEFwBWt8r2/JyiqWaDie2mrl8dl6CJHtULTHBg1ykqmMXJ9dAWST7Qg+5ZCo
	 eU82WGfRGiapwIlb2xyKPvo9DZsxAwvfbhIqx83SBx5iW1cY7YsyQtQ/b95T85GJHJBw5miLDPHq
	 UxItxkaHhG24hp6VwTCa0DPvtz/g6jc31AlFZuTowD7OuylO5GuNUlGBqeUDDronTbCYaxbMkaOo
	 +swF2a+yyUU7dK79ja9IixfUxvZxfuj3rJLnzN83xnwhTbrcl5U0D/VAbfvg==
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
From: Licay <licayy@foxmail.com>
To: ywen.chen@foxmail.com,
	akpm@linux-foundation.org
Cc: andrealmeid@igalia.com,
	bigeasy@linutronix.de,
	colin.i.king@gmail.com,
	dave@stgolabs.net,
	dvhart@infradead.org,
	justinstitt@google.com,
	kernel-team@android.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	luto@mit.edu,
	mingo@redhat.com,
	morbo@google.com,
	nathan@kernel.org,
	ndesaulniers@google.com,
	peterz@infradead.org,
	shuah@kernel.org,
	tglx@linutronix.de,
	usama.anjum@collabora.com,
	Licay <licayy@foxmail.com>
Subject: [PATCH v2 3/5] selftests/futex: read atomic variable value with atomic_read
Date: Tue, 16 Dec 2025 17:14:05 +0800
X-OQ-MSGID: <20251216091405.421289-1-licayy@foxmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <tencent_7DA95D2C454DDCF1E381AE2EE7F7793A5F08@qq.com>
References: <tencent_7DA95D2C454DDCF1E381AE2EE7F7793A5F08@qq.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Directly reading the internal value of atomic_t externally does
> not meet the encapsulation requirements. A new function
> atomic_read is added to obtain the value of an atomic variable.
>
> Signed-off-by: Yuwen Chen <ywen.chen@foxmail.com>
> ---
>  .../selftests/futex/functional/futex_requeue_pi.c    | 12 ++++++------
>  .../functional/futex_requeue_pi_signal_restart.c     |  4 ++--
>  tools/testing/selftests/futex/include/atomic.h       | 12 ++++++++++++
>  3 files changed, 20 insertions(+), 8 deletions(-)
Reviewed-by: Licay <licayy@foxmail.com>


