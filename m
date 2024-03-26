Return-Path: <linux-kselftest+bounces-6599-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 050CE88B653
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Mar 2024 01:48:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AFC62C37DE
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Mar 2024 00:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 897941BF27;
	Tue, 26 Mar 2024 00:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jnbUEh2x"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E1C17543
	for <linux-kselftest@vger.kernel.org>; Tue, 26 Mar 2024 00:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711414095; cv=none; b=qYp1Tp3lZqhD+l4Czldkrvn5chq0D0O2JF7ntA1kuy542xlzlbdh6TLSx7jViKlnwpdtwplxPLnsiQB8wn5s6sJuos3p204d7XQQIwcomUpZddA44BksFoT5ntjRerAZ9FjqtZSWdFCadNb3BNY+E7jJjyR6wfeO4XDOO2MPN7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711414095; c=relaxed/simple;
	bh=nC7jWSPMcZ3DGlq0LJ0vX1gPaAmQ2lbWdvs3qrIf540=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=siiWZ8oBcaT3yI2MzGpQHhKiSpfj3rGzAXqfKfsdES6j6avhMlXOh4fdZoLgun79ZJQweqREtRAWenyTw2Unn804pOWaKWC3pCZS44+toa8nGVAyZbfBNcIvt/CIC+NmEqJMFz+ciI2FT38UxYYuYSrt67Om3BPFSVpOVm2YzcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jnbUEh2x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B264C433C7;
	Tue, 26 Mar 2024 00:48:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711414094;
	bh=nC7jWSPMcZ3DGlq0LJ0vX1gPaAmQ2lbWdvs3qrIf540=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jnbUEh2xcOGTvHmMS8bp6FYB4b1Tu3Ef3X9AVgymtklwRmBPW1H2j+ZT5NQvqOZPF
	 /HB2dDPMH5jVKLYLIk2PedMTlKwqsM963xFCQ+plQIuXXqviU3/yKJmmJpsvatN9nO
	 0atJ5T+WIyagYXXoxp2FikHcbaRRwt41H3aAnlggdKKcJ3PJa1PQazG9VPtACp8CB4
	 +93OzatZrf1M9DtBmO7my+mO1HOQvqOcUXNXyd37Us8t7qJz852hw85hWm7aunHVZK
	 YdSekP9YkkdckStB/4dZ9BsHX2tgEsS0Ewl/UK+I6TGhU43HOmFbaacplfcYi30+3I
	 f3n1IPRWZ08HA==
Date: Mon, 25 Mar 2024 17:48:13 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Petr Machata <petrm@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 <nbu-linux-internal@nvidia.com>, Shuah Khan <shuah@kernel.org>, Nikolay
 Aleksandrov <razor@blackwall.org>, Hangbin Liu <liuhangbin@gmail.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>, Benjamin Poirier
 <bpoirier@nvidia.com>, "Ido Schimmel" <idosch@nvidia.com>, Jiri Pirko
 <jiri@nvidia.com>, <linux-kselftest@vger.kernel.org>
Subject: Re: [RFC PATCH net-next mlxsw 00/14] selftests: Fixes for kernel CI
Message-ID: <20240325174813.3111a5c7@kernel.org>
In-Reply-To: <cover.1711385795.git.petrm@nvidia.com>
References: <cover.1711385795.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 25 Mar 2024 18:29:07 +0100 Petr Machata wrote:
> As discussed on the bi-weekly call on Jan 30, and in mailing around
> kernel CI effort, some changes are desirable in the suite of forwarding
> selftests the better to work with the CI tooling. 

Excellent.

Did you skip CCing netdev@ on purpose or by accident?
Feel free to send it to the list without the RFC tag
(pw-bot will auto-discard it if it sees RFC).

