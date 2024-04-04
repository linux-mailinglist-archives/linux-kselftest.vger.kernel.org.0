Return-Path: <linux-kselftest+bounces-7197-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A742D898938
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Apr 2024 15:52:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8BDF1C254EF
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Apr 2024 13:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 450EA128812;
	Thu,  4 Apr 2024 13:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MWikJUAq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1127912839D;
	Thu,  4 Apr 2024 13:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712238723; cv=none; b=ufNznpUzQD+9SEea08CTjSuL//T+/PUhNAISQi91tUiuuyJH9ikrOLlDEQ2nYy8QQpJf4SI/m+Vve87mK1ixFopFvL173LMmiQ/eZsWjPbYcuMqyMUSRXpPNG2jZAr0DCFMGv3lkGk7ALRvRlASMOnXihusNHyU+Gp+CLiMumQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712238723; c=relaxed/simple;
	bh=5td1WnMP4T8gOUudfpg8lft9EMzSNlFEKNurVZ/kTaE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TEcm59QqBZLDnDMvzjO89exy/EqqVg/ju0WTRKm1xVda7aBWO0OpWNR4VjS8JLyI68mMesJCuv0HrIL/mA8MyrM9xeOqS2StbH31IY+UftqUjya6d/bwYQdnOqa85e7WpNKc2ee8nvOWraKU/kgLZ5tl+Fv7xIqx19QoC1rWhb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MWikJUAq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CFEFC433F1;
	Thu,  4 Apr 2024 13:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712238722;
	bh=5td1WnMP4T8gOUudfpg8lft9EMzSNlFEKNurVZ/kTaE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MWikJUAqiylqljmtmnZWdoozUbYxNRVmKSI55zrS58TQtSWqjRJooX/cAxx+tn8h7
	 HQ0WmwE+DcD8tjFG7hKO0ixMJI8EthnYYtsJFkM3oIRMzxd4IzYHg7qYstqaz2mUJV
	 x2xgxTSjTMYpvkktfsVLwc4w1YLwJsOEOHLBfEiLBrmPG71v5PZTlkJoLM/GSnYn5/
	 /tx35PfAJrQtneAaEFMsECrFGYgtjc7Hk5H2VYS5PyMJXtjE7MBh6k3nrGQ6nP81wT
	 92qyHyurNVeXjM2b8NvaS18tXSj/5jnRBWthi9vWktGw5x742voxMoaGuebgfSrJJR
	 v1HJlPkMQth7A==
Date: Thu, 4 Apr 2024 06:52:01 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Petr Machata <petrm@nvidia.com>
Cc: <davem@davemloft.net>, <netdev@vger.kernel.org>, <edumazet@google.com>,
 <pabeni@redhat.com>, <shuah@kernel.org>, <sdf@google.com>,
 <donald.hunter@gmail.com>, <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH net-next v2 5/7] netdevsim: report stats by default,
 like a real device
Message-ID: <20240404065201.0109606d@kernel.org>
In-Reply-To: <874jchgyok.fsf@nvidia.com>
References: <20240403023426.1762996-1-kuba@kernel.org>
	<20240403023426.1762996-6-kuba@kernel.org>
	<874jchgyok.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 4 Apr 2024 12:40:04 +0200 Petr Machata wrote:
> > +	stats->packets = rtstats.rx_packets - !!rtstats.rx_packets;  
> 
> This is just to make sure that per-queue stats are lower than the
> overall rtstats I presume?

Yes, to fake some "non-queue" stats.

