Return-Path: <linux-kselftest+bounces-37030-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 53C81B009E2
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 19:28:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58B171AA4437
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 17:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CBD82F0C54;
	Thu, 10 Jul 2025 17:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DLZQuBOV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 368E4199BC;
	Thu, 10 Jul 2025 17:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752168508; cv=none; b=EAhy1XEIZqdRMyD+HLNQO/sQ5+4jXiTHzC/R1Cc7ugSid/v7ZxJ2DCf/+3sboVNvlVPT6HEThK7YOSWg7fBN05Va73YTUAHY+OIGBAI4x3JoO9MlxKOWLrDHWju8hOVpQfwANf7auQ4pVRWGXfIx8ce9+lk9BmtnAz1ruVeHbZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752168508; c=relaxed/simple;
	bh=AwA55W9+gm6iz71BET86U2X3eLl34NRDjvbJ7Mlg8hY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QQIORf400a6HoAQIGMAk7Si7NjL+HZsCBYOSpeyith9Rspt9KPIo56Wrod/0co5XAq0Kb0emDw2TTc1qdOkh76GdDGCdaIHVreWJDpoB3zvozc0AfjaYHm+HiqO18PGfugiyJIplhNiS3YLhvNshTZ9kvO0JzwfpN4ckXE60b8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DLZQuBOV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B8EAC4CEE3;
	Thu, 10 Jul 2025 17:28:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752168507;
	bh=AwA55W9+gm6iz71BET86U2X3eLl34NRDjvbJ7Mlg8hY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DLZQuBOVM7z1ub2QZgn2BpMj8Mw6rEWAZRIgkLTzSnC0YzSoJ+l/RaD7QSlPNWO0a
	 1hEqUU40KmqWac29DAzk0nhlUvSZkE1UuLq0YU3wih+nQbfV7TqPeVqNaDcAiq3JqK
	 HUwz+pbBLYyAhQYfonu1/mrcxno2mCwQ3s79NuvfAykZxbZw4+jx3EmQ5tQ5MY9y9h
	 DgRXW2Mg4Pj9oZhCwbX6Pw2odh8+K+B7xfhLItEaadqoLxh80uQVCi3O7KpMzd1e2Z
	 KMnbGjDT022efxgRxdHJrXVPytF7XUnK6ZsWl5FzC1ZWkXhZ2O/EbvLTRyzgjS+5JK
	 sfRNwXFE17f3Q==
Date: Thu, 10 Jul 2025 10:28:25 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Song, Yoong Siang" <yoong.siang.song@intel.com>
Cc: Stanislav Fomichev <stfomichev@gmail.com>, Daniel Borkmann
 <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, "David S
 . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jonathan Corbet
 <corbet@lwn.net>, Alexei Starovoitov <ast@kernel.org>, John Fastabend
 <john.fastabend@gmail.com>, "Stanislav Fomichev" <sdf@fomichev.me>, Andrii
 Nakryiko <andrii@kernel.org>, "Martin KaFai Lau" <martin.lau@linux.dev>,
 Eduard Zingerman <eddyz87@gmail.com>, "Song Liu" <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, Hao
 Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko
 <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, Magnus Karlsson
 <magnus.karlsson@gmail.com>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@kernel.org>, "Fijalkowski, Maciej" <maciej.fijalkowski@intel.com>,
 Jonathan Lemon <jonathan.lemon@gmail.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "linux-doc@vger.kernel.org"
 <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "bpf@vger.kernel.org"
 <bpf@vger.kernel.org>, "linux-kselftest@vger.kernel.org"
 <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH bpf-next,v3 2/2] selftests/bpf: Enhance XDP Rx metadata
 handling
Message-ID: <20250710102825.744f2653@kernel.org>
In-Reply-To: <IA3PR11MB92540CF6DB5BCFD34384A280D848A@IA3PR11MB9254.namprd11.prod.outlook.com>
References: <20250702165757.3278625-1-yoong.siang.song@intel.com>
	<20250702165757.3278625-3-yoong.siang.song@intel.com>
	<77463344-1b1a-443a-97be-a7ef8a88b8af@kernel.org>
	<IA3PR11MB92546301B67FB3A9FDCD716DD842A@IA3PR11MB9254.namprd11.prod.outlook.com>
	<88a64a65-bd8c-4b73-af19-6764054d4572@kernel.org>
	<f5d724ab-0eb6-41a1-b694-8aea566e99ab@iogearbox.net>
	<aGvhzDLSuOolCCWW@mini-arch>
	<27edae8a-f1a8-4000-ac1e-fd4d5b01e807@iogearbox.net>
	<aG6Y1J9Li2DdjqWv@mini-arch>
	<IA3PR11MB92540CF6DB5BCFD34384A280D848A@IA3PR11MB9254.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 10 Jul 2025 15:35:32 +0000 Song, Yoong Siang wrote:
> Would it be advisable to update the documentation to indicate that
> drivers are expected to copy any device-reserved metadata from the
> metadata area? This would ensure that xdp_buff->data_meta is equal
> to xdp_buff->data before a BPF program is executed. This approach
> would allow BPF programs to freely manipulate the metadata area
> in XDP_REDIRECT scenarios.

Documenting sounds good.

> Additionally, I am uncertain about the need to overriding metadata in
> XDP_PASS scenarios. Should BPF programs refrain from overriding the
> metadata in this case?

IIRC XDP_PASS was the initial use case for the metadata area.
The driver needs to evacuate any HW metadata before handing over
to the XDP program.

