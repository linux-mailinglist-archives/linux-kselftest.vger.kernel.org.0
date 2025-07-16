Return-Path: <linux-kselftest+bounces-37445-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AB134B07C23
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Jul 2025 19:35:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8CC5E7A773C
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Jul 2025 17:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED5B6274B30;
	Wed, 16 Jul 2025 17:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b="e9GdmvUZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Nzqt6DUZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0EB1E0E14;
	Wed, 16 Jul 2025 17:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752687339; cv=none; b=GCaTWoQnGiHPXipWkfjvhkHHD2yggrufMEaeWfowk6bOv6ZVtfz2qaqdH5rR6DM2TFeFXGnc7RKR+eALDZ1l7btm6Ip6pXC6zcHSFeodSP5dQPNYAlvQa3XgHHXAdKsF7DAREfl18d8hsJs9NxSL/GlONlH3p90bIVvszZ9JXI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752687339; c=relaxed/simple;
	bh=H4tA6tL4LcE8mwAvrvhVgrsW7SeJrgIEWaM1hmXloM8=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID; b=nn0ZSlVZHZ+mOtzw55oAViyeD4WAcXbGEt13EWFiA8YrN5XVIyACodAiNrXW4TI0ueYjbxZU7bWKBnGInURgBhVYpOPQrprxhsoxF/LR1stDKPQrrO/OqttSOEfUkL8Vtbkd+MVDVjuf+6HlxTwBv+SM8cVCEb283Ij/NQxTmH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net; spf=pass smtp.mailfrom=jvosburgh.net; dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b=e9GdmvUZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Nzqt6DUZ; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvosburgh.net
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7945A14000B1;
	Wed, 16 Jul 2025 13:35:36 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Wed, 16 Jul 2025 13:35:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvosburgh.net;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm1;
	 t=1752687336; x=1752773736; bh=hWHT0GcvfH2wLJvLNk5Y1/WWazVacGml
	q8wDdUqXph4=; b=e9GdmvUZ5xYH933973IHi7dlIjUDQgi/aEKqvO/VYh2nwBr7
	5MkyHQJq44zSFN8Chc5mc9lNt/glUe1naLTo+uW+E+6vojfBNz37LqodNIEVpu7x
	+YbJwXL8dqget6nFLwSoEzFn5A8eEoyGLto37jXzqVkQ1SkigUWbN4YKTgPWp9DO
	iLulbNygSZjy489nwVNyLj+pkdWzR2Cte99U1KozTq4SeQ+ahMNdG1G19Gx441sp
	MaUaccdf0dGHmyHJCmVY/APswVhFuflrIdmeIpVRzF+W/B1Voh42kthfIdc/BzB8
	UUiVXok+207tVG7kOwI9xwKT3dEHZJWpaERQ1w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1752687336; x=
	1752773736; bh=hWHT0GcvfH2wLJvLNk5Y1/WWazVacGmlq8wDdUqXph4=; b=N
	zqt6DUZGmu+wMyGp8pOQZOERFFCrqrm34jgtZVNOo9nGDBasXRdtSc3zr0/xPZ3u
	XcNIWSjiKCOkF297eTcHOdqnnIGK/s7f7JP3mO7Ioo72CSvKUOOOxBVb9AwZDSFa
	ZhW1Oe81nT+2GpovTHAzhQ2ocB5TkHXbs3TTE20XCJ+aJ7z4NaKH0mGqMAIExvXW
	SG6umm+geDyqMfuCwwylUH0rN3K4hNSOhmW8MTGLeZFPxf/6KaMfVmAEbu9Hmx52
	MaAMPLmMuvCoCJFbUW09+bn99SsmBReMpLvgN9YknRZY8QMLTs4MwknNJ2Gmgq4k
	Wk5jMqYZ+0Pie2gUYe04g==
X-ME-Sender: <xms:5-J3aC8cIY7OMYxib3pwBGQG-B_gZElujadRBuO_F3-hWlmyGJ0VwQ>
    <xme:5-J3aNJHWMo5_TqfWtXDYdhi8xLReOuK7Tq-hfG5UNpbHqzw52iviufk7mLCiBp2p
    4pi34U15jNE29-V9C8>
