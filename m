Return-Path: <linux-kselftest+bounces-39158-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA3CCB290B2
	for <lists+linux-kselftest@lfdr.de>; Sat, 16 Aug 2025 23:44:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A194AA1E5B
	for <lists+linux-kselftest@lfdr.de>; Sat, 16 Aug 2025 21:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F0A223C512;
	Sat, 16 Aug 2025 21:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b="LNuoyGlP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CbjsNcAp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D963215175;
	Sat, 16 Aug 2025 21:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755380682; cv=none; b=B7588EZE7WxGC5C9NgVB9m6qaZadQTMcKrTybFnZW/V1yOo4EUaw5QJbpVO+0u1R86o/9ovl9T0WUmPg+PJLMFcKIMd/cVOd1+J/DCj1UCC6ElbbU7CxHhj+wfEsQUyiJCOoeDdinU7iugJogVOT3/BwJU5QhJ6e0CyRTNnd6AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755380682; c=relaxed/simple;
	bh=rH+iZVOojl81+gh+Qt2mwYI85KqtnO4j8w5ftUhj4/o=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID; b=g+UeqHg0aY/wePjAe/la3g+QMCav4eSoQ+jGQVF6qG5qxtZ/+PBLSYJU9xN9/vpr0aIBEI1ri9DpufQ+gkYtjZVCDAvE/jp5Vhrjkhd04mGUK0rlKZBFIbGMAcCezpB2pcS7Eq6wsjpLIOqosn7DqP88gFPKJKCndj51qHy1Ilk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net; spf=pass smtp.mailfrom=jvosburgh.net; dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b=LNuoyGlP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CbjsNcAp; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvosburgh.net
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id D37D1EC0075;
	Sat, 16 Aug 2025 17:44:35 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Sat, 16 Aug 2025 17:44:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvosburgh.net;
	 h=cc:cc:content-id:content-transfer-encoding:content-type
	:content-type:date:date:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to; s=fm2; t=1755380675; x=1755467075; bh=I3Cv5gTZ28aN83YHExaUK
	avYb1lKshX4L/7hwiwo+fU=; b=LNuoyGlP5rW8sSJi4VbAQ9MltNvRp5MD0nWtQ
	h1kBsSMYAfS/Fq4SzdXQgl19KLEAlBBCXVeV0LAAJIg2Szo3t51Y1DgFXfzfuQ9s
	uf3ITgv0rPG4pL3mvafjfXN6OC4VDzLqBE18PRgs++aWeoCEYAX/K8MXIuAvmQfZ
	DbOBtSDJvMlZkxMStQcirR/ejaLislZMgNNWyAoaVnZvUGmwE+z/3LtlDJOJFAOR
	yqGI/zq1E4n7ljnTG/EhnhKRw3QdQRclv2nRtci2nwbyPc+k+41+mH45kkKhsG7t
	7w2k6Etq5Crwu7w/ea1Z6ErXUZYe1o9q8vm7DceZ1eQSBsSmw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-id
	:content-transfer-encoding:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1755380675; x=1755467075; bh=I3Cv5gTZ28aN83YHExaUKavYb1lKshX4L/7
	hwiwo+fU=; b=CbjsNcAp1+1DY/DIUwzL5Qgh76ZpLUnoSGOYctEwp5H4JM+NvH8
	znFqtltzzLplhLwvQOV8gHAJrVyn9jWjqNIafPiuvsiwq+HKz63YspOtd/dmtOys
	UKCbesjziuMalmgCb7osbWoaza7tehb8WeAoUu4wghMsaf+ja6iaPcic09X70R3f
	r3bnMgdlDvPzf5DDAQUMD73tn+J3nbfpEd6cnrWkWpzC1tqWBu2u6QIhbj21hSpc
	n/FHONVemJ4rUbRz5FE+yTG56rEZzYb5VqNmz+KWeIeGGN4QfqXkj2lFMbt9S919
	AbrTj74PMtIpyMjkF6oSBK1S+I+ipwBx6Aw==
X-ME-Sender: <xms:w_ugaBslVhgHqHVKEFRrN9P3MKlnxEQ_ZfQW8VUr0M8pH0A-RAkCHw>
    <xme:w_ugaEvBp23dwWVSOf8YqTiRpwCIqfrTNAC3jKx_YnQjbWs4h6iQ7b3j-slQ04ND4
    4IixqsDsVE7EXusfLk>
