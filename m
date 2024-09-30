Return-Path: <linux-kselftest+bounces-18641-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A4E5C98A346
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 14:45:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E48FB291E7
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 12:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BEC719C55B;
	Mon, 30 Sep 2024 12:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LeeJ7rVs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B21219AD97;
	Mon, 30 Sep 2024 12:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727699857; cv=none; b=EAXg7fPqCaRlTaMi/b0D3NQXUL1k7Has42TQPbTu4CpD/FlCZSycku2BbewqH22A7aKpoza8Gu1n3W8LYstuwrQ/3aE6JEnZk78B0g2WdJ/KAPoRtXCWK+8yD7n6JKa/xjXVqpycAo/DJo7bv4fH0mz61MvkxOWR/CH5/L3vAAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727699857; c=relaxed/simple;
	bh=eI30oJEkTpORKqeVvScrV8NEvv05TGBrlosAxlR+md4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T+PspZ7MqnSrv4VVKpci1QVhI9w0fJaTFMsLX/ROMAK9rNz0RsFiDLpwVehLNfgBErLItzDkJyTGrDgSrtUevgR6Zlb1VxKNk8aazC8OEbO0aBgHf1CqGs6dsLpq6/hPucdLJQKh6DEo09lLi4CCbUF+Hd2wbaEB6smKvFt9YPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LeeJ7rVs; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-42cd46f3a26so34227455e9.2;
        Mon, 30 Sep 2024 05:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727699854; x=1728304654; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4mtn3Z+z0ZXxXMNcR2ig5e/IN1sKqO9BkR2/07EQmxE=;
        b=LeeJ7rVsqa523wBOix6n7xcLb2fQtE5V1bgCf12oMqtBvwfKDYEU4SU/GSvSZLyGbJ
         YgWn7qowWBksOBe24JNVX/nGlIdKvFcPe6GCEBB8HsWjt48oG/eOqgmkHuAn0SY5bKiJ
         x9bDzGR4NYoLLUaJt3r2sDMU2puHynZvw8uwmUAElYgCRgwr9OCJYFgD5ZfJ/BIzgjyM
         lpgyFNtRG8t4cZdqYvdQtq9b5QgWKVecW53VjYFpp1GtkmSRlqnjXiLGuq7AcI/DBCc5
         b61QxCyZXJjd/ie1+7KwIytsTJEqkfmzosE8zZ9xv/rM9pxXqWNPxlxsn1J4bZMLf7lW
         zTHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727699854; x=1728304654;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4mtn3Z+z0ZXxXMNcR2ig5e/IN1sKqO9BkR2/07EQmxE=;
        b=Bv6mulvuToWzwGT88QArEs4EUOMq4u7nXv+0jASBgy5xnqlqk2Rm2YVGoqJBvKlvFF
         ILuBhYzNNE7DzPpH4pePWai+iAOV7RE3qnOcBosTMjUQKIMcig/XeUjYSjOnFZwM62B0
         t65mqy4KKPGP2Gwu7fTkf98Glly02b441zsv/2QRUGnNIxs3yElgHgRVr8ewiJVmVats
         ypbQlYTAa8gB3BzUJsuCPi6lms7BtxRQNV/IDoHiabngbnizHZjTHzo5yNp2GNR1RAxt
         5IDZFXTbipWnDUE/mx6z1l8Yf5S4SSVVl1KrucuPbVhPHgokn4/xPTSRZ0ffXUuWABfh
         Ehyw==
