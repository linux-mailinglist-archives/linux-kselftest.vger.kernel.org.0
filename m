Return-Path: <linux-kselftest+bounces-48270-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D58FCF65E8
	for <lists+linux-kselftest@lfdr.de>; Tue, 06 Jan 2026 02:52:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8BD6F303FCF6
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Jan 2026 01:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1703722172C;
	Tue,  6 Jan 2026 01:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T0BlZhQ2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2768221DB0;
	Tue,  6 Jan 2026 01:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767664328; cv=none; b=JqnKABdZ7cRdl23U2IUOqD7P8RgcSvHrR/u6sTcirGxNNDqGDT76scxBtjiueWLN0iCGP/jF5twt3viTz3V33dFxKFLQy8S2g3FRB5CN0HdIs5UTEPAZlp8uP04oLNmz/5P0VmQ0guTLdaIh8ri6D4T1nyoD5GfQR1hTWsvzszk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767664328; c=relaxed/simple;
	bh=rgRAUCJPBwncGlwTdRFw1GUVxCAvl6kWItaIkD7Gwnw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mW57dbCUEWa1JElnvOuawXwjFWXeIOjCW+H3Yo4azpYk6B6X23d3hqrZiKfukbFlRVMUNWTgkiZ4nCf8QXLEaPw2Eqk65eNqVpbBq7rDiHsKB+6ipDOFvKPhH/6t43PLhzFZPJYypaKrt8jgouQ4vN3C8wBTCZUoe7ZxM/mVnOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T0BlZhQ2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11061C116D0;
	Tue,  6 Jan 2026 01:52:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767664327;
	bh=rgRAUCJPBwncGlwTdRFw1GUVxCAvl6kWItaIkD7Gwnw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=T0BlZhQ2/+S3skRIDCD5kZzgmAEXVUEzg0/mtjdTSA2d7ochVLN+aHutzZFnE20XA
	 oFqeSO+HoYus1ja/9AsmYULGKLaL9wNVNaFVWsCzMJG/E3MbIcaBTGcrtP6I2qBTqd
	 csdlmmlTe1ST8eeD46Iu9CEitS9/lCJdRoOTuGbhDxrpRkO0i1NXuf0ROTKI2mbVGI
	 aj3zqitOzUz58ZbCkWAqj1TildRG6LunWAjJ2n6ttoQ7E5D85GF3NyIPXn/KmdezbC
	 usxop+h8ZL4E+4jhT5KWDo73PUiIernKrVn5vKA59Nq8dEIs0vPGivkfuiC/B3tYGc
	 J1r7gCXGeqf8Q==
Date: Mon, 5 Jan 2026 17:52:06 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Cosmin Ratiu <cratiu@nvidia.com>
Cc: <netdev@vger.kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S
 . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, Carolina Jubran
 <cjubran@nvidia.com>, <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH net-next 2/2] selftests: drv-net: psp: Don't fail
 psp_responder when no PSP devs found
Message-ID: <20260105175206.7b74067d@kernel.org>
In-Reply-To: <20260105100424.2626542-3-cratiu@nvidia.com>
References: <20260105100424.2626542-1-cratiu@nvidia.com>
	<20260105100424.2626542-3-cratiu@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 5 Jan 2026 12:04:24 +0200 Cosmin Ratiu wrote:
> psp_responder, used in the PSP self tests, fails when no PSP devices are
> found. This makes the PSP test time out on connecting to the responder
> and throw out an unpleasant Python exception.

Indeed, handling the errors for responders within bkg() is quite
annoying. Or at least I didn't find a clean way to do it.

> Change psp_responder to open the server socket and listen for control
> connections normally, and leave the skipping of the various test cases
> which require a PSP device (~most, but not all of them) to the parent
> test. This results in output like:
> 
> ok 1 psp.test_case # SKIP No PSP devices found
> [...]
> ok 12 psp.dev_get_device # SKIP No PSP devices found
> ok 13 psp.dev_get_device_bad
> ok 14 psp.dev_rotate # SKIP No PSP devices found
> [...]

To be clear - in this case the DUT also doesn't have a PSP device?
I'm struggling to connect the dots on how this error msg could come
from psp_responder.

