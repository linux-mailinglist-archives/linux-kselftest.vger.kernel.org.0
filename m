Return-Path: <linux-kselftest+bounces-39847-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C6A1B344EE
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Aug 2025 17:02:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D9F116EF6B
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Aug 2025 15:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10C50302CA0;
	Mon, 25 Aug 2025 14:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="ksrIa0C8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CAE02FD7D8
	for <linux-kselftest@vger.kernel.org>; Mon, 25 Aug 2025 14:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756133903; cv=none; b=pUsY2mTrAfkDqoPspWnUOlADMQLwCiJjD1Q85CUn81QoeSKvOpzVvdUJw7pDOE6k5fOM/oXbwjGX31aaNji2GmzlkgjlxCL4iMltRRFX39HLbeJ19t9ftQ0SWPJWMegF5uqW/KjYo+to7LcwJ/LihA6hPoJ/pcDkhwXOu1Pf7T0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756133903; c=relaxed/simple;
	bh=xY16xtdVzGEfaeQq9IN656McbF+sKB7TIBPK2joy6Bc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oupeMwTiWHpHEa/M+v8VK354uWxXeJOgooEczOIDUlokU1PChrYOjvTZNmR7fZZkOIp1eRP0vCBXR2qu1WCbLEwC6FhtR+Kqckh6F38lxo9Ti719MA1pAUBo9/wAeqYsTTO1ce3ZA5TTpO3y6AUbBAvvehV3O323CtV6KumqVFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=ksrIa0C8; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-771e987b4e6so632753b3a.2
        for <linux-kselftest@vger.kernel.org>; Mon, 25 Aug 2025 07:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1756133900; x=1756738700; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S4tDabwrjUnjyF2pNuKY+D/uJFltgF7p2tl2gzeMXdU=;
        b=ksrIa0C8v0hctbG3df/jQc89E2ReqpsM+1mXmJWzgeRKFBFrxQ/TgKUa/LKlZCIuMC
         1lFWvIGyr+A0kFq5P2neS4kNK8hD4253cGMD+bZVuTY6YauNRlc4daEE5U7gxBfA/W5L
         gXJdFUhm37xPgdgACx9/QIGxdv6Gwp06ZAYdu2dvdPLIxe+gmd/7HqT3UefsGqAzruO7
         fyWEV+1qF+BRkNAEEj8Ihf0WZl6fho+D0k1LNntj2p7lga0DcW0omuHn9bFf1nd/dKMr
         vHypC82F+348AGyfkwyFGt7nZXCAnMbLKiTx28C6U+7Oo9Bmk8wG8ASp9Cev+PYb/t4E
         9JJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756133900; x=1756738700;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S4tDabwrjUnjyF2pNuKY+D/uJFltgF7p2tl2gzeMXdU=;
        b=Z1nl+rm/nRvfLeMW8lOGfU0C2Mk9kfKR6pJ1GFRArZ4uMsWzORQxYzFdt2DRhWgVGY
         UdBmplOoxFqO8wGUNFAhXp8jgmSdVksiN1hiOYlEN8V5Qghw441tsfH5GtlNNxSrZXz4
         gXt3uLjSIj2B6rlTBlTWYCg+k971jIPsKtSIJ9NgeDdA0qfWVex/TveBxtuEmg6Hh/Wg
         AZHyb4hNRmsca2hQGBLCQi+Yz0c5cAyDJgkntmQoX9xTMo/kNUTj5AhDaTkzISoWD5UR
         wQ1zVWBJ+xGfn2f9RV9ejXXYvbYwNvR8hwaiBNkehk8xJJU43juavLUywyackkKfQoHy
         OSKg==
X-Forwarded-Encrypted: i=1; AJvYcCWcjxsPX0ag6EeJluaFQpmBkwMG5tvuVrEUf6CmhmLrHgfGVmzquYJrFTo5zUWMtLYrTwFiExQ6k2YpYxEEITk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKf35oVWvnI/cR6kpnGscAwnuEtgTJCmbE1tbPIYKsoo3LP1n4
	Fn4QFvi504hlFpB6jjq5/zE65cWzA/WDXnwYyEZewF44q2b1Lfjl7Rw7JVcPjzylbCY=
