Return-Path: <linux-kselftest+bounces-34870-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1934FAD84B2
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Jun 2025 09:46:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86E6E1892088
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Jun 2025 07:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F6712F2C45;
	Fri, 13 Jun 2025 07:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="kbxOkqLB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8202F2ECEA4;
	Fri, 13 Jun 2025 07:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749800259; cv=none; b=OUFegeSyudUZ3cheypbr0wuG61UgurJAEi/1eg4zEXVbrS7hkS1vEpwVS8ymctToBPRwRloLYSVkhR3Pyl1pClrJFTyQWS8AGNn2TiHdr0KxXspwJAlFdJEySr/D+AmOwnM+1LLJkEWudlrA4ehVCo4ApYxdCkhgyn2FLsx/bpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749800259; c=relaxed/simple;
	bh=3XpS0uEyYaGnFNwFWsHdUwFaHYKDE5DLUYR9YOCDzdw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=XaN3xXaK3G/8XJajzPIbe8kNGA/XPoi+JWctzXcmCJMq6S2FBMdHbvPvIsqgd1xft/gA8IrRxZx+N645WzDHjn3uaeXeLHCznP/jlRRNib76umbXldDOT2l8Gd81WhBhasKhw0aNI6r8irG/2FcoeOxrXcCPOqHiNlWfnqt2HSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=kbxOkqLB; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 86F1944503;
	Fri, 13 Jun 2025 07:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1749800247;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=beEBVGnU6qU0wggmtWKWRNXrz1xxl7Gdx9jeDS6+tJk=;
	b=kbxOkqLBWMYw2LKAd/IW2RyGj/nP5qTDA3nQe30746ZNf401cfIfLbPiuY4UCGLIThgg52
	3SDjkKUlcjrkpsB7uie+NFd+q+khw4Qzg1V7FhH7kqzzDUETsK2pGbu4SLKi+3xHGZA5Px
	K8dourdAUK5hDgryw11qFf0uNWCLOjes5mH1frWPNr1onGZSx9hzPoBxJ8F4ePD6fSr9AO
	tPte1M9ivmGyxjku7Xi4XGOT8+ifFHjA0HhTgsLAKFka6UJZWMMHXlJDmbcy5ef57nUIR7
	33LybB/oSKZ4GDWXEWCuppTs2482C4hbZA/bJ1nk+is7e8e0Di4ud3snPwKt0Q==
From: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Subject: [PATCH bpf 0/7] bpf: deny trampoline attachment if args can not be
 located exactly on stack
Date: Fri, 13 Jun 2025 09:37:09 +0200
Message-Id: <20250613-deny_trampoline_structs_on_stack-v1-0-5be9211768c3@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIACXVS2gC/x2NQQrCMBAAv1L2bCANtKJfEQnJZquLugnZKErp3
 xu8zVxmVlCqTArnYYVKH1bO0mU8DID3IDcynLqDs26ysz2ZRPLzrYZXyU8W8trqG5v6LB0DPsw
 UIx4jOpvSCD1TKi38/S8uEMsC123bAYJUNa93AAAA
X-Change-ID: 20250609-deny_trampoline_structs_on_stack-5bbc7bc20dd1
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 David Ahern <dsahern@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
 "H. Peter Anvin" <hpa@zytor.com>, Menglong Dong <imagedong@tencent.com>, 
 =?utf-8?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn@kernel.org>, 
 Pu Lehui <pulehui@huawei.com>, Puranjay Mohan <puranjay@kernel.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Ilya Leoshkevich <iii@linux.ibm.com>, 
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>, Hari Bathini <hbathini@linux.ibm.com>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, 
 Naveen N Rao <naveen@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: ebpf@linuxfoundation.org, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, netdev@vger.kernel.org, 
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn@rivosinc.com>, 
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, linux-kselftest@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, 
 =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
