Return-Path: <linux-kselftest+bounces-25207-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F3DBEA1CCA1
	for <lists+linux-kselftest@lfdr.de>; Sun, 26 Jan 2025 17:30:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2ED2D1883F59
	for <lists+linux-kselftest@lfdr.de>; Sun, 26 Jan 2025 16:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A737914830C;
	Sun, 26 Jan 2025 16:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fHq6GGGx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74AD04207A;
	Sun, 26 Jan 2025 16:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737909015; cv=none; b=dmVpNrNCRJSXKOLHgse+BmOggpU1R913w9xKLZh8fA3ctbM1dSTA6wqawNwjsLZNUYvSKB20+QZlh+NAkhsv1zmTevOuaYJl3hRKOsBVzIbEHiJheMnsc0Q4W8P6bQFyyTCeyB8wj4vHz7VTI6mvMwuB2Nz1kr0hZqNmT7oSMl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737909015; c=relaxed/simple;
	bh=S+titEhlUb+YuBZU352XKekzkddgMY2IF2iQ3s9Ha78=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=CyVHvcH+Peno1DcA7UfwJMfijrwVNhXK+FzhPXvBOZ/t/aW+hqdixZRyvSoUlJUGvLPGv+7EH7cdNqbr4ctxqXvU8987ytryxx10y6+OkrWR8oGufum2q0ymk+utvIcgGwPGHvhC1s0mj3ZJPXeHbjG8bguprl+MP1ueIoiDMl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fHq6GGGx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E57E4C4CED3;
	Sun, 26 Jan 2025 16:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737909014;
	bh=S+titEhlUb+YuBZU352XKekzkddgMY2IF2iQ3s9Ha78=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=fHq6GGGxfr8xN+irpfhxmtgUM6cLRywp70+XYXqUwhdtfv+G+tljn/+QCLd8bWHk3
	 mkaqSEHkssD1I4B5DN/NZTSmfjgp/PSzgPmi+dRmDsEPdrhdAEj9UvgaYNfzuKkln2
	 ZJdBJPMX2kV1LobRkqoPlNoKcUGjAm2BKP6qE3aovt8daS/AGgj8bdp+q5VO0kHym/
	 kcXDLmAqmUTBBubmIMsG1Wr+PxFbfuzMkrjPgldR228ZZZ20YAh5VY+gm1vmaUuxdN
	 ECyjj5pJiAXVy6PeESs/5e1vmgwOPKOVv90iSTJs9H6zMZGk+ywFSDw3mn3LteNR7p
	 dEhHD4j5mM0yA==
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 26 Jan 2025 18:30:09 +0200
Message-Id: <D7C5BT3H2UW1.1FE9LG8GKH51U@kernel.org>
Cc: <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <linux-integrity@vger.kernel.org>
Subject: Re: [PATCH v3] selftests: tpm2: create a dedicated .gitignore
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Khaled Elnaggar" <khaledelnaggarlinux@gmail.com>, <shuah@kernel.org>,
 <peterhuewe@gmx.de>, <jgg@ziepe.ca>
X-Mailer: aerc 0.18.2
References: <20250122065021.91814-1-khaledelnaggarlinux@gmail.com>
 <20250126142250.839019-1-khaledelnaggarlinux@gmail.com>
In-Reply-To: <20250126142250.839019-1-khaledelnaggarlinux@gmail.com>

On Sun Jan 26, 2025 at 4:22 PM EET, Khaled Elnaggar wrote:
> The tpm2 selftests produce two logs: SpaceTest.log and
> AsyncTest.log. Only SpaceTest.log was listed in selftests/.gitignore,
> while AsyncTest.log remained untracked.
>
> This change creates a dedicated .gitignore in the tpm2/ directory to
> manage these entries, keeping tpm2-specific patterns isolated from
> parent .gitignore.
>
> Signed-off-by: Khaled Elnaggar <khaledelnaggarlinux@gmail.com>
> ---
> Hello, please let me if you have comments on anything.
>
> Thanks,
> Khaled
>
> Changes:
> v3: Improve commit message
> v2: Created a dedicated .gitignore
> v1: https://lore.kernel.org/linux-kselftest/20250116085929.313677-1-eng.k=
haled.elnaggar@gmail.com
> ---
>  tools/testing/selftests/.gitignore      | 1 -
>  tools/testing/selftests/tpm2/.gitignore | 4 ++++
>  2 files changed, 4 insertions(+), 1 deletion(-)
>  create mode 100644 tools/testing/selftests/tpm2/.gitignore
>
> diff --git a/tools/testing/selftests/.gitignore b/tools/testing/selftests=
/.gitignore
> index cb24124ac5b9..674aaa02e396 100644
> --- a/tools/testing/selftests/.gitignore
> +++ b/tools/testing/selftests/.gitignore
> @@ -4,7 +4,6 @@ gpiogpio-hammer
>  gpioinclude/
>  gpiolsgpio
>  kselftest_install/
> -tpm2/SpaceTest.log
>
>  # Python bytecode and cache
>  __pycache__/
> diff --git a/tools/testing/selftests/tpm2/.gitignore b/tools/testing/self=
tests/tpm2/.gitignore
> new file mode 100644
> index 000000000000..917fe0065467
> --- /dev/null
> +++ b/tools/testing/selftests/tpm2/.gitignore
> @@ -0,0 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +tpm2/AsyncTest.log
> +tpm2/SpaceTest.log
> +
> --
> 2.45.2


Acked-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko

