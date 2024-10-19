Return-Path: <linux-kselftest+bounces-20191-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A8B869A4BF5
	for <lists+linux-kselftest@lfdr.de>; Sat, 19 Oct 2024 10:03:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32299B229AD
	for <lists+linux-kselftest@lfdr.de>; Sat, 19 Oct 2024 08:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A16D1DE2D9;
	Sat, 19 Oct 2024 08:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kCjUPH15"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD2D1DDA32;
	Sat, 19 Oct 2024 08:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729324991; cv=none; b=iOlOyrJKYV/XdL2554tjRPhzTb8v9k/YR2Z0V8A6v2oG3jP57DLcxhgMLvQZDaSEoD2biHuFd3YWIB5bTsMIjZG+4tN76pJ/uRCg7rlJ8/05Fqs7ts2+ws5lFZ5KQQLLuU60BTyfv77vQ9FR7p7xt5u5JNqbG/52pPq7cDbgSVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729324991; c=relaxed/simple;
	bh=e/17Q2uqoKFVKpY5kK/k0yzZsTlFKko2EGJtXwjkM9E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sis4oSAI/vNCfmoVLSibxOIZ60onhZwt83kPzZjEXwllmflKXI9X6uaI/jRn+aktM5VAJLqqQuEVfVfxLlWe5nWjLxNbBVa3NCqcGY/Oc8B5yP1GtZhbRpOvFpX+vqWUb0BNtbIxEfJ50n4jDecr9A7/antMRscU7apPpECJ8eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kCjUPH15; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B7C8C4CEC7;
	Sat, 19 Oct 2024 08:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729324991;
	bh=e/17Q2uqoKFVKpY5kK/k0yzZsTlFKko2EGJtXwjkM9E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kCjUPH15QVOAeHsRciWHQybs8Lh1N/m6CapEO3VSwc7WI/LfJvZwZxyMPKJB4qWp9
	 OEcsSOowcE2ku/4gXL4TNhx397FrU9ZeSFPysMraXlWVf4lvQNqqRWfIogXG3vSMsj
	 JfPPyEIu5nqElcrERvd0ocJBKGg7kfxXFBpkXaByREqs7NgMjGkBNOg/T0KNqH95QE
	 ThANrcXLGX8IbPj1ahtWCnRubzr2kGFLbW7BBeV8yNcFXrzNCNpCQv+3uN4O/T9RG8
	 KkJhXww1JGU0Q10DDPjfFUBJ/g2waIljE4UOdRWv2Xaiaw+lEvKe/cih0DRhtwX0P1
	 BMVUQkZ5VxREg==
Date: Sat, 19 Oct 2024 09:03:07 +0100
From: Simon Horman <horms@kernel.org>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, Boris Pismenny <borisp@nvidia.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next] selftests: tls: add a selftest for wrapping
 rec_seq
Message-ID: <20241019080307.GG1697@kernel.org>
References: <20775fcfd0371422921ee60a42de170c0398ac10.1729244987.git.sd@queasysnail.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20775fcfd0371422921ee60a42de170c0398ac10.1729244987.git.sd@queasysnail.net>

On Fri, Oct 18, 2024 at 12:55:58PM +0200, Sabrina Dubroca wrote:
> Set the initial rec_seq to 0xffffffffffffffff so that it wraps
> immediately. The send() call should fail with EBADMSG.
> 
> A bug in this code was fixed in commit cfaa80c91f6f ("net/tls: do not
> free tls_rec on async operation in bpf_exec_tx_verdict()").
> 
> Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>

Reviewed-by: Simon Horman <horms@kernel.org>

