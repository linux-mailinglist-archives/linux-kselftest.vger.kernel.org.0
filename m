Return-Path: <linux-kselftest+bounces-41597-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 60875B59827
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Sep 2025 15:50:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 105E17A22EA
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Sep 2025 13:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E18132A83F;
	Tue, 16 Sep 2025 13:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hcBMMuQU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F19E311953;
	Tue, 16 Sep 2025 13:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758030502; cv=none; b=CSx3uVRaCBDz5hyVazfUZHAUXh+Xn3EPnUklHX03nSpeKzCSfLGmuGSNcxSX4waRH/+aDWfeLGxw8ZausDM1mXy6bUXycRmxIg/boAG5cmebylmnIno5zcGHn1fAjctWdAjDdkaazKmVo9YqiRs1vvw2/9B3e9I7KCF6zzpu2Hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758030502; c=relaxed/simple;
	bh=c8b0OR//SMMq1ThQp6loSE22A0EQw1mgk9q9pgcdyao=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=FZWrvgAYPPnFMDoluPv+qnaxOscsTuYYfq0RD+9daasuR7foU0qYbky34CQloOmr9HKVqbwXFitpJHkLPLzWmub5yACfjNNSfOUj4nV2QMjJvBQuvnoT2V3EMTmBSLQOBGv94MAwD7vdbvJKMDgxZqkBvymSwy62RX4indJlNqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hcBMMuQU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87BC8C4CEEB;
	Tue, 16 Sep 2025 13:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758030501;
	bh=c8b0OR//SMMq1ThQp6loSE22A0EQw1mgk9q9pgcdyao=;
	h=Date:From:To:Cc:Subject:From;
	b=hcBMMuQUoh6IVqSxopFyOP5+u+nCbOtRScuk8Q+GNGEBKHec4C+ZsvhBNy9DDfFg4
	 lF9rK9JWVCq65pOKJVD/rjoxqGwmhWFOZb6SH7+DsTwL4lEdKIsqbKCswVmR1djB5h
	 uqxF+kVZWJR2sRJqvsUW6rODxdnBaazXEYmHRGJoY2sVF/SKgnsaoNwkzWdaO0HJYW
	 GtH5TdTXGr7BLdtU+m6bQ3AF+ojWf5GhaK55iyWthNhm26i0IkmP18lbQ0lCdLFklI
	 sx/FHWLaYVAsEZcVBFLvaiZqNOtlTJmljyWyrFu8UXbLZsI6NpA2ta+dsjRsriG3Pi
	 Lwt8GdHUtigJw==
Date: Tue, 16 Sep 2025 16:48:18 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>
Cc: linux-integrity@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: kselftest and cargo
Message-ID: <aMlqouOSU8XN7V5H@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

The pre-existing kselftest for TPM2 is derived works of my earlier Python
based rudimentary TPM2 stack called 'tpm2-scripts'.

In order to get more coverage and more mainintainable and extensible test
suite I'd like to eventually rewrite the tests with bash and tpm2sh, which
is a TPM2 cli written with Rust and based on my new TPM2 stack [1] [2].

Given linux-rust work, would it be acceptable to require cargo to install
a runner for kselftest? I'm finishing off now 0.11 version of the tool,
which will take some time (versions before that are honestly quite bad,
don't try them) but after that this would be something I'd like to
put together.

NOTE: while tpm2-protocol itself is Apache/MIT, tpm2sh is GPL3 licensed
command-line program (for what it is worth).

[1] https://github.com/puavo-org/tpm2sh
[2] https://git.kernel.org/pub/scm/linux/kernel/git/jarkko/tpm2-protocol.git/about/

BR, Jarkko



