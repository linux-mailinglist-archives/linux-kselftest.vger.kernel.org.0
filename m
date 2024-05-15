Return-Path: <linux-kselftest+bounces-10206-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3553C8C5E63
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 May 2024 02:43:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9EBA282859
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 May 2024 00:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 857C163C;
	Wed, 15 May 2024 00:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ui/MobDt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481A7803;
	Wed, 15 May 2024 00:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715733803; cv=none; b=ELZF/h5olnord9PRMtTc7lTyX+tgUC8eiyPrjWg+DAZwaxR/Zew+DS1ez0527sanZ1ka5+YFFrEbSLuA4MbQNbJcLrwkHrTP8OanwF1VqIt1E74vWJkAhL0RhALmAt7QfZAjCBIunVWvxZKTBvZ/11mWzBQglWsyRFmf98V6fxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715733803; c=relaxed/simple;
	bh=VFRhRLtJe6gMt3AlqSP3aSMrq7Sn300+2gW/3T3DoWw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=akD+J95Ng1xTmESYO0VM6M/D685mT8s85bmXvZT6A9IweDafTnBX7tafzXrURqas6pgAGpLnZR6oB6GOzRbjstZn2bZM4KUlaWaSPIi7jdPpm4GnrvIRHqGfr1jXWwFT4dJKp8LZ3oZSKylBDQLEFEDf8zvpOBu5/+QFf2MLCfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ui/MobDt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EE08C2BD10;
	Wed, 15 May 2024 00:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715733802;
	bh=VFRhRLtJe6gMt3AlqSP3aSMrq7Sn300+2gW/3T3DoWw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ui/MobDtbOufjX9M08OxOsgD6NGdGs0kz0A5jvU8NYmOoeUBycuzAOh73iuApvpvj
	 tAa42Rfcoe1AAs5zrdOqr7JJYQE1Ci67NuTR53mGEHRHtwTdPVLd+v2aUqwES1AxEZ
	 izix4+61CVhsYUnLc4fd48hQ8G34vyF82yHqGvrUkuFjlf3CF9jbRCYXB6+DCmUSX8
	 NqH2Mg5qZSQjzbv/RxXypMT6a23NQE0lhROd4en69oCnqVCQnHMhpTOSSi7diu0AzO
	 yWjSwFtjTfSjkTDY1lski2ECJWR/MsXTgDYA6V3qeRM5MTXSoBts+Zk78O99cZWID9
	 j0PkU1uOS7NWg==
Date: Tue, 14 May 2024 17:43:21 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Petr Machata <petrm@nvidia.com>
Cc: <davem@davemloft.net>, <netdev@vger.kernel.org>, <edumazet@google.com>,
 <pabeni@redhat.com>, <vladimir.oltean@nxp.com>, <shuah@kernel.org>,
 <liuhangbin@gmail.com>, <bpoirier@nvidia.com>,
 <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH net-next] selftests: net: local_termination: annotate
 the expected failures
Message-ID: <20240514174321.376039a5@kernel.org>
In-Reply-To: <875xvhu97r.fsf@nvidia.com>
References: <20240509235553.5740-1-kuba@kernel.org>
	<875xvhu97r.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 13 May 2024 15:25:38 +0200 Petr Machata wrote:
> For veth specifically there is xfail_on_veth:
> 
> xfail_on_veth $rcv_if_name \
> 	check_rcv $rcv_if_name "Unicast IPv4 to unknown MAC address" \
> 		  "$smac > $UNKNOWN_UC_ADDR1, ethertype IPv4 (0x0800)" \
> 		  false
> 
> Which is IMHO clearer than passing an extra boolean.

The extra boolean is because we want to only fail particular subcases.
I think that's legit. If the other cases regress we want to know.
Otherwise running the test on SW bridge is only useful for catching
crashes (so less useful).

So we probably need to reset FAIL_TO_XFAIL in this case.
Any preference on how to go about that? I'm tempted to:

diff --git a/tools/testing/selftests/net/forwarding/lib.sh
b/tools/testing/selftests/net/forwarding/lib.sh index
112c85c35092..79aa3c8bc288 100644 ---
a/tools/testing/selftests/net/forwarding/lib.sh +++
b/tools/testing/selftests/net/forwarding/lib.sh @@ -473,6 +473,13 @@
ret_set_ksft_status() # Whether FAILs should be interpreted as XFAILs.
Internal. FAIL_TO_XFAIL=
 
+# Clear internal failure tracking for the next test case
+begin_test()
+{
+    RET=0
+    FAIL_TO_XFAIL=
+}
+
 check_err()
 {
 	local err=$1
diff --git
a/tools/testing/selftests/net/forwarding/local_termination.sh
b/tools/testing/selftests/net/forwarding/local_termination.sh index
65694cdf2dbb..0781ceba1348 100755 ---
a/tools/testing/selftests/net/forwarding/local_termination.sh +++
b/tools/testing/selftests/net/forwarding/local_termination.sh @@ -76,7
+76,7 @@ check_rcv() local xfail_sw=$5 
 	[ $should_receive = true ] && should_fail=0 || should_fail=1
-	RET=0
+	begin_test
 
 	tcpdump_show $if_name | grep -q "$pattern"
 

> Not sure what to do about the bridge bit though. In principle the
> various xfail_on_'s can be chained, so e.g. this should work:
> 
> xfail_on_bridge $rcv_if_name \
> xfail_on_veth $rcv_if_name \
> 	check_rcv $rcv_if_name "Unicast IPv4 to unknown MAC address" \
> 		  "$smac > $UNKNOWN_UC_ADDR1, ethertype IPv4 (0x0800)" \
> 		  false
> 
> I find this preferable to adding these ad-hoc tweaks to each test
> individually. Maybe it would make sense to have:
> 
> xfail_on_kind $rcv_if_name veth bridge \
> 	check_rcv $rcv_if_name "Unicast IPv4 to unknown MAC address" \
> 		  "$smac > $UNKNOWN_UC_ADDR1, ethertype IPv4 (0x0800)" \
> 		  false
> 
> And then either replace the existing xfail_on_veth's (there are just a
> handful) or convert xfail_on_veth to a wrapper around xfail_on_kind.

I think the bridge thing we can workaround by just checking
if ${NETIFS[p1]} is veth, rather than $rcv_if_name.
Since the two behave the same.

