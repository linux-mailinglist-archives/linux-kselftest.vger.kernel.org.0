Return-Path: <linux-kselftest+bounces-42228-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 458D3B9B1DB
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Sep 2025 19:51:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 833D93B3FD0
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Sep 2025 17:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74891314A64;
	Wed, 24 Sep 2025 17:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="iT8duxwz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="m08DfW+o"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E792FBE05;
	Wed, 24 Sep 2025 17:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758736238; cv=none; b=ZDS/gR1Fu7/+t9UE1YA35Fy5XXMCvvpHFAt4jKAey6RjAktbvZayOcloJQY3qb6Igwc+IrKDrw3H2xtynvSF8/zrMOBLvSDYyZjztygwciljY091JNrt1L4HnNJgVra01vsBDELma02y25F/wjDSAaMiiLosTxbjlDCW8QngNs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758736238; c=relaxed/simple;
	bh=NPGlUlaUMBUpPVyqYO4XSqsnRuXnfdEkj6waMAL1ODE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RGsSUuSzqaictzZVaEVvhmUJXyvYmGNNHzgVLrKMuIUhbCczJiH1G48aaevs85SVmMMmibqGj6RxuIJAlFse1Rtd1zEhzL3AtEWWXiOfIZlNaJWbqc68SufDvPtE3urORkzNaDsc7rEUCAo6XCSFNEwYtMBqtVMfCCGwltY9Ors=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=iT8duxwz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=m08DfW+o; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 1C9F4EC00B6;
	Wed, 24 Sep 2025 13:50:34 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 24 Sep 2025 13:50:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm2;
	 t=1758736234; x=1758822634; bh=moKr34pnawcljfj8OP/P5kJrgh1m2F+Q
	E1r8IvMYRIM=; b=iT8duxwzuK2zGKi4NgeVmyVO/fVTTRwr61CyIAOihTyIUHEy
	+0JGk8qYPdyr/8w0fi3gHClaLb9cCxTKY1Lw5HGvsjoSK+OlejSmgOKWDvSMe2qU
	wD+n+Isj+KSTHCV2xRTQcpaBFmIE5x3kI2qnJJ6g1pMC0frWSccHy8I1Da+i9Wf0
	Z+BW18gbfb1whu4XvSRrz83Dz9xegm6kI3qW3Fews0MAijGEC+ux5sxHUGfHSp+E
	bBjr05or6d1v6Y1dYxQSNWgFBWXkrvYIHGqpPitdXPGRvZr2EcWHmuIx4CyBK5J4
	U0gIhABn0t6ZeBvvgdEV+6eVUmpYvyde1Oa5yQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758736234; x=
	1758822634; bh=moKr34pnawcljfj8OP/P5kJrgh1m2F+QE1r8IvMYRIM=; b=m
	08DfW+oAcWXd+bAH7w4CvXtClNfIFKdrbEfJdJoGqOJXdih4CNLPvT7rlP2qzraR
	BiUN7HjfIE5fNydz3Qn90Z0T9S4lkg1x4JZdqurnuNS+rWpVojmwtqz0DCIIxKa/
	wOuMgGw36IfQqEjTTA9WNjmmSotmqa7b6YNxSpfbb4YgStqGujyfeA1mbkgZYx4E
	cbENVTg464dXZGB4VzS0JDPrAVBYTZLKgZUJOfffI6pUtiBaRRIbJ119CiXDj6hS
	Q97RhwB5MwPeF5mI1R06hK+NYktjQ/WwfYlA70i7NKBjspn+aGEl7n8b5K9q9X8G
	ShYoHsfZ6Fhxd8f+mUtXQ==
X-ME-Sender: <xms:aS_UaOUB5uQJpjGm5uW48h34b1E_2dxi0gD5q5KAdAaS-qdfhstk-g>
    <xme:aS_UaG8Mn7F8Cuoklc-yViFbEofuML_rLGbF_wd4Q8Izj2AupMxBwm9JxlKpUWCIM
    kE7-f4BMntzJrLRLn3gBRv-y7oCdQ_U-qGtSQegbF0Ch4fYreMOjTw>
