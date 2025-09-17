Return-Path: <linux-kselftest+bounces-41750-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 36176B815E1
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Sep 2025 20:41:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F113A4644CA
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Sep 2025 18:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A66043009E9;
	Wed, 17 Sep 2025 18:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YEovyDBd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D2DE2FFDFE;
	Wed, 17 Sep 2025 18:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758134461; cv=none; b=MvIn+T7jHA0PLuWgqG7C8aX0WJzePrcDxD9vGERg/fSsPAuc5DP7U7gmW0WpTyz+qzRHEArVKYnRmkZgsyw8hLM/5m0MY2vBEuUptpsdO8GAy+Ig3xYQIqeolPR8+cJfhjY38gfZWPaKnbppIlLLLC2m0slfrl5Cukg1i64zaHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758134461; c=relaxed/simple;
	bh=v5a8HDMTWo9UE7JwWuCAP2Rrqh4yWlt5INN+qU7/k9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pU33ezDuJbo2YyvcUzqqD9r1D8X8yxvo1xYW/XdpwoGMa0S22j4lyIHSls1pUDDrLqTbM76MYxOSNXwXXynJUb5vgIpjSRFXo9HXM5GM36qL2GL5iq5LezORdSDpvlnxfy2gg+sNCTVpFQUkWvGBz5dydFNkxa0EVKvev7rMk1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YEovyDBd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11FE7C4CEE7;
	Wed, 17 Sep 2025 18:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758134460;
	bh=v5a8HDMTWo9UE7JwWuCAP2Rrqh4yWlt5INN+qU7/k9Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YEovyDBdAidm++9nE0MUACQWUj04x3i0Ti0RfsJxCYJ/A/Bh9kp/NLbQewbyVy9x6
	 bG2fy1bnO0c9Z9UrKN1cVoWN6cC2aKk8DcZyLgs+cTEk2CRheotZ/Odnj1mY6ZrT3b
	 BuUH1ydBNossTwdmb5SUjrluU98XRUxhNSiZi15s9kj/1f47j4sCHxpq3jte2+AmUB
	 UeRdrUU6hOOlQ0IRdsT8cAtJEyNs9LtTLJTVa1rKrw74CGocsJS5/YBOPWXae5Shev
	 c818Zgw3Vm9RnlLt2UFWwqZPbzDKMwxtPRdinyciOq29FgoFpiHKDNqVu1zmJhceK7
	 vQaU+hJE99pvg==
Date: Wed, 17 Sep 2025 19:40:53 +0100
From: Simon Horman <horms@kernel.org>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Bryan Tan <bryan-bt.tan@broadcom.com>,
	Vishnu Dasa <vishnu.dasa@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, linux-hyperv@vger.kernel.org,
	berrange@redhat.com, Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v6 0/9] vsock: add namespace support to
 vhost-vsock
Message-ID: <20250917184053.GV394836@horms.kernel.org>
References: <20250916-vsock-vmtest-v6-0-064d2eb0c89d@meta.com>
 <20250917161928.GR394836@horms.kernel.org>
 <aMri5apAxBpHtZbJ@devvm11784.nha0.facebook.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aMri5apAxBpHtZbJ@devvm11784.nha0.facebook.com>

On Wed, Sep 17, 2025 at 09:33:41AM -0700, Bobby Eshleman wrote:
> On Wed, Sep 17, 2025 at 05:19:28PM +0100, Simon Horman wrote:
> > On Tue, Sep 16, 2025 at 04:43:44PM -0700, Bobby Eshleman wrote:
> > 
> > ...
> > 
> > > base-commit: 949ddfb774fe527cebfa3f769804344940f7ed2e
> > 
> > Hi Bobby,
> > 
> > This series does not seem to compile when applied to the commit above.
> > Likewise when applied to current net-next (which is now slightly newer).
> > 
> > hyperv_transport.c: In function ‘hvs_open_connection’:
> > hyperv_transport.c:316:14: error: too few arguments to function ‘vsock_find_bound_socket’
> >   316 |         sk = vsock_find_bound_socket(&addr, vsock_global_dummy_net());
> >       |              ^~~~~~~~~~~~~~~~~~~~~~~
> > In file included from hyperv_transport.c:15:
> > /home/horms/projects/linux/linux/include/net/af_vsock.h:218:14: note: declared here
> >   218 | struct sock *vsock_find_bound_socket(struct sockaddr_vm *addr, struct net *net,
> >       |              ^~~~~~~~~~~~~~~~~~~~~~~
> > 
> > -- 
> > pw-bot: changes-requested
> 
> Ah dang it, looks like I had hvc disabled when I build tested it.
> 
> Thanks for the catch, I'll fix this in the next rev.

Thanks, that would explain things.
Stuff happens :)

