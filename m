Return-Path: <linux-kselftest+bounces-41064-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B14CB50704
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Sep 2025 22:26:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88B8F16B987
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Sep 2025 20:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7509735CEB6;
	Tue,  9 Sep 2025 20:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b="LK8krL/L";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="I1FUUF9I"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F05340D9D;
	Tue,  9 Sep 2025 20:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757449549; cv=none; b=QW7YmRYSeF9IFi8d98DH0XCMfHtuUzkY0quDJjdLRtbq+le4E3Lu3+Sp8KkeHLbtastQQ/AlBvG1EAkrcvWBE5cGjKvUJj5j5C9ahmCi2c8ejTz5GFz2mGCR/xHkYO8LlCbj7VnNCPCgwGQ8iQWfB96fsBf/iBdCX42wWJ4lQwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757449549; c=relaxed/simple;
	bh=wVmPtnhqj+52kJgFmz3UAct8GT0c8EJYokdq6OeuQoc=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID; b=nAz1Bn2+BMR0loNXpWuaC+Bosb4oQ6q75KjrvtrVZoa+7YwkwLMzd5N6npRJd25GHYmYO4f5JRt5a6peyd2uXiHB8EX1DMctPrk9UlR5wR09egKBQaGtmRB3r2VB5HDx0sceBeZ2os4vpqXjvSHOLULuC2uhE+dXNHlKfQLc6hA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net; spf=pass smtp.mailfrom=jvosburgh.net; dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b=LK8krL/L; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=I1FUUF9I; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvosburgh.net
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B9C501400058;
	Tue,  9 Sep 2025 16:25:45 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 09 Sep 2025 16:25:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvosburgh.net;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm2;
	 t=1757449545; x=1757535945; bh=tEibikcvAKbiQhVLQviq/mkLgDn1B4pd
	40Iq4jn7GeQ=; b=LK8krL/Lukh+dolNzybMtPuEem0Y0FN0NswIAyK6OmBTjbvq
	2ov4fz7FwTWaUnLKCWipqqFbsLV085FzSKRIpzjFtAKU5JKfOr9+ROi7+4LEodyX
	laOEUyaDEP1I9SNoNwCsVd0HCIeIEHvkxA0ZPStyQhAZTOK/+DJneRUZVxNrlyh4
	pZFX0/2sjdpVR6TIgIZVX8jEVqeInkIiQ0ira1D73dSfJPJgG0liDqqd46mRlZ45
	1K5htQBynENzLgDS2XW8DykDBuBH+2iG7vtjojVr+v5h5QiyMO/sdRJ4DmHCyHvq
	hoyituHW0QVC5nVlgJW0JaIc1RR2o7t7beX2FA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757449545; x=
	1757535945; bh=tEibikcvAKbiQhVLQviq/mkLgDn1B4pd40Iq4jn7GeQ=; b=I
	1FUUF9IcBVXnmYiHL/iF+/m2kx5SkELg6sjs3A41emXVW2EyG/jx7BUHBYP59CQ0
	S2S39VmTn+a+8xJFULnwPSZlMAdJBdkL5X8OObTnrnKprUCNrp7GQzQCENNrPoCk
	0H79b2OS2k02RrbAr9wpHHQish2D/uMMHdDI3Zd4Saj+aO8lHL89SA1trEVyHyLt
	QufylTQJ1wZxBHGzjbEqXAjCtJ9LrLEFdHFjDVtUcZV/QHzA0Xi8hFd3VFczoyOl
	F2nMZdlZsW0iOtYXEmnuA1clbr0DPC+Q8y5w9Yn5/b1j3mny9NwhUqDcnLjZP8Zq
	KTwEG3mkkstfwO6QwzIpw==
X-ME-Sender: <xms:SY3AaHz6bBfhwuyP4iXjxzQ_ap9eKo1bxWn-1iH9TLnwQ4ZY61rYag>
    <xme:SY3AaEylTJtUq8kkerLOqvAQsNsJy3sZlsCCQAgHtrFSWkj8WQBTRQno13F9YQtCO
    opXqhYOnCHIvpwwYnI>
X-ME-Received: <xmr:SY3AaAZ7M3GBRawSqKSwpBWZZiDfgEt9akaISDGdBtxEyXjtUqoWCKI6cnUAj8LuzD6K0g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvudefjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhfogggtgfffkfesthhqredtredtjeenucfhrhhomheplfgrhicuggho
    shgsuhhrghhhuceojhhvsehjvhhoshgsuhhrghhhrdhnvghtqeenucggtffrrghtthgvrh
    hnpeegfefghffghffhjefgveekhfeukeevffethffgtddutdefffeuheelgeelieeuhfen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjvhesjh
    hvohhssghurhhghhdrnhgvthdpnhgspghrtghpthhtohepuddvpdhmohguvgepshhmthhp
    ohhuthdprhgtphhtthhopehrrgiiohhrsegslhgrtghkfigrlhhlrdhorhhgpdhrtghpth
    htohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopehlihhuhhgr
    nhhgsghinhesghhmrghilhdrtghomhdprhgtphhtthhopegvughumhgriigvthesghhooh
    hglhgvrdgtohhmpdhrtghpthhtohephhhorhhmsheskhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehshhhurghhsehkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopegrnhgurhgvfidonhgvthguvghvsehluhhnnhdr
    tghhpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomh
