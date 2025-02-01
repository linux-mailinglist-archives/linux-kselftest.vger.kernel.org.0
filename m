Return-Path: <linux-kselftest+bounces-25510-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A74A6A2482E
	for <lists+linux-kselftest@lfdr.de>; Sat,  1 Feb 2025 11:13:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 897533A53CC
	for <lists+linux-kselftest@lfdr.de>; Sat,  1 Feb 2025 10:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51331149E1A;
	Sat,  1 Feb 2025 10:13:39 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9BF92AD20;
	Sat,  1 Feb 2025 10:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=163.172.96.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738404819; cv=none; b=XXRydnp9xvM4+yZPChyWqiGGzQQkIaUaqDqdeOforzPrkVKHJDLYq/wAHJ0k7B14RG27zP5bba7FffgoQ7umjxlb+qfEb022DH7JTBsN7Qd7g5iFk6XiecAaRJMldhucKczVy6pde+eRxggTcO19EOpL5aics6Kw7pPVV/68dx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738404819; c=relaxed/simple;
	bh=eqy5n9zvc98rjwVXMWtKBTL0bMx8UfW5nruzLLsbyM8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DXRAyd1zD947n55BHvhakdEx6ptcK5YeAD2U7JS4YFp5pEI38Z0Sm7INP/M9EZUUigW6GoagfipPmCrajcH+FAYCOxHMEbwkMYgEtkVcUJO9sY7Bvr3bo/XYJUJvB/XMfIVczp6a5RXxufXrezgpcZkAa8B1QEoKzc9hCPysBwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; arc=none smtp.client-ip=163.172.96.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
Received: (from willy@localhost)
	by pcw.home.local (8.15.2/8.15.2/Submit) id 511ADYrT006385;
	Sat, 1 Feb 2025 11:13:34 +0100
Date: Sat, 1 Feb 2025 11:13:34 +0100
From: Willy Tarreau <w@1wt.eu>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/5] selftests/nolibc: always keep test kernel
 configuration up to date
Message-ID: <20250201101334.GE5849@1wt.eu>
References: <20250123-nolibc-config-v2-0-5701c35995d6@weissschuh.net>
 <20250123-nolibc-config-v2-5-5701c35995d6@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250123-nolibc-config-v2-5-5701c35995d6@weissschuh.net>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Thu, Jan 23, 2025 at 08:37:41AM +0100, Thomas Weiﬂschuh wrote:
> Avoid using a stale test kernel configuration by always synchronizing
> it to the current source tree.
> kbuild is smart enough to avoid spurious rebuilds.
> 
> Shuffle the code around a bit to keep all the commands with side-effects
> together.
> 
> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>


Acked-by: Willy Tarreau <w@1wt.eu>

Willy

