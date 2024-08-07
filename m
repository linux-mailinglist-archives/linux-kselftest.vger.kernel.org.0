Return-Path: <linux-kselftest+bounces-14912-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE6A1949EC0
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Aug 2024 06:08:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DE671C21612
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Aug 2024 04:08:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A310818FC92;
	Wed,  7 Aug 2024 04:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p+AJDbm4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7485C1C14;
	Wed,  7 Aug 2024 04:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723003702; cv=none; b=KcJo3do3cO6oh+NzEHLFyv89o40K7ZDMcSKV/viFcr/vP4ffmKTW/M65fn8e+SxZZ6PjLfzIMZbeKtjAX+s8Pp1UjYwMiblyQuykqVduI5/H3JvV30tbnyjzk7JlmxAwBR6UWhAThYbextOiir2c2CnhWZp26VdgIxWNaOE6JiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723003702; c=relaxed/simple;
	bh=ixX/BQtbYtEjnwzVtBFFECIdYOi0rCzgZaotQCORbNY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FiICjSma75vIUq3yj8jo+JMmrAdXwCdrRr7MvWEJezpx8m8qRURl3l+n7xJ94GRMvvfy5am9o8P6hku7Vx7Mi7bNud0LdXfFYS4Iy3F4mg69UPhviT/qgaOWewMb76Tjwyvs36ocJMTUG4G6GQbDb1cdxIKGCuCmTN270KDrzlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p+AJDbm4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CEF9C32782;
	Wed,  7 Aug 2024 04:08:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723003702;
	bh=ixX/BQtbYtEjnwzVtBFFECIdYOi0rCzgZaotQCORbNY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=p+AJDbm4ZUXD104hjmNP1kwgWALiRLqUxk6Rw3DQiH1/90s0uxxlh8uB8vbGbUlUv
	 OhljOWrHnRoQ4GO73TxnWHxO/2Jkq0Pi2iD1S5W9hFF69fQTKE0ACPCmn+sBBuxoHQ
	 MG931Ar2z6/CtQhlLS9EQtDL+yRl3OMbQHX5lJIFKw1PfY4rXma2bG4sS+x6sXPwet
	 DhRiru5YF0A8+hvW3xKCK3Wk1OnWehMAI3v468euDA5jFSU2yDtrzbb1NqZymjdXFT
	 NMFrrFjLhz9IafOWBYxbIHCqOdT9AybaP2zPTTT2QxfCaEgdqGbbn2LMjsVWf7TSrM
	 T6VVyaw2ifqIg==
Message-ID: <a22d9e0eb835e40000bc1955b57ae115ae44353c.camel@kernel.org>
Subject: Re: [PATCH net-next] selftests: forwarding: lib.sh: ignore "Address
 not found"
From: Geliang Tang <geliang@kernel.org>
To: Ido Schimmel <idosch@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>,  Petr Machata
 <petrm@nvidia.com>, Hangbin Liu <liuhangbin@gmail.com>, Benjamin Poirier
 <bpoirier@nvidia.com>,  Jiri Pirko <jiri@resnulli.us>, Vladimir Oltean
 <vladimir.oltean@nxp.com>, Geliang Tang <tanggeliang@kylinos.cn>,
 netdev@vger.kernel.org,  linux-kselftest@vger.kernel.org
Date: Wed, 07 Aug 2024 12:08:15 +0800
In-Reply-To: <ZrHTafNilRs6dx6E@shredder.mtl.com>
References: 
	<764585b6852537a93c6fba3260e311b79280267a.1722917654.git.tanggeliang@kylinos.cn>
	 <ZrHTafNilRs6dx6E@shredder.mtl.com>
Autocrypt: addr=geliang@kernel.org; prefer-encrypt=mutual;
 keydata=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
 Px+2P2cKc7LXXedb/qQ3M
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.52.0-1build2 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Ido,

Thanks for the review.