X-ME-Received: <xmr:5-J3aPi-HxyGPNDng1YJEW3bUHk02iEmROeSqA2RjGRmfRUAdnEhYmnxokIwu6W6iiTnog>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdehkeefvdcutefuodetggdotefrod
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
X-ME-Proxy: <xmx:5-J3aB9BpxjoUDlbwEtXtoT9wwIvSuNPTG2W7lRzc-lgf8eBrqn7AA>
    <xmx:5-J3aMMzuhNFWQJGNz9Bso9t5xwu_wj_2sb4hunQLJ9Q9pAxy0xRQw>
    <xmx:5-J3aNBGdxtxmEl74q8fQFs9HSSyWmlYte-olD_IMsyazHXOyd0OKw>
    <xmx:5-J3aINS0pCOrZr-HkJhaipv-r1qu8YX6WJCCWrYm2W44LOIaIQkUg>
    <xmx:6OJ3aBygjsroqXGM--me2ep7lp6_y6DzecUgUROjFCneu7hns0Pb2KVT>
Feedback-ID: i53714940:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 16 Jul 2025 13:35:35 -0400 (EDT)
Received: by famine.localdomain (Postfix, from userid 1000)
	id 5F47D9FC97; Wed, 16 Jul 2025 10:35:34 -0700 (PDT)
Received: from famine (localhost [127.0.0.1])
	by famine.localdomain (Postfix) with ESMTP id 5E37D9FB65;
	Wed, 16 Jul 2025 10:35:34 -0700 (PDT)
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
In-reply-to: <aHd4ddc1YzeT1lN3@fedora>
References: <20250709090344.88242-1-liuhangbin@gmail.com> <20250709090344.88242-2-liuhangbin@gmail.com> <765825.1752639589@famine> <aHd4ddc1YzeT1lN3@fedora>
Comments: In-reply-to Hangbin Liu <liuhangbin@gmail.com>
   message dated "Wed, 16 Jul 2025 10:01:25 -0000."
X-Mailer: MH-E 8.6+git; nmh 1.8+dev; Emacs 29.3
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Jul 2025 10:35:34 -0700
Message-ID: <807057.1752687334@famine>

Hangbin Liu <liuhangbin@gmail.com> wrote:

>On Tue, Jul 15, 2025 at 09:19:49PM -0700, Jay Vosburgh wrote:
>> Hangbin Liu <liuhangbin@gmail.com> wrote:
>>=20
>> >When lacp_active is set to off, the bond operates in passive mode, mean=
ing it
>> >will only "speak when spoken to." However, the current kernel implement=
ation
>> >only sends an LACPDU in response when the partner's state changes.
>> >
>> >In this situation, once LACP negotiation succeeds, the actor stops send=
ing
>> >LACPDUs until the partner times out and sends an "expired" LACPDU.
>> >This leads to endless LACP state flapping.
>>=20
>> 	From the above, I suspect our implementation isn't compliant to
>> the standard.  Per IEEE 802.1AX-2014 6.4.1 LACP design elements:
>>=20
>> c)	Active or passive participation in LACP is controlled by
>> 	LACP_Activity, an administrative control associated with each
>> 	Aggregation Port, that can take the value Active LACP or Passive
>> 	LACP. Passive LACP indicates the Aggregation Port=E2=80=99s preference
>> 	for not transmitting LACPDUs unless its Partner=E2=80=99s control value
>> 	is Active LACP (i.e., a preference not to speak unless spoken
>> 	to). Active LACP indicates the Aggregation Port=E2=80=99s preference to
>
>OK, so this means the passive side should start sending LACPDUs when recei=
ve
>passive actor's LACPDUs, with the slow/fast rate based on partner's rate?

	Did you mean "receive active actor's LACPDUs"?

	Regardless, the standard requires both sides to initiate
periodic LACPDU transmission if either or both enable LACP_Activity in
their LACPDUs.

	So, if a received LACPDU from the partner has LACP_Activity set,
then, yes, we would enable periodic LACPDU transmission, regardless of
our local setting of "lacp_active" / LACP_Activity.

>Hmm, then when we should stop sending LACPDUs? After
>port->sm_mux_state =3D=3D AD_MUX_DETACHED ?

	We stop sending when the criteria for NO_PERIODIC in the
