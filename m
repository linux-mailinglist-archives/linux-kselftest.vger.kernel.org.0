Return-Path: <linux-kselftest+bounces-34015-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B1399AC8509
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 May 2025 01:39:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C4A61BC3B74
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 May 2025 23:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B690C221733;
	Thu, 29 May 2025 23:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cmcOfTa5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 839F5610B;
	Thu, 29 May 2025 23:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748561954; cv=none; b=uiur5REcjJ2FY2VYKrZekSnwia1ZeRduUMbooLm/aaUyESzNdV7Y/uMzW+lKrBZIFtTsb3v6jiqzi9i48PfKqk9icfrDTmHUSfWoje14YmhkhjsmHvS+EeyEHgecCHwTXzmXwlSW2cGV7mEQ79PAK5GH9AVjIyvjzGSzsJyeVFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748561954; c=relaxed/simple;
	bh=vR07fP1DkWH9OYPo5qKIxbHEa+Ox8ly9FGddhmqKQvQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uR+12bdiV/SmP0zVv/lqIn3GE88ydguJ4HqZQk0cJJOm/2SPQjxSboxrMd/pHhxZuuWIeb0nnlE4MAoYbOtX59Hk1ci3uqf+v/sHxbnnnRPCMlNbNVE9dU/ZqN54pe3WuROxr6Fuc8Hug3egCHte3P2Qygec/xfwtIbkZUcpc9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cmcOfTa5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 892EAC4CEE7;
	Thu, 29 May 2025 23:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748561953;
	bh=vR07fP1DkWH9OYPo5qKIxbHEa+Ox8ly9FGddhmqKQvQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cmcOfTa5e6WFMvFg92tSJ6FPSD2hqJzahEeyGT8o/gMsfN4OuJoIu/F2dOE6BWWb/
	 PLpsm36XLeqCfTNJbX84nepeOM9ZchQSZlDGEfNEV30wI+2P/JnE8KGmTxva+AV0Io
	 PIukE2+LCb7iU+LM1TqRrqUKqvGVrmOuH0h61BvMzmDR/GWJ7vhyYEiK9NrfciB9Yu
	 DZgWk6Qk4rLzzJwG96Kequr2sUW/iXeCZUpsO8PswCIIiYLQaEGgtUw9WPwQ2p4b6v
	 GiSBxplfnqBENs+lgNXz3wvfSxnFI8EUzNTsCRW6FGitO6fEF6UL8ASx9Z/OyBIooo
	 nxzeYD6JlWoxw==
Date: Thu, 29 May 2025 16:39:12 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Bui Quang Minh <minhquangbui99@gmail.com>
Cc: netdev@vger.kernel.org, Philip Li <philip.li@intel.com>,
 oliver.sang@intel.com, Shuah Khan <shuah@kernel.org>,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] selftests: net: build net/lib dependency in all
 target
Message-ID: <20250529163912.72825205@kernel.org>
In-Reply-To: <20250529070536.84491-1-minhquangbui99@gmail.com>
References: <20250529070536.84491-1-minhquangbui99@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 29 May 2025 14:05:36 +0700 Bui Quang Minh wrote:
> Currently, we only build net/lib dependency in install target. This
> commit moves that to all target so that net/lib is included in in-tree
> build and run_tests.

With Simon's comments addressed, feel free to add to v2:

Reviewed-by: Jakub Kicinski <kuba@kernel.org>

Thanks!