On Tue, 2024-08-06 at 10:40 +0300, Ido Schimmel wrote:
> On Tue, Aug 06, 2024 at 12:20:38PM +0800, Geliang Tang wrote:
> > From: Geliang Tang <tanggeliang@kylinos.cn>
> > 
> > So many "Address not found" messages occur at the end of forwarding
> > tests
> > when using "ip address del" command for an invalid address:
> 
> Can you give an example of an invalid address that triggers this
> message?
> 
> > 
> > TEST: FDB limits interacting with FDB type local                   
> > [ OK ]
> > Error: ipv4: Address not found.
> > 
> > ... ...
> > TEST: IGMPv3 S,G port entry automatic add to a *,G port            
> > [ OK ]
> > Error: ipv4: Address not found.
> > Error: ipv6: address not found.
> > 
> > ... ...
> > TEST: Isolated port flooding                                       
> > [ OK ]
> > Error: ipv4: Address not found.
> > Error: ipv6: address not found.
> > 
> > ... ...
> > TEST: Externally learned FDB entry - ageing & roaming              
> > [ OK ]
> > Error: ipv4: Address not found.
> > Error: ipv6: address not found.
> 
> I'm unable to reproduce these with net-next and iproute2-next. Please
> debug this to understand the root cause or provide more details on
> how
> to reproduce.

I did get these errors with the latest net-next and iproute2-next. For
example, I got these errors of "bridge_mdb_port_down.sh":

$ sudo ./bridge_mdb_port_down.sh 
TEST: MDB add/del entry to port with state down                  [ OK ]
Error: ipv4: Address not found.
Error: ipv6: address not found.
Error: ipv4: Address not found.
Error: ipv6: address not found.

These errors occur when using h1_destroy() and h2_destroy() to delete
the addresses of h1 (192.0.2.1, 2001:db8:1::1) and h2 (192.0.2.2,
2001:db8:1::2):

h1_destroy()
{
        simple_if_fini $h1 192.0.2.1/24 2001:db8:1::1/64
}

h2_destroy()
{
        simple_if_fini $h2 192.0.2.2/24 2001:db8:1::2/64
}

It seems that when invoking h1_destroy() and h2_destroy(), both h1 and
h2 no longer have IP addresses.

I added "ifconfig" to show the addresses of h1 and h2 before invoking
h1_destroy() and h2_destroy() like this:

'''
@@ -105,7 +105,9 @@ cleanup()
        pre_cleanup
 
        switch_destroy
+       ifconfig $h1
        h1_destroy
+       ifconfig $h2
        h2_destroy
 
        vrf_cleanup
'''

And got these messages:

TEST: MDB add/del entry to port with state down                 [ OK ]
veth0: flags=4099<UP,BROADCAST,MULTICAST>  mtu 1500
        ether f2:ca:02:ee:05:19  txqueuelen 1000  (Ethernet)
        RX packets 149  bytes 17355 (17.3 KB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 81  bytes 9165 (9.1 KB)
        TX errors 0  dropped 12 overruns 0  carrier 0  collisions 0

Error: ipv4: Address not found.
Error: ipv6: address not found.
veth3: flags=4099<UP,BROADCAST,MULTICAST>  mtu 1500
        ether 92:df:97:5c:98:7e  txqueuelen 1000  (Ethernet)
        RX packets 67  bytes 6252 (6.2 KB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 39  bytes 4997 (4.9 KB)
        TX errors 0  dropped 56 overruns 0  carrier 0  collisions 0

Error: ipv4: Address not found.
Error: ipv6: address not found.

-Geliang

> 
> > 
> > This patch gnores these messages and redirects them to /dev/null in
> > __addr_add_del().
> > 
> > Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> > ---
> >  tools/testing/selftests/net/forwarding/lib.sh | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/tools/testing/selftests/net/forwarding/lib.sh
> > b/tools/testing/selftests/net/forwarding/lib.sh
> > index ff96bb7535ff..8670b6053cde 100644
> > --- a/tools/testing/selftests/net/forwarding/lib.sh
> > +++ b/tools/testing/selftests/net/forwarding/lib.sh
> > @@ -839,7 +839,7 @@ __addr_add_del()
> >  	array=("${@}")
> >  
> >  	for addrstr in "${array[@]}"; do
> > -		ip address $add_del $addrstr dev $if_name
> > +		ip address $add_del $addrstr dev $if_name &>
> > /dev/null
> >  	done
> >  }
> >  
> > -- 
> > 2.43.0
> > 


