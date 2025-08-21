Return-Path: <linux-kselftest+bounces-39460-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 303BDB2EFFF
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 09:46:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B3607B2BC1
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 07:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B9AD23D2B1;
	Thu, 21 Aug 2025 07:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=0x65c.net header.i=@0x65c.net header.b="S8Yb3yIi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from m204-227.eu.mailgun.net (m204-227.eu.mailgun.net [161.38.204.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 817D919F135
	for <linux-kselftest@vger.kernel.org>; Thu, 21 Aug 2025 07:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=161.38.204.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755762364; cv=none; b=J7UMu/Kx6q/+3FtHneWTIEPLygWba48GM4R0hmSj0zWIc+VWHAGw4YRE+zK36i+yo8NCpLOyS3pSfbe2brxO7IpkE4JwpYHw+ANLkeHxEeA7T7vAMtVw1L3dJfmQyiNPeBfZjTaiST+79yJ9XyWQTL54MmIcy09ImuKknds7+bM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755762364; c=relaxed/simple;
	bh=jtxKFVOjTnIGpDjVKvKlWABPophfMZw9Xc89ngO6tTY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cDD3Cmu4H78yTGjenHJrgMkTJxRZNdtBcQ1x4LT2XLdcwrsVTHJPguh7rfS1/XNdxeBjtHzo5fMRe1bRT8v+g1mNEZvII88pUz7gKy9nqvW8QLG9T8OdlLADNJIaE+1ScA0rMI26scJZbArAQwxP3dZFEe4ly1j2DTa+lndyva8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0x65c.net; spf=pass smtp.mailfrom=0x65c.net; dkim=pass (2048-bit key) header.d=0x65c.net header.i=@0x65c.net header.b=S8Yb3yIi; arc=none smtp.client-ip=161.38.204.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0x65c.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0x65c.net
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=0x65c.net; q=dns/txt; s=email; t=1755762359; x=1755769559;
 h=Content-Transfer-Encoding: Content-Type: MIME-Version: Message-ID: Date: Subject: Subject: Cc: To: To: From: From: Sender: Sender;
 bh=G07zZo/ZUjFs2pVfbhnQDmrrZ4OtXCwlPhefz537RQM=;
 b=S8Yb3yIiY541QeSL9VdNNc+T/XTgW838iq7ySBkLfELlv506PV4uORev/S69evh9wjE/QB1YUBRf2ihJ1t5oQ83wQ7YBYPrMyfeA41M5W6JPfXW8IohILiVlQnQbAkBdwYvKChh8rOlQ+zIpesARNLpumyA6+SehgzcwfZ07kWvzIGwOf/UNehwga8RnYazh8j9LrPRC889Ecg/E9StIOszdAG5zD8m7v73aGmrWSQ157uEAdysv5NeScAh3qSOrp2tFWLukvJjtvmi3VVcyffLmooFzLcmzBzrCo7O4wJg+67uMCuh8hY0P6BjmyJ9sDmDCYHhcZTSEwZa21SkVGg==
X-Mailgun-Sid: WyJlMmQxMSIsImxpbnV4LWtzZWxmdGVzdEB2Z2VyLmtlcm5lbC5vcmciLCI1NGVmNCJd
Received: from fedora (pub082136115007.dh-hfc.datazug.ch [82.136.115.7]) by
 0915ebfd771c1cc991a8a786c634850dbf8b05025dfa8b8697bc1d69e9166444 with SMTP id
 68a6ceb7f7c76b146d1411cd; Thu, 21 Aug 2025 07:45:59 GMT
X-Mailgun-Sending-Ip: 161.38.204.227
Sender: alessandro@0x65c.net
From: Alessandro Ratti <alessandro@0x65c.net>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	skhan@linuxfoundation.org
Cc: netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	alessandro.ratti@gmail.com
Subject: [PATCH] selftests: rtnetlink: add checks for ifconfig and iproute2
Date: Thu, 21 Aug 2025 09:43:10 +0200
Message-ID: <20250821074552.682731-1-alessandro@0x65c.net>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


Hi,

This patch improves portability of the rtnetlink selftests in two ways:

1. It wraps a call to ifconfig in a presence check to avoid test failures
   on systems where ifconfig is not installed — such as default Debian Bookworm
   and newer distributions where iproute2 is the norm.

2. It skips the do_test_address_proto test if the installed version of iproute2
   does not support the proto in ip address commands. Without this check,
   the test fails unconditionally on older iproute2 versions, even though the kernel
   functionality under test is not the culprit.

Both changes ensure that the test suite degrades gracefully by reporting SKIP
instead of FAIL on incompatible systems.

Tested on Debian Bookworm with iproute2 6.1.0 and without ifconfig.

Thanks for your time and consideration.

Best regards,
Alessandro Ratti

