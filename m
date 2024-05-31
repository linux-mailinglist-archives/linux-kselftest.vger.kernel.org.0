Return-Path: <linux-kselftest+bounces-10999-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D3EE8D6230
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 May 2024 14:51:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E66DF284048
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 May 2024 12:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF05B15884B;
	Fri, 31 May 2024 12:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="luLGxnmE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DD16210EC;
	Fri, 31 May 2024 12:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717159911; cv=none; b=DUmRi7sDMaIGFXQK/qb2dFUVvVlkvXXF8wLzvfgqsYetTsDZQQV0mytUJ+KwTgZX2gSjN0evji4AAy/bBi72HwOT8+qhMS05Mh0np8MAsBeObgdttxK2Xjv/AUScT49zD8TQRXeYFVO7VNfCzNb6Bb357gda+JptNS6QymlxuAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717159911; c=relaxed/simple;
	bh=mq2Zzqny2IVXTs3luQ/FAMhkfHVKM3ejXtFE0TZCml4=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=oKJKk+0xGHGn3vJ692yORFNyoFfwVM/85hXXKzmPVDhtbX4UeuihsRiB2N5UUCLJ0RNc1qiqWYql/8i2Adse1asTpPOPyR37BpWA+QiGkskNmO1Bq1vL0aNZoUMftPWjruA8ZN4V6rKZUASpPW8A1X/9FDRzzGMpvWf/bLTafks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=luLGxnmE; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717159910; x=1748695910;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=mq2Zzqny2IVXTs3luQ/FAMhkfHVKM3ejXtFE0TZCml4=;
  b=luLGxnmEAUdSPynLO7N1hp4ey3wblvcGEsWGmn/EJ1Nrh7bnvgF2lvKG
   eD9etu6B2hCAvjsdlBBW7zidJf5PMbVXGiDqWvF8A9hKvSnCNexLKKUNo
   MRGYS3pGFeI+X0sluXzXeXMRRuFCqEsp7d/hVdM6+xwdozBYydFC7fa/g
   +a280HH+/lRwa4KaDSlY5txi7E5zfaa38qyz2tZH+5A9ZGKSmTjkc1We4
   nPaDXIATyLdgwbErITfP48JpuMONmQILXIM+3GJ3VH1brfmOORxv2MKxj
   6tKnSBXsrtvL1ImfkGG/e4gMr7haM/s+iSSFiTNKL2bGaFb7Bv9Z6V3/C
   A==;
X-CSE-ConnectionGUID: dEK4+ey5RMCWG35y1KdmUw==
X-CSE-MsgGUID: DGKesi6tRdq05FQxoJ/zcQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11088"; a="16647416"
X-IronPort-AV: E=Sophos;i="6.08,204,1712646000"; 
   d="scan'208";a="16647416"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2024 05:51:49 -0700
X-CSE-ConnectionGUID: ME7YDNouRmuXSHs5bc096w==
X-CSE-MsgGUID: 1RdvsJU8T/yDNeC0TVKyXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,204,1712646000"; 
   d="scan'208";a="41077266"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.152])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2024 05:51:48 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 31 May 2024 15:51:44 +0300 (EEST)
To: Reinette Chatre <reinette.chatre@intel.com>
cc: linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>, 
    Babu Moger <babu.moger@amd.com>, 
    =?ISO-8859-15?Q?Maciej_Wiecz=F3r-Retman?= <maciej.wieczor-retman@intel.com>, 
    LKML <linux-kernel@vger.kernel.org>, Fenghua Yu <fenghua.yu@intel.com>, 
    Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH v4 02/16] selftests/resctrl: Calculate resctrl FS derived
 mem bw over sleep(1) only
In-Reply-To: <3b0baf88-c9cb-49c0-a6e1-acb581403f52@intel.com>
Message-ID: <23188ca6-2de8-3998-c73f-41939a964754@linux.intel.com>
References: <20240520123020.18938-1-ilpo.jarvinen@linux.intel.com> <20240520123020.18938-3-ilpo.jarvinen@linux.intel.com> <04d0a5d6-82fa-4cc7-bd80-ee5cbd35f0c3@intel.com> <ea0c86b9-ae77-c2d9-b52b-239ae42603e8@linux.intel.com> <d8063ee7-1744-45a2-b6b9-506e68106baf@intel.com>
 <b029db88-2e09-0b4a-f46a-84b5e535f178@linux.intel.com> <904aa442-9fc5-c6dd-f367-07b197085f7b@linux.intel.com> <700e3df4-4e10-4870-a1df-49d4616cbc45@intel.com> <0f294d43-e704-d1de-06ee-97bb81ebb9cb@linux.intel.com>
 <3b0baf88-c9cb-49c0-a6e1-acb581403f52@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-125186921-1717136622=:1027"
Content-ID: <af795ab7-1f7b-2778-334f-1fa913818b38@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-125186921-1717136622=:1027
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <5c23432d-da0d-c4b1-66c5-528957fb8e06@linux.intel.com>

On Thu, 30 May 2024, Reinette Chatre wrote:

> Hi Ilpo,
>=20
> On 5/30/24 4:11 AM, Ilpo J=E4rvinen wrote:
> > On Tue, 28 May 2024, Reinette Chatre wrote:
> > > On 5/28/24 3:19 AM, Ilpo J=E4rvinen wrote:
> > > > On Fri, 24 May 2024, Ilpo J=E4rvinen wrote:
> > > > > On Fri, 24 May 2024, Reinette Chatre wrote:
> > > > > > On 5/24/24 12:57 AM, Ilpo J=E4rvinen wrote:
> > > > > > > On Thu, 23 May 2024, Reinette Chatre wrote:
>=20
> ...
>=20
> > > > > > It is not necessary to open and close the file every time a val=
ue
> > > > > > needs
> > > > > > to be read from it.
> > > >=20
> > > > I'm bit unsure where to go with this. While I could change the code=
 to
> > > > match what you described, I realized with the two files approach th=
ere's
> > > > no need to do even review/lseek() call during the measurement. It m=
ight
> > > > not be very significant compared with the open that was there initi=
ally
> > > > but it's still extra.
> > >=20
> > > We are discussing the resctrl selftests that will accompany the resct=
rl
> > > filesystem in the kernel. When in doubt on how to interact with resct=
rl
> > > users
> > > use the selftests as reference. Needing to open and close a resctrl f=
ile
> > > every time a value needs to be read from it is not the correct guidan=
ce.
> >=20
> > That's actually a different goal from the earlier, but I've no problem
> > adjusting to it.
> >=20
> > Initially, this open/close() refactoring was made because of another go=
al
> > which was to avoid doing extra syscalls during the test.
> >=20
>=20
> It is not clear what you hint at here. Reading twice from an open file
> should not be a huge adjustment so it is not clear to me how this results
> in a big change to this work. As I understand this does match with origin=
al
> goal
> of reducing syscalls since the file need not be opened and closed twice.

What I tried to say is that with a single file, the test uses rewind()=20
that also needs to do a syscall within the test period, whereas if the=20
file is opened twice in advance rewind() won't be needed.

But I've converted it into single file for the sake of serving as an=20
example for other resctrl users.

--=20
 i.
--8323328-125186921-1717136622=:1027--

