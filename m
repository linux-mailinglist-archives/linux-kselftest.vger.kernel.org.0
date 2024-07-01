Return-Path: <linux-kselftest+bounces-12980-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6297D91D505
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Jul 2024 02:15:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C72E2281391
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Jul 2024 00:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ECE5770F1;
	Mon,  1 Jul 2024 00:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hTAEwsav"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EFC06FBF;
	Mon,  1 Jul 2024 00:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719792762; cv=none; b=KTKYnv9COQCL4e6SPVlIwzcQoU+wYzakZZJLwG5T06Vl+ZcexTEKr1wW5kRDhDfUQlqsKOfeBQrFfoHEPmVay6JGmrHRXe4groVpRl+n5zBwZGCA8OIQdC7DscSYYfq2BVWQka7M48vdnDctil7wiMZZ4Yl0tzUbQuObO8JfvBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719792762; c=relaxed/simple;
	bh=p3EN7FK246yZq7ZJYoFjN4WYgTILLsYkYVjtqauABbM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YZOVfTDGtV9DDlUZpanENOGHtrVEFdqq7R7VWsZ2MafoScgu9n46Yh2a9ioUI74CMpwHa3ZTeO67L5ATAe/YGBTXgjQC9UqbKM1uVAtLik17xUdtL9YHAXwRySZvyqw8LVIHe62K5EXhBBSi/E3PbimZvfimeDAr7R54cS7Pzsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hTAEwsav; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CCA5C4AF0A;
	Mon,  1 Jul 2024 00:12:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719792762;
	bh=p3EN7FK246yZq7ZJYoFjN4WYgTILLsYkYVjtqauABbM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hTAEwsavgG/gsCVGAjZbwTPxClHrSJETOO3/dBPro1RAYB++T8fFZZnpI13OjF4Jt
	 HQYojLCCl06WPmUqDKZe20gumFNES/rHs9QaoE1iOBF9mq6J72vDdfOTvgks1EACT0
	 XMHPRP2zhQbGpp77kvsbEmAYtw4zMD7FsixzAJk/ZTBIUytA19rNhumdQJSg/C0tmb
	 WzBua/Q6uQyWv7QW7eLbjF6WKIKl6RMzl+eWjZX8rhcps3UIItNV9nmCYQT0yD4PY1
	 Gjx/8w7BkK4PSGF4BwWd8wNTmA0pYK5xtObUIC8Igx65JV+MKbsGQpT1zW5liDKs4C
	 uZdtDBa8Dcy9w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Adrian Moreno <amorenoz@redhat.com>,
	Aaron Conole <aconole@redhat.com>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>,
	pshelar@ovn.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	shuah@kernel.org,
	netdev@vger.kernel.org,
	dev@openvswitch.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH AUTOSEL 6.9 13/20] selftests: openvswitch: Set value to nla flags.
Date: Sun, 30 Jun 2024 20:11:18 -0400
Message-ID: <20240701001209.2920293-13-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240701001209.2920293-1-sashal@kernel.org>
References: <20240701001209.2920293-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.9.7
Content-Transfer-Encoding: 8bit

From: Adrian Moreno <amorenoz@redhat.com>

[ Upstream commit a8763466669d21b570b26160d0a5e0a2ee529d22 ]

Netlink flags, although they don't have payload at the netlink level,
are represented as having "True" as value in pyroute2.

Without it, trying to add a flow with a flag-type action (e.g: pop_vlan)
fails with the following traceback:

Traceback (most recent call last):
  File "[...]/ovs-dpctl.py", line 2498, in <module>
    sys.exit(main(sys.argv))
             ^^^^^^^^^^^^^^
  File "[...]/ovs-dpctl.py", line 2487, in main
    ovsflow.add_flow(rep["dpifindex"], flow)
  File "[...]/ovs-dpctl.py", line 2136, in add_flow
    reply = self.nlm_request(
            ^^^^^^^^^^^^^^^^^
  File "[...]/pyroute2/netlink/nlsocket.py", line 822, in nlm_request
    return tuple(self._genlm_request(*argv, **kwarg))
                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "[...]/pyroute2/netlink/generic/__init__.py", line 126, in
nlm_request
    return tuple(super().nlm_request(*argv, **kwarg))
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "[...]/pyroute2/netlink/nlsocket.py", line 1124, in nlm_request
    self.put(msg, msg_type, msg_flags, msg_seq=msg_seq)
  File "[...]/pyroute2/netlink/nlsocket.py", line 389, in put
    self.sendto_gate(msg, addr)
  File "[...]/pyroute2/netlink/nlsocket.py", line 1056, in sendto_gate
    msg.encode()
  File "[...]/pyroute2/netlink/__init__.py", line 1245, in encode
    offset = self.encode_nlas(offset)
             ^^^^^^^^^^^^^^^^^^^^^^^^
  File "[...]/pyroute2/netlink/__init__.py", line 1560, in encode_nlas
    nla_instance.setvalue(cell[1])
  File "[...]/pyroute2/netlink/__init__.py", line 1265, in setvalue
    nlv.setvalue(nla_tuple[1])
                 ~~~~~~~~~^^^
IndexError: list index out of range

Signed-off-by: Adrian Moreno <amorenoz@redhat.com>
Acked-by: Aaron Conole <aconole@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/net/openvswitch/ovs-dpctl.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
index 5e0e539a323d5..8b120718768ec 100644
--- a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
+++ b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
@@ -531,7 +531,7 @@ class ovsactions(nla):
             for flat_act in parse_flat_map:
                 if parse_starts_block(actstr, flat_act[0], False):
                     actstr = actstr[len(flat_act[0]):]
-                    self["attrs"].append([flat_act[1]])
+                    self["attrs"].append([flat_act[1], True])
                     actstr = actstr[strspn(actstr, ", ") :]
                     parsed = True
 
-- 
2.43.0


