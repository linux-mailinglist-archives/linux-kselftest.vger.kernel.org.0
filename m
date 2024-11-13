Return-Path: <linux-kselftest+bounces-21904-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE8CE9C66D9
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Nov 2024 02:44:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7D6D1F25449
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Nov 2024 01:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 413DA381B1;
	Wed, 13 Nov 2024 01:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P6/BxIWy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 145A317C;
	Wed, 13 Nov 2024 01:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731462276; cv=none; b=uBzqKd8DAG9qQvXfHTvZgz6rTKJSQCOjPKWzPhoTGgxrErN+2J3EuQV5iJwoGZ0ju9rS32+l8AeR66pVyKDvt9gw5Gd2CO8N7q5DjV98RQK3AsA0QM0820aofoxSH8Zcy1EL6h4MdmxWJuWHVOvLw7DBChO2htfLfPBVTY+u2iQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731462276; c=relaxed/simple;
	bh=FfUYOUnPuKpqHXZMIHB0maG45wtjI5JQ6/E8dXh9b0E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jnhF29NYwRlJjKsKyOUa2cJCEhDnFr7Uq09mPjHAnW57gquq3PKfG++YjA4sNSzp+oEc37+HClpmXk/PueLNr5hejZl6EWzmxq0+fkp3CKyZ1VWAUfC2Z5hKL167IKyQ1hkb2/DOeYsEKkgH0+xunpBvRg8PweJ3fJHBLwy7kNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P6/BxIWy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40CE5C4CECD;
	Wed, 13 Nov 2024 01:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731462275;
	bh=FfUYOUnPuKpqHXZMIHB0maG45wtjI5JQ6/E8dXh9b0E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=P6/BxIWy33xlbj72BD9guX3DwPxVKY3pVnZsJ4VxLH/5N8SxojbqpEpSr2i1/X1ZG
	 Af9HhRsiW758kxvtOKfxT6dFgEP7eCBVrDfGGEXVADjNcL+LX1INFyub07wqp1OJVD
	 LyJ3jRwmc1I+rXQjt2lmX6ARiXm3lFX59LKcOmreHjUxcsgu+IKjs09aEQhevlYRzx
	 vboRjWPF0jFdZHD+aOdA9gJHScHfmU83vF72HjceocpMPPLwwGnjvRHihrNGzPP7ix
	 EBSfMo/cvYBPcedKyBU1pWG/NFdOGnOvhTfOR2p4xk+BY2agd5cbSaqsVZFpnZpetw
	 MQttYaMp9rGsg==
Date: Tue, 12 Nov 2024 17:44:34 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Daniel Xu <dxu@dxuuu.xyz>
Cc: pabeni@redhat.com, edumazet@google.com, davem@davemloft.net,
 shuah@kernel.org, andrew+netdev@lunn.ch, michael.chan@broadcom.com,
 martin.lau@linux.dev, pavan.chebbi@broadcom.com, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-team@meta.com
Subject: Re: [PATCH net v2 2/2] selftests: drv-net: rss_ctx: Add test for
 ntuple rule
Message-ID: <20241112174434.011bd0f6@kernel.org>
In-Reply-To: <dc4398dfe9a8e959245d2a8ffe5c2fcefbdd67f7.1731377399.git.dxu@dxuuu.xyz>
References: <cover.1731377399.git.dxu@dxuuu.xyz>
	<dc4398dfe9a8e959245d2a8ffe5c2fcefbdd67f7.1731377399.git.dxu@dxuuu.xyz>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 11 Nov 2024 19:23:31 -0700 Daniel Xu wrote:
> Extend the rss_ctx test suite to test that an ntuple action that
> redirects to an RSS context contains that information in `ethtool -n`.
> Otherwise the output from ethtool is highly deceiving. This test helps
> ensure drivers are compliant with the API.

Looks like it doesn't apply, please base the v3 on net rather than
net-next, I'll deal with the merge.

