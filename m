Return-Path: <linux-kselftest+bounces-37190-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A605B02B92
	for <lists+linux-kselftest@lfdr.de>; Sat, 12 Jul 2025 17:00:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF650A42E07
	for <lists+linux-kselftest@lfdr.de>; Sat, 12 Jul 2025 15:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DF541607AC;
	Sat, 12 Jul 2025 15:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H4u7j9qQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6C1A47;
	Sat, 12 Jul 2025 15:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752332442; cv=none; b=OGj3piefWZbpI5UNFxeETePHy8F1HKUh0brABZCSLg3fINwvBT6mJ1hOr6WXhYBVNY1/aIjh/rqjlGYGVJWAu50ujBN/dFYD4imTF1MQwdEQQj3pKLsx7py/hvGtg5FRMKS3KEQes/pxTmTpjQYBqRkKV7G5o5x48NVzu5qCE0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752332442; c=relaxed/simple;
	bh=41mLMzSaAdOmfNMCDQMSTEdFRnPzkT/wLBBtmmlTPVs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DMRw6KOvDm0PLw6OEDbYSYIBToUKsAQE3OIloSxryUUgoUlvYd7HfJDx7u+4LY6/jHXZB0JOXoNt5fgVUDJZUUjgfzJE20hx+VXiJNvwo5Ve6uVCM7pGZydEk0/Fpw7ZY2sGlqkrTEEgccOLvHWzdAGLcLc3PM73iFnZuQgf9ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H4u7j9qQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07415C4CEEF;
	Sat, 12 Jul 2025 15:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752332441;
	bh=41mLMzSaAdOmfNMCDQMSTEdFRnPzkT/wLBBtmmlTPVs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=H4u7j9qQnU+fY6/hNEK5C5HN5hNL/OFga0v6DpSW7y+Va6GQmCRxeQwA1p6ANlxiB
	 bq9g0vgxbOPl76KKWOfTpEE5Pv6rgFVs5DtKyuzRxe8SASwQAViwqLP/Tv1kcxz+eY
	 PmONfo/bQwZRTZR6V9h/TJvLc0umskeSp3wFPPuRx07Pysq5YV8XVlgKhgdb5YIbxC
	 LZtrmGTms5CGtpzx1oOb7V7fUEj4ZFUeo3aB/sYhADZJkd9D3tXIvBJ7Q/pGEiRjEG
	 6pCGFLBzGC3V75db8jovygenmNde9YbW2DuFsosWQpXwcxcI8CSbBPGe1QkgyhJ+VK
	 SSRBRLj1cBDlQ==
Date: Sat, 12 Jul 2025 08:00:39 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Mohsin Bashir <mohsin.bashr@gmail.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, shuah@kernel.org, horms@kernel.org,
 cratiu@nvidia.com, noren@nvidia.com, cjubran@nvidia.com, mbloch@nvidia.com,
 jdamato@fastly.com, gal@nvidia.com, sdf@fomichev.me, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next V3 4/4] selftests: drv-net: Test
 head-adjustment support
Message-ID: <20250712080039.525cb0f6@kernel.org>
In-Reply-To: <20250712002648.2385849-5-mohsin.bashr@gmail.com>
References: <20250712002648.2385849-1-mohsin.bashr@gmail.com>
	<20250712002648.2385849-5-mohsin.bashr@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 11 Jul 2025 17:26:48 -0700 Mohsin Bashir wrote:
> +from lib.py import ksft_run, ksft_exit, ksft_eq, ksft_ne, ksft_pr

ksft_pr has to be added in the previous patch, there's a transient
pylint warning

