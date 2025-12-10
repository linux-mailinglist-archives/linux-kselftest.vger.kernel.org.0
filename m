Return-Path: <linux-kselftest+bounces-47361-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E557BCB280E
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Dec 2025 10:13:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 564F130056CD
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Dec 2025 09:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93F04302773;
	Wed, 10 Dec 2025 09:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QA3OXfKS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6214E3B8D60;
	Wed, 10 Dec 2025 09:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765358003; cv=none; b=myTOYDfv94YJS9kHNLKGNwg+GpPKj0AtWcQJG3i+dSOzfr3Ha5Ra+yCfrOFaKX8K3gPEnr/a14ymrqoqN3Zu0IRQf0EE4S+2IbocUWYhPL0KShvxODIjId9boIKfVv0/XMJF+1GU7h2d+z964j+7vOOaQI7bD/PGOGeehvUl29w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765358003; c=relaxed/simple;
	bh=oPU0AhvyU7XFAxzbw3MaEzplrvP8zU2pVCfuZ1hVhaM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nYmGvkCtTGJA2lSSBUnUNHmiH5UYjxo1ObXOSCo/LjW+554LlOF9MFdMIH9YBJpDV4lodzpFC0GKRl1PT+4Wl9WbYeVviKRJ/n+MO8X7GPB/fiJZm9FTFs08LRIhr8BPS6thMccUeYYvd3z/T+bg+lLhS0XEFG+Bbosx4jCzOvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QA3OXfKS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE6DFC4CEF1;
	Wed, 10 Dec 2025 09:13:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765358003;
	bh=oPU0AhvyU7XFAxzbw3MaEzplrvP8zU2pVCfuZ1hVhaM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QA3OXfKSYWRf3eeZyknnUI8/skeBA9H9nwF1GzaR5nhH7FztO20QA1rrh8iniiA9h
	 oyCFoPwAzbNV5erWjUpeJQFrxJkq/GaiKzDiqhScrLGxX/yAxSIApeeSc8VXGw45T6
	 ND5GRoIxKj2ekDxXcXptgk6s9ammiJw/CnMGQkzyevKsfCN/lYupFWGzZ0sVxeGCeZ
	 Jmu1SeP2OTmHZMO0Z1lCn8y629cyLli67qkGf/ZCjOX0zSPaBg1ufw8bFuq23ooyhG
	 EH73Y9QkbFXa290lgbX3lXLMGT/VGT1/pSr7+j0ZOF84C+t9zbZaJZl4UzTvd2dLxw
	 F5BC5VEAnMhTg==
Date: Wed, 10 Dec 2025 18:13:18 +0900
From: Jakub Kicinski <kuba@kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Shuah Khan <shuah@kernel.org>, Christian Brauner <brauner@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Eric
 Dumazet <edumazet@google.com>, Kees Cook <kees@kernel.org>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 wine-devel@winehq.org, netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH v2 08/13] selftests: net: netlink-dumps: Avoid
 uninitialized variable warning
Message-ID: <20251210181318.73075886@kernel.org>
In-Reply-To: <20251205171010.515236-9-linux@roeck-us.net>
References: <20251205171010.515236-1-linux@roeck-us.net>
	<20251205171010.515236-9-linux@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri,  5 Dec 2025 09:10:02 -0800 Guenter Roeck wrote:
> The following warning is seen when building netlink-dumps.
>=20
> netlink-dumps.c: In function =E2=80=98dump_extack=E2=80=99:
> ../kselftest_harness.h:788:35: warning: =E2=80=98ret=E2=80=99 may be used=
 uninitialized
>=20
> Problem is that the loop which initializes 'ret' may exit early without
> initializing the variable if recv() returns an error. Always initialize
> 'ret' to solve the problem.

Are you sure you're working off the latest tree? I think this should
already be fixed by 13cb6ac5b50

I applied the other 3 networking changes.

