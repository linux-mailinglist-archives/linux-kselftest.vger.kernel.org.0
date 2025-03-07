Return-Path: <linux-kselftest+bounces-28466-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23A02A56372
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Mar 2025 10:18:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F28A1759F5
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Mar 2025 09:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFFBF1FC0E3;
	Fri,  7 Mar 2025 09:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ptzGaUH0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83888202F9A;
	Fri,  7 Mar 2025 09:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741339122; cv=none; b=My+eZMh8wdJfcD/iX3oaDzIK1FboSWE49Ek8G6r5G3Ea+vO9vx8/uItVIhj2zgkh8BuxZ6Zfw8HxVE55VlW+oo7+NxvfZCkYNjRcTOag+XJItzgi6rOay0Y0g6a/0U12d/AylcC+gvIkevBQ0OeJeBOJzIzBw6UdQdZvVTBDFRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741339122; c=relaxed/simple;
	bh=4FFtFEAghaw8Fxm+0QcQSP352FEs3EHEKWLpqW/iUy8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=A6wrkcV+/gQX5m7++C4eEPe78lDDffDuxmRUgYLYN6cDKcnHD3lsMN7jW245c4pfH/2GJhTPicrYFA7uYMK95e2FABffFxTBEBQ6B2XQhhgvT69GVawUP5Z2+7gljACATJquuqZt6n9vesuxIqaxksZ1Das3x51eBF00uowmxJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ptzGaUH0; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id B01614326B;
	Fri,  7 Mar 2025 09:18:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1741339113;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=acms9IK6zQkC5xrSpOuATQi+b7do71St7Vfny2KwyEo=;
	b=ptzGaUH099OlY/n4qguKI8Aw71Z6UTx94ap1k2b7u6Neq0BdxnD0qGi15sVPvDTk2zZkTz
	03NlKwZZLRMjCeVuvqXt31vgVDR2CBkW1G3kiV69ZP/sRtbypTCnb3gYBaNUFo6amlxuCS
	abiVr+RGN0XP4uU0iR5pxs3FlfTPtJEFUwAdbwsHQct1SqhnIuYWnvSBwn6k6v3W3g6v+8
	A7obr0NAxuesLMQo2wCnm/RN6szYHhb/reunsEVYwf5HTlXf+JqfPxvDNLwU89biqsAw9/
	fH1Gzbmt/E1xFQERppQep+/q9ENOdnlvpWkWoCVJoNBKkmu/E86FYvo2pi9y/A==
From: "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
Subject: [PATCH bpf-next 0/2] selftests/bpf: Move test_lwt_seg6local to
 test_progs
Date: Fri, 07 Mar 2025 10:18:22 +0100
Message-Id: <20250307-seg6local-v1-0-990fff8f180d@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAN65ymcC/x3MQQqAIBRF0a3EHyekmIO2Eg3UXvZBLDQiCPeeN
 DxwuS8VZEahqXsp4+bCR2qQfUd+tylA8NpMalDjoKQWBcHEw9sojHZ+hdbOGFDrz4yNn/81kzs
 3kfBctNT6ATnG+jllAAAA
X-Change-ID: 20250214-seg6local-64bcde44b66e
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
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
X-Mailer: b4 0.14.2
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduuddtvdekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhufffkfggtgfgvfevofesthejredtredtjeenucfhrhhomhepfdeurghsthhivghnucevuhhruhhttghhvghtucdlvgeurffhucfhohhunhgurghtihhonhdmfdcuoegsrghsthhivghnrdgtuhhruhhttghhvghtsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeektdekgfettdegkefhudejveefhfdvtefgudduieefvdfhvdfgfeethefhvdevhfenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghloheplgduledvrdduieekrddtrddugegnpdhmrghilhhfrhhomhepsggrshhtihgvnhdrtghurhhuthgthhgvthessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepvddtpdhrtghpthhtohephihonhhghhhonhhgrdhsohhngheslhhinhhugidruggvvhdprhgtphhtthhopegurghnihgvlhesihhoghgvrghrsghogidrnhgvthdprhgtphhtthhopehkphhsihhnghhhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehmhihkohhlrghlsehfsgdrtghomhdprhgtphhtthhop
 ehthhhomhgrshdrphgvthgriiiiohhnihessghoohhtlhhinhdrtghomhdprhgtphhtthhopegrlhgvgihishdrlhhothhhohhrvgessghoohhtlhhinhdrtghomhdprhgtphhtthhopegrnhgurhhiiheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohephhgrohhluhhosehgohhoghhlvgdrtghomh
X-GND-Sasl: bastien.curutchet@bootlin.com

Hi all,

This patch series continues the work to migrate the script tests into
prog_tests.

test_lwt_seg6local.sh tests some bpf_lwt_* helpers. It contains only one
test that uses a network topology quite different than the ones that
can be found in others prog_tests/lwt_*.c files so I add a new
prog_tests/lwt_seg6local.c file.

While working on the migration I noticed that some routes present in the
script weren't needed so PATCH 1 deletes them and then PATCH 2 migrates
the test into the test_progs framework.

Signed-off-by: Bastien Curutchet (eBPF Foundation) <bastien.curutchet@bootlin.com>
---
Bastien Curutchet (eBPF Foundation) (2):
      selftests/bpf: lwt_seg6local: Remove unused routes
      selftests/bpf: lwt_seg6local: Move test to test_progs

 tools/testing/selftests/bpf/Makefile               |   1 -
 .../selftests/bpf/prog_tests/lwt_seg6local.c       | 176 +++++++++++++++++++++
 tools/testing/selftests/bpf/test_lwt_seg6local.sh  | 156 ------------------
 3 files changed, 176 insertions(+), 157 deletions(-)
---
base-commit: 86eb3a47230a41c6ccf5cdae8ee0a7e7292aa29d
change-id: 20250214-seg6local-64bcde44b66e

Best regards,
-- 
Bastien Curutchet (eBPF Foundation) <bastien.curutchet@bootlin.com>


