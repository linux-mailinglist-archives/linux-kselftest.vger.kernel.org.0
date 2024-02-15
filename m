Return-Path: <linux-kselftest+bounces-4723-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6011A855BC0
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Feb 2024 08:39:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 051F71F2CEC6
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Feb 2024 07:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70C3B11183;
	Thu, 15 Feb 2024 07:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="p3OUwP8U"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C98DDD1;
	Thu, 15 Feb 2024 07:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707982766; cv=none; b=eBjHlWIiLlCS1y1ekWOERI2EVC7H2PsR5ONV08TaCoepy7Ri3EWY5WxFWskzNRrbUksIPEOtTERn9AYxHqYSPmuBYEpqYNMgGg0jzECu4+y5DlhDZlttA4pKNtYBwBc881td9KJyX+7Es32An8qJcTpyuYB27oQDtJFrWRcpeNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707982766; c=relaxed/simple;
	bh=HxtSLw+w1zTGCkjLPiCDlQ3SZFwE5BUR1mPiLjtpSJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NVgQaLGlDmhjg+8V2oqMHPEfhaR8+5byzpY0YB0EtXp5neI9liBn6AMgkWCLPOWq44r3T3kUNbxKkYRXmCjbfiSiT0aWwE9EekfW01vMBQ4Vg4w22Lv9wcV+fMlWY+huoLfyoMnW+fbciHNsp7pM9XscwsEw+PkfefyG0Z8IdFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=p3OUwP8U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D823C433F1;
	Thu, 15 Feb 2024 07:39:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707982765;
	bh=HxtSLw+w1zTGCkjLPiCDlQ3SZFwE5BUR1mPiLjtpSJ8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p3OUwP8UzmwSocednSH51m/JNPkk/w8QM2BhM+u3pzDai3FiwBw8oqsCafGLyUPHx
	 oDrCzXQ6hvdIw8Z2ueEo8jDW/1X9jdrp53jqE7C6ROaoN+J2Qz8s04yBOOBqXm51zQ
	 SFJfwEpubkcIaQTEOFUsO/t+9eszZnzXms/f93kU=
Date: Thu, 15 Feb 2024 08:39:22 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>, linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kunit: make kunit_bus_type const
Message-ID: <2024021512-twisting-hypnosis-7da3@gregkh>
References: <20240214-bus_cleanup-kunit-v1-1-1a38323eed73@marliere.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240214-bus_cleanup-kunit-v1-1-1a38323eed73@marliere.net>

On Wed, Feb 14, 2024 at 04:15:00PM -0300, Ricardo B. Marliere wrote:
> Since commit d492cc2573a0 ("driver core: device.h: make struct
> bus_type a const *"), the driver core can properly handle constant
> struct bus_type, move the kunit_bus_type variable to be a constant
> structure as well, placing it into read-only memory which can not be
> modified at runtime.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>


