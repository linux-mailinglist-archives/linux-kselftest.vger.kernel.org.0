Return-Path: <linux-kselftest+bounces-25324-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63954A20EC5
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Jan 2025 17:39:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2703318848E4
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Jan 2025 16:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 810641DE3B1;
	Tue, 28 Jan 2025 16:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZOJeXyw8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F901DE3A9
	for <linux-kselftest@vger.kernel.org>; Tue, 28 Jan 2025 16:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738082369; cv=none; b=GMtPE0F3GrC5vLzVF1Uv/lZLFdXIQEX2MZW1PsD2vyw6b8wUoiQRYWPEartmd5KdTub/cf8l8ue1aO55aQB1MVOJvhFhOQMPPQu9tHUa9b2KkHa+5sKdL6DxnaW1O1iUbe4cJkdIMnROMnZxuVy1iu0zAwvYC+RpXo+5IJTCE8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738082369; c=relaxed/simple;
	bh=/KpLabA68Ak2gO3Zh94uYnvL6rYJdCKG7nz2pp0x+k0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k1UJ4kspdE5OZR1y/wIV4MpfaBDQ30WBHgRGbqzPhUyS8rdgssyiPnQDz9FkwWB3NfqeRfjb0Oxgh+xvqyx0L7jxmsFIEMr9V6Ht59epd2172vh6liZcB5XlWcKeRDSoS5jnbYcgjWYTskuZEHaOzlJPlifv41rMNHQiTAhZiLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZOJeXyw8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738082367;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jiV6Ffp4rIGL2pzCQowSbFsXQuw9liHvQJLcfMUmaC4=;
	b=ZOJeXyw8Zy99mwvyj5ooQ1Tlgq3UCJkvMXoePc2IPcSI5x38tI7APdq4Km6lOW1cHnSm0H
	TcLAryYGYelu13xJKQ8gBtHrYHXYnEbe5JJmG1gP+nybTXIJcH5qzxbaBM9TIzVJ6Veqch
	ivZA1COUhYF7ST82QIE6Qa6318CN0Ak=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-524-NoLPzyDaOg-Hq3XADMbm4g-1; Tue,
 28 Jan 2025 11:39:23 -0500
X-MC-Unique: NoLPzyDaOg-Hq3XADMbm4g-1
X-Mimecast-MFC-AGG-ID: NoLPzyDaOg-Hq3XADMbm4g
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9D7FE1955DCD;
	Tue, 28 Jan 2025 16:39:22 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.45.225.106])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A205C18008D4;
	Tue, 28 Jan 2025 16:39:20 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: Kent Overstreet <kent.overstreet@linux.dev>,
	Shuah Khan <shuah@kernel.org>
Cc: Andreas Gruenbacher <agruenba@redhat.com>,
	linux-bcachefs@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 08/21] bcachefs: eytzinger[01]_test improvement
Date: Tue, 28 Jan 2025 17:38:45 +0100
Message-ID: <20250128163859.1883260-9-agruenba@redhat.com>
In-Reply-To: <20250128163859.1883260-1-agruenba@redhat.com>
References: <20250128163859.1883260-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

In eytzinger[01]_test(), make sure that eytzinger[01]_for_each()
iterates over all array elements.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/bcachefs/util.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/bcachefs/util.c b/fs/bcachefs/util.c
index 0ffbd22d3a5e..4122012ddfb2 100644
--- a/fs/bcachefs/util.c
+++ b/fs/bcachefs/util.c
@@ -728,6 +728,7 @@ void eytzinger1_test(void)
 
 			inorder++;
 		}
+		BUG_ON(inorder - 1 != size);
 	}
 }
 
@@ -761,6 +762,7 @@ void eytzinger0_test(void)
 
 			inorder++;
 		}
+		BUG_ON(inorder != size);
 	}
 }
 
-- 
2.48.1


