Return-Path: <linux-kselftest+bounces-3203-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45AE3831BD4
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Jan 2024 15:53:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96A96B21B1E
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Jan 2024 14:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B3331DDC0;
	Thu, 18 Jan 2024 14:53:30 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from wp716.webpack.hosteurope.de (wp716.webpack.hosteurope.de [80.237.130.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A70F039B;
	Thu, 18 Jan 2024 14:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705589610; cv=none; b=KkmrVpNFbyY00COWf8C2xmU1zAHXTYn31NrOvBPG0XB1aoc2RTnzjxEQdgVwuVERW8JFu4bnhlSlFSDHn+m957UFIvz2xQo4PglKV9wsYT8bsIHZimZDzE1Z78iUsU4rVeLE0VAPv6RV2fdNnegVgPUnl2hsdRo0NyMJQsu70kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705589610; c=relaxed/simple;
	bh=5QNhidmMxrvL4D2I8M20qaJImWVAaAjHxa9TzR5CbUk=;
	h=Received:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:User-Agent:
	 MIME-Version:X-bounce-key:X-HE-SMSGID; b=pkANOOWrbJZ54L4pIUOOKGibpHyLHUIXc92zGSpNQVdNFtKnlFn18qx424isj4794mqSoBA+UUXJYUTFs4ANoNXgY5NpdW61oifnLcB0lzGczF3ckdaNyKvIboaT7RuI6vD5F5+4irEX0tenn3RVFJmNOHK1tLybpTgUhObLZkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=alumni.tu-berlin.de; spf=none smtp.mailfrom=alumni.tu-berlin.de; arc=none smtp.client-ip=80.237.130.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=alumni.tu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=alumni.tu-berlin.de
Received: from dynamic-2a01-0c22-ac44-ff00-7b4e-548d-a441-0836.c22.pool.telefonica.de ([2a01:c22:ac44:ff00:7b4e:548d:a441:836] helo=jt.fritz.box); authenticated
	by wp716.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	id 1rQTle-0004Td-8M; Thu, 18 Jan 2024 15:53:18 +0100
Message-ID: <b332beac0f22636e7877c681b3adb9d6ff70cde3.camel@alumni.tu-berlin.de>
Subject: Re: [PATCH bpf-next] bpf: Allow setting SO_TIMESTAMPING* with
 bpf_setsockopt()
From: =?ISO-8859-1?Q?J=F6rn-Thorben?= Hinz <j-t.hinz@alumni.tu-berlin.de>
To: Martin KaFai Lau <martin.lau@linux.dev>, Willem de Bruijn
	 <willemdebruijn.kernel@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>,  Andrii Nakryiko <andrii@kernel.org>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,  Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan
 <shuah@kernel.org>,  Arnd Bergmann <arnd@arndb.de>, Deepa Dinamani
 <deepa.kernel@gmail.com>, bpf@vger.kernel.org, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org
Date: Thu, 18 Jan 2024 15:53:17 +0100
In-Reply-To: <73235f05-8474-4341-b70b-34bd0e6dfac5@linux.dev>
References: <20240115134110.11624-1-j-t.hinz@alumni.tu-berlin.de>
	 <65a69e1be51ef_380df0294d9@willemb.c.googlers.com.notmuch>
	 <51fd5249-140a-4f1b-b20e-703f159e88a3@linux.dev>
	 <65a7f855821cc_6d500294d0@willemb.c.googlers.com.notmuch>
	 <73235f05-8474-4341-b70b-34bd0e6dfac5@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-bounce-key: webpack.hosteurope.de;j-t.hinz@alumni.tu-berlin.de;1705589607;d1e87b62;
X-HE-SMSGID: 1rQTle-0004Td-8M

Hmm, after taking a new look at it today, I think my patch can be
disregarded---at least for having a BPF program access *RX* *hardware*
timestamps. (Sorry about the noise then.)

When I looked into this a few months ago, I half-blindly followed
Documentation/networking/timestamping.rst, afterwards assuming
bpf_setsockopt(SO_TIMESTAMPING*) will be necessary for my use case (see
about it at the end).

Looking at it again today, it seems the ioctl(SIOCSHWTSTAMP) is
sufficient here: It enables the hardware timestamping on the device,
which are placed in skb's/skb_shared_info's hwtstamps field. This
hwtstamps is where the values of __sk_buff.hwtstamp and
bpf_sock_ops.skb_hwtstamp are coming from. No further timestamp
processing is involved when a BPF program reads the these two fields.
Meaning bpf_setsockopt(SOF_TIMESTAMPING_RX_HARDWARE) would be a no-op
from the view of a BPF program.

I started this message before coming to the above understanding but
I've left my replies in below.

With bpf_setsockopt(SOF_TIMESTAMPING_RX_HARDWARE) being unnecessary,
and bpf_setsockopt(SOF_TIMESTAMPING_RX_SOFTWARE), as I understand,
having a number of possibly unwanted implications---should we leave it
at that here?

On Wed, 2024-01-17 at 13:23 -0800, Martin KaFai Lau wrote:
> > On 1/17/24 7:55 AM, Willem de Bruijn wrote:
> > > > Martin KaFai Lau wrote:
> > > > > > On 1/16/24 7:17 AM, Willem de Bruijn wrote:
> > > > > > > > J=C3=B6rn-Thorben Hinz wrote:
> > > > > > > > > > A BPF application, e.g., a TCP congestion control,
> > > > > > > > > > might
> > > > > > > > > > benefit from or
> > > > > > > > > > even require precise (=3Dhardware) packet timestamps.
> > > > > > > > > > These
> > > > > > > > > > timestamps are
> > > > > > > > > > already available through __sk_buff.hwtstamp and
> > > > > > > > > > bpf_sock_ops.skb_hwtstamp, but could not be
> > > > > > > > > > requested: BPF
> > > > > > > > > > programs were
> > > > > > > > > > not allowed to set SO_TIMESTAMPING* on sockets.
> > > > > >=20
> > > > > > This patch only uses the SOF_TIMESTAMPING_RX_HARDWARE in
> > > > > > the
> > > > > > selftest. How about
> > > > > > others? e.g. the SOF_TIMESTAMPING_TX_* that will affect the
> > > > > > sk->sk_error_queue
> > > > > > which seems not good. If rx tstamp is useful, tx tstamp
> > > > > > should be
> > > > > > useful also?
I admit I only ever looked at enabling and using
SOF_TIMESTAMPING_RX_HARDWARE for my/our use case. With that, I was not
aware that _SOFTWARE has more, possibly complicating implications.

> > > >=20
> > > > Good point. Or should not be allowed to be set from BPF.
> > > >=20
> > > > That significantly changes process behavior, e.g., by returning
> > > > POLLERR.
> > > > =C2=A0=20
> > > > > > > > > >=20
> > > > > > > > > > Enable BPF programs to actively request the
> > > > > > > > > > generation of
> > > > > > > > > > timestamps
> > > > > > > > > > from a stream socket. The also required
> > > > > > > > > > ioctl(SIOCSHWTSTAMP)
> > > > > > > > > > on the
> > > > > > > > > > network device must still be done separately, in
> > > > > > > > > > user space.
> > > > > >=20
> > > > > > hmm... so both ioctl(SIOCSHWTSTAMP) of the netdevice and
> > > > > > the
> > > > > > SOF_TIMESTAMPING_RX_HARDWARE of the sk must be done?
> > > > > >=20
> > > > > > I likely miss something. When skb is created=C2=A0 in the drive=
r
> > > > > > rx
> > > > > > path, the sk is
> > > > > > not known yet though. How the SOF_TIMESTAMPING_RX_HARDWARE
> > > > > > of the
> > > > > > sk affects the
> > > > > > skb_shinfo(skb)->hwtstamps?
I mostly followed Documentation/networking/timestamping.rst (section 3)
to understand how the hardware timestamps are to be setup and used.

From my understanding, the ioctl(SIOCSHWTSTAMP) makes a persistent
setting for the device/driver, independent of the lifetime of any
socket or skb.

I used a simplified program[1] when trying out this patch a few months
ago.

> > > >=20
> > > > Indeed it does not seem to do anything in the datapath.
> > > >=20
> > > > Requesting SOF_TIMESTAMPING_RX_SOFTWARE will call
> > > > net_enable_timestamp
> > > > to start timestamping packets.
> > > >=20
> > > > But SOF_TIMESTAMPING_RX_HARDWARE does not so thing.
> > > >=20
> > > > Drivers do use it in ethtool get_ts_info to signal hardware
> > > > capabilities. But those must be configured using the ioctl.
> > > >=20
> > > > It is there more for consistency with the other timestamp
> > > > recording
> > > > options, I suppose.
> > > >=20
> >=20
> > Thanks for the explanation on the
> > SOF_TIMESTAMPING_RX_{HARDWARE,SOFTWARE}.
> >=20
> > __sk_buff.hwtstamp should have the NIC rx timestamp then as long as
> > the NIC is=20
> > ioctl configured.

> >=20
> > Jorn, do you need RX_SOFTWARE? From looking at net_timestamp_set(),
> > any socket=20
> > requested RX_SOFTWARE should be enough to get a skb->tstamp for all
> > skbs. A=20
> > workaround is to manually create a socket and turn on RX_SOFTWARE.
No, my use case was only for the RX hardware timestamps, as close to
the packet reception time point as possible.

> >=20
> > It will still be nice to get proper bpf_setsockopt() support for
> > RX_SOFTWARE but=20
> > it should be considered together with how SO_TIMESTAMPING_TX_*
> > should
> > work in=20
> > bpf prog considering the TX tstamping does not have a workaround
> > solution like=20
> > RX_SOFTWARE.
> >=20
> > It is probably cleaner to have a separate bit in sk->sk_tsflags for
> > bpf such=20
> > that the bpf prog won't be affected by the userspace turning it
> > on/off and it=20
> > won't change the userspace's expectation also (e.g. sk_error_queue
> > and POLLERR).
> >=20
> > The part that needs more thoughts in the tx tstamp is how to notify
> > the bpf prog=20
> > to consume it. Potentially the kernel can involve a bpf prog to
> > collect the tx=20
> > timestamp when the bpf bit in sk->sk_tsflags is set. An example on
> > how TCP-CC is=20
> > using it will help to think of the approach here.
My (academic) application was an implementation[2,3] of PowerTCP[4], a
CC that (in its simplified variant) profits from precise timestamping.
Only the RX timestamps would be of use there.

As mentioned above, I used[1] a while ago when I looked into timestamp
usage. It shows how I imagine the timestamps could be accessed and used
(similarly implemented in [2]).

[1] https://github.com/jtdor/bpf_hwtstamps
[2] https://github.com/inet-tub/powertcp-linux
[3] https://schmiste.github.io/ebpf23.pdf
[4] https://schmiste.github.io/nsdi22powertcp.pdf

> >=20
> >=20



