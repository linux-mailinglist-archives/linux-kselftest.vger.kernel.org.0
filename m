Return-Path: <linux-kselftest+bounces-12044-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5D4190AB21
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Jun 2024 12:33:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FC6628524D
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Jun 2024 10:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5AE5192B87;
	Mon, 17 Jun 2024 10:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HhIdOlgr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCC231922CA;
	Mon, 17 Jun 2024 10:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718620422; cv=none; b=l2yrL6Vhd3G+DumRfilUR4JhyQnKoKUJt4KbUeVO6G+6hjGN+pHSYKSmTf/QZbiCpuyS8tXvXQNfvgZv7V8kexcN/+cDtWai6zkYNhPxlLzfls6YRTIPxF9EKi2l0KrFgUzfDNtm7SnHkQih+gT6MYqRHLG7V7wooewREeyFUyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718620422; c=relaxed/simple;
	bh=GZCp+iDL1kVJIIxty+nR0Ri78rNJu23FjKywHpYE2cY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cmAceY22i/A36Z0qALUNAG/b/cQF0nOxhH+Hu6DLtcQPTyusVgWFeWFt1PGcxuya59/0WaU2TDzWcTFkIXOjkCz++yt54F0pcbop1czwgQJgsW9Tg62KyoA82giiF3UNuBRdVhyBhJzbRC6o889Rq7F0YisfvlFNCPQ8o/clz5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HhIdOlgr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7ECFC2BD10;
	Mon, 17 Jun 2024 10:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718620422;
	bh=GZCp+iDL1kVJIIxty+nR0Ri78rNJu23FjKywHpYE2cY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HhIdOlgrqzPp6XRwtRZ1BRxGn6bvkL1flQFtKCPtDa6CEkNu0GhKj7ANVSkCst2sK
	 JMjfLMyiXc8D3sAL84/mpsk6LpL1AWBJ4kr47nl5XTsqvALcI9C3GhzorCeYxWRanp
	 WOQjF/Utrl3+cSTT5tWs3cwVXYowRhsBODH/2qHiP8dH58zWg13okMtl33XIBNrhSx
	 j2AUWF8Enx3DTJYLgpy6TsPhPFNeqVXWkQbMwaUMLm7AcDpygrjDDkgl38oDr7DbsO
	 OPs5cu/pHOLYCTwYe9JKuDX0Njx2lMXUO8C3HxF1wgvpJavmmgRd0PDS+QztVxCxKA
	 KnlT4CB6fpdqg==
Date: Mon, 17 Jun 2024 11:33:37 +0100
From: Simon Horman <horms@kernel.org>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Aaron Conole <aconole@redhat.com>, Adrian Moreno <amorenoz@redhat.com>,
	Pravin B Shelar <pshelar@ovn.org>, Shuah Khan <shuah@kernel.org>,
	netdev@vger.kernel.org, dev@openvswitch.org,
	linux-kselftest@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net] selftests: openvswitch: Use bash as interpreter
Message-ID: <20240617103337.GQ8447@kernel.org>
References: <20240617-ovs-selftest-bash-v1-1-7ae6ccd3617b@kernel.org>
 <594b79b7-452c-488f-8a7f-4ee95698bff2@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <594b79b7-452c-488f-8a7f-4ee95698bff2@intel.com>

On Mon, Jun 17, 2024 at 12:05:11PM +0200, Przemek Kitszel wrote:
> On 6/17/24 10:28, Simon Horman wrote:
> > openvswitch.sh makes use of substitutions of the form ${ns:0:1}, to
> > obtain the first character of $ns. Empirically, this is works with bash
> > but not dash. When run with dash these evaluate to an empty string and
> > printing an error to stdout.
> > 
> >   # dash -c 'ns=client; echo "${ns:0:1}"' 2>error
> >   # cat error
> >   dash: 1: Bad substitution
> >   # bash -c 'ns=client; echo "${ns:0:1}"' 2>error
> >   c
> >   # cat error
> > 
> > This leads to tests that neither pass nor fail.
> > F.e.
> > 
> >   TEST: arp_ping                                                      [START]
> >   adding sandbox 'test_arp_ping'
> >   Adding DP/Bridge IF: sbx:test_arp_ping dp:arpping {, , }
> >   create namespaces
> >   ./openvswitch.sh: 282: eval: Bad substitution
> >   TEST: ct_connect_v4                                                 [START]
> >   adding sandbox 'test_ct_connect_v4'
> >   Adding DP/Bridge IF: sbx:test_ct_connect_v4 dp:ct4 {, , }
> >   ./openvswitch.sh: 322: eval: Bad substitution
> >   create namespaces
> > 
> > Resolve this by making openvswitch.sh a bash script.
> > 
> > Fixes: 918423fda910 ("selftests: openvswitch: add an initial flow programming case")
> > Signed-off-by: Simon Horman <horms@kernel.org>
> 
> That's good fix,
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> 
> sidenote: I like very much the idea to use the least powerful tool, like
> sh vs bash, awk vs gawk, but it breaks when we forget what is outside of
> the scope of the former/standard.
> Perhaps for shell, we could convert all the selftests at once?

Thanks,

Now that you mention it, I have the same feelings.

Do we ever expect to use the minimal tools, when other
parts of the test suite depend on the enhanced ones?

...

