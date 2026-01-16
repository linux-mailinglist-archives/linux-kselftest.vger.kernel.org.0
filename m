Return-Path: <linux-kselftest+bounces-49171-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EC0CD334D7
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jan 2026 16:48:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CD6CA3023D46
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jan 2026 15:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F298833A9F1;
	Fri, 16 Jan 2026 15:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="CHQexJO2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF41922D781;
	Fri, 16 Jan 2026 15:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768578274; cv=none; b=sJ1xJyzaIdJGE7idyS8Q8q7RB9JiGad9LOSgqOUMLoA4vSaoj59m1D1qcDmbSxi+HXPueswI79G2arqGZHuVTeWqgSQqL4mn76afVRS/LC0b11nNuy+nIiXVTDnTd9JcuYiwgxLddj1M4AFX5Y1CeF7YnEoxc+FvzQB4WyrFOzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768578274; c=relaxed/simple;
	bh=Ywkk0ckwF86jetpRVGopodoAwE4G7Q3iX6e+4FisqyY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iY9ol+jqxzR7brGwzVLtsyOCU2rW1lNg81VBT/gYJcA9gasVxZD+D2xcxvdwsZF9ZdtfjSvPl49Onqd4S/iJsAQD97uGzZNwD+iyeZpNf8eZevFFmOmg9KH/0pQA5RhKQzuDB+mLwOjnYJGJuYQNio1NNZJvx/XcmFK1pnw0i6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=CHQexJO2; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=HRx9lWK+S+WOBI8oXXWCj90P7mXf+6WG0+uvtWiJJF4=; t=1768578272;
	x=1769183072; b=CHQexJO2lip/AyAlZ/EZjx7ClJMY+6yVOnbYkzx3lVPdrqpuYtjaLek7eCIjj
	PRf7sy7yXUVEMV6rkViXS1yC987WLm9XjaXaHunMnQ1bWonIKc8ySx9BJgM4FxSAohcdRac0gfCKR
	jvvgjFhpivAn2XcLE+8hJbDKe2kIi/qaxLpEIW5AjLWF761G1Q1zuAZbCMGAWdog6RwwkxzPjJlrF
	yFm1QIBUKDOeRdwYW/xpSULZligkSkIBVdeRay8ZJSfJByOlssEdo/vSgzdou92z5gH+W/NbZOjnS
	HBgjPgW2MAo5jcmYD3vPDdc4TAtDyZQsRTx6x/7uSeb+bRpOvA==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.99)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1vglzr-00000002otT-0phK; Fri, 16 Jan 2026 16:44:23 +0100
Received: from p5dc55f29.dip0.t-ipconnect.de ([93.197.95.41] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.99)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1vglzq-00000000YIc-3w6z; Fri, 16 Jan 2026 16:44:23 +0100
Message-ID: <c3f713a89dd406d094eae99ef95c108e779780c3.camel@physik.fu-berlin.de>
Subject: Re: [PATCH 0/3] sparc: Add architecture support for clone3
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Ludwig Rydberg <ludwig.rydberg@gaisler.com>, davem@davemloft.net, 
	andreas@gaisler.com, brauner@kernel.org, shuah@kernel.org
Cc: sparclinux@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, arnd@arndb.de, geert@linux-m68k.org, 
	schuster.simon@siemens-energy.com
Date: Fri, 16 Jan 2026 16:44:21 +0100
In-Reply-To: <20260116153051.21678-1-ludwig.rydberg@gaisler.com>
References: <20260116153051.21678-1-ludwig.rydberg@gaisler.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hi Ludwig,

On Fri, 2026-01-16 at 16:30 +0100, Ludwig Rydberg wrote:
> This series adds support for the clone3 system call to the SPARC{32|64}
> architectures and also adds a related patch for clone/fork/vfork that fix=
 an
> issue previously reported[1] that could result in -EFAULT for no good rea=
son.
> Without this patch, the clone3 system call would need the same mitigation=
 as
> introduced in glibc[2] for the clone system call.

Woohoo, thanks a lot for working on this! I'll build a test kernel right aw=
ay!

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

