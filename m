Return-Path: <linux-kselftest+bounces-34112-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8374AC9E0F
	for <lists+linux-kselftest@lfdr.de>; Sun,  1 Jun 2025 09:45:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36EB37AAB09
	for <lists+linux-kselftest@lfdr.de>; Sun,  1 Jun 2025 07:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D7E2188596;
	Sun,  1 Jun 2025 07:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="a2UQep+/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E0181A288;
	Sun,  1 Jun 2025 07:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748763936; cv=none; b=CgSsEWEKwr9YdKn6pLjzU4lKSsb78nbQgfSPoqEm+9Ei08cMUsEldduXQPFq4G/GePPyLXADDsCxWP723iuWpcsNl2SZj/KEShOKc2yOnKXoxklq+1HcVnktOsaixJ/lYP22bP+URpgvGIwiZi8H87mrjnsqJbu3lCducGIYukI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748763936; c=relaxed/simple;
	bh=FIf7snkOmowedQqN9kuaTh69x/rYM73sAbWL7crO7Uo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fau+RuLRDinH/jPO9EaRt0+TYwm/I7tVwr6TVCa012dfdU9KmNPHu9ni1UtAzJ+fWujviJHUUpEjg85CpMyi2xcmVyacVKZhDIbPEp039I0zTZLWcGag68WkZ8sBXtCyYY/piYSYHiO5WgiLCpIysyYC17keCsSLG0w6YPnwv48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=a2UQep+/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59A2BC4CEE7;
	Sun,  1 Jun 2025 07:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748763935;
	bh=FIf7snkOmowedQqN9kuaTh69x/rYM73sAbWL7crO7Uo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a2UQep+/GdItLkmdWJOJcn4gJuliMlcu8Cn9b/9C17JXsfa1J8IF/vu2khvYQ1euy
	 +4dZvcHZE8RWBr15fSgFRAsKbQsHoQSj4vn/50zwoHK1UsIocBCFsBHWyATe/BJT0Q
	 8x5x/81o0P16n4EukMe42ovCDEbV7ZXjq67JF1xw=
Date: Sun, 1 Jun 2025 09:45:33 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: David Matlack <dmatlack@google.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Shuah Khan <shuah@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
	Vinod Koul <vkoul@kernel.org>, Fenghua Yu <fenghua.yu@intel.com>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Adhemerval Zanella <adhemerval.zanella@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
	Wei Yang <richard.weiyang@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>, Takashi Iwai <tiwai@suse.de>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	WangYuli <wangyuli@uniontech.com>,
	Sean Christopherson <seanjc@google.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	Eric Auger <eric.auger@redhat.com>, Josh Hilke <jrhilke@google.com>,
	linux-kselftest@vger.kernel.org, kvm@vger.kernel.org,
	Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>,
	Vipin Sharma <vipinsh@google.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Parav Pandit <parav@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Dan Williams <dan.j.williams@intel.com>
Subject: Re: [RFC PATCH 08/33] vfio: selftests: Validate 2M/1G HugeTLB are
 mapped as 2M/1G in IOMMU
Message-ID: <2025060148-sandpit-snore-a49c@gregkh>
References: <20250523233018.1702151-1-dmatlack@google.com>
 <20250523233018.1702151-9-dmatlack@google.com>
 <CALzav=fJS69JeKa-t6ze8Sx0Nwp+y8zRMfFu0RUaCoCcZR3jYQ@mail.gmail.com>
 <aDtT7hrpxz7-3sh-@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aDtT7hrpxz7-3sh-@smile.fi.intel.com>

On Sat, May 31, 2025 at 10:09:34PM +0300, Andy Shevchenko wrote:
> On Fri, May 30, 2025 at 02:12:36PM -0700, David Matlack wrote:
> > On Fri, May 23, 2025 at 4:30 PM David Matlack <dmatlack@google.com> wrote:
> 
> ...
> 
> > > +       if (access("/sys/kernel/debug/iommu/intel", F_OK))
> > > +               return intel_iommu_mapping_get(bdf, iova, mapping);
> > > +
> > 
> > Oops, this should be !access(...).
> 
> Hmm... Generally speaking that code is a hack. Is there any guarantee that
> debugfs mount point is fixed to /sys/kernel/debug ?

No, userspace can mount it anywhere :)

But the kernel does create the mount point at /sys/kernel/debug/ by
default, so hopefully it does end up there if it is present in the
system, so you should be able to rely on it for testing.

thanks,

greg k-h