X-Mailer: b4 0.14.2
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugddujeefjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffufffkgggtgffvvefosehtkeertdertdejnecuhfhrohhmpeetlhgvgihishcunfhothhhohhrroculdgvuefrhfcuhfhouhhnuggrthhiohhnmdcuoegrlhgvgihishdrlhhothhhohhrvgessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepheeuuefggeeiuedutdeghffhtefguefffeelledttdfgjeejueeggeeugfdugfevnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpsghoohhtlhhinhdrtghomhenucfkphepvdgrtddvmeekgedvkeemfhelgegtmegvtddtmeemfhekheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtvdemkeegvdekmehfleegtgemvgdttdemmehfkeehpdhhvghloheplgduledvrdduieekrddurdduleejngdpmhgrihhlfhhrohhmpegrlhgvgihishdrlhhothhhohhrvgessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepheekpdhrtghpthhtohepshhonhhgsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrghhorhguvggvvheslhhinhhugidrihgsmhdrtghomhdprhgtphhtthhopehlihhnuhigphhptgdquggvvhesl
 hhishhtshdrohiilhgrsghsrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhhsvghlfhhtvghsthesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhsthhmfedvsehsthdqmhguqdhmrghilhhmrghnrdhsthhorhhmrhgvphhlhidrtghomhdprhgtphhtthhopegrlhgvgigrnhgurhgvrdhtohhrghhuvgesfhhoshhsrdhsthdrtghomhdprhgtphhtthhopehmhihkohhlrghlsehfsgdrtghomhdprhgtphhtthhopehsvhgvnhhssehlihhnuhigrdhisghmrdgtohhm
X-GND-Sasl: alexis.lothore@bootlin.com

Hello,
this series follows some discussions started in [1] around bpf
trampolines limitations on specific cases. When a trampoline is
generated for a target function involving many arguments, it has to
properly find and save the arguments that has been passed through stack.
While this is doable with basic types (eg: scalars), it brings more
uncertainty when dealing with specific types like structs (many ABIs
allow to pass structures by value if they fit in a register or a pair of
registers). The issue is that those structures layout and location on
the stack can be altered (ie with attributes, like packed or
aligned(x)), and this kind of alteration is not encoded in dwarf or BTF,
making the trampolines clueless about the needed adjustments. Rather
than trying to support this specific case, as agreed in [2], this series
aims to properly deny it.

It targets all the architectures currently implementing
arch_prepare_bpf_trampoline (except aarch64, since it has been handled
while adding the support for many args):
- x86
- s390
- riscv
- powerpc

A small validation function is added in the JIT compiler for each of
those architectures, ensuring that no argument passed on stack is a
struct. If so, the trampoline creation is cancelled. Any check on args
already implemented in a JIT comp has been moved in this new function.
On top of that, it updates the tracing_struct_many_args test, which
now merely checks that this case is indeed denied.

[1] https://lore.kernel.org/bpf/20250411-many_args_arm64-v1-0-0a32fe72339e@bootlin.com/
[2] https://lore.kernel.org/bpf/CAADnVQKr3ftNt1uQVrXBE0a2o37ZYRo2PHqCoHUnw6PE5T2LoA@mail.gmail.com/

Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
---
Alexis Lothoré (eBPF Foundation) (7):
      bpf/x86: use define for max regs count used for arguments
      bpf/x86: prevent trampoline attachment when args location on stack is uncertain
      bpf/riscv: prevent trampoline attachment when args location on stack is uncertain
      bpf/s390: prevent trampoline attachment when args location on stack is uncertain
      bpf/powerpc64: use define for max regs count used for arguments
      bpf/powerpc64: prevent trampoline attachment when args location on stack is uncertain
      selftests/bpf: ensure that functions passing structs on stack can not be hooked

 arch/powerpc/net/bpf_jit_comp.c                    | 38 ++++++++++--
 arch/riscv/net/bpf_jit_comp64.c                    | 26 +++++++-
 arch/s390/net/bpf_jit_comp.c                       | 33 ++++++++--
 arch/x86/net/bpf_jit_comp.c                        | 50 ++++++++++++----
 .../selftests/bpf/prog_tests/tracing_struct.c      | 37 +-----------
 .../selftests/bpf/progs/tracing_struct_many_args.c | 70 ----------------------
 .../testing/selftests/bpf/test_kmods/bpf_testmod.c | 43 ++-----------
 7 files changed, 129 insertions(+), 168 deletions(-)
---
base-commit: c4f4f8da70044d8b28fccf73016b4119f3e2fd50
change-id: 20250609-deny_trampoline_structs_on_stack-5bbc7bc20dd1

Best regards,
-- 
Alexis Lothoré, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


