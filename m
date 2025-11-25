Return-Path: <linux-kselftest+bounces-46450-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3120EC85CAF
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Nov 2025 16:36:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DE4E44E1D5C
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Nov 2025 15:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26C2B1E98EF;
	Tue, 25 Nov 2025 15:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EPyJ7KDV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6034A95E;
	Tue, 25 Nov 2025 15:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764084971; cv=none; b=UQR+g++R/lIjO2EtgqJGKdHjP9LpmzjBfegmFo4DS/L/yOEoQ+grKKHYBHpxIDkRe5tpi0ZBKniiSvdXRnPWMF5yDl8SHWZ7tTGBnqnx6+bhCMzEaC3CelT/P7Pm/eMPenPkHnD8NO0yIZEE4TdLtbhLfOMA1i57emX8SlxGOEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764084971; c=relaxed/simple;
	bh=+iQMCCWUnk6L/0bLx1glIiUO0IiAiLhNwECj2xiRFg4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XidO5vgfNTpBLd0TIfMdOe93lR8HL7p1v1QxI/rhNKHCrKJ+e3Gyl5+CWiGYNSytSfdkdqfkGzGlbNdAvHIKBQC0vu4JcnozPP2Sob4r9UpMSS1nNtuHFV1o054M7cPODEUAjQ5doMcALKwqQ2BP+YcmMZSyb1HrMdG3HnA0BxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EPyJ7KDV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03492C4CEF1;
	Tue, 25 Nov 2025 15:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764084970;
	bh=+iQMCCWUnk6L/0bLx1glIiUO0IiAiLhNwECj2xiRFg4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EPyJ7KDVNbv/fchCG5MbpgoOlQcM/fnHx3L5dYjGuzY4E8XMy7fshvrtWX8HgzW1K
	 7rwGAl1cnyl1V26Wv5ut+TXl6iKwbBL+EtohjUqtySqLjAMlK+AkP6auNt6wA3Yu7q
	 fCkFJlYXNb5nyqz56Dh/W5fNYngMyedKCII2t05F3oVRREfwPDaCdYDKCkkM71/x5W
	 WC215t+/r3+X2OSrZdCCH5pnCYrdQJNt4w0bjjurbtF7ytDmp9sYJkmvUV/6rcBKmk
	 8PV35P60sapSJWv1zTTCybrMOknVkzAT9jnh7wHp+0SLyhDcgTnu0pGMfODI1HJP+T
	 JrlUYUEbUgdTw==
Date: Tue, 25 Nov 2025 17:36:06 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Maurice Hieronymus <mhi@mailbox.org>
Cc: peterhuewe@gmx.de, linux-integrity@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests: tpm2: Fix ill defined assertions
Message-ID: <aSXM5l47FCN81gan@kernel.org>
References: <20251123111809.24634-1-mhi@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251123111809.24634-1-mhi@mailbox.org>

On Sun, Nov 23, 2025 at 12:18:09PM +0100, Maurice Hieronymus wrote:
> Remove parentheses around assert statements in Python. With parentheses,
> assert always evaluates to True, making the checks ineffective.
> 
> Signed-off-by: Maurice Hieronymus <mhi@mailbox.org>
> ---
>  tools/testing/selftests/tpm2/tpm2.py | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/tpm2/tpm2.py b/tools/testing/selftests/tpm2/tpm2.py
> index bba8cb54548e..3d130c30bc7c 100644
> --- a/tools/testing/selftests/tpm2/tpm2.py
> +++ b/tools/testing/selftests/tpm2/tpm2.py
> @@ -437,7 +437,7 @@ class Client:
>  
>      def extend_pcr(self, i, dig, bank_alg = TPM2_ALG_SHA1):
>          ds = get_digest_size(bank_alg)
> -        assert(ds == len(dig))
> +        assert ds == len(dig)
>  
>          auth_cmd = AuthCommand()
>  
> @@ -589,7 +589,7 @@ class Client:
>      def seal(self, parent_key, data, auth_value, policy_dig,
>               name_alg = TPM2_ALG_SHA1):
>          ds = get_digest_size(name_alg)
> -        assert(not policy_dig or ds == len(policy_dig))
> +        assert not policy_dig or ds == len(policy_dig)
>  
>          attributes = 0
>          if not policy_dig:
> 
> base-commit: 821e6e2a328bb907d40f8d1141d8b6c079aa7340
> -- 
> 2.50.1
> 


Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko

