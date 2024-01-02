Return-Path: <linux-kselftest+bounces-2591-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C39A822298
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Jan 2024 21:33:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82C051C22AA1
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Jan 2024 20:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B728312B76;
	Tue,  2 Jan 2024 20:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="pJQfTSkr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23209168A5;
	Tue,  2 Jan 2024 20:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1704227572;
	bh=Q/wpQ5hDA3lUiRluDg2RygkflJcWCGjGBp347NYFjck=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pJQfTSkrhT7hp18X6nNOyc7xBlmSkjB+rkrH7sdLet/DJrXnV3z4hXISJEiqqnVX3
	 QbEP07v3ATLtfFNWDPiZn/4TOc9F5l5UBEOyUbq2ey2GXdF63meWggx/0RYsFIQT6v
	 uTFuzBz7FQ+nKa3DGY54ZGOrxO+UNVjJnG6U6ZXOzZrF3A8+yRwPCpsXyGQhE0bixi
	 8tqAKpIXr8r2/kote3GBXmylLhojSlE5fiyz0qVBWyWf+OAaqtDWjRayj9Fm1gjIC0
	 TVSioNylxqzlx01Y1XuhJnb+ov3JbywV1tFLRnRQL/92PcobG0gjWSSBQg6lTtCmMH
	 zgkfAa3+CakuQ==
Received: from notapiano (zone.collabora.co.uk [167.235.23.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id B625837804B2;
	Tue,  2 Jan 2024 20:32:48 +0000 (UTC)
Date: Tue, 2 Jan 2024 17:32:15 -0300
From: =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado <nfraprado@collabora.com>
To: Laura Nao <laura.nao@collabora.com>
Cc: Shuah Khan <shuah@kernel.org>, Rob Herring <robh+dt@kernel.org>,
	Frank Rowand <frowand.list@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	kernel@collabora.com
Subject: Re: [PATCH] selftests: Move KTAP bash helpers to selftests common
 folder
Message-ID: <7a98105e-09ea-4eb0-9d0f-3b3a828470e5@notapiano>
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

Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
Tested-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Thanks,
Nícolas

