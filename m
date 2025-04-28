Return-Path: <linux-kselftest+bounces-31753-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D79BFA9E84F
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Apr 2025 08:33:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F02F917A66D
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Apr 2025 06:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F6471D63EF;
	Mon, 28 Apr 2025 06:33:18 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F9611C5D46;
	Mon, 28 Apr 2025 06:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745821998; cv=none; b=oXcdlAcr57uELFO15IU+9ekjlj3nzRj4Sf0f01rXpDSygxvEUNFPCe1kk7M5Ug66xKNwobLVeK9g9BXiNAitFsDxp6v+IlIX/OgtFptcwYxfMLaINaethqrK4Cr45L82cpINkm3O68zdUAE3uoh5c+8GkYANgBkv3BPRuFx9BZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745821998; c=relaxed/simple;
	bh=o3qXcMq9W9bqc0A6DllhRLlFvOzRBCr9VypF08Ya9TY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LarnGItOHoOPmUIWeIOHcZBb34lasommpVLg+TUdz13RlLqGJpJR3dxDG2bYLViHLpTu/sQ/95te3cGqAuW+gTP5BQqEFrocC1Lgq4l8VjrZaXroNkeqPjOUvRu/kY9nKvtz0SBWDanaxux88u2CDBvgBnLEP4PgyutUzHDCLds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8Bx63EfIQ9ojSDIAA--.3857S3;
	Mon, 28 Apr 2025 14:33:03 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowMAxDcUdIQ9oTM6aAA--.59312S2;
	Mon, 28 Apr 2025 14:33:02 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Christian Brauner <brauner@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] Fix compile-time and run-time issues for pid_namespace
Date: Mon, 28 Apr 2025 14:32:58 +0800
Message-ID: <20250428063300.7137-1-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMAxDcUdIQ9oTM6aAA--.59312S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29K
	BjDU0xBIdaVrnRJUUUk0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26c
	xKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vE
	j48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxV
	AFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E
	14v26F4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI
	0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280
	aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxAIw28Icx
	kI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2Iq
	xVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42
	IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY
	6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aV
	CY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU25EfUUUUU

Tiezhu Yang (2):
  selftests: pid_namespace: Include sys/mount.h
  selftests: pid_namespace: Skip tests if not root

 tools/testing/selftests/pid_namespace/pid_max.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

-- 
2.42.0


