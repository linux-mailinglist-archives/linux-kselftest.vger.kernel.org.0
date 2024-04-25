Return-Path: <linux-kselftest+bounces-8870-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0182D8B26A8
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Apr 2024 18:39:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3246E1C20CDC
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Apr 2024 16:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 404BC43AA8;
	Thu, 25 Apr 2024 16:39:27 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BED32B9D9;
	Thu, 25 Apr 2024 16:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=163.172.96.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714063167; cv=none; b=LlV1Lv7amb+VIUkUYM1ole5VmAxbsvLJdw9cwoPb2KC8c5lwnWW7XBvg8NfRD6uoTwajgHPbRIyL+TQivfdQymY1ZRaqC/cM04dwGBIsvib1YDFLo29GBi4AJf8pZcMBWZEMzLuWFC4zeG1W9+4iG3gZUcgsWePcDa5L7TJoTzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714063167; c=relaxed/simple;
	bh=zMGiiRm4aUgUe7MdkObk4e9O32713KMqKLgbY0yJxjg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a4amr+ZBlGavyIYncQmec8F/zJSY57pID0AUe4yD7l7ZW3NOYsmu5lLTGgLJWOU3Aw4lceHL5bUgS0TtkQT8JHjxzC8jyIckUCneWrsr9MfVQ0qilGOu1pPJ2QebAYpmaLYaZQ71YrNNxbKOm1ytEd8wx9vazHvmDykXL3dmttc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; arc=none smtp.client-ip=163.172.96.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
Received: (from willy@localhost)
	by mail.home.local (8.17.1/8.17.1/Submit) id 43PGUdr8017257;
	Thu, 25 Apr 2024 18:30:39 +0200
Date: Thu, 25 Apr 2024 18:30:39 +0200
From: Willy Tarreau <w@1wt.eu>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 0/2] tools/nolibc: implement strtol() and friends
Message-ID: <ZiqFL02n3+4EKFMV@1wt.eu>
References: <20240425-nolibc-strtol-v1-0-bfeef7846902@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240425-nolibc-strtol-v1-0-bfeef7846902@weissschuh.net>

Hi again Thomas,

On Thu, Apr 25, 2024 at 06:09:25PM +0200, Thomas Weiﬂschuh wrote:
> I wanted to implement sscanf() for ksft_min_kernel_version() and this is
> a prerequisite for it.
> 
> It's also useful on its own so it gets its own submission.
> 
> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>

Nice work, thank you. For the whole series, modulo my small comments on
2/2:

  Acked-by: Willy Tarreau <w@1wt.eu>

Cheers,
willy

