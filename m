Return-Path: <linux-kselftest+bounces-12889-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FEA091B2AF
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Jun 2024 01:28:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDC75281AFB
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Jun 2024 23:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50A341A2FA0;
	Thu, 27 Jun 2024 23:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WKH1vHvD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 243063FBA5;
	Thu, 27 Jun 2024 23:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719530890; cv=none; b=a5gLX+NcPmcUg5K9bovI2s5YFEYmsbiFw8lqDI/lFnwzEW/o6FIMi6PvJs/VwnqP9R17+7epUw87rQpqIHApDcIbTO5xYcGRNBSPV/X3CAzq2Gc3obK9vlJioZMXDS/FQ2FA0it/FRaoTdc3AxQGLpI/Ae/5zLwfW1gdZ/qBkYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719530890; c=relaxed/simple;
	bh=V2s3SFvzaMHtNwDR5PAPF/n+Oes+hWUxarUWBL0dXDU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MJNTlqmzWuMOhEnVyAjurSXeJTc6NqT4iSr5fO0zO+rx1ZjI9np6+LZr5ukVmABjvILF3oPYzShJGixH5yy5mmSlc9tUt2riRWSU85Di0YhYtD/wPwsZFZhDwHD/OpekvcGSAbTVtAs2DjXeD7Ygn35QP/oGq8oHRnYP+Q0vHfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WKH1vHvD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31507C32786;
	Thu, 27 Jun 2024 23:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719530889;
	bh=V2s3SFvzaMHtNwDR5PAPF/n+Oes+hWUxarUWBL0dXDU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WKH1vHvDE+fE4x6QqWRgt51PUZJpoEyzJ6dPfcggpgZ3056N3kq4EMXn/8I7CA5Mf
	 rodM9Iiqnoo88ADSXHa9777lLJRVa6rOHGY0oqotPp0Bi5fCXT1gaz6MZRJ7oshadv
	 6H0GbC6zUgesjAtelSYu8G0HKc5mwnvVDqGoB1rUQLdHQExV/3tQcbHyN7jgGRes02
	 u3UE1HYfm+BSMe2OiIqsm6vVf+14WF812bSJ3frFNLXg4v71iz1wTqMLp6cVr51MK7
	 yBFuzhzxXLm2zQ46R2KQ5jRteQD+8P9v+8POhwAZ2oel+VrOcpOSLt7Qln7glRmlBh
	 qTw2M2r9Qc1mQ==
Date: Thu, 27 Jun 2024 16:28:08 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Florian Westphal <fw@strlen.de>
Cc: allison.henderson@oracle.com, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, rds-devel@oss.oracle.com,
 linux-rdma@vger.kernel.org, oberpar@linux.ibm.com, chuck.lever@oracle.com,
 vegard.nossum@oracle.com
Subject: Re: [PATCH net-next v1 2/3] net: rds: add option for GCOV profiling
Message-ID: <20240627162808.015c25a7@kernel.org>
In-Reply-To: <20240626012834.5678-3-allison.henderson@oracle.com>
References: <20240626012834.5678-1-allison.henderson@oracle.com>
	<20240626012834.5678-3-allison.henderson@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 25 Jun 2024 18:28:33 -0700 allison.henderson@oracle.com wrote:
> From: Vegard Nossum <vegard.nossum@oracle.com>
> 
> To better our unit tests we need code coverage to be part of the kernel.
> This patch borrows heavily from how CONFIG_GCOV_PROFILE_FTRACE is
> implemented

Hi Florian, IIRC you were able to generate test coverage reports for
nftables / netfilter. Is this the approach you used? I'm not sure how
well adding a Kconfig knob for every module would scale..

