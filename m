Return-Path: <linux-kselftest+bounces-37942-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41A6AB10720
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Jul 2025 11:58:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 194E04E4040
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Jul 2025 09:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4310E257AF4;
	Thu, 24 Jul 2025 09:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b="fIU2qZjg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="i/U8YpZr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74091245032;
	Thu, 24 Jul 2025 09:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753351081; cv=none; b=ccPjEJldYwywXiZjHTYaI57vKNtl26jJsIoY0VrQBPNvm6O7GpDsekaAalOYF3ayyiKgXXcGI8bc3T4ru2BvVrYGhsW6K8C0FZq4eD974BJAcW3jgKiAZPiz7pG0A46khUWK6gzhiMs+xSCxmrDl8cFf4iaGXXboJo446OqO3G4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753351081; c=relaxed/simple;
	bh=gs5P+7aHDRhMqsRwZal5MENobFl85Xl8UU3Y/W3qvaY=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID; b=KBYpfAcqbGevkrr2AjhoCWjOcRB8O7IWPzbfDwZfQiYtZ6O3XobPbqIYsSK/xxF6lnGa7fLHnR4qsgLn30Vp2r/79I7yTOV+TZB0e0X8RcoL5aGMoLAe6p1HlCOfjy27D0lvDJYA0daId+eqhJ3A2PW7LFxSNEiEF6M5x7PIuFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net; spf=pass smtp.mailfrom=jvosburgh.net; dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b=fIU2qZjg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=i/U8YpZr; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvosburgh.net
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 07D6F7A0125;
	Thu, 24 Jul 2025 05:57:57 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Thu, 24 Jul 2025 05:57:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvosburgh.net;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm1;
	 t=1753351076; x=1753437476; bh=Ljyn2ghd83kunm14IdVeScg9Ar47ftsZ
	2AF4dzGyYQM=; b=fIU2qZjgtKhm6U81KtTKCRs5aXNFqOyybbPleMS+8qlvOnwC
	3gKUoeXwyswMmOVv4FI42vSVsSC/mql4m8Y9Pmpcd326o/ZVpPMLVPAbeusRX5CH
	7PzQRYFMNQcU0x6aDiNL9EYmS78sOG1AVPYM0CMRzwkzkZHaLc6slITSQG5x35Ek
	LgaIAwsF4fnnZRC0qNQeIp//2o9vskIZxOueqQ0AelPDa2O6EFRdq2gqgzq7rivo
	7ldaTJLC9UVYtwjE0KzHujdUotnRz1dfek9qRvkT8hm3nWCWVBOtppdTE4zSS5q7
	e7S/pS1r1Dbz0RNp7uTqq5DOHt5seC746D9z3g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1753351076; x=
	1753437476; bh=Ljyn2ghd83kunm14IdVeScg9Ar47ftsZ2AF4dzGyYQM=; b=i
	/U8YpZr/BK4GzryVagroIpH+pSH90KjpgGoZ2OmYIt+Z+cy6kwn3AzxKcF1cIyeT
	djcOzh64VDLsvF+grdI6mJarRgAY0ykvTHPVF/HTeEUDuj1Vem/Dm8NPBlut/YXF
	w938ellbK3aUEo0DdC6kDIdbRSffNfp70e2nqt2UfFd+UV2/zJEmPhNPdCDUIhIs
	gDZ3lT+KdwfhUVdl5iPAv+mj7RuJEwT7N1xR+t+DjhdFQ6EedQGJXLbN1I53LlXy
	MWZ2WUz6izlQp0AidT3p39F+a2CJmkbOaDy2I4VbvS6ENWy4OhZY0omUE3cJJGWD
	/U6enX96fMoovbbZqNbVA==
X-ME-Sender: <xms:pAOCaIhZCXbYl9fAijMHXhaAbujHWiHpRDDvrVRBQWfdFhK0yPpEtQ>
    <xme:pAOCaLdcZOs0SKH1_7HSSskaIJBMFt8vuWs14YVp3qMI6zHGdJRStxCJokU7OJy1p
    70WpUj69GZOtzin-iU>
