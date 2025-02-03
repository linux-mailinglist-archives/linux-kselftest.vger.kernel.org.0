Return-Path: <linux-kselftest+bounces-25564-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E89C4A2573F
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Feb 2025 11:49:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D90A87A2406
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Feb 2025 10:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7115E20103D;
	Mon,  3 Feb 2025 10:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UFzHO2u6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40BC11D86F2;
	Mon,  3 Feb 2025 10:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738579740; cv=none; b=rGQT8u5qnA+dosMivj6aXvqAcXJfQNXT3i2pygGEVkqmHx0FBHqxS/aPBS43MGZCnxiFhK6JeChFpt9w7/RpsqqYzoIabMqvBcD7UMPuaTgZMVFQyIS54cOlCZt02G35OsKY83peJratD8bPhBDTmPbfEqTZTkcvvPcpEeiI7Go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738579740; c=relaxed/simple;
	bh=f4uow+fYeSiEslYkO6Slx22QkpFezU9sppdHSfnIJWM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WHoZ16opOkXrFafD7FTw/Q452ayImIPtDXmc4B+VQn5CRtuWD7z7Lb8Ou7mEZxhmPD/42PEmZakBiyAhQ/XCha+GNcvxtULrgsHtyepIhLUob5UyXsHoZKuw5iqdISfuLVPk9n/NMU7hKfidOI5YQnyecEI2B30of1A35FsZRXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UFzHO2u6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7708EC4CED2;
	Mon,  3 Feb 2025 10:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738579739;
	bh=f4uow+fYeSiEslYkO6Slx22QkpFezU9sppdHSfnIJWM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UFzHO2u6PQ3XLrTmekV7QC9D89rsT/l68RSX4thXupXEpQEVyqno1D55IrLnzvVk4
	 fogvt4n8q/zmax63lHlpd9DpuGwYs/X97noKPaiu9y+Fks4In1M7APrSfOwoAgSIMt
	 dWsbwRg3G9fhUXrEg8HZ6CO5sKThS7uWPrKtVQxESxFf0H5vps3/CYS1S57xi8xQxW
	 XyiuK+R+I+0nkHE4cS3/NQwo6TfRwwJ+PjKwMhGJsSfRV2750e2Lp/EarARwaCEwQP
	 yWJ0n2p1+JmqqHxs+eU3Ogd9bvIpQ8ghXN0GYif+9lF/TwDNGBB05q4tWZeGqaZKf8
	 TIla9lw+tY50A==
Date: Mon, 3 Feb 2025 10:48:55 +0000
From: Simon Horman <horms@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
	matttbe@kernel.org
Subject: Re: [PATCH RFC net-next] netconsole: selftest: Add test for
 fragmented messages
Message-ID: <20250203104855.GC234677@kernel.org>
References: <20250131-netcons_frag_msgs-v1-1-0de83bf2a7e6@debian.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250131-netcons_frag_msgs-v1-1-0de83bf2a7e6@debian.org>

On Fri, Jan 31, 2025 at 04:39:38AM -0800, Breno Leitao wrote:
> Add a new selftest to verify netconsole's handling of messages that
> exceed the packet size limit and require fragmentation. The test sends
> messages with varying sizes and userdata, validating that:
>=20
> 1. Large messages are correctly fragmented and reassembled
> 2. Userdata fields are properly preserved across fragments
> 3. Messages work correctly with and without kernel release version
>    appending
>=20
> The test creates a networking environment using netdevsim, sends
> messages through /dev/kmsg, and verifies the received fragments maintain
> message integrity.
>=20
> Signed-off-by: Breno Leitao <leitao@debian.org>

=2E..

> +# Validate the message, which has two messages glued together.
> +# unwrap them to make sure all the characters were transmitted.
> +# File will look like the following:
> +#   13,468,514729715,-,ncfrag=3D0/1135;MSG1=3DMSG2=3DMSG3=3DMSG4=3DMSG5=
=3DMSG6=3DMSG7=3DMSG8=3DMSG9=3DMSG10=3DMSG11=3DMSG12=3DMSG13=3DMSG14=3DMSG1=
5=3DMSG16=3DMSG17=3DMSG18=3DMSG19=3DMSG20=3DMSG21=3DMSG22=3DMSG23=3DMSG24=
=3DMSG25=3DMSG26=3DMSG27=3DMSG28=3DMSG29=3DMSG30=3DMSG31=3DMSG32=3DMSG33=3D=
MSG34=3DMSG35=3DMSG36=3DMSG37=3DMSG38=3DMSG39=3DMSG40=3DMSG41=3DMSG42=3DMSG=
43=3DMSG44=3DMSG45=3DMSG46=3DMSG47=3DMSG48=3DMSG49=3DMSG50=3DMSG51=3DMSG52=
=3DMSG53=3DMSG54=3DMSG55=3DMSG56=3DMSG57=3DMSG58=3DMSG59=3DMSG60=3DMSG61=3D=
MSG62=3DMSG63=3DMSG64=3DMSG65=3DMSG66=3DMSG67=3DMSG68=3DMSG69=3DMSG70=3DMSG=
71=3DMSG72=3DMSG73=3DMSG74=3DMSG75=3DMSG76=3DMSG77=3DMSG78=3DMSG79=3DMSG80=
=3DMSG81=3DMSG82=3DMSG83=3DMSG84=3DMSG85=3DMSG86=3DMSG87=3DMSG88=3DMSG89=3D=
MSG90=3DMSG91=3DMSG92=3DMSG93=3DMSG94=3DMSG95=3DMSG96=3DMSG97=3DMSG98=3DMSG=
99=3DMSG100=3DMSG101=3DMSG102=3DMSG103=3DMSG104=3DMSG105=3DMSG106=3DMSG107=
=3DMSG108=3DMSG109=3DMSG110=3DMSG111=3DMSG112=3DMSG113=3DMSG114=3DMSG115=3D=
MSG116=3DMSG117=3DMSG118=3DMSG119=3DMSG120=3DMSG121=3DMSG122=3DMSG123=3DMSG=
124=3DMSG125=3DMSG126=3DMSG127=3DMSG128=3DMSG129=3DMSG130=3DMSG131=3DMSG132=
=3DMSG133=3DMSG134=3DMSG135=3DMSG136=3DMSG137=3DMSG138=3DMSG139=3DMSG140=3D=
MSG141=3DMSG142=3DMSG143=3DMSG144=3DMSG145=3DMSG146=3DMSG147=3DMSG148=3DMSG=
149=3DMSG150=3D: netcons_nzmJQ
> +#    key=3D1-2-13,468,514729715,-,ncfrag=3D967/1135;3-4-5-6-7-8-9-10-11-=
12-13-14-15-16-17-18-19-20-21-22-23-24-25-26-27-28-29-30-31-32-33-34-35-36-=
37-38-39-40-41-42-43-44-45-46-47-48-49-50-51-52-53-54-55-56-57-58-59-60-

Hi Breno,

I appreciate there is a value in providing the literal data.
But as the data is based mostly of arithmetic sequences
perhaps it would be nicer to express this in a more succinct way.

Regardless, this patch looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>

=2E..

