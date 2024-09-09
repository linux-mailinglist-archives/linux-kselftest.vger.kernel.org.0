Return-Path: <linux-kselftest+bounces-17485-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 53E1A970F2F
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Sep 2024 09:10:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 138A7280C57
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Sep 2024 07:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC3BE1B14F3;
	Mon,  9 Sep 2024 07:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UXNVfz4W"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2576C1B14FD;
	Mon,  9 Sep 2024 07:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725865720; cv=none; b=dg/ALkiNQiLcIXvHBFb/uKNGGLMNYzdBVw6QWk8xJmOmoTZZA912vzlHmXIwoiwdWqlUHlcBZpiqTowJ23ZNrW0F9+xPaVAFYheXNB83lrlypg1P9S3LYrS7Hb9pBEiFLqnY4GjvEd+SQaMh86QlwzaBDrxMLozXmw3AZY478tE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725865720; c=relaxed/simple;
	bh=Ug4hwwp7UU99Plu4pnSIeaaJ0aVs+9Zn4OkL2ElDSpg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=elKZ0UNFzj+DfrrrlDrbZUmkP9rFv9oVq7FZqNZFpgk0EWRqJVphslkkUiOz7b5Foa9/Cz0XzttPpn4/6AJBfuuOPuEJbxw9g1Vqg6XWlALbjhzzpAX/60O1KggLUxS1201XEH+dVPjZOAY/KPXce3EpqYPrOltSyKQObHLcIhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UXNVfz4W; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3787f30d892so2443262f8f.0;
        Mon, 09 Sep 2024 00:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725865717; x=1726470517; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dqq6NzUB0QMlVgbuEigLtg4dQP3OsIeGqq5KqtK1ysk=;
        b=UXNVfz4WblAifUaiB3yCfiebC5EzjxZ7ZKV+Atdt8SpZMoYfc0Sacuf//fkhhJXO6e
         4Qe5u8FhT2bbAF2+4wKrO5jZKtjluTJDmTQmPKfhDhIaFOyNaMpNzY+VSSp10mWL8nsV
         zSuQzTeCUgv1VM1z9CcBwum5o8mGgeuTUxQnigszGaVWnav2SWNgG676TSFOzyIHrWVA
         Kp0Ot6wOROpj7eB9aqdzVEw+MtjqjrFnBmS8XGVPHq2/GPVMUCQxUQpPOT9iOxA8/jAv
         C/0Ve84FwPrEdLpUwNg2TDKwB40hiLXIIWDVGHmzumLF13QCs1RQhl2ccXCoTVBf+d9K
         4GTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725865717; x=1726470517;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dqq6NzUB0QMlVgbuEigLtg4dQP3OsIeGqq5KqtK1ysk=;
        b=Uf4tTB2wmGPjEtd3obEPhz3i/JHQ379ZZ9IcScJ1jOmgie7f2Xo1BZm6VgdZB8vEOP
         pRghvpDqUbHW4ouSZwU3sGr84b6UE47ROZrVMnWoSpildYBver6kvd/7wWilAEsOYLrx
         ARfvM0Ibgl6r2iyHhqfA/kTxvj0XsDdGT2D8C1SFvkMkjBlr+CPFX/19s7iEPKFyJ6y+
         w6LNxgIzsee7HzL6SfI9OG7tyY/cPQdk++QC9IZk1jyTcGlxWZ55CQ372Ep7oZ706ugQ
         sUqFDITFvdriWI3rinMd9JmWdYpkFjG3qMawtkJKgAaH0eiMr4yIrBiSDATDIRZyk1PH
         bRwA==
X-Forwarded-Encrypted: i=1; AJvYcCURnesfcS8FSWjBKZ4FcMG858Vm/Hj+Zk5btoUrJpDB6KaOl5hYvvEdS1DBTjasTicmRqP120A33wfkFP5SxA==@vger.kernel.org, AJvYcCUT3heP3vy2ZpX574w6H6hC0ghX4URiQVUwh6QUGzAA/jr0Wsk8k/LsmMwzDVW9SgnkK6o=@vger.kernel.org, AJvYcCUWdfj1jpBj02LO4Z2/CcaXpSDj4WM4YHUDnYWvUY8HZRlJv715rBx9vulX6jQF1Iw6FytpKLEZucWrqlm9@vger.kernel.org, AJvYcCVgfa7sNOM8auU1aZYG558AGsO6L38z3yNkpkNuQj8SXmySoVIDHJIoQaHFv3V50TXP01UyzoJcxLWTmg==@vger.kernel.org, AJvYcCWPz59MNQ28QztGhFItnprktWkVIT35SWsyWLSFTeWcHrsrEZFhb10nxncOp0Tt6+f3A0G1815G/a5CExc=@vger.kernel.org, AJvYcCXKZm/5IIFyDaU/zm9Uo5mnly2YNai7RsZam4MiiNaSy5Dx+iHeYpVbotfoeK0FrH5TdYilCnF3BrvW2Ct8Bx5t@vger.kernel.org
X-Gm-Message-State: AOJu0YxDcR4U7C3gsNO0LJssh9Y8u7KZDXOgm/safFBP36nfSZa+Ou+g
	gqKQOsN+ISBNlAFN7WvAz5PR2gyUJixbFXosviS2j8kgcaUlJImD
X-Google-Smtp-Source: AGHT+IGvCGyXAe+yX+BYaSRb/hI+Ilgk0idYw90HidcMT2AOiWBbY9IJ69nJCH4grLww7mZj552B4Q==
X-Received: by 2002:a05:6000:4581:b0:371:9377:975f with SMTP id ffacd0b85a97d-378895d4740mr6131926f8f.25.1725865717197;
        Mon, 09 Sep 2024 00:08:37 -0700 (PDT)
Received: from fedora.iskraemeco.si ([193.77.86.250])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378956d375asm5178754f8f.66.2024.09.09.00.08.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 00:08:36 -0700 (PDT)
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
	kunit-dev@googlegroups.com
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v2 13/19] lib/rbtree-test: Include <linux/prandom.h> instead of <linux/random.h>
Date: Mon,  9 Sep 2024 09:05:27 +0200
Message-ID: <20240909070742.75425-14-ubizjak@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240909070742.75425-1-ubizjak@gmail.com>
References: <20240909070742.75425-1-ubizjak@gmail.com>
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
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 lib/rbtree_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/rbtree_test.c b/lib/rbtree_test.c
index 41ae3c7570d3..8655a76d29a1 100644
--- a/lib/rbtree_test.c
+++ b/lib/rbtree_test.c
@@ -2,7 +2,7 @@
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/rbtree_augmented.h>
-#include <linux/random.h>
+#include <linux/prandom.h>
 #include <linux/slab.h>
 #include <asm/timex.h>
 
-- 
2.46.0


