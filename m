Return-Path: <linux-kselftest+bounces-44631-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2B54C2A30E
	for <lists+linux-kselftest@lfdr.de>; Mon, 03 Nov 2025 07:32:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D70CD3AF86E
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Nov 2025 06:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 025F2296BBD;
	Mon,  3 Nov 2025 06:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Yw1bJVC+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E2EF286D56
	for <linux-kselftest@vger.kernel.org>; Mon,  3 Nov 2025 06:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762151547; cv=none; b=ElX3BY8JI5XTt8vvLMYHCHU0UerPRAQPMfQfKjEfqV7IXoeOBtsS7kdQvDzyx2tU/W/ACOtNuSCK7Tmz7H90fT0tlqZy/Hgqw4Qx38n4lZPzBTFDdqS7A7/LzJqHG9kF+sZhBtHBs7iKeKdy0+Qg7XiKdQvZrCMWL6DNsUNtoyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762151547; c=relaxed/simple;
	bh=otTY6ink45cvIho2B9gOhM00JPsjU95YMrNrMLHEoYk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Ogqe9XnJbXpMglswFgL7XpEFeP+pjjj/GFE6/SIrOrLgDiyIZfxyHFBpzpwUobMfkTmo7KrXc9QNOW9wDm63mmaAfitNh6MOEGZQr9+CcGz5PTG0OvmVOyb1GOidWgGBaXZrWxw0raYBYgSG8kETHXGPrJq9U6SFRrZ+sUmW2Is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Yw1bJVC+; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762151533;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=T5cEwxxSl6f5tkcOr38HBFAiwc+Jj7CNY1Z9St0dCSc=;
	b=Yw1bJVC+VZFsXHaxl3xai9EIwjPZSoDIHgPDXsgQSdR9pghdgt/urdhbH4I4uzdBVBm7Yf
	QxoHo2fZ6i6e3k2wSIZt4JIa1bXSiExYITiOe83iqpe0vyjNUINOE5ht3B6xTGf3T8Q1nj
	/FxysX2phKj8Q3IuFLw0udwH8SuYvzo=
From: KaFai Wan <kafai.wan@linux.dev>
To: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	shuah@kernel.org,
	paul.chaignon@gmail.com,
	m.shachnai@gmail.com,
	kafai.wan@linux.dev,
	harishankar.vishwanathan@gmail.com,
	colin.i.king@gmail.com,
	luis.gerhorst@fau.de,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v4 0/2] bpf: Skip bounds adjustment for conditional jumps on same scalar register
Date: Mon,  3 Nov 2025 14:31:06 +0800
Message-ID: <20251103063108.1111764-1-kafai.wan@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This small patchset is about avoid verifier bug warning when conditional
 jumps on same register when the register holds a scalar with range.

v4:
  - make code better. (Alexei) 

v3:
  https://lore.kernel.org/bpf/20251031154107.403054-1-kafai.wan@linux.dev/
  - Enhance is_scalar_branch_taken() to handle scalar case. (Eduard)
  - Update the selftest to cover all conditional jump opcodes. (Eduard)

v2:
  https://lore.kernel.org/bpf/20251025053017.2308823-1-kafai.wan@linux.dev/
 - Enhance is_branch_taken() and is_scalar_branch_taken() to handle
   branch direction computation for same register. (Eduard and Alexei)
 - Update the selftest.
 

v1:
  https://lore.kernel.org/bpf/20251022164457.1203756-1-kafai.wan@linux.dev/
---
KaFai Wan (2):
  bpf: Skip bounds adjustment for conditional jumps on same scalar
    register
  selftests/bpf: Add test for conditional jumps on same scalar register

 kernel/bpf/verifier.c                         |  31 ++++
 .../selftests/bpf/progs/verifier_bounds.c     | 154 ++++++++++++++++++
 2 files changed, 185 insertions(+)

-- 
2.43.0


