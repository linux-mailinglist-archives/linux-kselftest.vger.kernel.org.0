Return-Path: <linux-kselftest+bounces-17501-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51BF89710B4
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Sep 2024 09:59:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C54ABB22535
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Sep 2024 07:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D151D1B3F12;
	Mon,  9 Sep 2024 07:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WnaXDpCr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F88D1B3B09;
	Mon,  9 Sep 2024 07:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725868622; cv=none; b=cN9vcO43VrAq/aT86KiZqaa6hW9yNa6S6NUjp1HRx0/MJ5BEasSkHM198j+8POU/cYKEQ9SH7psCUzWa00tuJGlFTo+hZgcNRKGduZiDotSjhVobXhyT80qxDgMRx52ZSdfTsjs+EH2sHARjlEl0A9VscsvwePsQaOIAJ89FPGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725868622; c=relaxed/simple;
	bh=Cr9rtt3g2FddXoySp77nLkWLedb64WGYLUXg+hpbUTA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dFCUEXeNk3BfGKdsyq+M10cdhfcYRC3CeTwT0j/pN9taHrv15oqHnV85JTDHVU+wfYT6YxnfRfgiUZtlUQElsc/rV7gWDJp9i5WnC4IDfXLGqHySMV5gSi8+tISqnpYu4hB6D/Rx4sTcEdUwwPKYc4qItoNsXnE4+kYuto39V70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WnaXDpCr; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-371ba7e46easo2647881f8f.0;
        Mon, 09 Sep 2024 00:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725868619; x=1726473419; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tns6DEsLLFvzNa6897gvKPOeII1INdIqfTx8WlLIAvw=;
        b=WnaXDpCrIgd4sEqPqcTFzk5lJiOEH6aQ7nc4LbI8lDXIgR7dtiS711tQSFNh3G8ex2
         mfz53P+j14NkNiyPsiEigdSxlEZI7LxboIFxobOtwONFRAMFmkBEgXqE28dZUgsWLDJv
         U82+iO6DGZEylaxKvDAGBnsshNTR5OutOxdbXJErncdYES0ehwVcg1j8MXlnoNg3chV+
         huwRBZKoZ/B6iAIbXqTo+v8btjGYqnmHq5i0jJEBlzFqw66RD4/1Lc+6fwtzo0mK7HSr
         4i6FRWY7SjyXLXwrwU1qvaND78QyvpcZ8bKZy1L0GTrRw3wy0MSvZQPoB3SE6rn1xdPW
         gqIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725868619; x=1726473419;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tns6DEsLLFvzNa6897gvKPOeII1INdIqfTx8WlLIAvw=;
        b=vdbnqni8N+MiIpJLzA7W/IJjEUeVsBvNZ9LwrgbCaTmuDDK7SN6OjDFojvafL8E5IR
         0/17OQMkafOjUReGBM4gpNNC8ZWrwTqqRK733211ZUwAKMkG+rCvXwOvlKEitr445BD8
         HKkyaFH19RzYiK/U/Xzn7d8ODHJqnGdi7DmEq9m1SEvhRl8/ai79myngTTdH3QBhT4h/
         BzFCKc67flU3axcCMWhAbZzcozs6gektJZWdZ4ZiHkBkCp5vhwwD1eHRNMcdaNIcCQCU
         g67/TG/RUj7txcnEtbppoM+S825pVr+ct+u9dDPdo445cf1R0ifydsh0rtEAKH7wcLod
         od/A==
X-Forwarded-Encrypted: i=1; AJvYcCU1rM16JMuKSv3ctC3boPjarbikN2d4T7Cal/DyKOx5NKeyDD3Me/bdi7FhTA81nPrPy13s8jMq0ZUFVBiK@vger.kernel.org, AJvYcCUMsyzM/tGI1ebBNStNpeoXHQdO84Vqn07QSSCplJZgndoYnioKxc6s2BNScfdqNN+1P8wtqRfoYLAnEA==@vger.kernel.org, AJvYcCUtwRCUw9WPOCnOy6ki0Row+xFn36sdXez4944j2uI1UJxqw+JOv8GEleXJTSDePFWeTb81S8vsmlZaxhmKrOj5@vger.kernel.org, AJvYcCVPuCSdum8ep+waBrmMibW+gJivMLHmqCQ8OZahfZXs8yefw/E3XV/qdUoNOvx8wt4TOy+AuWvx/guoeWo=@vger.kernel.org, AJvYcCWbrmVjSAPznsg0q4+pnxnsaXXmdmgVpgGaR1NTMxGhixBjr7CrY7KAfbIVEOiRJsARe2w=@vger.kernel.org, AJvYcCXLPe1pFJy2WNDsmQ2Dg1kNDIuz2+FrzWEsiAf+Eec/EYhrjf7yvRHqw0ZyjKYs3NjiRmJUZ0jmLZaFRn61pg==@vger.kernel.org, AJvYcCXyFzu7qOxlRR/h388XoHB6DY775LJuR3lvVTPBJIl2I9NuXZ48HfsKPNZTN5yoRO5P2yon6acncbppwx/M@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1oEzLs3qbST4LsvbrqVUPNzE0gm0JjiwCALLAkaRdVYBJbUWS
	0zKGJ+UOaeVoZrgtghtF4Bo373Dh7V24hfsM8YYEZuGsbWHwMVsY
X-Google-Smtp-Source: AGHT+IFhnqv0adc/jPasshP9DFOYVF7kRZj6iEAk20wgpizKEHq4SVzWSg8dz/tDp3cddgfDjkxL9w==
X-Received: by 2002:adf:cd0d:0:b0:371:93eb:78a4 with SMTP id ffacd0b85a97d-378895c5b22mr6825835f8f.9.1725868619298;
        Mon, 09 Sep 2024 00:56:59 -0700 (PDT)
Received: from fedora.iskraemeco.si ([193.77.86.250])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37895675b7esm5303001f8f.50.2024.09.09.00.56.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 00:56:58 -0700 (PDT)
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
	Hannes Reinecke <hare@suse.de>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH RESEND v2 08/19] scsi: libfcoe: Include <linux/prandom.h> instead of <linux/random.h>
Date: Mon,  9 Sep 2024 09:53:51 +0200
Message-ID: <20240909075641.258968-9-ubizjak@gmail.com>
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
2.46.0


