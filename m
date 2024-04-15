Return-Path: <linux-kselftest+bounces-8031-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEF1D8A5C0E
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Apr 2024 22:10:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B01D281CB8
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Apr 2024 20:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E23E215666C;
	Mon, 15 Apr 2024 20:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pmachata.org header.i=@pmachata.org header.b="mEKrhpyz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 607E7155A59;
	Mon, 15 Apr 2024 20:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713211830; cv=none; b=K300eLZAODf5NiUft+H06UHW/yz9x1mCEcSossGyLJeU74yG3KLXVL2WwhMNeVGl4xn+c5XnEm1idigvKGpkxOVPS1PrYeSKIUUF6KzvjOvr6uO4hJxPEfOEyYuKyloApe4LKBOdGk8f5vHhf/IOMPdelO9SEC3x5zrdq4LiDoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713211830; c=relaxed/simple;
	bh=g8JK/aZCfmHBUAxyv41ehSIOXvujf2qcRQoAhesluaM=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=p0W1EuaHJflG6c4FqxqUyCwSkYMK+dGcBVCEAr6xW8ZX/eJ1U64pwv6JdTGTCEqCuD0yUHmuAx7Zgz6p58rvAkGuqUozlDURf7qiIU7wEbMb+OeCjsthfiKktbeZzQmnXjYj3M0lc/IyKs2ySxTbviT7Nn46lUxwJhunlfihh0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pmachata.org; spf=pass smtp.mailfrom=pmachata.org; dkim=pass (2048-bit key) header.d=pmachata.org header.i=@pmachata.org header.b=mEKrhpyz; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pmachata.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pmachata.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4VJJF42DRJz9t1M;
	Mon, 15 Apr 2024 22:10:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pmachata.org;
	s=MBO0001; t=1713211816;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eJeqVcsNvKE6dvU+h4J3wYSeASrfvCc7lVMr6jvZV1U=;
	b=mEKrhpyzOQEWJBdVbnAEYbjg9WdFuDilOv7CCF+0YzFkwkEAmoVHjXNR01N5YxCljOk/HG
	BH3iL6Ek12wEieRrf8Bgm56kVa4MnrmNsx70FkUz+9U09kTC4n30jH+APZ0x8I39EXl6me
	iVqct7RVQJ4/c/EBkbj+jV/8GBGji3rlqfPmr4m9tGka1sQm4Nff/8mnrFRukVJ7B/Am5U
	SF26FQwsQkz++LpkZkawut87jO/Z3t9W1HDMyub3Pyd1S41qSsmusSo+EH7GQdA/tZd1Rl
	dVHfp0ZBJisdeNrvKvAPSy+z0ApefcEZxT+aWmGDY4y/42hY4anytrCoHzPjAQ==
References: <20240412233705.1066444-1-kuba@kernel.org>
 <20240412233705.1066444-2-kuba@kernel.org>
 <661c0cae8110a_3e773229418@willemb.c.googlers.com.notmuch>
From: Petr Machata <me@pmachata.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, shuah@kernel.org, petrm@nvidia.com,
 linux-kselftest@vger.kernel.org, willemb@google.com, Jakub Kicinski
 <kuba@kernel.org>
Subject: Re: [PATCH net-next 1/5] selftests: drv-net: define endpoint
 structures
Date: Mon, 15 Apr 2024 21:39:06 +0200
In-reply-to: <661c0cae8110a_3e773229418@willemb.c.googlers.com.notmuch>
Message-ID: <87v84ie6aj.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: 4VJJF42DRJz9t1M


Willem de Bruijn <willemdebruijn.kernel@gmail.com> writes:

> 1. Cleaning up remote state in all conditions, including timeout/kill.
>
>    Some tests require a setup phase before the test, and a matching
>    cleanup phase. If any of the configured state is variable (even
>    just a randomized filepath) this needs to be communicated to the
>    cleanup phase. The remote filepath is handled well here. But if
>    a test needs per-test setup? Say, change MTU or an Ethtool feature.
>    Multiple related tests may want to share a setup/cleanup.

Personally I like to wrap responsibilities of this sort in context
managers, e.g. something along these lines:

    class changed_mtu:
        def __init__(self, dev, mtu):
            self.dev = dev
            self.mtu = mtu

        def __enter__(self):
            js = cmd(f"ip -j link show dev {self.dev}", json=True)
            self.orig_mtu = something_something(js)
            cmd(f"ip link set dev {self.dev} mtu {self.mtu}")

        def __exit__(self, type, value, traceback):
            cmd(f"ip link set dev {self.dev} mtu {self.orig_mtu}")

    with changed_mtu(swp1, 10000):
       # MTU is 10K here
    # and back to 1500

A lot of this can be made generic, where some object is given a setup /
cleanup commands and just invokes those. But things like MTU, ethtool
speed, sysctls and what have you that need to save a previous state and
revert back to it will probably need a custom handler. Like we have them
in lib.sh as well.

