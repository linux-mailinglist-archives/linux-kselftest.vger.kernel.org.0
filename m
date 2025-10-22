Return-Path: <linux-kselftest+bounces-43722-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EA16BF96BF
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Oct 2025 02:01:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CFB93A6F24
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Oct 2025 00:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BF2C9460;
	Wed, 22 Oct 2025 00:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pme7V+h4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27A017D2;
	Wed, 22 Oct 2025 00:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761091310; cv=none; b=JUROphAgUSjJaBu4JYcsoYpP8JiCR4ZoCJ6ty2eJ5mLp358cBbRFteHq4UWeyX+L7cRyCmscApymJJCxkiJovEPmhGsZQOkRUPFftG9siojrkIVa2OsmnP/zSDdc9laa0cGkzrLPKIs3IXCK2O5WBG2uZBCzmFwziR3cXQTqwnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761091310; c=relaxed/simple;
	bh=p+ZizTiGxIaoODfuSopyyeSnYFPc7WE7M0A6WnSxqmE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u4D6ewPeEo0w+gDdVDpwYtsOc19W8ec8CXh6Qogqr3WdIDSkCsF+94zy3L+JqQRRRj9K+BsSGwTTFcgrYwev+f8EsIHEAfN5BrnAPRavNgiRhfzCmqhLuuTCeoII75fNYNofDDmnUz9L9kU7Sdjofcbqr77XsVUay3Enuvrht4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pme7V+h4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49BA4C4CEF1;
	Wed, 22 Oct 2025 00:01:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761091309;
	bh=p+ZizTiGxIaoODfuSopyyeSnYFPc7WE7M0A6WnSxqmE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Pme7V+h4OVfRJg7agdV9osvbp48/KAdTtFv4m7ugnYlgC5tWftPij+MItChJ57SjV
	 7+vRyzH+x4ac7qLh3UVJiDFqn7TAbluRfOWOgCOC4JToXzg8IXAiR5og2hUEI1/CEf
	 kqkEmJ6uNAqhIn4DFo0iBEh0SajTNqk6ThpRxCjDt7IF9wWhMwmvahIi3Yzbd4VTcw
	 GDV/Nd519/dZwYtNrpCBd+GJQ6vl5ZSST8D047hX/uOxLgDCXVM4Nz94I+Kez97U0K
	 vNDOKNWZaJS+21bEFY0HZ57CeeUmRZHMKU4okd21jA65Z454Qy/qmSPHHHqKgxAI+x
	 Z2JSVzIsvys4Q==
Date: Tue, 21 Oct 2025 17:01:47 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>, "Michael S.
 Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Xuan Zhuo
 <xuanzhuo@linux.alibaba.com>, Eugenio =?UTF-8?B?UMOpcmV6?=
 <eperezma@redhat.com>, "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang
 Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui
 <decui@microsoft.com>, Bryan Tan <bryan-bt.tan@broadcom.com>, Vishnu Dasa
 <vishnu.dasa@broadcom.com>, Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, virtualization@lists.linux.dev,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 linux-hyperv@vger.kernel.org, berrange@redhat.com, Bobby Eshleman
 <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v7 08/26] selftests/vsock: improve logging in
 vmtest.sh
Message-ID: <20251021170147.7c0d96b2@kernel.org>
In-Reply-To: <20251021-vsock-vmtest-v7-8-0661b7b6f081@meta.com>
References: <20251021-vsock-vmtest-v7-0-0661b7b6f081@meta.com>
	<20251021-vsock-vmtest-v7-8-0661b7b6f081@meta.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 21 Oct 2025 16:46:51 -0700 Bobby Eshleman wrote:
> Improve usability of logging functions. Remove the test name prefix from
> logging functions so that logging calls can be made deeper into the call
> stack without passing down the test name or setting some global. Teach
> log function to accept a LOG_PREFIX variable to avoid unnecessary
> argument shifting.
> 
> Remove log_setup() and instead use log_host(). The host/guest prefixes
> are useful to show whether a failure happened on the guest or host side,
> but "setup" doesn't really give additional useful information. Since all
> log_setup() calls happen on the host, lets just use log_host() instead.

And this cannot be posted separately / before the rest? I don't think
this series has to be 26 patches long.

I'm dropping this from PW, please try to obey the local customs :(

