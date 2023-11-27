Return-Path: <linux-kselftest+bounces-620-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C67B47F9790
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Nov 2023 03:42:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 511F8B20A0D
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Nov 2023 02:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20260A3F;
	Mon, 27 Nov 2023 02:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AFTAPfku"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B7610F3;
	Mon, 27 Nov 2023 02:42:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEAE6C433C7;
	Mon, 27 Nov 2023 02:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701052958;
	bh=IuRSheeNrDhtwvIStpJFQHRM3Y4QhShtdM7feP48aqM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=AFTAPfkuisTvtDVc1eMYWjcNYv5R137b26o9c4RCIX9n7+1JYJ52xvzODbuRH9Wba
	 oS9Ziu2KJQrloweGAu6qxid8ofVs/5utjrVUkyjihxMxV2mKtPjIxgG135L6cXZHql
	 Zhis+62r+IQW29N/1812rSXEtHAoOnz4d0y0E5lhc5jX2/nKcOREDt1IUwXXMmt3aV
	 OoRuMceZRaSFMVJaz3+aVUhsu8yuj1Dq3pDZihHvz1TQ8ouhHEujWwCH5pzJISEqGN
	 uGKc7rmlIrRKb6H9gAUjoqrcw5m2Ny6K/DwN9VoimBGkvpZALCtMaXqw6ZnpYJpY6l
	 hT+AgLIB4v49A==
Message-ID: <7b69805c-f48b-48f7-8d04-fd385ed2193f@kernel.org>
Date: Sun, 26 Nov 2023 19:42:36 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 00/38] Conver all net selftests to run in unique
 namespace
To: Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>,
 linux-kselftest@vger.kernel.org, Po-Hsu Lin <po-hsu.lin@canonical.com>,
 Guillaume Nault <gnault@redhat.com>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@rivosinc.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>, Mark Brown <broonie@kernel.org>,
 Luis Chamberlain <mcgrof@kernel.org>
References: <20231124092736.3673263-1-liuhangbin@gmail.com>
Content-Language: en-US
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20231124092736.3673263-1-liuhangbin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/24/23 2:26 AM, Hangbin Liu wrote:
> As Guillaume pointed, many selftests create namespaces with very common
> names (like "client" or "server") or even (partially) run directly in init_net.
> This makes these tests prone to failure if another namespace with the same
> name already exists. It also makes it impossible to run several instances
> of these tests in parallel.
> 
> This patch set conver all the net selftests to run in unique namespace,
> so we can update the selftest freamwork to run all tests in it's own namespace
> in parallel. After update, we only need to wait for the test which need
> longest time.
> 
> ]# per_test_logging=1 time ./run_kselftest.sh -n -c net
> TAP version 13
> # selftests: net: reuseport_bpf_numa
> not ok 3 selftests: net: reuseport_bpf_numa # exit=1
> # selftests: net: reuseport_bpf_cpu
> not ok 2 selftests: net: reuseport_bpf_cpu # exit=1
> # selftests: net: reuseport_dualstack
> not ok 4 selftests: net: reuseport_dualstack # exit=1
> # selftests: net: reuseaddr_conflict
> ok 5 selftests: net: reuseaddr_conflict
> 
> ...
> 
> # selftests: net: test_vxlan_mdb.sh
> ok 90 selftests: net: test_vxlan_mdb.sh
> # selftests: net: fib_nexthops.sh
> not ok 41 selftests: net: fib_nexthops.sh # exit=1
> # selftests: net: fcnal-test.sh
> not ok 36 selftests: net: fcnal-test.sh # exit=1
> 
> real    55m1.238s
> user    12m10.350s
> sys     22m17.432s
> 
> 

I have not looked at the details of each script change, but as long as
not test is broken by the change I am fine with the intent.

Acked-by: David Ahern <dsahern@kernel.org>



