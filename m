Return-Path: <linux-kselftest+bounces-10340-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A05348C85D2
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 May 2024 13:47:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DCD81F22A47
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 May 2024 11:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C16C43F8D6;
	Fri, 17 May 2024 11:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kryf/Hid"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A023BB35;
	Fri, 17 May 2024 11:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715946431; cv=none; b=NvKxcx3bNhSk1M+7T8Tum6AWzwaezx/WlZB4P2/3f+xTGvSFdMPcoKWRQzTtWt0UsCUvFnzaB1t7zKcypeptxolu4jy60oIa9MrmEHIaUOtK2wEUIQ5Ig7Amnj7CgpEHuI6y1lolOn2LXuDIBeJcjj5AfTNbH1/GBnRA5VIqhXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715946431; c=relaxed/simple;
	bh=QPxik8B0uZ4chhltJzrxGabUS/wR7kyYGqGWD9+nCgc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TbNbuRWvoGIsBSCYXAr+RwUpUOJa5/NqxzsLoiYB0u3jm3vB7Dsw3t6Hnfowb1DT5NRlo+RODVx03S8sbu6fHq4dje1jAVnWOwzwf9kDGgpEEzj1bL5lTvQIHnuUSk5HsNDOGXc5ngGnt60pzq/+613yH7NDZgQOjDCZnSkEtS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kryf/Hid; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A300C2BD10;
	Fri, 17 May 2024 11:47:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715946431;
	bh=QPxik8B0uZ4chhltJzrxGabUS/wR7kyYGqGWD9+nCgc=;
	h=From:To:Cc:Subject:Date:From;
	b=kryf/Hidpo82T7jbyBP0ORsBFGOksfU1ecIjD8wq256hwJ9ovWXPvozuYKc3zpXkS
	 9tg19TrH5cemLG5+m9ZrGglcGXhaGOK6LN205CxeJOFAc5FhIBLzyIv00FH2A/pofq
	 QNvaw4pkwgct0oPQNGTSqdwhj3En0wKh8RJBrxqs2HlDz3xSZZo6FrKsWPGKn3L8K2
	 f002pLW1EY4P+hbmPuu97A2a6dydPtcSNuDOtmFEYGaJrwCCUBtgdPaTEFHsm9jaY0
	 nQgHVk7VT0eOzwXq/OA5+qq9SZmoj8K9Oe7nyJLLlmqE73W6Zc3Vgyx8YrABNFoK6R
	 qlvkN6cNSebHA==
From: Masahiro Yamada <masahiroy@kernel.org>
To: Kees Cook <keescook@chromium.org>,
	Andy Lutomirski <luto@amacapital.net>,
	Will Drewry <wad@chromium.org>,
	linux-kselftest@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Benjamin Tissoires <benjamin.tissoires@redhat.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	David Hildenbrand <david@redhat.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Jiri Kosina <jikos@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	bpf@vger.kernel.org,
	kvm@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-rtc@vger.kernel.org
Subject: [PATCH 0/2] selftests: harness: refactor __constructor_order
Date: Fri, 17 May 2024 20:45:04 +0900
Message-Id: <20240517114506.1259203-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


This series refactors __constructor_order because
__constructor_order_last() is unneeded.

BTW, the comments in kselftest_harness.h was confusing to me.

As far as I tested, all arches executed constructors in the forward
order.

[test code]

  #include <stdio.h>

  static int x;

  static void __attribute__((constructor)) increment(void)
  {
           x += 1;
  }

  static void __attribute__((constructor)) multiply(void)
  {
          x *= 2;
  }

  int main(void)
  {
          printf("foo = %d\n", x);
          return 0;
  }

It should print 2 for forward order systems, 1 for reverse order systems.

I executed it on some archtes by using QEMU. I always got 2.



Masahiro Yamada (2):
  selftests: harness: remove unneeded __constructor_order_last()
  selftests: harness: rename __constructor_order for clarification

 .../drivers/s390x/uvdevice/test_uvdevice.c     |  6 ------
 tools/testing/selftests/hid/hid_bpf.c          |  6 ------
 tools/testing/selftests/kselftest_harness.h    | 18 ++++--------------
 tools/testing/selftests/rtc/rtctest.c          |  7 -------
 4 files changed, 4 insertions(+), 33 deletions(-)

-- 
2.40.1


