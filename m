Return-Path: <linux-kselftest+bounces-8379-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C66F18AA48E
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Apr 2024 23:03:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66ED61F21684
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Apr 2024 21:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A09D1194C9F;
	Thu, 18 Apr 2024 21:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SmDbnbRG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF67194C8C
	for <linux-kselftest@vger.kernel.org>; Thu, 18 Apr 2024 21:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713474172; cv=none; b=rMI6+7YuFBQlyP13vqac0XchtexqYQVcbEmyp2ZH8UKIqqDbWg8IwQRrg8So/ga8/0COkHw6LIl6bzYpJwC64waUGgM9b4WCCMOYfL+Jw0UBsGGwbQPvL+F7/x+53e/19iC+aCP1a4ZuZBnXNRNH2w2mda6eZ2Y4e0CZfqtOqcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713474172; c=relaxed/simple;
	bh=RkC57Q7UJKwDbV5ZOymkImc73C43dsfw8U713gEUT98=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZAF7uPdHdE8F4mxGetb/BGTjkqj4kwqqSzlGT7QD2/5JnwBdCF0naQaMjIiIAXd4iAMP/z+sc4VxTsNSA4yGrLwFJk7anYK5A2ayOSW9N6/dzZkJ4Orm0rIuNPaMW339PKbF0J+1o5sTOJvuPxSpXFa+RpUu1xvfBFugO1BeUCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SmDbnbRG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713474170;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OquLsmPZLgQdNvdRfcQqVZOgi9jZ8SYqH65xHdO5f8w=;
	b=SmDbnbRGB5tIfuYPdSFyYDPNFnQE9NWEZoh8oExf1gwWeXiEUON7M6D8MusXm11dLYGSGa
	au6iZ96+ugjEcAs/NLaPMGtG4bzsfMNji7+iXPnKLdDvkwpEc6Ynwo+Y1xxu5DhT7Skhbm
	DymZwRpnjAGzEafgti+ovsD71bnCwog=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-335-DxhA7QUEOyePso0vqAbdvA-1; Thu, 18 Apr 2024 17:02:45 -0400
X-MC-Unique: DxhA7QUEOyePso0vqAbdvA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4979218065AA;
	Thu, 18 Apr 2024 21:02:44 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.16.186])
	by smtp.corp.redhat.com (Postfix) with ESMTP id E8302488D81;
	Thu, 18 Apr 2024 21:02:41 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>,
	Rae Moar <rmoar@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Maxime Ripard <mripard@kernel.org>,
	linux-kselftest@vger.kernel.org (open list:KERNEL UNIT TESTING FRAMEWORK (KUnit)),
	kunit-dev@googlegroups.com (open list:KERNEL UNIT TESTING FRAMEWORK (KUnit)),
	linux-kernel@vger.kernel.org (open list)
Cc: Wander Lairson Costa <wander@redhat.com>
Subject: [PATCH v3 1/2] kunit: unregister the device on error
Date: Thu, 18 Apr 2024 18:02:34 -0300
Message-ID: <20240418210236.194190-2-wander@redhat.com>
In-Reply-To: <20240418210236.194190-1-wander@redhat.com>
References: <20240418210236.194190-1-wander@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

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


