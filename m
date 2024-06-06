Return-Path: <linux-kselftest+bounces-11283-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B0668FDCB4
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Jun 2024 04:27:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CEB1282EDC
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Jun 2024 02:27:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C02DD18C08;
	Thu,  6 Jun 2024 02:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XE6ycHhF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 922848C0B;
	Thu,  6 Jun 2024 02:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717640848; cv=none; b=nLKQ5m7tNE+SAh3Vxhc6LgNFHmAUe6a1DH7KqyH183XyFQT37eWIlx7Hp1GxcWlKR0tLT4o8J57POPlNSq0rXoauCOKJQQLkJqUrK9ObmSpQsYw/FlwBWAXrpwMRu+a4/7bfLpdIzw1U0KO6U/bwY54I7bt2YtM7c0mawcks4rE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717640848; c=relaxed/simple;
	bh=/U1TE3SFt7bMT0N4580wNlLmxRudTmEaztuiiHNKSrM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fC6YoWUuqGHGjt0NALnzs+yMBDMCN35nlHHap6fMpMCHSWAcp777rZoY8sMVXu/nSeni34mp64LLOJxQJxENGemo03nOgUF3fMZXlpijHHMMWP1hy8czpnrXA6gAQFbjXCCbFp4xef9SZa5b8I3EgvHg0LP0M9JxCimlUtcThB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XE6ycHhF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CD3AC2BD11;
	Thu,  6 Jun 2024 02:27:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717640848;
	bh=/U1TE3SFt7bMT0N4580wNlLmxRudTmEaztuiiHNKSrM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XE6ycHhFZkVAdzSk9PobeBobzB7ULjbvbMetnc/CD7YJR6v4IdUuzkPun0p+qfHdq
	 TYpWmT5GaCjTw/r2+U1ZUaemq9oJbLZ/xSQADKP+qlsABw8jH7wdVREOKxXLz/eO00
	 BYAuDlRdBZwX8HaAnIJS1W4YxxGlEkkZ9TxpVPCH5pbZSVRH7YPIQfVCqH3zJjuzLE
	 pbewAHJaw8xfUz3UzIkCF/CcMkqYiIEomTqLyrOVYra8bY4foIPFSmLMrkq8NbGLIK
	 tSOURzSAwejYYmSPuXilp+bdkoonXbRPlY3uLh6vx3tQW1i+75iys+34BGisk2Wqut
	 9mFE56kcx3A3w==
Date: Wed, 5 Jun 2024 19:27:26 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Lukasz Majewski <lukma@denx.de>
Cc: netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, Eric Dumazet
 <edumazet@google.com>, Vladimir Oltean <olteanv@gmail.com>, "David S.
 Miller" <davem@davemloft.net>, Oleksij Rempel <o.rempel@pengutronix.de>,
 Tristram.Ha@microchip.com, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Ravi Gunasekaran <r-gunasekaran@ti.com>, Simon
 Horman <horms@kernel.org>, Nikita Zhandarovich <n.zhandarovich@fintech.ru>,
 Murali Karicheri <m-karicheri2@ti.com>, Arvid Brodin
 <Arvid.Brodin@xdin.com>, Dan Carpenter <dan.carpenter@linaro.org>, "Ricardo
 B. Marliere" <ricardo@marliere.net>, Casper Andersson
 <casper.casan@gmail.com>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Hangbin Liu <liuhangbin@gmail.com>,
 Geliang Tang <tanggeliang@kylinos.cn>, Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH net-next] selftests: hsr: Extend the hsr_redbox.sh test
 to use fixed MAC addresses
Message-ID: <20240605192726.58a48199@kernel.org>
In-Reply-To: <20240603093322.3150030-2-lukma@denx.de>
References: <20240603093322.3150030-1-lukma@denx.de>
	<20240603093322.3150030-2-lukma@denx.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  3 Jun 2024 11:33:22 +0200 Lukasz Majewski wrote:
> Fixed MAC addresses help with debugging as last four bytes identify the
> network namespace.
> 
> Moreover, it allows to mimic the real life setup with for example bridge
> having the same MAC address on each port.

Doesn't seem like a particularly scalable method of making tests more
debugable but alright...

