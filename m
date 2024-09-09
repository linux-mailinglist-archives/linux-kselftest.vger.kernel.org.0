Return-Path: <linux-kselftest+bounces-17494-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77193971078
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Sep 2024 09:57:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A34171C220EA
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Sep 2024 07:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E28D1B1439;
	Mon,  9 Sep 2024 07:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TnD7VLbh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0CC31AF4DB;
	Mon,  9 Sep 2024 07:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725868612; cv=none; b=mhlzLn1U550Lo6b0V0XF2z6HcoG1qEXVRyyHal2Gb64mSL7fz4I4tLlraX7tz446POSE64XPafsvyYEoWV2+Wsjs0cgv9MidUVn2r2Fn6DTrPLPuXVdyghBOt9aXdrXMvDrOp1XyoAfdx2LXTwE6Sq49u83sb2cyzmry8D6Y9sM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725868612; c=relaxed/simple;
	bh=vg8RVh1QVSzklqVo21bOPOyAtUZ4RZO6cEL+S2fGkkU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WBqESGhkRjYPNc3EZOPUdX+R2d+iYTabOHaohWwlz+l6PQt44ejzlT9/qIaxR1zGvNybtPmk+ahtFNdKO9J4oL3O6RPqEJ1UVU+3rPoP+aUNT9a3su4XfH6R5KfWlqTyy1EckTmQW2yiAiPH0QZsgt0Pi6Qdwl1f2fo/uZyMwRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TnD7VLbh; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-42cb9a0c300so3045185e9.0;
        Mon, 09 Sep 2024 00:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725868609; x=1726473409; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8B7BVoErPcOoKPxSdUBz41r3SRVlI1m5+I4zzu3vMfI=;
        b=TnD7VLbhYuP5pcF5b+32D19m8QLqfw6oz62PDj0X+hr1QWdQ4wCebclf0TsCDx1uUv
         Qb4HrQy4kCChPXMxNLBJmc/75Xgm1DbjpoEH7e364OPS5MYowqscbcwDvxz+kYz6/5F7
         x4VFJySm8ukcQkdWDiedlMplaUl6HLdnt9tuITA3EH7YmmAyKu0depcNIq+sY+lgK4FQ
         kr8bwdB7mufzbA3V60JmoRa6G2YXDGNjTxbNCKPex82TrBRCXvrgfJjLOqmvmCwx/uTR
         QtN70GYgJWAnGV2bkRASZVvIJOsbnBFlRGAdg8PIPq6jvjsI0POONzWNO9G6YgVMJzum
         rzKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725868609; x=1726473409;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8B7BVoErPcOoKPxSdUBz41r3SRVlI1m5+I4zzu3vMfI=;
        b=IvVj4u673eNCT5a3xgOX9Bv8lFfjkpSO6RccijdfwJsFxvz56FBoa7ybc5KjhEncaY
         xV5PxeN7mJNKew/Z18gpaIQqhJbVA+W/NcThR0jXAiR9Ve8FzjWOnIG3pWewkwslFtGh
         X2dtBlpKb+DT1yAYjJaosjma9L8qT30WabDm5RYG8usIvsD4tq4B0uG0dqtKLoNWNQvp
         nNa3Q9ugYXhKSWBMKPrTTq0eMwipGNbSv869pCg/ZKlMSzj3EJ4Cec+mtQEocJfC1Qdk
         /NNgJJVNCi6O4aPAkm3QzQ4ZQNZOm9uC3aK7A51fjVeDQg+f/Zn62S+KD9HSfh8lRFTf
         VcqA==
X-Forwarded-Encrypted: i=1; AJvYcCU+my+P6kje6jzb5d0nFfVJf81BqgQo+MsXBPzCC3XRRAQxrfXld7tJwaDLiAjJr1CdI3FRqZ5pM0g17XQw@vger.kernel.org, AJvYcCUo9J+VFUEPTuS7l5LAFshK2uhJTK6jtPInb3Rr+OaPZF4qi1K+U4PGRzCHM5wA88zvoJZ1Qcngk7M9Bg==@vger.kernel.org, AJvYcCV0HY71MLRqlnKN94oJ4uTlLSVGbtD6a/Fe1Fokz1eXeec3hG1CI+ER85jJB9GuPoTco2zqmyDGGO2dt7M=@vger.kernel.org, AJvYcCVZ1kAez4QuB5yLe5UW/u0afjL1i3M4xiZA8CP+TvQvvwR1NST6+6mfNrY9CX4SZrRmeASMRSKQQmlFhzfUOg==@vger.kernel.org, AJvYcCWG5YJlHm0IKHRTQwQmBIrypV097ZddByBxzvl/Xjqu3xF0Xj/w2tpINXWI7OYRQ2JtO2c=@vger.kernel.org, AJvYcCXt2mYFKqxlDQMSc8DGEL6Dr7+aoeJg2b1k10GEfnRXQRhU7oMZPTB2VrRBOp7X+gKBDWqq61+NNkVpy38d@vger.kernel.org, AJvYcCXz+oRNiz6HBNZwMQHcEdMP7kFWUN2uKDmKKVck3rHYUQTrZEhsRhGmlTFHBlq4PNPplqYdknKa9+6vaRVQtPBW@vger.kernel.org
X-Gm-Message-State: AOJu0YwpwfDcBRAgd0vS3WabuJjs93Q5sbk0XX9AZ3SQS8kHNMPlRpOk
	72wnnm1C+jMpmAzumGYzdBmJIJfrXLk1d7Uw4fcUkPnCK9TqWwa1
X-Google-Smtp-Source: AGHT+IHWkhCod/cUhSnjyZKEZLy/v5Es+DtTGTGYiOp483T8sPZJXqNXcFpaXCFZinKhbm5C7GjmvA==
X-Received: by 2002:a05:600c:3b20:b0:42c:b8c9:16cb with SMTP id 5b1f17b1804b1-42cb8c91953mr12858525e9.5.1725868608863;
        Mon, 09 Sep 2024 00:56:48 -0700 (PDT)
Received: from fedora.iskraemeco.si ([193.77.86.250])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37895675b7esm5303001f8f.50.2024.09.09.00.56.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 00:56:47 -0700 (PDT)
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
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH RESEND v2 01/19] x86/kaslr: Include <linux/prandom.h> instead of <linux/random.h>
Date: Mon,  9 Sep 2024 09:53:44 +0200
Message-ID: <20240909075641.258968-2-ubizjak@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240909075641.258968-1-ubizjak@gmail.com>
References: <20240909075641.258968-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Substitute the inclusion of <linux/random.h> header with
<linux/prandom.h> to allow the removal of legacy inclusion
of <linux/prandom.h> from <linux/random.h>.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
---
 arch/x86/mm/kaslr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/mm/kaslr.c b/arch/x86/mm/kaslr.c
index 230f1dee4f09..e17e6e27b7ec 100644
--- a/arch/x86/mm/kaslr.c
+++ b/arch/x86/mm/kaslr.c
@@ -22,7 +22,7 @@
 
 #include <linux/kernel.h>
 #include <linux/init.h>
-#include <linux/random.h>
+#include <linux/prandom.h>
 #include <linux/memblock.h>
 #include <linux/pgtable.h>
 
-- 
2.46.0


