Return-Path: <linux-kselftest+bounces-22310-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65AB59D2F4D
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Nov 2024 21:10:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B3101F2307A
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Nov 2024 20:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 327C11D27A0;
	Tue, 19 Nov 2024 20:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uuy7Jd+v"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6AAE1CCEF7;
	Tue, 19 Nov 2024 20:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732047048; cv=none; b=V4sH6C4KvGl/fgkdQEqgygcXVm2K6Rxp8scVdmdFuUmM/NIzFjjy2pnMZkpPbwvZPYEMi+HVOXmOXx1NkeCzRjzuUh+Z1pAVaQKKeDpeu7Fx4bQ2oPHnL1dqA34cnu6DJGMs6QzhfVdhnqa7HPIkQxEp31RqMPQ5wb0uakdViqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732047048; c=relaxed/simple;
	bh=80p4u8vFU8cU6neBJorNSyBCRfiu3wL8yP9UDvMnD7o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jmRwW36gFEyOsiJgLCrTbsXNXEVHZ0ZrCTKk4IXswSyuuXenXXGEX8mfZwFq54I/58dTG5AmiJH5AFXq5Cl6j7wpUkTR8m65W9w+3kJQGkwa/pdYi+oBENMeA0Qaf3+aLVSTybxoLSL0Uq/qvekU+OPQ9szAa5QSNnWFcfMM/84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uuy7Jd+v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A46B3C4CECF;
	Tue, 19 Nov 2024 20:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732047047;
	bh=80p4u8vFU8cU6neBJorNSyBCRfiu3wL8yP9UDvMnD7o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uuy7Jd+vQldDusMOoTA5ujAWOpxoWC3hIgk+EQooQ3HcsDFe3FlK/vlHLCtuR1gHG
	 RxMNB3Zs4G29GqTaSw1Eu00nUctmUvxyenM60QK6Wf2EYS3TtBHST03xkpvsgVeErI
	 1Z9RW3pz9X+kne3+h/58p2y3GvUBCwci1GuoSRqqv/l7rzYZuuWU8KXiTSq2fx2vVL
	 SVPTo0qNvFUEm9Yw0mIKFNYeKmtrySo6LIOzq+yQGUTF3J1YsmF86wmovCYL6kSWSO
	 Q+eA626XtJrhx0WNtyPhf2+UaZugOLjORq8Rs7qXh27dilBbgGe16dGRh9zUEnpYGW
	 /dZot0wypxOeA==
Date: Tue, 19 Nov 2024 12:10:45 -0800
From: Luis Chamberlain <mcgrof@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Roberto Sassu <roberto.sassu@huaweicloud.com>, zohar@linux.ibm.com,
	dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com, corbet@lwn.net,
	petr.pavlu@suse.com, samitolvanen@google.com, da.gomez@samsung.com,
	akpm@linux-foundation.org, paul@paul-moore.com, jmorris@namei.org,
	serge@hallyn.com, shuah@kernel.org, mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com, linux-integrity@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org, linux-modules@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kselftest@vger.kernel.org, wufan@linux.microsoft.com,
	pbrobinson@gmail.com, zbyszek@in.waw.pl, mjg59@srcf.ucam.org,
	pmatilai@redhat.com, jannh@google.com, dhowells@redhat.com,
	jikos@kernel.org, mkoutny@suse.com, ppavlu@suse.com,
	petr.vorel@gmail.com, mzerqung@0pointer.de, kgold@linux.ibm.com,
	Roberto Sassu <roberto.sassu@huawei.com>
Subject: Re: [PATCH v6 02/15] module: Introduce ksys_finit_module()
Message-ID: <ZzzwxdHbG9HynADT@bombadil.infradead.org>
References: <20241119104922.2772571-1-roberto.sassu@huaweicloud.com>
 <20241119104922.2772571-3-roberto.sassu@huaweicloud.com>
 <20241119121402.GA28228@lst.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241119121402.GA28228@lst.de>

On Tue, Nov 19, 2024 at 01:14:02PM +0100, Christoph Hellwig wrote:
> On Tue, Nov 19, 2024 at 11:49:09AM +0100, Roberto Sassu wrote:
> > From: Roberto Sassu <roberto.sassu@huawei.com>
> > 
> > Introduce ksys_finit_module() to let kernel components request a kernel
> > module without requiring running modprobe.
> 
> That does sound more than sketchy, even more so because the commit log
> completely fails to explain why you'd need to do that.

I also don't think the commit log is correct, I don't see how the
code is preventing calling modprobe, the indepotent check is intended
to prevent duplicate module init calls which may allocate extra vmalloc
space only to release it. You can test to see if your patch has any
improvments by enabling MODULE_STATS and MODULE_DEBUG_AUTOLOAD_DUPS
and check before / after results of /sys/kernel/debug/modules/stats  ,
right now this patch and commit log is not telling me anything useful.

  Luis



