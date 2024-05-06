Return-Path: <linux-kselftest+bounces-9514-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB9D18BCCA3
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 May 2024 13:13:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 024B11C217FF
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 May 2024 11:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CC11142E80;
	Mon,  6 May 2024 11:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="vf/4+HxZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F3321E880;
	Mon,  6 May 2024 11:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714994031; cv=none; b=S5F57xRPf+ilddq2gdGTNCtPGe3aETeRdr4o6X6tKIeizp2pCEk0ijgyfpprZ6iqfIBghQIcd4ZBrJMQ9QhYZlZzLi2WV772MsorwjijecH/z0Syw4lGVEJwnH59p+uwsHDtBjFhld4XuyujpTG3S7Z5s9Ez3qPwGHBGkg1W9gU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714994031; c=relaxed/simple;
	bh=a6i3CVDHlGAggk/fgGhmQbyqk8/OrNzsgYdWQKFFYVw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OjMW8WQ+V75clPosdRJvNuLuTnxmffLqaZp9y42HCS5AwrFSD8SDNZS2myi1UzQ5a09BMOnlu9TzVSrepeuAPgRrOSehgYMgaTVVrX7kiVpnzg1tCXkve3b9J3tN+aOhb0/mp2cvBFWq53x9oc7p1ehMFVTkbE3qfPE2YRACF9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=vf/4+HxZ; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1714994028;
	bh=a6i3CVDHlGAggk/fgGhmQbyqk8/OrNzsgYdWQKFFYVw=;
	h=From:To:Cc:Subject:Date:From;
	b=vf/4+HxZnuXCkOtg6wst9HXj/3NH+fR81yCztX5sVA0KzjIfl5/vTOTqrk6Mw6k6H
	 5vSgTxSI7jsBJGuW+fZgbU9R1c5eWkFDDI3JLgPaNFDq54lqdR0GTGOOE/MIZOHSH9
	 h6/hxe0Y0PI2TC8ST7QncyKNbeV/oKBReeYwBQ9FkEot/ddPdJ8m/J1EOhNKsK/QVe
	 AJXgDehdtmCxJRETXkRSPlpWEPRYCFkVm6O9xD3UOEGgYVz0Y3HQ+V7Y9eVRHLcjG9
	 cjLvC2XJf+FyE6ZtCJIb36V1HwzQeEY9jndvytSg8qyMd6LDhtfS5WYVYct66KkErN
	 COn83cL7rB+RQ==
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laura.nao)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 94067378020D;
	Mon,  6 May 2024 11:13:47 +0000 (UTC)
From: Laura Nao <laura.nao@collabora.com>
To: shuah@kernel.org
Cc: kernel@collabora.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Laura Nao <laura.nao@collabora.com>
Subject: [PATCH 0/2] Modify the watchdog selftest for execution with kselftest runner
Date: Mon,  6 May 2024 13:13:57 +0200
Message-Id: <20240506111359.224579-1-laura.nao@collabora.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The watchdog selftest script supports various parameters for testing
different IOCTLs. The watchdog ping functionality is validated by starting
a loop where the watchdog device is periodically pet, which can only be
stopped by the user interrupting the script.

This results in a timeout when running this test using the kselftest runner
with no non-oneshot parameters (or no parameters at all):

 TAP version 13
 1..1
 # timeout set to 45
 # selftests: watchdog: watchdog-test
 # Watchdog Ticking Away!
 # .............................................#
 not ok 1 selftests: watchdog: watchdog-test # TIMEOUT 45 seconds

To address this issue, the first patch in this series limits the loop to 5
iterations by default and adds support for a new '-c' option to customize
the number of pings as required.

The second patch conforms the test output to the KTAP format.

Laura Nao (2):
  selftests/watchdog: limit ping loop and allow configuring the number
    of pings
  selftests/watchdog: convert the test output to KTAP format

 .../selftests/watchdog/watchdog-test.c        | 166 +++++++++++-------
 1 file changed, 101 insertions(+), 65 deletions(-)

-- 
2.30.2


