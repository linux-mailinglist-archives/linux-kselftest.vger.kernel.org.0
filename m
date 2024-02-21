Return-Path: <linux-kselftest+bounces-5219-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 12A2585E619
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Feb 2024 19:33:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 442A81C20DAF
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Feb 2024 18:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C377E8564D;
	Wed, 21 Feb 2024 18:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nE6kKvoh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD1042A8B;
	Wed, 21 Feb 2024 18:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708540411; cv=none; b=ocliRpG1n1gpfJMuOQYRh59rNe48gm5M4lsrXsETySYkGRa7mwi68fVYMp07v4+qOhB+CvYs9V4BE2ghWDs8sF2EjY27wU0gBTpfGnFWU7L8zAtZmgTveHi2GDgeD0CnzQ6gHhqRKT8tMMDvaVi+EQH/jZR8sC0eYJvw5YgrXa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708540411; c=relaxed/simple;
	bh=WcDm4KjAgiSTUngwOyHdp1cM2Jf76T40wkx+rKaqIoo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Uf3xsukoIvCS0MZmhQAU4u46CL8Dtx7lVbTSYNCgES6PKutPnzYwTy1VII1pCbrPHoMoyuFQlODIzya15woo1AvBBSsQMVRfTuiNBt37XGtCcmRqhTeABV+63NVPbFQDxrb9E9IK1k1fIRFtnFg+TdlKN9Nrlnc8vWm6Pc9WEyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nE6kKvoh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BA67C433C7;
	Wed, 21 Feb 2024 18:33:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708540411;
	bh=WcDm4KjAgiSTUngwOyHdp1cM2Jf76T40wkx+rKaqIoo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nE6kKvohCppY47gE5CVCjMpcKWUJS9f+ojW2TtLPKi9hzhUH0Rr2d7u/+14qgz7yI
	 Q0Cvor7x1Ktk4X63j4bAAyGpW4oNZWDuSMl+xHMXD6YvqfTICp3hIY9MsPqLxCmnH4
	 J+I8EqUg7NxEwSv8x4hIfBqFuVQy86QYA2l/hlBgq4NvBo1plmvsgg7D6o4T5A+iEU
	 apfLRqpeYsmf6RY1D0TIFMrFMFvQVcvR+V+TOb3s462OzO5APQlQuFrIY5Ho8OWJB6
	 pUkSqoSY+UgxOQqFejfasmmxmDjfI/84IqA2GXC3y7eY0W28iT5SFhSgx0SwK/fr4z
	 zUIflmAtX/Sfg==
Date: Wed, 21 Feb 2024 10:33:30 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, Boris Pismenny <borisp@nvidia.com>, John
 Fastabend <john.fastabend@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, Vakul Garg
 <vakul.garg@nxp.com>, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net 3/5] tls: don't skip over different type records
 from the rx_list
Message-ID: <20240221103330.2ae35871@kernel.org>
In-Reply-To: <ZdYBzKcmIorAO47N@hog>
References: <cover.1708007371.git.sd@queasysnail.net>
	<f00c0c0afa080c60f016df1471158c1caf983c34.1708007371.git.sd@queasysnail.net>
	<20240219120703.219ad3b2@kernel.org>
	<ZdPgAjFobWzrg_qY@hog>
	<20240220175053.16324f4d@kernel.org>
	<ZdYBzKcmIorAO47N@hog>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 21 Feb 2024 14:59:40 +0100 Sabrina Dubroca wrote:
> It's not exactly enough, since tls_record_content_type will return 0
> on a content type mismatch. We'll have to translate that into an
> "error". 

Ugh, that's unpleasant.

> I think it would be a bit nicer to set err=1 and then check
> err != 0 in tls_sw_recvmsg (we can document that in a comment above
> process_rx_list) rather than making up a fake errno. See diff [1].
> 
> Or we could swap the 0/1 returns from tls_record_content_type and
> switch the err <= 0 tests to err != 0 after the existing calls, then
> process_rx_list doesn't have a weird special case [2].
> 
> What do you think?

I missed the error = 1 case, sorry. No strong preference, then.
Checking for error = 1 will be as special as the new rx_more
flag. Should I apply this version as is, then?

