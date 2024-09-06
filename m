Return-Path: <linux-kselftest+bounces-17343-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D9B4D96E758
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Sep 2024 03:42:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11C2C1C23449
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Sep 2024 01:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54EF31B960;
	Fri,  6 Sep 2024 01:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LbjfkyH4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23A0F288B5;
	Fri,  6 Sep 2024 01:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725586926; cv=none; b=n0NTusE5VPlC3Xx/xtvXAmlacmb8nZm3k8JmQLfYhW0cphCAPyMcyzeJniA4Yus+Sp7Xc4vzsepvUGQeFQRWuQmOsqGGcIDo2uE+NVlXnIhrwdpntHfXa2i25JzgIFuZwR1U0HYEuNy8aTSTFjd9nHq2fCk51xUV9fYsbkVrmZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725586926; c=relaxed/simple;
	bh=wzWJ2grsEBS1oOgFBCqpVg7HIZfDqD5DVDovKWkIM70=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nbg1iNKF1rCZ9cgMH3Up1wi/tLLyOU98Tq/QJEavhxKPEe4t9wymwrbJ77cj2S0+9u6IsRja1dB+GSqOvzlJLSDVmXT9/ENruLyLwD8tlM4xIBq1gAnL4kAUgPC6eQEY5XOHk0YnT4/+P0Ov3vgXvE8/Fa9Ie5qDNuhQkgC10HQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LbjfkyH4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 190AEC4CEC3;
	Fri,  6 Sep 2024 01:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725586925;
	bh=wzWJ2grsEBS1oOgFBCqpVg7HIZfDqD5DVDovKWkIM70=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LbjfkyH4RMHF3yE+hp6qcHD4naomEyO931mU51a3tWJKzqIW70v5HAcajUmHBNBrj
	 wuE4g2FKEnCpQvs6/bg8i++dIMMusygWb34M3ZWVQ/pX8znMgcCk0qU8sYRHFjrYMS
	 ufPp/Zy/n0Ov9oAx7KmHqyuxUyBh70js8IsQACZKnH7ZzRagX28pKVrm/zqKxi/H69
	 TOThrXwMBvtcfXBkx5TNC4RuIlibs+QoqwbZn45FR/ykc3S3r22fa4jJ+c3UxBdY+Q
	 +jEdVHbcQfNMEmy5Se8g0AsrMySHS9N2YSSFjGQo+i6ri3YqWKuwNXZyGrIbYbOTNe
	 BmHS7GNLvS0AA==
Date: Thu, 5 Sep 2024 18:42:04 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, ncardwell@google.com, shuah@kernel.org,
 linux-kselftest@vger.kernel.org, fw@strlen.de, Willem de Bruijn
 <willemb@google.com>
Subject: Re: [PATCH net-next 2/2] selftests/net: integrate packetdrill with
 ksft
Message-ID: <20240905184204.797a4c49@kernel.org>
In-Reply-To: <66da5b8b27259_27bb41294c@willemb.c.googlers.com.notmuch>
References: <20240905031233.1528830-1-willemdebruijn.kernel@gmail.com>
	<20240905031233.1528830-3-willemdebruijn.kernel@gmail.com>
	<20240905143128.0dde754f@kernel.org>
	<66da3dabc3f71_25102d29476@willemb.c.googlers.com.notmuch>
	<66da4ab570989_269be02944d@willemb.c.googlers.com.notmuch>
	<66da5b8b27259_27bb41294c@willemb.c.googlers.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 05 Sep 2024 21:31:55 -0400 Willem de Bruijn wrote:
> > Packetdrill scripts are sensitive to timing.
> > On the dbg build, I just observe a flaky test.
> > 
> > The tool takes --tolerance_usecs and --tolerance_percent arguments.
> > I may have to update ksft_runner.sh to increase one if a dbg build is
> > detected.
> > 
> > Let me know if I should respin now. Else I can also follow-up.
> > 
> > Need to figure out how best to detect debug builds. It is not in
> > uname, and no proc/config.gz. Existence of /sys/kernel/debug/kmemleak
> > is a proxy for current kernel/configs/debug.config, if a bit crude.  
> 
> Should have kept on reading. Will use KSFT_MACHINE_SLOW:
> 
> +declare -a optargs
> +if [[ "${KSFT_MACHINE_SLOW}" == "yes" ]]; then
> +       optargs+=('--tolerance_usecs=10000')
> +fi
> +
>  ktap_print_header
>  ktap_set_plan 2
> 
> -packetdrill ${ipv4_args[@]} $(basename $script) > /dev/null \
> +packetdrill ${ipv4_args[@]} ${optargs[@]} $(basename $script) > /dev/null \
>         && ktap_test_pass "ipv4" || ktap_test_fail "ipv4"
> -packetdrill ${ipv6_args[@]} $(basename $script) > /dev/null \
> +packetdrill ${ipv6_args[@]} ${optargs[@]} $(basename $script) > /dev/null \
>         && ktap_test_pass "ipv6" || ktap_test_fail "ipv6"
> 
> 
> > Another config affecting timing may be CONFIG_HZ. I did not observe
> > issues with these specific scripts with CONFIG_HZ=250. It may have to
> > be tackled eventually. Or CONFIG_HZ=1000 hardcoded in config.  
>  
> I will just add the CONFIG for now.

Not sure I follow the HZ idea, lowering the frequency helps stability?

We can see how well v2 does overnight, so far it's green:
https://netdev.bots.linux.dev/contest.html?executor=vmksft-packetdrill-dbg
(the net-next-2024-09-05--* branches had v1).

FWIW status page lists two sets of packetdrill runners, probably 
because I 'reused' an old team-driver runner instead of creating
a new one. It should straighten itself out by tomorrow.

