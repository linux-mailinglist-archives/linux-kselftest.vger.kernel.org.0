Return-Path: <linux-kselftest+bounces-7474-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2781B89D75B
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Apr 2024 12:57:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 597DF1C224A4
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Apr 2024 10:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79BC483A07;
	Tue,  9 Apr 2024 10:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AoTBGBya"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B59A55E55;
	Tue,  9 Apr 2024 10:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712660255; cv=none; b=Mco3QoxLAlVZUO9pfkDMEZgqRyUZjsSEIEqnpo7bGzj87WBpvcwnoOn9trVHIPIve5sFSmCIXQa+Ti569FxKeoe0AwhMNTWAq9ckO3owsu3364/KwsrdTdpGD7qw6jMTqRYIqadH1J2AkI4g1cHz5aIsg31ysVvnx2nZsPBxe4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712660255; c=relaxed/simple;
	bh=XHWzoZ555HXHOQXCvCNj2YAGuzpHDijDHi5pEG5xAGg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AZyn7R5LSUFkWhOD2EejIT7EF3LeC11xLIWbcHBZUmKyTw0hDKrRrA/5Oe1UgObBFx4yWPOINDlb+K06smMPQI3kkgrawHMxrJXQG8xNyPPWQoRAmRMd844mzJnC7/KjRZQx5JW2ynNT3h5quYg+JrTyXT8+uoJae/L7njOYr/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AoTBGBya; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D027C433F1;
	Tue,  9 Apr 2024 10:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712660254;
	bh=XHWzoZ555HXHOQXCvCNj2YAGuzpHDijDHi5pEG5xAGg=;
	h=From:To:Cc:Subject:Date:From;
	b=AoTBGByaJ1NMAeKe+orDil07yqSFz1/c382E4mGTnnCATmGtUZFccp+Pi3cbe9Ont
	 Qgfk/RvkJD+Qp62ceXNs5tPiys3HO0CZIDhEmG9hw0bAmgm1WU3ICGUgeQNab0i962
	 uPeg9RLyzFo20mlRtPd4QxZ6C7YvJgHbvVBpTyVHiXGxsbkuAlhU4AMs66NtrvV7QN
	 FMGvOmi4+lnIyNr54p1Bbe/+eXOAT9kJuJrUIMZrVxvjeq05gFBeLoVZyPhpWWZgPQ
	 5EN5pcet7lb/Tdl9Rp3ivuZ99Wyzgm0l9Sc4uwYOagv0px+BM8w2gTYMu7xSxsgQt5
	 eioPvoU1HkqoA==
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
Subject: [PATCH bpf-next v3 0/4] export send_recv_data
Date: Tue,  9 Apr 2024 18:57:21 +0800
Message-Id: <cover.1712659575.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

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

Geliang Tang (4):
  selftests/bpf: Use log_err in network_helpers
  selftests/bpf: Add struct send_recv_arg
  selftests/bpf: Export send_recv_data helper
  selftests/bpf: Support nonblock for send_recv_data

 tools/testing/selftests/bpf/network_helpers.c | 125 +++++++++++++++++-
 tools/testing/selftests/bpf/network_helpers.h |   1 +
 .../selftests/bpf/prog_tests/bpf_tcp_ca.c     |  71 +---------
 3 files changed, 121 insertions(+), 76 deletions(-)

-- 
2.40.1


