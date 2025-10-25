Return-Path: <linux-kselftest+bounces-44032-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 827C3C08A77
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 Oct 2025 05:45:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 440E64E556A
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 Oct 2025 03:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BC0725228D;
	Sat, 25 Oct 2025 03:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b="ZvN1t6kM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Nk5C3pvo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB7A4248880;
	Sat, 25 Oct 2025 03:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761363897; cv=none; b=Ybo5kHCTxglVRfNZo2bun/ztPNRphub+vqDbjvL35hK+tjuKi/+/AxRNXbXijo6CIzQ1Lr/F1dJ6xPGwkGthlarN1Sju+3C2QRW96pOhLDFT2s1V2DjHBTm5gvDt6v/Uc9fgMRAHgGGHmlRm1zBdBlBgdLSBia4/jTSxajkgvu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761363897; c=relaxed/simple;
	bh=LfMe8TQ/LeXa4E/cqZqOUQ8SMoLWWfDeYiX3TlRpwT4=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID; b=mgtUj96NsRPkzcQbsK2m2HA4RwHRPHH+RrSjmzrw/XBsiQuu5OBDQlu38m6HpoUHG45NTnkscM2HXyWaQ9V04kAkVX/n/ZoNDhlbNAhxobTFzrQvFe6THuKwAkFSHYcY5XMnXUHStY2rE5twV3nRHa//7wSigBNBVm5UfjbHi4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net; spf=pass smtp.mailfrom=jvosburgh.net; dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b=ZvN1t6kM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Nk5C3pvo; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvosburgh.net
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 38EB31D00180;
	Fri, 24 Oct 2025 23:44:53 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Fri, 24 Oct 2025 23:44:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvosburgh.net;
	 h=cc:cc:content-id:content-transfer-encoding:content-type
	:content-type:date:date:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to; s=fm1; t=1761363893; x=1761450293; bh=UozRQF1oVu6aEb4GRj/7A
	iA4H/nVIgK0+x1skH8F1Fo=; b=ZvN1t6kMNmmdamis9GkZ8gfwmbP3pNQnTuJKW
	mBoPs0YxzsI7wbZ4YiWerCuf4M8amUEqtptM9OL3ysDA64ehP3GRe3+UIqLtim/S
	zFIobVRN7qcBvoLDg3x/iiiBw1gGo0ktdSA7vDKkvAzDs4HzyykuTSALEuQkIAwX
	EUue3CKvN/mqt0Hi8YpbQhPjUbc8x+cRGr559svrxZHNqgrVRVjSsU174OuvvOrS
	nSiTT5utKiVG6xiR3RwEppWD9lz13LIuDRO6Qa1jCvojTKV9MXXLdWdAVUoXtjRX
	/TNIjFiv/g4Dk0hDngQ6WfuhEhATGEZuN1nic6bUDBUZdP1XQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-id
	:content-transfer-encoding:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1761363893; x=1761450293; bh=UozRQF1oVu6aEb4GRj/7AiA4H/nVIgK0+x1
	skH8F1Fo=; b=Nk5C3pvomfm2+DfP9TS1tsb3ASyue+k517wI4iVxhWeFLEeDjU9
	PyeFZNXaCGynrBuaayGvuzIVjkaDC68nWjNkegP7W29pIvtvqDmtjJDGSj6GRPbK
	JFMYuGQ8CZZ+qCojP6H49hlnnKhq+M1HLnIsQka8PcsSSfRzzlN3k6wKPBUkJ4X8
	f9Ee3zbwCAoXbJjrLsc+nyF35YieA4cONlHaoSN7fZc62ZkwBYH2fsX4u7kynS7f
	GHDHtBT9lAGLhkzOOGjB4XHo0EUljAiOyLUO0bY9EBdQ/nNhuBbCAIcBCoknFUId
	ppKsLeQOCVlXLhL0XAnnoBCSw4zyQgR5mbg==
X-ME-Sender: <xms:s0f8aDJQoREBn_84tRC8pwShaxhVNkW2nwhOYOMCM7llufAY8Ee8kA>
    <xme:s0f8aDHQGAO5gB7ocV_NIsTW3kx7x1PFYW5Ii4g_9O36W2KG2ynSZYtOsUH_RfwHb
    r1H_h7COUHzJuvju83UhEvPlG_KuwqNG57Vpse1d1jaZMnAf16B8E8>
