Return-Path: <linux-kselftest+bounces-3692-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F888840A1D
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Jan 2024 16:33:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 521C81C24C7C
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Jan 2024 15:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6D95153BF4;
	Mon, 29 Jan 2024 15:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="bklY6RON"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B6660EFF;
	Mon, 29 Jan 2024 15:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706542427; cv=none; b=TpZxbZF2ZryyEnriuLF/wXfrK+CNBoBB4wijSQzECidckkPT35a8EOvOq1PQNeiEXw9/un5NtIMsyhN3XXF0/zY/J2TnGT/zyixrYD6PKoJfmGCNjp4LvFAm/8VyKPZOZa/xPzEP/lgd2Vzck7UMDHkOFHDlm8jFsN0YWpC2RHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706542427; c=relaxed/simple;
	bh=+R7/JcKIxC377oWJCLZuDlPtntWxUpOP25ZAD15bqkI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eF07Wblbo50i+KTjXiuXLAhsYGjPvrvNTesYYdaMXLyX9sBqeSidgYdXTIy3p2orvIpUyVosWx5+JhmFcXtej+yNmXuHByxGD5aTc8rdnQNNuFjfgtKdzwJ7t3FaTj4W+alDZqbHh/ZzI9vLU+zPF5Q9tfuSfoHqpHJGwUyRpAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=bklY6RON; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 3835740E00C5;
	Mon, 29 Jan 2024 15:33:38 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id H17CwIdTl8uk; Mon, 29 Jan 2024 15:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1706542416; bh=ZE+UbbDAySZDxLHmwMn6H2oCiWnq1zxqmdc69CKzfFs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bklY6RONiMKwT9KlqopNnAk3+Hyv90UJqv9pTYGEuyK1qjY/UpA0LUgzgtup7Dkoo
	 z/qthwHCjoUBgJfKc7Pmmn0EnF+L7BuIJCqZqx6Mi8FghWLV7Gzt2RBRuaUS5k2gxd
	 pJhOCxWukJwx1Zfp+CO8jQxmJM2U41EYmkoCRQ4GDRz8fRfD9vxQiMCM8FFnQF4RJ7
	 PPdFh/GSOgOASToW0Zyy6VzK5WtlU4ITe7fiCy9lQWTV6/CiSmgJS8KdSSfaMBs7Rp
	 A2PE8UJnMMU8QJD8iCVjWl0M1AMDzz2OOsIyJns4vT2AWiufey30iEMDor6WqVb1uY
	 C4GxBv8v8bHX3B98FiqUgLvsPIRItc22NcAtmbqj+ngCuuVQKSYySBEWplLmAbUMgM
	 g5LUPgCPeiAB49HY3hhtKQk+shLn4HP36Jzz9AQ/dKh/HAV6qfMjG5xKNXdcoi5l+O
	 2veyi/A/ehuL3e3+CruO8baAFoSaXwn1r+08eO+KKwEcoa1NtXDr4QkXDD59oASh3b
	 O3MzmBKcF7T4HdyLLypIiwgHtad+qAMJUaOYcjHzscaIEp6m+oEc+lWIQCi/92JDxe
	 lOv85El7Xn1ZbZcn905L6iguP5mz+jrfGSLPrJSKleqeXU0tMXSAwaxDquQkFjE04i
	 +hJFehmK5nndFX0ELb9/8u/o=
Received: from zn.tnic (pd953033e.dip0.t-ipconnect.de [217.83.3.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E688340E0177;
	Mon, 29 Jan 2024 15:33:16 +0000 (UTC)
Date: Mon, 29 Jan 2024 16:33:11 +0100
From: Borislav Petkov <bp@alien8.de>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Meng Li <li.meng@amd.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Huang Rui <ray.huang@amd.com>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, x86@kernel.org,
	linux-acpi@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>,
	linux-kselftest@vger.kernel.org,
	Nathan Fontenot <nathan.fontenot@amd.com>,
	Deepak Sharma <deepak.sharma@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Shimmer Huang <shimmer.huang@amd.com>,
	Perry Yuan <Perry.Yuan@amd.com>, Xiaojian Du <Xiaojian.Du@amd.com>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Oleksandr Natalenko <oleksandr@natalenko.name>
Subject: Re: [PATCH V14 0/7] amd-pstate preferred core
Message-ID: <20240129153311.GDZbfFN0Twxkw4FnKX@fat_crate.local>
References: <20240119090502.3869695-1-li.meng@amd.com>
 <CAJZ5v0gzKdjZJBypEw1+czGN-SHbx0s0-h=Lq96+MDVAO11PYQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gzKdjZJBypEw1+czGN-SHbx0s0-h=Lq96+MDVAO11PYQ@mail.gmail.com>

On Mon, Jan 29, 2024 at 04:18:02PM +0100, Rafael J. Wysocki wrote:
> You've had comments on the previous version of this.
> 
> Have they all been addressed?

Yeah, see patch 1.

Thx.


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

