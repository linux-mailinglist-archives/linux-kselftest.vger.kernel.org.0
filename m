Return-Path: <linux-kselftest+bounces-27980-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3525A4B40C
	for <lists+linux-kselftest@lfdr.de>; Sun,  2 Mar 2025 19:24:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 547513AEE7A
	for <lists+linux-kselftest@lfdr.de>; Sun,  2 Mar 2025 18:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF2CF1EB5D0;
	Sun,  2 Mar 2025 18:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="X7G5ZBWv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="0mR329K3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A21D418BBA8;
	Sun,  2 Mar 2025 18:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740939862; cv=none; b=CyTXd6kL4unbKtgnZyXCJwlXKpFQwuHnVd4OMZVodpzKL6hiecYW2Xg7+mdwJT017vTK+S+z39h+fwWWRVYsfHHKppyMGHFTkKwl1EcUja0cwgZaDhFiitDJxf20TRapRzbT3or7S3W3AX0Ya4ouI+qwL3V8UKTINzhj1RSdOJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740939862; c=relaxed/simple;
	bh=RTb9Ohk7mRbGTgMtcH0ebJfOQQb87PiScFc/UMSe3RM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S6vwF2mb3z/Y4em3SntGDlnD7QUEkovuKOzjslVcCyoxAoddwWuRjq/vQiqa8BbPWzwc0fudv2dph039Da9rf3KYRb/f+cjkdroirjv1rsrCJjw7rXJUeeU59ns5ZVot7REkQ+tQoO6FA8re1YU+CIDX2O0VJeXj30HOB8DPV/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=X7G5ZBWv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=0mR329K3; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 3CD9D1140144;
	Sun,  2 Mar 2025 13:24:18 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Sun, 02 Mar 2025 13:24:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1740939858; x=
	1741026258; bh=vbDBbOj0P076q30CuM2H8hrlu1dzNSJq+H1MlcuN+n8=; b=X
	7G5ZBWvVYtgL92wliiWQLOoPPLEsbW6qvxPWOWO2L31SI2Pn7pzCn0OtHcoGbeQ0
	U5uY9d4JrMYQ0SnV1t8edjWN2DIljmb3gBWSLAyVzUNunqCgsc2Nz2Gs/WAxVoLJ
	ZrrvjIUINpe4gBFFOzM9nBlxqfC8leKTvJRzZEk8ntcfqFzpA+zAhasoRhYNkx75
	qtocaZNWFahYOa8cUdxWDqRZjvoo0O35fAJ7B9ljE6EfjoENW+vTMjBSjWOTJehw
	uIIfxdEHpgeLDHc5tT5TRFLMpzhUQoHh0HiERDMRTSnmDxUHDr8eYFbCLTU4D39u
	hHBPQCe1Kd2Lh8wUUJJgg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1740939858; x=1741026258; bh=vbDBbOj0P076q30CuM2H8hrlu1dzNSJq+H1
	MlcuN+n8=; b=0mR329K3REKRIgKSPebDDB7SQ8XsB6tAX39yW10+XOQKOvXZ7RT
	/jtwbNHWyieMjKUmEvhVL1eNRETQcshMdOcJnZMfuf2fJXAXav6/s58G1PJBm9He
	WFDoS8Lp2B0/TY4k5UMZ6gdCZinIIktATJh2jk0koAzdLYy4TZ8NscFaeQ/kr8UM
	MDwGX9s6mbPdxcYSmiftk8EM/S0J6SfEZf5IgKK9R4xX3cKFWMFej8zvc3XXIgt9
	WdR0JYIsARDeKO3Ap5O/F7vuDYcbLy/QQ0Lc+Tx/1gLz/5K68TkGSM/MtdT5sobh
	PRrIBR6QVjhqRCbfJinkPjZ5j62IPEpx9PQ==
