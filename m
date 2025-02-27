Return-Path: <linux-kselftest+bounces-27761-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10708A480B9
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2025 15:16:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFF5A3A5CD7
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2025 14:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7060235340;
	Thu, 27 Feb 2025 14:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="HIaGtyJj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C8C17BA6;
	Thu, 27 Feb 2025 14:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740665316; cv=none; b=d7woGY6S0FJ7pAsOwPXtVl9Btsb4tvBqtaqm8q2n8mD6Hab27gt7AM2bzJgSgxeQ0bzpkB7xAzb72983iqXCURZC/oD5BG9K/qZxPfih5UuvzwY5kOEEmlr5w3yL3GPvTtF0zRoutMFuc+a2bX/LlLpEnlkJBA1JEPG3xLJTLVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740665316; c=relaxed/simple;
	bh=gJt/cFfZaH6Og4HX/5kUVO/gZHEEtlmW+8JOgkIHyxA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=c+QWwySepANb6gpi0nDV0Ckwc/RgujnocrW/fZgCBSuQTYRe9YtQg5arOAjyDo5S9R3vnAWwhZt9NwneVmWKRujD6JU1BLiV08IhNSZYqxWoBZri2teepXPsLZJ6ulsN6bhRG2vN7UY2NTC9akLJ3HsokCXeQWhbVmi6HMoUcd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=HIaGtyJj; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7D07644170;
	Thu, 27 Feb 2025 14:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1740665310;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=A24/2SZcuFtlVpRIfutvUh+D2wAns2FOkWmIRd/eu00=;
	b=HIaGtyJjCcdFHCsdHuTqqIwZ5469kZcxDprgdjd1XVJj9GagN++Yzw+l2Y1ZVLt/7Jim0L
	qsm7Fs/sNe8uv6rHR6eAWlqdxlUTU25UhfPyWh69QBoYK7Pr3IK027/wpm+J7xn2ANpcYz
	NaJw2EICUzBOUKjw5Zo4FA5XnZys5VXW9MUSIIIkeL/f+LEEE/oBbzcDLCN/Rx77asfAly
	yK/1u/V+r5vugk8T+3m9SDFUJ1tv/EvOS4kcYdAC6Z+TaX1L7hRJanpHd+ajYtMSFvbwcE
	+0K5jRwXRzWspBsjJT9eGDQ4vwRXeHnDlkDxHzKVsE51vtovX0F3p6A7BABvvw==
From: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Date: Thu, 27 Feb 2025 15:08:23 +0100
Subject: [PATCH] bpf/selftests: test_select_reuseport_kern: remove unused
 header
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250227-remove_wrong_header-v1-1-bc94eb4e2f73@bootlin.com>
X-B4-Tracking: v=1; b=H4sIANZxwGcC/x3MSwqAMAxF0a1IxhZq8IdbERGxT83AVlJQQdy7x
 eEZ3PtQhAoiddlDilOiBJ9Q5BnN2+RXGHHJxJYry9wYxR5OjJcGv44bJgc1lh23ratLtiWl8lA
 scv/XfnjfDwMl6ORlAAAA
X-Change-ID: 20250227-remove_wrong_header-02d288d64204
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
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, bpf@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
X-Mailer: b4 0.14.2
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekjeeiiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkffvvefosehtkeertdertdejnecuhfhrohhmpeetlhgvgihishcunfhothhhohhrroculdgvuefrhfcuhfhouhhnuggrthhiohhnmdcuoegrlhgvgihishdrlhhothhhohhrvgessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepueehfeevfeeggfegueeuueehveevteefjeduieeigeefgffhiedvleeuhffhhfelnecuffhomhgrihhnpegsohhothhlihhnrdgtohhmnecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopegludelvddrudeikedrtddrvddungdpmhgrihhlfhhrohhmpegrlhgvgihishdrlhhothhhohhrvgessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepvddupdhrtghpthhtoheplhhinhhugidqkhhsvghlfhhtvghsthesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsohhngheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohephhgrohhluhhosehgohhoghhlvgdrtghomhdprhgtphhtthhopegurghnihgvlhesihhoghgvr
 ghrsghogidrnhgvthdprhgtphhtthhopehsughfsehfohhmihgthhgvvhdrmhgvpdhrtghpthhtohepvggsphhfsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtohepmhgrrhhtihhnrdhlrghusehlihhnuhigrdguvghvpdhrtghpthhtohepmhihkhholhgrlhesfhgsrdgtohhm
X-GND-Sasl: alexis.lothore@bootlin.com

test_select_reuseport_kern.c is currently including <stdlib.h>, but it
does not use any definition from there.

Remove stdlib.h inclusion from test_select_reuseport_kern.c

Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
---
I stumbled upon this specific header include while trying to build selftests on
the current bpf-next_base branch, which ended with this error:

[...]
  CLNG-BPF [test_progs-cpuv4] test_select_reuseport_kern.bpf.o
In file included from progs/test_select_reuseport_kern.c:4:
/usr/include/bits/floatn.h:83:52: error: unsupported machine mode
'__TC__'
   83 | typedef _Complex float __cfloat128 __attribute__ ((__mode__
(__TC__)));
      |                                                    ^
/usr/include/bits/floatn.h:97:9: error: __float128 is not supported on
this target
   97 | typedef __float128 _Float128;

The exact error (unknown TC mode) is likely rather due to some issues in
my local build, in which I am actually cross-compiling selftests  (for
ARM64 from a x86_64 host, but not through vmtests.sh), and I still have
to sort out some other issues. But I guess it is not really right anyway
to include stdlib.h from an ebpf program, especially if it is not used,
so I am still proposing this small change.
---
 tools/testing/selftests/bpf/progs/test_select_reuseport_kern.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/progs/test_select_reuseport_kern.c b/tools/testing/selftests/bpf/progs/test_select_reuseport_kern.c
index 5eb25c6ad75b1a9c61f22e978d817d3dc88b3a2f..a5be3267dbb01372c84bb468e3a48eae69ac5329 100644
--- a/tools/testing/selftests/bpf/progs/test_select_reuseport_kern.c
+++ b/tools/testing/selftests/bpf/progs/test_select_reuseport_kern.c
@@ -1,7 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2018 Facebook */
 
-#include <stdlib.h>
 #include <linux/in.h>
 #include <linux/ip.h>
 #include <linux/ipv6.h>

---
base-commit: 072c40912477ebac2ef98cd0b1532ba9bebda20a
change-id: 20250227-remove_wrong_header-02d288d64204

Best regards,
-- 
Alexis Lothoré, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


