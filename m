Return-Path: <linux-kselftest+bounces-4536-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18F7F851E98
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Feb 2024 21:24:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF2EF1F25550
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Feb 2024 20:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81381481BE;
	Mon, 12 Feb 2024 20:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J2RLtG4g"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 546A94644F;
	Mon, 12 Feb 2024 20:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707769438; cv=none; b=KouoJSz9g4c0yw33VRkc2EYM+nA2Tmd6J9PaXNQI9ajvQnNHnKYt2vWhRRSzLtphswhVJIXQmdCtWrZ6u4Osh4QvEKtHTI6heC50huHKnF95fB8JpwILDqDIpcagx3duj4aCUxGXPH21oN/njkY5OmV4AIIr2xypdwLydnsrPao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707769438; c=relaxed/simple;
	bh=JQf2lj/HzjPCnEf/bSiPcFb7iymUO94Ot5ZsNI7BFTQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Htst9L72KrnAiv3U9nivqz232RrSiaaDBMkqb+2Z6+ZAjCPCugsbNRNUSQm4TbLfQtAh3WibUkIJSFMtlYhzinEq4d3wxKor34infTD2DOA8QRYg6lkEB5ClH5M0VmN7wMdDiP76GbptBOyUBQkm085XOfzm6jj0jXDOprK/LR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J2RLtG4g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6524FC433C7;
	Mon, 12 Feb 2024 20:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707769438;
	bh=JQf2lj/HzjPCnEf/bSiPcFb7iymUO94Ot5ZsNI7BFTQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J2RLtG4g3Y8jRHRN96RqXggg8ZI07R9k9EXGIdTIJZZV5M4jwgikh+zBQwZPVDYn6
	 mXQ07PE/UVuDnzO1WK7f99rY9D0K/eFRLsrUe2jnjU5CkYJBpWPlk7i9cW+WGZFf99
	 y5ATK5fbpLwRtWxMBIHRLaG8Qoo8K/LyYkViIGI8liSuvywKbY1ySfMbWWXfXS+TlD
	 ejHF+VsLi9rvdusRuU2SoqTgtB9Do7l7cHio8aDRKCIjKAxjiDDNdZWP1s53pVGC54
	 5vCQTt1zcpXIISiVRGRakWQ2sjB8PksbyFmA/KYWc/WG4S4eDI4lExHRSTWP9vAaPu
	 hcBqAZnTIhqTg==
From: SeongJae Park <sj@kernel.org>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Bernd Edlinger <bernd.edlinger@hotmail.de>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 4/4] selftests: damon: add access_memory to .gitignore
Date: Mon, 12 Feb 2024 12:23:56 -0800
Message-Id: <20240212202356.73461-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <34986860-41e5-4d03-a0c5-72af12e7e97c@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 12 Feb 2024 21:07:34 +0100 Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:

> 
> 
> On 12.02.24 20:53, SeongJae Park wrote:
> > Hello,
> > 
> > On Mon, 12 Feb 2024 20:43:39 +0100 Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:
> > 
> >> This binary is missing in the .gitignore and stays as an untracked file.
> >>
> >> Reported-by: Bernd Edlinger <bernd.edlinger@hotmail.de>
> >> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> > 
> > 'checkpatch.pl' complains as below:
> > 
> >     WARNING: Reported-by: should be immediately followed by Closes: with a URL to the report
> >     #11:
> >     Reported-by: Bernd Edlinger <bernd.edlinger@hotmail.de>
> >     Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> > 
> > I guess the 'Closes:' could this link?
> > https://lore.kernel.org/r/AS8P193MB1285C963658008F1B2702AF7E4792@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM
> >
> 
> I will add the Closes tag with the right link, thank you.

Thank you :)

> 
> > Also, note that this conflicts on mm-unstable.
> 
> Should I use mm-unstable as basis to make sure no conflicts are introduced?

DAMON selftest patches could be merged in mm-unstable or linux-kselftest
depending on cases.

If you rebase this on mm-unstable, it might conflict on linux-kselftest.
Letting Shuah merge this on linux-kselftest and asking Linus Torvalds to fix
the conflict in next merge window could be one possible option.

Or, making this split out of this series, rebase on mm-unstable, and asking
Andrew Morton to carry may be another option.

Andrew and Shuah, may I ask your opinions?


Thanks,
SJ

[...]

