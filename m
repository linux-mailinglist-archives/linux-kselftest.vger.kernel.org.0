Return-Path: <linux-kselftest+bounces-25876-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 51C61A29E81
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Feb 2025 02:45:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B58937A2D9B
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Feb 2025 01:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A21A3BBF0;
	Thu,  6 Feb 2025 01:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D7ljF96j"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 482A34A06;
	Thu,  6 Feb 2025 01:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738806318; cv=none; b=E/WMOs2/jsPSP3knYLc21Z00fsAMQ4I+jxZthAKivJUPeQYMx/Bt5QzhrsW13y4GLGtN80o6BecWVPPeC7h6SZ3gJERKUmy6x6xKllePed1DVUvYtoZkEaE84Di+eMmGS5icYSu2ZHTwsUfwJ1nEv6XQ6VDy2ShNGGuBCFtzFUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738806318; c=relaxed/simple;
	bh=3FKgirNXQBD9To5djYaaxMigf7vVsLObBwiIb3LzA+o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TMgkcCMwrjIDLtlBXYcBTkjsZh8fT2+s85x+D3blAaa8L6qx7SsRGxzsFkGbhpP3884JgENe8CpU92gRMXE5++hO7N61WTVxAq3AmdOxAvbFuJMOuI6GOzqN1c/ksNTGdLe4IP8SwyjeeMmDnnzI+njVQiTizMJEz/5eNy1lJVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D7ljF96j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B58ECC4CED1;
	Thu,  6 Feb 2025 01:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738806317;
	bh=3FKgirNXQBD9To5djYaaxMigf7vVsLObBwiIb3LzA+o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=D7ljF96jPqObiWUUX4RymLnHDejsWlOf7Lh4b5TZjKhiZONmEp2keHrwrvyxBwKgr
	 kolGt6oDUMXlHZRmAY/m6Wy20wyDBIrBnX9A/tcP3QMLWurszEB/C8PIMjTrgCmArk
	 Owo1E2b80+dFU/jPNUGx4Y9jUvdY18131mp/EElXW28Pai9R/n/jpO/SMPyZfv7g4u
	 ju2ndhmCTO7IcslYOLpsg2mQNQm4WZgY2yA9Wl/H3EjdgJJNWSqnhkWq8ZKjU//hpP
	 kPZrZ+y4Vj9fEVLj0Qdwocc6n88tLyZZvS57Ko9hvFyo6QPFtqdBFvrEotocFp1m8+
	 YPKn4GjB05R8A==
Date: Wed, 5 Feb 2025 17:45:16 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, kvm@vger.kernel.org,
 virtualization@lists.linux.dev, linux-kselftest@vger.kernel.org, Donald
 Hunter <donald.hunter@gmail.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Neal Cardwell <ncardwell@google.com>, David Ahern
 <dsahern@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang
 <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio
 =?UTF-8?B?UMOpcmV6?= <eperezma@redhat.com>, Stefan Hajnoczi
 <stefanha@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan
 <shuah@kernel.org>, sdf@fomichev.me, asml.silence@gmail.com,
 dw@davidwei.uk, Jamal Hadi Salim <jhs@mojatatu.com>, Victor Nogueira
 <victor@mojatatu.com>, Pedro Tammela <pctammela@mojatatu.com>, Samiullah
 Khawaja <skhawaja@google.com>
Subject: Re: [PATCH net-next v3 0/6] Device memory TCP TX
Message-ID: <20250205174516.537a7101@kernel.org>
In-Reply-To: <CAHS8izNxi+Dc6mXPNaQSjtmz5YzmeA-Sn8JdMWLpYRomJdCWMA@mail.gmail.com>
References: <20250203223916.1064540-1-almasrymina@google.com>
	<20250204180833.48cb40cb@kernel.org>
	<CAHS8izNxi+Dc6mXPNaQSjtmz5YzmeA-Sn8JdMWLpYRomJdCWMA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 5 Feb 2025 11:52:20 -0800 Mina Almasry wrote:
> > please stick to RFC until a driver implementation is ready and
> > included  
> 
> For the RX path proposals I kept the driver implementation out of the
> series and linked to it in the cover letter. Just to confirm, is that
> OK for this series as well?

No, the other series was large IIRC. This is just 6 patches, normal
rules. 

