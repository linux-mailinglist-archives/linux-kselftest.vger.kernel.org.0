Return-Path: <linux-kselftest+bounces-21023-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AA0C9B5721
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 00:43:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8885B22796
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 23:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A88C820C006;
	Tue, 29 Oct 2024 23:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jmWEdasI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7960720B201;
	Tue, 29 Oct 2024 23:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730245388; cv=none; b=r1x5acRluzHFHG09GmeXSNWaqR1aOzYJbS/Coj/tlSQX4Bo676EL8RRnWby1V8ExG+KGBhAzg5Y/pgbtrQSzEoHuYLWGB+OHjUCaZfL+G+IxEIFGqV2+oj5My7/hAO1PYJym2N1SDg1+L0trBtg1eZSjlyo2g5CfIGpY2YL/qpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730245388; c=relaxed/simple;
	bh=PnqjYA8U5yyLVavxuesHltH63d6Xppyk7ejLJ8Jv+FQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BXdZXdEiVmoRiqP19CA4FAaRlSiE02zBeYv81dyuuTTPP8BSbn/igVRz86f+5sItKJuSv2tUtV8Ltn8xKMfjrPvc/vbacCcYGMtSGXilkH4R/SzkDlFkyHXVvkAW46k6VW1Eb3agyC+sNqRDkXzEuIlyLSUAlhptwfd+HxqapUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jmWEdasI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9720CC4CECD;
	Tue, 29 Oct 2024 23:43:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730245388;
	bh=PnqjYA8U5yyLVavxuesHltH63d6Xppyk7ejLJ8Jv+FQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jmWEdasIwt0EoLzlzk8hRlFdRB1A5PYHNpXq0HVbNhXzCn2MkRlM6sRKR75ciVxuw
	 FgP7lq8LTTfKgNOwsXy0TtU8dR35UtKCPBsiPpLYzs7l9k7ASaQPrHmM/FJcRYkqte
	 S/UiwJt6/g5WIiPf4z9ap9050RFfSHzFhxYvbTvUuA+CNHbhEXvaJPajNmJpBwg2yT
	 M5tnmHzNkMGpG6y6pP0dHGxZbkTQpUAduUTNcSCMZbym91aqvGriM8TkIQ0g2GyFfK
	 wrM8CZTLjrcxMj0NhDEYfpVLoXkZC6es0ea3tOfgfVQozsrO3EWtjNFWoKULuuFDE6
	 cgMsOiwfCOC9g==
Date: Tue, 29 Oct 2024 16:43:06 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Li Zhijian <lizhijian@fujitsu.com>
Cc: linux-kselftest@vger.kernel.org, shuah@kernel.org,
 linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org
Subject: Re: [PATCH for-next 7/7] selftests/net: Fix ./ns-XXXXXX not cleanup
Message-ID: <20241029164306.6122b372@kernel.org>
In-Reply-To: <20241025014010.6533-7-lizhijian@fujitsu.com>
References: <20241025014010.6533-1-lizhijian@fujitsu.com>
	<20241025014010.6533-7-lizhijian@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 25 Oct 2024 09:40:10 +0800 Li Zhijian wrote:
> ```
> readonly STATS="$(mktemp -p /tmp ns-XXXXXX)"
> readonly BASE=`basename $STATS`
> ```
> It could be a mistake to write to $BASE rather than $STATS, where $STATS
> is used to save the NSTAT_HISTORY and it will be cleaned up before exit.

Agreed, although since we've been creating the wrong file this whole
time and everything worked -- should we just just delete those two
lines completely?

Similarly to patch 6 - please repost as a standalone patch so that our
CI will test it. If you only CC a mailing list on subset of patches
they are likely to be ignored by automation..
-- 
pw-bot: cr

