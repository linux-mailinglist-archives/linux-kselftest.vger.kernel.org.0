Return-Path: <linux-kselftest+bounces-25320-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94B1AA20EC1
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Jan 2025 17:39:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECB7F167636
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Jan 2025 16:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2F901DE3A8;
	Tue, 28 Jan 2025 16:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KHlGokxM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA2F1DE3AB
	for <linux-kselftest@vger.kernel.org>; Tue, 28 Jan 2025 16:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738082361; cv=none; b=Cs4mbtw96dOcRf5n7+o/S6uVzJDejH+uftiB4A1krtKALEKyJzTyfneJUwHA7g2HOQC1ezjKt/amJph4GWo9kAdcpfCPJ6djyQ+tv4TDEbTBm/erEz2sPCIz7571HKdHNmHEXo24mhs6BhiK1W2dNCq7/Ziuha5DQggXdJG2vf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738082361; c=relaxed/simple;
	bh=80V5ZD3kqKIEt9ykSkK9ujmtNKhjg0TdGjBMSGp3CxM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Efc8v+AwhUYAtgPtt30JcG5T6xjCMoq/SUkM1G16zG3+BOY6uId/hBsXXCnihYOE4IVvr0G5JjSQ6TfNAi1v6ffPXs5rqZPRwTaDJA60NP1+GwO8i2MKwNE/CHQGNTRbyyN4PPs6sxDxAgg+5X8f3Bo1D/yOXDtx7jfBycn3vso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KHlGokxM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738082359;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RFsVTpVx9tfu2gtY/FcLf9k1nGGY3NJBOkFAp0nnMYI=;
	b=KHlGokxMQmudMPJFBUAtrUxMCDuWjNw/Zj5LsR4MPBVXq7kv49wjz7QtcbIXy0Hlq7nAb7
	1vUb/PjZac7a5PnMGcnX34PvDyb7WPULV+qp2ayLmViWcF8tVGuKjiQtQCWA0Opn+laRSz
	J4npp5vxy+KpqBSmcHjJKH56F8ngjM0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-493-i_O4QtVUMoCT3VCvHwK1gA-1; Tue,
 28 Jan 2025 11:39:13 -0500
X-MC-Unique: i_O4QtVUMoCT3VCvHwK1gA-1
X-Mimecast-MFC-AGG-ID: i_O4QtVUMoCT3VCvHwK1gA
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CB4CB195608B;
	Tue, 28 Jan 2025 16:39:12 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.45.225.106])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id EB4A4180035E;
	Tue, 28 Jan 2025 16:39:10 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: Kent Overstreet <kent.overstreet@linux.dev>,
	Shuah Khan <shuah@kernel.org>
Cc: Andreas Gruenbacher <agruenba@redhat.com>,
	linux-bcachefs@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 04/21] bcachefs: EYTZINGER_DEBUG fix
Date: Tue, 28 Jan 2025 17:38:41 +0100
Message-ID: <20250128163859.1883260-5-agruenba@redhat.com>
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

When EYTZINGER_DEBUG is defined, <linux/bug.h> needs to be included.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/bcachefs/eytzinger.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/bcachefs/eytzinger.h b/fs/bcachefs/eytzinger.h
index 16303908ccff..6fa6d51a5420 100644
--- a/fs/bcachefs/eytzinger.h
+++ b/fs/bcachefs/eytzinger.h
@@ -8,6 +8,7 @@
 #define EYTZINGER_DEBUG
 
 #ifdef EYTZINGER_DEBUG
+#include <linux/bug.h>
 #define EYTZINGER_BUG_ON(cond)		BUG_ON(cond)
 #else
 #define EYTZINGER_BUG_ON(cond)
-- 
2.48.1


