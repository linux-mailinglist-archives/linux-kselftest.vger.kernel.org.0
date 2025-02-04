Return-Path: <linux-kselftest+bounces-25705-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03735A27788
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Feb 2025 17:50:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D788164C62
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Feb 2025 16:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37B57215776;
	Tue,  4 Feb 2025 16:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YCKSvpgv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF9DD86324;
	Tue,  4 Feb 2025 16:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738687812; cv=none; b=mc5noCZ5hN1RoCaMO7C7vg4pfITzfzjW4Y0xJbkx0p5EAduC9D8NLR85YfUXzmcKL4Rxy8xwEQ0J+blV87CPRkK+Wc4m1s7F7XeLNSeBtwskACKmg2dj8NeGyA8g8eFE4KOB0UgSaq6w03FN0yJsfdkDiId7g4NM85lPOjYHGjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738687812; c=relaxed/simple;
	bh=BkfYd3pmYoLUvBzp6+/u6N/oMS5/8X5zZnqyN2RPmV0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X9IINVT39kEQygfHA3w2rv62E/e3RAL8cLOy0CTCACITob+OTgpP1yq9GDiN6LfbIgk/X3uR9aO4O5cvJRwjSebzoSKajdPsCQZ9qViDoNuImF/JCj66EL4/jCCmOpRjfl6uR8xO3DKeSaWdMiWnWUWxAlmW44vd58R4IoIzwks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YCKSvpgv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3EE2C4CEDF;
	Tue,  4 Feb 2025 16:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738687811;
	bh=BkfYd3pmYoLUvBzp6+/u6N/oMS5/8X5zZnqyN2RPmV0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YCKSvpgvIUqCcTGoRbh7u2+tiVMkkY3DihyAOBu8YNyOYuZ/rwJWIeeg7OL6dEiRN
	 vpY4EQS3mc8diT8ZQsgudL68v28aWPiVsoHM2AHrutJOBu1C0+OneL/+qgBAgjwso2
	 VDVc6B9wT3hK4hS+4XH/XlnTw0Ivqirs+YCMfCEIRNQCEbDS50y5zhHF0Uxwi+3Mtx
	 R3eupjl5iXLpKZg4sy54Ml7aFLOY6wdbnnA8nZ2SJNSMMzWL9hbpdYJuFnaXcqjMF6
	 d08dO9VLGxqASNH5IR360DaFGB/6raWHmg2CuONKYL/IgieFWvZrFo64MarTf7KyVE
	 iaccKtSTOJQPg==
Date: Tue, 4 Feb 2025 08:50:08 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Mina Almasry <almasrymina@google.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 kvm@vger.kernel.org, virtualization@lists.linux.dev,
 linux-kselftest@vger.kernel.org, Donald Hunter <donald.hunter@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Simon Horman <horms@kernel.org>, Jonathan Corbet
 <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>, Neal Cardwell
 <ncardwell@google.com>, David Ahern <dsahern@kernel.org>, "Michael S.
 Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Xuan Zhuo
 <xuanzhuo@linux.alibaba.com>, Eugenio =?UTF-8?B?UMOpcmV6?=
 <eperezma@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Stefano
 Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>,
 sdf@fomichev.me, asml.silence@gmail.com, dw@davidwei.uk, Jamal Hadi Salim
 <jhs@mojatatu.com>, Victor Nogueira <victor@mojatatu.com>, Pedro Tammela
 <pctammela@mojatatu.com>, Samiullah Khawaja <skhawaja@google.com>
Subject: Re: [PATCH net-next v3 2/6] selftests: ncdevmem: Implement devmem
 TCP TX
Message-ID: <20250204085008.1adf89ea@kernel.org>
In-Reply-To: <c8dd0458-b0a9-4342-a022-487e73542381@redhat.com>
References: <20250203223916.1064540-1-almasrymina@google.com>
	<20250203223916.1064540-3-almasrymina@google.com>
	<c8dd0458-b0a9-4342-a022-487e73542381@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 4 Feb 2025 13:29:18 +0100 Paolo Abeni wrote:
> On 2/3/25 11:39 PM, Mina Almasry wrote:
> > Add support for devmem TX in ncdevmem.
> > 
> > This is a combination of the ncdevmem from the devmem TCP series RFCv1
> > which included the TX path, and work by Stan to include the netlink API
> > and refactored on top of his generic memory_provider support.
> > 
> > Signed-off-by: Mina Almasry <almasrymina@google.com>
> > Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>  
> 
> Usually the self-tests are included towards the end of the series, to
> help reviewers building-up on previous patches knowledge.

I had the same reaction, but in cases where uAPI is simpler than 
the core code it may actually help the understanding to start with
the selftest. Dunno. Only concern would be that the test won't work
if someone bisects to this commit, but that's not very practical?

