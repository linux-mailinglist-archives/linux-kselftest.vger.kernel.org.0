Return-Path: <linux-kselftest+bounces-22809-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F5B09E3249
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Dec 2024 04:51:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02C14B225FE
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Dec 2024 03:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0536314A4E9;
	Wed,  4 Dec 2024 03:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VTGybN7h"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE42317BA1;
	Wed,  4 Dec 2024 03:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733284290; cv=none; b=lI9MckT0DMZb5Ag6cpG95VFA+bEJM3r2VWWZCxDDr4WxqUCINGEHRgUEeeJsk1eaLyIqNYDL5zXJTr2Sq7zJ29sHSClMBrYKQTqChdmI3CG8EizrzUianiTU0wrgb+3HbdGwCgObnLMPT9w8o2cOa10wWD0/MXpdh4mVkEmjawQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733284290; c=relaxed/simple;
	bh=bkl1fC1asdNySiWZpwGEDHKtEKnC7uWcPKi06Qhd4pw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pabh9wBAKAxbjzXdvrfrV8kt+xeEoA8XQWnMCgcIyB+cXvx3UdKSK9fdyDrblAM7jBv8UxRgnVVKDkB60HgFpdbM1NJJuvUKrq9PiOKbNPcSZJJ/scvgGV6JXfiSrobkkU9ASmDAgO5+N5delbS6AFfeOujAEq58GsMQZKyhCmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VTGybN7h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8966C4CED1;
	Wed,  4 Dec 2024 03:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733284290;
	bh=bkl1fC1asdNySiWZpwGEDHKtEKnC7uWcPKi06Qhd4pw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VTGybN7huQju9hzuBIgw7miuofMsj6QHx2Wb93mWNe27HTY5EsOAamNaOR9x8lS37
	 rhu0Q8PlqWujhCl6mwHAVPLL2vIVqzHmHOuuF0i7QQUdLaw6/mW7JIQnJIIasg7eRw
	 QytdcjR8Bg2sVzggbkWNEDJ2/exzmzyp69EdPDrAnQmdE6BXhwVagMuYhvLtKSfjjK
	 SLZgZF+FsHZyfI1SngSonZxlvEqTasQAjYgpy6vn1E/7sEI1CG4rxricqFaAkfX/cO
	 6jBTbkI70dJQ9xRzqP7/03S63SJIdRA+xPOQLINWuxqy2blrg3X/06if4FwexnKwFF
	 XPK6doEsrLIlw==
Date: Tue, 3 Dec 2024 19:51:29 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, Vadim Fedorenko <vfedorenko@novek.ru>, Frantisek
 Krenzelok <fkrenzel@redhat.com>, Kuniyuki Iwashima <kuniyu@amazon.com>,
 Apoorv Kothari <apoorvko@amazon.com>, Boris Pismenny <borisp@nvidia.com>,
 John Fastabend <john.fastabend@gmail.com>, Shuah Khan <shuah@kernel.org>,
 linux-kselftest@vger.kernel.org, Gal Pressman <gal@nvidia.com>, Marcel
 Holtmann <marcel@holtmann.org>, Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net-next v4 4/6] docs: tls: document TLS1.3 key updates
Message-ID: <20241203195129.25e07e53@kernel.org>
In-Reply-To: <6baaaaf467845c56d7ec47250aaa2138de948003.1731597571.git.sd@queasysnail.net>
References: <cover.1731597571.git.sd@queasysnail.net>
	<6baaaaf467845c56d7ec47250aaa2138de948003.1731597571.git.sd@queasysnail.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 14 Nov 2024 16:50:51 +0100 Sabrina Dubroca wrote:
> +To prevent attempting to decrypt incoming records using the wrong key,
> +decryption will be paused when a KeyUpdate message is received by the
> +kernel, until the new key has been provided using the TLS_RX socket
> +option. Any read occurring after the KeyUpdate has been read and
> +before the new key is provided will fail with EKEYEXPIRED. Poll()'ing
> +the socket will also sleep until the new key is provided. There is no
> +pausing on the transmit side.

Thanks for the doc update, very useful. I'm not a socket expert so dunno
if suppressing POLLIN is the right thing to do. But a nit on the
phrasing - I'd say "poll() will not report any events from the socket
until.." ? Could be just me but sleep is a second order effect.

