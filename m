Return-Path: <linux-kselftest+bounces-14687-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B10E0945481
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Aug 2024 00:24:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7149728499C
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Aug 2024 22:24:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2457914B949;
	Thu,  1 Aug 2024 22:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DJ+RY8hv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFED013DDA3;
	Thu,  1 Aug 2024 22:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722551065; cv=none; b=PRfUuYUNgPlV6BEIb2ddhvPv+nBf4ubz8IyL1BsIdW2pNqZ93M0VrtiHxFak8KWVnaPHvCgPol6JENYk1IwYOBdg4vUnUJm1FN7axSb41eYpSMktmgGMvTz7W1Iqjk8mGRRfJKgKS+hRNdYVovs2p6z9qMTGffTE35ypVCZmhxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722551065; c=relaxed/simple;
	bh=AcvWsy9XY+bY//VE6FcMyUnl7b7Lb/jz7Zp4Oi0A1D8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=Ppz82m+qEaFQUBUvIYrEyRrjusyUg8lJCw+WXMxWzPtE2Q/C1efW+wps9usVLE2Ne70PBY/7Jtr5it5NRClLtkT6euinKGmHnXCPk1xjF9JMjFBKgJhjLSdqwp0PMwdLSAXsewUm7sCDHLFJhMd8pOrdb4FOK/09bSB1kLDXi7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DJ+RY8hv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21606C32786;
	Thu,  1 Aug 2024 22:24:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722551064;
	bh=AcvWsy9XY+bY//VE6FcMyUnl7b7Lb/jz7Zp4Oi0A1D8=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=DJ+RY8hv8+vBLlV09VDkKwHjNnMv74QVdFuS9zDkZ0V1XjX8FkAcA/S14R4PKTQqt
	 2/wGwSMdcpwPs4yLhT0hzzywdi3XIzS3eJqiTi5j+aVesPiMer/Cr2agpgKzrHbf3+
	 S/swkiG/kGmr2wYMBeC2y+L3hIbpWTUM56wNGt3dI52da+4FlLhpcf9gsVD5gbUqLE
	 UXQoRytpP7GMa6O2jhhbuEc/sGTvOy665Wq04xMKxlRBadyxX8j/fEPJSIgfrB9Jtq
	 tYePJGlCgrdZsN8reOaloZ4SjcnVvVAaFCRhc0YcNNV9y7E98cN0+TeTzXZ8fxmgF6
	 DmYycrpFsJL2Q==
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 02 Aug 2024 01:24:21 +0300
Message-Id: <D34XE10GQHIY.1H7BTET3DOREV@kernel.org>
Cc: <kernel@collabora.com>, <linux-kselftest@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] selftests: tpm2: redirect python unittest logs to
 stdout
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Shuah Khan" <skhan@linuxfoundation.org>, "Muhammad Usama Anjum"
 <usama.anjum@collabora.com>, "Shuah Khan" <shuah@kernel.org>
X-Mailer: aerc 0.17.0
References: <20240710081539.1741132-1-usama.anjum@collabora.com>
 <47ea7423-3aae-4bb3-a41f-1fcb5c07e74b@collabora.com>
 <8696338c-fcd7-4c0f-87ec-9303c9c1ce88@linuxfoundation.org>
In-Reply-To: <8696338c-fcd7-4c0f-87ec-9303c9c1ce88@linuxfoundation.org>

On Wed Jul 31, 2024 at 8:45 PM EEST, Shuah Khan wrote:
> On 7/31/24 07:42, Muhammad Usama Anjum wrote:
> > Reminder
> >=20
>
> top post???
>
> > On 7/10/24 1:15 PM, Muhammad Usama Anjum wrote:
> >> The python unittest module writes all its output to stderr, even when
> >> the run is clean. Redirect its output logs to stdout.
> >>
> >> Cc: Jarkko Sakkinen <jarkko@kernel.org>
> >> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> >> ---
> >>   tools/testing/selftests/tpm2/test_async.sh | 2 +-
> >>   tools/testing/selftests/tpm2/test_smoke.sh | 2 +-
> >>   tools/testing/selftests/tpm2/test_space.sh | 2 +-
> >>   3 files changed, 3 insertions(+), 3 deletions(-)
> >>
>
> Applied to linux-kselftest next for Linux 6.12-rc1
>
> thanks,
> -- Shuah

OK, great. Maybe it is not *that* critical to backport this.

BR, Jarkko

