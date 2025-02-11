Return-Path: <linux-kselftest+bounces-26341-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1756BA3071F
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 10:30:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 580F7167070
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 09:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 130AB1F2364;
	Tue, 11 Feb 2025 09:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b="alM7hX1q"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E76B1F0E5C;
	Tue, 11 Feb 2025 09:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739266211; cv=none; b=i37u2eVegp3lzUdLpUQjhCmujGCy5EuoA29RCwsvc/1lh1eGorllebBUxGKEPugv/D/HUhWYSj2O9Ez0+tdjYaLDvqBCEtQ0Il0f1VmNf4CI7rx2HYHNqVim1Zu8Z97DRH7BavXt3I3rgAZ3m/ODOnw7HWK3aAY5P9BtgFO0wso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739266211; c=relaxed/simple;
	bh=kh1RoAOMTmHyrqSjIKrarn+yEalDE2KGW1HPIU+MCRc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SppA0u1u2OMgZAWOai51Wsd59yXVHEt6BMCbyBdhjnQIoIVnHdB1zhX0AZHRH9fDMwbYEdecs8CtruBeUYY9BwS8zvL6LDUhbkT7da2GOsWsZCphG2Y1gP4Yn7LQhwuNqFc85yz3iK087poqqfmSeAL4k1I4ZNiJtkDLwVIFu7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b=alM7hX1q; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1739266201; x=1739871001; i=ps.report@gmx.net;
	bh=wPhcP0ysWo8kiC7tYIfKR/lpoPsbi4VO9OoHCHU8r3c=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=alM7hX1qBVd6fvxF8urV62Jd6EGPbq9RvKsYyZMZvHtNf1PYTsrrAKVlchb06krh
	 /nGOn9fME7qG1t+jqZ3p+us9kGVK5bkuuSc8UttDjezv8KNqpkerKcXu/apnoabra
	 ZlrzBZAIqQLLeOae+HTJiDyAzMFLPMDn9dnJ9lMepVn3LNl2V/PJtK+I1ggEwgW/G
	 YPRJmy8rFJHMNTmkML4JBPJ+NX3107ChRl779ADi9YrvWOwShjGpcFXLDPP2zGQJ8
	 G7boVTsCAq5HDgfmbwSDmjAKaOpH9Wmqk/WYpGGBRX+X15TQg/OZmYNyzbNN9+/Vr
	 XAloG4cQET9BHwC1Pg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost ([82.135.81.30]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MyKHm-1tTfTo3Nq0-00sfdw; Tue, 11
 Feb 2025 10:30:00 +0100
Date: Tue, 11 Feb 2025 10:29:59 +0100
From: Peter Seiderer <ps.report@gmx.net>
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH net-next v4 09/17] net: pktgen: align some variable
 declarations to the most common pattern
Message-ID: <20250211102959.4aeeb806@gmx.net>
In-Reply-To: <20250206132538.GU554665@kernel.org>
References: <20250205131153.476278-1-ps.report@gmx.net>
	<20250205131153.476278-10-ps.report@gmx.net>
	<20250206132538.GU554665@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:q80QNBi+mJdxRVtoALQDPCsn0ntljixSQm1+/52vqpAYjyfu5H+
 rC0XAmxfBPETOon9BrIi85OQR80Q2h056GPCQ9d8o6+Nskz+BLtxrx5H5lhKh6Md3hTQcKs
 OAua78GFQhmNlNAJKs2kMex4rt07d9ILIboGs29ePvDELSMDiGpvz0aBYXrvZa+6QUJbiNK
 YE79Men49QssJA0OOQBGg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:4lyfgqOCAV0=;raGpbA+rgF/FhrQImWdd3OWWvx1
 +Oo8jrA9hNP92lgMFIPStEkyFC/IJxIX2GPTKeJ4iJrLA6mB3YZOubq4BYcdhRFEKitt00iJ3
 sVzWUOSRquZCP5s8ZCP4Wi+VmemdxDvNmKBuG1FeDI6MwziyaJhyyJdgQRrqPNhKsXXIIzYkM
 ZMafGzwp1PxYFl8wgBnw2PkW3o0gbrhFbxQvyvie3B4RMXCfi5HvEm+DA3SVCsS7NpWCl9ZUa
 bzG3gvGPPFJso1gJA5xIg9KG0l1g5ZKMgQ1DOHJnaGDyXOsFfJPoglE4iOJJfCt5CWkxyyVEi
 r2D7XsE9gq8YPhST+D4cLWJtSn4yJN/nvv7Almpz1DN1orEgrjODyRlzyK+/0PIvcHy4bOIuq
 ESric4Eem+zxNOFK4vQBtrx75fjdR21nkygnLzTkXl9TSZuYSTYHXXhu3qyWugxtHTOenEKKw
 HiF5XaGGhMwYZZvsUte7/HGlFt8+huQgB9Z+bWKsVOg0G8d0Z9huXD2lbEXC0p4YSCPwjPbek
 mwCv7OcSdwnfOPYvv8NFuwHV/9Sp2cUGMvEisWM3vGGV+B4ZfVyunpCs4rwexjeGFL788cbWw
 J0+KqZhD4OeTUxv0lxdEEPi8URHuwRNXgZK9vtehnTTB5tEee4Ap3pGvtwhQ6worxaccvGiRT
 p362BpzP+rtZLdmwSe6YF2JUrmgy6D1KFn+3na+GCYXQqbUnUByycMZoZ+7MkA2E8w8517yam
 zS8isVAF+puXK8L55M734xdV0EgcQeCCqrcLJXkfiPSl8kXR558VtFWsL6mGZSr0waMvaLAFr
 kuZTxWWUg3QOYpai8A7j/U4ZHppTUC7Fd8ltOS8Apkmrc94w3Acf2MJXgFsloRoj2vokj2N61
 gu8ocEvUH06KW5lm+sb+sr7Fsn7+N6kUqkysgeqS29lPwoS8WugjX7NouTMpA74pWZ9KKObsY
 NtH/GdhB9HNdOKzoD7NPXn4SYrE5o7wnEYt3I1m0ZIsoazC6XW5tezFY9H2Q2qs+b1fjsrJL7
 ih7jlDJCh2rgprVJrTItX9rnlhV73hv850A4Hh+5C3J/YR2/6IuuHmS8Vej9zCHdK6r7qoOzi
 msqgF/+uhKRMbiajBEgr9CoSRR8KVx+EIhCq7Pyj576h96RasPEDJNnMjRgIzsK5SAY9oHbbU
 wE6OgZCNBKuYbUSCi+S7MPIV6ttz26d0j3cHmXBNvbs7FK+Co4rD0qtsJ1j3eFremrGGGEBXu
 Qmhy/+U99tALuyL/aHB0IpgEUhaMCMtIDmR0q6ZCNux2Qp7n03tEhmJgbKv+Unp4bmJtAFxwo
 HZRncB4suxHo1zHmLt5FvNab95gWMgSeqgg0BUdEPdpit+If15J1jQrn4+dn5M8XnVhZnYzZ+
 UXO9OZOBNKu8CMq7QqrYRqqTTQ7sQEdE3Q3ISi4xtTK5yPBB9RE2yD6SYrcR1zbUSzuFeV936
 braH0K8XJ6MIMqfNT7Ds3jUboQu8=

