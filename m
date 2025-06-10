Return-Path: <linux-kselftest+bounces-34625-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ECA4AD44D6
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Jun 2025 23:33:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E366B169EAD
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Jun 2025 21:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14C3E28469B;
	Tue, 10 Jun 2025 21:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uLiidkIm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB71E266B6B;
	Tue, 10 Jun 2025 21:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749591184; cv=none; b=PQddUQvG2Q5UKuwim1yeNwFV3mA3yRPATd54p68jhlFrrkw2OXveDb9BpS1fft0fKbXpe21Pvy+eVyz9K1X8yz78HbUC72CezeRqUpbnawY7Sw4IhpCmuYFSK2QgPS/9J1dmnhmdg71PttKlS8HfvrkM1OazzPwSTR1MmShYNKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749591184; c=relaxed/simple;
	bh=Hv8Y77kESeUEG6AWdiacSNDkHYArojCMOPgmZ6wvAx0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZOkQPTME4Ka0LYVc+mw+pqiC7DodVmQYFlz9KbQS49jfzfElzWP1VQwd61l5pmIK0Ln9HFck9FedE9YQwwJQN0wSTX/rE8Mu7iSXWRF1qu8slt5v4MU5ETUGY1Jh49B4bvBoQeZO9277cieaWppej8WcxrXx8Mm9ql1eaKDkGVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uLiidkIm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC85BC4CEED;
	Tue, 10 Jun 2025 21:33:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749591183;
	bh=Hv8Y77kESeUEG6AWdiacSNDkHYArojCMOPgmZ6wvAx0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uLiidkImoEU0Xqohc2KkWhlNq5Y8ZnHefXDDd3E5m3sH3M9Vw8D4Z7zlSLFh9uQ4L
	 SQazXvvQDA+Rpr3OtiXwdbzvKtvxtnHGTR2C6l8M7HNgzSYmv0lm9nUKSgtcLXyYyY
	 FDnAZ+n3129Lm8V/oMtmNmzJf0rS0BaCFqtktQkgG8YX0gRilEqOelhDyo1vyLz92l
	 bPyp2yFWKrJmx8OSq2uRlmlA1tXzyRgFfTuJ+S20rRrXyw85Mk9ZtO8biVxrbDO+fZ
	 eqw+EY13yWvLKw9rsJrzohIXG39PVZY7TOuyXUx04F7SAepOsb9nfFNj7McJEaKwDL
	 q3uk0sWHQMbuw==
Date: Tue, 10 Jun 2025 14:33:01 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Gal Pressman <gal@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, netdev@vger.kernel.org, Andrew Lunn
 <andrew@lunn.ch>, Simon Horman <horms@kernel.org>, Shuah Khan
 <shuah@kernel.org>, Joe Damato <jdamato@fastly.com>,
 linux-kselftest@vger.kernel.org, Tariq Toukan <tariqt@nvidia.com>, Nimrod
 Oren <noren@nvidia.com>
Subject: Re: [PATCH net v2 1/2] net: ethtool: Don't check if RSS context
 exists in case of context 0
Message-ID: <20250610143301.41ee168f@kernel.org>
In-Reply-To: <43587592-e4b6-4340-adeb-60bd5a3e783a@nvidia.com>
References: <20250609120250.1630125-1-gal@nvidia.com>
	<20250609120250.1630125-2-gal@nvidia.com>
	<20250609154156.76be9902@kernel.org>
	<43587592-e4b6-4340-adeb-60bd5a3e783a@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 10 Jun 2025 08:58:52 +0300 Gal Pressman wrote:
> On 10/06/2025 1:41, Jakub Kicinski wrote:
> > On Mon, 9 Jun 2025 15:02:49 +0300 Gal Pressman wrote:  
> >> Cc: Jakub Kicinski <kuba@kernel.org>
> >> Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
> >> Reviewed-by: Nimrod Oren <noren@nvidia.com>
> >> Signed-off-by: Gal Pressman <gal@nvidia.com>
> >> Reviewed-by: Joe Damato <jdamato@fastly.com>  
> > 
> > Did you receive a user report for this change in behavior?  
> 
> No.

Please make this clear in the commit message.

