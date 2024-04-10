Return-Path: <linux-kselftest+bounces-7522-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B3CE89EA7F
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Apr 2024 08:14:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B62591F247CE
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Apr 2024 06:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 512AA288AE;
	Wed, 10 Apr 2024 06:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QpdXiBhq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 226A128F0;
	Wed, 10 Apr 2024 06:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712729627; cv=none; b=u6hJuEDZckDljSaWEjLyzf5J1SrIGPm4fm+BrQKVOzKYKjpWNQD1IonEazlL5Hn+ujoL178VgZ3M6I65A44zKNC5ATJNDKwykgrREjotAra4TkDGJJTUFm2KFVOlmHVPEHMvZf7phTeiwHt44A3ETxFqq+mYZd4qm7InmWtTjQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712729627; c=relaxed/simple;
	bh=Zz7kX5N/KT6moe6JlMKBOytWQlwcQXRc5BhzcQb5RJM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Zz6MI7+/s/Kyqa2mCQOl9J2OSITC/ryEF3h/q24GEPPhPrNh7hDRpkJubaLgVcvc7y1Qfv7bYCCMLVvqtO0Om0HIiitXBtQJ0vEJd6CrZ5R4yUv73O8RXOwIH8LO2y4UsuUQ7mAOi7HxWrFBmrm3QcL/qmrxh8EkwlQlMRqEW5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QpdXiBhq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25BB7C43390;
	Wed, 10 Apr 2024 06:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712729626;
	bh=Zz7kX5N/KT6moe6JlMKBOytWQlwcQXRc5BhzcQb5RJM=;
	h=From:To:Cc:Subject:Date:From;
	b=QpdXiBhqCurI15U6odM1USau4Uy5MvnA889b7pv1S1vWQYmgDcsNI6aB5A495uUTZ
	 JAXjNUngURrZvFNQEq6PUArp5BqGrfNThaptdMvT7r8YrsKtnKJWmT1PkD0Z47frGr
	 yL03G+vaU6t9T8OsmXVeEVAj8utzvxwFi2sGU1+3aMeCSBv9kBBwbaZlsINmAt9Ay7
	 2C7Dbtxqrb9FGzfcK8St5AkNbim3I6AhZsOES/k9qq3icaRuFpz/7jhrLaJEeY48mH
	 vFEb5Sl4Qq8TtwgmnM9ekVUrpmoxNOwnQNoVphmvg6rhXtFTID3L10NcvJ9TmutK2y
	 acuDBULpjSfHw==
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
	mptcp@lists.linux.dev,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v4 0/3] export send_recv_data
Date: Wed, 10 Apr 2024 14:13:28 +0800
Message-Id: <cover.1712729342.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

v4:
 - fix a bug in v3, it should be 'if (err)', not 'if (!err)'.
 - move "selftests/bpf: Use log_err in network_helpers" out of this
   series.

v3:
 - add two more patches.
 - use log_err instead of ASSERT in v3.
 - let send_recv_data return int as Martin suggested.

v2:

Address Martin's comments for v1 (thanks.)
 - drop patch 1, "export send_byte helper".
 - drop "WRITE_ONCE(arg.stop, 0)".
 - rebased.

send_recv_data will be re-used in MPTCP bpf tests, but not included
in this set because it depends on other patches that have not been
in the bpf-next yet. It will be sent as another set soon.

Geliang Tang (3):
  selftests/bpf: Add struct send_recv_arg
  selftests/bpf: Export send_recv_data helper
  selftests/bpf: Support nonblock for send_recv_data

 tools/testing/selftests/bpf/network_helpers.c | 103 ++++++++++++++++++
 tools/testing/selftests/bpf/network_helpers.h |   1 +
 .../selftests/bpf/prog_tests/bpf_tcp_ca.c     |  71 +-----------
 3 files changed, 105 insertions(+), 70 deletions(-)

-- 
2.40.1