Hello Simon,

On Thu, 6 Feb 2025 13:25:38 +0000, Simon Horman <horms@kernel.org> wrote:

> On Wed, Feb 05, 2025 at 02:11:45PM +0100, Peter Seiderer wrote:
> > Align some variable declarations (in get_imix_entries and get_labels) =
to
> > the most common pattern (int instead of ssize_t/long) and adjust funct=
ion
> > return value accordingly.
> >
> > Signed-off-by: Peter Seiderer <ps.report@gmx.net>
>
> Hi Peter,
>
> These comments are is true in general of this patchset, but particularly=
 so
> in the case of this patch:
>
> * I think a more succinct subject would be nice.
> * I think the patch description should provide some reason
>   _why_ the change is being made.

Yep, will improve...

>
> Also, specifically relating to this patch, I wonder if it's scope ought =
to
> be extended. For example, the two callers of num_arg(), get_imix_entries=
() and
> pktgen_if_write() assign the return value of num_arg() to len, which is =
now
> an int in both functions. But num_args() returns a long.

Aim was to get rid of the int/long mixture in the code (which works flawle=
ss
because no one writes to proc with more than a few bytes AND count is limi=
ted
to INT_MAX - PAGE_SIZE in vfs_write (see [1], [2])...

I believe the clean way is to use

  size_t i, max;
  ssize_t len;

consequently through out the code and adjust the function signatures
accordingly...., will re-spin...

>
> > ---
> > Changes v3 -> v4
> >   - new patch (factored out of patch 'net: pktgen: fix access outside =
of user
> >     given buffer in pktgen_if_write()')
> > ---
> >  net/core/pktgen.c | 14 ++++++--------
> >  1 file changed, 6 insertions(+), 8 deletions(-)
> >
> > diff --git a/net/core/pktgen.c b/net/core/pktgen.c
> > index 4f201a2db2dc..279910367ad4 100644
> > --- a/net/core/pktgen.c
> > +++ b/net/core/pktgen.c
> > @@ -850,12 +850,11 @@ static int strn_len(const char __user * user_buf=
fer, unsigned int maxlen)
> >   * where each entry consists of size and weight delimited by commas.
> >   * "size1,weight_1 size2,weight_2 ... size_n,weight_n" for example.
> >   */
> > -static ssize_t get_imix_entries(const char __user *buffer,
> > -				struct pktgen_dev *pkt_dev)
> > +static int get_imix_entries(const char __user *buffer,
> > +			    struct pktgen_dev *pkt_dev)
> >  {
> > -	int i =3D 0;
> > -	long len;
> >  	char c;
> > +	int i =3D 0, len;
>
> Given it can be achieved with exactly the same lines changed, just in a
> different order, please arrange the local variable declarations in rever=
se
> xmas tree order - longest line to shortest.
>
> Likewise for the other hunk of this patch.  And I believe there are also
> other cases in this patchset where this comment applied.
>
> The following tool can be useful:
> https://github.com/ecree-solarflare/xmastree

O.k. will take a look at it...

Thanks for review!

Regards,
Peter


[1] https://elixir.bootlin.com/linux/v6.13.1/source/fs/read_write.c#L673
[2] https://elixir.bootlin.com/linux/v6.13.1/source/include/linux/fs.h#L27=
04

