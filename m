Return-Path: <linux-kselftest+bounces-39839-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0C2AB344C9
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Aug 2025 16:58:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C829D176645
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Aug 2025 14:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AC3E2FC87E;
	Mon, 25 Aug 2025 14:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="HEgdlVMq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E432FDC53
	for <linux-kselftest@vger.kernel.org>; Mon, 25 Aug 2025 14:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756133871; cv=none; b=WAsJz3qlveJcmnMy2Wv4DkK6/XKnetjsh+lfSYBtzR8g81kfRrRJtG20oW3vSNZnnvO34KCT8oG2aDmHmMlTc/HNGoDfj2aQNoHWXuOWwyQX2LRKKAiOxrd2TpakSFbQE/54Z6VS48O3LXWYE2AOgPWI9JpX/AHJ7nwnKxQouTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756133871; c=relaxed/simple;
	bh=xY16xtdVzGEfaeQq9IN656McbF+sKB7TIBPK2joy6Bc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LVdnyD5hPtEltzR4Im1yFGI8b52i3UIvx1u5lvw47rsGILgfOT1iiCXrIs3RumOBJpO/9rS/n2oxLoTpDZbETs71lV8s8OyeTyLILHcvRi7tYM09u+SSEDQk5TwOhWiYPvFty08zowiH6bQTDnjlWPtLPsdH9NKa2EiYsQeeQbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=HEgdlVMq; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7718408baf7so1330765b3a.3
        for <linux-kselftest@vger.kernel.org>; Mon, 25 Aug 2025 07:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1756133869; x=1756738669; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S4tDabwrjUnjyF2pNuKY+D/uJFltgF7p2tl2gzeMXdU=;
        b=HEgdlVMqfcNzg4t4NKdp0OlF4jZ1GAzoEPjWfmG9Rvf+D3pIqfViiHhdzsH1mtENtm
         h4u9U3wR8XAYu43ObhQXaKjSveEE33r0HnQarA37yWFBDiA825aQ6o1KXzKBoRIfGiKM
         U/VVO7LUzKfxjS1+XgQfvkHKMCgSA9qDT++ZsHB88UlgODcvmrPj29T491X8ZshTHOzC
         rRUq2c9BJmVvWjDB9EWZXTfCHz4T9bz1mVNxGYBD2H0rr3jUekKlIhcGc+7xf/hQYlcg
         3ZuRQNNm5sPgOcGsAAoMbhX7fcGPnrZXLWfNZ5n5mJcG2jFVGdETbh6fcTKsN50lRrFv
         g5mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756133869; x=1756738669;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S4tDabwrjUnjyF2pNuKY+D/uJFltgF7p2tl2gzeMXdU=;
        b=wBemEQr9UXcvzwFol5JQJLRMbslnmqillwy8J3EXbQSe3lW+5kWPd8hh8F/gXgT3Iv
         qepwRJF35bNGn+TNyK28ToHYCmQutJjIDOsoS9l+Gzp7MQrb6AxzZMLsWn+fiIcfRb4d
         gMS4S+OVz+MR7qZ60d5/FP542sdCXf2N1fng8Lvka6dxccWIlQLWSLQugGwKR7MTBjIc
         Hvu0QXoxUAPErBbv4Qo2GWYX/mu6Dz8+vOyElhHIhUcWz05uQjKzqBz2L2sKCCK8POVI
         JDZyGuw2LAsDT+BRZq3JLO0ZezKv/VzkXEFt6P0c2vYL648PBW34phVOxb3vwbczBZjK
         R5mw==
X-Forwarded-Encrypted: i=1; AJvYcCUgyuJRIAVDPEC3mF34eBp1/G6YbvZQhF7z/cRLWlINjKMeJHK5qgq1IOUvXAn0Xz67SC4FIyLX+wMIfuD2X3I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHoItIUZ1heQ+Z1cDMorqd/5XPENTklj04SObcLN6qJdOlbpwh
	8NKpUPfg2qsWWFdg2sm/q+/DXIrRAT//IweMJQgNQdlxiMR/oWoKAS9I2vPosMdJuNc=
X-Gm-Gg: ASbGnctiO0WFKdRWjrYs4sCWR/DB6k6M7u89Bs5/LI1mX1MxFBbyn1rLzDKpJ0E4Elh
	Y9EHJq3KyW3IxUXGFYuaGWlJH3k52K4NYhGYxdle/2AnJ4U6KcKEjgh3UaWIiOkIK7oUd7k1tnS
	2241Bka2ekDE9nbrNNOfDkygr3uudTZkpd827Mzc9SXKqJGA+nWT+Q4qb3JzAHNN2eNkosibsVS
	PDzgewqNd99CfOJp2oBslsLJE8tF6tq/iC5b/oEuMDEoZXl9luBS0iHwMMd6YttrD8EVBUvFE5T
	A2yrb4AdB9S6znhQzZgwziwnfqxSk/pLoyyIQqtLypM/5zd0kwqG3LhQLeRdi2VXARYx16uTy/d
	lwB3OSwZch9+e8K3tg/rqdev4jM4Abdb46/PMd1yDzQ/zIg0xC7DHWb1pUYLo
X-Google-Smtp-Source: AGHT+IFQ75GZYr3N6HMX7zPn0dw0ZuYOLQe7vaWeVSJK+4VjzmhYfxDpWVGeXxn9RSIeBs/bIzorqg==
X-Received: by 2002:a05:6a00:248f:b0:770:34f9:49d2 with SMTP id d2e1a72fcca58-77034f94ca1mr11670084b3a.1.1756133868947;
        Mon, 25 Aug 2025 07:57:48 -0700 (PDT)
Received: from H3DJ4YJ04F.bytedance.net ([203.208.189.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-770401b190asm7803436b3a.74.2025.08.25.07.57.45
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 25 Aug 2025 07:57:48 -0700 (PDT)
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
Date: Mon, 25 Aug 2025 22:57:08 +0800
Message-Id: <20250825145719.29455-6-linyongting@bytedance.com>
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


