Return-Path: <linux-kselftest+bounces-25072-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A667A1B083
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Jan 2025 07:50:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97F893A7A4A
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Jan 2025 06:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 835571D63DF;
	Fri, 24 Jan 2025 06:50:09 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 155FC5733A;
	Fri, 24 Jan 2025 06:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=163.172.96.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737701409; cv=none; b=ud33QQLnhzuZBU/rYnDpn7jhTIE0lPXM9+872A2XrMzNoqquPY4XZpy0Crg/tBa8DWHd9UbIup3jTQak8bxf1UhdMMRhVib+z43uUZIIYJNMpSglU6oGCbPtJEPv+cpV1WTjoAbJ6or408gfPlSh4R0wNope2/Df4ss12KHaBGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737701409; c=relaxed/simple;
	bh=IsqhM0Iij4jmcMVPPDty/UavwkFXTCjbOjl+ftriEE0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UVNaY5KMSL9i/Qb4/sF3CdcXuADW8DVwy0gwMf6Q4qtN2uSa/VfjTqwkKZlk2T+OdNu32mH8NABjLjKbZxPwl1AJ2t4hvucF8rCK/Gg3evx1MOa+DilnVCGWMfo2TNsnH/0vMa9BxBOEb7n4AjjZ3tCTmEsgqD1HusJmtqnPGfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; arc=none smtp.client-ip=163.172.96.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
Received: (from willy@localhost)
	by pcw.home.local (8.15.2/8.15.2/Submit) id 50O6nubr014535;
	Fri, 24 Jan 2025 07:49:56 +0100
Date: Fri, 24 Jan 2025 07:49:56 +0100
From: Willy Tarreau <w@1wt.eu>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 0/3] tools/nolibc: compatibility with -Wmissing-prototypes
Message-ID: <20250124064956.GC14395@1wt.eu>
References: <20250123-nolibc-prototype-v1-0-e1afc5c1999a@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250123-nolibc-prototype-v1-0-e1afc5c1999a@weissschuh.net>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Thu, Jan 23, 2025 at 09:10:41PM +0100, Thomas Weißschuh wrote:
> Make nolibc compatible with -Wmissing-prototypes

Nice, ack for all the series:

  Acked-by: Willy Tarreau <w@1wt.eu>

Thank you Thomas,
Willy

