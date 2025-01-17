Return-Path: <linux-kselftest+bounces-24691-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DFC4DA147AC
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Jan 2025 02:44:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B1B73A12E9
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Jan 2025 01:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D70338DEC;
	Fri, 17 Jan 2025 01:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YWzdGyik"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF455383;
	Fri, 17 Jan 2025 01:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737078247; cv=none; b=TzhngY5Gt9viSpshxq7/fGdcidsqUvR71fR0IbDs45ilGeB/ydWfSfjbk77/mwTKDqxz8NB6DUPXFCM+eKNmTqbT8TMphvCrCQVYpwr4tU0Yjd62yiwe7ojEuxedLaxPYzKIXSZPIgFb4XKvmdqqWm0B9zPYtMui7wQCcN3kR6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737078247; c=relaxed/simple;
	bh=6xzTH+3aaMXmw8yu6wbcyw5/dNk9bdoOWb2rzNoHKoY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WqmTk2qOA/6xIWmHasJ3rNuq4ke/gClSkHoqITrx0k6wHl17S0sy/KM+6fIEXVfImf1qFd7W3cbu/z8FdrG5eePacHVbkPLYZq+kNZi8Kjnb82QdwhSYuJLR5+E33Wpve767gnHfi7+ruqZy0o/kgj3SGgnz2+uMNGFqs0VUPVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YWzdGyik; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F4089C4CEDF;
	Fri, 17 Jan 2025 01:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737078246;
	bh=6xzTH+3aaMXmw8yu6wbcyw5/dNk9bdoOWb2rzNoHKoY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YWzdGyik5Spa2eoyYAkytpkqA8nyMnxM/v/I19eqJZGkm/iA6I+7LnJCCW6f2m3fo
	 eyPoYdy/f4AM5rQSnNwYoz2sg3cKxJqsOZ7LrUuhrA0/sTTWi8r93bfu9YIoGu6kIL
	 iLGW0cI9zfMCQwQ/zbCaJeTEArjVuCdqXi2pIfWnC+KRsHZkHR+zhCIsWqi/PIWbiS
	 q5BHBxK1o3zL2G8gb/79r9zxD/andz3AaQ9Q2xZqxBPnwYhHzLQJKo7i1HEZdUhzsq
	 xgZdeQMEUUkjwKTvQtcTJb8m9IR+AxYP6RwtuuXsGWYeukpdmyW1nGX1p4ZyaBxSdL
	 UyfVRE56zIvHw==
Date: Thu, 16 Jan 2025 17:44:05 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jonathan Corbet
 <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org, kernel-team@meta.com, max@kutsevol.com,
 thepacketgeek@gmail.com
Subject: Re: [PATCH net-next v2 3/5] netconsole: add support for sysdata and
 CPU population
Message-ID: <20250116174405.20a0e20b@kernel.org>
In-Reply-To: <20250115-netcon_cpu-v2-3-95971b44dc56@debian.org>
References: <20250115-netcon_cpu-v2-0-95971b44dc56@debian.org>
	<20250115-netcon_cpu-v2-3-95971b44dc56@debian.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 15 Jan 2025 05:35:20 -0800 Breno Leitao wrote:
> +	WARN_ON_ONCE(userdata_len + sysdata_len >
> +		     MAX_EXTRADATA_ENTRY_LEN * MAX_EXTRADATA_ITEMS);
> +
> +	/* nt->sysdata_length will be used later to decide if the message
> +	 * needs to be fragmented.
> +	 * userdata_len cannot be used for it, once next sysdata append should
> +	 * start from the same userdata_len location, and only overwrite old
> +	 * sysdata.
> +	 */
> +	nt->sysdata_length = sysdata_len;

Updating nt-> fields at runtime is something we haven't done before,
right? What's the locking? We depend on target_list_lock ?

Looks like previously all the data was on the stack, now we have a mix.
Maybe we can pack all the bits of state into a struct for easier
passing around, but still put it on the stack?

