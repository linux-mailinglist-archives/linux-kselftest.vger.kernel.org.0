Return-Path: <linux-kselftest+bounces-44510-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BD44C23FC5
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Oct 2025 10:03:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 77F2D4F2944
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Oct 2025 09:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32B1E32D44A;
	Fri, 31 Oct 2025 09:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="hUph6cor"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34CD932C938;
	Fri, 31 Oct 2025 09:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761901317; cv=none; b=tmxOD4oWahgsKkNNqf3AEmYjwUslkL/T09w2w6Q4xRdHFd+4ErgQgzrO0WLt6B7/7ZBBzwOhm0dBn1KePhtd163/lGtllVzH4kfCdRd/pCy3zL6SmdRuUEbHgDXnDTEIhhX5J219YXziZeuZZ8mdHKX+aRJmvJkOVAbqUJT4ndg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761901317; c=relaxed/simple;
	bh=O5itHnLTDcAl7kg5b+ivHplkojiYqTRRAtCF+sGH1mI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=XL/eZ/eMYAaOcy2wP61kg8Ub0+G9ERlUnLzD06yZ8oO7hiXT771QyigDsVLDsaZL+qB6nRLyBqdPbX8/RE6+jtmT6+wvNmaEJnSlalSCF3nPs/IRBxR8a7Qols68zS3giJcR/ECakr6xEkN/5Z1rNH2bArKcG5t4VUq07NVH3zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=hUph6cor; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 96A741A17A7;
	Fri, 31 Oct 2025 09:01:52 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 6B12560704;
	Fri, 31 Oct 2025 09:01:52 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 249A011810843;
	Fri, 31 Oct 2025 10:01:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761901311; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=7C6G3ro04Iqz2YzPn/lLXpMOd5QB91V65CxIuf8EN4I=;
	b=hUph6corzB0WA1dwRt5oKq5fKundl6bdXdzKiLgzrWAwB02vvFhTghkAnyCssf6sYXcBIv
	YgRuARpwnngLERrNPHW2cCtt5AnuWXcKQdEP+vCW/vr3Iupd3pze//H+8cqOC7P2CVPUgK
	ZXdti62qjQpjZMRbPb2uuCyV1soE7N+pi1IEqUJYtvK82xee6/zb6gNBdSWYhR6DgcHj6i
	6owm46o2QecQ/amGUt9BsEPCsutQ1ldm1fZjJb5VaeaZ+VaKp4frdANNwLyg9b6UE0N4Sq
	AjAkdJqMfsbSVODSSpR66VHI010GV0ZxwR6EOynnrxU6GVtxHisQkjKz/aA4mA==
From: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Subject: [PATCH bpf-next 0/3] selftests/bpf: small improvements on
 tc_tunnel
Date: Fri, 31 Oct 2025 10:01:40 +0100
Message-Id: <20251031-tc_tunnel_improv-v1-0-0ffe44d27eda@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAPR6BGkC/x3MQQqAIBBA0avErBPUSKirRETZWAM1iVoE0d2Tl
 m/x/wMRA2GEtngg4EWRDs5QZQF2HXlBQXM2aKlrJSspkh3SyYzbQLsPxyXM1MzKam2NM5AzH9D
 R/S87mLwTjHeC/n0/Ocn3JGwAAAA=
X-Change-ID: 20251030-tc_tunnel_improv-6b9d1c22c6f6
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: ebpf@linuxfoundation.org, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, bpf@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

Hello,
this series is a small follow-up to the test_tc_tunnel recent
integration, to address some small missing details raised during the
final review ([1]). This is mostly about adding some missing checks on
net namespaces management.

[1] https://lore.kernel.org/bpf/1ac9d14e-4250-480c-b863-410be78ac6c6@linux.dev/

Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
---
Alexis Lothoré (eBPF Foundation) (3):
      selftests/bpf: skip tc_tunnel subtest if its setup fails
      selftests/bpf: add checks in tc_tunnel when entering net namespaces
      selftests/bpf: use start_server_str rather than start_reuseport_server in tc_tunnel

 .../selftests/bpf/prog_tests/test_tc_tunnel.c      | 162 ++++++++++++++-------
 1 file changed, 107 insertions(+), 55 deletions(-)
---
base-commit: 1e2d874b04ba46a3b9fe6697097aa437641f4339
change-id: 20251030-tc_tunnel_improv-6b9d1c22c6f6

Best regards,
-- 
Alexis Lothoré, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