X-Gm-Gg: ASbGncugNceR5JBtcDG0SSIaHs2kZDBkQACEPkVyCNAN9iA6ky7P9nxDD64c9tqIItD
	lD/sz2PqvunfuLoSZlYIAvncduIEQrgFU3VXtckepCah6/vlwJiBieSV1mC63S5GjrYn4e7qndM
	HPFjFVkffQcBynwhVfXp6roaTElpIFKoVV+yGQmDNlKkuY7g0ixt+hLtkTgrUPtbwd3/5l9eyLp
	aJ1iGJEEkMga0Ta1zVmy374k0f8S8hMl8SaA9z//nvpCqj0CQDFGr2Y04OHWMo1lu83pa5s6rww
	TuYxKZwDSVeaO7Z2GxXBQtauKOyQMi3ICN3miCrmikPAcw6/xhfvjkH8XPiIeHeFd2IfoJGm2Za
	O1ifB+PQRV2X4GViOUSOdxWkPdPBQN5ThmQdcmo4VoQrTU/3bdyvOIIL0qJl1
X-Google-Smtp-Source: AGHT+IE4HBpFp2FjPR/VhGO77A7Hf4iGpyorA58tgjMrbJX3zjiUolWr1Fp2pgViqY8L4woXW+eoFw==
X-Received: by 2002:a05:6a20:7345:b0:240:195a:8333 with SMTP id adf61e73a8af0-24340bff9bfmr20854855637.14.1756133899572;
        Mon, 25 Aug 2025 07:58:19 -0700 (PDT)
Received: from H3DJ4YJ04F.bytedance.net ([203.208.189.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-770401b190asm7803436b3a.74.2025.08.25.07.58.16
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 25 Aug 2025 07:58:19 -0700 (PDT)
From: Yongting Lin <linyongting@bytedance.com>
To: anthony.yznaga@oracle.com,
	khalid@kernel.org,
	shuah@kernel.org,
	linyongting@bytedance.com
Cc: linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	akpm@linux-foundation.org,
	linux-mm@kvack.org
Subject: [PATCH 5/8] mshare: selftests: Add test case ioctl unmap
Date: Mon, 25 Aug 2025 22:57:16 +0800
Message-Id: <20250825145719.29455-14-linyongting@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250825145719.29455-1-linyongting@bytedance.com>
References: <20250825145719.29455-1-linyongting@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This test case aims to verify whether the process with guest mm will
segfault when VMA of host mm is unmaped via ioctl(MSHAREFS_UNMAP).

Signed-off-by: Yongting Lin <linyongting@bytedance.com>
---
 tools/testing/selftests/mshare/basic.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/tools/testing/selftests/mshare/basic.c b/tools/testing/selftests/mshare/basic.c
index 2347d30adfee..16d1f63c3ebe 100644
--- a/tools/testing/selftests/mshare/basic.c
+++ b/tools/testing/selftests/mshare/basic.c
@@ -85,4 +85,24 @@ TEST_F(basic, shared_mem)
 	ASSERT_EQ(memcmp(addr, STRING, sizeof(STRING)), 0);
 }
 
+TEST_F_SIGNAL(basic, ioctl_unmap, SIGSEGV)
+{
+	char *addr;
+	int fd;
+
+	fd = open(self->filename, O_RDWR, 0600);
+	addr = mmap(NULL, self->allocate_size, PROT_READ | PROT_WRITE,
+			MAP_SHARED, fd, 0);
+	ASSERT_NE(addr, MAP_FAILED);
+	addr[0] = 'M';
+
+	/* munmap vma for host mm */
+	mshare_ioctl_munmap(fd, self->allocate_size);
+	/*
+	 * Will generate SIGSEGV signal as ioctl has already cleaned
+	 * shared page table
+	 */
+	addr[0] = 'D';
+}
+
 TEST_HARNESS_MAIN
-- 
2.20.1


