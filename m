Return-Path: <linux-kselftest+bounces-26339-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F857A304EC
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 08:54:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B23053A386D
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 07:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 065841EE019;
	Tue, 11 Feb 2025 07:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=avm.de header.i=@avm.de header.b="cjWTWyqX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.avm.de (mail.avm.de [212.42.244.94])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 784F91E9B39;
	Tue, 11 Feb 2025 07:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.42.244.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739260486; cv=none; b=rPdto4FgQqc3ZAlqIxrpEoMxKbDRnqd7Vs47YZhHO5ZKOyQz+BV7YQOaamoOMHJRCWWIblbpFK6MPhMHm5HP8mupH65kpWDbY68vIYox9ewR978q5APG/lRUmSKvp2tCw+yJoQUH/QN3XntDp6LG0PEGGP58yMocGPnaRIOxVMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739260486; c=relaxed/simple;
	bh=zeYqsmy3zOjGEu/ZNTX027ncYMz1t9krEA8HwArBA2s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Io0h64a5JYKdRKOxz8pFQiZDjdrJdre3hyCydgJHRy6lKLJzPrInZ0sQz9R95k1wqd7M6kG3+NgqoSkGQB5qnaDDDNmAdlF7UDde0nqeCgPZHXpfrhp1uhfrhiEUwCSgupBqliisF6T3L8bTbtSy0/OCKKSTK+b9obfhjplEBYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de; spf=pass smtp.mailfrom=avm.de; dkim=pass (1024-bit key) header.d=avm.de header.i=@avm.de header.b=cjWTWyqX; arc=none smtp.client-ip=212.42.244.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=avm.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
	t=1739260113; bh=zeYqsmy3zOjGEu/ZNTX027ncYMz1t9krEA8HwArBA2s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cjWTWyqXIm4qG5RQ+weSzjFX/zpNVo8yMker3i+OKmCeYtRqnn+7lR7PDR4xtcLW0
	 fgpJMjw3322dNPiI0TdLAgFpg2H24nQSlnDEjSVVb6CXD/OppknmJ3i/yaCyA8vVfU
	 u/IoC1SHMD2fFL6gnuYn+ltvhT6e2PVlLJFUoLPE=
Received: from [2001:bf0:244:244::71] (helo=mail.avm.de)
	by mail.avm.de with ESMTP (eXpurgate 4.52.1)
	(envelope-from <n.schier@avm.de>)
	id 67ab00d1-714a-7f0000032729-7f00000187f2-1
	for <multiple-recipients>; Tue, 11 Feb 2025 08:48:33 +0100
Received: from mail-auth.avm.de (dovecot-mx-01.avm.de [IPv6:2001:bf0:244:244::71])
	by mail.avm.de (Postfix) with ESMTPS;
	Tue, 11 Feb 2025 08:48:33 +0100 (CET)
Received: from buildd.core.avm.de (buildd-sv-01.avm.de [172.16.0.225])
	by mail-auth.avm.de (Postfix) with ESMTPA id B249C80230;
	Tue, 11 Feb 2025 08:48:32 +0100 (CET)
Received: from l-nschier-z2.ads.avm.de (unknown [IPv6:fde4:4c1b:acd5:7792::1])
	by buildd.core.avm.de (Postfix) with ESMTP id A293E181681;
	Tue, 11 Feb 2025 08:48:32 +0100 (CET)
Received: from nicolas by l-nschier-z2.ads.avm.de with local (Exim 4.98)
	(envelope-from <n.schier@avm.de>)
	id 1thl0S-00000004hMe-1bBr;
	Tue, 11 Feb 2025 08:48:32 +0100
Date: Tue, 11 Feb 2025 08:48:32 +0100
From: Nicolas Schier <n.schier@avm.de>
To: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Cc: linux-kbuild@vger.kernel.org, linux-um@lists.infradead.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	=?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Richard Weinberger <richard@nod.at>,
	Nicolas Schier <nicolas@fjasle.eu>
Subject: Re: [PATCH v1] kbuild: Allow building of samples with UML
Message-ID: <20250211-holistic-gentle-moth-c90edb@l-nschier-z2>
References: <20241218115126.264342-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241218115126.264342-1-mic@digikod.net>
X-purgate-ID: 149429::1739260113-C7F3ACDC-FBB69494/0/0
X-purgate-type: clean
X-purgate-size: 1114
X-purgate-Ad: Categorized by eleven eXpurgate (R) https://www.eleven.de
X-purgate: This mail is considered clean (visit https://www.eleven.de for further information)
X-purgate: clean

On Wed, Dec 18, 2024 at 12:51:23PM +0100, Mickaël Salaün wrote:
> It's useful to build samples/* with UML and the only blocker is the
> artificial incompatibility with CONFIG_HEADERS_INSTALL.
> 
> Allow the headers_install target with ARCH=um, which then allow building
> samples (and tests using them) with UML too:
> 
>   printf 'CONFIG_SAMPLES=y\nCONFIG_HEADERS_INSTALL=y\nCONFIG_SAMPLE_LANDLOCK=y\n' >.config
>   make ARCH=um olddefconfig headers_install
>   make ARCH=um samples/landlock/
> 
> Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
> Cc: Johannes Berg <johannes@sipsolutions.net>
> Cc: Masahiro Yamada <masahiroy@kernel.org>
> Cc: Nathan Chancellor <nathan@kernel.org>
> Cc: Nicolas Schier <nicolas@fjasle.eu>
> Cc: Richard Weinberger <richard@nod.at>
> Fixes: 1b620d539ccc ("kbuild: disable header exports for UML in a straightforward way")
> Signed-off-by: Mickaël Salaün <mic@digikod.net>
> ---
>  Makefile          | 1 -
>  lib/Kconfig.debug | 1 -
>  2 files changed, 2 deletions(-)
> 

Thanks, looks good to me.

Reviewed-by: Nicolas Schier <n.schier@avm.de>

