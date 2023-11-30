Return-Path: <linux-kselftest+bounces-887-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD6127FF051
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Nov 2023 14:38:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF2431C20DFC
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Nov 2023 13:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC698482C4;
	Thu, 30 Nov 2023 13:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b="OWghkhHd"
X-Original-To: linux-kselftest@vger.kernel.org
X-Greylist: delayed 554 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 30 Nov 2023 05:38:10 PST
Received: from serv108.segi.ulg.ac.be (serv108.segi.ulg.ac.be [139.165.32.111])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F0B910D5;
	Thu, 30 Nov 2023 05:38:10 -0800 (PST)
Received: from [192.168.1.55] (125.179-65-87.adsl-dyn.isp.belgacom.be [87.65.179.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by serv108.segi.ulg.ac.be (Postfix) with ESMTPSA id 04E2E200CCEC;
	Thu, 30 Nov 2023 14:28:53 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 serv108.segi.ulg.ac.be 04E2E200CCEC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uliege.be;
	s=ulg20190529; t=1701350933;
	bh=yEf+RebkcIT37fxi/jtCy8qZ4gAHzzGnKtpP5kElZQ0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=OWghkhHdabnD77lXSbGWmfVtjLhHaYJwprfsBZO+XUl8JB9IBSWarPASzpGpACt7a
	 ynH1eEqfWLOGtCcuH38K7aYxzZfRrRjjszcxMDWocGJ/OJ919dOoOrHU5aMPoLQ0Qu
	 PZS7q4Ji/5hnBqvykZQ9vd6uuCm9Ethviyajo0oszY/3186ZoDk/cYuuz2doxOzdtw
	 bRPF5E5ZZ5c23YN8rY7q4kkuthVlxM6Nv/8VucP553bHfNSXNK8ynMRP01aR/Kcva3
	 ho7KFe0N6ekdDDrnPKVBQ61RWqW39tNfc8OoxLRt3HoNR8qxxTvR0vmngqDmfzYuZK
	 Dm9U2IvKCofGQ==
Message-ID: <4ab6e843-fd60-4abf-a23f-c8032e617f5c@uliege.be>
Date: Thu, 30 Nov 2023 14:28:51 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 net-next 10/14] selftests/net: convert ioam6.sh to run
 it in unique namespace
To: Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>,
 David Ahern <dsahern@kernel.org>, linux-kselftest@vger.kernel.org,
 Po-Hsu Lin <po-hsu.lin@canonical.com>, Guillaume Nault <gnault@redhat.com>,
 Petr Machata <petrm@nvidia.com>, James Prestwood <prestwoj@gmail.com>,
 Jaehee Park <jhpark1013@gmail.com>, Ido Schimmel <idosch@nvidia.com>,
 Francesco Ruggeri <fruggeri@arista.com>, Xin Long <lucien.xin@gmail.com>,
 justin.iurman@uliege.be
References: <20231130040105.1265779-1-liuhangbin@gmail.com>
 <20231130040105.1265779-11-liuhangbin@gmail.com>
Content-Language: en-US
From: Justin Iurman <justin.iurman@uliege.be>
In-Reply-To: <20231130040105.1265779-11-liuhangbin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/30/23 05:01, Hangbin Liu wrote:
> Here is the test result after conversion.
> 
> ]# ./ioam6.sh
> 
> --------------------------------------------------------------------------
> OUTPUT tests
> --------------------------------------------------------------------------
> TEST: Unknown IOAM namespace (inline mode)                          [ OK ]
> TEST: Unknown IOAM namespace (encap mode)                           [ OK ]
> TEST: Missing trace room (inline mode)                              [ OK ]
> TEST: Missing trace room (encap mode)                               [ OK ]
> TEST: Trace type with bit 0 only (inline mode)                      [ OK ]
> ...
> TEST: Full supported trace (encap mode)                             [ OK ]
> 
> --------------------------------------------------------------------------
> GLOBAL tests
> --------------------------------------------------------------------------
> TEST: Forward - Full supported trace (inline mode)                  [ OK ]
> TEST: Forward - Full supported trace (encap mode)                   [ OK ]
> 
> - Tests passed: 88
> - Tests failed: 0
> 
> Acked-by: David Ahern <dsahern@kernel.org>
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>

Reviewed-by: Justin Iurman <justin.iurman@uliege.be>

LGTM. Just one question though. Is there any reason not to use 
cleanup_ns everywhere? There is the following diff (actually, 3 times):

> -    ip netns del ioam-tmp-node || true
> +    ip netns del $ioam_tmp_node || true

While, at the same time, there is the following diff (as expected):

> -  ip netns del ioam-node-alpha || true
> -  ip netns del ioam-node-beta || true
> -  ip netns del ioam-node-gamma || true
> +  cleanup_ns $ioam_node_alpha $ioam_node_beta $ioam_node_gamma

IMO, it looks like cleanup_ns can safely replace all "ip netns del" 
instances in ioam6.sh.

