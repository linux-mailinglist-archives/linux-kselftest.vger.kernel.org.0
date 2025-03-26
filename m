Return-Path: <linux-kselftest+bounces-29842-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2E04A721D0
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Mar 2025 23:04:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F5B13B92BE
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Mar 2025 22:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8874C1B0424;
	Wed, 26 Mar 2025 22:04:39 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 029671B040D;
	Wed, 26 Mar 2025 22:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743026679; cv=none; b=bXYzq1cod2KT3LcbtNyV6ypgWzJKspdHIP1p55atpI/LwgL1Le6SnGtF1UiE+gVHqgm19/uRH07mM6xE1pAnYUKLy7Dsa3YzJ4x0WDcvCnddvaTVIcuUCAJQs0DiCr5aG22oS9VtOroR1I7UuIgDzdiiQ82Bxg41wLU+ZnRuuhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743026679; c=relaxed/simple;
	bh=Zh2UWJYG8bBasfUkVNTPqK0ACUoQtQj1ANKJcOkOs0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j88PozyLIZaeO/jm87+4qW2kB4eGSSbD6ylFTjS3N/WToXcvWF3lgEG8fa1k3xmgnFqepwYaAs5Kee54T4HIc8cGbzVnvjHem8b8BBuCPUgWCNHIC+jxGgs2+5fMgdgTw3EHI8Nupxn5l24gNNHGU6zI5KkqANPpPzUVEAP2zZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=breakpoint.cc; spf=pass smtp.mailfrom=breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=breakpoint.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=breakpoint.cc
Received: from bigeasy by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <sebastian@breakpoint.cc>)
	id 1txYrP-0001jB-1w; Wed, 26 Mar 2025 23:04:31 +0100
Date: Wed, 26 Mar 2025 23:04:30 +0100
From: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	"Maciej W. Rozycki" <macro@orcam.me.uk>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-mips@vger.kernel.org
Subject: Re: [PATCH v2 0/4] tools/nolibc: MIPS: entrypoint cleanups and
 N32/N64 ABIs
Message-ID: <20250326220430._IkF6-zy@breakpoint.cc>
References: <20250225-nolibc-mips-n32-v2-0-664b47d87fa0@weissschuh.net>
 <20250326205434.bPx_kVUx@breakpoint.cc>
 <60e78caf-49e5-42ad-900c-9813518d838b@t-8ch.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <60e78caf-49e5-42ad-900c-9813518d838b@t-8ch.de>

On 2025-03-26 22:51:54 [+0100], Thomas Wei=C3=9Fschuh wrote:
> > mips32le works as-is.
> > For mips64le I had to s/-march=3Dmips64r6/-march=3Dmips64r2 to match the
> > ABI. Which makes me wonder: Why do do we need to pass -march here and
> > can't rely on toolchain defaults?
>=20
> The goal here is to have an as-wide-as-possible test matrix for
> nolibc-test, which will mostly be running on QEMU anyways.
> Also we need to run the correct QEMU user variant; by fixing the
> architecture this is easy to do.

I would prefer to make distro users as in real hardware first class
citizen and not QEMU users. If you run qemu you can specify the ABI
anyway.

> Thomas

Sebastian

