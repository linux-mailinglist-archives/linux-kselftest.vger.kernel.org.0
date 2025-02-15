Return-Path: <linux-kselftest+bounces-26704-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D47D1A36BF4
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Feb 2025 05:11:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32EF53A82DD
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Feb 2025 04:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A11E818950A;
	Sat, 15 Feb 2025 04:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gvp2Ukzw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC5821345;
	Sat, 15 Feb 2025 04:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739592707; cv=none; b=DnARY+RAMJNWUuSSEjgmbGC4esGuzq75pl24YIoe7j+YL4UrmC/wr/zZ1yM8FG0Rg8ym1a/OEvmWbJZCXf8IIY16c60UClivt3vjEHunhg242kO+tbAMg2pktOmrRiMDS73jCQMxjU2owg003oXhPAt2zbyHXNVuI7wjL/c042w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739592707; c=relaxed/simple;
	bh=J01rv0Vc3764uz0oZ4ZqAFwsv9wb2ZQedlgpcHJ03p8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VxskeHShngKrkGtZbCnoP5vlxpP8+hGFycweFfk1q32989dyVJpzNHdZwgB+XMqg5r0CmqpsJyIRgyanjLaJBI2qkw5PFSUlTce97XsTLHNd33ISCF/EitDWObOAdQmGnBgHufH16GSS1hKxcAmvcCmZOnI6J4aCa+OI1/TiO0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gvp2Ukzw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6632AC4CEE4;
	Sat, 15 Feb 2025 04:11:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739592706;
	bh=J01rv0Vc3764uz0oZ4ZqAFwsv9wb2ZQedlgpcHJ03p8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Gvp2UkzwzR5C8A9qxtm8/T6+rG0KOQRN4YDjIAG0tn25BG/s39lq6qAfdOsElPKlR
	 oYJDEi7WEUVL98U/3Pn/ls6MYzG4RoecWvw+iJKc6U1wASWV4CcUVlskKQ3EeZgNcc
	 /athIuB7fXF8LvgGTgNM/eV6KqKIRbJKNI6vN7j3yCOpkMDrc00WSddBtkEVEtU//Q
	 IQoIeJKJBPwlPqamiP0uXO4oUdzPQ7m0dLuhsKOmZskhZkHQ7p/ZYjRRyVJ+ITUw/v
	 +JX/vRqS0xDoWgmLkfCiWhRDnenR1sWKyXUZUPAzD6eRbR8/hW2x4xeT+cryS+2fFn
	 V88Km1UDighhA==
Date: Fri, 14 Feb 2025 20:11:45 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Peter Seiderer <ps.report@gmx.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, Artem Chernyshev
 <artem.chernyshev@red-soft.ru>, Nam Cao <namcao@linutronix.de>, Frederic
 Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH net-next v5 8/8] net: pktgen: use defines for the
 various dec/hex number parsing digits lengths
Message-ID: <20250214201145.2f824428@kernel.org>
In-Reply-To: <20250213110025.1436160-9-ps.report@gmx.net>
References: <20250213110025.1436160-1-ps.report@gmx.net>
	<20250213110025.1436160-9-ps.report@gmx.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 13 Feb 2025 12:00:25 +0100 Peter Seiderer wrote:
> Use defines for the various dec/hex number parsing digits lengths
> (hex32_arg/num_arg calls).

I don't understand the value of this patch, TBH.

Example:

+#define HEX_2_DIGITS 2

-		len = hex32_arg(&user_buffer[i], 2, &tmp_value);
+		len = hex32_arg(&user_buffer[i], HEX_2_DIGITS, &tmp_value);

The word hex is already there.
There is still a two.
I don't think the new define has any explanatory power?

Previous 7 patches look ready indeed.
-- 
pw-bot: cr

