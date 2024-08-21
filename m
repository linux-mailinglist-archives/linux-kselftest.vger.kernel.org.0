Return-Path: <linux-kselftest+bounces-15939-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE27595A886
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Aug 2024 01:52:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C2E41F22351
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Aug 2024 23:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6751517DFE5;
	Wed, 21 Aug 2024 23:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="neVs1xXt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B3E817D8BB;
	Wed, 21 Aug 2024 23:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724284372; cv=none; b=DOnPISnbBJmD0RdqAbG/XIgbQIYra5Vx2qYAZcHaQeM2iZvmiRVjMvr3YGIISUCx4drJg55Km0bLwc8uZ7Ig5kloJdubWS+oREYtP1II2fuDAEOFf82ZADegRDyd0usXAFX2PVzerpoEfg8+QCandk6+bwS6DkpMnb/fEBBeBEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724284372; c=relaxed/simple;
	bh=IoQNstbn7ku069/liwRFklbAC8jJAjqUOq1rB9ugBzk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f58wzkD7E1E7ocBNCC5GeBmsLJUO/dZU8pA1suoNibPC2CAq37bNBrA7rJXeLKK2WzIaLMrgZ5ykuYSPI6P/SzYUXZ+h/FJMqhHMVSf3MZFmjWKvwlybEgvrnKKyWfOGwiSjNDeO1Coq977iuOhLu/HYzQghTFraH3GnGkvU+MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=neVs1xXt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FCEEC32781;
	Wed, 21 Aug 2024 23:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724284371;
	bh=IoQNstbn7ku069/liwRFklbAC8jJAjqUOq1rB9ugBzk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=neVs1xXt9m5m1lP4p0w1/mMArTaYHTRD4e/JEgPKDjzXemd2ECV3dJNg7xfXvYe1q
	 qgG2a5whJw4uVNQ92+sqfBomWx+cZxCKS0Y3jx/ma7br3WvCLfmTpeLXenhT3nnnR0
	 bbLNR8KzM2k64JiR3WYKeJ85URLIAr7MFyLXgUfhUOEhydAPdIINlprMO631sy1dYs
	 TwZDAbaqakIo0aRtSBvRkvDJ5U8YgH+2zg9/5vHiJU3SLL3HRZdSf6I/UqQbypkZJo
	 a4vglNGfYqzSTsEUNDSpcttZLWY6pVxlLCuIL5M3aGua6r0U4A5WQUaUwSPpbCdTrX
	 68h6rlBvtd45w==
Date: Wed, 21 Aug 2024 16:52:50 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Breno Leitao <leitao@debian.org>, edumazet@google.com,
 pabeni@redhat.com, liuhangbin@gmail.com, petrm@nvidia.com, Shuah Khan
 <shuah@kernel.org>, netdev@vger.kernel.org, "David S. Miller"
 <davem@davemloft.net>, Willem de Bruijn <willemb@google.com>, David Wei
 <dw@davidwei.uk>, open list <linux-kernel@vger.kernel.org>, "open
 list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH net-next v6] net: netconsole: selftests: Create a new
 netconsole selftest
Message-ID: <20240821165250.08e345ec@kernel.org>
In-Reply-To: <1a667d36-d44d-4c34-b8ef-cbc3326622fa@kernel.org>
References: <20240821080826.3753521-1-leitao@debian.org>
	<1a667d36-d44d-4c34-b8ef-cbc3326622fa@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 21 Aug 2024 11:50:40 +0200 Matthieu Baerts wrote:
> > +		echo "SKIP: IPs already in use. Skippig it" >&2  
> 
> Skippig: is it because netconsole is vegetarian?

Let's do one more rev :)
-- 
pw-bot: cr

