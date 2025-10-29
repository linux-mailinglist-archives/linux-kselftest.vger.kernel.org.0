Return-Path: <linux-kselftest+bounces-44364-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42409C1DB29
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Oct 2025 00:37:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B96C3ACC77
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Oct 2025 23:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91AB33126A3;
	Wed, 29 Oct 2025 23:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TECs7yeM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A13283FEA;
	Wed, 29 Oct 2025 23:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761781065; cv=none; b=FEN8fj5zCycjH27NC5WI7BQ0/02Q7kRcrl2mgCInylS9mhcn0ID0Ne3T5o7ks8LxBiuv5fJokxGjGuyIjaGjt3v7nTdWmDspGJEPjQD/yCOIghiyu03qiYoxUEDMrPhw4qiaInISY2SoJjsf4POpQBX0t0TdawMjW1TtRjT4LGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761781065; c=relaxed/simple;
	bh=m1IJ3wz/HYcYihE+8vU8MyPQBw9ffxLK5KkdfAv1QvU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bsf9tF2rVKwMNJUUUyuxdee76LbbpLxbanFJOILMNRgS3ClNYB2+TVsWcNyoehhsCtUGduS7L2GNCN4rIqUqDSSjdvCZNIkRn2YmpaKsf+PWXC7RJp0rI+7ekYrmpXCRA264kodaj5DjfYknMUH6G10Wuk8e28FZlRqXJmK9XKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TECs7yeM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DAEDC4CEF7;
	Wed, 29 Oct 2025 23:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761781065;
	bh=m1IJ3wz/HYcYihE+8vU8MyPQBw9ffxLK5KkdfAv1QvU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TECs7yeMNwVkBCp8r74tqDLyQ0eq5Is8+FrKb302/MG5MLEAlJJqaulE1XI0Npd78
	 NQSFYTF3owwzz9jIAzHz+NCjL77APXSlqYI9VEQ1u9i6EPJw7CVCSrJa8l5SdeNMM4
	 YV8YX3ZbKXGXGO8/CvBbkA9xgE10hUKWIbigy/rhUyERxw2HH4q/IdS95UpdEehYTC
	 283x+OLO8u2MeFPyYdztTola032beAOtmJgyMHr+ePpx4KWOXbJFlBCUEEKhJGcb8f
	 tk+1FzLue3w2Cv1RzK3X6ugI1T4y1WO3jln8SgHbO477qTPVKH+DLgDmT62lDQd84O
	 v2wb8BISZ6Rag==
Date: Wed, 29 Oct 2025 16:37:42 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, Donald Hunter <donald.hunter@gmail.com>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jan Stancek
 <jstancek@redhat.com>, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
 =?UTF-8?B?QXNiasO4cm4=?= Sloth =?UTF-8?B?VMO4bm5lc2Vu?= <ast@fiberby.net>,
 Stanislav Fomichev <sdf@fomichev.me>, Shuah Khan <shuah@kernel.org>, Ido
 Schimmel <idosch@nvidia.com>, Guillaume Nault <gnault@redhat.com>, Petr
 Machata <petrm@nvidia.com>, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next 2/3] netlink: specs: update rt-rule src/dst
 attribute types to support IPv4 addresses
Message-ID: <20251029163742.3d96c18d@kernel.org>
In-Reply-To: <20251029082245.128675-3-liuhangbin@gmail.com>
References: <20251029082245.128675-1-liuhangbin@gmail.com>
	<20251029082245.128675-3-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 29 Oct 2025 08:22:44 +0000 Hangbin Liu wrote:
>        -
>          name: dst
> -        type: u32
> +        type: binary
> +        display-hint: ipv4
>        -
>          name: src
> -        type: u32
> +        type: binary
> +        display-hint: ipv4

This will be annoying For C / C++, and you didn't set the max len 
so I think we'll also have to malloc each time. Do we not support
display-hint for scalars?

