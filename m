Return-Path: <linux-kselftest+bounces-2841-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 577FB82AAA9
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jan 2024 10:19:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 722C31C25945
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jan 2024 09:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D865D10940;
	Thu, 11 Jan 2024 09:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="W8Aih2z/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE8A1078D;
	Thu, 11 Jan 2024 09:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id B174040E01B2;
	Thu, 11 Jan 2024 09:19:31 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 75rQRR9rxJhI; Thu, 11 Jan 2024 09:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1704964768; bh=TukuYSY8K4PgC2+/1f/CzkqHRiMiVTc5HcHBppG/p8M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W8Aih2z/501plmUS7atfC64dlRQjOShAvBVndfMrWqPeBQKwBnCEq53iFOffzOCj6
	 ASz2LhAD1wuXwfVGG5ogOrzKmhgKo60wgF4/1r2KjBhQZeh/l6pFL6nQNw76kTt9O/
	 dm+pN55ueeegyOIFo0LjiJaHFx5LBggJ55msozJblKm+F0qVc57Jezs77wUBITm38r
	 tWH64cDU+oqGrIU2fNmHbzR9so/IH4mXRbmqmkOWauvEvwnw9Q6xzLjPCChjcXt2+i
	 muF/rWyUlQOmNC4FZ0OvNHj7OQ9dynCkBL5SSjDeuMzCejsfNzaoIdmknN+Vp3GOTL
	 i0BfxTbnmpU595EH1Ao4ICDVn5KOM2qawY7/YoOwKRCixytB5wu2MhhQmaAymfziKz
	 bTCqwdLPHj5p7OFF9ZfFDuQxpACgfqF6zyHr7dHCpjccN62bzp3mDnM/AiI2vRtXje
	 oLRbbwsaDoH2f9dOufnVLzA3H2FG6bETwWlgYs1iR8AINPYn7Ej40RFp3aC2Fjm1Ud
	 KGHr1WOJ/T/x5JVqZg2h2REIidws6w4VUqV/OI1QKmssRg2BDJS8pkZ/9G4FncRv1Y
	 rRthqLpawTvqyn1cnoSncVft689dDt5ZU+bAeZxQZy6NO8vdr0lBTAI5QE41F9xrmq
	 IOQ34SEkJI/cOBXUxv2O0scU=
Received: from zn.tnic (pd9530f8c.dip0.t-ipconnect.de [217.83.15.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3A5AE40E0196;
	Thu, 11 Jan 2024 09:19:10 +0000 (UTC)
Date: Thu, 11 Jan 2024 10:19:04 +0100
From: Borislav Petkov <bp@alien8.de>
To: "Meng, Li (Jassmine)" <Li.Meng@amd.com>
Cc: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	"Huang, Ray" <Ray.Huang@amd.com>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"Fontenot, Nathan" <Nathan.Fontenot@amd.com>,
	"Sharma, Deepak" <Deepak.Sharma@amd.com>,
	"Deucher, Alexander" <Alexander.Deucher@amd.com>,
	"Limonciello, Mario" <Mario.Limonciello@amd.com>,
	"Huang, Shimmer" <Shimmer.Huang@amd.com>,
	"Yuan, Perry" <Perry.Yuan@amd.com>,
	"Du, Xiaojian" <Xiaojian.Du@amd.com>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Oleksandr Natalenko <oleksandr@natalenko.name>
Subject: Re: [PATCH V12 1/7] x86: Drop CPU_SUP_INTEL from SCHED_MC_PRIO for
 the expansion.
Message-ID: <20240111091904.GAZZ-yiBNC8O6KN99S@fat_crate.local>
References: <20231205063537.872834-1-li.meng@amd.com>
 <20231205063537.872834-2-li.meng@amd.com>
 <20240109104504.GAZZ0jsFrrncZ8Vx8y@fat_crate.local>
 <DM4PR12MB63515E818A5B4D5E512F5234F7692@DM4PR12MB6351.namprd12.prod.outlook.com>
 <20240110100402.GAZZ5rklxQUZk_KFV4@fat_crate.local>
 <DM4PR12MB6351BAC3EDC9BD184D5D1FAFF7682@DM4PR12MB6351.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <DM4PR12MB6351BAC3EDC9BD184D5D1FAFF7682@DM4PR12MB6351.namprd12.prod.outlook.com>

On Thu, Jan 11, 2024 at 08:10:48AM +0000, Meng, Li (Jassmine) wrote:
> I will modify it soon.

No, don't modify it, don't do anything. Please read the whole thread
again.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

