Return-Path: <linux-kselftest+bounces-8347-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A955D8A9F6D
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Apr 2024 18:01:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A07E2818A1
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Apr 2024 16:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C2A016FF29;
	Thu, 18 Apr 2024 16:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P/1gCqVm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5DC616F84E
	for <linux-kselftest@vger.kernel.org>; Thu, 18 Apr 2024 16:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713456057; cv=none; b=gSzK7zLCTHOcjtxXdVojRz3R/kWYE/HVvP6dpIEryqllv3d4mXwkw1y/ZN+b+RTzw9+r63SDZxCDAoYQIJFTftlg0ZQnJshx9d0C6OdmIrFxYE6rM8Ruovlo1I4JigJbQU+KWGAuhlF3OK72nPgPG3IPwBc1qj2EWHq81wsmgE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713456057; c=relaxed/simple;
	bh=RkC57Q7UJKwDbV5ZOymkImc73C43dsfw8U713gEUT98=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GKdJO/sgfcHrvLIxSzXfcGZqyVWKa6LwZcWPGEuOYoC8C6aJzp7ktRvLEHFaFst5YdG3iPOjiwo6rmCCCVh1vH61NR354toEimQVpHs2HBdXFAKSckEqwKKxhCKXrZQPCYwCbn5+yKfEUeTtOiHyXo4KMVZpqau2OSqzX7ZuLWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P/1gCqVm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713456054;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OquLsmPZLgQdNvdRfcQqVZOgi9jZ8SYqH65xHdO5f8w=;
	b=P/1gCqVm0w1UXWKldFaRpygblsJKb4bXokDXqcGgjWG7AVPKdby+JN9ZcSn/U5viDMDvr3
	dr79OKGb1ahJCHK5/+J8F1JwCSdf16+m9b9cQA3HfEy1T7VW4tmIMirbfdGigOyCcgOCo0
	a9sj1IpMHQ6ArYuNiEqVmc9/icvevgs=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-325-tlPy5OwSMauqxVcyfc3e9A-1; Thu,
 18 Apr 2024 12:00:49 -0400
X-MC-Unique: tlPy5OwSMauqxVcyfc3e9A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7C3FA1C05AE0;
	Thu, 18 Apr 2024 16:00:48 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.16.186])
	by smtp.corp.redhat.com (Postfix) with ESMTP id CC4A940829CD;
	Thu, 18 Apr 2024 16:00:45 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>,
	Rae Moar <rmoar@google.com>,
	Maxime Ripard <mripard@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	linux-kselftest@vger.kernel.org (open list:KERNEL UNIT TESTING FRAMEWORK (KUnit)),
	kunit-dev@googlegroups.com (open list:KERNEL UNIT TESTING FRAMEWORK (KUnit)),
	linux-kernel@vger.kernel.org (open list)
Cc: Wander Lairson Costa <wander@redhat.com>
Subject: [PATCH v2 1/2] kunit: unregister the device on error
Date: Thu, 18 Apr 2024 13:00:37 -0300
Message-ID: <20240418160039.69993-2-wander@redhat.com>
In-Reply-To: <20240418160039.69993-1-wander@redhat.com>
References: <20240418160039.69993-1-wander@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

kunit_init_device() should unregister the device on bus register error,
but mistakenly it tries to unregister the bus.

Unregister the device instead of the bus.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
Fixes: d03c720e03bd ("kunit: Add APIs for managing devices")
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