X-ME-Received: <xmr:aS_UaG2W84DgZpAz3cPnC1pU22cG1i2feuhigjmn0hT0fLzX9-oMK4bLw1RK>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeigedvhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtugfgjgesthekrodttddtjeenucfhrhhomhepufgrsghrihhn
    rgcuffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrghilhdrnhgvtheqnecuggftrf
    grthhtvghrnheptedttdeijeetgeelkedttedvgefhheeuffeghfdviedvheelhfdvheef
    ffeuvdefnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsugesqhhuvggrshihshhnrghilhdr
    nhgvthdpnhgspghrtghpthhtohepudegpdhmohguvgepshhmthhpohhuthdprhgtphhtth
    hopeifihhlfhhrvggurdhophgvnhhsohhurhgtvgesghhmrghilhdrtghomhdprhgtphht
    thhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlih
    hnuhigqdguohgtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhu
    gidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinh
    hugidqkhhsvghlfhhtvghsthesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepvgguuhhmrgiivg
    htsehgohhoghhlvgdrtghomhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomh
X-ME-Proxy: <xmx:aS_UaDcPjnod5XhER5-UXNUiYuwQYTPga7OzJiISPhDluvDlyKHBKw>
    <xmx:aS_UaFCEojX29xTEgH735Kq1bWlb59yKsTh6uFtQxHGH3V2Uj-B25A>
    <xmx:aS_UaC9aOU6cAXPW0SC0GnN_p6FQ1VAvYHKnDR1wYX9fiGGcfqZ55Q>
    <xmx:aS_UaBql8E6iRb-8-7Hc40vc1ivrtkysPeoGYbdSUeh8G3ycLv-02g>
    <xmx:ai_UaItRc-UPAsQFv6kaqrW6CDmhWPMks014ZWeR9i2f-2ragQ6fUnxq>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 Sep 2025 13:50:32 -0400 (EDT)
Date: Wed, 24 Sep 2025 19:50:30 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Wilfred Mallawa <wilfred.opensource@gmail.com>
Cc: netdev@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, corbet@lwn.net,
	john.fastabend@gmail.com, shuah@kernel.org,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>
Subject: Re: [PATCH v4 2/2] selftests: tls: add tls record_size_limit test
Message-ID: <aNQvZnCWhymiXYPO@krikkit>
References: <20250923053207.113938-1-wilfred.opensource@gmail.com>
 <20250923053207.113938-2-wilfred.opensource@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250923053207.113938-2-wilfred.opensource@gmail.com>

[got a bit distracted while writing this so Simon got to the process
stuff before me, but I'll leave it in:]

BTW, a few details about process: since this is a new feature, the
subject prefix should be [PATCH net-next v4 n/m] (new stuff targets
the net-next tree), and the patches should be based on the net-next
tree [1] (I'm not sure what you based this on, git am complained on
both net and net-next for this patch). More info about this in the
docs [2].

[1] https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/
[2] https://docs.kernel.org/process/maintainer-netdev.html
    (in case you're not aware: also note the bits about "merge window"
    which will quite likely become relevant in a few days)


2025-09-23, 15:32:07 +1000, Wilfred Mallawa wrote:
> From: Wilfred Mallawa <wilfred.mallawa@wdc.com>
> 
> Test that outgoing plaintext records respect the tls record_size_limit
> set using setsockopt(). The record size limit is set to be 128, thus,
> in all received records, the plaintext must not exceed this amount.
> 
> Also test that setting a new record size limit whilst a pending open
> record exists is handled correctly by discarding the request.
> 
> Suggested-by: Sabrina Dubroca <sd@queasysnail.net>
> Signed-off-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>

Thanks for adding this patch.
(and for the tag :))

> ---
>  tools/testing/selftests/net/tls.c | 149 ++++++++++++++++++++++++++++++
>  1 file changed, 149 insertions(+)
> 
> diff --git a/tools/testing/selftests/net/tls.c b/tools/testing/selftests/net/tls.c
> index 0f5640d8dc7f..c5bd431d5af3 100644
> --- a/tools/testing/selftests/net/tls.c
> +++ b/tools/testing/selftests/net/tls.c
> @@ -24,6 +24,7 @@
>  #include "../kselftest_harness.h"
>  
>  #define TLS_PAYLOAD_MAX_LEN 16384
> +#define TLS_TX_RECORD_SIZE_LIM 5

