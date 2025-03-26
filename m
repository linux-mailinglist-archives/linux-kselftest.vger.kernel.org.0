Return-Path: <linux-kselftest+bounces-29838-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2678BA72040
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Mar 2025 21:56:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4CCA1766F1
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Mar 2025 20:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9599925E45D;
	Wed, 26 Mar 2025 20:54:50 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0CFD1F55FB;
	Wed, 26 Mar 2025 20:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743022490; cv=none; b=R/JGECuEHS8ndZAhe1JBuGMQsKLjewjlOSDZ9FKnj8MSAuy4vpk/Ez3sTRNrs4xueox5u4e0hq56QMoxwsADFL+9IguSCH4pzJYj7SiiB18UxyejysPs1oNAolc9axDFO2au4p3hKOr0mfzU9Pkl6rWRJDgKPFx8BMMFhEE6Si0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743022490; c=relaxed/simple;
	bh=JQYH6Zg4jnoka7zieh2nEFJFRsfxuEU6yzfTT1ofpSU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DbpzYWlV0tGbSRpPzv85NxdwgaJntf8UcM8rvMoUUpQpWYo48qs4GoezkNXbP7mB1lE2EGQ4FOBPLMFhsvLNmZce8DEBCmzvEPJlKXHAvOwEJSHvDDYrq43D3lxl24valxoC3pzcwUM9BJP5FxTFw7Dm+Xoy+qQkrdQo1HNAhsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=breakpoint.cc; spf=pass smtp.mailfrom=breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=breakpoint.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=breakpoint.cc
Received: from bigeasy by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <sebastian@breakpoint.cc>)
	id 1txXli-0001GT-LT; Wed, 26 Mar 2025 21:54:34 +0100
Date: Wed, 26 Mar 2025 21:54:34 +0100
From: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	"Maciej W. Rozycki" <macro@orcam.me.uk>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-mips@vger.kernel.org
Subject: Re: [PATCH v2 0/4] tools/nolibc: MIPS: entrypoint cleanups and
 N32/N64 ABIs
Message-ID: <20250326205434.bPx_kVUx@breakpoint.cc>
References: <20250225-nolibc-mips-n32-v2-0-664b47d87fa0@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250225-nolibc-mips-n32-v2-0-664b47d87fa0@weissschuh.net>

On 2025-02-25 18:02:34 [+0100], Thomas Wei=C3=9Fschuh wrote:
> Introduce support for the N32 and N64 ABIs. As preparation, the
> entrypoint is first simplified significantly. Thanks to Maciej for all
> the valuable information.
>=20
> Signed-off-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>

Tested-by: Sebastian Andrzej Siewior <sebastian@breakpoint.cc> [ICT Loongso=
n-3]

mips32le works as-is.
For mips64le I had to s/-march=3Dmips64r6/-march=3Dmips64r2 to match the
ABI. Which makes me wonder: Why do do we need to pass -march here and
can't rely on toolchain defaults?

Sebastian

