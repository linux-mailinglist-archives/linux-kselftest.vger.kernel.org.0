Return-Path: <linux-kselftest+bounces-36729-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 768A9AFBCF1
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Jul 2025 22:55:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80CAC17DA2E
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Jul 2025 20:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C9CF26E703;
	Mon,  7 Jul 2025 20:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uF07XEBu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2787426E6E9;
	Mon,  7 Jul 2025 20:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751921709; cv=none; b=G0flIIJM17BXYsjZzj+25CCqmswY+D5kLcy84lb+lvzxO2ADMccoe5MzNv3BqMrozhauF7pQg+PD5nmQ7hEpJKPewJ4uev6UIBsrlCkgVB5ZKeWqTJbQr3KgtLiEZlA2pQwOa2V6mVAb2d5s2rLRPCoxPTKwWSP91Iv5kUK0dS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751921709; c=relaxed/simple;
	bh=0jxuX3ETarqAfuwfV1mmeo6yur/8SCAhFLaEndL8th8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K3CmpveqD/b4HVg3Cl4HkZODcusBq6ZA6Hh4XzgodrlQIohCi5j53hQ1+hsFQOsPz/59Ykuw9VoT6VDjqoCSaTwxRU+NAuqhBi1Pej0pjnnrjXTK1yXcO+W0KP8wYEcQbA+JF0T1ay3qGYYq8sUfGI4GS13uSPE7FNKjHtaZAEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uF07XEBu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E828EC4CEE3;
	Mon,  7 Jul 2025 20:55:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751921708;
	bh=0jxuX3ETarqAfuwfV1mmeo6yur/8SCAhFLaEndL8th8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uF07XEBucRV/vaHkfTH0cj5XxSmgFEvnPX0H7218Qup4BYKVm/YnIYAkHjKu9gky7
	 OP8vAO7LI+PM1itArtsorrcUJZ03sJpYksshwJW7qE+eK5qX//lxKVwFiuMitB9JjV
	 15Mzahx873msG90F4jMxaBivjf6DzhnuO6sJVULFqZ9OsQvqG0fQuwz6m9IIfWnB08
	 4YN2E868e+Uk4PogV7LyVSssWBMMbGv3PH9NShRJR3k7K50FgLo3rYFMmhjlAFGgML
	 hsF9pLumh7MDHhKaeVgfSBLdjih+yyRv0J/LeS68PNPuz8v+ZdGmCLy8DjAuBNRJVA
	 WGQ6N++ObgWkw==
Date: Mon, 7 Jul 2025 13:55:07 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Song Yoong Siang <yoong.siang.song@intel.com>
Cc: "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard
 Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko
 <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf-next 0/2] Clarify and Enhance XDP Rx Metadata
 Handling
Message-ID: <20250707135507.29cb55be@kernel.org>
In-Reply-To: <20250701042940.3272325-1-yoong.siang.song@intel.com>
References: <20250701042940.3272325-1-yoong.siang.song@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  1 Jul 2025 12:29:38 +0800 Song Yoong Siang wrote:
>                         |<---sizeof(xdp_meta)--|
>                         |                      |
>                  struct xdp_meta               rx_desc->address
>                         ^                      ^
>                         |                      |
> +----------+----------------------+------------+------+
> | headroom |    custom metadata   |  reserved  | data |
> +----------+----------------------+------------+------+
>            ^                      ^            ^
>            |                      |            |
>     struct xdp_meta     xdp_buff->data_meta    xdp_buff->data
>            |                      |
>            |<---sizeof(xdp_meta)--|

Huh. Did AF_XDP maintainers explicitly sign off on this or it's just how
IGC implementation works and nobody noticed?

For normal XDP my understanding is that its the driver's responsibility
to move the "reserved" stuff out of place before presenting the frame to
program.

