Return-Path: <linux-kselftest+bounces-7198-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 354CF898944
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Apr 2024 15:53:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D837281053
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Apr 2024 13:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD95712838B;
	Thu,  4 Apr 2024 13:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ikNmkSco"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 850D018AF6;
	Thu,  4 Apr 2024 13:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712238827; cv=none; b=mldYYuJE9gA9C7oaLPvuG+rIMoT4FKSDrrGxuxyAskyHkJs3RBlEZvYL/R2HrpilUqXDF9Nufsmph0aaKAi/QiPgFnr8ONF3ID6BKo5L4ubEEVuONSNQ6VjvbzxY1gs5wwN9idzZmcyK7d1ErHLnogrv3lDbgr1DFHm3BN4J5uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712238827; c=relaxed/simple;
	bh=74NSj1caHuMI0lZrkxQ1cVoir+OLZbFtzYa1jLkcTVI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Dy4HdImWSbfwqKYpciKiL2oxhMrnpgPze+N2j3AHJhe+xWCBnJ8dSiLr6hyhiIOwKTTVqB6pd8YdVbMuXJmYcX+rMIWrECUoDjQUkhqW+alaWtJQVdW2hOYXAmpwz34XlRUWdfHp0oecxxUXE2n7lMwIhWV9b07hjHKa3UR0R1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ikNmkSco; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DD3DC433C7;
	Thu,  4 Apr 2024 13:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712238827;
	bh=74NSj1caHuMI0lZrkxQ1cVoir+OLZbFtzYa1jLkcTVI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ikNmkScogNv6fqpMKbs47ETcEwrinozHl6aiKwyGb8sV1XGrERUabKPuhSup72EgP
	 BAyBaAjIvtT3ZhfcH0iSZBhu7XxQl5L2mCb1/BtF6W+MoWQvoq+bqJOEw8Tud3wpR+
	 tYZo+k1DNfivCtowY9pDozZzcUPf1kp0pXwT562ts+4Dv7dbcsdJLCsKc7zYlOOBcv
	 4rCZ+MDfGeK2wEYm3ElXnWNlXw4C8L6oVcnM9C+R7NVvPeYMMVdRX5U6q7PTPfkVsj
	 V0H/bs5qeNv/Vc0VDu882slhfrDkUG6rFr/M3yNNbgNeHmQOzG8bNgMDWZKFhAN0W2
	 IRSAXZx/kuCYw==
Date: Thu, 4 Apr 2024 06:53:45 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 shuah@kernel.org, sdf@google.com, donald.hunter@gmail.com,
 linux-kselftest@vger.kernel.org, petrm@nvidia.com
Subject: Re: [PATCH net-next v2 5/7] netdevsim: report stats by default,
 like a real device
Message-ID: <20240404065345.3a475611@kernel.org>
In-Reply-To: <8f84ab63488c2283108ff08689a1fb2001a70f0a.camel@redhat.com>
References: <20240403023426.1762996-1-kuba@kernel.org>
	<20240403023426.1762996-6-kuba@kernel.org>
	<8f84ab63488c2283108ff08689a1fb2001a70f0a.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 04 Apr 2024 15:40:33 +0200 Paolo Abeni wrote:
> > +	nsim_get_stats64(dev, &rtstats);
> > +
> > +	stats->packets = rtstats.tx_packets - !!rtstats.tx_packets;
> > +	stats->bytes = rtstats.tx_bytes;  
> 
> It looks the stats will not be self-consistent with multiple queues
> enabled. 
> 
> What about zeroing 'stats' when idx > 0 ?

Ah, good catch. We do allow allocating multiple queues, even tho 
we don't do anything with them on the driver side, yet..

