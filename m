Return-Path: <linux-kselftest+bounces-44151-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CE118C12011
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Oct 2025 00:25:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 405524FD1A6
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Oct 2025 23:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 585AE332EB7;
	Mon, 27 Oct 2025 23:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lkNM3vyb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26829332EAD;
	Mon, 27 Oct 2025 23:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761607367; cv=none; b=tMustF73gS92WwMpMYgvb+ulO4uazI/FG35qdJJZ3gK2SxzBRhF32CdJQOxCTZ06rymhO97o8hkitmYJPgZ6LIvqCcQSUh5osJ95pw4PEemKAw2AsObYBhC3FITUmNVS98IHo3p/A7G8S1wH+nPknLHfflSNKLRMT6J8Yp2rvBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761607367; c=relaxed/simple;
	bh=ZWxyQz5K6dbJDOK535AKreA5DglUpUVB45lZid+YI4o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KZwMAOX5428LA7acfa/T/nVF5osX8Wia1wXgmpg3IcZzD07exEUwx4tyXVOU0gxFCA2GSsAtvDC81hDzgwm18yamTg+W5uSQ9O+i07ObUeGT1jH6qRu5nYS/K21KkhSm/NeeWreHVIxRq+EpC7JM+eL78f5amlKTvWboeHA9PWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lkNM3vyb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34EE9C116D0;
	Mon, 27 Oct 2025 23:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761607365;
	bh=ZWxyQz5K6dbJDOK535AKreA5DglUpUVB45lZid+YI4o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lkNM3vybzlx7ssdfIjtUQg23Lj69ZBSDOwBrwb8AMgD+M9gGE+MuwJtqLMuCXpFT+
	 EFPBkm2fYSORLAX9UhuNYc8P0Vwds4HNQBUnkgSclPp00BwuD+iG7JL/BnsoRg/tD8
	 Hzdyz6zUujimZTBsjIyUfxD99u8RNwdNnk60ydj5CK5+nLSOHu2JMCfHkHwft7BxDH
	 QGdW30O8WI0CS3d/AYCnltylKtjzcc78PWbYmEhzoVaK21+omv8YAcgPpL21244TBS
	 tNyUlpZ/BIahTr6xuVYMzgxZYkXsgbDLarKDfgJWbQFfSFlQPX9ePf0/ZlegDKva2Z
	 DsCIVbfdnVQyw==
Date: Mon, 27 Oct 2025 16:22:44 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Simon Horman <horms@kernel.org>, Stefano Garzarella
 <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>,
 virtualization@lists.linux.dev, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, Bobby
 Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next 03/12] selftests/vsock: reuse logic for
 vsock_test through wrapper functions
Message-ID: <20251027162244.0101a099@kernel.org>
In-Reply-To: <aP/DQLcX9uaY6kXN@devvm11784.nha0.facebook.com>
References: <20251022-vsock-selftests-fixes-and-improvements-v1-0-edeb179d6463@meta.com>
	<20251022-vsock-selftests-fixes-and-improvements-v1-3-edeb179d6463@meta.com>
	<aP-kmqhvo4AFv1qm@horms.kernel.org>
	<aP+zgF7zF9T3ovuS@devvm11784.nha0.facebook.com>
	<aP/DQLcX9uaY6kXN@devvm11784.nha0.facebook.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 27 Oct 2025 12:08:48 -0700 Bobby Eshleman wrote:
> > > shellcheck has some (new) things to say about this patch too.
> > > Could you take a look over them?
> 
> It looks like the errors are SC2317 and SC2119, but are false-positives.
> Invoking a program as a variable (e.g., "${VSOCK_TEST}") is tripping
> SC2317 (command unreachable), and SC2119 is due to log_{guest,host}()
> being passed zero arguments (logging its stdin instead).
> 
> I also see that SC2317 has many other false positives elsewhere in the
> file (80+), reporting even lines like `rm "${QEMU_PIDFILE}"` as
> unreachable. I wonder if we should add a patch to this series to disable
> this check at the file-level?

Yes, FWIW, don't hesitate to disable things at the file level.
We should probably revisit which of the checks need to be disabled
globally. But file level is also useful for manual testing.

