Return-Path: <linux-kselftest+bounces-25524-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D7BBA24ED6
	for <lists+linux-kselftest@lfdr.de>; Sun,  2 Feb 2025 17:00:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F9BE3A5160
	for <lists+linux-kselftest@lfdr.de>; Sun,  2 Feb 2025 16:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9CF4374EA;
	Sun,  2 Feb 2025 16:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="S2UvkASs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD7151FB3;
	Sun,  2 Feb 2025 16:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738512046; cv=none; b=t0TkRvGpwxIWgMdV4lFDHwBz6s9bnf4OVtbR5nJhdA/7GO5drzVwso2RGwm3CZk9bTuxisLwsaAnaWW2UucKiokgN3Un9YRlF4q1LkaDXJv89sVrvluYfvlIZa2ysB/BBlgeq6PFGgwMT3PsxkHDATh5jJ6YtZcwAMvoPi7nC5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738512046; c=relaxed/simple;
	bh=JxvFZ/EK8z5JlSqPGMMbIAcJmK9vYXtwZQmyfI5VkJ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dgyMUUN1w+92ZFNocVSr73it1djbG8QRIN6Oo9FcEiFJGQm0WvgiDgUwdMbkK4OONix6OUigI1e2sejTPEz6Ab+X/x6umzB8lAW96V8nriXGglBRXIwWlR1t55B0o+hiCKgvIP2NUJhNAhhD4vhVHA4ae/O9meTuHYAsNimjT9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org; spf=none smtp.mailfrom=idosch.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=S2UvkASs; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 6DA3411400FA;
	Sun,  2 Feb 2025 11:00:42 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Sun, 02 Feb 2025 11:00:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738512042; x=1738598442; bh=AeE79DlPUgKYrINviwyNykCRSBqnXfoGcmh
	/Cn8nGhE=; b=S2UvkASsfcVRew9JXhBeyQ40/qU/t3u8638Ekrylnwhc+U7P2dX
	0h4fFf22zTH6tAEdsh+whNEA5m6KNrxBn1hc5Y6DPRAH46gdtmkphu0fS+Z5w+AP
	vRQHkfT2uZLsyh6r6K23msuaA22aXsagDiKg8jOfVL3vmOCuvh+ui4pH0d/rIAIM
	RFsPG/wy0TsX2CD66m1wNoOPEsyLY58c/E7AHaAO5T9Q06Rd6w6EqMmnadUNNK0I
	EmQpWalwlU5aF+yYDHev4OO/5j2PdW7/xlDoVpf6OYmYR52vyfy6fNBJAO/k4l0b
	XK4risHSJbZc/cH/Kw0vIdF2CIt0BI0Mbgg==
X-ME-Sender: <xms:qZafZ1UUW6YWbDGGzk3w6E-tZgpOuU19uU6vELlMV9WSbt11wR49vw>
    <xme:qZafZ1kiXmXHsFLQKItgzg4a2SO7a0aeze1Q0z4gsW8lxPtU4r2tpKBy_lr0WJys5
    LLhOY2-tSy7vTM>
X-ME-Received: <xmr:qZafZxbuXIvEb5vq9HuVLp-rpWkIKnA61GFOm2FH8YYJtI4C8p10Uzd1T52De_ljI0KFWbSQBH5dMJ900UVyqMN3m9SgNw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduhedtlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefkughoucfutghhihhmmhgvlhcuoehiughoshgthhesihguohhstghhrd
    horhhgqeenucggtffrrghtthgvrhhnpedvudefveekheeugeeftddvveefgfduieefudei
    fefgleekheegleegjeejgeeghfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehiughoshgthhesihguohhstghhrdhorhhgpdhnsggprhgtphht
    thhopeduuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprghnnhgrvghmvghsvg
    hnhihirhhisehgmhgrihhlrdgtohhmpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdr
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepfhgvjhgvshesihhnfhdrvghlthgvrdhhuh
    dprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohep
    khhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehprggsvghnihesrhgvughhrg
    htrdgtohhmpdhrtghpthhtohepfihilhhlvghmsgesghhoohhglhgvrdgtohhmpdhrtghp
    thhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopehhohhrmh
    hssehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:qZafZ4WPpKnFAK59MmGo27c-TkYbS_Oif6cQ3RUkoHX2LOfs2eplnw>
    <xmx:qZafZ_ld4vSXu0oHqPa3qAUiVsBBlWrbzo7AJDHLI5e0wZeeoPAI8g>
    <xmx:qZafZ1dVQrXAQvYo2S3s2M-sVdvx75hgnGFvkwBsdUBj6xC9IANYhw>
    <xmx:qZafZ5ERvFbeD5eUCoIabKTrZZa5_79QRcdvWFstpv7E1sPvV_HF4w>
    <xmx:qpafZ4dgcHdzzuIl-wXMqfylIOzRQP7Bm8p9o40h9ayJ5THdbCmCC0QG>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 2 Feb 2025 11:00:41 -0500 (EST)
