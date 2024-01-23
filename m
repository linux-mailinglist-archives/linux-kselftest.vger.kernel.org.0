Return-Path: <linux-kselftest+bounces-3421-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 572248392CA
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jan 2024 16:34:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AA831C216D2
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jan 2024 15:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DBFD5FEE4;
	Tue, 23 Jan 2024 15:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nQoe1N5I"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB285FDCC;
	Tue, 23 Jan 2024 15:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706024053; cv=none; b=FG38iGcKjn1fyrSIcQR3BqrNV1m+6MOTjjlSeQc8rN7AMiRngQqIEsdTEaEpE4fJrJtL1UR3+fCF3vMRGOZ14Ibd0oaIpDvCph0fpLZgNTkxe95lqqKVzCRtQB7BPphyuykg0D709nC22Ae/ymK8iB7wy22feBeLyICf3NNnhjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706024053; c=relaxed/simple;
	bh=VUBnDrHu3wRwT7UFTdkF6jesG1Iu1Riq11ShVr60N2M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PsIeBecVK72F+1UNb3WbQAes8BzyOo3UNhrrqvDpEmYF4FLQIC2wXlY1Sj91dvgNhHrfiBMDd2jF4kKTEWs/BLatPrJuCFkjlGwVnY1MfR5Al8VRl9Lx1Ku+MHVo45BtLeSSZ2uGBHZSdipwmJyT0RnmZDV+5+6jjw9+rchuHCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nQoe1N5I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F5CDC433C7;
	Tue, 23 Jan 2024 15:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706024053;
	bh=VUBnDrHu3wRwT7UFTdkF6jesG1Iu1Riq11ShVr60N2M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nQoe1N5I8V2TViuknsXbQakxAZiSFlYiGWanyKyvs8cpSFW8WIQeFR0Wnrm4wv7i+
	 fVjJskYHjvwukA9/DiO9uFjiuoDs3kNiYIZUAXHoul3aVPZu4IDUiJJ3GYyARKzHFI
	 RF/tbbE2os3uLVtIWQHQtfhGSEfZBeu3j/kAjvDBmCTAcFmCAtTD4IFhGRyt396FZf
	 MwCpMJQx8hEAw1syaeGJSULJ1Z+5B8ulD9fSejE311zwgOcuHSTBtcLBEtheZVvYOo
	 114R6sMOV6kvlSGcNgb28XKNhxwiktB27fkCCy608T39xBIAH0IiHuv1LviQCiyN+b
	 +wWsYiwkzbb3w==
Date: Tue, 23 Jan 2024 07:34:12 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Petr Machata <petrm@nvidia.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "netdev-driver-reviewers@vger.kernel.org"
 <netdev-driver-reviewers@vger.kernel.org>, Shuah Khan <shuah@kernel.org>,
 linux-kselftest@vger.kernel.org
Subject: Re: [ANN] net-next is OPEN
Message-ID: <20240123073412.063bc08e@kernel.org>
In-Reply-To: <87fryonx35.fsf@nvidia.com>
References: <20240122091612.3f1a3e3d@kernel.org>
	<87fryonx35.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 23 Jan 2024 10:55:09 +0100 Petr Machata wrote:
> > If you authored any net or drivers/net selftests, please look around
> > and see if they are passing. If not - send patches or LMK what I need
> > to do to make them pass on the runner.. Make sure to scroll down to 
> > the "Not reporting to patchwork" section.  
> 
> A whole bunch of them fail because of no IPv6 support in the runner
> kernel. E.g. this from bridge-mdb.sh[0]:

Thanks a lot for investigating! I take it that you're looking at
forwarding? Please send a patch to add the missing configs to

tools/testing/selftests/net/forwarding/config

The runner uses that to configure the kernel on top of defconfig.

Unless I'm doing it wrong and the sub-directories are supposed to
inherit the parent directory's config? So net/forwarding/ should
be built with net/'s config? I could not find the info in docs,
does anyone know?

