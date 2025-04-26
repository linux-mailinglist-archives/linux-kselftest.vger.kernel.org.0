Return-Path: <linux-kselftest+bounces-31700-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0519BA9DA33
	for <lists+linux-kselftest@lfdr.de>; Sat, 26 Apr 2025 12:48:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D36787B3D09
	for <lists+linux-kselftest@lfdr.de>; Sat, 26 Apr 2025 10:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC1AF1FBCB0;
	Sat, 26 Apr 2025 10:48:16 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33B5252F88;
	Sat, 26 Apr 2025 10:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=163.172.96.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745664496; cv=none; b=ArvNrZ+G1HF63cKmwY8ZZZeyFqSCZlXzL3a0Vp8QbLZt7w/DK9BX15FWfyqPOQ3edzNx1cv9MGfuay1STbySdo/gZYDslFtFiQ+/VXqhn2Y4FdM2o7NOMo0uTZipsqGCP81OROEnpiwuLh9LsVQ2Of5CN0b5AxFVvnsq34k8dKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745664496; c=relaxed/simple;
	bh=jUD+WsFp4tg9bqt2jHb707OV1HIiSOX7AYGgiMcqCpc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sJX7Yd3at0K3vVPxUa2UFW06UxkUBorNEoGh+ruk2SdSL37/qHM8vPoV19DvygKXUzBpK8kP6PVM9bieLnhIWmBgxHfPswFKN90SNrTan0Rvb3qjtDnJ+FsTSXUD++McjON+ieGRRKSNM/vEk1PxIlslwCDojXJzUEf+2JahaAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; arc=none smtp.client-ip=163.172.96.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
Received: (from willy@localhost)
	by pcw.home.local (8.15.2/8.15.2/Submit) id 53QAmAsH018755;
	Sat, 26 Apr 2025 12:48:10 +0200
Date: Sat, 26 Apr 2025 12:48:10 +0200
From: Willy Tarreau <w@1wt.eu>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>
Cc: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
        Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 12/15] tools/nolibc: add namespace functionality
Message-ID: <20250426104810.GE17549@1wt.eu>
References: <20250423-nolibc-misc-v1-0-a925bf40297b@linutronix.de>
 <20250423-nolibc-misc-v1-12-a925bf40297b@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250423-nolibc-misc-v1-12-a925bf40297b@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Wed, Apr 23, 2025 at 05:01:42PM +0200, Thomas Weißschuh wrote:
> This is used in various selftests and will be handy when integrating
> those with nolibc.

It could be useful to add a small note here mentioning that the test
takes care of the optional OS support, and will run it only if started
as root.

Willy

