Return-Path: <linux-kselftest+bounces-25265-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A71AA201A2
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Jan 2025 00:27:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9CCA1659DC
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Jan 2025 23:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 512DC1DDC03;
	Mon, 27 Jan 2025 23:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b="wMyqwg77";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Cdcce9RN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D871DC747;
	Mon, 27 Jan 2025 23:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738020321; cv=none; b=Zm/ve9wAxzNaheOALNU8EldCTjCCq0p04xFdmkXxU1dE1avonF68ODKuhP1lAMNbXZCo4ZAolhbmgoRxSC02aZXV2FZKECpkJKDe0bOyNbOq7qXfnNU1pEhccpiS+fmMwl3D5AEwg9cCPYR8xWpoPWsnC2sak070V8nBU2HnZGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738020321; c=relaxed/simple;
	bh=BYkehnIpBnocYGyjLeN0L5UEDG1dmgrbbixLoe1gkGg=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID; b=pREk1Ou4EVV0ZIpDjNmBtgtVDjFMuyVfnIMkWNNaW8g204j3Jei1MHZNA4agFXbyr7vJwwWoAtDYJKIEaAkRTmrMxxOB492yMhRs0wAD/WsnEPu3EkNLhpKhDT4lxMlsiLJF/hWet7qS8NJv/0+cpwugEJzKjQqUvyum5k71t/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net; spf=pass smtp.mailfrom=jvosburgh.net; dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b=wMyqwg77; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Cdcce9RN; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvosburgh.net
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 97A0B11401D1;
	Mon, 27 Jan 2025 18:25:16 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 27 Jan 2025 18:25:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvosburgh.net;
	 h=cc:cc:content-id:content-transfer-encoding:content-type
	:content-type:date:date:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to; s=fm1; t=1738020316; x=1738106716; bh=CPjWf1wHRCpAlAPPogONS
	Y2JicosVViIJDCkH3vIjPk=; b=wMyqwg77GSeBxiV1pSszP1qFJX04WYr40a+NJ
	1iDsyIu9PJWNFJU7WThnwytG2T75uoXG0cDmsjQdtBh+u6LcymGNpOopItIYNcfv
	gnVMdMOoYch29ocIkjPPsr5p09n9d1xSsV+X0z8q6l+h6QEqY9fJ+oANJlT1oG+u
	q9MwlRyV+vVbM3nzInOZst/hBgtb/KlvNZMAHby3P6XnG4dsl7bjTeVTiBn1xH55
	Caj6UumE+NoS8/35d1H7wP8lbQP9PeKk4lC3RxN2CpLHOQJJbOfWizrPc0AUdYIZ
	K1z52F5WphQXctg+J7DMmdP9n5nC7q5ovXI8LttIe7uYLjYyQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-id
	:content-transfer-encoding:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738020316; x=1738106716; bh=CPjWf1wHRCpAlAPPogONSY2JicosVViIJDC
	kH3vIjPk=; b=Cdcce9RNhgsq/6hRfbtz0hMVHrSUQ73uTdBrf+D/JPqx2whk+Rp
	gSMOMl+0zmfDe4zEW9L8D6MkUL1Ujomi5w4HpXdqy1dbCiJnRjvTXURUOzKPgJFT
	nBMAIb0dAWjFJzSxdk0htbppoHKHZH+62yq9S9kxguQITYajPPnQkfLfg50Z1yyX
	yumFVyAoJqmduEW89r75WgJp4CFJ/OE/Su7JSjDpPrr8T4Tqqa53nf9kJS0LM5sQ
	QhQ+2hHFX0ei2nOXINUY+173HY4XpC7yHC1L0mIfQ2rYrNjXw24T9jEw3UgK3ZoA
	4fd0bwDcHcC0w/4Z/+4NaWIRAdiAvYYEx6w==
X-ME-Sender: <xms:3BWYZz_pRcF_v2SpfxzvJ1xj1pAOd95q6b9V3KMgDHSO0G9yN0TakQ>
    <xme:3BWYZ_sFXQriqa0mjuJo86kiT2TQ77yBkc0d8vBwWqdix2fcXtsl7GULd13Lqwb-1
    fER9w7UAxG9vna-zqk>
