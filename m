Return-Path: <linux-kselftest+bounces-8331-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 662608A9B08
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Apr 2024 15:18:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8957B227D6
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Apr 2024 13:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B66FD161937;
	Thu, 18 Apr 2024 13:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SiD671Ke"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32637161912
	for <linux-kselftest@vger.kernel.org>; Thu, 18 Apr 2024 13:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713446292; cv=none; b=L22QWZ67OPA/LAG0hyk00r7p1G1ztrArC0f/mRhTv7p500i9O2Hke/3mhumFNYNbFcIpxFrASQFY4rrVGGzZdjizHuNZ42MnxSaJ8d95AksMJWZxewSgH7Vp9Chc03oHOtqF2VlZOX1bQCIrAuPWd3uZtxMBdHTOmNTyN9gUTU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713446292; c=relaxed/simple;
	bh=Ivl7NLRFYxtoqjJkKe1UCiz86XgKw2dJ0dlF8yqQUlM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iOeQ+S9QfU6wbk8o5smcjqqq+16yOm6PTbseHHGTUTmWcOXYXbdltw0kQ4m4LWWYcWSb/H0VgI3374kyOwYB6k1bY5UCffB/5V+lUV1Nj/gDTZ9RV04cH+O4KLyAPDB0ExrOqdzpB4BIXzxp4Pdq4bMfbtG9h0dWdOAMXwwNZxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SiD671Ke; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713446290;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2lvDVBn2YeHNhWXJQKj2GHQDBwVBzUZ6NZWRt9eEEeI=;
	b=SiD671KeZZ8QtKjFHxDEIxxI/T47BMLhFXeVTQRjvIWE3VC2ufPK4gvH3Q/TtjTQTbKt/a
	iCRjx4As4CFj65+fG/PTDNB+kiDTQrY/827uVx6warFJIPBohhAFhAuv+4LsOg0cLdut02
	hzh8OZ4Vw+IiZ1cVqSG9yKwdB7vtr4k=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-142-0KBN1d59MpKjGWi_1t5Ugw-1; Thu,
 18 Apr 2024 09:18:06 -0400
X-MC-Unique: 0KBN1d59MpKjGWi_1t5Ugw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C829A3C23FD0;
	Thu, 18 Apr 2024 13:18:05 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.16.186])
	by smtp.corp.redhat.com (Postfix) with ESMTP id B9D37C271A4;
	Thu, 18 Apr 2024 13:18:03 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>,
	Rae Moar <rmoar@google.com>,
	linux-kselftest@vger.kernel.org (open list:KERNEL UNIT TESTING FRAMEWORK (KUnit)),
	kunit-dev@googlegroups.com (open list:KERNEL UNIT TESTING FRAMEWORK (KUnit)),
	linux-kernel@vger.kernel.org (open list)
Cc: Wander Lairson Costa <wander@redhat.com>
Subject: [PATCH 2/2] kunit: avoid memory leak on device register error
Date: Thu, 18 Apr 2024 10:17:53 -0300
Message-ID: <20240418131754.58217-3-wander@redhat.com>
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

If the device register fails, free the allocated memory before
returning.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
---
 lib/kunit/device.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/kunit/device.c b/lib/kunit/device.c
index 25c81ed465fb..d8c09dcb3e79 100644
--- a/lib/kunit/device.c
+++ b/lib/kunit/device.c
@@ -131,6 +131,7 @@ static struct kunit_device *kunit_device_register_internal(struct kunit *test,
 	err = device_register(&kunit_dev->dev);
 	if (err) {
 		put_device(&kunit_dev->dev);
+		kfree(kunit_dev);
 		return ERR_PTR(err);
 	}
 
-- 
2.44.0


