Return-Path: <linux-kselftest+bounces-2798-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68A798296DF
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Jan 2024 11:04:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E196828A0C0
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Jan 2024 10:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1F193F8E3;
	Wed, 10 Jan 2024 10:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="SPReVNX5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5D3BE5E;
	Wed, 10 Jan 2024 10:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id CBA8240E01B2;
	Wed, 10 Jan 2024 10:04:23 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 4K_7Q4QU78V6; Wed, 10 Jan 2024 10:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1704881062; bh=oJLkoiziOduPtb/cNDhpBdqQ7Qw3Bv/OYk1DSPyjEys=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SPReVNX5mO4rjH8gAJR8lkxFlU5acWreAoHXYqShJBeGOIsQGLDhrQ8Ds4pr9eKsr
	 lOgwXBr/Fn54So/pLG/3T6BmVBxgFyfb5Xgj+nS3WDzIEYJ79TUjVbwenTZKwqL30e
	 /VQjFIg+gqRZ2R9vFVDkGBQprUU8J4EJxfkn5bBGLEDNipmQ+mgOm0GtMZKdLnHTzR
	 0Vt67twZqO3HfmHHxbSO1HYFLM09gMHIA0kjS9ZNE19aSYYzJVBckVN29ZKbOfvcAD
	 HbreznrZi+bJB2bhiolrNiWnDWNu725zmkGx3FaoUGqgntV8qIVtTe3AHbyCgMzhMs
	 BEiWhR2Va1XvWXaUmib82+/UB/mbh3kL2KIANarumEWrEw6904J6wx6T8X/NuKlyYG
	 /EMoNGLPk5uifTCyYdvvd7HoxVS+S6ppnSKahH9THaKf0loHG2tBALnRYRQNMpzKzT
	 yEMrh4FM/wjTmUOvf6iu+1gCbyCsu42eWzVwJnzaTCUV5qwTt2YZ3Qm5t7b0MUXTHZ
	 mE58e/yKnvboqMgpItDvOAYZ7EJaqbX6PcFJ716Iydztde4PPDPWek2K8Irsdoqdko
	 HLJNXUpOm4ppsGHiEIIgweaAhXv1TFlr5goK0GHbMD2hBC8f1dd81HSZ+RVZdNQDeh
	 EhMxTgipx0zkfBJ7H7D+mPUE=
Received: from zn.tnic (pd9530f8c.dip0.t-ipconnect.de [217.83.15.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id BE5E940E01A9;
	Wed, 10 Jan 2024 10:04:03 +0000 (UTC)
Date: Wed, 10 Jan 2024 11:04:02 +0100
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
Message-ID: <20240110100402.GAZZ5rklxQUZk_KFV4@fat_crate.local>
References: <20231205063537.872834-1-li.meng@amd.com>
 <20231205063537.872834-2-li.meng@amd.com>
 <20240109104504.GAZZ0jsFrrncZ8Vx8y@fat_crate.local>
 <DM4PR12MB63515E818A5B4D5E512F5234F7692@DM4PR12MB6351.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <DM4PR12MB63515E818A5B4D5E512F5234F7692@DM4PR12MB6351.namprd12.prod.outlook.com>

On Wed, Jan 10, 2024 at 06:59:25AM +0000, Meng, Li (Jassmine) wrote:
> The reason why I added the selects is just to distinguish different
> pstate drivers.  These two drivers cannot be supported simultaneously
> in the same project.

No, that's not what I meant. Read here:

"- reverse dependencies: "select" <symbol> ["if" <expr>]

  While normal dependencies reduce the upper limit of a symbol (see
  below), reverse dependencies can be used to force a lower limit of
  another symbol. The value of the current menu symbol is used as the
  minimal value <symbol> can be set to. If <symbol> is selected multiple
  times, the limit is set to the largest selection.
  Reverse dependencies can only be used with boolean or tristate
  symbols.

  Note:
        select should be used with care. select will force
        a symbol to a value without visiting the dependencies.
        By abusing select you are able to select a symbol FOO even
        if FOO depends on BAR that is not set.
        In general use select only for non-visible symbols
        (no prompts anywhere) and for symbols with no dependencies.
        That will limit the usefulness but on the other hand avoid
        the illegal configurations all over."

From Documentation/kbuild/kconfig-language.rst

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

