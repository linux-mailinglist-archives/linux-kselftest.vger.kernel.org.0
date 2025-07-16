Return-Path: <linux-kselftest+bounces-37404-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C961FB06C9A
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Jul 2025 06:20:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00489189E714
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Jul 2025 04:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A320227702E;
	Wed, 16 Jul 2025 04:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b="g1aqZFJW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OLsjRP99"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989E6186294;
	Wed, 16 Jul 2025 04:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752639595; cv=none; b=fi1tW2vgR4s0fkoYxVOyVDc5CVFU3mYu5VQur9YGUwT4Ime1jz9C2eo/eP9YXg7MTqKZdQ7prskReHi7ZNky/6gdEgrpbFNY6MjkAT88xNXTJymy4urwdJTBhdkNZCkyax4cHQ40ZRMy4EZcCQFL2cMJBJviEUGIrbMueQe7M4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752639595; c=relaxed/simple;
	bh=DcSq4O2836qVIYEQkJ5ppCzyb5Q+J91I208VZqlFPLI=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID; b=Oc29zBBHVODIxaz6XJcTIV3Xi3OEdsFx4XRmjKNOEcidQLaTNrGrz3gnlRdZ+2dkgNimhOzvKaIlKm5glULmclMcIXMOdcxwR8/BOXnuC0s99Qe68Pn94albJes4OEakZgY3ppyWaWqk4li7ZW3NM9yMLS1XwQqSVu2b0qSlHQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net; spf=pass smtp.mailfrom=jvosburgh.net; dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b=g1aqZFJW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OLsjRP99; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvosburgh.net
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 84EF514000CC;
	Wed, 16 Jul 2025 00:19:51 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Wed, 16 Jul 2025 00:19:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvosburgh.net;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm3;
	 t=1752639591; x=1752725991; bh=pUsexg3Nn8SGdsJqhAr2zCNOoqqk8OpJ
	XOBdo5Vrryw=; b=g1aqZFJWjRM2hnkzUCybrAiEsSYDgiORTcxWRpBcDxHRTWuQ
	8RIwJ7gBqWpvSb+heJ/bVEof5sJeR+h0CrtUXYc0KLBhUemufGi8G+QYI0QFXyau
	YI5omEUZp2j6n6bMAwiwbey4VzS2NbO488KFqGO4CWl/ofndXL6zgkVc2UaxK28S
	j336Ya3geKQlq5AFieXYmnFsunc8I0pvH/DH2xx9n8cRTen9rz4xEKI8xfG+A47W
	/tEleqJ5E6BviryuO67rurWPzXb0GXuF0KhFvvh1nkIQxTQEUpPDzKLd4HB2JiqG
	in7o5t+Dr7ICw5PNEsSrCs86bJEGhlEjD2WagQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1752639591; x=
	1752725991; bh=pUsexg3Nn8SGdsJqhAr2zCNOoqqk8OpJXOBdo5Vrryw=; b=O
	LsjRP990o7AwpIPiy7T3R3XpSdlyP9mCZURuM49OKBH9Gvzp4ruTu0QXq/0CRBTf
	/1zgSrkImFa1wt3uQW/tGnfH4cb3Qln8ayFIooE8xplPdD12BBlwqeUaGdM6XSmO
	jPPnyhfJSMu/UuyzFXa5pzsxEdyzMYjPpy0xRk70lF25ilRNspPYQzmAERtPipmU
	ZcC2UUSByC5M216+TXx8nJUmx4jm8+vF0djiBIK21lFdqWqFEtZ0Uqv1y1MOnQcc
	l3KeblYFcVF5GjgV/6rpAR4yp5AZ0SEcRU9oiCT+F4+H69fv2P+qZ+5y/xw9lenb
	1Q9H+CgbMTvDT8+Tzc3KA==
