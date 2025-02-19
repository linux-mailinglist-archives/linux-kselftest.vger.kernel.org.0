Return-Path: <linux-kselftest+bounces-26976-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C323A3C2CC
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Feb 2025 15:57:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46CFF3B82F3
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Feb 2025 14:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6FB71F17E8;
	Wed, 19 Feb 2025 14:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="LyT6VsPh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C8DB1E3DE5;
	Wed, 19 Feb 2025 14:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739976786; cv=none; b=C9YuSDhAqI3JBspFvKxEnWcGPGaHSnwdzK2DCgmhvlXh7liIGVGlUuu4zVRpMEjKKLfP0KwWqD5SAJKPLFISDvlrn3QQno0XZeeBhG9W4SIzdMuX4UZhg/V7da45KfZaQl6Tue3D2R1vbDujIUyY3IxXi7HUNgbAUMcRdVN9OZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739976786; c=relaxed/simple;
	bh=tu4WVIJF223rTpEWbwlaBpWytn6iFw+i67smhB6epTo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Em89OJavj6lUV+vq400Ns/P8MB87rSC7DyyU4BkAUKlamOoLR7ZbhkZninlTFsCnHTgSAzf/Z0F82dFZoqyGjvIeYtfMPTGR1kebkNi8SKleKAwGOjBGTP1dC6URRrntaF2CpIFupD9B2HYuD7Ttn32qF2rkTdhAFLFIWsJ6LCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=LyT6VsPh; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2C3F6204CD;
	Wed, 19 Feb 2025 14:53:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1739976782;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=5VDkGsDaDqbgamfigdNa+cYCENWw5QBOSl85Mw3UIMc=;
	b=LyT6VsPhl+pvcQIO2zUtl6bglOwUhWceF20npCaK3/UFQw4v+q2dgy1oEKmehAl9AmXHQx
	URT+uPMmCyfpykc2qE367F52w3i+G8dQSTQOLK/N6j2jP7zCc6dSxXcRQBVr6E48fXBtTu
	qjxdCOY3b+3rAKRR/XI1fgg1Q9c4AZGLIU7DbtlKyuUYbNsDq1Tt5MH+bq7Zo02G1vQ6F/
	pac6Blb251w0qGc0wkhb3SSdQgiU07+yYnaUPrtZP3RN6iVRuZyg70+lyv8IJGr114ZLSS
	GEi+Py71NK7whaoDiCYikFdktwRW0UpqOy5iuHa15w/sQ8+W/0Sd8/3uc9gV+Q==
From: "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
Subject: [PATCH bpf-next v2 0/4] selftests/bpf: tc_links/tc_opts:
 Unserialize tests
Date: Wed, 19 Feb 2025 15:52:59 +0100
Message-Id: <20250219-b4-tc_links-v2-0-14504db136b7@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEvwtWcC/x3MSwqAMAwA0atI1gZq8YNeRUSsphqUKG2Rgnh3i
 8u3mHnAk2Py0GUPOLrZ8ykJOs9g3iZZCXlJBq10pXTRoikxzOPBsns09VIZ26iWCgupuBxZjv+
 tB3NZFIoBhvf9AIZovXtnAAAA
X-Change-ID: 20250219-b4-tc_links-b6d5bf709e1f
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: Alexis Lothore <alexis.lothore@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, bpf@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
X-Mailer: b4 0.14.2
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeigeehgecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffufffkgggtgffvvefosehtjeertdertdejnecuhfhrohhmpedfuegrshhtihgvnhcuvehurhhuthgthhgvthculdgvuefrhfcuhfhouhhnuggrthhiohhnmddfuceosggrshhtihgvnhdrtghurhhuthgthhgvthessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhephffgheekudehgeduiedufeevtdejjedvffekffetudejiefgkefgieeuheeftdejnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghloheplgduledvrdduieekrddtrddugegnpdhmrghilhhfrhhomhepsggrshhtihgvnhdrtghurhhuthgthhgvthessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepvddtpdhrtghpthhtoheprghnughrihhisehkvghrnhgvlhdrohhrghdprhgtphhtthhopehhrgholhhuohesghhoohhglhgvrdgtohhmpdhrtghpthhtohepsghpfhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegrshhtsehkvghrnhgvlhdro
 hhrghdprhgtphhtthhopeihohhnghhhohhnghdrshhonhhgsehlihhnuhigrdguvghvpdhrtghpthhtohepthhhohhmrghsrdhpvghtrgiiiihonhhisegsohhothhlihhnrdgtohhmpdhrtghpthhtohepshhonhhgsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehjohhlshgrsehkvghrnhgvlhdrohhrgh
X-GND-Sasl: bastien.curutchet@bootlin.com

Hi all,

Both tc_links.c and tc_opts.c do their tests on the loopback interface.
It prevents from parallelizing their executions.

Add a new behaviour to the test_progs framework that creates and opens a
new network namespace to run a test in it. This is done automatically on
tests whose names start with 'ns_'.

One test already has a name starting with 'ns_', so PATCH 1 renames it
to avoid conflicts. PATCH 2 introduces the test_progs 'feature'.
PATCH 3 & 4 convert some tests to use these dedicated namespaces.

Signed-off-by: Bastien Curutchet (eBPF Foundation) <bastien.curutchet@bootlin.com>
---
Changes in v2:
 - Handle the netns creation / opening directly in test_progs
 - Link to v1: https://lore.kernel.org/bpf/e3838d93-04e3-4e96-af53-e9e63550d7ba@bootlin.com

---
Bastien Curutchet (eBPF Foundation) (4):
      selftests/bpf: ns_current_pid_tgid: Rename the test function
      selftests/bpf: Optionally open a dedicated namespace to run test in it
      selftests/bpf: tc_links/tc_opts: Unserialize tests
      selftests/bpf: ns_current_pid_tgid: Use test_progs's ns_ feature

 .../selftests/bpf/prog_tests/ns_current_pid_tgid.c | 47 ++++++++--------------
 tools/testing/selftests/bpf/prog_tests/tc_links.c  | 28 ++++++-------
 tools/testing/selftests/bpf/prog_tests/tc_opts.c   | 40 +++++++++---------
 tools/testing/selftests/bpf/test_progs.c           | 12 ++++++
 4 files changed, 63 insertions(+), 64 deletions(-)
---
base-commit: a814b9be27fb3c3f49343aee4b015b76f5875558
change-id: 20250219-b4-tc_links-b6d5bf709e1f

Best regards,
-- 
Bastien Curutchet (eBPF Foundation) <bastien.curutchet@bootlin.com>


