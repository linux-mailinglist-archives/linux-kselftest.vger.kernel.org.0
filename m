Return-Path: <linux-kselftest+bounces-12500-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B211913530
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Jun 2024 18:49:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 001451F224D1
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Jun 2024 16:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53D6C8C09;
	Sat, 22 Jun 2024 16:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VqeI9zwP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB9D7BE4A;
	Sat, 22 Jun 2024 16:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719074956; cv=none; b=pt0hevwzFfJMKYmX7K8GLDQR9DkYZtPfw7vyCALRYa4QpIdYvVXlHfs4BlleTXyrnjxVneOIsSuOKnmT4B8OYJA7yjfFAk7/9GJryQmKtv2CkCmN7OQ2x7OX8JSJql0+9ru0Ya0B3Pthnfr+tLsebial8AlZLu7zrzgluKrCWME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719074956; c=relaxed/simple;
	bh=JKS4BTNqhIWJKvQ52q0oKKZoT24gjwg0VxQiwj++Z3w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ICNMg/dvRlXoV2eWA1kJAsR+PpnBEBTF+5hsUJOLjkPCkw4g9M/KWZEYi8PcKFgGNeXxlOD5wANcUd1lZQ8/zF04bp4jZ79X9FRXj9+p6GhCBQuetIUm3ICfHn2coJc/k5YKawqYbOTKnJSqkwyo3D78Cvz7m6l6JZIvWPY0OuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VqeI9zwP; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719074954; x=1750610954;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=JKS4BTNqhIWJKvQ52q0oKKZoT24gjwg0VxQiwj++Z3w=;
  b=VqeI9zwPcHciTF4rFAaNV8ueuySjCuvObETlYwLu3znAXSn8gBm9SDU0
   QDmxHtC0vEUDXp7o869RgRX1NYd8oocwfraFouWpNh+jjlBrxRrPdiAlJ
   S01AW7Y3HaZYJdmO8hDzOLZXpFRmCgFGrzGzI9H9UcMuyS6jsNrlJUVcF
   3CBf5tTBNjt22vmytgq6+9YmK/zwZIe58km5NX+kkfQWZ38tx04P/WoyZ
   4bdjfz1C6OdfIl6GGOQrjnhVvl9iTxTNZF2BrDqCHV715NX+ZyxGP0quC
   6zNj218BBKzru/t4qbN2M2Zt1GTSOh6GwIgNv+H2nT8czZegfwX5rBwxY
   A==;
X-CSE-ConnectionGUID: RDpU2FoNT1qYj75YqyQIsQ==
X-CSE-MsgGUID: sJO/MEAPRBydenXeJ6qxTQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11111"; a="33554653"
X-IronPort-AV: E=Sophos;i="6.08,258,1712646000"; 
   d="scan'208";a="33554653"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2024 09:49:13 -0700
X-CSE-ConnectionGUID: JDXf4qZUQ/+Cfdar1LhvNg==
X-CSE-MsgGUID: iR1+Le1xTDCcBPEX8JE/gA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,258,1712646000"; 
   d="scan'208";a="43552168"
Received: from tassilo.jf.intel.com (HELO tassilo) ([10.54.38.190])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2024 09:49:13 -0700
Date: Sat, 22 Jun 2024 09:49:12 -0700
From: Andi Kleen <ak@linux.intel.com>
To: Jiaqi Yan <jiaqiyan@google.com>
Cc: nao.horiguchi@gmail.com, linmiaohe@huawei.com, jane.chu@oracle.com,
	osalvador@suse.de, muchun.song@linux.dev, akpm@linux-foundation.org,
	shuah@kernel.org, corbet@lwn.net, rientjes@google.com,
	duenwen@google.com, fvdl@google.com, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v4 0/4] Userspace controls soft-offline pages
Message-ID: <ZncAiH-SWmGQY5so@tassilo>
References: <20240620184856.600717-1-jiaqiyan@google.com>
 <87msnfusyw.fsf@linux.intel.com>
 <CACw3F51QadqESg2a8Lb_A+PCH7TH0W8BqwNKCyOX4nyeeP1wAw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACw3F51QadqESg2a8Lb_A+PCH7TH0W8BqwNKCyOX4nyeeP1wAw@mail.gmail.com>

On Fri, Jun 21, 2024 at 04:53:41PM -0700, Jiaqi Yan wrote:
> Thanks for your comment, Andi.
> 
> On Thu, Jun 20, 2024 at 3:53 PM Andi Kleen <ak@linux.intel.com> wrote:
> >
> > Jiaqi Yan <jiaqiyan@google.com> writes:
> >
> > > Correctable memory errors are very common on servers with large
> > > amount of memory, and are corrected by ECC, but with two
> > > pain points to users:
> > > 1. Correction usually happens on the fly and adds latency overhead
> > > 2. Not-fully-proved theory states excessive correctable memory
> > >    errors can develop into uncorrectable memory error.
> >
> > This patchkit is amusing (or maybe sad) because it basically tries to
> > reconstruct the original soft offline design using a user space daemon
> > instead of doing policy badly in the kernel.
> 
> Some clarifications. I don't intend to reconstruct. I think this
> patchset can also be treated as "patch some missing places so that
> kernel doesn't soft offline behind the back of userspace daemon".
> I agree with you (IIUC) that the policy for corrected memory errors
> should exist in userspace. But the situation is that some behaviors in
> the kernel don't respect that (they either have a reason to not
> respect, or just forget to respect). enable_soft_offline is basically
> the big button in userspace to block these kernel violators.

It would be better to disable them earlier before they waste work
tracking things unnecessarily.  But yes it's a step in the right direction.

> 
> >
> > You can still have it by enabling CONFIG_X86_MCELOG_LEGACY and
> > use http://www.mcelog.org or an equivalent daemon of your chosing
> > that listens to /dev/mcelog.
> 
> If I didn't miss anything important in
> https://github.com/andikleen/mcelog and
> arch/x86/kernel/cpu/mce/dev-mcelog.c, I don't think /dev/mcelog works
> on ARM platforms where CPER is used to convey hw errors from platform
> to OS.

Yes or not on AMD even. 

-Andi

