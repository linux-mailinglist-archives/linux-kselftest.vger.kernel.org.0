Return-Path: <linux-kselftest+bounces-8790-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA6418B101D
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Apr 2024 18:44:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BBED1F2487D
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Apr 2024 16:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ADDC16C423;
	Wed, 24 Apr 2024 16:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t8N+WTXi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12C1613C672;
	Wed, 24 Apr 2024 16:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713977049; cv=none; b=Qo9j6lEbfp/xwexh6RLIFZgbUprcdLbA0ij00x2BCAIEDBSB9rvBXVXgEDCJc3YBisaRNzQtuHQvzbi1MZHR+0ax5tWZ2svXO1xEdsMbad4zTr+K/oMeOy3y3KFeFkyMqmVIvmL2yGLu+YakIckOXtWfYHQI5riBZo1lIwZ3Wtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713977049; c=relaxed/simple;
	bh=ou56p/+S5AFd1uQF8WgiDdiw3v5Mf5dIv88lwkk1SJs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Ufomg2a4udtyLU7OLaP42chAow9PIBjJ5nUYXoXvd85Y7FXFsT2FTfoHS1rzuX2X3cfxQru9nJNl8YuDl1roKy5vVpB/wwwfklGM1gyl4qnHkaXu0rZlbPBTzyQuG5FC2Gkm4ZCRUhi4gCmkjsAQkCEDi+Uj9iYdB5t+im2i7to=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t8N+WTXi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E04AC113CD;
	Wed, 24 Apr 2024 16:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713977048;
	bh=ou56p/+S5AFd1uQF8WgiDdiw3v5Mf5dIv88lwkk1SJs=;
	h=Date:From:To:Cc:Subject:From;
	b=t8N+WTXiWdG1MkCFhoCWPovS7BBzao6f0BGXSyS1W4I2xqA7lbzJ+FJFz/R8UGh2V
	 PTr7g94G3PKBbB6HVbraE791vq+w3/eySRvj8KwXsCFvpJV1GdnmKrtxNwxgyScMrQ
	 kGFY1Tt5tDj00E5PwXHGXXRbVqe3wEr06okKZJkiryK7gbuifjpok9FIhQ36aJz6E9
	 Lua2yRUfjRp8yDjgOI2jSYC3LYPpQnkljgPTtJxXAgBzhiihKf8MhbziTUNAXd1isn
	 16c7XYsgGzuCH5/Lrw7arRk5skKX7W9v+glyGSsdIKswjdNcRFgnIucUvy8zazw/2u
	 xhgXK9O9ZDOhg==
Date: Wed, 24 Apr 2024 17:44:05 +0100
From: Simon Horman <horms@kernel.org>
To: Aaron Conole <aconole@redhat.com>, Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, dev@openvswitch.org,
	linux-kselftest@vger.kernel.org
Subject: selftests: openvswitch: Questions about possible enhancements
Message-ID: <20240424164405.GN42092@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Aaron, Jakub, all,

I have recently been exercising the Open vSwitch kernel selftests,
using vng, something like this:

	TESTDIR="tools/testing/selftests/net/openvswitch"

        vng -v --run . --user root --cpus 2 \
                --overlay-rwdir "$PWD" -- \
                "modprobe openvswitch && \
		 echo \"timeout=90\" >> \"${TESTDIR}/settings\" && \
                 make -C \"$TESTDIR\" run_tests"

And I have some observations that I'd like to ask about.

1. Building the kernel using the following command does not
   build the openvswitch kernel module.

	vng -v --build \
		--config tools/testing/selftests/net/config

   All that seems to be missing is CONFIG_OPENVSWITCH=m
   and I am wondering what the best way of resolving this is.

   Perhaps I am doing something wrong.
   Or perhaps tools/testing/selftests/net/openvswitch/config
   should be created? If so, should it include (most of?) what is in
   tools/testing/selftests/net/config, or just CONFIG_OPENVSWITCH=m?

2. As per my example above, it seems that a modprobe openvswitch is
   required (if openvswitch is a module).

   Again, perhaps I am doing something wrong. But if not, should this be
   incorporated into tools/testing/selftests/net/openvswitch/openvswitch.sh
   or otherwise automated?

3. I have observed that the last test fails (yesterday, but not today!),
   because the namespace it tries to create already exists. I believe this
   is because it is pending deletion.

   My work-around is as follows:

 ovs_add_netns_and_veths () {
 	info "Adding netns attached: sbx:$1 dp:$2 {$3, $4, $5}"
+	for i in $(seq 10); do
+		ovs_sbx "$1" test -e "/var/run/netns/$3" || break
+		info "Namespace $3 still exists (attempt $i)"
+		ovs_sbx "$1" ip netns del "$3"
+		sleep "$i"
+	done
 	ovs_sbx "$1" ip netns add "$3" || return 1
 	on_exit "ovs_sbx $1 ip netns del $3"
 	ovs_sbx "$1" ip link add "$4" type veth peer name "$5" || return 1

   N.B.: the "netns del" part is probably not needed,
   but I'm not able to exercise it effectively right now.

   I am wondering if a loop like this is appropriate to add, perhaps also
   to namespace deletion. Or if it would be appropriate to port
   openvswitch.sh to use ./tools/testing/selftests/net/lib.sh, which I
   believe handles this.

4. I am observing timeouts whith the default value of 45s.
   Bumping this to 90s seems to help.
   Are there any objections to a patch to bump the timeout?

