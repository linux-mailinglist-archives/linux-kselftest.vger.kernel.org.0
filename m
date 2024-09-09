Return-Path: <linux-kselftest+bounces-17481-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 032E5970F18
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Sep 2024 09:09:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6BD6CB21FBD
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Sep 2024 07:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3CA61B0129;
	Mon,  9 Sep 2024 07:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i1AbrQZL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 379261B0105;
	Mon,  9 Sep 2024 07:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725865714; cv=none; b=hh20q3nlLLZBU7N7fj95yXpJuoQ9grLGjc8fNqJhIaTrthermiXsI58akkawFMUjolLeCYlAhATHiK/MbIuKXLMpxyjtG9KjVNP5GHnqvW5r6AOGGUufb51E/IGmKwX8qDjLVz6wrmRI+OgiK6usk7dEy8KRTz9cvI2udtiZxWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725865714; c=relaxed/simple;
	bh=Cr9rtt3g2FddXoySp77nLkWLedb64WGYLUXg+hpbUTA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PJYgwnGQhxmcPyC98ThiCuKMdFvD+wkxwDS6YgNqyGDEhrGfpDVPGlpVVg1/fGX0eHgjyG0LPiRKTEIz/JJ1eGBSBYu2u04XgfMwb8zCy6S8jK7qaBcgoTl+8e81udvhYnz54MVJLGp01APcEGfXzMW3imG2c/ZyH4XTH6+fMk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i1AbrQZL; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-42cb60aff1eso7364015e9.0;
        Mon, 09 Sep 2024 00:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725865709; x=1726470509; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tns6DEsLLFvzNa6897gvKPOeII1INdIqfTx8WlLIAvw=;
        b=i1AbrQZLo0cOqKQndVvBa+PdwZCFlHV1qz51jV1oeDK4Ymx8Q10UsStexFUk8eKQfk
         4vhY1BJMCxvU7zqF4D/NPku2rTVI5LA4SaEAKnMcb6Scquk7cSiKIiwGTJkyMxGRYnGl
         rqUE40DyrhVqs7+HXYN8rTnIEw/Vo3OqTf1D4pJTVZGqrc/lS0XdVWhwaFYGeXeNg/u6
         hOphCm7h4Agz2I8n2bOJ95EpfL4IF+/ICN4T52g8ybaKStyaCOpLPCEH9SLTf5O8aeE6
         pAjcwXMR0mo7CmvWAlsFq3cvZt+9lhwKfx4zD6lWknCOp33JGTGQadZ0TSv/9O97xSK9
         4RQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725865709; x=1726470509;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tns6DEsLLFvzNa6897gvKPOeII1INdIqfTx8WlLIAvw=;
        b=DzTXlVLLCoNqQweGzpFp5P4rQbZh6sgXnPrKgAgQebsbzp58H8ZvnJ2XQlXTH3rFLl
         RwWq+0jG8sDCxkjIxDIETqBpxj/r9bodJhcdWSWaJbF7m4GyKSKGCuBEb367Mf0xB/O2
         EfP/sH240IDId6lTUJbe8IlZz2WScggRyF1zECCNOtO0uJGtdKVKrgfKu9K/gIXbP4+F
         d0CM2TFC8NhhcbBNBDisB5VT5hSPJF/6h7n6mVQ2sCv3NFBmyl5utPX9zlKcvkFmLIyH
         kxasi5YPCKP6k5b9vkQvMu5Em0qwG7pzZmpGyUskSymreTV0ZqgzNJBAkO5oGrJMW8wu
         ScLQ==
X-Forwarded-Encrypted: i=1; AJvYcCUkGQtTrQ86IUN8N9/2WiDZTqVwzCCgz/dhn9mVvu0Ji5IbTmFHL6A2Q0TmRMC0mi9w6p1bA4Z7cMJ2C0E=@vger.kernel.org, AJvYcCUxBWcI2uXmYWiAhc2Udr96mGd43ugXq/83VVCXFLofW8EQaof7gtuCGH3OnUYWAYAzOVr5vQbw/VR1FA==@vger.kernel.org, AJvYcCVhG311/oQfUsLTfpyyw6WnhCmCB+nmZMjvFq0y/QNamMywDCGfPgMIG7z4YT4TQj+VCOo=@vger.kernel.org, AJvYcCWWUTUNlOYnhutTEelpCH0mE2h2aSnuCB+1Fvy7EVFcCMqoXMw7clhIbufM5py0W2UrJXRBMMecQGA0W7kr@vger.kernel.org, AJvYcCXNtXx+0e2irPbH2IyHxzmn2xUFuajOp+SIxYeMNSlheGS9hHIB82GOZktuvFeiJ7l+wyrydXqAavYdvz0weQ==@vger.kernel.org, AJvYcCXnfpUJZ7zkAjWLX2d1NLv29Kwf6XSxHI9WY3/P2HmrAGTFUKVy6r38IiBFrk/bV5us5dVKz7bc1K69Vwfol7Zy@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7PBNU158BHa/hjzjf+a7CNvTBEQB1TSUbR3rol9zPOIOdDRct
	aVYE6veekr/PKUesvd/eYhrXLgxpcvH2M9/amhbA0QKjJieXgWtE
X-Google-Smtp-Source: AGHT+IE4gYqw+4rBd+cHrezcNoH0ZCL4/TV7eTgB/uDbDVBwGdbv1e6X9shSKYPEa98NPjsJYgGg4g==
X-Received: by 2002:adf:e544:0:b0:368:445e:91cc with SMTP id ffacd0b85a97d-378895c9deemr7165822f8f.21.1725865709459;
        Mon, 09 Sep 2024 00:08:29 -0700 (PDT)
Received: from fedora.iskraemeco.si ([193.77.86.250])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378956d375asm5178754f8f.66.2024.09.09.00.08.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 00:08:28 -0700 (PDT)
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
	Hannes Reinecke <hare@suse.de>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH v2 08/19] scsi: libfcoe: Include <linux/prandom.h> instead of <linux/random.h>
Date: Mon,  9 Sep 2024 09:05:22 +0200
Message-ID: <20240909070742.75425-9-ubizjak@gmail.com>
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


