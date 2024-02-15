Return-Path: <linux-kselftest+bounces-4782-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF76E856961
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Feb 2024 17:18:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BFE9290EAB
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Feb 2024 16:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAB8D134730;
	Thu, 15 Feb 2024 16:18:04 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC00A13472A;
	Thu, 15 Feb 2024 16:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708013884; cv=none; b=uynAYUa5+T2HjlMokaMa33JOV3EAm5kyOJJakbLebYBClUaEAVNqYrO8+bMhnCqp4KHgrXMYZQHBzNAkIQNLz1fANcPtEzfG3E4T+MZRtZ4+f5pqrmkvN0vPxD+ZyJFogZKbv0q4O+/MeCggrghb78mQ8v23F72NIa0jUQF9zYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708013884; c=relaxed/simple;
	bh=TSSwNN3LmNhxS9dNRKcIJDl5KbLsosK0LGEd+GxbZjw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gclKO8E43dQnPMSYgePaytPeVooEi9e0zKh509OsmYIWcdX16dNRNVnsTVauyzGSpleNMRw9qiOB/uQ+r89OehhbYxOPSEeyID+z90liqunVjiM0eE//zQ8JuRVk7LS/Zogy4tFBc2fOHzV2jU6OCDOSPRKst72zyGN52oXvv5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=none smtp.mailfrom=queasysnail.net; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=queasysnail.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 15CCB1C0014;
	Thu, 15 Feb 2024 16:17:51 +0000 (UTC)
From: Sabrina Dubroca <sd@queasysnail.net>
To: netdev@vger.kernel.org
Cc: Sabrina Dubroca <sd@queasysnail.net>,
	Boris Pismenny <borisp@nvidia.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Vakul Garg <vakul.garg@nxp.com>,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net 0/5] tls: fixes for record type handling with PEEK
Date: Thu, 15 Feb 2024 17:17:28 +0100
Message-ID: <cover.1708007371.git.sd@queasysnail.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: sd@queasysnail.net

There are multiple bugs in tls_sw_recvmsg's handling of record types
when MSG_PEEK flag is used, which can lead to incorrectly merging two
records:
 - consecutive non-DATA records shouldn't be merged, even if they're
   the same type (partly handled by the test at the end of the main
   loop)
 - records of the same type (even DATA) shouldn't be merged if one
   record of a different type comes in between

Sabrina Dubroca (5):
  tls: break out of main loop when PEEK gets a non-data record
  tls: stop recv() if initial process_rx_list gave us non-DATA
  tls: don't skip over different type records from the rx_list
  selftests: tls: add test for merging of same-type control messages
  selftests: tls: add test for peeking past a record of a different type

 net/tls/tls_sw.c                  | 24 +++++++++++------
 tools/testing/selftests/net/tls.c | 45 +++++++++++++++++++++++++++++++
 2 files changed, 61 insertions(+), 8 deletions(-)

-- 
2.43.0


