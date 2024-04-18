Return-Path: <linux-kselftest+bounces-8378-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D818D8AA48C
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Apr 2024 23:02:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 798CC1F21549
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Apr 2024 21:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BDB8194C6E;
	Thu, 18 Apr 2024 21:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JzujF4hF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2974146596
	for <linux-kselftest@vger.kernel.org>; Thu, 18 Apr 2024 21:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713474169; cv=none; b=SnIbAhm5hMGPL0ZxDnAZrvmaYUbDlf3Ux37m02vv66MlL6KGzO4BZHR4OWWaD8bijfBQbPqNu2jWpPYYLVbAZkei1PCBtFFO5SCpquz8XRy1FU4EmaZmjwHuSdsXeSGk/Mg4o1IuhKqf1aVaRjJUnA7w9o7uZlI9dj8vrdhQEHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713474169; c=relaxed/simple;
	bh=KZa/vZufk2PsBjetQQ+gPzVW8ZNJp5XBtr6BD0HWs40=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SOvIxyOz0UPhDYnjUt2ay6mbwuYTklqJ65s+9GCOHIfCxpiyDn9qCfZKJl+buAjreXMkeBR1J+SiHcrtOWbScb34I6OJ9qupqz8CH7xHYrN9xkU3uTaJm1rvMiUhP9jSUmyC+rHR9E2WHojrF3rHtyBCBDvcmzuzC7YlEOowTII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JzujF4hF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713474166;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ObaeTICvAPqWukXrEO4oct5PVN7dK5UdpfwP8Y9ZffY=;
	b=JzujF4hFyBpaNV0fZLc2pE5KveIjSM8q1Ni5WEkPq4fLg3err5e61UGWogzbYglHhCxhHP
	kdezFvVhyHJ5ji1D/rAkRKMM0aNKPOjT5Ox/zP2CO4Pt4zyUZgk/gDb6rDc6c1b63H93sv
	qzQpIKCg8xRDw++1JZjQlk/EpfQvXdg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-tk6hNdpeN4CU_Sd-MP7FPg-1; Thu, 18 Apr 2024 17:02:42 -0400
X-MC-Unique: tk6hNdpeN4CU_Sd-MP7FPg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5C7F880591B;
	Thu, 18 Apr 2024 21:02:41 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.16.186])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 02DE5488D80;
	Thu, 18 Apr 2024 21:02:38 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>,
	Rae Moar <rmoar@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Maxime Ripard <mripard@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	linux-kselftest@vger.kernel.org (open list:KERNEL UNIT TESTING FRAMEWORK (KUnit)),
	kunit-dev@googlegroups.com (open list:KERNEL UNIT TESTING FRAMEWORK (KUnit)),
	linux-kernel@vger.kernel.org (open list)
Cc: Wander Lairson Costa <wander@redhat.com>
Subject: [PATCH v3 0/2] kunit: fix minor error path mistakes
Date: Thu, 18 Apr 2024 18:02:33 -0300
Message-ID: <20240418210236.194190-1-wander@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

Hi,

These two patches fix some minor error path mistakes in the device
module.

Changes
-------

v1->v2
* Add fixes tag
* Add imperative statement in the commit description
v2->v3
* Add a goto exit label kunit_device_register_internal

Wander Lairson Costa (2):
  kunit: unregister the device on error
  kunit: avoid memory leak on device register error

 lib/kunit/device.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

-- 
2.44.0


