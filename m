Return-Path: <linux-kselftest+bounces-3094-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D98882F530
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Jan 2024 20:20:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DC361F248F8
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Jan 2024 19:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56AE81CFB6;
	Tue, 16 Jan 2024 19:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s6eZIivu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C8661CAB9;
	Tue, 16 Jan 2024 19:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705432814; cv=none; b=pkmuyX8g3SiWC57lCSdrchDolCsWcb+lJfKmLWh09IUfNkoAuPfKuz+wryKFv8HnQkczzIDQadANGr4Wj3wPTWam861IyuYPktiaKGBZncVyGXd3fzuglKCy3dpA2GMB4h3uyWXf3wqjx913yVwA8LM/h2ex9vfV6JEkeV/Qj/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705432814; c=relaxed/simple;
	bh=FwQNwleAH2pbP/ob7aj6LI1Lev5r74VjOMiVXQUCZU8=;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding; b=go6uZwIIkOXAn6Xp6C7jWJRWLo0o+GzPgh7cwiHdWo8Gdc04aO9tBudGTJX4yPsMwWQYl5KXiDmZrm9MGVb/ABvQAPg6QluvbvqtU9zXuLLCQuWLubNelJloX5BJabt1ApgifAqfl8h59HL4nrqALsLspiaVqZlolTHt2wvWjNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s6eZIivu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E1E7C433F1;
	Tue, 16 Jan 2024 19:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705432813;
	bh=FwQNwleAH2pbP/ob7aj6LI1Lev5r74VjOMiVXQUCZU8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=s6eZIivuKJO0BVQX28j8y5Oq4+VjX+IwljwRMQNE630DjqvFFDUy5RzvhaK4qLipD
	 exwtUY+/WA5VAn84BgTVC9spdcdvdz7EES1OwovsTcQ10uj45WGCFAQF5iuCfZdjrB
	 67iAIYqjyX1kkxQFhJWwrEz8jEFBjQtElq/upvnSxuvk9AtN3AJ+xx4ud8HoodGt85
	 VP5/HuOAwbPP149AqKdOqy9xrcy41mBfe2JSkiLgS3BQm55FEuSaaEyQ6LO5f/kLYP
	 JtcOd9e1S0ZgEzlULCLvAm/SaWHVVmKd7cDYULYHHisv+wMmx+LMLaO6v98D8HsZrl
	 yydz1CarQ6ypQ==
Date: Tue, 16 Jan 2024 11:20:12 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jay Vosburgh <jay.vosburgh@canonical.com>
Cc: Benjamin Poirier <bpoirier@nvidia.com>, Hangbin Liu
 <liuhangbin@gmail.com>, netdev@vger.kernel.org, Andy Gospodarek
 <andy@greyhouse.net>, Shuah Khan <shuah@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Jonathan Toppins <jon.toppins+linux@gmail.com>,
 Nikolay Aleksandrov <razor@blackwall.org>, Michal Kubiak
 <michal.kubiak@intel.com>, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net] selftests: bonding: Add more missing config options
Message-ID: <20240116112012.026e44d9@kernel.org>
In-Reply-To: <78106.1705431810@vermin>
References: <20240116154926.202164-1-bpoirier@nvidia.com>
	<20240116104402.1203850a@kernel.org>
	<78106.1705431810@vermin>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 16 Jan 2024 11:03:30 -0800 Jay Vosburgh wrote:
> 	If I'm reading it right, this will sleep for 12, 22, 32 and 52
> seconds for the passes through the loop in num_grat_arp(), so that would
> be 118 seconds just for that.

Hah, that's really tight if the default timeout is 120.
Let me send a patch to bump it to 300..

