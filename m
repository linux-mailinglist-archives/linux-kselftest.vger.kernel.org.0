Return-Path: <linux-kselftest+bounces-41598-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 52388B59830
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Sep 2025 15:52:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB4561BC45A4
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Sep 2025 13:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EADCE31D731;
	Tue, 16 Sep 2025 13:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MBNORpU5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF89231B829;
	Tue, 16 Sep 2025 13:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758030735; cv=none; b=UbktfRzoKLLkny1mehwip3iuEVTSQNWwuJh2lcMjTv3bRMsAja4diBKtdeywjEWAv5XcE0UyBdyVQ6UlP32ZxZqRNrn8u6AzRkB77MZlIZGsOTAJFDCQI+2a6wa6WukUPnjsSnnhtroSeHvzEuX3UnvkaU9Q5wnCy+Yhp4etr2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758030735; c=relaxed/simple;
	bh=hWrudklsCy6dWagmcMX7ZBix021VTx20qYWTKbVrbm4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uYGOQbB5YdV/DiMQPvkFpWRmM3Zvid6ZnOFskowaPOe8pQ75xFWgjK1tzsIm5x+swto9vXs7RvNgqr7Ge73lUnT+DIG43d1gSxBAjlZzW5BBHPKjOStpZxPgRDGmiN1iqcbIBkwCuLQ1kiYcC2P/tKResl3J+AgJOE1Zrn0aAb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MBNORpU5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48E1EC4CEFD;
	Tue, 16 Sep 2025 13:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758030735;
	bh=hWrudklsCy6dWagmcMX7ZBix021VTx20qYWTKbVrbm4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MBNORpU5oJDr9jZA7e9pPNLLfaMSw3p0hCpzhZ2hv0nJUKv5QJZpqjv4eQ29SWJHg
	 Dx+OqCEpScqD+iHg0hxQosbBk+FL00ylLy+bzcyU+XnGAFoVlWiUIyQtq7TAncZ/+P
	 /mVGPx+R9tjKLOnIO9tKYn3/BPU48SOTlBqQffut0pugG3QKtKMvUOIJKDOqdipbmc
	 sLGccRPdIYVsdgJpUy3NDynLnMj8dOQY6pLyDDic6KoCPsqSrBgq6nyCdN5P4z0hhv
	 Uj8ETpDdDlDs9la62p0dA3bQDPNNtGkNDO0zIro0CfkaO4OuogKB1HglxYqJ/RtSuo
	 vyHkQCybGNOVQ==
Date: Tue, 16 Sep 2025 16:52:11 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>
Cc: linux-integrity@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: kselftest and cargo
Message-ID: <aMlri8uA2pf3_8M8@kernel.org>
References: <aMlqouOSU8XN7V5H@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMlqouOSU8XN7V5H@kernel.org>

On Tue, Sep 16, 2025 at 04:48:22PM +0300, Jarkko Sakkinen wrote:
> Hi,
> 
> The pre-existing kselftest for TPM2 is derived works of my earlier Python
> based rudimentary TPM2 stack called 'tpm2-scripts'.
> 
> In order to get more coverage and more mainintainable and extensible test
> suite I'd like to eventually rewrite the tests with bash and tpm2sh, which
> is a TPM2 cli written with Rust and based on my new TPM2 stack [1] [2].
> 
> Given linux-rust work, would it be acceptable to require cargo to install
> a runner for kselftest? I'm finishing off now 0.11 version of the tool,
> which will take some time (versions before that are honestly quite bad,
> don't try them) but after that this would be something I'd like to
> put together.
> 
> NOTE: while tpm2-protocol itself is Apache/MIT, tpm2sh is GPL3 licensed
> command-line program (for what it is worth).

Also tpm2-protocol is dependencyless, no crazy corporate TPM2
shenanigans and daemons involved etc., meaning that overall tpm2sh is
quite self-contained and good fit but 8 KSLOC not really to be imported
(the size comes from built-in TPM2 emulator, policy expression language
and advanced import functionality that directly converts PKCS#8 to TPM2
Key ASN.1 DEr/PEM all super useful for all sorts of testing purposes).


> 
> [1] https://github.com/puavo-org/tpm2sh
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/jarkko/tpm2-protocol.git/about/
> 
> BR, Jarkko
> 
> 

