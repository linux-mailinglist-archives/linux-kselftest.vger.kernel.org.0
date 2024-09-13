Return-Path: <linux-kselftest+bounces-17921-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 66FC1977996
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Sep 2024 09:27:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DF401C22950
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Sep 2024 07:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD0041BC07E;
	Fri, 13 Sep 2024 07:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BaHhRIDc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E8177107;
	Fri, 13 Sep 2024 07:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726212425; cv=none; b=fHWB1kwOAVZePlw4Hz5MLOvMWZMgiha7XdnCbJ1UE+MMFhS6NGhKGmLqhKjxszjPv4ed4WiOM6ynBRUkVqf9gt+YkIgwoo3YCycVr5/pognmc3psHER3G7VOBnnNpaZexTVWa3cEJqPOfKijoUgVm3NnA2NmchdxINDJ3x/ZgrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726212425; c=relaxed/simple;
	bh=YHrWZ756TWnCmNV+PsSyXX+0zIj/PE3ia94PWJfIGm0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WJAjpb8M0YMicKafZhq1j72CXXOtWHDRF/5qO3GTjuD9SsKvxuiIfER1sKqrWAOjREn7PwV7PQFBqFvclF8UPLC0uCXXGmjMoklNEE50Fwa+8H3wr8cxQf8J/iGiTh/R6Ysn56ORx7xOk2mQq9quMglR70JL25eLAakMNr/1VrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BaHhRIDc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B28EC4CEC0;
	Fri, 13 Sep 2024 07:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726212425;
	bh=YHrWZ756TWnCmNV+PsSyXX+0zIj/PE3ia94PWJfIGm0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BaHhRIDccAB+chq4vfIolGjqSeEg83jXPD9rNbdUr9nB5/qalCkKmr1FX/E8z3e8A
	 Fq2G5AaOuXhVk6j+SjVejHhvtB1b14B8RT3I909sg4e1/JOPKttO+W4O8PstFZa/tF
	 U2MoY8GK5rjFdB0ee9DQ9gWLeJ79qbhess8Q/RmCHjX+IkVyufUTNX3KH3r9JZq9PG
	 IJJOJA2f6q237Wh9f5SSsO1L+T0/3RFpi43x42GqwpcQSBpo29bk0rlpdzOdBB4dzq
	 hfSkl93kcOr7NY6EOvPA004XRR7x0+IKyvGh9B6yUFhu8rEPQINRj0/IyDlGkWSIhy
	 QEGwyGjkY0Mgw==
Date: Fri, 13 Sep 2024 08:26:58 +0100
From: Simon Horman <horms@kernel.org>
To: Alexis =?utf-8?Q?Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	ebpf@linuxfoundation.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH bpf-next v2] selftests/bpf: convert test_xdp_features.sh
 to test_progs
Message-ID: <20240913072658.GR572255@kernel.org>
References: <20240910-convert_xdp_tests-v2-1-a46367c9d038@bootlin.com>
 <20240911141824.GZ572255@kernel.org>
 <fb7db9a9-5b9a-4b77-8dc6-f30b839bec27@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fb7db9a9-5b9a-4b77-8dc6-f30b839bec27@bootlin.com>

On Thu, Sep 12, 2024 at 10:17:13PM +0200, Alexis Lothoré wrote:
> Hi Simon,
> 
> On 9/11/24 16:18, Simon Horman wrote:
> 
> [...]
> 
> >> diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_features.c b/tools/testing/selftests/bpf/prog_tests/xdp_features.c
> >> new file mode 100644
> >> index 000000000000..bcb36a2d2767
> >> --- /dev/null
> >> +++ b/tools/testing/selftests/bpf/prog_tests/xdp_features.c
> >> @@ -0,0 +1,446 @@
> >> +// SPDX-License-Identifier: GPL-2.0
> >> +
> >> +/**
> >> + * Test XDP features
> >> + *
> >> + * Sets up a veth pair, and for each xdp feature under test:
> >> + * - asks the tested interface its xdp capabilities through bpf_xdp_query
> >> + * - attach and run some specific programs on both interfaces to check if
> >> + *   announced capability is respected
> >> + */
> > 
> > Hi Alexis,
> > 
> > This is neither a full review nor an issue that needs to block progress.
> > But, FWIIW, the comment above is not a Kernel doc, yet starts with '/**'.
> > I suggest that it should start with '/*' instead.
> 
> ACK. I'll wait for more comments on the series, and add the fix to the
> corresponding revision, if any.

Thanks, much appreciated.

