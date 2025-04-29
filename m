Return-Path: <linux-kselftest+bounces-31950-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7319AA3B6B
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Apr 2025 00:27:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CBF107A6D89
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Apr 2025 22:26:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F3942749C5;
	Tue, 29 Apr 2025 22:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="i+pIAioK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10DE270ED5;
	Tue, 29 Apr 2025 22:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745965636; cv=none; b=l65X0mCNFez37KBdlsrtDkicQOkZP4WpsC/29atjM0bXrn4GiUVEx8AlbLS6LFarsHUKBgUhSDbJHHeHSxzsE+xlIi20VKn0+cHhDzuPCp5uTNANll1GdwQJN9V1gI8favDarL/W+Hxrk0bpo2rmgLAoBkcMeyJofXZVVY3Nmrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745965636; c=relaxed/simple;
	bh=PLlpYUkKComDCwpdqOUw7vnutWpdX1yZK6ZOSdelAvo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rybhNzHbeBTK8nGnLGRr3lfXnU12nNWMZnonVdwmnDS28dLdOF1fN1k/wJfFeQNWTEQaycd5/T9cflScQmdV0TLucQ+qu2gmI2ONGDlzmmwmMm/b7EFyZpxvTz9GR3G46pvAJgkS+wIBbf61x9i9q4EAOVq7PYnYiYLN7h9gOlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=i+pIAioK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AEAEC4CEE3;
	Tue, 29 Apr 2025 22:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745965634;
	bh=PLlpYUkKComDCwpdqOUw7vnutWpdX1yZK6ZOSdelAvo=;
	h=From:To:Cc:Subject:Date:From;
	b=i+pIAioKwTOZ0ItbRsivCpMpA24tv8H01yzMrsxybI6CImOmgTR6BVpwvoGtn1j/5
	 jFYMGF/RmJYwpgeOa8g5nXpaMcYwmvhrmww1PjNhWpMcCy8saJ97BR+42S5FaxA/uR
	 fxjnVhzhYUlw+HwjyeCnGahnPt+OCZgJ1Axig1rE=
From: Shuah Khan <skhan@linuxfoundation.org>
To: brendan.higgins@linux.dev,
	davidgow@google.com,
	rmoar@google.com,
	corbet@lwn.net
Cc: Shuah Khan <skhan@linuxfoundation.org>,
	linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com,
	workflows@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] Update kunit doc and tool with tips to build errors
Date: Tue, 29 Apr 2025 16:27:10 -0600
Message-ID: <cover.1745965121.git.skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kunit kernel build could fail if there are ny build artifacts from a
prior kernel build. These can be hard to debug if the build artifact
happens to be generated header file. It took me a while to debug kunit
build fail on ARCH=x86_64 in a tree which had a generated header file
arch/x86/realmode/rm/pasyms.h

make ARCH=um mrproper will not clean the tree. It is necessary to run
make ARCH=x86_64 mrproper

Example work-flow that could lead to this:

        make allmodconfig (x86_64)
        make
        ./tools/testing/kunit/kunit.py run

Add this to the documentation and kunit.py build help message.

Shuah Khan (2):
  doc: kunit: add information about cleaning source trees
  kunit: add tips to clean source tree to build help message

 Documentation/dev-tools/kunit/start.rst | 12 ++++++++++++
 tools/testing/kunit/kunit.py            |  2 +-
 2 files changed, 13 insertions(+), 1 deletion(-)

-- 
2.47.2


