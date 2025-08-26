Return-Path: <linux-kselftest+bounces-39956-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 62482B36DB4
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Aug 2025 17:27:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C6937AC93B
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Aug 2025 15:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9B6F2749C1;
	Tue, 26 Aug 2025 15:26:23 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from bregans-0.gladserv.net (bregans-0.gladserv.net [185.128.210.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 271EA1E0DE3;
	Tue, 26 Aug 2025 15:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.128.210.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756221983; cv=none; b=Zx996DeRXuOb9jA/qGEmd8l30PcY3UklEfiL/qWWhRt4e4CnCRNoAcad7lObJNTKPeynWjbFiqeMrW+QaqUgJPRbLDIsbYhE5DwW4VVq2WGNdKTwJ+BA1KjrhBXZha5TIFApCTAzJigvywQ0NskVf90sN+nZYWYIb4/8RjfmCMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756221983; c=relaxed/simple;
	bh=I69FLLJx7uzYRbheD/LN/XcKJl4GwTFQhf5Fm4voQJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E5waN0DxgcFUuaBeDiAcYYLWQBZiVrQ0FUAv2Co9+9VbY26zJpCBGwvuEm6mFl1gqiCLQt3S6bycTIrlbn6MBVreqm/9g0sVuaFOvb5/jbrlKTATEjaEU+U0ivlLbQ0k2f5Fq4qHohTQiNhmWp9P99Vnahv76X78FefCWVBgw4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=librecast.net; spf=pass smtp.mailfrom=librecast.net; arc=none smtp.client-ip=185.128.210.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=librecast.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=librecast.net
Date: Tue, 26 Aug 2025 17:26:10 +0200
From: Brett Sheffield <bacs@librecast.net>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Greg KH <gregkh@linuxfoundation.org>,
	Willem de Bruijn <willemb@google.com>
Subject: Re: [PATCH net-next] selftests: net: add test for ipv6 fragmentation
Message-ID: <aK3SEhq1GQFOHKzg@karahi.gladserv.com>
References: <20250825092548.4436-3-bacs@librecast.net>
 <willemdebruijn.kernel.143e90d593cff@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <willemdebruijn.kernel.143e90d593cff@gmail.com>

Thanks for the review, Willem.

On 2025-08-25 12:16, Willem de Bruijn wrote:
> Brett A C Sheffield wrote:
> > Add selftest for the IPv6 fragmentation regression which affected
> > several stable kernels.
> > 
> > Commit a18dfa9925b9 ("ipv6: save dontfrag in cork") was backported to
> > stable without some prerequisite commits.  This caused a regression when
> > sending IPv6 UDP packets by preventing fragmentation and instead
> > returning -1 (EMSGSIZE).
> > 
> > Add selftest to check for this issue by attempting to send a packet
> > larger than the interface MTU. The packet will be fragmented on a
> > working kernel, with sendmsg(2) correctly returning the expected number
> > of bytes sent.  When the regression is present, sendmsg returns -1 and
> > sets errno to EMSGSIZE.
> > 
> > Signed-off-by: Brett A C Sheffield <bacs@librecast.net>
> > Link: https://lore.kernel.org/stable/aElivdUXqd1OqgMY@karahi.gladserv.com
> 
> Thanks for adding a regression test for this.

No problem. I wrote a test for myself when bisecting the problem back in June -
makes sense to convert it to a selftest.

> > +/* we need to set MTU, so do this in a namespace to play nicely */
> > +static int create_namespace(void)
> > +{
> > +	const char *netns_path = "/proc/self/ns/net";
> > +	int fd;
> > +
> > +	if (unshare(CLONE_NEWNET) != 0) {
> > +		perror("unshare");
> > +		return -1;
> > +	}
> 
> Is this not sufficient to move the current process in its own netns?

Yes. Yes it is. Apparently I did not read the man page properly.

> > +	fd = open(netns_path, O_RDONLY);
> > +	if (fd == -1) {
> > +		perror("open");
> > +		return -1;
> > +	}
> > +
> > +	if (setns(fd, CLONE_NEWNET)) {
> > +		perror("setns");
> > +		return -1;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int setup(void)
> > +{
> > +	struct ifreq ifr = {0};
> > +	char ifname[IFNAMSIZ];
> > +	int fd = -1;
> > +	int ctl;
> > +
> > +	if (create_namespace() == -1)
> > +		return -1;
> > +
> > +	ctl = socket(AF_LOCAL, SOCK_STREAM, 0);
> > +	if (ctl == -1)
> > +		return -1;
> > +
> > +	memset(ifname, 0, sizeof(ifname));
> > +	fd = create_interface(ctl, ifname, &ifr);
> > +	if (fd == -1)
> > +		goto err_close_ctl;
> > +	if (disable_dad(ifname) == -1)
> > +		goto err_close_fd;
> > +	if (interface_up(ctl, ifname, &ifr) == -1)
> > +		goto err_close_fd;
> > +	if (set_mtu(ctl, ifname, &ifr) == -1)
> > +		goto err_close_fd;
> > +	usleep(10000); /* give interface a moment to wake up */
> 
> This may be racy. Wait on a more explicit signal? E.g.,
> /sys/class/net/$DEV/operstate.

Good thinking. I'll try that.

> > +	struct msghdr msg = {
> > +		.msg_iov = &iov,
> > +		.msg_iovlen = 1,
> > +		.msg_name = (struct sockaddr *)&sa,
> > +		.msg_namelen = sizeof(sa),
> > +	};
> > +	ssize_t rc;
> > +	int ns_fd;
> > +	int s;
> > +
> > +	printf("Testing IPv6 fragmentation\n");
> > +	ns_fd = setup();
> > +	if (ns_fd == -1)
> > +		return 1;
> > +	s = socket(AF_INET6, SOCK_DGRAM, 0);
> > +	msg.msg_name = (struct sockaddr *)&sa;
> > +	msg.msg_namelen = sizeof(sa);
> 
> nit: duplicate?

Well spotted. Will fix.

> Also, no local address is set. This uses the IPv6 auto assigned
> address?

Correct. The test sends to a link-local scope multicast group from the autoconf
link-local address.  I'll clarify that in the comments at the top of the test.

> > +	rc = sendmsg(s, &msg, 0);
> > +	if (rc == -1) {
> > +		perror("send");
> > +		return 1;
> 
> Probably want to cleanup state both on success and failure.

Ack.

> Could use KSFT_.. exit codes, though 0/1 works just as well for
> kselftests in practice.

Ok.

> > +	} else if (rc != LARGER_THAN_MTU) {
> > +		fprintf(stderr, "send() returned %zi\n", rc);
> > +		return 1;
> > +	}
> > +	close(s);
> > +	close(ns_fd);
> > +
> > +	return 0;
> > +}
> > -- 
> > 2.49.1
> > 

Thanks again - expect a v2 when I have that cleaned up and re-tested.

Cheers,


Brett
--

