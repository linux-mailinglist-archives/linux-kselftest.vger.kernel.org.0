Return-Path: <linux-kselftest+bounces-47990-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 47B2FCE6EDD
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Dec 2025 14:57:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ED089300976F
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Dec 2025 13:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE2DC312826;
	Mon, 29 Dec 2025 13:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="I5qcZiKs";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dbHkKS7k"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE85F22A4EB;
	Mon, 29 Dec 2025 13:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767016654; cv=none; b=a9bXK6XTDsZHk1b2uprnA+b05fSEUuxvQd7V246EuAJfwGuIFDUngv3K9h1ufnoCaPn6oM04u3+Z2Y+Hun2rJ7sCNkvbJPRkuDW0XnxSFuLvwN+FJorD1lh7q49A9TYsZH6uohVZD8imWXHAz10TrXwAJ0JmftufxYPu+AjZgKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767016654; c=relaxed/simple;
	bh=q9jk6pdPEBQYIy34ofx1tOOTdyh9/Soq/BIZTagnNkk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oi56vTYH4NC3/08htcvKU4masiCdc9tj1W6CLAZNkSy0uhZ4KPn/AQSpxjn8xpt03lBNEndaW7/ac+U5CCxoj0335SbfBHl/ONnBhcxG5TI8jX9y7YzQCrDHCIkewND7FvMv9+HhOj8laSkhp+868GKWA6Aj6brPuKINk3wOgPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=I5qcZiKs; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dbHkKS7k; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 29 Dec 2025 14:57:25 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1767016650;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b2+4kIzxc3Y23tv43jhWLxYxiyYeeu8jb11lSSlPEI0=;
	b=I5qcZiKs0kZuG6WFijLQpjUDQslghyctI6bq3ZbRMPidB6gii+vuf2mv9WilX3zHFofmIO
	QDtP3gz79coZq4XJxofSWVRwoK82EtataOuq4LHR9BeL2Snsopbl0SOQM9M7VZMspskgvd
	bvKf9Wh81hMOgx+68Sj/RNxeUeSvlezZhATZ5riJVuo/9FFQm+/30v51U2y6RYW+qNFXLk
	rkMwi7DYwcMzOwHkxI92+vi8MQ4+RL5L1ka99lLZw13a+FrZwDSWoigB8pbThLQPIa6FhB
	UoGxvowJugXRneNc+wD9TAyBT0a6+SU8ma5u2s8zShT01IE0R5WyMjoUOaD8lg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1767016650;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b2+4kIzxc3Y23tv43jhWLxYxiyYeeu8jb11lSSlPEI0=;
	b=dbHkKS7kIeECJgZK+9wsENJu90OJsTxc5pTWAzCXjBrSyBNOOtYiE/2Nl+cpHlKtBvdo/0
	c9FxZxlT3c1j3hAw==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado <nfraprado@collabora.com>
Cc: Shuah Khan <shuah@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Bjorn Helgaas <bhelgaas@google.com>, kernelci@lists.linux.dev, 
	kernel@collabora.com, Tim Bird <Tim.Bird@sony.com>, linux-pci@vger.kernel.org, 
	David Gow <davidgow@google.com>, linux-kselftest@vger.kernel.org, 
	Rob Herring <robh+dt@kernel.org>, Doug Anderson <dianders@chromium.org>, linux-usb@vger.kernel.org, 
	Saravana Kannan <saravanak@google.com>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Guenter Roeck <groeck@chromium.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/3] kselftest: Add test to verify probe of devices
 from discoverable buses
Message-ID: <20251229145542-059157e7-1864-4407-8734-0a32589f9b0b@linutronix.de>
References: <20240122-discoverable-devs-ksft-v4-0-d602e1df4aa2@collabora.com>
 <20240122-discoverable-devs-ksft-v4-1-d602e1df4aa2@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240122-discoverable-devs-ksft-v4-1-d602e1df4aa2@collabora.com>

On Mon, Jan 22, 2024 at 03:53:21PM -0300, Nícolas F. R. A. Prado wrote:
> Add a new test to verify that a list of expected devices from
> discoverable buses (ie USB, PCI) have been successfully instantiated and
> probed by a driver.
> 
> The per-platform list of expected devices is selected from the ones
> under the boards/ directory based on the DT compatible or the DMI IDs.
> 
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> ---
>  tools/testing/selftests/Makefile                   |   1 +
>  tools/testing/selftests/devices/Makefile           |   4 +

>  tools/testing/selftests/devices/ksft.py            |  90 ++++++

This seems to be a copy of tools/testing/selftests/kselftest/ksft.py.
Instead of copying the file, try to use it from the standard location.

>  .../selftests/devices/test_discoverable_devices.py | 318 +++++++++++++++++++++
>  4 files changed, 413 insertions(+)

(...)

