Return-Path: <linux-kselftest+bounces-3514-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2592C83B8BC
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jan 2024 05:46:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D4691C23A18
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jan 2024 04:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 685767489;
	Thu, 25 Jan 2024 04:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y7Qnn/TE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 351435C9A;
	Thu, 25 Jan 2024 04:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706157975; cv=none; b=seJo5dJdeHWF/lXzhLU+79ApwIB56+R+dIHFErRBVFtQJvi5z/SNGD/frQgT/ZNfSnANPdUbZ8/hgHePQsc/Lu/+/YvdRC9F3nAei83pDIMij55HE6Ad+XsleskdtiLYn1NwS617okejELpqurzqUHin3vsI1yhELrph/GcnsrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706157975; c=relaxed/simple;
	bh=afcdbMWCY3eiWfPY0mb5JQNRODS7wAD1Xr74pJ57Yg0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UZjiFdB1C0gdN7swwPGnxBp9G60CAKoap6yGqyFTeAGNYJQXVqpXUZeh+HRpi0f6288KCPjbebqh2NpwEYXWpD6dC5H+h10fqgYRWnn0qc1Kv0Lfh8uEs5CKP40+pHbEQQZ9Nl8PSl48wUpwqeX5DUe6Knop1oYWIy167nLXGAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y7Qnn/TE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43DB4C433C7;
	Thu, 25 Jan 2024 04:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706157974;
	bh=afcdbMWCY3eiWfPY0mb5JQNRODS7wAD1Xr74pJ57Yg0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Y7Qnn/TESDf+xaJoWsAeBideYGSbmHr0wpovbhSqPdResbShIs8ehe1oURjSU+Wh7
	 TgH5U+xisGL+tSJ7VpE6Jv9zBZrORuExpKw1uDsdxD+amaZ8DBlHreG38LpFdHzpWz
	 r98hX1qpZx3J+sDoETMbIrx8uNF9pQSwjkrdX3sjqi+QEzKmVk1ZGJmJ8eiPPF5MmB
	 e82UrSztqqdFhpFU4oiCNNPoR+N5XE+kQ4C3lSXe5Z3pUT6+1/rjY1waGhAQ6I8g7F
	 8pH4fcksxRZ6upFm9+hYAWkzmACymbMAYzKXjTV2yp29oDDi8jX3J3Kx8yOgS2aN5H
	 4oAWn7lUphhyg==
Date: Wed, 24 Jan 2024 20:46:12 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Benjamin Poirier <bpoirier@nvidia.com>
Cc: netdev@vger.kernel.org, Shuah Khan <shuah@kernel.org>, Jonathan Corbet
 <corbet@lwn.net>, Jay Vosburgh <j.vosburgh@gmail.com>, Andy Gospodarek
 <andy@greyhouse.net>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli
 <f.fainelli@gmail.com>, Vladimir Oltean <olteanv@gmail.com>, Jiri Pirko
 <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Petr Machata
 <petrm@nvidia.com>, Danielle Ratson <danieller@nvidia.com>, Nikolay
 Aleksandrov <razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>,
 Johannes Nixdorf <jnixdorf-oss@avm.de>, Davide Caratti
 <dcaratti@redhat.com>, Tobias Waldekranz <tobias@waldekranz.com>, Zahari
 Doychev <zdoychev@maxlinear.com>, Hangbin Liu <liuhangbin@gmail.com>,
 linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH net-next 1/6] selftests: Introduce Makefile variable to
 list shared bash scripts
Message-ID: <20240124204612.4c688095@kernel.org>
In-Reply-To: <20240124170222.261664-2-bpoirier@nvidia.com>
References: <20240124170222.261664-1-bpoirier@nvidia.com>
	<20240124170222.261664-2-bpoirier@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 24 Jan 2024 12:02:17 -0500 Benjamin Poirier wrote:
> --- a/Documentation/dev-tools/kselftest.rst
> +++ b/Documentation/dev-tools/kselftest.rst
> @@ -255,9 +255,19 @@ Contributing new tests (details)
>  
>     TEST_PROGS_EXTENDED, TEST_GEN_PROGS_EXTENDED mean it is the
>     executable which is not tested by default.
> +
>     TEST_FILES, TEST_GEN_FILES mean it is the file which is used by
>     test.
>  
> +   TEST_INCLUDES is similar to TEST_FILES, it lists files which should be
> +   included when exporting or installing the tests, with the following
> +   differences:
> +   * symlinks to files in other directories are preserved
> +   * the part of paths below tools/testing/selftests/ is preserved when copying
> +     the files to the output directory
> +   TEST_INCLUDES is meant to list dependencies located in other directories of
> +   the selftests hierarchy.
> +

I think that this chunk causes a warning when doing make htmldocs:

Documentation/dev-tools/kselftest.rst:267: WARNING: Unexpected indentation.
Documentation/dev-tools/kselftest.rst:268: WARNING: Block quote ends without a blank line; unexpected unindent.

Could you double-check?

