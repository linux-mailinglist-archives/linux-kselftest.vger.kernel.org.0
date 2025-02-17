Return-Path: <linux-kselftest+bounces-26775-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9A8EA3830F
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Feb 2025 13:37:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 793261707DB
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Feb 2025 12:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65B7F218E85;
	Mon, 17 Feb 2025 12:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Mdth02Gv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443061E49F;
	Mon, 17 Feb 2025 12:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739795865; cv=none; b=bYYVoWqowU+X/8NpKro9Ero9qzMTxrBtNm5JEUGsGRq31CT+OGOmsNiDUGyrAJ9GfV+OJE2u+0HFcdvvxpKV7aQ8R+uLSPflbzQ+7JXuWFiYRs36MNPTaBUazbvzPqjPyDf2f21RQ1LIHwmu5EKa/EdI1ZnJ/Us8Kkdzrf5Xsa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739795865; c=relaxed/simple;
	bh=N+hbKVsU3yr0pdvxSg3gz8TMzTEZjqbulPC2FucYu98=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=VmuNooo3el3wmc9OL/wnjFQX2EGpDC5sv91zXvi/ZLnDdlKsr1CEQp+pPPRll5mbOHt+SwfR73pbMo0xqSfGon3Q5NqhozXmT4mSN0wG0uI8NSpOYmWNaeaKER8fGARu6MptQpIHwRj8LZnOVMNm9pQKtX+sj8AScLXl+CMSGAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Mdth02Gv; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D1C96442E6;
	Mon, 17 Feb 2025 12:37:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1739795860;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=MHW5GHgCy90xIagepwZyXILIBdlp2eVTmbrVYozSMjs=;
	b=Mdth02GvPC71UBUWFwBXdI21GKQdAJx5mrseKFVMSMqXvPctTza2z2LFWUgA3bhcDt4hf4
	kjWrXZARqI0d1YvvIcpJxsxaBSeZ8pPNMuH815nS5u3d0kgSz71co+5Mg9aVe0n6CbIqRA
	4TecOUWugWTCcZ25rnXSY1s1j1Fl4NGT4vofO/oHHCI4zZiTDhOQEcdbaeFxhu8nXAEqk+
	MH06NK5hGrYJ6dnQ6pVdOKxGqzaBIWEbXnMYw08wPjSj4/GVhQHaFL4ashOA3pknIpglDw
	P24F55uilVkXQrou8p1rQRJszBwcblcFo2nAuzlRF9vSvG4UHOf9a6xbbk/gNQ==
From: "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
Subject: [PATCH bpf-next 0/3] selftests/bpf: tc_links/tc_opts: Unserialize
 tests
Date: Mon, 17 Feb 2025 13:37:37 +0100
Message-Id: <20250217-tc_links-v1-0-27f7965e3dcd@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJEts2cC/x3MWwqAIBBA0a3IfCeYvdtKRKSNNRQWGhGIe0/6P
 HC5ATw6Qg89C+DwIU+nTcgzBnqb7YqclmSQQlYily2/9XSQ3T1f2q6cZaEaUReQ8suhofdfDaA
 uwy2+N4wxfsCbhjdkAAAA
X-Change-ID: 20250128-tc_links-d894a23b7063
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Alexis Lothore <alexis.lothore@bootlin.com>, bpf@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
X-Mailer: b4 0.14.2
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdehkeegvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffufffkgggtgffvvefosehtjeertdertdejnecuhfhrohhmpedfuegrshhtihgvnhcuvehurhhuthgthhgvthculdgvuefrhfcuhfhouhhnuggrthhiohhnmddfuceosggrshhtihgvnhdrtghurhhuthgthhgvthessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepkedtkefgtedtgeekhfdujeevfefhvdetgfduudeifedvhfdvgfefteehhfdvvefhnecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopegludelvddrudeikedrtddrudegngdpmhgrihhlfhhrohhmpegsrghsthhivghnrdgtuhhruhhttghhvghtsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvtddprhgtphhtthhopehshhhurghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehsohhngheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghstheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhohhhnrdhfrghsthgrsggvnhgusehgmhgrihhlrdgtohhmpdhrtghpthhtoheprghnughrihhis
 ehkvghrnhgvlhdrohhrghdprhgtphhtthhopehsughfsehfohhmihgthhgvvhdrmhgvpdhrtghpthhtohephihonhhghhhonhhgrdhsohhngheslhhinhhugidruggvvhdprhgtphhtthhopegvugguhiiikeejsehgmhgrihhlrdgtohhm
X-GND-Sasl: bastien.curutchet@bootlin.com

Hi all,

Both tc_links.c and tc_opts.c do their tests on the loopback interface.
It prevents from parallelizing their executions.

Use namespaces and the new append_tid() helper to allow this
parallelization.

Signed-off-by: Bastien Curutchet (eBPF Foundation) <bastien.curutchet@bootlin.com>
---
Bastien Curutchet (eBPF Foundation) (3):
      selftests/bpf: tc_helpers: Add create_and_open_tid_ns()
      selftests/bpf: tc_link/tc_opts: Use unique namespace
      selftests/bpf: tc_links/tc_opts: Serialize tests

 .../testing/selftests/bpf/prog_tests/tc_helpers.h  |  12 ++
 tools/testing/selftests/bpf/prog_tests/tc_links.c  | 164 +++++++++++++--
 tools/testing/selftests/bpf/prog_tests/tc_opts.c   | 230 ++++++++++++++++++---
 3 files changed, 361 insertions(+), 45 deletions(-)
---
base-commit: cfed0f474a4bb2f12b54de5d6a7301cfb7dc0dbd
change-id: 20250128-tc_links-d894a23b7063

Best regards,
-- 
Bastien Curutchet (eBPF Foundation) <bastien.curutchet@bootlin.com>


