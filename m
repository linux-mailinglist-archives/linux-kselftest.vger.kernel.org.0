Return-Path: <linux-kselftest+bounces-4905-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF502858CE9
	for <lists+linux-kselftest@lfdr.de>; Sat, 17 Feb 2024 02:48:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8439F1F25D73
	for <lists+linux-kselftest@lfdr.de>; Sat, 17 Feb 2024 01:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E46AE1AACA;
	Sat, 17 Feb 2024 01:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yoq//APH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B97244C8F;
	Sat, 17 Feb 2024 01:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708134494; cv=none; b=ce03SV26kbObCzY2oO+hrWOkewV7Xkp7EdzslMmyMvCp/LVVxEuruGTLbIQMDkKtinb/0UBMqf2vjLp6znOMy2MmykdOElwc/opdOwnvWdeURYVAPOrZluH01w/BpcSBqgVVCoNS3HG92g4lL1CsxCPpuIBwRISVLBYr5kaQopk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708134494; c=relaxed/simple;
	bh=+/qU9sTft6N84fwOzrA3R69027DI8SB4KWAOUa/ErcM=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=sZufxLY7WbyP6UgL2nQwqp4zl6FAZ3qKqYR+EQw/FJpld/X8kowx/Y3AsJxTGyByn3ZRaz4Eylq/FbMznWzVXTAd0tS0ZLKfyfbjzRD5Q4V42g/DNpbSMm5OVAa24NgE9QlsyZI0v9mxTnq+l7eoaAzWK1dgxxX+Hvu0DKSOWIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yoq//APH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1564DC433F1;
	Sat, 17 Feb 2024 01:48:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708134494;
	bh=+/qU9sTft6N84fwOzrA3R69027DI8SB4KWAOUa/ErcM=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=Yoq//APHWRKSpUNM3k1lUsqvvrUt6vuE2dhf18yE0AxQRQCx0b/Am/7RMITURH/RT
	 lUusrperm7F0/6kp0qK2eYBDUDcuSDSdp05Jq6H9FGwj5Ya2b2AbIT8+s8vlHuCK4w
	 lG3g3fDO4GttQ01M6BmgMZkCPjtujcS6DvqilIf1HRuRcdE7bJGWKxSCkyIC9ot5BE
	 lqJ3BjCV64bbaSk1sponMk7261hGgk/Nu5UT1ioU0fwDTmWehV797cujolk6xKFtDo
	 P0lGBzfBFTElHyer7nieGNs46CRw38Nb7JLHR49EhOXtpcQ0EMg6ohjsLFDruIAD3S
	 KMqodvsmqIeSw==
Date: Fri, 16 Feb 2024 17:48:13 -0800
From: Kees Cook <kees@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>, Kees Cook <keescook@chromium.org>
CC: jakub@cloudflare.com, shuah@kernel.org, linux-kselftest@vger.kernel.org,
 netdev@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BRFC_0/7=5D_selftests=3A_kselftest=5Fhar?= =?US-ASCII?Q?ness=3A_use_common_result_printing_helper?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20240216172621.44df880b@kernel.org>
References: <20240216004122.2004689-1-kuba@kernel.org> <202402161328.02EE71595A@keescook> <20240216163119.7cc38231@kernel.org> <20240216163304.2ab0ff7a@kernel.org> <20240216172621.44df880b@kernel.org>
Message-ID: <C791109F-124B-4BC9-9BCC-B9E756FEAFE9@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On February 16, 2024 5:26:21 PM PST, Jakub Kicinski <kuba@kernel=2Eorg> wr=
ote:
>On Fri, 16 Feb 2024 16:33:04 -0800 Jakub Kicinski wrote:
>> On Fri, 16 Feb 2024 16:31:19 -0800 Jakub Kicinski wrote:
>> > Let's see if I can code this up in 30 min=2E While I do that can you=
=20
>> > ELI5 what XPASS is for?! We'll never going to use it, right? =20
>>=20
>> Oh, it's UNexpected pass=2E Okay=2E So if we have a case on a list of
>> expected failures and it passes we should throw xpass=2E

Right: it's still "ok" but it identifies something worth looking at ("why =
did this start passing?")

>
>I got distracted from this distraction :S
>Is this along the lines of what you had in mind?
>Both my series need to be rejigged to change the paradigm=20
>but as a PoC on top of them:

Oh yeah! This looks good=2E I will give it a spin tomorrow=2E

-Kees

--=20
Kees Cook

