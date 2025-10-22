Return-Path: <linux-kselftest+bounces-43802-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B3FE9BFE596
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Oct 2025 23:51:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 28B844E7EFD
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Oct 2025 21:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 590C8301486;
	Wed, 22 Oct 2025 21:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="KuwbYWp2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mALDxU6u"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C2F027B354;
	Wed, 22 Oct 2025 21:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761169876; cv=none; b=KWYTGHZ0QYoct30WUEpPCW/1HjxTkGsERv9Z7DVms99RiMlLag93HYyHvlEncXUmnYPaKsYO50IGwREVmVPxcJT6J8sVwO9nzqrrNwKmlg0ToYTt0YphYknygyALWtmddwLGqK+ofuQr5F86Lzw7+TQpDCDvxuY+AF9xpeiWR04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761169876; c=relaxed/simple;
	bh=dn0HwXYQmRQZXxo4hkZFxuJSWZQyybh4xR+3qIH7kd8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TcUmnkAXEbMppukQTSoXADUbA08id8MiUVGt4kVtq6XWXRMt8BOk+TOE/PW1rXaepRqaJDqrB4+rltyBZx+EtqaCiSJ3pTnu9IFdiyGhU1+2FJltFPeb+/7kPZ9ppTwClVKelqxO7MYSyDtOVYUXNRta+t7yf9gk55LhDC+a1Eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=KuwbYWp2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mALDxU6u; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 01E337A0125;
	Wed, 22 Oct 2025 17:51:11 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Wed, 22 Oct 2025 17:51:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1761169871; x=
	1761256271; bh=hbG6RsnJYSgulUi4OAThtCw5VfjfNUbCoBtc+xp3w7g=; b=K
	uwbYWp2BQH2k1UF4Gcwg2z3z1f3vZnDqoU/DhGEc+TCIB8gmohgm+Yib5XtNl2wE
	1GiCIyPcg6UTha6jt0e1g4sSP5+FncC5fFLt4pBHrXvbFaDI4zfWPiiJX52ZTVYW
	bKX64BcY3OYzI0Sau4mkTmx1weZI8elFj1JfaewCNzC5gm3NCXLkcqUZq7HqUbf4
	kZj4wR6rEftZ9iQc93TNVjr2zpN+8szXdCgrpVE5Qd78qJTQ3EKW+tjCHJ8qSod8
	dl6TFbGyuqkbyS0GVGoGsEpLC6pPLTkBcyHuRa6+xLpEhyQQn9ob8Nn2AEACM4qw
	83fpZlpZ2Jq2HFIrHLirg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1761169871; x=1761256271; bh=hbG6RsnJYSgulUi4OAThtCw5VfjfNUbCoBt
	c+xp3w7g=; b=mALDxU6u4ug2q5nX7gWT/vJIh6d0vG9Uvc5JMYJA3uJTNvCsLib
	Ve/F5d1pjFGtgsJEWbt7BYGmJSZeZQU21MTYI69+uvQZzKM5JkZYUFhmqTZkycKw
	rf3oDXBD36CjqV0bbYq8HqeBZiIirFG52+9oT82iPh3eegMNFHiPirjLnj+JhcDx
	bGS15bHLe9UFFXHnH8sSGsHrz4S6fRlQ4YhRT6TRQDhT/xVhsYBpolw9FfMB6qh9
	4btr4QsR/5i4rRjbVnTAujM7u3vXcmN2uaSWuiI20Qk+LGTGZVQ5G4UKJEEu3t0N
	XqdRZTIjbDCo78gxjLa+LRVCYZpIrChQ76Q==
X-ME-Sender: <xms:z1H5aDgBeJbVpYPQc3HyDm1m0Ah4srAcBpI8-VOzzFV-WXSAwOmmtg>
    <xme:z1H5aMZUsdIqPWc1T28tfF0nyA8jvli_GxJwWinLzoyA_F9jZoeP8V4zjdTqJY6bw
    fE_TPBrgqcJbpO8mHjQVq_pG0tW3eDAwiHImG2ga2mnqrw1fu7ZdQ>
