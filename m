Return-Path: <linux-kselftest+bounces-19244-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9534099525E
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Oct 2024 16:51:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C62F61C21BEA
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Oct 2024 14:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D805A1DFDB1;
	Tue,  8 Oct 2024 14:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="SieLekxt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE8218CBED;
	Tue,  8 Oct 2024 14:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728399068; cv=none; b=Q2bM7oxZN3/E7mF/xDkdYIWOAKwAKT5CtAu0sSPf6a5nB6e2JMb8d+u384UJv9BLyaQz3A4l2tZH1nEEZqn04y6VsYCU08pTK5GBwxqiTeC4wNfsMdHVg+Zx5aDpdCoeeq7UJI9ttNbRDYYtZPppvdo513NOcMhes2x279uCvRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728399068; c=relaxed/simple;
	bh=p/9acfdEgaLxVZfogRhnfANqjd3z7mrfWD179zJel/M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Sl4X+tJXQQDRn9ylZL/Gbwa1DvP7lpUbbLZn8GU/ARazEV94gFStWmwlSqb8JDNs6hrgdTdcGEOV2BnoQZTwgy7s/IshV3l4P25xoI9N+vhVBNKXu20ohrzwuVNQhrxzd7UJlIKz1b7KunJEeBhVS2f9t6z2WoSu3ASHSya/BcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=SieLekxt; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9C6244000A;
	Tue,  8 Oct 2024 14:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1728399064;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=T8JTIkRyYPw4ANhnRm9O1xslQPulRbbv6/2c4JrZHr0=;
	b=SieLekxt9CJgTwGfAISBzmrG8aI1Zw9QyaTNvG7O3mRQexMn+MGTAUtKxIRU1XJd9AGUhr
	OWoKrOtvHK+ncs/rsblUPL64zUk+f5lggblH4VOsnTdeW4F+gt11zJmMpCfUYvH5jL6PKK
	fuNCgJkNkg5EwJfnXI8KIDQCzBX13d2sMGj9n3A8j9uUH3J/fED+EovzLoHU4wdyqo1bAo
	niIeKT6ZAJhMBIy152AtsoprW1mCyn2kaBo+XQ7Am8E+PSqVjxCRluYd/7dvub+1FUo9pO
	vb/R8q4zfhr0b+ELQqfWkweSIQMvOusWpnEiCK8g1WKk4OnHVTJ6hd+pDwT1oA==
From: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Date: Tue, 08 Oct 2024 16:50:57 +0200
Subject: [PATCH bpf] selftests/bpf: add missing header include for htons
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241008-network_helpers_fix-v1-1-2c2ae03df7ef@bootlin.com>
X-B4-Tracking: v=1; b=H4sIANBGBWcC/x2MWwqAIBAAryL7naA96HGViMjaailU1qggunvS5
 wzMPBCQCQM04gHGkwI5G0EnAsZ1sAtKmiJDqtJcK1VJi8fleOtX3D1y6Ge6pTGmnHRR1XWmIJa
 eMer/2oLxM3Tv+wEKzjpBagAAAA==
X-Change-ID: 20241008-network_helpers_fix-bbb7d1589930
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: ebpf@linuxfoundation.org, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, bpf@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
X-Mailer: b4 0.14.2
X-GND-Sasl: alexis.lothore@bootlin.com

Including the network_helpers.h header in tests can lead to the following
build error:

./network_helpers.h: In function ‘csum_tcpudp_magic’:
./network_helpers.h:116:14: error: implicit declaration of function \
  ‘htons’ [-Werror=implicit-function-declaration]
  116 |         s += htons(proto + len);

The error is avoided in many cases thanks to some other headers included
earlier and bringing in arpa/inet.h (ie: test_progs.h).

Make sure that test_progs build success does not depend on header ordering
by adding the missing header include in network_helpers.h

Fixes: f6642de0c3e9 ("selftests/bpf: Add csum helpers")
Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
---
 tools/testing/selftests/bpf/network_helpers.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/bpf/network_helpers.h b/tools/testing/selftests/bpf/network_helpers.h
index c72c16e1aff825439896b38e59962ffafe92dc71..5764155b6d25188ed38e828e1e4a8a08f8a83934 100644
--- a/tools/testing/selftests/bpf/network_helpers.h
+++ b/tools/testing/selftests/bpf/network_helpers.h
@@ -1,6 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #ifndef __NETWORK_HELPERS_H
 #define __NETWORK_HELPERS_H
+#include <arpa/inet.h>
 #include <sys/socket.h>
 #include <sys/types.h>
 #include <linux/types.h>

---
base-commit: 67a7c7b656cfc10a7280f71641fb9e88726e8a5d
change-id: 20241008-network_helpers_fix-bbb7d1589930

Best regards,
-- 
Alexis Lothoré, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


