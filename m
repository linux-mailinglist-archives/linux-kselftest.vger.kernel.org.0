Return-Path: <linux-kselftest+bounces-45643-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CA0CC5D5C3
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Nov 2025 14:31:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4E0EC4E9404
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Nov 2025 13:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F66C3093BB;
	Fri, 14 Nov 2025 13:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uwRMxDpU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AA8Wmj8y"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0758237707;
	Fri, 14 Nov 2025 13:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763126757; cv=none; b=AyCO/nRc46bfgiOo2XmuK62PfOj94HpnhfTwhGDyBMXhzyOqLgf+/iCfsDfdTqCvfZ71nd8yRLoeDQVz1gRPBAH7xyLJDk1LNXUbbGiIAiOMjRgRohrLIXs0lhNsvejVBeJgROWToM3QzygetK9QNSFNG2oi+8YMh5TfJoNCPzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763126757; c=relaxed/simple;
	bh=BGBwi7SO4aaKXCl1GmQYJaHABho5Yc4x0/kxHVDHRyg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ajy8PWdIRq6Zq6GIvTnZvuBE6xf2yhpJDgMVJngBfoGeP40Yj2S0ZYX/q0o+Q047L4FYO3tpYYHq1e2MDXyPxmY/bOpky9XU0lILOfsrkd7r6JcizyFpk2zBnjyQtGd4zivbv54/NBUEWwOnWEj8ESGpfcTkIDIK5zahVj1/EhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uwRMxDpU; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AA8Wmj8y; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 14 Nov 2025 14:25:52 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763126753;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NWsp+DdVvkIFBzRvQmxTtKsXVPdhWUyfiVayBoC2gnY=;
	b=uwRMxDpUsmQkNiDHR2aRpQnLEO3NLe/HeP3dMYPTpxTK9tC2MzYnMHY+37FapkKCv2xcyY
	uqi4+Od03mE+igdikzvANHgze0fBIHBlfI4G+wJv2Uk5PadCfp9fX7ENkuPN4ZGTVSc6/f
	7vTginqjyKMe/A4l0mpseD8ztoEceJpoR2IoTgHm+A7BtDni4vfyf+jKqrdmXZ9gdBNMaZ
	+NMUcRXR4m8mLetQ/gYk62bFVLspDlL2Zr9hwna0fjSNjkq8moXU3WnoLovaHi5dzMfvZT
	uyf8oj78YDZWQ56HBq9pffAcmBmL0XdGOIPNPY38PlLtVdUp8my4ThjW7K24yQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763126753;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NWsp+DdVvkIFBzRvQmxTtKsXVPdhWUyfiVayBoC2gnY=;
	b=AA8Wmj8y6GHM5zV42MXXsuu4y5CURcGwWZU9ovOBVfayAD+9LEboJDNV31v8RM/PmvNA9w
	fscEw39w6r/EeYAw==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: David Gow <davidgow@google.com>
Cc: Brendan Higgins <brendan.higgins@linux.dev>, 
	Rae Moar <rmoar@google.com>, linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kunit: Make filter parameters configurable via Kconfig
Message-ID: <20251114142451-5fff7714-b714-4903-a12c-a13a28e88b40@linutronix.de>
References: <20251106-kunit-filter-kconfig-v1-1-d723fb7ac221@linutronix.de>
 <CABVgOSnSGkkcWJVS3t8=Tp1UbtpqdVV1LDvZczWUrneVCtja-g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABVgOSnSGkkcWJVS3t8=Tp1UbtpqdVV1LDvZczWUrneVCtja-g@mail.gmail.com>

On Fri, Nov 14, 2025 at 11:02:06AM +0800, David Gow wrote:
> On Thu, 6 Nov 2025 at 18:32, Thomas Weiﬂschuh
> <thomas.weissschuh@linutronix.de> wrote:
> >
> > Enable the preset of filter parameters from kconfig options, similar to
> > how other KUnit configuration parameters are handled already.
> > This is useful to run a subset of tests even if the cmdline is not
> > readily modifyable.
> >
> > Signed-off-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>
> > ---
> 
> Thanks. Do you think it'd make sense to also add one of these for
> kunit.action (i.e., support for listing tests/test attributes)?

I'm not sure. For my usecase not really.

> Otherwise, other than maybe the possibility of adding some detail to
> the help texts (though that'd just duplicate what's in the
> documentation for those module parameters), this looks good. We can
> always add more in a follow-up if it's useful.
> 
> Reviewed-by: David Gow <davidgow@google.com>

Thanks!

(...)

