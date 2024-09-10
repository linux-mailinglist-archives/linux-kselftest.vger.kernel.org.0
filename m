Return-Path: <linux-kselftest+bounces-17649-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F0A9B97430B
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Sep 2024 21:07:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9D58289426
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Sep 2024 19:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27E1C1AB506;
	Tue, 10 Sep 2024 19:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RM2cMH04"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED8701AAE3F;
	Tue, 10 Sep 2024 19:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725995227; cv=none; b=WvSpF/vm13f9yRTDig5bYQYEer+OevbsLqMMhxtbbZ55libYqrvQTPo79bSSGkdynrh5vE8m8+xuQ9w1IgSWY+Tq3FCKMfptXqXGaHhDLDvs0sc/V/eDqlK95fRPgZWe/LTs3xe2Det8CZ5XShpf50G7/YmD2Rm1aXI8kjrk8GQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725995227; c=relaxed/simple;
	bh=qDdqHdcGxPDTj/mv2nTeJVub1oxQDtvYdII5/k1oFio=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MpplXgCETBeER5DljTK3jmITLEQHAS2BlvhXwchDxFP6fKJwHK4FP8VdBhMVrxlDyX8V2McfxzRS7xZuJOvA0FAxslK10Ov1bc+sHSbYGLDpmw4MIsukCjK4YEAo5sdWqRYDPumRvFMycOgk9vf76trUk7KxD3EHHp9n2vDOjc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RM2cMH04; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BDB1C4CEC4;
	Tue, 10 Sep 2024 19:07:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725995226;
	bh=qDdqHdcGxPDTj/mv2nTeJVub1oxQDtvYdII5/k1oFio=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=RM2cMH04h22dZOzYMS+2rS4ATooohzdO3/v5PoF0noLzA9SGei+MXiQ3VGUoKBDcT
	 Q2AVIfpLZn5UIaBB/rI1Ze0B20aSxgi6lL5n1DVgBxQw6WxphaDGNW/G9QEy8ZzPGQ
	 84QJ9HEcLkcR28Eh/FeKpEaYU5OMcz2j/yATqG3gNk0lstUSMvPKicnYHHP+PcirAH
	 bHLK3eesKp7JQQrBgSVj113SzpPLwshsViyK6gXsJMM4UzeLmnp5EAcyQyMgsduDl6
	 bocCTIJzv5pfjx5UoHMR3RUP+g0N610H/A1kPaYWmcKEkqGT5BaTAJt588tCMELB0b
	 O+og18JhXniqA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 10 Sep 2024 21:06:37 +0200
Subject: [PATCH net 2/3] selftests: mptcp: include lib.sh file
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240910-net-selftests-mptcp-fix-install-v1-2-8f124aa9156d@kernel.org>
References: <20240910-net-selftests-mptcp-fix-install-v1-0-8f124aa9156d@kernel.org>
In-Reply-To: <20240910-net-selftests-mptcp-fix-install-v1-0-8f124aa9156d@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1129; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=qDdqHdcGxPDTj/mv2nTeJVub1oxQDtvYdII5/k1oFio=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBm4JjRZQ24BZMu1h1QV0ZFxLUIY/bq73nziQz1G
 GMZAAiJHKSJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZuCY0QAKCRD2t4JPQmmg
 c35KD/9BUEvN905IXtVjRV2aziGXNRcfNcIk/UrdILqNuLyUMkz/Wgn6EjYV6366J7DrCst+fzT
 9L94X4Vd/NmKSGLvPOfFpOnZYocfxGaa4cFqkJ4fKHdgK6aKFpovVRg+wc32UvWZmm8SBR5e3Mw
 1BnBKl746BD8EArjD6k2h/VTngSHAZovxo/71JshFUgf1xlX57qkwJ35Aq/bd3PdAJOAb+Grrzv
 NBQvfJT3QHpHtyI4bOgsYj72dYBoln6qEdBvGx6qnY8wr3K+8MG12AQP0qaO3dS13nWz8vz55wy
 5XDUGfWI0tXE50lGdM83FVohDJUO9sft7jhGF+NkThYTvdxeVbnwbhdKwTgvz+qdjuw/e9Th1pA
 sM6v0mbWB4ufNt/6sFXHNoD/VFQJqKFGko4K4j2UG4tQ9SiCxl72uAOvt36qgZv3/GDQqbzpyPe
 BkrQFkXU56haWnj9+yLLvbr9fNLKfL6I5cr17MD//YAMRnZX9+PjYGSvXlFcg7h+gkAO58N6BXa
 84U0Cv3lM35i4iPDcqlkUNlPa7/7LWCG8BUrKmvdmeelWvpLMg9O9iq33gYSoyBQNnGbJHfgdhr
 vLiKZro1dbp/ZaWv0fPH37/fDadD/Vsatejr4fhGrqG5GDMKfPEc0FKgctjxxbNqosG4wI7oe4w
 o4RYKa3eVu17JHA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

The lib.sh file from the parent directory is used by the MPTCP selftests
and it needs to be present when running the tests.

This file then needs to be listed in the Makefile to be included when
exporting or installing the tests, e.g. with:

  make -C tools/testing/selftests \
          TARGETS=net/mptcp \
          install INSTALL_PATH=$KSFT_INSTALL_PATH

  cd $KSFT_INSTALL_PATH
  ./run_kselftest.sh -c net/mptcp

Fixes: f265d3119a29 ("selftests: mptcp: lib: use setup/cleanup_ns helpers")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/Makefile b/tools/testing/selftests/net/mptcp/Makefile
index 7b936a926859..68924053a1e6 100644
--- a/tools/testing/selftests/net/mptcp/Makefile
+++ b/tools/testing/selftests/net/mptcp/Makefile
@@ -11,6 +11,8 @@ TEST_GEN_FILES = mptcp_connect pm_nl_ctl mptcp_sockopt mptcp_inq
 
 TEST_FILES := mptcp_lib.sh settings
 
+TEST_INCLUDES := ../lib.sh
+
 EXTRA_CLEAN := *.pcap
 
 include ../../lib.mk

-- 
2.45.2


