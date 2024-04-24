Return-Path: <linux-kselftest+bounces-8741-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D69818AFE0D
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Apr 2024 03:53:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14CCD1C22C35
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Apr 2024 01:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C827BBE58;
	Wed, 24 Apr 2024 01:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W+ybrxRg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F0A14A1A;
	Wed, 24 Apr 2024 01:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713923586; cv=none; b=PUiIf4jf0vMAoAzon1MM5XzG3t7JJyaYFGpEwJRDJpX7QXCLzX/A3mJ+8v5oSabEo292Rm6KrO4N+pkD+Uj1Wz76ZMyDByKhHca/0R3rbhvz/kONDr0KSURWU46w0DDSSsm5YZpD37SL41TtCqiW42uTja0w1S3wD1snJ+1ena8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713923586; c=relaxed/simple;
	bh=j6fwoufWyubhgfGZXhJ9Mq2Hnq2LyI0WyRdiRqwhbWo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X3SuUM9Ip6Rz2xbySzMh8U4U1oDWZ+kVcYMm682FtVfnKGGHBVXiyv35IPMjct3+dh79fcY23kQUdjevJ9SfZlQXI+8ASHOBCzmgzgAEm9Q6QKy9YWNppHudKo/qaenBFkucVzhGkqYKi3erziURYHICLmewsDWuSrHFugLiZMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W+ybrxRg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E70A5C116B1;
	Wed, 24 Apr 2024 01:53:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713923586;
	bh=j6fwoufWyubhgfGZXhJ9Mq2Hnq2LyI0WyRdiRqwhbWo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=W+ybrxRgotGBi8j4TT7TRYoVLOy+uWtcrHJaCxtOIEBKFnHLooWK7RKfcTlKRTPmD
	 owUQoft90MXXRo8sj7HewnFfW9w+NX87w1LpNuDTSNMIjfY+zaLrhR5BSfC12ar0o5
	 fjnrUUMrJocPFre0NIW+rE9zmG64vniOWctXMMibCQwtGs2OaRj6gIAZpnaz+rm2Dd
	 rTXww/DCmZRA3v1UnObLN6zvfFW6GclSVIuFYgcUTcRGeW6J5gwACw7gZgGXOOpJWf
	 gDD31FCrxeUVvPg3qLQYzduXxcPPMHroZM9iSqI9+DDhIs/12p0tTrCt/oHgJCnyql
	 UpwjwhH6dkvEA==
Date: Tue, 23 Apr 2024 18:53:05 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, shuah@kernel.org, petrm@nvidia.com,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v5 0/7] selftests: drv-net: support testing
 with a remote system
Message-ID: <20240423185305.15fca2b7@kernel.org>
In-Reply-To: <6627f699278fe_1759e9294e3@willemb.c.googlers.com.notmuch>
References: <20240420025237.3309296-1-kuba@kernel.org>
	<662526f58a70c_1dff9929430@willemb.c.googlers.com.notmuch>
	<6627f699278fe_1759e9294e3@willemb.c.googlers.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 23 Apr 2024 13:57:45 -0400 Willem de Bruijn wrote:
> Only possible non-obvious observation is that some kselftests expect
> as root, and the ssh remote logic extends that to expecting ssh
> root access to the remote host.
> 
> Would it make sense to explicitly add sudo for all privileged
> operations, to allow for non-root ssh and scp?

I haven't thought about this part much, TBH. I'm not aware of any
scheme used in other tests.
IIUC the problem is that we need root locally, and then try to SSH
over to remote. But normally the SSH keys belong to the non-root
user, so SSH'ing as root is annoying?

