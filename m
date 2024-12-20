Return-Path: <linux-kselftest+bounces-23657-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D62789F9429
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Dec 2024 15:22:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A2721887A6D
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Dec 2024 14:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EF3D215F56;
	Fri, 20 Dec 2024 14:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mu5BGaQB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03159215717;
	Fri, 20 Dec 2024 14:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734704536; cv=none; b=l0yvc0v0NavzPBn+Ta+0BYZ4U+QJZaMxz+OJsmd5J6EUbL6WgpzoeSFZSJetNUjM7w2LP8WSruXMZOCF0qjKxnOeweA9FeVuhsojjlxG2UoA6dRos6HJYj9jWBgAeBodLKwgHx4BzhgkfgvJa6JNmJArmE0jGCxmfWaZfg2Q6o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734704536; c=relaxed/simple;
	bh=txIex3QN3yTqNXp6lUA//gB6opNg24p+Kc8nV8iHv0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vBRgkbnQWCqvSOoalpv5UefSrtMeKE4kvL2cdYCc0l8EpjMom+43xUjL/tgN9FstcJ5xd7fwNNV07AcRSX5ILGBqzg50lHze53FAywkf3gXwH9bg+mt7StWetAI/Lb3KJxXpk8XVrEMsGnrJJxceE2kOy+0XP0AnzHUpwywTH7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mu5BGaQB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BF5DC4CECD;
	Fri, 20 Dec 2024 14:22:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734704535;
	bh=txIex3QN3yTqNXp6lUA//gB6opNg24p+Kc8nV8iHv0Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mu5BGaQB4Bj4b38Hhn/5Mz8tyVxowBkNx0TzuYDMrHlWjHwb3i1ZcVYjHlNGt+3aC
	 9ZQB0vdCkiPaG+i1KShRmgAy4dkqPlwLmosDc7Db+A8CKM/JX5pfamGA7O8hzU2TNI
	 Qffcrgmd2tZ+TNNJ0j3r7TZWKpdjb+zy1wSMZx9oalSiPHf7LgM18Nec07LSLgGInw
	 mR0OUcyDIx0EWvTznY7Vzoqe59YQhAd3yOkB1HLGeiMn1JorMUtvrIVpZUlWj/zkOF
	 gpUTbvyueWs47p8fxHRghMyZUfRntd73KxdQOOB/VVRD9jq3aet2CFLuRGErfdB/GJ
	 rsOKQ/jx5pC/w==
Date: Fri, 20 Dec 2024 06:22:14 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, shuah@kernel.org, willemb@google.com, petrm@nvidia.com,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next] selftests: drv-net: assume stats refresh is 0
 if no ethtool -c support
Message-ID: <20241220062214.3e8823ac@kernel.org>
In-Reply-To: <e933e67f-66f2-422b-b00e-09ae788ed51d@lunn.ch>
References: <20241220003116.1458863-1-kuba@kernel.org>
	<e933e67f-66f2-422b-b00e-09ae788ed51d@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 20 Dec 2024 10:09:06 +0100 Andrew Lunn wrote:
> > @@ -234,7 +234,12 @@ from .remote import Remote
> >          Good drivers will tell us via ethtool what their sync period is.
> >          """
> >          if self._stats_settle_time is None:
> > -            data = ethtool("-c " + self.ifname, json=True)[0]
> > +            data = {}
> > +            try:
> > +                data = ethtool("-c " + self.ifname, json=True)[0]
> > +            except CmdExitFailure as e:
> > +                if "Operation not supported" not in e.cmd.stderr:
> > +                    raise  
> 
> How important is this time to the test itself? 

Just to be clear (because unfortunately git doesn't do a good job of
calling out Python method names in the diff :() this is part of a
method called wait_hw_stats_settle() within the test env class. 
It's used by various tests which use/check device stats.

> If it is not available,
> can the test just default to 50ms and keep going? I would of thought
> we find more issues by running the test too slowly, than not running
> it at all, unless having the wrong timer makes it more flaky.

We already use zero for majority of driver which don't report stat
refresh:

                 data.get('stats-block-usecs', 0) / 1000 / 1000
                                              ^^^
this patch just does the same thing not only if the driver doesn't
report 'stats-block-usecs' but also if it doesn't support -c at all.

