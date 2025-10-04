Return-Path: <linux-kselftest+bounces-42770-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E49F0BB903C
	for <lists+linux-kselftest@lfdr.de>; Sat, 04 Oct 2025 18:48:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4D193BD3AB
	for <lists+linux-kselftest@lfdr.de>; Sat,  4 Oct 2025 16:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5217280312;
	Sat,  4 Oct 2025 16:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FDNZGpON"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D4E27FD7D;
	Sat,  4 Oct 2025 16:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759596514; cv=none; b=mfw1Adz90YXZz1GXitInyrGTNS8bfmkVOGhkU3YT4fhrZ2wffnHhQ8VBc2+ftkEKXoCMNqWW4D2FTBW4QOgsO0Kd2JWdHnnvI0RZ0h8bGB1iqrXqc4EyZlo43wOPLTIUsFdFhWwrzfQgp+etNEXfn8XyyguGdr9IruHzk9XxXfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759596514; c=relaxed/simple;
	bh=yCAZ5oEyih+l6yumTZaIrhzSCG3sqWXUOUxtpLskqbo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O+hJVYNG6i7BMtFvStwpZ/FN06BfyCKpgoIxBEi8bXZYvMpkiWUUrWr4Kkcd9I6hgQBjOMC0B/JW+TeQrVjPmlHEo/ZmDzZXtGDJ2GotifCurU0y0F4CtPC1HDwxL01lbFZsL3lLkg0gzm3Y3KmMFum1TOqXtxpD6g/vXknK44Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FDNZGpON; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C77A5C4CEF1;
	Sat,  4 Oct 2025 16:48:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759596514;
	bh=yCAZ5oEyih+l6yumTZaIrhzSCG3sqWXUOUxtpLskqbo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FDNZGpONqL3UJj6rdeDL/3S9U+3RuCs/LaspBCJxE35pI1gCgl+qF21D8HM7kgqwC
	 QTbm39fIelgWHkj9wcpjMXZQc/KBP9VrtU7ZCIwARvO2VvYudA9tTuWIddyydgUOC6
	 pV4zW3LmCRiXfjDu37KQumUsWlxDFOajXXT4YqgNPdMbUsRUONxzjM6jTakbPlz5ud
	 w2+hwytA+qp3E5UYlPmtSMej0S9FfPabh3nQJclOqFOof1/Zqj7hOe1uUggJwvlVv+
	 NEDKHFtWBd3QosbVlZa9L+aOWHjE0P6nz2j/WixC/FmR/gdlkRqU+iwWw5O8uANTH6
	 mf1gAm1FwK2rg==
Date: Sat, 4 Oct 2025 17:48:29 +0100
From: Simon Horman <horms@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, bpf@vger.kernel.org,
	shuah@kernel.org, johndale@cisco.com,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net 7/9] selftests: drv-net: fix linter warnings in
 pp_alloc_fail
Message-ID: <20251004164829.GL3060232@horms.kernel.org>
References: <20251003233025.1157158-1-kuba@kernel.org>
 <20251003233025.1157158-8-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251003233025.1157158-8-kuba@kernel.org>

On Fri, Oct 03, 2025 at 04:30:23PM -0700, Jakub Kicinski wrote:
> Fix linter warnings, it's a bit hard to check for new ones otherwise.
> 
>   W0311: Bad indentation. Found 16 spaces, expected 12 (bad-indentation)
>   C0114: Missing module docstring (missing-module-docstring)
>   W1514: Using open without explicitly specifying an encoding (unspecified-encoding)
>   C0116: Missing function or method docstring (missing-function-docstring)
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>


