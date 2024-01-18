Return-Path: <linux-kselftest+bounces-3205-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 298CC831C6B
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Jan 2024 16:27:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C0721C20EB0
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Jan 2024 15:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8C9528DAD;
	Thu, 18 Jan 2024 15:23:42 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB4EF28DA4;
	Thu, 18 Jan 2024 15:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705591422; cv=none; b=j/7HH/C8nh9vKSZDyxgYAetq1SKbD581DTagUWtwqSqNM7EhYjXA++K87gW5BE1oS9LGjm22+wjTlmJ5VPvqWBDhrvTjbeojP4Bfe5d1SVKeiUfONYbxWPBAS6L5mO6HHAEPxeuzd7xOlAXD5F7E3nhKjyxuTXSLeDUF4dXpQ5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705591422; c=relaxed/simple;
	bh=icNsLcoeq2o0/4o3AFJv51eCsoCGswIf7Ldk3RqNmPo=;
	h=Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To; b=GebY0/zbm6T27rZdz+kJNB4EJ5G1k9K8VXqjMFbUUoy6a52CftOE0i6dc8pSZIee64MKrB4rIMlRvme/ickUe9iAhb1+0XNOaY0uG/MvcE2T411rs7SjP0cDWP17gcco/67m3rnPp0xJ7Q0Cw+XuYZliq3cw/wZ6PCvKHx19mBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 42C441042;
	Thu, 18 Jan 2024 07:24:25 -0800 (PST)
Received: from FVFF77S0Q05N.cambridge.arm.com (FVFF77S0Q05N.cambridge.arm.com [10.1.28.174])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EF5303F73F;
	Thu, 18 Jan 2024 07:23:35 -0800 (PST)
Date: Thu, 18 Jan 2024 15:23:30 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
	linux-kernel@vger.kernel.org, patches@lists.linux.dev,
	linux-um@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
	kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
	devicetree@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Subject: Re: [PATCH 1/6] arm64: Unconditionally call unflatten_device_tree()
Message-ID: <ZalCcivD0vXpQfr9@FVFF77S0Q05N.cambridge.arm.com>
References: <20240112200750.4062441-1-sboyd@kernel.org>
 <20240112200750.4062441-2-sboyd@kernel.org>
 <ZaZtbU9hre3YhZam@FVFF77S0Q05N>
 <CAMuHMdU0qtMeX=7SY+32=30-QGMRniFVCCm217REJ1X+ZNJ=Aw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdU0qtMeX=7SY+32=30-QGMRniFVCCm217REJ1X+ZNJ=Aw@mail.gmail.com>

On Tue, Jan 16, 2024 at 03:13:42PM +0100, Geert Uytterhoeven wrote:
> Hi Mark,
> 
> On Tue, Jan 16, 2024 at 12:51 PM Mark Rutland <mark.rutland@arm.com> wrote:
> > On Fri, Jan 12, 2024 at 12:07:44PM -0800, Stephen Boyd wrote:
> > > Call this function unconditionally so that we can populate an empty DTB
> > > on platforms that don't boot with a firmware provided or builtin DTB.
> > > There's no harm in calling unflatten_device_tree() unconditionally.
> >
> > For better or worse, that's not true: there are systems the provide both a DTB
> > *and* ACPI tables, and we must not consume both at the same time as those can
> > clash and cause all sorts of problems. In addition, we don't want people being
> > "clever" and describing disparate portions of their system in ACPI and DT.
> 
> We'd get to the latter anyway, when plugging in a USB device where the
> circuitry on/behind the USB device is described in DT.

I don't understand what you mean there; where is the DT description of the USB
device coming from if the DTB hasn't been unflattened?

Mark.

