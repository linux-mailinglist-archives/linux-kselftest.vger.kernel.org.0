Return-Path: <linux-kselftest+bounces-12034-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B52FD90A862
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Jun 2024 10:28:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57058284D3E
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Jun 2024 08:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F219D19046B;
	Mon, 17 Jun 2024 08:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kMvTYB8A"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9087187342;
	Mon, 17 Jun 2024 08:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718612919; cv=none; b=a4b2OsCHeaAfOOi3qtvVH0bUj+Etsq//fufqwtjD2gnnx3kpoHmfQrggd4pU6hIBLF7xBvtbgXhvhIDZhMXuVdINZYuSDkXuIM0QCxyHFiLT8ai+pYBfZ82vp7YUlnywB7NWhtAZywPNqOtHuUTA2sD6AI4VG2pI/OUsBbzHuHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718612919; c=relaxed/simple;
	bh=ByABHIgX/ho9/cT/uZjXBPibJy0YoUkL6nxvrr1uzjg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=hN4DJAAcxgLMgXtqlb4GDHN4iESidGM/3eU6aJEDE/Hnf3Y0OHtsr6doiq12KFUwWJVXfkCoElPKCcL0GWjneJrlVXEW0Xw4D65buz5d/VpHuPVllQfX2r2PuWiu851/zSSAdqDQTL2O9EwyIFvBlJ7W+Mm1wd/5h59sNqlKO9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kMvTYB8A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23D76C2BD10;
	Mon, 17 Jun 2024 08:28:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718612919;
	bh=ByABHIgX/ho9/cT/uZjXBPibJy0YoUkL6nxvrr1uzjg=;
	h=From:Date:Subject:To:Cc:From;
	b=kMvTYB8AMwNK3K8joduMysIumj/1naUwwAm+Z+TpIKCpubvP3WpZTv0b3XwLpWa80
	 cE2D4SNd3K1Vx+IkpHBtyOlJ7WyQhj0Yd8Uvvqo+ETe4ABDU83xfasl2TzB2z0jNy1
	 tpra7bGtRP2xkT0INaiTa67N7357H6ktdgH3zfd+O4NjxM8JAFdPr+5Du2Ef7hYr5W
	 MgCbtBi5xBC5B/NVnAFJgpf4FFB3lUaavP0cf75COAd/34XWbxOuHmt/7mEdbAgse8
	 /vyHyBH6jILwiVBvd2yO602DfGdP816l3gcqktRYYZiXZvvVWY5GGQd/Qfq1pcAUUj
	 OyXayJHzLTYHw==
From: Simon Horman <horms@kernel.org>
Date: Mon, 17 Jun 2024 09:28:33 +0100
Subject: [PATCH net] selftests: openvswitch: Use bash as interpreter
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240617-ovs-selftest-bash-v1-1-7ae6ccd3617b@kernel.org>
X-B4-Tracking: v=1; b=H4sIALDzb2YC/x3MMQqAMAxA0atIZgOmiIpXEYdWUw1IlaaIULy7x
 fEN/2dQjsIKY5Uh8i0qZyiguoJlt2FjlLUYTGPapqMez1tR+fCJNaGzuiMZct53ZNfBQemuyF6
 e/zlB4ATz+34XcRdmaAAAAA==
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: Aaron Conole <aconole@redhat.com>, Adrian Moreno <amorenoz@redhat.com>, 
 Pravin B Shelar <pshelar@ovn.org>, Shuah Khan <shuah@kernel.org>, 
 netdev@vger.kernel.org, dev@openvswitch.org, 
 linux-kselftest@vger.kernel.org
X-Mailer: b4 0.12.3

openvswitch.sh makes use of substitutions of the form ${ns:0:1}, to
obtain the first character of $ns. Empirically, this is works with bash
but not dash. When run with dash these evaluate to an empty string and
printing an error to stdout.

 # dash -c 'ns=client; echo "${ns:0:1}"' 2>error
 # cat error
 dash: 1: Bad substitution
 # bash -c 'ns=client; echo "${ns:0:1}"' 2>error
 c
 # cat error

This leads to tests that neither pass nor fail.
F.e.

 TEST: arp_ping                                                      [START]
 adding sandbox 'test_arp_ping'
 Adding DP/Bridge IF: sbx:test_arp_ping dp:arpping {, , }
 create namespaces
 ./openvswitch.sh: 282: eval: Bad substitution
 TEST: ct_connect_v4                                                 [START]
 adding sandbox 'test_ct_connect_v4'
 Adding DP/Bridge IF: sbx:test_ct_connect_v4 dp:ct4 {, , }
 ./openvswitch.sh: 322: eval: Bad substitution
 create namespaces

Resolve this by making openvswitch.sh a bash script.

Fixes: 918423fda910 ("selftests: openvswitch: add an initial flow programming case")
Signed-off-by: Simon Horman <horms@kernel.org>
---
 tools/testing/selftests/net/openvswitch/openvswitch.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/openvswitch/openvswitch.sh b/tools/testing/selftests/net/openvswitch/openvswitch.sh
index 5cae53543849..15bca0708717 100755
--- a/tools/testing/selftests/net/openvswitch/openvswitch.sh
+++ b/tools/testing/selftests/net/openvswitch/openvswitch.sh
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/bin/bash
 # SPDX-License-Identifier: GPL-2.0
 #
 # OVS kernel module self tests


