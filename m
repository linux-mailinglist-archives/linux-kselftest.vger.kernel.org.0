Return-Path: <linux-kselftest+bounces-27738-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B830A47F02
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2025 14:25:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C5D9188F121
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2025 13:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A6C522FDF2;
	Thu, 27 Feb 2025 13:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="VQMF8q3H"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D6922FAFD;
	Thu, 27 Feb 2025 13:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740662670; cv=none; b=ZVT2TBWTJt5qIrs4aU+B1pbRA9CR01ExvMXIPRFnuZJlAoHchHH6kvNNIIadpnyqmtosABCEC6RBzEOU9plqLcZHNdGrp6uRwQu1moV0wn6zzh/G+kaMYLIUs8wXQtUMM7Wlp/uMZwRwhJPgduMnoreTdJGASRQvZ/qzo978X4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740662670; c=relaxed/simple;
	bh=q78T31r8ZzsIZ6l2LVv9q89HNLhFvW4dCxCXOTAfIlg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Yekp5CQCdbsm6rI2BDwLVIhxsb20mqx5G2uZe9RXMQCs/m6qxivKjmAss/455eyzzRB3eVMXeq5K4JMsLdU+4w3jyWp+ozUYQTX7bDbRRVpjgc0Ht4sJ6+g1I2/vAQwfF+XGGdZlIZKWPD0V7a5B/drSZxq8yYsxBx3GJs/3LVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=VQMF8q3H; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 29EA8441D1;
	Thu, 27 Feb 2025 13:24:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1740662665;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ev6fUAp7eyoqQUZCt0Ye0W7Edj16g7jXZKrOMsCZZGg=;
	b=VQMF8q3HE+DIsj1Zg1fXthpCf00GO5tNsure50nQNxcZjft8eRwKR/YwLIWS2GRr2XsUq4
	SsmvOGdmsL2fHE9YbE+Cs1dxgSQx89mzJaKMpACDAnD2jB8zSynSqlgaVdC5uJDTkl8rX0
	aKUnYDsmHvQbS9YJ3NvX4L2mltEtaFqSCOEkYTOoF49/cXs9/aTd3+TrsT4he3ugFvDQ2Y
	657tIWMNIEuW2VcXg0oZaGOVH2+nbzwUIuL1W3a7T0LJjXy1EVp1RDVxvaRePMUVmYeSMy
	fuIH8mD0vFfiokG+f0ufImxjhRwzIEV4DoGbNSlmI/9spDPuEC4562AVF/NLVQ==
From: "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
Subject: [PATCH bpf-next 00/10] selftests/bpf: Migrate test_tunnel.sh to
 test_progs
Date: Thu, 27 Feb 2025 14:24:15 +0100
Message-Id: <20250227-tunnels-v1-0-33df5c30aa04@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAH9nwGcC/x3MSwqAMAwA0atI1hYaf6BXERetphqQKI2KIN7d4
 vLBMA8oRSaFLnsg0sXKmyRgnsG4OJnJ8JQMhS1qiyWa4xShVU3d+qZCcmVAC6neIwW+/1MPfg9
 G6D5geN8PNauVM2MAAAA=
X-Change-ID: 20250131-tunnels-59b641ea3f10
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekjeehkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffufffkgggtgffvvefosehtjeertdertdejnecuhfhrohhmpedfuegrshhtihgvnhcuvehurhhuthgthhgvthculdgvuefrhfcuhfhouhhnuggrthhiohhnmddfuceosggrshhtihgvnhdrtghurhhuthgthhgvthessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepkedtkefgtedtgeekhfdujeevfefhvdetgfduudeifedvhfdvgfefteehhfdvvefhnecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopegludelvddrudeikedrtddrudegngdpmhgrihhlfhhrohhmpegsrghsthhivghnrdgtuhhruhhttghhvghtsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvtddprhgtphhtthhopehkphhsihhnghhhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegvugguhiiikeejsehgmhgrihhlrdgtohhmpdhrtghpthhtohephhgrohhluhhosehgohhoghhlvgdrtghomhdprhgtphhtthhopegrnhgurhhiiheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqk
 hgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhohhhnrdhfrghsthgrsggvnhgusehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhhuhgrhheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghstheskhgvrhhnvghlrdhorhhg
X-GND-Sasl: bastien.curutchet@bootlin.com

Hi all,

This patch series continues the work to migrate the *.sh tests into
prog_tests framework.

The test_tunnel.sh script has already been partly migrated to
test_progs in prog_tests/test_tunnel.c so I add my work to it.

PATCH 1 & 2 create some helpers to avoid code duplication and ease the
migration in the following patches.
PATCH 3 to 9 migrate the tests of gre, ip6gre, erspan, ip6erspan,
geneve, ip6geneve and ip6tnl tunnels.
PATCH 10 removes test_tunnel.sh

Signed-off-by: Bastien Curutchet (eBPF Foundation) <bastien.curutchet@bootlin.com>
---
Bastien Curutchet (eBPF Foundation) (10):
      selftests/bpf: test_tunnel: Add generic_attach* helpers
      selftests/bpf: test_tunnel: Add ping helpers
      selftests/bpf: test_tunnel: Move gre tunnel test to test_progs
      selftests/bpf: test_tunnel: Move ip6gre tunnel test to test_progs
      selftests/bpf: test_tunnel: Move erspan tunnel tests to test_progs
      selftests/bpf: test_tunnel: Move ip6erspan tunnel test to test_progs
      selftests/bpf: test_tunnel: Move geneve tunnel test to test_progs
      selftests/bpf: test_tunnel: Move ip6geneve tunnel test to test_progs
      selftests/bpf: test_tunnel: Move ip6tnl tunnel tests to test_progs
      selftests/bpf: test_tunnel: Remove test_tunnel.sh

 tools/testing/selftests/bpf/Makefile               |   1 -
 .../testing/selftests/bpf/prog_tests/test_tunnel.c | 627 +++++++++++++++++---
 tools/testing/selftests/bpf/test_tunnel.sh         | 645 ---------------------
 3 files changed, 532 insertions(+), 741 deletions(-)
---
base-commit: 16566afa71143757b49fc4b2a331639f487d105a
change-id: 20250131-tunnels-59b641ea3f10

Best regards,
-- 
Bastien Curutchet (eBPF Foundation) <bastien.curutchet@bootlin.com>