X-ME-Sender: <xms:UaLEZ5J6oaOLtF1CkeIhG95QfTi44C0aKfmBrhMrqE1Zw1rvUMz0xw>
    <xme:UaLEZ1J4bqLz34XyeRHS4uoPBRwyCbUY_xbO7i7r5QtRrH5asGUuST-EtEsG29KLd
    nlLWeswwWEuAtl7XXM>
X-ME-Received: <xmr:UaLEZxs_G2jDjvfowvvzPZ6rq6ya_0IOJzKdhL6ihfE3mko2xtn7e_LgTW2a>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdelieelvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttdej
    necuhfhrohhmpefurggsrhhinhgrucffuhgsrhhotggruceoshgusehquhgvrghshihsnh
    grihhlrdhnvghtqeenucggtffrrghtthgvrhhnpeeuhffhfffgfffhfeeuiedugedtfefh
    keegteehgeehieffgfeuvdeuffefgfduffenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehsugesqhhuvggrshihshhnrghilhdrnhgvthdpnhgs
    pghrtghpthhtohepudefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrnhhtoh
    hnihhosehophgvnhhvphhnrdhnvghtpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdr
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtg
    homhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgr
    sggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopeguohhnrghlugdrhhhunhhtvg
    hrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhhuhgrhheskhgvrhhnvghlrdhorhhg
    pdhrtghpthhtoheprhihrgiirghnohhvrdhsrdgrsehgmhgrihhlrdgtohhmpdhrtghpth
    htoheprghnughrvgifodhnvghtuggvvheslhhunhhnrdgthh
X-ME-Proxy: <xmx:UaLEZ6aME6pA6a_NQ89RWNsBp6blRqjrQSSkYaZGkHhQbDdArBNrcg>
    <xmx:UaLEZwbL-9P45mrNHenV1Q8xo2a9C154d5xvs3VahbM_Kyfb7hUSBA>
    <xmx:UaLEZ-BxC1mNMqbd-s_BT2rjghXA8XFmMJprXM3dJ5hiz8IbruMFig>
    <xmx:UaLEZ-ZNTN9t1eEaL4QnOUURDC6PDw-lPSZjHiVs_24nPRcuajSpkw>
    <xmx:UqLEZwp-BRLoq-FXlmkkvUDDqPnypzR4VeAsfLaCZCP3WKwIog6hKgR6>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 2 Mar 2025 13:24:16 -0500 (EST)
Date: Sun, 2 Mar 2025 19:24:14 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Shuah Khan <shuah@kernel.org>, ryazanov.s.a@gmail.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, Xiao Liang <shaw.leon@gmail.com>
Subject: Re: [PATCH net-next v20 20/25] ovpn: implement peer
 add/get/dump/delete via netlink
Message-ID: <Z8SiTgEmj2Vr-p-E@hog>
References: <20250227-b4-ovpn-v20-0-93f363310834@openvpn.net>
 <20250227-b4-ovpn-v20-20-93f363310834@openvpn.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250227-b4-ovpn-v20-20-93f363310834@openvpn.net>

2025-02-27, 02:21:45 +0100, Antonio Quartulli wrote:
> @@ -1310,9 +1329,12 @@ void ovpn_peer_keepalive_work(struct work_struct *work)
>  	if (next_run > 0 && ovpn->registered) {
>  		netdev_dbg(ovpn->dev,
>  			   "scheduling keepalive work: now=%llu next_run=%llu delta=%llu\n",
> -			   next_run, now, next_run - now);
> +			   next_run, now, next_run - now ?: 0);

nit: I don't think this "?: 0" does anything

> +		/* due to the waiting above, the next_run deadline may have
> +		 * passed: in this case we reschedule the worker immediately
> +		 */
>  		schedule_delayed_work(&ovpn->keepalive_work,
> -				      (next_run - now) * HZ);
> +				      (next_run - now) * HZ ?: 0);

nit: same here

-- 
Sabrina

