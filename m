Return-Path: <linux-kselftest+bounces-27149-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF124A3F152
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Feb 2025 11:05:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEEFD17DDA9
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Feb 2025 10:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E514E204596;
	Fri, 21 Feb 2025 10:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="QJIvTzM+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D1391D6DDC;
	Fri, 21 Feb 2025 10:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740132309; cv=none; b=Wj3zsU8LUMpt1LXtK45xukR4fyCtn6eRE6U3y1AQVuXEhxn5BVwYOnFnfTIc90TmnihQdmO8GnoWFos/LzDe2qStajwWWejthhtNAXakEuaoPmHqTL4+jYOouEOiCzKWrLiasMWcyMiYwjjppCh7HvQhESTBeqMr3HIPoygwYPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740132309; c=relaxed/simple;
	bh=LD5Lhl1Q+KLHq2xv3l+SsRfVNOf4Q5JroCfGt9RJiOI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=U4Y+Our8K+ccQVd5qU19DpnapsPx1sCl0YFNqp8vlOOjwnkk7zCAoncQ24t+PWuaZgJUviIF66qjmS1nZZofByxhNTRT31TCj4yAuBuRwE5OpHT8Xf95spsjOkrqbJqNiHwHHd3G2liH4+HDQyOAS74Roxc4B/xBeIEmNFwyKOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=QJIvTzM+; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D7ADC4439E;
	Fri, 21 Feb 2025 10:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1740132300;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=9o77DNgMUQd4emSOMc0omKMZ7sD/eszdoHGQSaoXRJI=;
	b=QJIvTzM+G6gu/+bqs869VfAHqnZB53fGjm/HKF+/31QTi/1+RdxYlFLAQsmgG36J5W+SUc
	aqpijeoLOD764Dts6O+oIcV2kRSnMtItSUSi5ER1frY8KW81SHu7DNcZUTbrEuChIwRxt3
	NndqiOJFQPPncso4TQuvVrEJFVZKtKLzhWcSNMsrS0Dtw8flONJKOiiPbyVaR3XYsXKnT0
	MNLZ53qfVTazEh6C/oJBB3Un4xaw7zmSpPdReP8CVm7BHX07S8XRPPYWwgL5b0nLKTxqUb
	vxlBIAACtgIaeTAkOrRvyqva/mcc4WT/5Kw7G/cARALLRyPAfqk4u14TsRgKZw==
From: "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
Subject: [PATCH bpf-next 0/2] selftests/bpf: Migrate test_xdp_vlan.sh into
 test_progs
Date: Fri, 21 Feb 2025 11:04:56 +0100
Message-Id: <20250221-xdp_vlan-v1-0-7d29847169af@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMlPuGcC/x3MQQqAIBBA0avIrBPUCqKrRITpWANhoiGCdPek5
 YPPr5AwEiaYWYWImRLdvkF2DMyp/YGcbDMooUYhe8GLDVu+tOc4qdGYwTo5aGh5iOio/KsF9uC
 4x/LA+r4fuXeWwWQAAAA=
X-Change-ID: 20250130-xdp_vlan-e825cc4df14a
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
 Mykola Lysenko <mykolal@fb.com>, Martin KaFai Lau <martin.lau@linux.dev>, 
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, 
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
 Shuah Khan <shuah@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Alexis Lothore <alexis.lothore@bootlin.com>, netdev@vger.kernel.org, 
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
X-Mailer: b4 0.14.2
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeileejhecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffufffkgggtgffvvefosehtjeertdertdejnecuhfhrohhmpedfuegrshhtihgvnhcuvehurhhuthgthhgvthculdgvuefrhfcuhfhouhhnuggrthhiohhnmddfuceosggrshhtihgvnhdrtghurhhuthgthhgvthessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepkedtkefgtedtgeekhfdujeevfefhvdetgfduudeifedvhfdvgfefteehhfdvvefhnecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopegludelvddrudeikedrtddrudegngdpmhgrihhlfhhrohhmpegsrghsthhivghnrdgtuhhruhhttghhvghtsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvgedprhgtphhtthhopehsohhngheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhpshhinhhghheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgrrhhtihhnrdhlrghusehlihhnuhigrdguvghvpdhrtghpthhtohepshhhuhgrhheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvgguugihiiekj
 eesghhmrghilhdrtghomhdprhgtphhtthhopegsphhfsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhihkhholhgrlhesfhgsrdgtohhmpdhrtghpthhtoheprghstheskhgvrhhnvghlrdhorhhg
X-GND-Sasl: bastien.curutchet@bootlin.com

Hi all,

This patch series continues the work to migrate the script tests into
prog_tests.

test_xdp_vlan.sh tests the ability of an XDP program to modify the VLAN
ids on the fly. This isn't currently covered by an other test in the
test_progs framework so I add a new file prog_tests/xdp_vlan.c that does
the exact same tests (same network topology, same BPF programs) and
remove the script.

Signed-off-by: Bastien Curutchet (eBPF Foundation) <bastien.curutchet@bootlin.com>
---
Bastien Curutchet (eBPF Foundation) (2):
      selftests/bpf: test_xdp_vlan: Rename BPF sections
      selftests/bpf: Migrate test_xdp_vlan.sh into test_progs

 tools/testing/selftests/bpf/Makefile               |   4 +-
 tools/testing/selftests/bpf/prog_tests/xdp_vlan.c  | 175 ++++++++++++++++
 tools/testing/selftests/bpf/progs/test_xdp_vlan.c  |  20 +-
 tools/testing/selftests/bpf/test_xdp_vlan.sh       | 233 ---------------------
 .../selftests/bpf/test_xdp_vlan_mode_generic.sh    |   9 -
 .../selftests/bpf/test_xdp_vlan_mode_native.sh     |   9 -
 6 files changed, 186 insertions(+), 264 deletions(-)
---
base-commit: a814b9be27fb3c3f49343aee4b015b76f5875558
change-id: 20250130-xdp_vlan-e825cc4df14a

Best regards,
-- 
Bastien Curutchet (eBPF Foundation) <bastien.curutchet@bootlin.com>


