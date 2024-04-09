Return-Path: <linux-kselftest+bounces-7457-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BCB3D89D0DC
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Apr 2024 05:17:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D67D1F25642
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Apr 2024 03:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5AE9548E9;
	Tue,  9 Apr 2024 03:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IGdJwqv8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 895AB142E69;
	Tue,  9 Apr 2024 03:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712632617; cv=none; b=R1Awa/qjy+ySTOL6WEiMZAV5Ogwu5Yo7g6/L3sqjeQxZZUmie/HireBIBJOYSLyi+YbfKPI1ePvMiJx4LWmGKspahNNrHdFWt0U6pqCA6/vuNYRvZFJbujL2EsURbB3gjDA6m1UGEAK7VTIHxbxql6ZZUFPZdvCrmRrn3RPdLds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712632617; c=relaxed/simple;
	bh=OhctB5+obPobGX9q0/inLddJqS1lntq9/UGjOm+23AQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Tfwn1c/oMO0V6+A4JEPecaVCiDn4/W0qFEvdyblsFv9HLYs2TpnIs+MBSLjfSBUEMCcxBenrPeRKgRrHUQuSlC1cfBmIU9ySnc+kOQ1NGzt37QzWcaCbYY5yemVs/FaGadcj5QFinx0/gqAbnhNlEyC4o8MgjBycIE/i46tRBYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IGdJwqv8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DEDAC433F1;
	Tue,  9 Apr 2024 03:16:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712632617;
	bh=OhctB5+obPobGX9q0/inLddJqS1lntq9/UGjOm+23AQ=;
	h=From:To:Cc:Subject:Date:From;
	b=IGdJwqv8BwaNSi1aBYq3OAmAt+ezW6w9q9yOeQSs7EK+lancdG2i5kQjmRVxm7vOP
	 YdPiXD5f/SBREkUkS1lKDeEekZdwBjl6Zhs9zj5vFK/r/opY6Rt1GzBjNCbvZao+8o
	 jiKvwziN7AdrSrEBGK64AHwaNA58Rijqk2yyt114R4ukgdF2V9NBM3I7b8Yc/+uEPe
	 ivE0PPuzDrJsD15rQjqlSQI477nf8e5SAc2lMtNu+bevz5oLklZr/Hz/zUItiroMPR
	 95umydLu+IuU6ZQwTlzT+0XEU/YDFh233JnMSOrbgJTkrlMfA18D1C80SUtp/PR5tf
	 fo5nwTO7/xjVg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	bpf@vger.kernel.org,
	andrii@kernel.org,
	mykolal@fb.com,
	eddyz87@gmail.com,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 0/4] selftests: move bpf-offload test from bpf to net
Date: Mon,  8 Apr 2024 20:15:45 -0700
Message-ID: <20240409031549.3531084-1-kuba@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The test_offload.py test fits in networking and bpf equally
well. We started adding more Python tests in networking
and some of the code in test_offload.py can be reused,
so move it to networking. Looks like it bit rotted over
time and some fixes are needed.

Admittedly more code could be extracted but I only had
the time for a minor cleanup :(

Jakub Kicinski (4):
  selftests: move bpf-offload test from bpf to net
  selftests: net: bpf_offload: wait for maps
  selftests: net: declare section names for bpf_offload
  selftests: net: reuse common code in bpf_offload

 tools/testing/selftests/bpf/Makefile          |   1 -
 tools/testing/selftests/net/Makefile          |  11 +-
 .../test_offload.py => net/bpf_offload.py}    | 138 +++++-------------
 tools/testing/selftests/net/lib/py/nsim.py    |   9 +-
 .../sample_map_ret0.bpf.c}                    |   2 +-
 .../sample_ret0.c => net/sample_ret0.bpf.c}   |   3 +
 6 files changed, 57 insertions(+), 107 deletions(-)
 rename tools/testing/selftests/{bpf/test_offload.py => net/bpf_offload.py} (93%)
 rename tools/testing/selftests/{bpf/progs/sample_map_ret0.c => net/sample_map_ret0.bpf.c} (96%)
 rename tools/testing/selftests/{bpf/progs/sample_ret0.c => net/sample_ret0.bpf.c} (70%)

-- 
2.44.0


