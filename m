Return-Path: <linux-kselftest+bounces-29926-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D9BCA75BE2
	for <lists+linux-kselftest@lfdr.de>; Sun, 30 Mar 2025 21:19:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 956FA1888CAF
	for <lists+linux-kselftest@lfdr.de>; Sun, 30 Mar 2025 19:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C4A71CDA3F;
	Sun, 30 Mar 2025 19:19:45 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE42C80C02;
	Sun, 30 Mar 2025 19:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743362385; cv=none; b=B7aBtwn8ZK49nuNSEj02oEBrtkkiJ3/jgs9q4rAgncFdozfem0LNLQKaCO0UCHh5RHrC1oOrP8U0R3UPHjwHCtLpsQ3z9vGcLkZh3WJHEg8Nt+ZoSRG4U1mYDrg3vyeqiWOqHLaMjKpe9i5GwulEXZ4D+mz0dXbjLztN5yEEc94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743362385; c=relaxed/simple;
	bh=NK8A9IK2TwM8Rn4visRZVeXeLeV20HHbC0t4xC+R9nU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g/GtFfywF6R9R4EN46vQ+zxzpfhOS/wa920chguFPCV+Z4neH7z4T6MWpB8xkSKiP3MsSa4RMV0qLlfQt7jkQaZNId3yj7tjqO3RXs2KXmUy67RXD8RNEZDG2He5gWB8dXpoqDqHxrZPNTWL9NAFflPAcT9kwGNqQuckXquJTBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=breakpoint.cc; spf=pass smtp.mailfrom=breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=breakpoint.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=breakpoint.cc
Received: from bigeasy by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <sebastian@breakpoint.cc>)
	id 1tyyBn-0005fB-7s; Sun, 30 Mar 2025 21:19:23 +0200
Date: Sun, 30 Mar 2025 21:19:23 +0200
From: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	"Maciej W. Rozycki" <macro@orcam.me.uk>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-mips@vger.kernel.org
Subject: Re: [PATCH v2 0/4] tools/nolibc: MIPS: entrypoint cleanups and
 N32/N64 ABIs
Message-ID: <20250330191923.M_4QMXqa@breakpoint.cc>
References: <20250225-nolibc-mips-n32-v2-0-664b47d87fa0@weissschuh.net>
 <20250326205434.bPx_kVUx@breakpoint.cc>
 <60e78caf-49e5-42ad-900c-9813518d838b@t-8ch.de>
 <20250326220430._IkF6-zy@breakpoint.cc>
 <7fef431b-1b68-4967-8f8a-d2b49e403578@t-8ch.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <7fef431b-1b68-4967-8f8a-d2b49e403578@t-8ch.de>

On 2025-03-29 10:51:47 [+0100], Thomas Wei=C3=9Fschuh wrote:
>=20
> Does the following work for you when running kust "make nolibc-test"?

I had to manually apply this on top of b4/nolibc-mips-n32. The resulting
make produced the native 64bit binary.

Sebastian

