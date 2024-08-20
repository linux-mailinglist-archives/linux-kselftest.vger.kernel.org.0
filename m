Return-Path: <linux-kselftest+bounces-15773-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A36F9588AC
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Aug 2024 16:11:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CAC81C22156
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Aug 2024 14:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DE6A195FE5;
	Tue, 20 Aug 2024 14:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kZANOZN3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fhigh8-smtp.messagingengine.com (fhigh8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C847919409C;
	Tue, 20 Aug 2024 14:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724162921; cv=none; b=sDmz28w8L8w4Fu4Ro1bkJziA+AX1bU2Ka9qVMHmkHzlqz4AYDOsS3AAMyHKTvk6paAzKt6hixNf7w+5vJXr4jFQnnniWdiKz50rYNGzivqRyLVw6N/JmqSMaSYSJYJrcj5PCSJafP9zHm9OTXsIJfc77oDr/EhwqSwtR93yUYwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724162921; c=relaxed/simple;
	bh=GWNelTh3ZbbX0X7L0QDhwF2X1aKVlbBiANE3TaBt0DY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ev8xEFoPzX5LCc/OoSrFyZFeNf+jhxsWfQJy4lpgxgJmuMdw1QW1N4v1iwAn1CZWKTbOlF8lgAbdQO440/wc6A37k2B67G37ctgsfpf9fU9PFSQLLQAGC0W7EVHSdTJdbIl4YeckpwI0CX1a71lnsHMpZjhcZJeJXj5Tw+XrojQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org; spf=none smtp.mailfrom=idosch.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kZANOZN3; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Received: from phl-compute-03.internal (phl-compute-03.nyi.internal [10.202.2.43])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id E6E071151A91;
	Tue, 20 Aug 2024 10:08:37 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 20 Aug 2024 10:08:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1724162917; x=1724249317; bh=kEfYQeLPTow8jHAH+gKTn8OFS8ak
	MGlN/WqVFVkSklE=; b=kZANOZN35uNBToTAebxk6RQbQS0cIfsgQP34Fxh/IAz1
	3wR16yLrj9A1q6A3tXxDJfN7QCVL6zZ+FQTf7TGXBEPRvH1gKcDO/QuzwUgn6tnU
	MzY+8rw7vKokzr3ixx3CCrZJwko538JREeWzy+eeSSMEhWjjsPGMnKhWRDYevFp0
	j54jxPFEgSf0scbiQFbhmCts+9a2Ln6fXtZQDQ+lX27X5z31evxPzoeQTxWeFIer
	QIjmbKsbPAXHRIA2jmbonbuXu97XhjaXBPki+eyteYl70ceEV5nx2ZfOvAvhqVLW
	CB7Kf+x0FbEfv186xzPEvck3zHusvAf6t+RiRF1RIg==
X-ME-Sender: <xms:ZaPEZlnpRegO60vWI_C30xt_9zOacKjEnOJLjQ-phVNlxspCHrP-Jg>
    <xme:ZaPEZg1tbElTBL2n48v4rEoejjQYRxraRETRG6kZ02VmikySZ6DBrCNy77wpG-vKk
    HXZtPodk89TA4A>
X-ME-Received: <xmr:ZaPEZrp0gHKgy8wwNTMG5jU1nMQW9mZVB3ZwsMY5gY5dNuH6TbUUmnezwGb_D5J5NLckH2OtYxFmdJmz2KgLG4NtHYL_Og>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudduiedgjeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefkughoucfutghhihhmmhgvlhcu
    oehiughoshgthhesihguohhstghhrdhorhhgqeenucggtffrrghtthgvrhhnpedvudefve
    ekheeugeeftddvveefgfduieefudeifefgleekheegleegjeejgeeghfenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehiughoshgthhesihguoh
    hstghhrdhorhhgpdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgt
    phhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrvhgvmhesug
    grvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpd
    hrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopehshhhu
    rghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkshgvlhhfthgvsh
    htsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:ZaPEZlk77FWp5qoZqvmJcGJcyjFgYL19YfFv4hMIyquzXH0IUK4C2g>
    <xmx:ZaPEZj3_NvM95Jf1wj_lQGN6MVAB9fKa7olw_w1p7LaRkt7mpMpfVw>
    <xmx:ZaPEZksX3qp2-B9JkWYO_41ztt3JbIrWrfd5UwUxbS5TZzoSzWDUxw>
    <xmx:ZaPEZnXePj-31QgrCTZdbMJREA2iKWIyEBf6u7Ab7JRR4Xp6NzhuNQ>
    <xmx:ZaPEZtpWVE2qq8E0JzCXz8CZlHmDovGxQBQKF9MMcF0npJszWrI1b__b>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 Aug 2024 10:08:36 -0400 (EDT)
Date: Tue, 20 Aug 2024 17:08:33 +0300
From: Ido Schimmel <idosch@idosch.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, shuah@kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v2] selftests: net: add helper for checking if
 nettest is available
Message-ID: <ZsSjYQV66Sn25iv9@shredder.mtl.com>
References: <20240820004217.1087392-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240820004217.1087392-1-kuba@kernel.org>

On Mon, Aug 19, 2024 at 05:42:17PM -0700, Jakub Kicinski wrote:
> A few tests check if nettest exists in the $PATH before adding
> $PWD to $PATH and re-checking. They don't discard stderr on
> the first check (and nettest is built as part of selftests,
> so it's pretty normal for it to not be available in system $PATH).
> This leads to output noise:
> 
>   which: no nettest in (/home/virtme/tools/fs/bin:/home/virtme/tools/fs/sbin:/home/virtme/tools/fs/usr/bin:/home/virtme/tools/fs/usr/sbin:/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin)
> 
> Add a common helper for the check which does silence stderr.
> 
> There is another small functional change hiding here, because pmtu.sh
> and fib_rule_tests.sh used to return from the test case rather than
> completely exit. Building nettest is not hard, there should be no need
> to maintain the ability to selectively skip cases in its absence.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Like Hangbin I am also not sure what "profile=1" is about, but looks
fine otherwise, so:

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

Thanks!