Date: Sun, 2 Feb 2025 18:00:37 +0200
From: Ido Schimmel <idosch@idosch.org>
To: Anna Emese Nyiri <annaemesenyiri@gmail.com>
Cc: netdev@vger.kernel.org, fejes@inf.elte.hu, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, willemb@google.com,
	davem@davemloft.net, horms@kernel.org, shuah@kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next 1/1] selftests: net: Add support for testing
 SO_RCVMARK and SO_RCVPRIORITY
Message-ID: <Z5-WpRAnP40UsMOS@shredder>
References: <20250129143601.16035-1-annaemesenyiri@gmail.com>
 <20250129143601.16035-2-annaemesenyiri@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250129143601.16035-2-annaemesenyiri@gmail.com>

On Wed, Jan 29, 2025 at 03:36:01PM +0100, Anna Emese Nyiri wrote:
> diff --git a/tools/testing/selftests/net/test_so_rcv.sh b/tools/testing/selftests/net/test_so_rcv.sh
> new file mode 100755
> index 000000000000..12d37f9ab905
> --- /dev/null
> +++ b/tools/testing/selftests/net/test_so_rcv.sh
> @@ -0,0 +1,56 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +
> +HOST=127.0.0.1
> +PORT=1234
> +TOTAL_TESTS=0
> +FAILED_TESTS=0
> +
> +declare -A TESTS=(
> +	["SO_RCVPRIORITY"]="-P 2"
> +	["SO_RCVMARK"]="-M 3"
> +)
> +
> +check_result() {
> +	((TOTAL_TESTS++))
> +	if [ "$1" -ne 0 ]; then
> +		((FAILED_TESTS++))
> +	fi
> +}
> +
> +for test_name in "${!TESTS[@]}"; do
> +	echo "Running $test_name test"
> +	arg=${TESTS[$test_name]}
> +
> +	./so_rcv_listener $arg $HOST $PORT &
> +	LISTENER_PID=$!
> +
> +	if ./cmsg_sender $arg $HOST $PORT; then

In addition to the other comments, please run both binaries in a
namespace that the test creates at the beginning via setup_ns() (from
lib.sh) and deletes at the end via cleanup_ns().

Thanks for adding the test.

> +		echo "Sender succeeded for $test_name"
> +	else
> +		echo "Sender failed for $test_name"
> +		kill "$LISTENER_PID" 2>/dev/null
> +		wait "$LISTENER_PID"
> +		check_result 1
> +		continue
> +	fi
> +
> +	wait "$LISTENER_PID"
> +	LISTENER_EXIT_CODE=$?
> +
> +	if [ "$LISTENER_EXIT_CODE" -eq 0 ]; then
> +		echo "Rcv test OK for $test_name"
> +		check_result 0
> +	else
> +		echo "Rcv test FAILED for $test_name"
> +		check_result 1
> +	fi
> +done
> +
> +if [ "$FAILED_TESTS" -ne 0 ]; then
> +	echo "FAIL - $FAILED_TESTS/$TOTAL_TESTS tests failed"
> +	exit 1
> +else
> +	echo "OK - All $TOTAL_TESTS tests passed"
> +	exit 0
> +fi
> -- 
> 2.43.0
> 