X-ME-Received: <xmr:3BWYZxBmvyFbGGsS-orE4Bp66KEC0idudOsrdMoZm_0gIJwuMfuopYmUUERtIAotCrZKKA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejgedgudegheduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghfofggtgfgfffksehtqhertder
    tddvnecuhfhrohhmpeflrgihucggohhssghurhhghhcuoehjvhesjhhvohhssghurhhghh
    drnhgvtheqnecuggftrfgrthhtvghrnhepieefvdelfeeljeevtefhfeeiudeuiedvfeei
    veelffduvdevfedtheffffetfeffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepjhhvsehjvhhoshgsuhhrghhhrdhnvghtpdhnsggprhgtphht
    thhopedugedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprhgriihorhessghlrg
    gtkhifrghllhdrohhrghdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhn
    vghtpdhrtghpthhtoheplhhiuhhhrghnghgsihhnsehgmhgrihhlrdgtohhmpdhrtghpth
    htohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehhohhrmhhs
    sehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepsghorhhishhpsehnvhhiughirgdrtghomhdprhgtphhtthhopegtrhgr
    thhiuhesnhhvihguihgrrdgtohhmpdhrtghpthhtohepjhhirghnsgholhesnhhvihguih
    grrdgtohhm
X-ME-Proxy: <xmx:3BWYZ_dA1I8-rxcj2W3sHtRz-tAKX8guv4I_g7riBJqHiy0QxEp8WQ>
    <xmx:3BWYZ4NXtUGEkW-0yK-cbGqPMaYysGjh5TdwEjE00lLMBIKy0M6XBA>
    <xmx:3BWYZxmRgK6V-zhsRRhDTJ_uwQCtG24RxgFL8oeQfhXDWRFCHlkSog>
    <xmx:3BWYZyvPw7L6XNskcF0phxcKqQ3jEWEYTVKF-L2FofNZymgVkO2UkQ>
    <xmx:3BWYZ_lLzvS2MzDitSxyQ6hR9O8uvYciL1_7l9sP8jhY2KVPqtWJIrNC>
Feedback-ID: i53714940:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Jan 2025 18:25:15 -0500 (EST)
Received: by famine.localdomain (Postfix, from userid 1000)
	id 256E99FD33; Mon, 27 Jan 2025 15:25:14 -0800 (PST)
Received: from famine (localhost [127.0.0.1])
	by famine.localdomain (Postfix) with ESMTP id 21E059FC62;
	Mon, 27 Jan 2025 15:25:14 -0800 (PST)
From: Jay Vosburgh <jv@jvosburgh.net>
To: Cosmin Ratiu <cratiu@nvidia.com>
cc: netdev@vger.kernel.org, Nikolay Aleksandrov <razor@blackwall.org>,
    "David S . Miller" <davem@davemloft.net>,
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
    Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
    Jianbo Liu <jianbol@nvidia.com>, Boris Pismenny <borisp@nvidia.com>,
    Tariq Toukan <tariqt@nvidia.com>, linux-kselftest@vger.kernel.org,
    Hangbin Liu <liuhangbin@gmail.com>, Liang Li <liali@redhat.com>
Subject: Re: [PATCH net v3] bonding: Correctly support GSO ESP offload
In-reply-to: <20250127104147.759658-1-cratiu@nvidia.com>
References: <20250127104147.759658-1-cratiu@nvidia.com>
Comments: In-reply-to Cosmin Ratiu <cratiu@nvidia.com>
   message dated "Mon, 27 Jan 2025 12:41:47 +0200."
X-Mailer: MH-E 8.6+git; nmh 1.8+dev; Emacs 29.3
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <115557.1738020314.1@famine>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Jan 2025 15:25:14 -0800
Message-ID: <115558.1738020314@famine>

Cosmin Ratiu <cratiu@nvidia.com> wrote:

