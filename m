Return-Path: <linux-kselftest+bounces-8330-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF2418A9B06
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Apr 2024 15:18:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64112284C93
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Apr 2024 13:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7D021607B7;
	Thu, 18 Apr 2024 13:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OUezjuiN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F6A915FD0B
	for <linux-kselftest@vger.kernel.org>; Thu, 18 Apr 2024 13:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713446288; cv=none; b=dmraaBqr5Su7fV5uIHNXdy8KIQwBX0dA+OVSSZucXjvhOYjlceV+rxAlyQiyOE75rfm7/bau01+euZxDOd22xARPVCG/o163lUsCm0sbti4l5pFHKJ7zeGWOzE4gFFY3rul8vGLBSLp+tmHxoMHNj1bIeXzil30+2YbXHjsRSDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713446288; c=relaxed/simple;
	bh=nXM+CC7tSgd1SU8pAldhxaauEOPwaBJ/aoBUfDLRb5E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WWfjRanKQIWxduMY0/BHQK6WcKgmMlhXiRyxoCfrEBmshwvRisATCPtcPUzL6CR9W2HEWSXCONrkgT6TVARS5ZKQcWSpPIpS4vrzrxUMjALOpABxOLoWPB0uBdE5Ag6ZzT0OByOkD9Il7auZXyQHBIQGYAJHakIOTumOaUA9dU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OUezjuiN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713446286;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yrDuSMKVIPvxaoWUO2lKmOmdU2n/2aiR3bt/iorklfM=;
	b=OUezjuiNl0unzHd+KfoahhIJKR6cOiN/qUieHJiP9vAUaFwRhLDoNSST4IvUZx5c1kgurs
	ODp5PoKzv0mxjC7+/NqX1Eh63RaHcUM/+arYgvl+fJvAWst7gouqvZAS6R865qI0xqMfGJ
	iInGLQwAYWKZhKnmW4544rkizpTyyps=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-368-OykGZIxpNRCSTuIjaNnQqQ-1; Thu, 18 Apr 2024 09:18:03 -0400
X-MC-Unique: OykGZIxpNRCSTuIjaNnQqQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1810B800CAC;
	Thu, 18 Apr 2024 13:18:03 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.16.186])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 18366C271A9;
	Thu, 18 Apr 2024 13:18:00 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>,
	Rae Moar <rmoar@google.com>,
	linux-kselftest@vger.kernel.org (open list:KERNEL UNIT TESTING FRAMEWORK (KUnit)),
	kunit-dev@googlegroups.com (open list:KERNEL UNIT TESTING FRAMEWORK (KUnit)),
	linux-kernel@vger.kernel.org (open list)
Cc: Wander Lairson Costa <wander@redhat.com>
Subject: [PATCH 1/2] kunit: unregister the device on error
Date: Thu, 18 Apr 2024 10:17:52 -0300
Message-ID: <20240418131754.58217-2-wander@redhat.com>
In-Reply-To: <20240418131754.58217-1-wander@redhat.com>
References: <20240418131754.58217-1-wander@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

kunit_init_device() should unregister the device on bus register error.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
---
 lib/kunit/device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/kunit/device.c b/lib/kunit/device.c
index abc603730b8e..25c81ed465fb 100644
--- a/lib/kunit/device.c
+++ b/lib/kunit/device.c
@@ -51,7 +51,7 @@ int kunit_bus_init(void)
 
 	error = bus_register(&kunit_bus_type);
 	if (error)
-		bus_unregister(&kunit_bus_type);
+		root_device_unregister(kunit_bus_device);
 	return error;
 }
 
-- 
2.44.0


