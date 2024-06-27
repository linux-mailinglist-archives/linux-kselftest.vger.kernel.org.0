Return-Path: <linux-kselftest+bounces-12890-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 506B391B2C9
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Jun 2024 01:32:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DAF11C21AEF
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Jun 2024 23:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17A8D210E4;
	Thu, 27 Jun 2024 23:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PJL4YZlB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFEC1199E93;
	Thu, 27 Jun 2024 23:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719531154; cv=none; b=m7BGpS4acHpBZBh+CHyZI1G2ee1XdQYrN9LgHn8F9lIfOFOsfvyjbBHf0RZh7iibHfBSltI72IX+Hf/X2WESkSMSRigxuwq2atodCXa7Jw1Ev+wgyqrwN3jCJmV8mWD4xXANeVdeFKASrE2e14zZmNPPQIFOFjmC7F/F0EUBy48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719531154; c=relaxed/simple;
	bh=4kzXNwWo2EHiiSbt+rLI28KXowWz8U1l+u+WwoIRZjw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PVfG6t7hJ3qH8hrO6i9hKX/TtCbe+017Co2Bz0C7QGEg/WuApYG5wvgHYPIFwGFsvjWKmGg7Oytn2hy1cvr/NZdjsj4yYMU/rsVLzz12HgcK0f7Ug9AbvlXX+hjjbHdeP/zmIM55Si6heXZ7YagtiODRXUBLgkV0BfMqgShNLAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PJL4YZlB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 254A9C2BBFC;
	Thu, 27 Jun 2024 23:32:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719531153;
	bh=4kzXNwWo2EHiiSbt+rLI28KXowWz8U1l+u+WwoIRZjw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PJL4YZlB/EyVo/kD3oN81Xg9KTvXfFf4RrYwYtyFFM6jE7baV3gkoYTzTar71gy2J
	 TIayh4gGeyyrmpDTn9dnB6k373E2sB+YKojDs9Uk22zMetAdG63I7Z9rfUVf2t4AMW
	 8iqocCJznyKUA3r0sXRrmVS2aPUDw6E+3TtJ5CYuEfexBsUGD5fmxVMVKwey4tZtJZ
	 9u8HYP8fSExbiuxYIR3IOWF+xcEqqQGWhtTvlfGZO4Wz/rRzf+cELFMRSqnUASzbns
	 LhzB0nfIJ7o8APnEDTHoNwGP2BpZrU2bGR8MGC8NSFcu5JeVdvD0FuUO89D8RJgOJA
	 0TEy+bBXgte6w==
Date: Thu, 27 Jun 2024 16:32:32 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: allison.henderson@oracle.com
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 rds-devel@oss.oracle.com, linux-rdma@vger.kernel.org,
 oberpar@linux.ibm.com, chuck.lever@oracle.com, vegard.nossum@oracle.com
Subject: Re: [PATCH net-next v1 3/3] selftests: rds: add testing
 infrastructure
Message-ID: <20240627163232.1c2b5e49@kernel.org>
In-Reply-To: <20240626012834.5678-4-allison.henderson@oracle.com>
References: <20240626012834.5678-1-allison.henderson@oracle.com>
	<20240626012834.5678-4-allison.henderson@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 25 Jun 2024 18:28:34 -0700 allison.henderson@oracle.com wrote:
> From: Vegard Nossum <vegard.nossum@oracle.com>
> 
> This adds some basic self-testing infrastructure for RDS-TCP.
> 
> Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> Signed-off-by: Allison Henderson <allison.henderson@oracle.com>
> ---
>  Documentation/dev-tools/gcov.rst           |  11 +
>  MAINTAINERS                                |   1 +
>  tools/testing/selftests/Makefile           |   1 +
>  tools/testing/selftests/net/rds/Makefile   |  13 +
>  tools/testing/selftests/net/rds/README.txt |  41 ++++
>  tools/testing/selftests/net/rds/config.sh  |  56 +++++
>  tools/testing/selftests/net/rds/init.sh    |  69 ++++++
>  tools/testing/selftests/net/rds/run.sh     | 271 +++++++++++++++++++++
>  tools/testing/selftests/net/rds/test.py    | 251 +++++++++++++++++++

Let's start with adding selftests, well integrated with kselftest infra.
This is how we execute the tests in networking:
https://github.com/linux-netdev/nipa/wiki/How-to-run-netdev-selftests-CI-style

If you want to use python please use tools/testing/selftests/net/lib/py/
instead adding another wrappers.
-- 
pw-bot: cr

