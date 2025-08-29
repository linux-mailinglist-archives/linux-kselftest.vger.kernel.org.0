Return-Path: <linux-kselftest+bounces-40287-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F4BBB3BC4C
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Aug 2025 15:18:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03D955A083A
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Aug 2025 13:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87D68320393;
	Fri, 29 Aug 2025 13:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qeddB7eT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF142EB869;
	Fri, 29 Aug 2025 13:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756473253; cv=none; b=oCcQNGe5yOMxzmuRGqCvyLda7Uez3ItpZDoPg1Yfbjcu5KW8g1ma1ug2UH2ea3igdEUTdChd1Np3TlzTNK8/PrUTo+p2YdqaA5uTPNIy8F5KkPj6APLDnzfodLhrBflte6zQEuaHVMpTc7UPMTAWeL+ak6RH1qdoI0aAi2EE2ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756473253; c=relaxed/simple;
	bh=vn78dxpS7nVM7YM+o/8hcv7e2zoL/2MljBn9gVbIGcM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fEk8/Z4Fjewnc/v047asHbFniHBj9qTAriqMkQAsXcoe45eUPBndST+KYqpL1Rehb4LKZDXmS+amuEISpqTiKSIBF75z/maK846Cvz5xbj/shUc6XBayaAmZTXFZxKMFSq/afI2Tq+s/+3A6cpebC3CrFgLIqsr4hoGf7zYjZ4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qeddB7eT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BA93C4CEF0;
	Fri, 29 Aug 2025 13:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756473252;
	bh=vn78dxpS7nVM7YM+o/8hcv7e2zoL/2MljBn9gVbIGcM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qeddB7eTmQvUdrE1gFfrOaqqAIZwpxPutGLGTTDOuFKWPLDWMNYfGIxps/PyEJPZs
	 hd4j4NByzzsoqWPBzIYU4VXd6qX3W4FiY4fpv4SZlsqgmXGekFN9LTrnI4B0ZbC5Tn
	 q7xkanwGfk6bb1jflUBERCelUzElGQFLDYvG5rBrUAMxXiRbNKrPeQ7Ds9WV49mbKb
	 3IjzFT1pxaHdNxCnFk+7TFTKii7VNEvTg2D6dLKOya6v9A30TcSwWZR5CTAt7Kh/sN
	 ezCf3EYxefmOfI57pfFbi1JXWoR09JZIUSf6p80d3Hp/09zvj961/tyzbHvE2FtcLu
	 rxCCCChc7y6og==
Date: Fri, 29 Aug 2025 14:14:07 +0100
From: Simon Horman <horms@kernel.org>
To: Madhur Kumar <madhurkumar004@gmail.com>, dev@openvswitch.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	i.maximets@ovn.org, edumazet@google.com,
	linux-kselftest@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
	shuah@kernel.org, davem@davemloft.net
Cc: Aaron Conole <aconole@redhat.com>,
	Praveen Balakrishnan <praveen.balakrishnan@magd.ox.ac.uk>
Subject: Re: [ovs-dev] [PATCH] selftests/net: openvswitch: Fix spelling error
 in print message
Message-ID: <20250829131407.GA56092@horms.kernel.org>
References: <20250814180007.406941-1-madhurkumar004@gmail.com>
 <20250826173415.GM5892@horms.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250826173415.GM5892@horms.kernel.org>

+ Aaron Conole, Praveen Balakrishnan

On Tue, Aug 26, 2025 at 06:34:15PM +0100, Simon Horman via dev wrote:
> On Thu, Aug 14, 2025 at 11:30:01PM +0530, Madhur Kumar wrote:
> > Fix a typo in a print statement in ovs-dpctl.py:
> > "Unkonwn" → "Unknown".
> 
> Hi Madhur,
> 
> You need to include a Signed-off-by line here.
> 
> Please see [1] and [2].
> 
> [1] https://docs.kernel.org/process/submitting-patches.html#developer-s-certificate-of-origin-1-1
> [2] https://docs.kernel.org/process/maintainer-netdev.html#changes-requested

Hi again,

Aaron (CCed) brought to my attention that a superset of this patch has been
posted by Praveen Balakrishnan.

- [PATCH] selftests: net: fix spelling and grammar mistakes
  https://lore.kernel.org/netdev/20250828211100.51019-1-praveen.balakrishnan@magd.ox.ac.uk/

I'd like to suggest that we keep things simple and go with that patch.