X-ME-Proxy: <xmx:SY3AaF3Tk9o2-nJr1P37G-QH4KSlaTYu39y_Pl-qvMuqKJgKzvUHZg>
    <xmx:SY3AaCcL_bIsTlCBdl5D02T8J3X6sL1NzipbRjB6xlXUp3ucCj-hog>
    <xmx:SY3AaCLrpiRzHL6oZTE6eBA_YjcldQ0qRsN4yxrvzWZ6WcyxHf_9sw>
    <xmx:SY3AaApJGDesiOOdcr7ATvkFLsiAmCdqywRiEk66fJ4V2g1JCZfjyw>
    <xmx:SY3AaA6QowkJunQ4TvwfH5gIdKjaoarWXDehHRaE4rPuIVf81YyBGhie>
Feedback-ID: i53714940:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Sep 2025 16:25:44 -0400 (EDT)
Received: by famine.localdomain (Postfix, from userid 1000)
	id E49CF9FCB4; Tue,  9 Sep 2025 13:25:43 -0700 (PDT)
Received: from famine (localhost [127.0.0.1])
	by famine.localdomain (Postfix) with ESMTP id E3AD89FC62;
	Tue,  9 Sep 2025 13:25:43 -0700 (PDT)
From: Jay Vosburgh <jv@jvosburgh.net>
To: Hangbin Liu <liuhangbin@gmail.com>
cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
    "David S. Miller" <davem@davemloft.net>,
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
    Paolo Abeni <pabeni@redhat.com>,
    Nikolay Aleksandrov <razor@blackwall.org>,
    Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
    linux-kselftest@vger.kernel.org, Qiuling Ren <qren@redhat.com>
Subject: Re: [PATCH net 1/2] bonding: set random address only when slaves already exist
In-reply-to: <aL-gWAFWPAKuNoUi@fedora>
References: <20250820091009.393785-1-liuhangbin@gmail.com> <1546564.1755908490@famine> <aKvhk8Cq3ZdWeH_7@fedora> <aL-gWAFWPAKuNoUi@fedora>
Comments: In-reply-to Hangbin Liu <liuhangbin@gmail.com>
   message dated "Tue, 09 Sep 2025 03:34:48 -0000."
X-Mailer: MH-E 8.6+git; nmh 1.8+dev; Emacs 29.3
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Sep 2025 13:25:43 -0700
Message-ID: <2918806.1757449543@famine>

Hangbin Liu <liuhangbin@gmail.com> wrote:

