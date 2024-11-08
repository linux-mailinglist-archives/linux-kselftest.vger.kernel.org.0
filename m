Return-Path: <linux-kselftest+bounces-21697-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C1C09C2120
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Nov 2024 16:52:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4504B21F84
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Nov 2024 15:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C6E321B42A;
	Fri,  8 Nov 2024 15:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dVF2Mhej"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B501F4FA2;
	Fri,  8 Nov 2024 15:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731081160; cv=none; b=YOOpgWbAjbN9oar4QTnJUlJbCmderGvxQx9RypFXOMjoY50gVxNokesVFIgvF2WO1fcuTszgXXWjDZLgk82sL5i/Ev5rcba2FOrntZFYA+E9FLR9YjKLzWnY2KgIriVKhaaAa0woqrdfY9g+lY6V8Rz2JSTCZpVNKopUTErV8yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731081160; c=relaxed/simple;
	bh=sdc3Fgw7LkfomUsNgXiGHABPYcdaemtYhM218MhnbrY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=f00B+bRjBojFJqahoyH/SyIwi4dHAcfLlUCTVz5lTCz6XdRw0HMS+DU0MQo8TljoEsO6WtQezPTrJygdTQ7Y/HjbcG8A14/ebjQtnPuuRr61n8/nT5x+UrOu+R1h67CG+ggGMr7WEQOOsxTGXu14X6+zaXP4RMTjDUgy6briQXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dVF2Mhej; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C05CC4CECD;
	Fri,  8 Nov 2024 15:52:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731081159;
	bh=sdc3Fgw7LkfomUsNgXiGHABPYcdaemtYhM218MhnbrY=;
	h=From:Subject:Date:To:Cc:From;
	b=dVF2Mhej9QfKJ/9TEblk7mKwHVPMUW5pNv+8/P+uwnflxyDrpekEK9f0NKGO1H+70
	 qbSSOxeljRxCStyQXUEveLM6JtNjdVDKudn9BP3L28M+aDxEmhAKDHRVAvx4H0g/RQ
	 8I3UQpCmghcJ6WcEWDRYlSRvt8puLjEN2Sb9uvC4FSOKve3tX/npyndbxek9/FHAGm
	 /WzLrsdgNj6KNlbtqUApwKQRU1I/ZFyAYskSRlknhFZo+9fRm9tuh5m5u26NBIA0A3
	 Po0fnUIF2aI7C1IWDEuLtAkI5XAq4rutb9q4j6UpQL9/btld/qra/Cs9He1RhHQygm
	 Pcd9yL5b0EZUw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH bpf-next/net 0/5] bpf: Add mptcp_subflow bpf_iter support
Date: Fri, 08 Nov 2024 16:52:29 +0100
Message-Id: <20241108-bpf-next-net-mptcp-bpf_iter-subflows-v1-0-cf16953035c1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAL0zLmcC/zWNQQqDMBBFryKz7mASxEivUkqpOrEDbQyZtAri3
 TstuPnw/uK9DYQyk8C52iDTh4XnqGBPFQyPe5wIeVQGZ1xjremwTwEjrUWn4CuVIf2uGxfKKO8
 +POdF0Dgf2rHz3hsCVaVMgdd/5gKHoVYDXPf9CyjX0w2EAAAA
X-Change-ID: 20241108-bpf-next-net-mptcp-bpf_iter-subflows-027f6d87770e
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Martin KaFai Lau <martin.lau@kernel.org>, Geliang Tang <geliang@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2242; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=sdc3Fgw7LkfomUsNgXiGHABPYcdaemtYhM218MhnbrY=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnLjPBjZN5EcSfU/EHBM8jdcW35EZVVAxOqy/uh
 SkdhLSn2Z6JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZy4zwQAKCRD2t4JPQmmg
 c4AXD/0RQOk9yO9wBoSuoXMD6ZQOtQVE84dm9KfGvktTJN9GofrHZ9fIkNaFGS/raQl03Sgx0i/
 eZ08XnxOoPU9Fan3ENYo/ZIYUY3XVUCqcLpNQHWNJItqZkQSwvioOQwwhsKbHGF7ERtHVlqYSOf
 ekCGbR0hnn3jEJftTpkL8QvHK8UMGqibTSFAhFDvtzK46hJs7nKoQLE4LMly6EXwfLXG/ux16n7
 gcxBz3Bfk5m/tyDEegPZDd9w3LuhhTYhMei0XZVkhm5pttsiT08haPJAZGZgijWxKiQEf1ct8KT
 qmHfzR5x5S9QXhHON8or9MiQOpXZ1aASJqNfBh69hWdLpBTItFWOItnbP/1uUOtI3uQ48i+1/E2
 MK0ZpgL0f6TR6gOJ7YHNpTDXP6xiZiKPYM5pW1ki+rGj5uhWHgKAcZBRO+YUiuOHgbZ8IkGhnK+
 0kEo3dZnUliN88MyTnVPOU2zog+LhA1rZEgfj/n5iVUj7iiyfg6BV/gIfCBoMHPzY1P6JTRQSn+
 8xhcUaz4NvBxbXnQaiFFXYm9in9Ux54XjJJC+jkB2KqjZ95I2k3ccH4PemJ3rfkP8YWlAmfpUWi
 cR76WgeWJEId+LzlB6REOgpfR82ylDdizgii/yUb+K2g8ms3GU5JAza5Nf7qYOjTDtySmvBRDuf
 SqpK9WsgOeC2RXg==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Here is a series from Geliang, adding mptcp_subflow bpf_iter support.

We are working on extending MPTCP with BPF, e.g. to control the path
manager -- in charge of the creation, deletion, and announcements of
subflows (paths) -- and the packet scheduler -- in charge of selecting
which available path the next data will be sent to. These extensions
need to iterate over the list of subflows attached to an MPTCP
connection, and do some specific actions via some new kfunc that will be
added later on.

This preparation work is split in different patches:

- Patch 1: register some "basic" MPTCP kfunc.

- Patch 2: add mptcp_subflow bpf_iter support. Note that previous
           versions of this single patch have already been shared to the
           BPF mailing list. The changelog has been kept with a comment,
           but the version number has been reset to avoid confusions.

- Patch 3: add kfunc to make sure the msk is valid

- Patch 4: add more MPTCP endpoints in the selftests, in order to create
           more than 2 subflows.

- Patch 5: add a very simple test validating mptcp_subflow bpf_iter
           support. This test could be written without the new bpf_iter,
           but it is there only to make sure this specific feature works
           as expected.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Geliang Tang (5):
      bpf: Register mptcp common kfunc set
      bpf: Add mptcp_subflow bpf_iter
      bpf: Acquire and release mptcp socket
      selftests/bpf: More endpoints for endpoint_init
      selftests/bpf: Add mptcp_subflow bpf_iter subtest

 net/mptcp/bpf.c                                    | 104 ++++++++++++++++-
 tools/testing/selftests/bpf/bpf_experimental.h     |   8 ++
 tools/testing/selftests/bpf/prog_tests/mptcp.c     | 129 ++++++++++++++++++++-
 tools/testing/selftests/bpf/progs/mptcp_bpf.h      |  10 ++
 .../testing/selftests/bpf/progs/mptcp_bpf_iters.c  |  64 ++++++++++
 5 files changed, 308 insertions(+), 7 deletions(-)
---
base-commit: 141b4d6a8049cecdc8124f87e044b83a9e80730d
change-id: 20241108-bpf-next-net-mptcp-bpf_iter-subflows-027f6d87770e

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>


