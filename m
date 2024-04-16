Return-Path: <linux-kselftest+bounces-8233-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A7238A7988
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Apr 2024 01:59:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31BEE1F24B69
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 23:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02FA413AA5C;
	Tue, 16 Apr 2024 23:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UeFDv8sB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBFE213AA47;
	Tue, 16 Apr 2024 23:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713311921; cv=none; b=lenqbLoekCB1pPwxtTFYO26K5dWTX+v8gt1qUtTht9h9MEjGxrWEpKaVh24uZ75MVdP6qVZkPE5o60uoj1m3OmUdlabTZvkz+enoLeZ0bR1EKUnjj8V6DlpGnU3jO63S8S3akhgbypxEuE1h3PIcM2u+2NPCG1fe5TnrjdbmEyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713311921; c=relaxed/simple;
	bh=pMVjzBecr9lv8HWHk/sAGLbo1rKqnKJr77wFsqpxPS4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iqoSLxwiWoDS4uUfX90MAH1gSev+OiSw6ZMxTiCc5gU/D0MPhY/BHP0uSgnvh9BS8HSZQ4bknVQMhLmSije3CmbReea9eHOvNUJK1kvOMAJTBJWfTryW4rDZZ6DAkZ4sg7uJTwqmHBqG4QLR7phm+Gt6HCob/Gc8VAUOL8sllCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UeFDv8sB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7551C3277B;
	Tue, 16 Apr 2024 23:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713311921;
	bh=pMVjzBecr9lv8HWHk/sAGLbo1rKqnKJr77wFsqpxPS4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UeFDv8sBNBRgCKm/UbuLnBHCGF3ipS/GZphD27VfKlcMLpIzymtQjAwyvaOQv+ATg
	 yhun9zDbDcZhbPkn/+p98Y+Bz2vGElE4vgFKhTo3E1DdfHPmxYL2vxz5o/GvNFvKL1
	 dTbt/xc+Pu8rDo1STWPifpH0UsXrb+lRrPlQcEsvcqsYf/lmmsvnoa4utmiwM1dXKr
	 WrhmQ5wQ/TCsACIFTRsai4LkchGfcW8KMtPLLTQvqjQs8XaheJpV4Vf26vR9y4gu5O
	 mRahiFaZzT42udBLcu7iBrPep9hFHLcn7GAZOI4M5VdCMOmBDFIOGlI1ZvmdZk+LHj
	 lLoBuc9VjuGvQ==
Date: Tue, 16 Apr 2024 16:58:39 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, shuah@kernel.org, petrm@nvidia.com,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v2 0/6] selftests: drv-net: support testing
 with a remote system
Message-ID: <20240416165839.300767d4@kernel.org>
In-Reply-To: <661e941c3e250_5279f29470@willemb.c.googlers.com.notmuch>
References: <20240416004556.1618804-1-kuba@kernel.org>
	<661e941c3e250_5279f29470@willemb.c.googlers.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 16 Apr 2024 11:07:08 -0400 Willem de Bruijn wrote:
> Thanks for humoring the naming suggestions. Exciting to have this infra.

I wrote a couple more tests today and as you predicted already needed
wait_port_listen()...  I also discovered a few sharp edges with the
way the commands are wrapped for the remote host. I'll apply the first
two patches for now, and repost the rest tomorrow/Thu once I gain more
confidence.