X-ME-Received: <xmr:s0f8aB1HqsrH_VQATHDxzG2YzXrvBldmF3Wu65cmqKYGdmTgvcqoPVC35AIQu5jsz5nigw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduheduudejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghfofggtgfgfffksehtqhertdertddvnecuhfhrohhmpeflrgihucgg
    ohhssghurhhghhcuoehjvhesjhhvohhssghurhhghhdrnhgvtheqnecuggftrfgrthhtvg
    hrnhepieefvdelfeeljeevtefhfeeiudeuiedvfeeiveelffduvdevfedtheffffetfeff
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhvse
    hjvhhoshgsuhhrghhhrdhnvghtpdhnsggprhgtphhtthhopedujedpmhhouggvpehsmhht
    phhouhhtpdhrtghpthhtoheprhgriihorhessghlrggtkhifrghllhdrohhrghdprhgtph
    htthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohephhhorhhm
    sheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehshhhurghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrnhgu
    rhgvfidonhgvthguvghvsehluhhnnhdrtghhpdhrtghpthhtoheptghorhgsvghtsehlfi
    hnrdhnvghtpdhrtghpthhtohepshhtvghphhgvnhesnhgvthifohhrkhhplhhumhgsvghr
    rdhorhhgpdhrtghpthhtohepihdrmhgrgihimhgvthhssehovhhnrdhorhhg
X-ME-Proxy: <xmx:s0f8aCwuxh0aTEzKjSVNDqQ14CdD1CWz7IvMVAx_7h3_Vww_8WBeKQ>
    <xmx:s0f8aIjjLIBgPK1zfPHw9CleM1etZkeK9XyYKERc8hWV6I27rbYoCg>
    <xmx:s0f8aJysETbmIAxATEOklts42DwTwTmzDz3a7hqLhj9oqYlzHkCe4Q>
    <xmx:s0f8aOzFCZkQIlSk6Mlk08Y1N38AVVsAwvPCJmgAIY4o4zTIvX92Sg>
    <xmx:tUf8aBpqQwS8IDhar2f1lxoSlwrApU50P0y2h6a3DC0xqs3rXDOzB0mi>
Feedback-ID: i53714940:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 24 Oct 2025 23:44:51 -0400 (EDT)
Received: by famine.localdomain (Postfix, from userid 1000)
	id 58C029FC5A; Fri, 24 Oct 2025 20:44:50 -0700 (PDT)
Received: from famine (localhost [127.0.0.1])
	by famine.localdomain (Postfix) with ESMTP id 559839FC57;
	Fri, 24 Oct 2025 20:44:50 -0700 (PDT)
From: Jay Vosburgh <jv@jvosburgh.net>
To: Jakub Kicinski <kuba@kernel.org>
cc: David Wilder <wilder@us.ibm.com>, netdev@vger.kernel.org,
    pradeep@us.ibm.com, i.maximets@ovn.org, amorenoz@redhat.com,
    haliu@redhat.com, stephen@networkplumber.org, horms@kernel.org,
    pabeni@redhat.com, andrew+netdev@lunn.ch, edumazet@google.com,
    razor@blackwall.org, shuah@kernel.org, corbet@lwn.net,
    linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH net-next v14 0/7] bonding: Extend arp_ip_target format to
 allow for a list of vlan tags.
In-reply-to: <20251022175033.7daec7f6@kernel.org>
References: <20251022182721.2567561-1-wilder@us.ibm.com>
 <20251022175033.7daec7f6@kernel.org>
Comments: In-reply-to Jakub Kicinski <kuba@kernel.org>
   message dated "Wed, 22 Oct 2025 17:50:33 -0700."
X-Mailer: MH-E 8.6+git; nmh 1.8+dev; Emacs 29.3
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1102579.1761363890.1@famine>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Oct 2025 20:44:50 -0700
Message-ID: <1102580.1761363890@famine>

Jakub Kicinski <kuba@kernel.org> wrote:

>On Wed, 22 Oct 2025 11:25:27 -0700 David Wilder wrote:
>> The current implementation of the arp monitor builds a list of vlan-tag=
s by
>> following the chain of net_devices above the bond. See bond_verify_devi=
ce_path().
>> Unfortunately, with some configurations, this is not possible. One exam=
ple is
>> when an ovs switch is configured above the bond.
>
>Once again if anyone thinks this belongs in the kernel please speak up.
>Otherwise let this be the last posting.
>
>*If* someone does speak up in support you will need to find a less ugly
>way to represent the attribute within Netlink. What you invent must work
>in YNL and be added to the spec (Documentation/netlink/specs/rt-link.yaml=
)
>-- =

>pw-bot: cr

	Sorry, didn't have a chance to catch up until now.  I gave this
a read through again, and I have mixed feelings about it.

	I understand the problem they're trying to solve, which is
largely an artifact of the way OVS kind of lives off to the side and
does its own thing.  And, yes, there are a bunch of other things (tc,
ebpf, et al) that can arbitrarily tweak VLAN tags in a packet.

	That said, it's kind of a niche use case, and it's adding what
feels to me like an awkward API and its related infrastructure that will
have to be maintained forever.  Bonding already has baggage from things
that seemed like a good idea at the time, but ultimately weren't, so I'm
reluctant to add something like this for a niche case.

	-J

---
	-Jay Vosburgh, jv@jvosburgh.net

