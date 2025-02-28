Return-Path: <linux-kselftest+bounces-27907-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D5AAA49C2C
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 15:39:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 557C53A831F
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 14:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB04126FDB3;
	Fri, 28 Feb 2025 14:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ThEVMJpv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88BDD2686A0;
	Fri, 28 Feb 2025 14:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740753546; cv=none; b=eC43oZj5zxkIeaL4oruIT0pYKAnbt31ZlNbxjeV7I7OxTmaBqziAyt5IZZKo+A3prAXgp3AZYAMLgkNoGinh7eoo1iUrLG98Ynw+zbnMICCL7Sl+zJ5p5T5A1N9DC0JZ7pxIHzPSrGwu3788i4krR4ydGgvWoLhXDOHSUoNCTNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740753546; c=relaxed/simple;
	bh=LSZ43G3RguyR8JT13Yid9ixB8s/FRWLidQd9lifiub8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=i1gKnJFwRpSmc7PPlRixs1Vl791WK0RTNjTdWPwKS33If5UxK8UPKPTh5PfnLByvGNeqwzWCh2bJNDkBfl7yvA+djNraN2WWCh+dA3+CBpFhOJtZERg81ncMiseKJIzSYOrnlXUM+poKirVi9vSs5C9JiTgAwjaCgcH06Oc7TnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ThEVMJpv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33EEAC4CED6;
	Fri, 28 Feb 2025 14:39:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740753545;
	bh=LSZ43G3RguyR8JT13Yid9ixB8s/FRWLidQd9lifiub8=;
	h=From:Subject:Date:To:Cc:From;
	b=ThEVMJpvPz1h4Bnn8Ta0YAgpbhe40tCCl8a7+4tg1JOhTXTKfCEZU4hbHd25THMmz
	 8oMAaE6qF4jyHRKz0ljMlMJbH9S3fpjmVG6TtpWVbU7pfCAZngVTLJJwPy831SUyEI
	 1aRpqUdNV92JtJNX0PQ8xJpqT5IUszNfQbIABhqZV2QdrzNUcYGTofJWYvOPVXpBEB
	 FC7SyboLdhJu9Q6IxIAHVL4DwYNT3suVWhFGaiBNr0cIo8yNBPlZH0WNpCR4dzktar
	 Ub+Q0Z2BlqtrJBe2AJ+r7vpO/9uctNrilVs3p3/IyPoOdAbu6YZQnKIWc2+rJ6tc3x
	 nXnFI6D4hJyUQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH net-next 0/5] mptcp: improve code coverage and small
 optimisations
Date: Fri, 28 Feb 2025 15:38:34 +0100
Message-Id: <20250228-net-next-mptcp-coverage-small-opti-v1-0-f933c4275676@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGrKwWcC/zWNwQqDMBBEf0X27EJcKbX9leIhZLftgiYhCSKI/
 +5S6GEOD+bNHFClqFR4dgcU2bRqigZD30H4+vgRVDYGcnRzRBNGaZa94ZpbyBjSJsVbra5+WTD
 lpnh3PHEYeKQHgw3lIm/dfycv+Pswn+cFeIPC634AAAA=
X-Change-ID: 20250228-net-next-mptcp-coverage-small-opti-70d8dc1d329d
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Gang Yan <yangang@kylinos.cn>, Geliang Tang <geliang@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1407; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=LSZ43G3RguyR8JT13Yid9ixB8s/FRWLidQd9lifiub8=;
 b=owEBbAKT/ZANAwAIAfa3gk9CaaBzAcsmYgBnwcqFAlyzhVa9vJHyOS5n85FwY4QCgdzPROzqU
 aY3AB36xciJAjIEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ8HKhQAKCRD2t4JPQmmg
 c9ngD/dobU2167VR16CyPlajKR2shZJyNQJ9LTHUGKH/2ooDvYdjk2V/qKLtJnR6OL+HXjCb3+q
 FEMsRj+48xxy4mqcOlJ4uM3NC3NFHWHAaPr516Y9XRDbhluV0U6OMkcWhp5lU3pF/6SjJvHrjdb
 Q1xgbBX8ZMSMbDt0cPn0trbEesye9LSSjBJtQ7UZ71vtqOtc2oJxLqY67glV0s0wCLlw9rZgnNY
 WiR4ulW9S87XBhyAmXREEjmHo3z9X8bsAVjWC8AaRZ54tbf3ead1vubwinwNr8TO4P+KyvkLxi/
 Vh/kc9yQLUBIX7Yb+p7U1sjB6G/1+ATeE4poETwDJ/r18yLRStFLkRSmwy2MzV1G99KDGKjX3yd
 /8WoopSISCrNCW4IV8xE8q98eDtIMkQXjrX+PJmgc1mCjd3EitTiaQ9gyA9dNFX1mjqETXgf5QF
 EKdCsYRKqflMkSr8TPos+8HwEXWcb8BpP5Pne3PBibx/csrLu1PTGsP9pKv78dc/fvKe67vafAF
 eII2RDNIgg6WSbAC4mgUDqqDoTt4ztM+GZaQPnUXU4O4Z1W4Gb5DmVtZF1/h/Qaaei+lZrGd50F
 pwldfa64EIg5viDc/pKnwAS5sr+ayenHjq8ngjZUwDHK0ypBWnaHq/ScGp+PTfXhZ5OhNoyBw75
 fURSw3/Med34z
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

This small series have various unrelated patches:

- Patch 1 and 2: improve code coverage by validating mptcp_diag_dump_one
  thanks to a new tool displaying MPTCP info for a specific token.

- Patch 3: a fix for a commit which is only in net-next.

- Patch 4: reduce parameters for one in-kernel PM helper.

- Patch 5: exit early when processing an ADD_ADDR echo to avoid unneeded
  operations.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Gang Yan (2):
      selftests: mptcp: Add a tool to get specific msk_info
      selftests: mptcp: add a test for mptcp_diag_dump_one

Geliang Tang (2):
      mptcp: pm: in-kernel: avoid access entry without lock
      mptcp: pm: in-kernel: reduce parameters of set_flags

Matthieu Baerts (NGI0) (1):
      mptcp: pm: exit early with ADD_ADDR echo if possible

 net/mptcp/pm.c                                 |   3 +
 net/mptcp/pm_netlink.c                         |  15 +-
 tools/testing/selftests/net/mptcp/Makefile     |   2 +-
 tools/testing/selftests/net/mptcp/diag.sh      |  27 +++
 tools/testing/selftests/net/mptcp/mptcp_diag.c | 272 +++++++++++++++++++++++++
 5 files changed, 311 insertions(+), 8 deletions(-)
---
base-commit: 56794b5862c5a9aefcf2b703257c6fb93f76573e
change-id: 20250228-net-next-mptcp-coverage-small-opti-70d8dc1d329d

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>