X-ME-Sender: <xms:Zih3aHu4Z43qBZ1zCxnHGsNjwU9IXPOyWrXcBiEViUDqMtX-oK5Zcg>
    <xme:Zih3aC4c5ekRi0KP5U8cc12Ffzw4qRS-dD1ioLF28Ik4kVlWGt5um_QoN6lFvO6DP
    9zHJ1th8umSqJw-L60>
X-ME-Received: <xmr:Zih3aCTSsJ5Cjmj6VC1u__AGn3-T7BAlKS5qMEiEbkIuLeaeF4jlSd5YFCLoW0xy12KKTw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdehieejfecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:Zih3aNvyNdyozWJzk0mY_s_cQ6r9mXIf2a78CW5Ww8Urld7ckFx0Yw>
    <xmx:Zih3aM_IemzAtplYMdwjSXMpBbs6Nz1pSC4UB_aUpIxcDdkb9AZTSw>
    <xmx:Zih3aOyEb7pH3prx-1VfIA_YnA3FFh9yEWbUGF2mVA7AE-nz17Q3jg>
    <xmx:Zih3aG_sIdJkS8yEHZf9kntYOm7IMFWV7tn57PYcbC0-v7ZoN8aKiA>
    <xmx:Zyh3aAglPoruP3qSP8LM4f88MoV6GhDd4ZHPr17Kr2ruUbGL2MPWlxbM>
Feedback-ID: i53714940:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 16 Jul 2025 00:19:50 -0400 (EDT)
Received: by famine.localdomain (Postfix, from userid 1000)
	id 35EB19FC97; Tue, 15 Jul 2025 21:19:49 -0700 (PDT)
Received: from famine (localhost [127.0.0.1])
	by famine.localdomain (Postfix) with ESMTP id 32B079FC54;
	Tue, 15 Jul 2025 21:19:49 -0700 (PDT)
From: Jay Vosburgh <jv@jvosburgh.net>
To: Hangbin Liu <liuhangbin@gmail.com>
cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
    "David S. Miller" <davem@davemloft.net>,
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
    Paolo Abeni <pabeni@redhat.com>,
    Nikolay Aleksandrov <razor@blackwall.org>,
    Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
    linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 1/2] bonding: update ntt to true in passive mode
In-reply-to: <20250709090344.88242-2-liuhangbin@gmail.com>
References: <20250709090344.88242-1-liuhangbin@gmail.com> <20250709090344.88242-2-liuhangbin@gmail.com>
Comments: In-reply-to Hangbin Liu <liuhangbin@gmail.com>
   message dated "Wed, 09 Jul 2025 09:03:43 -0000."
X-Mailer: MH-E 8.6+git; nmh 1.8+dev; Emacs 29.3
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Jul 2025 21:19:49 -0700
Message-ID: <765825.1752639589@famine>

Hangbin Liu <liuhangbin@gmail.com> wrote:

>When lacp_active is set to off, the bond operates in passive mode, meaning=
 it
>will only "speak when spoken to." However, the current kernel implementati=
on
>only sends an LACPDU in response when the partner's state changes.
>
>In this situation, once LACP negotiation succeeds, the actor stops sending
>LACPDUs until the partner times out and sends an "expired" LACPDU.
>This leads to endless LACP state flapping.

	From the above, I suspect our implementation isn't compliant to
the standard.  Per IEEE 802.1AX-2014 6.4.1 LACP design elements:

c)	Active or passive participation in LACP is controlled by
	LACP_Activity, an administrative control associated with each
	Aggregation Port, that can take the value Active LACP or Passive
	LACP. Passive LACP indicates the Aggregation Port=E2=80=99s preference
	for not transmitting LACPDUs unless its Partner=E2=80=99s control value
	is Active LACP (i.e., a preference not to speak unless spoken
	to). Active LACP indicates the Aggregation Port=E2=80=99s preference to
	participate in the protocol regardless of the Partner=E2=80=99s control
	value (i.e., a preference to speak regardless).

