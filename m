Return-Path: <linux-kselftest+bounces-16169-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 31F6995D40C
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Aug 2024 19:08:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA86F1F21A0E
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Aug 2024 17:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8EB718DF7E;
	Fri, 23 Aug 2024 17:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fMDDMyCO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C84C18C929;
	Fri, 23 Aug 2024 17:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724432924; cv=none; b=CoyJrwbRM0CadxaxQSgz7BngcKMzEKDq6c/dOXjouWCaLXzRTnh0oHtFSlJXLS42Ma9qxVRZ/n9UgzAXOOcV7Dkc3VqaYjraTfTvRBfc6XaG2t6I2PPu0wdiILItt6SXqv3m+k2LG0VXE2S8rUXCNoXYEy3us6DOqMA6cgxhx9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724432924; c=relaxed/simple;
	bh=RihPOGh9p93UyuuiwT2FCbCPYyy1oUyaWOUKpt8j+K4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QmpZbZVZxP9axKZ3AwwdzA95w030Gg+xREFO+R1ndD+MyfzYfcmw5ogLCu829E7YcojJ7BUrhWN33yPjf0pxY2M/1MMNOosrbnKFisDnldgCaPQzohUbBcVuaTOOwXtCvYy/i69xCRiu+rNq/0YD7F1HNnzM40pbU3LiUJgPxqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fMDDMyCO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D713C32786;
	Fri, 23 Aug 2024 17:08:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724432924;
	bh=RihPOGh9p93UyuuiwT2FCbCPYyy1oUyaWOUKpt8j+K4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fMDDMyCOPVaR0lNY9h3NbsHg2Bdt69cwbY79/e6UXmXBU5kM9OfPR8wvBL7llF20P
	 4DAQH9IlKKaP662nLGdhQeBT15sTV8EuWxAkbewdCzRnX7moXjhl60oy28w6PIN1up
	 M7u16xXP7PxQzHcK6CmgYx/mbU0XxD2Rr9ABpZeQk193rmnHV78uERlqK0Pf1QkoFl
	 9rgDnGWcKdC7M8DMgdfRQxN/+zEZ6xOhtnKDPlPHghDbwwXH6FqIsjlhqeTEBYFNKC
	 WIyQSGTSRuHjVeYzUziQ0SMR09W61Qn6ZfAQfwsVYOzqdgMYpfHJLnU3hc/S0GKZCX
	 AgsBhEuIYFm/A==
Date: Fri, 23 Aug 2024 18:08:36 +0100
From: Will Deacon <will@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Joey Gouly <joey.gouly@arm.com>, linux-arm-kernel@lists.infradead.org,
	nd@arm.com, akpm@linux-foundation.org, aneesh.kumar@kernel.org,
	aneesh.kumar@linux.ibm.com, anshuman.khandual@arm.com, bp@alien8.de,
	broonie@kernel.org, christophe.leroy@csgroup.eu,
	dave.hansen@linux.intel.com, hpa@zytor.com,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org, maz@kernel.org, mingo@redhat.com,
	mpe@ellerman.id.au, naveen.n.rao@linux.ibm.com, npiggin@gmail.com,
	oliver.upton@linux.dev, shuah@kernel.org, skhan@linuxfoundation.org,
	szabolcs.nagy@arm.com, tglx@linutronix.de, x86@kernel.org,
	kvmarm@lists.linux.dev, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v5 06/30] arm64: context switch POR_EL0 register
Message-ID: <20240823170835.GA1181@willie-the-truck>
References: <20240822151113.1479789-1-joey.gouly@arm.com>
 <20240822151113.1479789-7-joey.gouly@arm.com>
 <20240823144531.GH32156@willie-the-truck>
 <Zsi7ovLOfuFdfuuz@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zsi7ovLOfuFdfuuz@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Fri, Aug 23, 2024 at 05:41:06PM +0100, Catalin Marinas wrote:
> On Fri, Aug 23, 2024 at 03:45:32PM +0100, Will Deacon wrote:
> > On Thu, Aug 22, 2024 at 04:10:49PM +0100, Joey Gouly wrote:
> > > +static void permission_overlay_switch(struct task_struct *next)
> > > +{
> > > +	if (!system_supports_poe())
> > > +		return;
> > > +
> > > +	current->thread.por_el0 = read_sysreg_s(SYS_POR_EL0);
> > > +	if (current->thread.por_el0 != next->thread.por_el0) {
> > > +		write_sysreg_s(next->thread.por_el0, SYS_POR_EL0);
> > > +		/* ISB required for kernel uaccess routines when chaning POR_EL0 */
> > 
> > nit: typo "chaning".
> > 
> > But more substantially, is this just to prevent spurious faults in the
> > context of a new thread using a stale value for POR_EL0?
> 
> Not just prevent faults but enforce the permissions from the new
> thread's POR_EL0. The kernel may continue with a uaccess routine from
> here, we can't tell.

Hmm, I wondered if that was the case. It's a bit weird though, because:

  - There's a window between switch_mm() and switch_to() where you might
    reasonably expect to be able to execute uaccess routines

  - kthread_use_mm() doesn't/can't look at this at all

  - GUP obviously doesn't care

So what do we actually gain by having the uaccess routines honour this?

Will

