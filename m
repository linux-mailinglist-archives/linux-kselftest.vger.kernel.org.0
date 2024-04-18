Return-Path: <linux-kselftest+bounces-8346-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8F148A9F69
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Apr 2024 18:01:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73B9E281B07
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Apr 2024 16:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBB7416F900;
	Thu, 18 Apr 2024 16:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z6FG1YNN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3858F16F8FB
	for <linux-kselftest@vger.kernel.org>; Thu, 18 Apr 2024 16:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713456052; cv=none; b=pGaz9W5lfp8QGZS8OJSNEA+uzFxC7MRw6qQHwD76P5UnW34BoIWQ/IM/u12DM54QLQxMdHMopaeGDUAHFQiNpOCAgMjuPAvMpRwDL3f09uhvxY2XzMKhMpfTnbF1uO8C4aAAFT5X+t+s7k5lW1Rug7VdkspDMufVaWKF8c+ZrGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713456052; c=relaxed/simple;
	bh=cyofhNpuzNoJ61d5zp30RxmRNrJJzUEO0QXv/sR7gDc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WKeEkBvQHhm0gH8imu9o4HmGUKBsN4dEliWaSPDkOJTqfRKbbmh0tJllboCoXZE2vytOYgObvQTlbSg0Vk77C+X3BonmigM8BO7Ni6jNu1RThBX3aeppBZMlCSAG5gi0C+vdFqDfpoQHX5CTsQMTdNEic6Xpd7pf52WddU1w6DI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z6FG1YNN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713456050;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=F0ag/Egk0C8yEugn2IgQOhKenICLMcEUisuefA5gpJU=;
	b=Z6FG1YNNmebDBiLkxKFnWAinOxJbW54ME507E8gSNp9RKoonczMTttbWmKPcz+OqLen9QS
	6/rA2LC9u7/hoNBKBpFJOzYjwGBovmnmXLeDg2C7i0QcyP5lLLukmFkYlkgfYqwRHSm5D0
	uN56S8zZsvz2HdCZh/jPJgDkcm4kgxg=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-104-V4V5UnIUPrikEavOkqdOMQ-1; Thu,
 18 Apr 2024 12:00:45 -0400
X-MC-Unique: V4V5UnIUPrikEavOkqdOMQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3A6F73816442;
	Thu, 18 Apr 2024 16:00:45 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.16.186])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 5516E40357A7;
	Thu, 18 Apr 2024 16:00:42 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>,
	Rae Moar <rmoar@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Maxime Ripard <mripard@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	linux-kselftest@vger.kernel.org (open list:KERNEL UNIT TESTING FRAMEWORK (KUnit)),
	kunit-dev@googlegroups.com (open list:KERNEL UNIT TESTING FRAMEWORK (KUnit)),
	linux-kernel@vger.kernel.org (open list)
Cc: Wander Lairson Costa <wander@redhat.com>
Subject: [PATCH v2 0/2] kunit: fix minor error path mistakes
Date: Thu, 18 Apr 2024 13:00:36 -0300
Message-ID: <20240418160039.69993-1-wander@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

Hi,

These two patches fix some minor error path mistakes in the device
module.

Changes:
--------

v1->v2:
* Add fixes tag.
* Add an imperative statement in the first commit descripton.

Wander Lairson Costa (2):
  kunit: unregister the device on error
  kunit: avoid memory leak on device register error

 lib/kunit/device.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

-- 
2.44.0


