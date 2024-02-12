Return-Path: <linux-kselftest+bounces-4510-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA823851777
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Feb 2024 16:01:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A696A283FC5
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Feb 2024 15:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 794FC3B797;
	Mon, 12 Feb 2024 15:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="AfdM6/Fl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC643C46C;
	Mon, 12 Feb 2024 15:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707750080; cv=none; b=gH9ODy6ijT68oVdUutbdmB3wYieBsplI4JgY9YMXpX+LIohk/Ags9zzdDRdL8LJ4CksNO0e01c3iuuxGw4KzjGtgPm2Kw5ZqSh4ACAxHaBFEHTklygEQGovU5yBLObrh3sM/fB6IUJSO7mZaUDXcAx6CJ0ipWNUmBDmliMrALzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707750080; c=relaxed/simple;
	bh=84ZlsfUCbgrLSlPwH1NEYTwV7mGy7VAwpen0lKDl+/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uzZAMLdDaAemqQKmwAQwOuXaWjZVhxS9WzFh6WqQ6JHhBzSj2ff7r7QMt4TCtn3dXdMxdn02z3jkVo3NQRBPD63w2hL0xLt7n0eNp1b0gv1dNI48RH6jppK5bgt/5Pj3P/6H2dQa1qKZMESx16ZRFNC4vIXWpEXcQoCXEQuzzmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=AfdM6/Fl; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1707750077;
	bh=84ZlsfUCbgrLSlPwH1NEYTwV7mGy7VAwpen0lKDl+/Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AfdM6/FlyyUcs9EppKi7/sYeRLSK2v6ydSeMsNNXTyacNEwT04zoV5qhEm0bH2TD9
	 quA1VOU4qZq6ZQs/mXwvhzs3y+Vv6k5N3RfjI50+7tm4kU8tt/5KzVQdCyjs9eTHmo
	 dAnHsLQlcAo4TGkrjEfp9Mh19HXRkVBa5c/JgnKk4t5twyGyRPbk5aeaJOc/oSOJCJ
	 DJyGuVunI75m55twh7AJHPu8W9p0KyHbK0uhbZP9m0I256ezKdFQebMuEtJi1aleZ9
	 EpEo9YSsHinZQiLFQucVWiQBLf3/68hDJpIEPeWIKVTEQe2F/VNKcDuuRCmak7bKF7
	 SugK6NUu2c5jg==
Received: from notapiano (zone.collabora.co.uk [167.235.23.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 652623780A0B;
	Mon, 12 Feb 2024 15:01:15 +0000 (UTC)
Date: Mon, 12 Feb 2024 10:01:13 -0500
From: =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado <nfraprado@collabora.com>
To: Laura Nao <laura.nao@collabora.com>
Cc: Shuah Khan <shuah@kernel.org>, Rob Herring <robh+dt@kernel.org>,
	Frank Rowand <frowand.list@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	kernel@collabora.com
Subject: Re: [PATCH] selftests: Move KTAP bash helpers to selftests common
 folder
Message-ID: <5b14aa28-a239-4204-a8ce-8d37f19b724b@notapiano>
References: <20240102141528.169947-1-laura.nao@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240102141528.169947-1-laura.nao@collabora.com>

On Tue, Jan 02, 2024 at 03:15:28PM +0100, Laura Nao wrote:
> Move bash helpers for outputting in KTAP format to the common selftests
> folder. This allows kselftests other than the dt one to source the file
> and make use of the helper functions.
> Define pass, fail and skip codes in the same file too.
> 
> Signed-off-by: Laura Nao <laura.nao@collabora.com>
> ---

Hi Shuah, any thoughts on this patch?

It's gotten Rob's ack, so I take this will be merged through your tree.

Thanks,
Nícolas

