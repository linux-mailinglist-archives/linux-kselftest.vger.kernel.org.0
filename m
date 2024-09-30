Return-Path: <linux-kselftest+bounces-18631-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 33DC698A301
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 14:41:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D04C4B274F5
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 12:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62B31192D79;
	Mon, 30 Sep 2024 12:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i0i5XIC8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3758319259B;
	Mon, 30 Sep 2024 12:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727699843; cv=none; b=ZRjBreARMz+cASBlcKhMvbPrIJgBEs+XcWj/uccOqVEMmRFkL2HlqsqXVtzCXkbTpavUzFiir5mox2PHyvL3zUeWqe32mTuPqKYbJRjKlqj3udUXZGAqdkB6dn9o/9e56qtcCvW6xv/1pi9RQyfX/ontwKtH+zM9Wiv6ThSQ4Mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727699843; c=relaxed/simple;
	bh=Nz2QTY8uc5isjjc5sA50/WTGcjDu3jyH6xL5GcUjeWE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PeTqHso1jpDWmwcRd7MYQxTkkXVczzw41qKE133XqZ73HzK5ypU2hgjcSZFQao9k9Bv8Gm++XlnmD3FBxE2mUt9CFdgsov0fg4ooPch8gpVTem78bWufusC1ejmBAo9aBEK8R71voa+r3+z3cZ2z7MSIE0Pq7+Aw213c9HMgD04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i0i5XIC8; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-42cb806623eso33174265e9.2;
        Mon, 30 Sep 2024 05:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727699839; x=1728304639; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tn+GOzQztHgHcIfRc1gU/LmX7CJxu4Do9s+iY4ufzHw=;
        b=i0i5XIC8QIiAXwMAOns1WWNmcVvnWXmUiSuNTlLNO+SjJMIo3kPxsTquah6Qagk6DO
         chKQQDfQLSWbjcW0rBDe2T7Ec7Cjo0i4licYJ2l9R6lhW5HIj5K4e9OzJQK2M5rTYM3y
         UT3mj1lSw7fziVgBXO76zEr2ZHP4gAtVFYNwRPzNY8Xh2BOA9GfY3BMcAIJAhvxx3XaW
         04BTJFSotc3/as/GMlQCr0PWrGUzHUcNWw4Ya01jcIjEG5LiRAwUdZfyIrQdv0ilwvaF
         3f1ZI2ITCgyF5gjD+nvVB/lOptJFJjm6PvZtii0qI4rD2FrBXOWKfUDH6Y3J6G1XDMrx
         gVkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727699839; x=1728304639;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tn+GOzQztHgHcIfRc1gU/LmX7CJxu4Do9s+iY4ufzHw=;
        b=rfR5Iwi+f8CDppLVyx8Cjm/VK8uj+NdZwRb/Px+dRgfsUxUO0CxpaSduBTPIxoGouc
         sGBbbICqXgjLMKAJSTzMn2livB177pSyz6vzIgiGEmG+UvSvPjT8r7GmmIrhuvplaKzp
         ysiGaD5YLFpRqxoLTwpiL9JzBTHYtFerVa/xFzt/uo8D72FBNYEbYITCc5k8arYBOn4y
         hL8LiCYtZwfucxp/RO0dru/A6F6V1Mu3WaqvtaU5KOqPhy2u67HOhcawrRWqHnH+PMFW
         vvyOBaG9P0YupzXqP7sU4jxW7dtD0o4BIupSNPE3AD19W7Vj/y3r1x50D1Ex0tHgBcmY
         z6cw==
X-Forwarded-Encrypted: i=1; AJvYcCVYOnAK8p3FR9j0p4rMAEaAdLYFappQE4wzqXY2SoG926mnAE7u5GCI99WCyRuqhkK9Wlm/jKMGzFk4QFw=@vger.kernel.org, AJvYcCW8sR2a3G715wrXLOx3jJvqjh/hWDrUwf4wQjwoTb/KnMtyR1NFYQbw6i1R2cVFgB3CMVg=@vger.kernel.org, AJvYcCWDcW5fJocMx5vEPvUvl1R5NHDJ88kC0kqr+NU25cEB4TVB/nm+WGXS6w59quGMG+DubFoHulNvrHGIdvERjg==@vger.kernel.org, AJvYcCWKRIWN0hA73dTZcz0W9khWRVIzDcWUd7L5yVZ2p7OPz6bpytgYV0Q12nMqwP2ztVFTPBM/d+Kh+k52AH2uGDmF@vger.kernel.org, AJvYcCWSJQBt3Dodq7jOC55RaVhXhbTgRJ/pV+s8SH2Kk4xET6t10eReOJKjaRA8DmK3zrxtRC76fYsR2ZRjNCp1@vger.kernel.org, AJvYcCXiF5HmavKj2LBUxUX6kmew9v0SV1aMsISwK0/7pWG+U4zMAKe0IOfPKGnURq62uEwvCekVtHPDbXXTTg==@vger.kernel.org, AJvYcCXzRI0Z4qza96vQO0ooL5vnlp3Far3auvdoRyhdZLXiocjNYuN1gCHL/JnSUfEcrrbIW1ugBFKugUocyceS@vger.kernel.org
X-Gm-Message-State: AOJu0Yxf7s0DiAyh64sZzYIUxXHJt4Gls9dd9abmz+WI5jhZsIgIDnMS
	+nLnxQaXkaIAuWzkS35AZlBQWnnmUEvuIukmaBrOIxACI1wdCoee
X-Google-Smtp-Source: AGHT+IGvq6NRT6JufQmn6LdLh9JuzzheTPsAQprqBquWz6qQ+pBzTt6Ksdb4rtzF4i0KxoWpmKQ3VA==
X-Received: by 2002:a05:600c:1c26:b0:42c:b950:680a with SMTP id 5b1f17b1804b1-42f5843a723mr78695175e9.20.1727699839348;
        Mon, 30 Sep 2024 05:37:19 -0700 (PDT)
Received: from fedora.iskraemeco.si ([193.77.86.250])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e96a52308sm149011355e9.43.2024.09.30.05.37.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 05:37:18 -0700 (PDT)
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
	Bart Van Assche <bvanassche@acm.org>,
	Hannes Reinecke <hare@suse.de>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH v3 08/19] scsi: libfcoe: Include <linux/prandom.h> instead of <linux/random.h>
Date: Mon, 30 Sep 2024 14:33:19 +0200
Message-ID: <20240930123702.803617-9-ubizjak@gmail.com>
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

Substitute the inclusion of <linux/random.h> header with
<linux/prandom.h> to allow the removal of legacy inclusion
of <linux/prandom.h> from <linux/random.h>.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Cc: Hannes Reinecke <hare@suse.de>
Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
---
 include/scsi/libfcoe.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/scsi/libfcoe.h b/include/scsi/libfcoe.h
index 3c5899290aed..6616348e59b9 100644
--- a/include/scsi/libfcoe.h
+++ b/include/scsi/libfcoe.h
@@ -15,7 +15,7 @@
 #include <linux/skbuff.h>
 #include <linux/workqueue.h>
 #include <linux/local_lock.h>
-#include <linux/random.h>
+#include <linux/prandom.h>
 #include <scsi/fc/fc_fcoe.h>
 #include <scsi/libfc.h>
 #include <scsi/fcoe_sysfs.h>
-- 
2.46.2