X-Forwarded-Encrypted: i=1; AJvYcCU3zpWk/fXtCBVvQIhsWIdOPIs1vhMIPTqaIYxKgpGwE1LvxLG8drE3F91N8s1OZFsIu3t5/lcxirpKzbhcmA==@vger.kernel.org, AJvYcCUDo1rYSC9RoAcm3Zkx72hqTURzu7qMDyYGxw/VFlFfRWwJN8biDnAk+EmqliO1J/fN6y0=@vger.kernel.org, AJvYcCUf6t3YxSzalgyWKD0J3QevNYwaC4WWcDkUAPKSeO1HhT7Sh92vDbZRbRE5FNzaeevs8mWKXIJRpnBSjfBj@vger.kernel.org, AJvYcCUxPzVWVHSW/4HbIjfUXTOfF4OUYonVMfznHyfvPW8XsWHsehTEAfydvfMZbihqIvo7bqizqc70Ah6ZK3GH@vger.kernel.org, AJvYcCWHqJUFvHazJXK0gfbj+tXOviaU5hLKDtG6XgGL3yimHBhWF7gLvG1iN+9h9a99LnR2i2MLPMDNTc6TBMU=@vger.kernel.org, AJvYcCXXPwWAbeTMpGp9xEuG2Ba7w1UdJQAxAmmjMkHj1FFw9WryXEmPMCS4j4kqpfNvEmeZzdz9PO8qOclhX31Nanks@vger.kernel.org, AJvYcCXevs08cH+5Q7yBSxB+fHV3hf5OoCND05rC8xosiGnbGRHIYGTALsajkvQ9NDQob8pFnzXjFjl0mV0Uhg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzZ3coCKyOiEilPrAQOG0IBFNeX+umTG8zkSKNJerqexfHizMim
	B5wFygR9pLjaho9LBP+CgGHNmreHy7KjcUly3X39faDr/hlP35Qr
X-Google-Smtp-Source: AGHT+IHR5GBV9Sk+AH/yXxWplf7Dccbv713xjj5lLaRHbnIJlkBTu8kMh1LwOxClCDrwdMW16rb5Wg==
X-Received: by 2002:a05:600c:4e86:b0:42c:bb75:4f86 with SMTP id 5b1f17b1804b1-42f58498ba3mr80097165e9.32.1727699853769;
        Mon, 30 Sep 2024 05:37:33 -0700 (PDT)
Received: from fedora.iskraemeco.si ([193.77.86.250])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e96a52308sm149011355e9.43.2024.09.30.05.37.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 05:37:32 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: x86@kernel.org,
	linux-crypto@vger.kernel.org,
	intel-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-media@vger.kernel.org,
	linux-mtd@lists.infradead.org,
	linux-fscrypt@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	"Theodore Ts'o" <tytso@mit.edu>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH v3 18/19] random: Do not include <linux/prandom.h> in <linux/random.h>
Date: Mon, 30 Sep 2024 14:33:29 +0200
Message-ID: <20240930123702.803617-19-ubizjak@gmail.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20240930123702.803617-1-ubizjak@gmail.com>
References: <20240930123702.803617-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Files that use prandom infrastructure are now converted to
use <linux/prandom.h> header instead of <linux/random.h>.
Remove the legacy inclusion of <linux/prandom.h> from
<linux/random.h>.

This is the "nice cleanup" part, wished in c0842fbc1b18.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Fixes: c0842fbc1b18 ("random32: move the pseudo-random 32-bit definitions to prandom.h")
Cc: "Theodore Ts'o" <tytso@mit.edu>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
---
 include/linux/random.h | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/include/linux/random.h b/include/linux/random.h
index b0a940af4fff..333cecfca93f 100644
--- a/include/linux/random.h
+++ b/include/linux/random.h
@@ -145,13 +145,6 @@ declare_get_random_var_wait(u64, u32)
 declare_get_random_var_wait(long, unsigned long)
 #undef declare_get_random_var
 
-/*
- * This is designed to be standalone for just prandom
- * users, but for now we include it from <linux/random.h>
- * for legacy reasons.
- */
-#include <linux/prandom.h>
-
 #ifdef CONFIG_SMP
 int random_prepare_cpu(unsigned int cpu);
 int random_online_cpu(unsigned int cpu);
-- 
2.46.2


