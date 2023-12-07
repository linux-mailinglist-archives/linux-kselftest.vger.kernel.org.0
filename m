Return-Path: <linux-kselftest+bounces-1366-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EC0B808BC3
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Dec 2023 16:26:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0DC2B20F63
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Dec 2023 15:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37C7A44C84;
	Thu,  7 Dec 2023 15:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="my8BzQNp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1349A4185B;
	Thu,  7 Dec 2023 15:26:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36AA7C433C8;
	Thu,  7 Dec 2023 15:26:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701962775;
	bh=usRReFCixNKtJkH4TXHx9VWzuWKM1CKrDYSp1IErqio=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=my8BzQNp7/cQN2skGkWsuoIacaJhSXW6GMSFzDZ51jw1r44zEXa4vOxEcdXjrlEc5
	 w6zgUN1lOrvQuoIq8iJOv03Svf3XEpVrpAL2c1oqB0zl+xBfPLKErN5aejVC1J5mJ+
	 J6FeP2lI1WtVg6V8ZZ1R9yzLQPXmnchAmUuaIZURzEq6CsetClJjrG7v1dlRBxa+u5
	 bWtboT2+wODnfwf5yj9y892ulJ8KhA4lvXFpiyZ13Yl9wBNz3gOcVWiu7Lq0dl7Fb1
	 2WYHQjdUAo/W/AFnn+AL3IbaBK0WYcXAUgLHjROxmBQQ1MJxp6LmGX6z4uKflhcYID
	 NA75vLQ/tdDjw==
Message-ID: <72056882-acd4-48e2-a688-b0c0e7e88ab0@kernel.org>
Date: Thu, 7 Dec 2023 08:26:14 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv3 net-next 01/14] selftests/net: add lib.sh
Content-Language: en-US
To: Petr Machata <petrm@nvidia.com>, Paolo Abeni <pabeni@redhat.com>
Cc: Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Shuah Khan <shuah@kernel.org>,
 linux-kselftest@vger.kernel.org, Po-Hsu Lin <po-hsu.lin@canonical.com>,
 Guillaume Nault <gnault@redhat.com>, James Prestwood <prestwoj@gmail.com>,
 Jaehee Park <jhpark1013@gmail.com>, Ido Schimmel <idosch@nvidia.com>,
 Justin Iurman <justin.iurman@uliege.be>, Xin Long <lucien.xin@gmail.com>,
 James Chapman <jchapman@katalix.com>
References: <20231202020110.362433-1-liuhangbin@gmail.com>
 <20231202020110.362433-2-liuhangbin@gmail.com>
 <7e73dbfe6cad7d551516d02bb02881d885045498.camel@redhat.com>
 <87jzpr5x0r.fsf@nvidia.com>
 <70497ad83be1c7bd715abc8f29c72ee39a381f58.camel@redhat.com>
 <87y1e646cd.fsf@nvidia.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <87y1e646cd.fsf@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/7/23 3:34 AM, Petr Machata wrote:
> But what I object against is that the library uses trap without having a
> way for user scripts to schedule at-exit work, because that's used
> literally everywhere in forwarding tests. 

+1