>Hi Jay,
>
>On Mon, Aug 25, 2025 at 04:07:55AM +0000, Hangbin Liu wrote:
>> On Fri, Aug 22, 2025 at 05:21:30PM -0700, Jay Vosburgh wrote:
>> > Hangbin Liu <liuhangbin@gmail.com> wrote:
>> >=20
>> > >Commit 5c3bf6cba791 ("bonding: assign random address if device addres=
s is
>> > >same as bond") fixed an issue where, after releasing the first slave =
and
>> > >re-adding it to the bond with fail_over_mac=3Dfollow, both the active=
 and
>> > >backup slaves could end up with duplicate MAC addresses. To avoid thi=
s,
>> > >the new slave was assigned a random address.
>> > >
>> > >However, if this happens when adding the very first slave, the bond=
=E2=80=99s
>> > >hardware address is set to match the slave=E2=80=99s. Later, during t=
he
>> > >fail_over_mac=3Dfollow check, the slave=E2=80=99s MAC is randomized b=
ecause it
>> > >naturally matches the bond, which is incorrect.
>> >=20
>> > 	The description here seems confusing to me; what does "this"
>> > refer to?  I don't understand the sequence of events that lead to the
>> > issue being fixed here.
>> >=20
>> > 	I wonder if there's another bug somewhere, since nominally when
>> > releasing the last interface in the bond, __bond_release_one() should
>> > randomize the bond's MAC address, so it shouldn't match when adding (or
>> > re-adding ?) the first interface to the bond.
>> >=20
>>=20
>> Sorry I didn't make it clear. A easy reproducer would describe the issue=
. e.g.
>> (omit the lo interface)
>>=20
>> [root@virtme-ng net]# ip link add type veth
>> [root@virtme-ng net]# ip link add bond0 type bond mode 1 miimon 100 fail=
_over_mac 2
>> [root@virtme-ng net]# ip link show
>> 3: veth0@veth1: <BROADCAST,MULTICAST,M-DOWN> mtu 1500 qdisc noop state D=
OWN mode DEFAULT group default qlen 1000
>>     link/ether 02:0a:04:c2:d6:21 brd ff:ff:ff:ff:ff:ff
>> 4: veth1@veth0: <BROADCAST,MULTICAST,M-DOWN> mtu 1500 qdisc noop state D=
OWN mode DEFAULT group default qlen 1000
>>     link/ether 82:a8:52:f4:81:4e brd ff:ff:ff:ff:ff:ff
>> 5: bond0: <BROADCAST,MULTICAST,MASTER> mtu 1500 qdisc noop state DOWN mo=
de DEFAULT group default qlen 1000
>>     link/ether 92:5d:9c:47:e7:53 brd ff:ff:ff:ff:ff:ff
>> [root@virtme-ng net]# ip link set veth0 master bond0
>> [root@virtme-ng net]# ip link show
>> 3: veth0@veth1: <NO-CARRIER,BROADCAST,MULTICAST,SLAVE,UP,M-DOWN> mtu 150=
0 qdisc noqueue master bond0 state LOWERLAYERDOWN mode DEFAULT group defaul=
t qlen 1000
>>     link/ether 4e:b5:4a:b4:03:18 brd ff:ff:ff:ff:ff:ff
>> 4: veth1@veth0: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN mod=
e DEFAULT group default qlen 1000
>>     link/ether 82:a8:52:f4:81:4e brd ff:ff:ff:ff:ff:ff
>> 5: bond0: <BROADCAST,MULTICAST,MASTER> mtu 1500 qdisc noop state DOWN mo=
de DEFAULT group default qlen 1000
>>     link/ether 02:0a:04:c2:d6:21 brd ff:ff:ff:ff:ff:ff
>>=20
>> Here we can see the veth0's mac address is randomized. The reason is in
>> function bond_enslave(), we set the bond mac address to the same as slav=
e's
>> if it's the first one.
>>=20
>>         /* If this is the first slave, then we need to set the master's =
hardware
>>          * address to be the same as the slave's.
>>          */
>>         if (!bond_has_slaves(bond) &&
>>             bond->dev->addr_assign_type =3D=3D NET_ADDR_RANDOM) {
>>                 res =3D bond_set_dev_addr(bond->dev, slave_dev);
>>                 if (res)
>>                         goto err_undo_flags;
>>         }
>>=20
>> And later
>>=20
>>        } else if (bond->params.fail_over_mac =3D=3D BOND_FOM_FOLLOW &&
>>                    BOND_MODE(bond) =3D=3D BOND_MODE_ACTIVEBACKUP &&
>>                    memcmp(slave_dev->dev_addr, bond_dev->dev_addr, bond_=
dev->addr_len) =3D=3D 0) {
>>                 /* Set slave to random address to avoid duplicate mac
>>                  * address in later fail over.
>>                  */
>>                 eth_random_addr(ss.__data);
>>         } else {
>>=20
>> Here we check the bond and slave's mac address, which would be the same
>> definitely, which cause the first slave's mac got changed.
>
>Any comments for this?

	Sorry, fell off the radar.

	I follow what's going on now, and it's actually a lot simpler
than the description suggests, at least to my reading.  Perhaps language
like:

After commit 5c3bf6cba791 ("bonding: assign random address if device
address is same as bond"), bonding will erroneously randomize the MAC
address of the first interface added to the bond if fail_over_mac =3D
follow.

Correct this by additionally testing for the bond being empty before
randomizing the MAC.

	Does that sound ok to you?

	-J

>Thanks
>Hangbin
>
>>=20
>> >=20
>> > >The issue is normally hidden since the first slave usually becomes the
>> > >active one, which restores the bond's MAC address. However, if another
>> > >slave is selected as the initial active interface, the issue becomes =
visible.
>> > >
>> > >Fix this by assigning a random address only when slaves already exist=
 in
>> > >the bond.
>> > >
>> > >Fixes: 5c3bf6cba791 ("bonding: assign random address if device addres=
s is same as bond")
>> > >Reported-by: Qiuling Ren <qren@redhat.com>
>> > >Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
>> > >---
>> > > drivers/net/bonding/bond_main.c | 1 +
>> > > 1 file changed, 1 insertion(+)
>> > >
>> > >diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bo=
nd_main.c
>> > >index 257333c88710..8832bc9f107b 100644
>> > >--- a/drivers/net/bonding/bond_main.c
>> > >+++ b/drivers/net/bonding/bond_main.c
>> > >@@ -2132,6 +2132,7 @@ int bond_enslave(struct net_device *bond_dev, s=
truct net_device *slave_dev,
>> > > 		memcpy(ss.__data, bond_dev->dev_addr, bond_dev->addr_len);
>> > > 	} else if (bond->params.fail_over_mac =3D=3D BOND_FOM_FOLLOW &&
>> > > 		   BOND_MODE(bond) =3D=3D BOND_MODE_ACTIVEBACKUP &&
>> > >+		   bond_has_slaves(bond) &&
>> > > 		   memcmp(slave_dev->dev_addr, bond_dev->dev_addr, bond_dev->addr_=
len) =3D=3D 0) {
>> > > 		/* Set slave to random address to avoid duplicate mac
>> > > 		 * address in later fail over.
>> > >--=20
>> > >2.50.1
>> > >
>> >=20
>> > ---
>> > 	-Jay Vosburgh, jv@jvosburgh.net
>> >=20

---
	-Jay Vosburgh, jv@jvosburgh.net


