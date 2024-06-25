Return-Path: <linux-kselftest+bounces-12647-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ADCA9169D2
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jun 2024 16:07:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C58DF1F216B0
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jun 2024 14:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 669CB15FA74;
	Tue, 25 Jun 2024 14:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FkHBIoSF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37CB31B7F7;
	Tue, 25 Jun 2024 14:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719324416; cv=none; b=FW1O0yTFrVB5x7Bc7YXKuWHw6UHTjMnSprtu8lRaeDB/+j2YZ9orlhyg627JBZ/C86OX9Yclcj7efSVNk4mfohT4S7ixcrlMbchRybqLlzNAfYN4KqwNntTYTcMk0ZEGFHArbJMhKa7HqCP2kUn7lGjbNTnNFpWYY8AHRqMhTfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719324416; c=relaxed/simple;
	bh=7J8V+A2m4KYY9Ousnw3i3fJCgNrKZAjhDaETttSPm0c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z9U+2aVAwjoCCdGQJa0lkoD3MFgcqWCnDu2jv1Welfzdanzb1jseiKNTuNy+qrJ+1n1PGoWL5RUfNuLcaEtQdoYxxLIBzmV99gD7w/eellt4J5e7JLEv4ePYgN8foc4qCx2tTasErA4vtLNqPM5glOB04fQdK6uj5Hg5lSVCujk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FkHBIoSF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42DF7C32781;
	Tue, 25 Jun 2024 14:06:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719324415;
	bh=7J8V+A2m4KYY9Ousnw3i3fJCgNrKZAjhDaETttSPm0c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FkHBIoSFBTopDeTKT/XI/obwtTFmXbucUL0Iu8XhW1Hh/aHREi75sUiaICLONLA4v
	 VV5lyqmmZMmhPCcUvuctzn0VxJ36EkxN45CGmVg3yFXcFDmPCf9vNE6HU0c13hb7Ha
	 DzyYVA3cSOJqLGOTWSVDgUeee6ZzY9fss+4GOZn6XrTeU7X9ckCXO/0lJdbp0yPMrU
	 53DN+2G82EQ6Bkgq6mbGI/wP08QT3TSvMOzkXjSQZLm0i+YhfdX5qB+x2oyR47NoSE
	 8BKvWhPcg6xeqn8Mxjd1Rn8lUNsGtW0Jx9UjQg3ukp5b6NA1LsZh275De8C7f/IdAP
	 ga5ghxOaAIz5Q==
Date: Tue, 25 Jun 2024 07:06:54 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Aaron Conole <aconole@redhat.com>
Cc: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 dev@openvswitch.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Pravin B Shelar <pshelar@ovn.org>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Shuah
 Khan <shuah@kernel.org>, Stefano Brivio <sbrivio@redhat.com>,
 =?UTF-8?B?QWRyacOhbg==?= Moreno <amorenoz@redhat.com>, Simon Horman
 <horms@kernel.org>
Subject: Re: [PATCH v2 net-next 0/7] selftests: net: Switch pmtu.sh to use
 the internal ovs script.
Message-ID: <20240625070654.6a00efef@kernel.org>
In-Reply-To: <f7th6dhgnvm.fsf@redhat.com>
References: <20240620125601.15755-1-aconole@redhat.com>
	<20240621180126.3c40d245@kernel.org>
	<f7ttthjh33w.fsf@redhat.com>
	<f7tpls6gu3q.fsf@redhat.com>
	<e4f69335f90aae3f1daa47ba8f69b24ea15ed3b7.camel@redhat.com>
	<f7th6dhgnvm.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 25 Jun 2024 09:20:29 -0400 Aaron Conole wrote:
> > I'm still wondering if the issue is Kconfig-related (plus possibly bad
> > interaction with vng). I don't see the OVS knob enabled in the self-
> > tests config. If it's implied by some other knob, and ends-up being
> > selected as a module, vng could stumble upon loading the module at
> > runtime, especially on incremental build (at least I experience that
> > problem locally). I'm not even sure if the KCI is building
> > incrementally or not, so all the above could is quite a wild guess.
> >
> > In any case I think adding the explicit CONFIG_OPENVSWITCH=y the
> > selftest config would make the scenario more well defined.  
> 
> That is in 7/7 - but there was a collision with a netfilter knob getting
> turned on.  I can repost it as-is (just after rebasing) if you think
> that is the only issue.

Sorry for not checking it earlier, looks like the runner was missing
pyroute:

# python3 ./tools/testing/selftests/net/openvswitch/ovs-dpctl.py
Need to install the python pyroute2 package >= 0.6.

I guess run_cmd counter-productively eats the stderr output ? :(

