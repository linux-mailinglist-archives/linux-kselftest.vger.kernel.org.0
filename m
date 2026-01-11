Return-Path: <linux-kselftest+bounces-48678-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AFE7D0E886
	for <lists+linux-kselftest@lfdr.de>; Sun, 11 Jan 2026 11:06:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2B4DC300D41D
	for <lists+linux-kselftest@lfdr.de>; Sun, 11 Jan 2026 10:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BCCC318BA8;
	Sun, 11 Jan 2026 10:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=1wt.eu header.i=@1wt.eu header.b="KKoE1Xwk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mta1.formilux.org (mta1.formilux.org [51.159.59.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A1122D7DC1;
	Sun, 11 Jan 2026 10:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.159.59.229
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768125978; cv=none; b=Pmq8/OQ3U/K+lrqqKmD91jvrWrOGkChAtMVzPVP4BLuM79wCjyrjCJBO0KU/ZpoLG1D3s3i4Yn/icIXSsEdLyxa0bH5SNpkFfnokyl4LhUlnlzdsDOy5H4q/hmY+OnJDG+lNrt9hdngbCsX5KEY3OhNNuz48PQG2zfBkOj4HZT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768125978; c=relaxed/simple;
	bh=Z4yMKmjbUNaAw+SpCE0KEIXbOOxs+ymVABNfc8SXOfA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QrtVWXDPzPv4nu+/Y9Dq8w86qAjgZmkfPknImivbbwl6hSCdjuwOVWmVddk9T6AoFWynf0aSVbZEqWANde/GsQzNVE37gkBc0RlwlQDljNUU+GXl+gij9jrrKSSCnpUp/0XQmq7H572vYNNSvBihqdcn7RDx5JPSLmsNQC5EtX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; dkim=pass (1024-bit key) header.d=1wt.eu header.i=@1wt.eu header.b=KKoE1Xwk; arc=none smtp.client-ip=51.159.59.229
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1wt.eu; s=mail;
	t=1768125966; bh=JMA8eRzH/pwiCl3E1420RjwZT9tL7oUKEiZr5J81GoQ=;
	h=From:Message-ID:From;
	b=KKoE1XwkAXU6975f5Hqkhzmdsd26eEq+ibZgp84dPdARa5t7+xrLApTItyLXMHguJ
	 Vq54sW2q8Wuc1Ls8oATV3MbsOjgalR6Xmp/ic/PkwD+r9y0Lk0Ys5HYdPHMRuQX9qT
	 ZHlIyeb1g8v/D62opiUgr3F4gSuBEAV8HDcuvGzw=
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by mta1.formilux.org (Postfix) with ESMTP id 70E86C09BF;
	Sun, 11 Jan 2026 11:06:06 +0100 (CET)
Date: Sun, 11 Jan 2026 11:06:06 +0100
From: Willy Tarreau <w@1wt.eu>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] selftests/nolibc: improvements to the kselftest
 runner integration
Message-ID: <aWN2Djjv1z_0ZFBx@1wt.eu>
References: <20260106-nolibc-selftests-v1-0-f82101c2c505@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260106-nolibc-selftests-v1-0-f82101c2c505@weissschuh.net>

Hi Thomas,

On Tue, Jan 06, 2026 at 12:44:56PM +0100, Thomas Weiﬂschuh wrote:
> Fix the execution of 'make run_tests' and also wire up libc-test.
> 
> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>

For the whole series:
Acked-by: Willy Tarreau <w@1wt.eu>

Thanks,
Willy

