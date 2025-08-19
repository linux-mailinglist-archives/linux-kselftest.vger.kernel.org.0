Return-Path: <linux-kselftest+bounces-39271-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4625CB2B6B3
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Aug 2025 04:08:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CA263A6752
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Aug 2025 02:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FDBD274671;
	Tue, 19 Aug 2025 02:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="friyQYQ4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461EF1E98F3;
	Tue, 19 Aug 2025 02:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755569285; cv=none; b=tMSfC3P88VlC18xTXCX9eNtpijDArLq7zq43d0oHSCpIZDEJKIJ5k3Dn48FoqJezWLuzwGFI8FZa46g1rYFnEVvt7laV++eHtiMLL3dimoXi+svZd+kVBeTwd+Mc4xtj1W70khRCGeH7dmriNHWx/fFpdcgOI/rTEEN3y6tKbRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755569285; c=relaxed/simple;
	bh=M0bBEKCejlPniYhqQUOjYtCPHc37etNmkEhV/ot6cds=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ei5nYhjhowbg8H5qWbUFhV6a47E+tBZHScz2Y5imBkhpAPxbAt8VKNeEv0DJrZeQWSsTx8eIlH0wVy+eMih3O6a0sfnM4n3tN3d0xIN2cX/xQ7wfJSLq3Sxdrujfvn4VzucfEmeJkhLwz2FKb3rw7R0+DrDBlMe0wJD52xa1dxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=friyQYQ4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99A03C4CEEB;
	Tue, 19 Aug 2025 02:08:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755569284;
	bh=M0bBEKCejlPniYhqQUOjYtCPHc37etNmkEhV/ot6cds=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=friyQYQ4rPVU0IKY6q6UD1XKDn+hevn+E/OWnfCXsy/6l4E6uA2Xv6FcdpTwoJ4RW
	 ypGQK9l7BFCjQ6EPnrKmCU3a6Ht+g9FpmveckQsMmoIJZc3UEmrI5jzrr3XAaOrUeF
	 pmjFO3gdvA8AM/OsK5WZoiS1cHeOmEHegXc2SQL/JKb/cgHZeeaPDQDLEh0yz3kZFd
	 E7qgog2bqolKIH53gbJq7LOyVnrun9C1yy5EqyQUaFzWxog4e1zmLerBB4I1IU7h3d
	 Cvk30BOQ8E+T8IgrrlZRJIKYfgQQ77b/J9Q8z3O78jF3/9yE6C/S7wi1utqMhXn8eF
	 ajz2CgtHBV3GQ==
Date: Mon, 18 Aug 2025 19:08:03 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net] selftests: rtnetlink: fix addrlft test flakiness on
 power-saving systems
Message-ID: <20250818190803.19a43fae@kernel.org>
In-Reply-To: <aKPYe8t7kR_u7DZ7@fedora>
References: <20250715043459.110523-1-liuhangbin@gmail.com>
	<20250818183012.35f47956@kernel.org>
	<aKPYe8t7kR_u7DZ7@fedora>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 19 Aug 2025 01:50:51 +0000 Hangbin Liu wrote:
> Hmm, I think we need to know what's the current preferred_lft and valid_lft
> on failed test. Would you please add a debug line so we can get the info
> after failed?
> 
>         slowwait 5 check_addr_not_exist "$devdummy" "10.23.11."
>         if [ $? -eq 1 ]; then
> +               ip addr show dev "$devdummy"
>                 check_err 1
>                 end_test "FAIL: preferred_lft addresses remaining"
>                 return

Given that this is 2nd or 3rd time we're massaging this test case 
I think we should just add the appropriate debug information to the
test itself. Please post a real patch?

