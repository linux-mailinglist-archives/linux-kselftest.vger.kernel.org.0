Return-Path: <linux-kselftest+bounces-4909-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 882D5858DD5
	for <lists+linux-kselftest@lfdr.de>; Sat, 17 Feb 2024 09:02:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17D93B20F04
	for <lists+linux-kselftest@lfdr.de>; Sat, 17 Feb 2024 08:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DC761CD1E;
	Sat, 17 Feb 2024 08:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yGwTrS+4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0BF21CD17;
	Sat, 17 Feb 2024 08:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708156917; cv=none; b=kXEiwOBz4Ezumyh7ewo094ooCLvKLAwo/6zdj8/HEbV8oBmc6+0nCxPVVHbMRidZsz/jlvYkFfL07IB6oPqp5sbFQNQ1Sk4ttVnHg8qROTEgIjsRIZiwbIPz0L0QDT40wDTTb/MbvElbPWq16BVnDWM180mWRhGe5/BX+H420gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708156917; c=relaxed/simple;
	bh=SRXyCMay6d+7i35hw5/TogppVGxQdPA5nDzwp/LcC7k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c9hmm5grwppH1wHQ6LjQaYsafhKvGz0jh2ibLrUEnep3RuwRx+v1TI15dF7Uto4ee1QSKJEWF2v3X6uo6imlTnb4h8O7M7xAkeNbZH+OXqEYcuVr0I2nUlJG8R0RhXCHbVgCj0dMCeewB4eXlI2aOYOrWXN067PqbB80xxtDQlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yGwTrS+4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C337FC433C7;
	Sat, 17 Feb 2024 08:01:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708156916;
	bh=SRXyCMay6d+7i35hw5/TogppVGxQdPA5nDzwp/LcC7k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=yGwTrS+4zIt/K5bthZ4z/bBKZNyv2lv6fvDWY/u6kvjgW+W6t+9LNhbLei6SKO6Fr
	 wp2VLzJnxU9i5yXVMWPXOa+uV8sVFu8KMZ/0ABSwtM5Zk3jpAMePNcBP809iRM6eJ2
	 kNBQDqfLffoAQfq7KqJjvTgvtQluOWtskxszXCKU=
Date: Sat, 17 Feb 2024 09:01:53 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Elizabeth Figura <zfigura@codeweavers.com>,
	Arnd Bergmann <arnd@arndb.de>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org,
	=?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
	Wolfram Sang <wsa@kernel.org>,
	Arkadiusz Hiler <ahiler@codeweavers.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Andy Lutomirski <luto@kernel.org>, linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 00/31] NT synchronization primitive driver
Message-ID: <2024021756-bakeshop-wolf-f975@gregkh>
References: <5ae668e3-e275-40b0-af3c-6a459e3a0b87@p183>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ae668e3-e275-40b0-af3c-6a459e3a0b87@p183>

On Fri, Feb 16, 2024 at 07:31:12PM +0300, Alexey Dobriyan wrote:
> > drivers/misc/ntsync.c                         | 1146 ++++++++++++++
> 
> Assuming this doesn't go into futex(2) or some other existing code...
> 
> Can you start putting all of this into top-level "windows" directory?
> I suspect there will be more Windows stuff in the future.

There will?  Like what?

> So those who don't care about Windows can turn off just one config option
> (CONFIG_WINDOWS) and be done with it.

This should all be configured under one option anyway, so I don't see
the need.

> Name it "Linux Subsystem for Windows" for 146% better memes.

Fun with marketing!  :)

greg k-h