X-ME-Received: <xmr:pAOCaHliJuIUgXkmQH-YU4Xpr6UL2K3W79SK4wXIX-UBnYQxqG4JNQLVcH0AGCH4BMzfPB87>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdektdefhecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:pAOCaAzFTPnrNQTESolq4Zh9NqsqZ9vyVLnYhL75W6SKtx3Cd_KV8w>
    <xmx:pAOCaKxNNpMmMTdwcYCzgZRazDyQjJWztu15Dj50lPFbhgHQfzZb1Q>
    <xmx:pAOCaAWlYdNmTasydwPjinhWoNjduqxmJlZl4PurbouInhMz6GZQnQ>
    <xmx:pAOCaBQNHD-7e9K3WClelUJlHybMTh0zObui7gkOGuV7ZhAi4q3hsA>
    <xmx:pAOCaO2SuK5-0h1v7SJcHzBrhIcL1c7pRJaqBGsnehkWNX5e7uwTeOkO>
Feedback-ID: i53714940:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Jul 2025 05:57:55 -0400 (EDT)
Received: by vermin.localdomain (Postfix, from userid 1000)
	id D9B8E1C0051; Thu, 24 Jul 2025 02:57:53 -0700 (PDT)
Received: from vermin (localhost [127.0.0.1])
	by vermin.localdomain (Postfix) with ESMTP id D7A8D1C004F;
	Thu, 24 Jul 2025 11:57:53 +0200 (CEST)
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
In-reply-to: <aIC5HrE9js_YtSCB@fedora>
References: <20250709090344.88242-1-liuhangbin@gmail.com> <20250709090344.88242-2-liuhangbin@gmail.com> <765825.1752639589@famine> <aIC5HrE9js_YtSCB@fedora>
Comments: In-reply-to Hangbin Liu <liuhangbin@gmail.com>
   message dated "Wed, 23 Jul 2025 10:27:42 -0000."
X-Mailer: MH-E 8.6+git; nmh 1.7+dev; Emacs 29.0.50
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Jul 2025 11:57:53 +0200
Message-ID: <309184.1753351073@vermin>

Hangbin Liu <liuhangbin@gmail.com> wrote:

>On Tue, Jul 15, 2025 at 09:19:49PM -0700, Jay Vosburgh wrote:
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
>Hi Jay,
>
>I did some investigation and testing. In addition to your previous change,
>we also need to initialize the partner's state to 0 in ad_initialize_port_=
tmpl().
>Otherwise, the check:
>```
>!(port->partner_oper.port_state & LACP_STATE_LACP_ACTIVITY)
>```
>in ad_periodic_machine() will fail even when the actor is in passive mode.

	Agreed; the .port_state in the port_params tmpl should just be
zero; the magic number 1 there now, which is LACP_STATE_LACP_ACTIVITY,
is just wrong.  For the actor side, the lacp_active option will set it
appropriately, and the partner's will be updated by any LACPDUs that
arrive.

>Also, the line:
>```
>port->partner_oper.port_state |=3D LACP_STATE_LACP_ACTIVITY;
>```
>in ad_rx_machine() should be removed, since we can't assume the partner is=
 in
>active mode. [1]

	Also agreed.

>With these two changes, we can ensure:
>1. In passive mode, the actor will not send LACPDU before receiving any LA=
CPDU from the partner.
>2. Once it receives the partner=E2=80=99s LACPDU, it will start sending pe=
riodic LACPDUs as expected.
>
>Do you agree with making these changes? If so, I can post a patch for your=
 review.

	Yes, please post a patch.

>[1] IEEE 8021AX-2020, Figure 6-14=E2=80=94LACP Receive state diagram, the =
AD_RX_EXPIRED
>statue should be
>```
>Partner_Oper_Port_State.Synchronization =3D FALSE;
>Partner_Oper_Port_State.Short_Timeout =3D TRUE;
>Actor_Oper_Port_State.Expired =3D TRUE;
>LACP_currentWhile =3D Short_Timeout_Time;
>```

	FWIW, I usually reference the older standards 2008 or 2014, as
the 2020 edition changes a lot of things and bonding isn't necessarily
conformant to those changes (e.g., many of the state machines are
different in large or small ways).  Technically, the bonding
implementation was written to the pre-802.1AX standard when it was still
part of 802.3 (hence the name 802.3ad), clause 43.

	This particular bit (the EXPIRED state actions) is the same,
but, for example, the transition test from EXPIRED to DEFAULTED is
different in the 2014 vs 2020 editions, and we need to be careful not to
implement the state machines piecemeal from different editions of the
standard.

	-J

---
	-Jay Vosburgh, jv@jvosburgh.net