nit: That should not be needed if you run `make headers_install`
before compiling the selftest:

make -s headers_install ; make -C tools/testing/selftests/net tls
make: Entering directory '/home/sab/linux/net/tools/testing/selftests/net'
gcc -Wall -Wl,--no-as-needed -O2 -g -I../../../../usr/include/ -isystem /home/sab/linux/net/tools/testing/selftests/../../../usr/include -I../ -D_GNU_SOURCE=     tls.c   -o tls

and that will find the new constant defined in the previous patch
using the headers from the current kernel tree, instead of those in
the system.


[...]
> +TEST(tx_record_size)
> +{
> +	struct tls_crypto_info_keys tls12;
> +	int cfd, ret, fd, rx_len, overhead;
> +	size_t total_plaintext_rx = 0;
> +	__u8 tx[1024], rx[2000];
> +	__u8 *rec;
> +	__u16 limit = 128;
> +	__u16 opt = 0;
> +	__u8 rec_header_len = 5;

gcc complains about unused variables, I guess leftovers from
extracting parse_tls_records:

tls.c: In function ‘tx_record_size’:
tls.c:2840:14: warning: unused variable ‘rec_header_len’ [-Wunused-variable]
 2840 |         __u8 rec_header_len = 5;
      |              ^~~~~~~~~~~~~~
tls.c:2837:15: warning: unused variable ‘rec’ [-Wunused-variable]
 2837 |         __u8 *rec;
      |               ^~~
tls.c: In function ‘tx_record_size_open_rec’:
tls.c:2893:14: warning: unused variable ‘rec_header_len’ [-Wunused-variable]
 2893 |         __u8 rec_header_len = 5;
      |              ^~~~~~~~~~~~~~
tls.c:2891:15: warning: unused variable ‘rec’ [-Wunused-variable]
 2891 |         __u8 *rec;
      |               ^~~


> +	unsigned int optlen = sizeof(opt);
> +	bool notls;
> +
> +	tls_crypto_info_init(TLS_1_2_VERSION, TLS_CIPHER_AES_CCM_128,
> +			     &tls12, 0);
> +
> +	ulp_sock_pair(_metadata, &fd, &cfd, &notls);
> +
> +	if (notls)
> +		exit(KSFT_SKIP);
> +
> +	/* Don't install keys on fd, we'll parse raw records */
> +	ret = setsockopt(cfd, SOL_TLS, TLS_TX, &tls12, tls12.len);
> +	ASSERT_EQ(ret, 0);
> +
> +	ret = setsockopt(cfd, SOL_TLS, TLS_TX_RECORD_SIZE_LIM, &limit, sizeof(limit));
> +	ASSERT_EQ(ret, 0);
> +
> +	ret = getsockopt(cfd, SOL_TLS, TLS_TX_RECORD_SIZE_LIM, &opt, &optlen);
> +	ASSERT_EQ(ret, 0);
> +	ASSERT_EQ(limit, opt);
> +	ASSERT_EQ(optlen, sizeof(limit));

nit: Maybe a few of those should be EXPECT_EQ? (ASSERT_* stops the
test, EXPECT_* will run the rest of the test)

Getting the wrong value back from this getsockopt is worth noting but
there's value in running the traffic through anyway?

> +
> +	memset(tx, 0, sizeof(tx));
> +	EXPECT_EQ(send(cfd, tx, sizeof(tx), 0), sizeof(tx));

But this one should maybe be an ASSERT because trying to parse records
from whatever data we managed to send (if any) may not make much
sense?

(just some thoughts, this is not a "strict requirement" to change
anything in the patch)


> +	close(cfd);
> +
> +	ret = recv(fd, rx, sizeof(rx), 0);
> +	memcpy(&rx_len, rx + 3, 2);
> +	rx_len = htons(rx_len);

nit: set but not used (also in tx_record_size_open_rec)

-- 
Sabrina

