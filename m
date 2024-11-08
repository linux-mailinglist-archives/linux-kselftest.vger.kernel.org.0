Return-Path: <linux-kselftest+bounces-21691-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A35F49C2050
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Nov 2024 16:26:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2C291C22204
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Nov 2024 15:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C987206E83;
	Fri,  8 Nov 2024 15:25:50 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02808206E79
	for <linux-kselftest@vger.kernel.org>; Fri,  8 Nov 2024 15:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731079550; cv=none; b=iwku3MyH+3SFe+rJe+lO/a9s5CeokXcsAM8lsBcEsPHVYzmC8diyZKMxqgRCwMyKBQ8D3u5891LdB0mTU4LvRsimRBobJIW7uuDZ5Uf1Fh6eu+NHoZw7SY7XbkH7RJ/wtVv0xzsNb+BPUzE2pdCXRLXePVrdsMgDGZKEbXrjqtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731079550; c=relaxed/simple;
	bh=Di0ldJzwD/4FunUZdHJKkqrhrCLdfODw907R7kiTRjM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gio6xjDJYg5UxdPSWHp9Bq1MJibAlmv8ugdyRUHfw82mePtbVa72JksijeLE1vpTr3v4zctS+P9ThnIEnBPc0FhMiGfysUdWicCJxto4SaIkfTxRzZt5K7dhZsxAYBiMLxr4QyNeK0S4G0s9mOPegHK11TfAeL8L2FACsJUS0rE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85218C4CECD;
	Fri,  8 Nov 2024 15:25:48 +0000 (UTC)
Date: Fri, 8 Nov 2024 15:25:46 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Mark Brown <broonie@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org,
	Shuah Khan <skhan@linuxfoundation.org>,
	Will Deacon <will@kernel.org>, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 2/4] kselftest/arm64: Fix printf() warning in the arm64
 MTE prctl() test
Message-ID: <Zy4telEzvU1DGih1@arm.com>
References: <20241108134920.1233992-1-catalin.marinas@arm.com>
 <20241108134920.1233992-3-catalin.marinas@arm.com>
 <4bbc179b-73b6-46d7-b414-f3b14079b489@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4bbc179b-73b6-46d7-b414-f3b14079b489@sirena.org.uk>

On Fri, Nov 08, 2024 at 03:10:59PM +0000, Mark Brown wrote:
> On Fri, Nov 08, 2024 at 01:49:18PM +0000, Catalin Marinas wrote:
> > While prctl() returns an 'int', the PR_MTE_TCF_MASK is defined as
> > unsigned long which results in the larger type following a bitwise 'and'
> > operation. Cast the printf() argument to 'int'.
> 
> >  	} else {
> >  		ksft_print_msg("Got %x, expected %x\n",
> > -			       (ret & PR_MTE_TCF_MASK), mask);
> > +			       (int)(ret & PR_MTE_TCF_MASK), mask);
> 
> Shouldn't we just use a %lx here?  Casts tend to be suspicious...

It's more like the ret is actually 32-bit and should stay like that when
bits are masked out. But the bitwise op 'upgrades' it to a long (in
hindsight, we should not have used UL for the TCF bits and mask).

-- 
Catalin

