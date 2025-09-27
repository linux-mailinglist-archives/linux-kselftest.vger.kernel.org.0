Return-Path: <linux-kselftest+bounces-42515-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49572BA56DD
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Sep 2025 02:41:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F241B4C52C6
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Sep 2025 00:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0527B1D6193;
	Sat, 27 Sep 2025 00:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gUxvY52P"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC307282E1;
	Sat, 27 Sep 2025 00:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758933680; cv=none; b=TG5veg4dR+FcR1I5Qn6m6OZDV2dLAlXxe7dbYuDJxAaZsn6EV5vV4dktnfdJNUQaLgXBAOTcT3zLHs6lkdT5FL4StsErbb8u68FSt4IgkxhYMWAprOIkTIgJFdBQIXUs7KihXz53CT1pGBzChYhpHnSxFOMm5Oa5e++GL6C6+OM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758933680; c=relaxed/simple;
	bh=g5wTDCdkm3VSKuvWD/nVJLosXsdzTuSUkxk7ig06G1s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fhEBoaC2x1nUvy+x3BijKRI8/Day+54v7XC44eqxmr4Ii9GvnBTTHKgGlC8JzHtS8br+d6il1GzHPG6VL1mjo5q1ZwDro1rRr7XkUA4C2lpYFhESE8AV1+a1yuCbxHzPKlIQqp8wQjhOyPz2/nkh41XHoggahV8wfbDrfrIFz8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gUxvY52P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 886A7C4CEF4;
	Sat, 27 Sep 2025 00:41:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758933680;
	bh=g5wTDCdkm3VSKuvWD/nVJLosXsdzTuSUkxk7ig06G1s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gUxvY52P2ChIDgRfp15cahlHnhYPmWDcS4EjNqQtUPZQt6w+kZVK/ahEnvtBxLLW4
	 e9vu9m2OpUpb5yINGjZIJNCXOcR4BhfXYX8U9OBLXXCQdmJid0zBM9F1GLnHBm3Sc/
	 gFLFFBwDH2glgqyCvuuJn3atl0PfZ7Rbn8VyDksJX4ZkQcpvYrwTYybYCYGQfUeFAZ
	 0ScdHjwj49rJ2thZLAk4Bm4GASGcFtrh6pKnoNPSeb79S7Cf2Y5T8+fHt9dqxk6rb1
	 E/X4ez/ai13eqL+oWaJca3y6UB0bgmHtqmW0ns2gqysftVBocBxVMb9JbDZSu06R/S
	 qBiUApX0Zz21A==
Date: Fri, 26 Sep 2025 17:41:18 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>, Donald Hunter
 <donald.hunter@gmail.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, Alexander Lobakin
 <aleksander.lobakin@intel.com>, Andrii Nakryiko <andrii@kernel.org>, Martin
 KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP
 Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, Maciej Fijalkowski
 <maciej.fijalkowski@intel.com>, netdev@vger.kernel.org,
 bpf@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH RFC bpf-next v2 1/5] netlink: specs: Add XDP RX checksum
 capability to XDP metadata specs
Message-ID: <20250926174118.23a054a7@kernel.org>
In-Reply-To: <0608935c-1c1c-4374-a058-bc78d114c630@kernel.org>
References: <20250925-bpf-xdp-meta-rxcksum-v2-0-6b3fe987ce91@kernel.org>
	<20250925-bpf-xdp-meta-rxcksum-v2-1-6b3fe987ce91@kernel.org>
	<0608935c-1c1c-4374-a058-bc78d114c630@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 26 Sep 2025 11:53:25 +0200 Jesper Dangaard Brouer wrote:
> What do people think: Do we leave it as an exercise to the BPF-developer
> to deduct hardware detected a wrong/failed checksum, as that is possible
> as described above.  Or do we introduce a CHECKSUM_FAILED?

I vote we leave it unless someone has a strong use case for FAILED.
Checksumming and dropping packets should be pretty cheap, it's not
worth complicating the stack with another option.

