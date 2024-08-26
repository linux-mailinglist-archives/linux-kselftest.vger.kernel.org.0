Return-Path: <linux-kselftest+bounces-16334-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DF2295FA56
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Aug 2024 22:04:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA6EF1C213D0
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Aug 2024 20:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 713D41990DB;
	Mon, 26 Aug 2024 20:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Om6GuGCV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E1F811E2;
	Mon, 26 Aug 2024 20:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724702666; cv=none; b=NTBMSWQ0wXdPGaFNRtQL9+jQozGXJxdnvOf8kxi/SK46rL2561WN3dt8SbdqY1+W8pVcpzw5k/O91rZm6SZusishQeYS44ocbuQaZho74WuUD1XWiZ0MvJuid+3JaA5DIYbeuWdHGTTLeovJb4jPg6f8ZNnDfPLH7CtEM9Ukuco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724702666; c=relaxed/simple;
	bh=/0Yhb4a07o4WbESMnukgufhnlYOgg1PzRIImHGNTeC0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PddwtuUpEQmPAj/Xf9yTYQxWmF5lHTsMPanymYSqd/4eYqouGF+S9LwVFRzNUaygMGkzhBv5QMRBAsaLgt0yrki012wHxhox/qNevmHEjuI8eM3clbIO4Ev73r8qtoLA2PCzw7sYH4eNnEamxm3nlkwZjBGlOiJtlil5IxiIa3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Om6GuGCV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A02DC4FEF9;
	Mon, 26 Aug 2024 20:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724702665;
	bh=/0Yhb4a07o4WbESMnukgufhnlYOgg1PzRIImHGNTeC0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Om6GuGCVZcVHTs6NZrW05nbzm3VfVYp1Gih/v0gGy5zATOz8jPr2FUraXXFhftfZl
	 Ip3ER39EXFXg9osnaRQj0rqOeQ5rGB21YC2yX7PAWWBPfp7Hha7VI1u8920owzeq5b
	 nFa5gWCbMxBAUH2l5SOLG2Jd250+/iMCLwUo5ybQh/sgA1Gerqu6E9La5qy7xFRCy8
	 yyMfaNH3sZ7LQ+/pWzHdJKVlqtj8q48H9K6n92HKGxKbfH04D+72UQKuitJCiKG0Hr
	 48018GYshxQ7zWt5q5yq3VVj9JE5GrUIp3fCagRpRKbSdGtqjMpCc5aA0sReddD8Ke
	 WFd6YtxWTrIdg==
Date: Mon, 26 Aug 2024 13:04:24 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Petr Machata <petrm@nvidia.com>
Cc: Ido Schimmel <idosch@nvidia.com>, Shuah Khan <shuah@kernel.org>,
 <linux-kselftest@vger.kernel.org>, <netdev@vger.kernel.org>, Amit Cohen
 <amcohen@nvidia.com>, Benjamin Poirier <bpoirier@nvidia.com>, Hangbin Liu
 <liuhangbin@gmail.com>, Vladimir Oltean <vladimir.oltean@nxp.com>,
 <mlxsw@nvidia.com>
Subject: Re: [RFC PATCH net-next 1/5] selftests: forwarding: Introduce
 deferred commands
Message-ID: <20240826130424.5924ef81@kernel.org>
In-Reply-To: <20240826130343.582d68dc@kernel.org>
References: <cover.1724324945.git.petrm@nvidia.com>
	<d5f8364b42f277daa9e235d23398e3dce5549e92.1724324945.git.petrm@nvidia.com>
	<Zsxai0ACHxfbwH-t@shredder.mtl.com>
	<87wmk38ieu.fsf@nvidia.com>
	<20240826130343.582d68dc@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 26 Aug 2024 13:03:43 -0700 Jakub Kicinski wrote:
> > > Does it make sense to place these helpers in net/lib.sh?    
> > 
> > Yeah, it does.  
> 
> Would it further make sense to split them to their own file
> (net/lib_defer.sh?) and source that in net/lib.sh?
> 
> Should be pretty self-contained.

Just saw your reply to Przemek, makes sense.