d)	Periodic transmission of LACPDUs occurs if the LACP_Activity
	control of either the Actor or the Partner is Active LACP. These
	periodic transmissions will occur at either a slow or fast
	transmission rate depending upon the expressed LACP_Timeout
	preference (Long Timeout or Short Timeout) of the Partner
	System.

	Which, in summary, means that if either end (actor or partner)
has LACP_Activity set, both ends must send periodic LACPDUs at the rate
specified by their respective partner's LACP_Timeout rate.

>To avoid this, we need update ntt to true once received an LACPDU from the
>partner, ensuring an immediate reply. With this fix, the link becomes stab=
le
>in most cases, except for one specific scenario:
>
>Actor: lacp_active=3Doff, lacp_rate=3Dslow
>Partner: lacp_active=3Don, lacp_rate=3Dfast
>
>In this case, the partner expects frequent LACPDUs (every 1 second), but t=
he
>actor only responds after receiving an LACPDU, which, in this setup, the
>partner sends every 30 seconds due to the actor's lacp_rate=3Dslow. By the=
 time
>the actor replies, the partner has already timed out and sent an "expired"
>LACPDU.

	Presuming that I'm correct that we're not implementing 6.4.1 d),
above, correctly, then I don't think this is a proper fix, as it kind of
band-aids over the problem a bit.

	Looking at the code, I suspect the problem revolves around the
"lacp_active" check in ad_periodic_machine():

static void ad_periodic_machine(struct port *port, struct bond_params *bond=
_params)
{
	periodic_states_t last_state;

	/* keep current state machine state to compare later if it was changed */
	last_state =3D port->sm_periodic_state;

	/* check if port was reinitialized */
	if (((port->sm_vars & AD_PORT_BEGIN) || !(port->sm_vars & AD_PORT_LACP_ENA=
BLED) || !port->is_enabled) ||
	    (!(port->actor_oper_port_state & LACP_STATE_LACP_ACTIVITY) && !(port->=
partner_oper.port_state & LACP_STATE_LACP_ACTIVITY)) ||
	    !bond_params->lacp_active) {
		port->sm_periodic_state =3D AD_NO_PERIODIC;
	}

	In the above, because all the tests are chained with ||, the
lacp_active test overrides the two correct-looking
LACP_STATE_LACP_ACTIVITY tests.

	It looks like ad_initialize_port() always sets
LACP_STATE_LACP_ACTIVITY in the port->actor_oper_port_state, and nothing
ever clears it.

	Thinking out loud, perhaps this could be fixed by

	a) remove the test of bond_params->lacp_active here, and,

	b) The lacp_active option setting controls whether LACP_ACTIVITY
is set in port->actor_oper_port_state.

	Thoughts?

	-J

>Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
>Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
>---
> drivers/net/bonding/bond_3ad.c | 6 ++++++
> 1 file changed, 6 insertions(+)
>
>diff --git a/drivers/net/bonding/bond_3ad.c b/drivers/net/bonding/bond_3ad=
.c
>index c6807e473ab7..e001d1c8a49b 100644
>--- a/drivers/net/bonding/bond_3ad.c
>+++ b/drivers/net/bonding/bond_3ad.c
>@@ -666,6 +666,8 @@ static void __update_default_selected(struct port *por=
t)
>  */
> static void __update_ntt(struct lacpdu *lacpdu, struct port *port)
> {
>+	struct bonding *bond;
>+
> 	/* validate lacpdu and port */
> 	if (lacpdu && port) {
> 		/* check if any parameter is different then
>@@ -683,6 +685,10 @@ static void __update_ntt(struct lacpdu *lacpdu, struc=
t port *port)
> 		   ) {
> 			port->ntt =3D true;
> 		}
>+
>+		bond =3D __get_bond_by_port(port);
>+		if (bond && !bond->params.lacp_active)
>+			port->ntt =3D true;
> 	}
> }
>=20
>--=20
>2.46.0
>

---
	-Jay Vosburgh, jv@jvosburgh.net


