Return-Path: <linux-kselftest+bounces-39764-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 75017B324EA
	for <lists+linux-kselftest@lfdr.de>; Sat, 23 Aug 2025 00:15:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4017B1BA2208
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Aug 2025 22:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D9CB1AE844;
	Fri, 22 Aug 2025 22:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IpKbEh6T"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78F7393DE7;
	Fri, 22 Aug 2025 22:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755900938; cv=none; b=I08aORWYfcVBvVPMaNtUPw1wvJcSVoqCXrDTCFYGgE23YoXkPCX6t+yzuC1/F920vIHtNobsyD2+dpiyrRu86UJXtJ8qhCKypjudgwRdnKPczpK2LNDGY81ThnC+cNjxheRQYVwvxhIOLR4jjenSS4QAWOH9k/nAjCX88gQ8zSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755900938; c=relaxed/simple;
	bh=ejl6ZW0TgFW7B0NWnGni6B8tuyXnNI24xcIsCbzYmFc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=equfa1ttACTrptcWGQIrYei1U7dpi2On6O4pHKRbNdENef4bDv8yvtgyIqvf3tRNFja7istBkfGyWzDs9Xbjyv6ub3REustJl4ToEM9XQ+CPebtVzxhzFfPCPckUBS7vKVlVRl8SMtFMGVagL1a2+tqc0adEzUhfItaDNks7oqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IpKbEh6T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06362C4CEED;
	Fri, 22 Aug 2025 22:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755900935;
	bh=ejl6ZW0TgFW7B0NWnGni6B8tuyXnNI24xcIsCbzYmFc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IpKbEh6TSiq09GqZg/IT20lGdGOIo+AicZiSuV9eM36Dj0tEsyRZfxTAqHRUMnFsC
	 YOBfWX40F5hGrmQSEqfeZVa1994CUJfNtxlh4sdCLY6wZof5gpwFVjj9d4VMhpf8B3
	 q5iJLAtDABLYC/AkpI93q4QUe+r/kLIeWxIaKkdkYokIJ7w05fn4S+Qt1ab84EzJqJ
	 /DS9X5GvYvfjKPhMSi7kWD2WpXiL/a7FgHJ6Xa3Dvy2rY8S6iAQu+JNbrYyrwNjVFs
	 h1usbVPLASO+MUMiWWdg1mwanaeaNUVReDfsaAX8uBSiLoJxVatTLWG1q8f9AHVcbs
	 dxMiXiDS8kbVg==
Date: Fri, 22 Aug 2025 15:15:33 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 almasrymina@google.com, sdf@fomichev.me, joe@dama.to,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next 2/4] selftests: drv-net: ncdevmem: save IDs of
 flow rules we added
Message-ID: <20250822151533.05c78040@kernel.org>
In-Reply-To: <aKjgw1R9Zpl7nCKZ@mini-arch>
References: <20250822200052.1675613-1-kuba@kernel.org>
	<20250822200052.1675613-3-kuba@kernel.org>
	<aKjgw1R9Zpl7nCKZ@mini-arch>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 22 Aug 2025 14:27:31 -0700 Stanislav Fomichev wrote:
> On 08/22, Jakub Kicinski wrote:
> > In prep for more selective resetting of ntuple filters
> > try to save the rule IDs to a table.
> > 
> > Signed-off-by: Jakub Kicinski <kuba@kernel.org>  
> 
> This seems ok to unblock nipa cleanup, but at this point why not copy-paste
> proper ioctl from kperf? https://github.com/facebookexperimental/kperf/blob/main/devmem.c#L119
> (seems less complicated than popen)

Yeah, IDK. I thought fixing the run_command() to be able to capture
output is more useful long term.