X-ME-Received: <xmr:z1H5aHiN7iSEsq3N5bVg0KoKuUaTWa38zI3nI8C_UeUlzWOZ3JLT2ESyEZVy>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugeegjeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtrodttddtjeenucfhrhhomhepufgrsghrihhn
    rgcuffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrghilhdrnhgvtheqnecuggftrf
    grthhtvghrnhepveeileffffegueduleffgeeghefgkeffuedvhfehtdfgtdekhfetteef
    gfejueefnecuffhomhgrihhnpehrfhgtqdgvughithhorhdrohhrghenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsugesqhhuvggrshihshhn
    rghilhdrnhgvthdpnhgspghrtghpthhtohepudegpdhmohguvgepshhmthhpohhuthdprh
    gtphhtthhopeifihhlfhhrvggurdhophgvnhhsohhurhgtvgesghhmrghilhdrtghomhdp
    rhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtth
    hopehlihhnuhigqdguohgtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    lhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    eplhhinhhugidqkhhsvghlfhhtvghsthesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepvgguuh
    hmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomh
X-ME-Proxy: <xmx:z1H5aOYggQ4Ygt1qW_XonnaI6GpJqAXPmJEWdtMUsEXG5u_hsI59Rw>
    <xmx:z1H5aNNFWKVU6JEgDQIRy-U2SH5upapJCPrnrUE9zVJZOgke_SaOAg>
    <xmx:z1H5aPZwPClYIXUo-WhJpHVh-Zbmq_Az_8FN_Pqko_beIQnULEbkwg>
    <xmx:z1H5aNUhLOdncpxSvyrVjS7ZVDUND4f5K9JJ_ZQ3wPWwMKPhytDdMg>
    <xmx:z1H5aAZZ-fbRVkflSlAuwQk-Dme9ProS48-E9p_zqIcctenE6qOEE2nK>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Oct 2025 17:51:10 -0400 (EDT)
Date: Wed, 22 Oct 2025 23:51:09 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Wilfred Mallawa <wilfred.opensource@gmail.com>
Cc: netdev@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>, Simon Horman <horms@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>
Subject: Re: [PATCH net-next v8 1/2] net/tls: support setting the maximum
 payload size
Message-ID: <aPlRzZtmnbLJNzmR@krikkit>
References: <20251022001937.20155-1-wilfred.opensource@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251022001937.20155-1-wilfred.opensource@gmail.com>

2025-10-22, 10:19:36 +1000, Wilfred Mallawa wrote:
> From: Wilfred Mallawa <wilfred.mallawa@wdc.com>
> 
> During a handshake, an endpoint may specify a maximum record size limit.
> Currently, the kernel defaults to TLS_MAX_PAYLOAD_SIZE (16KB) for the
> maximum record size. Meaning that, the outgoing records from the kernel
> can exceed a lower size negotiated during the handshake. In such a case,
> the TLS endpoint must send a fatal "record_overflow" alert [1], and
> thus the record is discarded.
> 
> Upcoming Western Digital NVMe-TCP hardware controllers implement TLS
> support. For these devices, supporting TLS record size negotiation is
> necessary because the maximum TLS record size supported by the controller
> is less than the default 16KB currently used by the kernel.
> 
> Currently, there is no way to inform the kernel of such a limit. This patch
> adds support to a new setsockopt() option `TLS_TX_MAX_PAYLOAD_LEN` that
> allows for setting the maximum plaintext fragment size. Once set, outgoing
> records are no larger than the size specified. This option can be used to
> specify the record size limit.
> 
> [1] https://www.rfc-editor.org/rfc/rfc8449
> 
> Signed-off-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
> ---
> V7 -> V8:
>  - Fixup HTML doc indentation
>  - Drop the getsockopt() change in V7 where ContentType was included in the
>    max payload length
> ---
>  Documentation/networking/tls.rst | 20 ++++++++++
>  include/net/tls.h                |  3 ++
>  include/uapi/linux/tls.h         |  2 +
>  net/tls/tls_device.c             |  2 +-
>  net/tls/tls_main.c               | 64 ++++++++++++++++++++++++++++++++
>  net/tls/tls_sw.c                 |  2 +-
>  6 files changed, 91 insertions(+), 2 deletions(-)

Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>

Thanks Wilfred.

-- 
Sabrina

