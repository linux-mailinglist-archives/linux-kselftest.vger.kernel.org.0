Return-Path: <linux-kselftest+bounces-42641-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 967FBBADEC0
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Sep 2025 17:38:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57A414A5F3B
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Sep 2025 15:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 447C62FD1DD;
	Tue, 30 Sep 2025 15:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MhtSyoKI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A18925FA0F;
	Tue, 30 Sep 2025 15:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759246683; cv=none; b=OIaFkZgR43NQrD+nU2RKmc+BYbAC6WynSxj+XbyuGxYXypYVoHhD7iss6Q5oJUPQq5GdRoIhL+o0nKGMATZspLo7DWqMoRJzVTPj5iSXpbbwAdks+Yd0/eFoMYQWdNWl6O6C+aLBqrU76mGY50A+B5ASfKdzDucdWIYb+Ju7LE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759246683; c=relaxed/simple;
	bh=bIH1tajW+dgFb5n4LJwiC8n9OYJSE7wqex2JjoawW1M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=beW8dJbjnFscRLufQ+R1VKkoGkH5TQ7K5Vr/XcpCgIW3TZODLoX8ogZkj9O4mpPPjxvARhonjBPJCe7o8TsCT40RmcHlM63vrxZAQQagZOY4L0qGYdrhKsW2iPpt3oxAoMIZ04j33y/tmGfzytQdz9r+IqiMEDjflMkOWW981fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MhtSyoKI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 235EEC4CEF0;
	Tue, 30 Sep 2025 15:38:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759246682;
	bh=bIH1tajW+dgFb5n4LJwiC8n9OYJSE7wqex2JjoawW1M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MhtSyoKISPs3dmcY4138fLmP5fomwoybxORSnid9IV1riqivI6ny9P+U83/F3xCcK
	 6boEvcQF5w8DyvGcYeaaZTCUlIVwD0+6BxUldhrh+XFIeYtrW5c1C75ee1acHd4erS
	 RKX7KngxXPCQDYIOPxYeVUxn2TxnzfINyM8OpjAj5p8dDoVxP5X1D3m29L/suQ0grg
	 CauYO5CAVrIwnZADAyNY+iWOxPdPZocihOQ12vljJl7cIsI+HBWd+rCgTbkWooh4F2
	 252IuJpfkJ+QJMSR+M5fUMQxrRe5xgiPnV6o+5FxcsmhLPEUQsM3o7vOpKRxaL6Gpv
	 sRwuQmQg2s1Eg==
Date: Tue, 30 Sep 2025 08:38:01 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Gopi Krishna Menon <krishnagopi487@gmail.com>
Cc: Simon Horman <horms@kernel.org>, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, shuah@kernel.org,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, david.hunter.linux@gmail.com,
 skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH net-next] selftests/net: add tcp_port_share to
 .gitignore
Message-ID: <20250930083801.3ea0f7bb@kernel.org>
In-Reply-To: <nebdn6xrcevewtcv6hbumf5tdh4p4patujhdojc7hn2yppwil6@jqbfz7q2ljth>
References: <20250929163140.122383-1-krishnagopi487@gmail.com>
	<aNucABvb0PvBtCxr@horms.kernel.org>
	<aNuci8Y9ZO9pd0Ua@horms.kernel.org>
	<nebdn6xrcevewtcv6hbumf5tdh4p4patujhdojc7hn2yppwil6@jqbfz7q2ljth>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 30 Sep 2025 19:17:29 +0530 Gopi Krishna Menon wrote:
> > Please note that net-next is now closed.
> > 
> > So if you do respin, please wait for it to re-open once v6.18-rc1 has been
> > released. About two weeks from now.  
> Noted, I will send a v2 for this patch when net-next will be reopened.

I suppose a dirty tree will annoy people. Let's get this fixed before
we ship net-next since it's a recent "regression". I'll drop the Fixes
tag and apply

