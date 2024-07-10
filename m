Return-Path: <linux-kselftest+bounces-13461-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2993892D25B
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Jul 2024 15:10:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3606282097
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Jul 2024 13:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD20619246D;
	Wed, 10 Jul 2024 13:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vIFfgaFa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3ACC18FDDB;
	Wed, 10 Jul 2024 13:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720617031; cv=none; b=QGp3fkSVUkB4vcS0Qewyuh5BkFUuM4xPilcl0KcT5p9mkVMNjyhloo7n2WtIxewBn+pZPItjOLCnrfJQBCn67S23dG74Pjs3f1nVUsu5CVqTS4NFSRPo4/0x9khnO4kZg4ah8He2J0rfX0EVy7cMwMAu3v/G1ntU6BQ+KX1or2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720617031; c=relaxed/simple;
	bh=5nIX8f+03OJ3l1bZ4QCcTPI/Cm1v27scAFX7mg85uQQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZCS3qvlh1CTY1MCF7uwOeOu64hm+MJeiD36S8Z/aUgPZWlPB6BRZkXRYqW8xUCS5b5HcXxaa7oqXL4weqDA6ZlG6FA/cLlHVl4HIsvGgfpJSTjue+90ZnQY6b2nBdk1sHKy0JWfLM0f6hTQgbOge0sYTGY62vOcKQ3RaQy2B6Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vIFfgaFa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB902C32781;
	Wed, 10 Jul 2024 13:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720617031;
	bh=5nIX8f+03OJ3l1bZ4QCcTPI/Cm1v27scAFX7mg85uQQ=;
	h=From:To:Cc:Subject:Date:From;
	b=vIFfgaFal6QpGa2NkGMfqeNMLu7CTYpr4nmEo1ADTtbh17A6LEAnRhrCvfjYko9En
	 cuEMMoScjh/iIOkXl2oiyikMR9UQuAMLWQWwkfxKwaNe1M+86VaMwEMDQz5uKiRmm0
	 QQIInmcT4dMaBtaax0+SxNhtMiGcN+XNIG8x+kDfrlXENrmSqLYgOXPrHkdJ/v2Mg7
	 wwv6A1fLfw+HxfjjNGMXnvAuRmiJbjAq/MFVUBPxuq3QrHAP88MUTBZO5O6C/3kXYQ
	 5xScEpZvYjpsxkawtfhm8MOHBXKnIdw5lLuzYduSSMfkaeHQm0Xh/JSo5NSiBNUqgS
	 zMJKRw81GVtxA==
From: Geliang Tang <geliang@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Mykola Lysenko <mykolal@fb.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v2 0/2] BPF selftests misc fixes
Date: Wed, 10 Jul 2024 21:10:15 +0800
Message-ID: <cover.1720615848.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

v2:
 - only check the first "link" (link_nl) in test_mixed_links().
 - Drop patch 2 in v1.

Resend patch 1 out of "skip ENOTSUPP BPF selftests" set as Eduard
suggested. Together with another fix for xdp_adjust_tail.

Geliang Tang (2):
  selftests/bpf: Null checks for links in bpf_tcp_ca
  selftests/bpf: Close obj in error path in xdp_adjust_tail

 .../selftests/bpf/prog_tests/bpf_tcp_ca.c        | 16 ++++++++++++----
 .../selftests/bpf/prog_tests/xdp_adjust_tail.c   |  2 +-
 2 files changed, 13 insertions(+), 5 deletions(-)

-- 
2.43.0


