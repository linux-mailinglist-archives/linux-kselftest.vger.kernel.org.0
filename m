Return-Path: <linux-kselftest+bounces-16333-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A809995FA51
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Aug 2024 22:03:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DB911F21CF4
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Aug 2024 20:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B6BD1991B8;
	Mon, 26 Aug 2024 20:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QGL/Rqz8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7348D14AD0C;
	Mon, 26 Aug 2024 20:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724702624; cv=none; b=rIXW4ajlhZBYzv2iVu42hL2o2soGHQjqEMZfs9PnhfQxYpjvgXmqm5TRLT54+Ub9Y5SN4t9LlNZ07pDt5AIkCJq0A71KJFtyLB7dHpet2Wd4Ftb3TtyuEkjgKNTAIDHrrzkKpkKTdxd+JPR5BhI4l6jNMtjX0dEPjIRhvEl3Oqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724702624; c=relaxed/simple;
	bh=mZbD9wckRztGFvzf5HK4Mk+YDJQvY1Q1XU8YS/2+TOQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V4WbsCAkt14AkazuTAlTfSGcO6JesDeB4m9slOSH1ZhpmPEVCzr2DAI0dfv7/OG9oOG+/08utP7ZcRLP2XKyKuxbrtHESrWJCXr/WmlNlQ67ZxuQM6qt9rfqic2d1F2/7+isvsX8tAOHMKcMoqWfGplodz8aYoNjm1VAEz3Xx00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QGL/Rqz8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E78EAC4FEA5;
	Mon, 26 Aug 2024 20:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724702624;
	bh=mZbD9wckRztGFvzf5HK4Mk+YDJQvY1Q1XU8YS/2+TOQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QGL/Rqz8nCiEw35QFTeBq6qelY9osjM4CBUiZW9LnRqa6/+0vJMyTRyb5jhWpwUBi
	 H5kFNyycCDHDdo1TQGCdvbqoXmXvN5disyYY3szWVDo7DBOvxxm8lLlMJVfk3E1/AY
	 J1Cxl60QEAMclAD2bBU1VTc7SkxwelneUh5RMPgUxfO17ktObBVLvUcgd70jP9D1/C
	 Qe5xgQJruCwz218dqGVKzvfPR4i0Y8isHjKq3kEIDtUoVeR/stQcf18h/ET4IkSk29
	 oLY0ldTYo+181VYAprYL5czbLVCcL6ngYf85ZHWLuY4V+FiKu2mBbmzhVwDAfGFx1Z
	 2FlfmcIdr04dA==
Date: Mon, 26 Aug 2024 13:03:43 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Petr Machata <petrm@nvidia.com>
Cc: Ido Schimmel <idosch@nvidia.com>, Shuah Khan <shuah@kernel.org>,
 <linux-kselftest@vger.kernel.org>, <netdev@vger.kernel.org>, Amit Cohen
 <amcohen@nvidia.com>, Benjamin Poirier <bpoirier@nvidia.com>, Hangbin Liu
 <liuhangbin@gmail.com>, Vladimir Oltean <vladimir.oltean@nxp.com>,
 <mlxsw@nvidia.com>
Subject: Re: [RFC PATCH net-next 1/5] selftests: forwarding: Introduce
 deferred commands
Message-ID: <20240826130343.582d68dc@kernel.org>
In-Reply-To: <87wmk38ieu.fsf@nvidia.com>
References: <cover.1724324945.git.petrm@nvidia.com>
	<d5f8364b42f277daa9e235d23398e3dce5549e92.1724324945.git.petrm@nvidia.com>
	<Zsxai0ACHxfbwH-t@shredder.mtl.com>
	<87wmk38ieu.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 26 Aug 2024 16:25:47 +0200 Petr Machata wrote:
> >>  tools/testing/selftests/net/forwarding/lib.sh | 83 +++++++++++++++++++  
> >
> > Does it make sense to place these helpers in net/lib.sh?  
> 
> Yeah, it does.

Would it further make sense to split them to their own file
(net/lib_defer.sh?) and source that in net/lib.sh?

Should be pretty self-contained.

