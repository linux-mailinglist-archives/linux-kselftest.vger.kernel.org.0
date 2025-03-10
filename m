Return-Path: <linux-kselftest+bounces-28669-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04628A5A40B
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Mar 2025 20:50:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B02EB3ACA96
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Mar 2025 19:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EABBE1DB14C;
	Mon, 10 Mar 2025 19:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hnm+zr4/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B55961D54EE;
	Mon, 10 Mar 2025 19:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741636212; cv=none; b=UeBxgwhnV0I9H9yApigqBGwYN3+yIvpS32EK+Fce+whMcA1zCA436RmR2fSFN14WHNbD2fYo99tc5pGAX5uoiusK+2Br0945FKG5XmYSm8zlbUzSOcaq/CYYICZiCIgsVJ6kEnIxqkC3Xx4lvBMXtV+KXZdSE9l9+Be4h1M4B+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741636212; c=relaxed/simple;
	bh=Mou4XIMPQe6vHlHG+JrTUtYI9XNrbgd6UlwNdDedTzk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aKKlEvwuwR7Suw30Uc/ZFxSrGMBuETBlyOC7+e2AcHePLoYtJAjOLFwMgJuvkdJQiWucK1R8gBQgfSHxnAn3/WU8iVHEQzJNmbRsOwpWeQEz+EB3jGrA4rk/HUyvjFBDin5WsRoGQNLs8H/ikBhZfda2v8+ucFS6koQiaOEJbRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hnm+zr4/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E9EFC4CEE5;
	Mon, 10 Mar 2025 19:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741636212;
	bh=Mou4XIMPQe6vHlHG+JrTUtYI9XNrbgd6UlwNdDedTzk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Hnm+zr4/m3zduyUKRxvtfx7++ozizMMInZkFL4FbsuA/zoNhFQCPvPkjHBC4pklZG
	 ARhEc0tWMLm7GBNzcbfXv+IJYDVyxKO/hnc6rzbWczoWK8RA52h4t0jjDJu73EvIKl
	 j3ELzk1Pmc8yeoYi+4GFz30GXqy6XezkyP/yyUywJBvi29ntbHPVs9sV7EDveaugOv
	 gNpsPjz4MIqTazKz2stXuTM6ZqFWHZWXGwce+NOSulC6uEzYEDavQe2ylSGrW6JtLC
	 MBM7xRlex3ik0sGrzH0WifYHeJ8IB1LMpUoziAoESjk2WXagfga/N4SGQwMYXajnwL
	 PB21cqlrrVnFg==
Date: Mon, 10 Mar 2025 20:50:00 +0100
From: Jakub Kicinski <kuba@kernel.org>
To: Lei Yang <leiyang@redhat.com>
Cc: Mina Almasry <almasrymina@google.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 kvm@vger.kernel.org, virtualization@lists.linux.dev,
 linux-kselftest@vger.kernel.org, Donald Hunter <donald.hunter@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Jeroen de Borst <jeroendb@google.com>, Harshitha
 Ramamurthy <hramamurthy@google.com>, Kuniyuki Iwashima <kuniyu@amazon.com>,
 Willem de Bruijn <willemb@google.com>, David Ahern <dsahern@kernel.org>,
 Neal Cardwell <ncardwell@google.com>, Stefan Hajnoczi
 <stefanha@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, "Michael
 S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Xuan Zhuo
 <xuanzhuo@linux.alibaba.com>, Eugenio =?UTF-8?B?UMOpcmV6?=
 <eperezma@redhat.com>, Shuah Khan <shuah@kernel.org>, sdf@fomichev.me,
 asml.silence@gmail.com, dw@davidwei.uk, Jamal Hadi Salim
 <jhs@mojatatu.com>, Victor Nogueira <victor@mojatatu.com>, Pedro Tammela
 <pctammela@mojatatu.com>, Samiullah Khawaja <skhawaja@google.com>
Subject: Re: [PATCH net-next v7 0/9] Device memory TCP TX
Message-ID: <20250310205000.357d0e84@kernel.org>
In-Reply-To: <CAPpAL=yPwCXONQfO4cZYt_j1CEt1=Yq6jDzqnc6udCTStM8exQ@mail.gmail.com>
References: <20250308214045.1160445-1-almasrymina@google.com>
	<CAPpAL=yPwCXONQfO4cZYt_j1CEt1=Yq6jDzqnc6udCTStM8exQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 10 Mar 2025 18:00:51 +0800 Lei Yang wrote:
> QE tested this series with virtio-net regression tests, everything works fine.
> 
> Tested-by: Lei Yang <leiyang@redhat.com>

It's a bit unclear to me what exactly you tested here 
and why you chose this patch set..

If you have a set of automated tests integrating them 
with patchwork may be a more judicious use of time.

