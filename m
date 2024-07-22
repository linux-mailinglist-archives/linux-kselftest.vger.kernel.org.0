Return-Path: <linux-kselftest+bounces-14001-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 37CB59393E1
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Jul 2024 20:52:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67DF71C2152D
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Jul 2024 18:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08FAE16FF5A;
	Mon, 22 Jul 2024 18:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="KspQ6jkn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B12A16EBF0;
	Mon, 22 Jul 2024 18:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721674341; cv=none; b=k9823zUV3y/2LTa8vskwvvjr3apbJaGyhsTm3zPcPunRkwhfwp+auBOhOP/B6raLetz0lMgo+qvk0EUw8Vqyq9CcGILnnLCHiPeW6Br3bdyymUorm2OnszrYdJFJJBeLe8ITcKiBPFZ1E43NRErxaLsY8WZIHUxCLedZKwEj6bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721674341; c=relaxed/simple;
	bh=9CIc1XlRDVqSX70HnPwHx+wFrc7kTfy/vxozkOgco1w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ruzaqM+pKNAeXQ/7Hpi62ZNWz3vy2abua71vA4YFCznbUSqBUzKHV65MsQAh6OkYyGzVx5KZrje4hm3iElN9fQkLrqcCC3eBrb+oqE6V2/0HJJn6ofAkZwuYQYCiCIxKVIZWwQkithEuvu8hCoK/Dtsg6d2rcpfvD3/YvP6OH+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=KspQ6jkn; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1721674333;
	bh=9CIc1XlRDVqSX70HnPwHx+wFrc7kTfy/vxozkOgco1w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KspQ6jknwz3pawGMvQYRgqB2lNBo2zLNNN0v9QI95Rf4DUMPbXySO3nc2PlSHufzm
	 kwA7fscMtVhi82YW9ZqFP8qaZU+giRdMmYi/ZW7OvWIMKyNUrg3NOI3+Iq4CO2z+iK
	 4D8bo1QCC5Y7t9KmZ4a5qd6vgdlJ1nlH7kUBfc5IiVIgGRbbUTV7lKEsptC62VgjdX
	 wH9oSHFdpqmDvhjGupNL4AciHOWxJI3JczClgEg/Im4BBvv8I0nDugL1+tL/vdSd/A
	 PGVW5HZSBEV5TWOeT/RCT2g3ea1oJhxCLUkmil/fNP8tcBjvWUALYuxvxkc6tv2GHe
	 R14Xu8cMkGuZw==
Received: from notapiano (zone.collabora.co.uk [167.235.23.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 2844337806B3;
	Mon, 22 Jul 2024 18:52:10 +0000 (UTC)
Date: Mon, 22 Jul 2024 14:51:58 -0400
From: =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado <nfraprado@collabora.com>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Laura Nao <laura.nao@collabora.com>, shuah@kernel.org,
	gregkh@linuxfoundation.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCH] selftests: ksft: Track skipped tests when finishing the
 test suite
Message-ID: <b558e9dd-3c09-44a2-923d-afe7bc2a7e97@notapiano>
References: <20240722154319.619944-1-laura.nao@collabora.com>
 <0fe1b57e-4557-4020-878a-7eec13a2fdb1@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0fe1b57e-4557-4020-878a-7eec13a2fdb1@linuxfoundation.org>

On Mon, Jul 22, 2024 at 11:32:35AM -0600, Shuah Khan wrote:
> On 7/22/24 09:43, Laura Nao wrote:
> > Consider skipped tests in addition to passed tests when evaluating the
> > overall result of the test suite in the finished() helper.
> > 
> > Signed-off-by: Laura Nao <laura.nao@collabora.com>
> > ---
> >   tools/testing/selftests/kselftest/ksft.py | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/tools/testing/selftests/kselftest/ksft.py b/tools/testing/selftests/kselftest/ksft.py
> > index cd89fb2bc10e..bf215790a89d 100644
> > --- a/tools/testing/selftests/kselftest/ksft.py
> > +++ b/tools/testing/selftests/kselftest/ksft.py
> > @@ -70,7 +70,7 @@ def test_result(condition, description=""):
> >   def finished():
> > -    if ksft_cnt["pass"] == ksft_num_tests:
> > +    if ksft_cnt["pass"] + ksft_cnt["skip"] == ksft_num_tests:
> 
> Please don't. Counting skips in pass or fail isn't accurate
> reporting. skips need to be reported as skips.

Hi Shuah,

this won't change the skip count, just allow a test suite that has a mix of pass
and skip results to exit with code 0. That's the same behavior as the C
ksft_finished() helper in kselftest.h:

#define ksft_finished()			\
	ksft_exit(ksft_plan ==		\
		  ksft_cnt.ksft_pass +	\
		  ksft_cnt.ksft_xfail +	\
		  ksft_cnt.ksft_xskip)

It was my oversight to not do the same in the python helper.

Laura,

I consider this fixing an incorrect behavior, so I'd add this tag:

Fixes: dacf1d7a78bf ("kselftest: Add test to verify probe of devices from discoverable buses")

I think the message is good as is, but maybe it could have mentioned that this
matches the behavior of the C helper, just to make the point above clearer.

Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

And just a note for the maintainers, this patch depends on "kselftest: Move ksft
helper module to common directory"
https://lore.kernel.org/all/20240705-dev-err-log-selftest-v2-2-163b9cd7b3c1@collabora.com/
which was picked through the usb tree but is queued for 6.11-rc1.

Thanks,
Nícolas

