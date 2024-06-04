Return-Path: <linux-kselftest+bounces-11203-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6FA58FB33F
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Jun 2024 15:15:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0360B1C228CE
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Jun 2024 13:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D261146A62;
	Tue,  4 Jun 2024 13:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bl4zO631"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB502146016;
	Tue,  4 Jun 2024 13:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717506899; cv=none; b=PpYKbDwXQKfRaRhI7xk02NQ6sS6eyW/sr+VdQ6npg0snHJ+mIVehEir0sHPspuD/0JwfiWoKN86ppnCeR536Y4ikAxlOQY3Tmsn7W1T/L9onMRh+65ryot+iaAFUaaNICsMF3C7qiHqGnQ+p9BNt1z1W/A1C2aIKj0FnWetqDqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717506899; c=relaxed/simple;
	bh=OE4saAuELWugESCc+U2+rPB+AbB3NFl9UxVwjKH6csE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sb4neHG4oXhqaZ0Odmv+WWzUGuEKxKWzbZoUYOKM+I69sn4l5xEIe4SDELC8TrME5RUp8Bm0j0h5k9ToCKXR7AyyURQ+x6owdBN2acBPO086VUTMaWfMj80a+veVAYGj5A4OACsZsBxzlKrPlObipy1wXkZnE4SP0gZdKW9hHuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bl4zO631; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6783C2BBFC;
	Tue,  4 Jun 2024 13:14:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717506898;
	bh=OE4saAuELWugESCc+U2+rPB+AbB3NFl9UxVwjKH6csE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bl4zO631XFuKkKm+uT8b4uFOHoHB13GN2UC+mFmCxBvMWEOCr9aEGlRF+tjl5SBMq
	 tXE1mpsGD60VZz+SvYn5WbjLciRCnjW+i+zFyWvgX2ucsLMtToUP36wBart1gOWLTh
	 d5N3q/u3blB0uWbxCsbis4GUP77TxVo5GgxUC210mO1VQl2jJKM7k7AtI26RVDReVU
	 pStQPdgaBvikaXDnuTQQ15VZLxQ8mfaiQ0Q0pS9Q/A+lA4t8wLUMWQJnRIgCj4qJpF
	 +ODO4WGx7A52mQmzThYZQxujfs5YtaFSGUH573yEZMuqmUTs7Sr2QbfYgoEuc3k80W
	 f0AvGBsA6/nbg==
Date: Tue, 4 Jun 2024 14:14:51 +0100
From: Mark Brown <broonie@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: John Hubbard <jhubbard@nvidia.com>, Shuah Khan <shuah@kernel.org>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>,
	Beau Belgrave <beaub@linux.microsoft.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Naresh Kamboju <naresh.kamboju@linaro.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Bill Wendling <morbo@google.com>, sunliming <sunliming@kylinos.cn>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Valentin Obst <kernel@valentinobst.de>,
	linux-kselftest@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>, llvm@lists.linux.dev,
	Ryan Roberts <ryan.roberts@arm.com>
Subject: Re: [PATCH v2 1/2] selftests/lib.mk: handle both LLVM=1 and CC=clang
 builds
Message-ID: <720aa2c5-5cc0-4021-ae0e-8fc4a78995e3@sirena.org.uk>
References: <20240531183751.100541-1-jhubbard@nvidia.com>
 <20240531183751.100541-2-jhubbard@nvidia.com>
 <306eebf8-bb5d-4e1a-9fa3-ad3f4ea11b9c@sirena.org.uk>
 <20240603224706.GA245774@thelio-3990X>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Czvh9zDO7UJp9RNF"
Content-Disposition: inline
In-Reply-To: <20240603224706.GA245774@thelio-3990X>
X-Cookie: Is it clean in other dimensions?


--Czvh9zDO7UJp9RNF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 03, 2024 at 03:47:06PM -0700, Nathan Chancellor wrote:
> On Mon, Jun 03, 2024 at 04:32:30PM +0100, Mark Brown wrote:

> > ICBW but I believe there are still some architectures with clang but not
> > lld support where there's a use case for using CC=clang.

> Does CC=clang even work for the selftests? lib.mk here uses 'CC :=' so
> won't CC=clang get overridden to CC=$(CROSS_COMPILE)gcc?

No idea, it's not a configuration I'm interested in myself.

--Czvh9zDO7UJp9RNF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZfE0sACgkQJNaLcl1U
h9BiTwf/aqeENJmdBeAWWPhMRKY1YW39uwcdusyhYZ53o47QTHVkbDIAYhuRspO2
CWolKkBg3xMKc8tKtpRvChHaTli5n3at69kRGjDYtyGp0Bvo1sekQhqJ7MicbE/8
2zh6LqLpKjN6a8a9DlkhyFh6lkhLh4+/kOS2O1zEcUZyftK03EvbtSOtY94uN1xp
G8bbwu1tps4iKuPbTTrAa+zkbP9t7Zbuio1bDMPXuEGPpevzmRlXD62pXOtk/JgY
sbDfwKd2VBa05yDTHWnWj4aQCBuCMm88eLki2Ytdo8h0XaAQFf8/AnrVBPRyamoi
Z/RA5udP5eYkRRe/LqsG9MTzx9QS0Q==
=sDhS
-----END PGP SIGNATURE-----

--Czvh9zDO7UJp9RNF--