X-ME-Received: <xmr:w_ugaKNKY0CoE8vspUN0IMBtHKeq0Rny5tN5Bh_KSf4Yos876fxvIZkF3p-rbbqNiQdzvA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddugeejleeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghfofggtgfgfffksehtqhertdertddvnecuhfhrohhmpeflrgihucgg
    ohhssghurhhghhcuoehjvhesjhhvohhssghurhhghhdrnhgvtheqnecuggftrfgrthhtvg
    hrnhepieefvdelfeeljeevtefhfeeiudeuiedvfeeiveelffduvdevfedtheffffetfeff
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhvse
    hjvhhoshgsuhhrghhhrdhnvghtpdhnsggprhgtphhtthhopedukedpmhhouggvpehsmhht
    phhouhhtpdhrtghpthhtoheprhgriihorhessghlrggtkhifrghllhdrohhrghdprhgtph
    htthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepughsrghh
    vghrnhesghhmrghilhdrtghomhdprhgtphhtthhopehlihhuhhgrnhhgsghinhesghhmrg
    hilhdrtghomhdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhr
    tghpthhtohephhhorhhmsheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhusggrse
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopehshhhurghhsehkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopegrnhgurhgvfidonhgvthguvghvsehluhhnnhdrtghh
X-ME-Proxy: <xmx:w_ugaOdYOBIiemgzlQnb06iIAPnYvkxUsFunk8LCVSo69bV3D8jD3Q>
    <xmx:w_ugaJn76wrqgBHEyceOJnDNXfo3W755CyGsVYZBnwdg5JzXSbTwjA>
    <xmx:w_ugaIxVSOXf_RtrNlpN3piO5s7vnkyeUCLfaXw6FNK1liChmu3Wow>
    <xmx:w_ugaEPrruU0OF9xms9RxFL_b4RoNJCfI1wnX3bMiCGmoDufihyzqg>
    <xmx:w_ugaOVdgUf-MiKtBHdUTYvDJsFVWKELljfYm1cL5Ic-qjtEUiUBWOkg>
Feedback-ID: i53714940:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 16 Aug 2025 17:44:34 -0400 (EDT)
Received: by famine.localdomain (Postfix, from userid 1000)
	id 2E9709FC9C; Sat, 16 Aug 2025 14:44:33 -0700 (PDT)
Received: from famine (localhost [127.0.0.1])
	by famine.localdomain (Postfix) with ESMTP id 2B91B9FB65;
	Sat, 16 Aug 2025 14:44:33 -0700 (PDT)
From: Jay Vosburgh <jv@jvosburgh.net>
To: Hangbin Liu <liuhangbin@gmail.com>
cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
    "David S. Miller" <davem@davemloft.net>,
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
    Paolo Abeni <pabeni@redhat.com>,
    Nikolay Aleksandrov <razor@blackwall.org>,
    Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
    Jonathan Corbet <corbet@lwn.net>, Petr Machata <petrm@nvidia.com>,
    Amit Cohen <amcohen@nvidia.com>,
    Vladimir Oltean <vladimir.oltean@nxp.com>,
    Stephen Hemminger <stephen@networkplumber.org>,
    David Ahern <dsahern@gmail.com>, linux-doc@vger.kernel.org,
    linux-kselftest@vger.kernel.org
Subject: Re: [PATCHv2 net-next 2/3] bonding: support aggregator selection
 based on port priority
In-reply-to: <20250814104256.18372-3-liuhangbin@gmail.com>
References: <20250814104256.18372-1-liuhangbin@gmail.com>
 <20250814104256.18372-3-liuhangbin@gmail.com>
Comments: In-reply-to Hangbin Liu <liuhangbin@gmail.com>
   message dated "Thu, 14 Aug 2025 10:42:55 -0000."
X-Mailer: MH-E 8.6+git; nmh 1.8+dev; Emacs 29.3
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1109152.1755380673.1@famine>
Content-Transfer-Encoding: quoted-printable
Date: Sat, 16 Aug 2025 14:44:33 -0700
Message-ID: <1109153.1755380673@famine>

Hangbin Liu <liuhangbin@gmail.com> wrote:

>Add a new ad_select policy 'port_priority' that uses the per-port
>actor priority values (set via ad_actor_port_prio) to determine
>aggregator selection.
>
>This allows administrators to influence which ports are preferred
>for aggregation by assigning different priority values, providing
>more flexible load balancing control in LACP configurations.
>
>Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
>---
> Documentation/networking/bonding.rst |  9 ++++++++-
> drivers/net/bonding/bond_3ad.c       | 27 +++++++++++++++++++++++++++
> drivers/net/bonding/bond_options.c   |  1 +
> include/net/bond_3ad.h               |  1 +
> 4 files changed, 37 insertions(+), 1 deletion(-)
>
>diff --git a/Documentation/networking/bonding.rst b/Documentation/network=
ing/bonding.rst
>index 874d8a4681ec..151c964562db 100644
>--- a/Documentation/networking/bonding.rst
>+++ b/Documentation/networking/bonding.rst
>@@ -250,7 +250,14 @@ ad_select
> 		ports (slaves).  Reselection occurs as described under the
> 		"bandwidth" setting, above.
> =

>-	The bandwidth and count selection policies permit failover of
>+	prio or 3
>+
>+		The active aggregator is chosen by the highest total sum of
>+		actor port priorities across its active ports. Note this
>+		priority is ad_actor_port_prio, not per port prio, which is
>+		used for primary reselect.
>+
>+	The bandwidth, count and prio selection policies permit failover of

	Needing to have a caveat here makes me think we should instead