periodic state machine is met (IEEE 802.1AX-2014 6.4.13, Figure 6-19).

	Practically speaking, this happens when a BEGIN event occurs,
due to a port being reinitialized.  The ad_mux_machine() will set the
mux state to AD_MUX_DETACHED when BEGIN occurs, so I don't think we need
to test for DETACHED explicitly.

	The NO_PERIODIC check is the first "if" block in
ad_periodic_machine() that I referenced below.  The code currently tests
all of the criteria from Figure 6-19, but adds a test of "!lacp_active",
which is why I suspect that removing that bit and managing the
lacp_active option via the LACP_Activity in the actor port state would
do the right thing.

	-J

>> 	participate in the protocol regardless of the Partner=E2=80=99s control
>> 	value (i.e., a preference to speak regardless).
>>=20
>> d)	Periodic transmission of LACPDUs occurs if the LACP_Activity
>> 	control of either the Actor or the Partner is Active LACP. These
>> 	periodic transmissions will occur at either a slow or fast
>> 	transmission rate depending upon the expressed LACP_Timeout
>> 	preference (Long Timeout or Short Timeout) of the Partner
>> 	System.
>>=20
>> 	Which, in summary, means that if either end (actor or partner)
>> has LACP_Activity set, both ends must send periodic LACPDUs at the rate
>> specified by their respective partner's LACP_Timeout rate.
>>=20
>> >To avoid this, we need update ntt to true once received an LACPDU from =
the
>> >partner, ensuring an immediate reply. With this fix, the link becomes s=
table
>> >in most cases, except for one specific scenario:
>> >
>> >Actor: lacp_active=3Doff, lacp_rate=3Dslow
>> >Partner: lacp_active=3Don, lacp_rate=3Dfast
>> >
>> >In this case, the partner expects frequent LACPDUs (every 1 second), bu=
t the
>> >actor only responds after receiving an LACPDU, which, in this setup, the
>> >partner sends every 30 seconds due to the actor's lacp_rate=3Dslow. By =
the time
>> >the actor replies, the partner has already timed out and sent an "expir=
ed"
>> >LACPDU.
>>=20
>> 	Presuming that I'm correct that we're not implementing 6.4.1 d),
>> above, correctly, then I don't think this is a proper fix, as it kind of
>> band-aids over the problem a bit.
>>=20
>> 	Looking at the code, I suspect the problem revolves around the
>> "lacp_active" check in ad_periodic_machine():
>>=20
>> static void ad_periodic_machine(struct port *port, struct bond_params *b=
ond_params)
>> {
>> 	periodic_states_t last_state;
>>=20
>> 	/* keep current state machine state to compare later if it was changed =
*/
>> 	last_state =3D port->sm_periodic_state;
>>=20
>> 	/* check if port was reinitialized */
>> 	if (((port->sm_vars & AD_PORT_BEGIN) || !(port->sm_vars & AD_PORT_LACP_=
ENABLED) || !port->is_enabled) ||
>> 	    (!(port->actor_oper_port_state & LACP_STATE_LACP_ACTIVITY) && !(por=
t->partner_oper.port_state & LACP_STATE_LACP_ACTIVITY)) ||
>> 	    !bond_params->lacp_active) {
>> 		port->sm_periodic_state =3D AD_NO_PERIODIC;
>> 	}
>>=20
>> 	In the above, because all the tests are chained with ||, the
>> lacp_active test overrides the two correct-looking
>> LACP_STATE_LACP_ACTIVITY tests.
>>=20
>> 	It looks like ad_initialize_port() always sets
>> LACP_STATE_LACP_ACTIVITY in the port->actor_oper_port_state, and nothing
>> ever clears it.
>>=20
>> 	Thinking out loud, perhaps this could be fixed by
>>=20
>> 	a) remove the test of bond_params->lacp_active here, and,
>>=20
>> 	b) The lacp_active option setting controls whether LACP_ACTIVITY
>> is set in port->actor_oper_port_state.
>>=20
>> 	Thoughts?
>
>As the upper question. When should we stop sending the LACPDUs?
>
>Thanks
>Hangbin

---
	-Jay Vosburgh, jv@jvosburgh.net


