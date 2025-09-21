Return-Path: <linux-kselftest+bounces-42010-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 45B23B8D5D8
	for <lists+linux-kselftest@lfdr.de>; Sun, 21 Sep 2025 08:42:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08CB7189F844
	for <lists+linux-kselftest@lfdr.de>; Sun, 21 Sep 2025 06:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B0552C3276;
	Sun, 21 Sep 2025 06:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GBySzmd0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 275E22C3247;
	Sun, 21 Sep 2025 06:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758436907; cv=none; b=hHTVhNsXvpedBGk3+j8SpQrll0fT/ZeTqSUdg0bv49PfnNxrzMLgWV+xRIY0eVou3Knlo4u5KDeBAWbHUl4k5rq+jFPDvTZEHmfFNlwud7CVzO88jI/X/XZmsTLl7WFkLKYF1FEz0BamiSRB+h0WVI1isHCrkHNE3rleTvvucrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758436907; c=relaxed/simple;
	bh=v3yR36KwvuptwusMELrktsI6NwfP+gZuT+gaH8sI5Ho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e+i73NiXqsQByQM5vi4XmBmpWvMgjMAyybA/SCVW5ze0R5G9t6l+TU4kFdM8eDJyGdknvjL38dTSpXGTKfP/MeU2jxiJuIWJmzC2d4e1bir+hMpOCGaaMQpaokEfG46S6m7kxVLH25RDRYE37didpCO3G3hTwXNlxSkTBweSWA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org; spf=none smtp.mailfrom=idosch.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GBySzmd0; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id D6C13EC0099;
	Sun, 21 Sep 2025 02:41:43 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Sun, 21 Sep 2025 02:41:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758436903; x=1758523303; bh=5NNXK9C0jEkb7A0rE8+6BRc5c5cH8w5cLXh
	+W5FM/rk=; b=GBySzmd0QuFN3TuyW9XGyZEDbNxBcaSqSCTd8pvb1+VChO+O2Ge
	aMaWX3Lll2RJo5V8gGK+CkMJn1Y8NttHILwoFeFyQ2yNRg/g4BsRuOFdMzEATjIJ
	K0PG/PDfrWrfX0jNrvbZ9UIkpZJ7b/ItWEGrXSqAGd76tyBjZ6tXI8khxoYyb0E4
	zHaIrvJWuXt+NvoOrP7btBr4NbZAwEh7t88RE/sfJfcFbyPcZYsRanF9jLYZpOjt
	FqXa/I2UClErhKOshUzHK8/En5mMwyjLRSPatw6cxfvPBrbyOdUEZxCx7yGLILOz
	7AmI7fhmuh+DtkddutbHG4lQDZQ6Z2e7evg==
X-ME-Sender: <xms:J57PaN1dec1eqfhBX-2gsX5e4Efr2IPebZdEU75S0CGSfhoGNjnS2w>
    <xme:J57PaEj4Z-hz2Irb6d1VeTbymVe_J38HVP9sG-cPzdB41HpvzkqXPQ94ogT4A6_tY
    4eaCQHqRmU-X0s>
X-ME-Received: <xmr:J57PaNrWmBB_sONpf-rJPj8_7Hwk7pnWJL5TtVLNVNMXwX3qikFAwPcD>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdehgedvkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefkughoucfutghh
    ihhmmhgvlhcuoehiughoshgthhesihguohhstghhrdhorhhgqeenucggtffrrghtthgvrh
    hnpedvudefveekheeugeeftddvveefgfduieefudeifefgleekheegleegjeejgeeghfen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehiughosh
    gthhesihguohhstghhrdhorhhgpdhnsggprhgtphhtthhopeduhedpmhhouggvpehsmhht
    phhouhhtpdhrtghpthhtohepmhhmhigrnhhgfhhlsehgmhgrihhlrdgtohhmpdhrtghpth
    htohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggr
    vhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegvughumhgriigvthesgh
    hoohhglhgvrdgtohhmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtohephhhorhhmsh
    eskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhhuhgrhheskhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepphgvthhrmhesnhhvihguihgrrdgtohhm
X-ME-Proxy: <xmx:J57PaHMmpdXoxsgzfaHdfMNsObwA_YfrSpI6rOwYXdgXRK7esgrV6g>
    <xmx:J57PaJ27i57mjbGk35dKG2vURcWjIx-RsQk_M7mHAMOlAwCk1Wr2kQ>
    <xmx:J57PaFpPfdoUhLtt7fed2PlIxwnPrY4YqO5CHBjDeQK6Gn1fG_a1mQ>
    <xmx:J57PaDct7-PY8DvzY311DCJJeA_iCtQhj7IomSwCm_mSFxq72yYC5Q>
    <xmx:J57PaPEN8w2G2y_lNiiui_PfCTRAzKGuFb66y4394_UYmH_InwTkqUU6>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 21 Sep 2025 02:41:42 -0400 (EDT)
Date: Sun, 21 Sep 2025 09:41:40 +0300
From: Ido Schimmel <idosch@idosch.org>
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
	Petr Machata <petrm@nvidia.com>, Amit Cohen <amcohen@nvidia.com>,
	Li Shuang <shuali@redhat.com>,
	Alessandro Zanni <alessandro.zanni87@gmail.com>,
	Hangbin Liu <liuhangbin@gmail.com>, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3] selftests: forwarding: Reorder (ar)ping
 arguments to obey POSIX getopt
Message-ID: <aM-eJIAj2cnj34On@shredder>
References: <20250919053538.1106753-1-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250919053538.1106753-1-mmyangfl@gmail.com>

On Fri, Sep 19, 2025 at 01:35:33PM +0800, David Yang wrote:
> Quoted from musl wiki:
> 
>   GNU getopt permutes argv to pull options to the front, ahead of
>   non-option arguments. musl and the POSIX standard getopt stop
>   processing options at the first non-option argument with no
>   permutation.
> 
> Thus these scripts stop working on musl since non-option arguments for
> tools using getopt() (in this case, (ar)ping) do not always come last.
> Fix it by reordering arguments.
> 
> Signed-off-by: David Yang <mmyangfl@gmail.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

