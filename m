Return-Path: <linux-kselftest+bounces-13960-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37335938108
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Jul 2024 13:40:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A259C28135C
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Jul 2024 11:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F25B84FAC;
	Sat, 20 Jul 2024 11:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iAg0JJqx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F245CDE9;
	Sat, 20 Jul 2024 11:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721475641; cv=none; b=qBQionp6OPK9BnyUQQGqYgGROuZWAjW8z9gwqESvEGz52QLBaUbxSnusqWlWJp5nBcFdn2rF/il5Ql5kz9sMQ4sHe5fCQmpQIOAsvt3XPhPLefW28FUkA8wZzyskW4mH/611Np8R1i46KX0tQqsSt3N94RDQZrAo82V5qNc2/q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721475641; c=relaxed/simple;
	bh=P7Lo7k1CnCNjAsU/FjoZ+s0VwR3inhJjKnTNkqiDrNo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ECrM0WginB7GAN5S5MrVAN3BhAbPlp6fOUmUh+ixUq7m4EdPQfbf6Km4XD/L342A4/let9iq2qEtH8wvO1WwjiBRXSyZ59oa6Sx8bUSBQ/jtbTI/mGOTnQAvDcuOTWBy00bQPInbJGspivwVX8Vo6ftLs2CzEX4X4Phfy70AtX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iAg0JJqx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4D13C2BD10;
	Sat, 20 Jul 2024 11:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721475640;
	bh=P7Lo7k1CnCNjAsU/FjoZ+s0VwR3inhJjKnTNkqiDrNo=;
	h=From:To:Cc:Subject:Date:From;
	b=iAg0JJqx+cBh8w9VbXyW2W7kPfyy6ImvC7eLx7bWtmyhZt/i6hi8sT+rvyYogCDfH
	 ZduXYY77I3+qTJOK8hErfodDNcXQqT3+oCKWmrUP1+gxpdQdUd8G9JkPYibRDt540G
	 t0PNxeuYQWGvCWxTLUYTCA1IcIvsb2qT3nWJMSgchQ/J0QlbOpl9XYVwT1g6PRPTDT
	 jzhkxoNXrW5fMD6FDlUnuiwq8KY9xLAhWcdzekPgF9WC7JBzcf9BD5vOxg4HRjREW+
	 /uHOkMkmn1XVug4PFeczOHy0X8ap8eHfevr051VoM9jgx3+gf5QsCL8Nm7H1X7r1e9
	 IOHZBx/QyTTXw==
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
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next 0/4] use network helpers, part 10
Date: Sat, 20 Jul 2024 19:40:02 +0800
Message-ID: <cover.1721475357.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This set is part 10 of series "use network helpers" all BPF selftests
wide.

Patches 1-3 drop local functions make_client(), make_socket() and
inetaddr_len() in sk_lookup.c. Patch 4 drops a useless function
__start_server() in network_helpers.c.

Geliang Tang (4):
  selftests/bpf: Drop make_client in sk_lookup
  selftests/bpf: Drop make_socket in sk_lookup
  selftests/bpf: Drop inetaddr_len in sk_lookup
  selftests/bpf: Drop __start_server in network_helpers

 tools/testing/selftests/bpf/network_helpers.c |  26 ++---
 .../selftests/bpf/prog_tests/sk_lookup.c      | 110 +++++-------------
 2 files changed, 40 insertions(+), 96 deletions(-)

-- 
2.43.0