change the nomenclature.  Perhaps "lacp_port_prio"?  The standard hasn't
had "ad" in its name for 20-ish years, so I don't think we should use
"ad" in user facing options, and common usage these days is to just call
it "lacp."

	Simiarly, I don't think we need "ad" in the option name, either;
the standard just calls it "actor_port_priority", is there a good reason
not to use that?

	-J

> 	802.3ad aggregations when partial failure of the active aggregator
> 	occurs.  This keeps the aggregator with the highest availability
> 	(either in bandwidth or in number of ports) active at all times.
>diff --git a/drivers/net/bonding/bond_3ad.c b/drivers/net/bonding/bond_3a=
d.c
>index 19b389b81600..dcc1a1750df5 100644
>--- a/drivers/net/bonding/bond_3ad.c
>+++ b/drivers/net/bonding/bond_3ad.c
>@@ -747,6 +747,18 @@ static int __agg_active_ports(struct aggregator *agg=
)
> 	return active;
> }
> =

>+static unsigned int __agg_ports_priority(const struct aggregator *agg)
>+{
>+	struct port *port =3D agg->lag_ports;
>+	unsigned int prio =3D 0;
>+
>+	for (; port; port =3D port->next_port_in_aggregator)
>+		if (port->is_enabled)
>+			prio +=3D port->actor_port_priority;
>+
>+	return prio;
>+}
>+
> /**
>  * __get_agg_bandwidth - get the total bandwidth of an aggregator
>  * @aggregator: the aggregator we're looking at
>@@ -1707,6 +1719,9 @@ static struct aggregator *ad_agg_selection_test(str=
uct aggregator *best,
> 	 * BOND_AD_COUNT: Select by count of ports.  If count is equal,
> 	 *     select by bandwidth.
> 	 *
>+	 * BOND_AD_PRIO: Select by total priority of ports. If priority
>+	 *     is equal, select by count.
>+	 *
> 	 * BOND_AD_STABLE, BOND_AD_BANDWIDTH: Select by bandwidth.
> 	 */
> 	if (!best)
>@@ -1725,6 +1740,14 @@ static struct aggregator *ad_agg_selection_test(st=
ruct aggregator *best,
> 		return best;
> =

> 	switch (__get_agg_selection_mode(curr->lag_ports)) {
>+	case BOND_AD_PRIO:
>+		if (__agg_ports_priority(curr) > __agg_ports_priority(best))
>+			return curr;
>+
>+		if (__agg_ports_priority(curr) < __agg_ports_priority(best))
>+			return best;
>+
>+		fallthrough;
> 	case BOND_AD_COUNT:
> 		if (__agg_active_ports(curr) > __agg_active_ports(best))
> 			return curr;
>@@ -1790,6 +1813,10 @@ static int agg_device_up(const struct aggregator *=
agg)
>  * (slaves), and reselect whenever a link state change takes place or th=
e
>  * set of slaves in the bond changes.
>  *
>+ * BOND_AD_PRIO: select the aggregator with highest total priority of po=
rts
>+ * (slaves), and reselect whenever a link state change takes place or th=
e
>+ * set of slaves in the bond changes.
>+ *
>  * FIXME: this function MUST be called with the first agg in the bond, o=
r
>  * __get_active_agg() won't work correctly. This function should be bett=
er
>  * called with the bond itself, and retrieve the first agg from it.
>diff --git a/drivers/net/bonding/bond_options.c b/drivers/net/bonding/bon=
d_options.c
>index 5b58326dd24c..4bfff38b9ad0 100644
>--- a/drivers/net/bonding/bond_options.c
>+++ b/drivers/net/bonding/bond_options.c
>@@ -165,6 +165,7 @@ static const struct bond_opt_value bond_ad_select_tbl=
[] =3D {
> 	{ "stable",    BOND_AD_STABLE,    BOND_VALFLAG_DEFAULT},
> 	{ "bandwidth", BOND_AD_BANDWIDTH, 0},
> 	{ "count",     BOND_AD_COUNT,     0},
>+	{ "prio",      BOND_AD_PRIO,      0},
> 	{ NULL,        -1,                0},
> };
> =

>diff --git a/include/net/bond_3ad.h b/include/net/bond_3ad.h
>index bf551ca70359..34495df965f0 100644
>--- a/include/net/bond_3ad.h
>+++ b/include/net/bond_3ad.h
>@@ -26,6 +26,7 @@ enum {
> 	BOND_AD_STABLE =3D 0,
> 	BOND_AD_BANDWIDTH =3D 1,
> 	BOND_AD_COUNT =3D 2,
>+	BOND_AD_PRIO =3D 3,
> };
> =

> /* rx machine states(43.4.11 in the 802.3ad standard) */
>-- =

>2.50.1
>

---
	-Jay Vosburgh, jv@jvosburgh.net