>The referenced fix is incomplete. It correctly computes
>bond_dev->gso_partial_features across slaves, but unfortunately
>netdev_fix_features discards gso_partial_features from the feature set
>if NETIF_F_GSO_PARTIAL isn't set in bond_dev->features.
>
>This is visible with ethtool -k bond0 | grep esp:
>tx-esp-segmentation: off [requested on]
>esp-hw-offload: on
>esp-tx-csum-hw-offload: on
>
>This patch reworks the bonding GSO offload support by:
>- making aggregating gso_partial_features across slaves similar to the
>  other feature sets (this part is a no-op).
>- advertising the default partial gso features on empty bond devs, same
>  as with other feature sets (also a no-op).
>- adding NETIF_F_GSO_PARTIAL to hw_enc_features filtered across slaves.
>- adding NETIF_F_GSO_PARTIAL to features in bond_setup()
>
>With all of these, 'ethtool -k bond0 | grep esp' now reports:
>tx-esp-segmentation: on
>esp-hw-offload: on
>esp-tx-csum-hw-offload: on
>
>Fixes: 4861333b4217 ("bonding: add ESP offload features when slaves suppo=
rt")
>Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
>Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>

Acked-by: Jay Vosburgh <jv@jvosburgh.net>


>---
> drivers/net/bonding/bond_main.c | 19 ++++++++++---------
> 1 file changed, 10 insertions(+), 9 deletions(-)
>
>diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_m=
ain.c
>index 7b78c2bada81..e45bba240cbc 100644
>--- a/drivers/net/bonding/bond_main.c
>+++ b/drivers/net/bonding/bond_main.c
>@@ -1538,17 +1538,20 @@ static netdev_features_t bond_fix_features(struct=
 net_device *dev,
> 				 NETIF_F_HIGHDMA | NETIF_F_LRO)
> =

> #define BOND_ENC_FEATURES	(NETIF_F_HW_CSUM | NETIF_F_SG | \
>-				 NETIF_F_RXCSUM | NETIF_F_GSO_SOFTWARE)
>+				 NETIF_F_RXCSUM | NETIF_F_GSO_SOFTWARE | \
>+				 NETIF_F_GSO_PARTIAL)
> =

> #define BOND_MPLS_FEATURES	(NETIF_F_HW_CSUM | NETIF_F_SG | \
> 				 NETIF_F_GSO_SOFTWARE)
> =

>+#define BOND_GSO_PARTIAL_FEATURES (NETIF_F_GSO_ESP)
>+
> =

> static void bond_compute_features(struct bonding *bond)
> {
>+	netdev_features_t gso_partial_features =3D BOND_GSO_PARTIAL_FEATURES;
> 	unsigned int dst_release_flag =3D IFF_XMIT_DST_RELEASE |
> 					IFF_XMIT_DST_RELEASE_PERM;
>-	netdev_features_t gso_partial_features =3D NETIF_F_GSO_ESP;
> 	netdev_features_t vlan_features =3D BOND_VLAN_FEATURES;
> 	netdev_features_t enc_features  =3D BOND_ENC_FEATURES;
> #ifdef CONFIG_XFRM_OFFLOAD
>@@ -1582,8 +1585,9 @@ static void bond_compute_features(struct bonding *b=
ond)
> 							  BOND_XFRM_FEATURES);
> #endif /* CONFIG_XFRM_OFFLOAD */
> =

>-		if (slave->dev->hw_enc_features & NETIF_F_GSO_PARTIAL)
>-			gso_partial_features &=3D slave->dev->gso_partial_features;
>+		gso_partial_features =3D netdev_increment_features(gso_partial_feature=
s,
>+								 slave->dev->gso_partial_features,
>+								 BOND_GSO_PARTIAL_FEATURES);
> =

> 		mpls_features =3D netdev_increment_features(mpls_features,
> 							  slave->dev->mpls_features,
>@@ -1598,12 +1602,8 @@ static void bond_compute_features(struct bonding *=
bond)
> 	}
> 	bond_dev->hard_header_len =3D max_hard_header_len;
> =

>-	if (gso_partial_features & NETIF_F_GSO_ESP)
>-		bond_dev->gso_partial_features |=3D NETIF_F_GSO_ESP;
>-	else
>-		bond_dev->gso_partial_features &=3D ~NETIF_F_GSO_ESP;
>-
> done:
>+	bond_dev->gso_partial_features =3D gso_partial_features;
> 	bond_dev->vlan_features =3D vlan_features;
> 	bond_dev->hw_enc_features =3D enc_features | NETIF_F_GSO_ENCAP_ALL |
> 				    NETIF_F_HW_VLAN_CTAG_TX |
>@@ -6046,6 +6046,7 @@ void bond_setup(struct net_device *bond_dev)
> 	bond_dev->hw_features |=3D NETIF_F_GSO_ENCAP_ALL;
> 	bond_dev->features |=3D bond_dev->hw_features;
> 	bond_dev->features |=3D NETIF_F_HW_VLAN_CTAG_TX | NETIF_F_HW_VLAN_STAG_=
TX;
>+	bond_dev->features |=3D NETIF_F_GSO_PARTIAL;
> #ifdef CONFIG_XFRM_OFFLOAD
> 	bond_dev->hw_features |=3D BOND_XFRM_FEATURES;
> 	/* Only enable XFRM features if this is an active-backup config */
>-- =

>2.45.0
>

