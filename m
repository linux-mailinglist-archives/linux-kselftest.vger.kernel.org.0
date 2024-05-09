Return-Path: <linux-kselftest+bounces-9812-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 73AB98C14F7
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 May 2024 20:42:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F4010B236BE
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 May 2024 18:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ADC37F483;
	Thu,  9 May 2024 18:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GutFNL9F"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B272980024;
	Thu,  9 May 2024 18:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715280134; cv=none; b=fTMojX1QE97/TA8E5ySGuguY5NHQsmkGSIMbkk21rq8HrMFUXArWpJ/Sl0j3go0TaXVGadWk2CqqmQl59eEvrrYXv1ByU62GogCxUSnPzjRqbkPHmFQ6j6Xas3EsijZghM6A5ON3/gss1/xP5ACkysDiK1kWuknNUNYG3QGksic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715280134; c=relaxed/simple;
	bh=DbiubKQgQk4H/yu5v/5TkWfqLZQZUTEHbadtl7n4xog=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ke2p9mz4SLSS9r9Zo828UdRqmXsDFSwyUuj/iw1n45gRYcOWKctGykXmCi27zgRYQ5G3y1xLzOP8bF76UdXw2dwd0UtkzAMNWnMGtAi+5Hrzmn3gCfMSyoIGBUMNZS75r1sne9RwJ+jWHnwnNU1TddrI5IcViV3MiByuqHdLNN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GutFNL9F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE419C116B1;
	Thu,  9 May 2024 18:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715280134;
	bh=DbiubKQgQk4H/yu5v/5TkWfqLZQZUTEHbadtl7n4xog=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GutFNL9FeOnBSdIxI3n+JuEs9ak0NPkpd9tzPe9hahSe3Z64B6JQIRr1b4QZAY0Cs
	 nd7UcI9bAQCyB7HZJMW4eHP9K0pt5q3JV8B36maDWeEAig5INJpuYMir+2n/DqfQ92
	 VqjYtHkE95lgXHILhelvGTOyiwxmQ6X1LvTizUM0SORHKN0+5xPaVZMRTj7io3lJ8o
	 7frkGwBP9s3/1uFsnO7Cg3YW8hTeCermWtcxwJRqsG9C77VBY9GXTKhQ4Op5P1xpdC
	 AgzJA9BETXjW/fupjnlnXVdCxUGDt+gachyDfvlGL3+fwNJaZH0dDmFYdAeHfDSQUX
	 Y1CB0cjGf8d1Q==
Date: Thu, 9 May 2024 11:42:12 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 shuah@kernel.org, ap420073@gmail.com, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net] selftests: net: move amt to socat for better
 compatibility
Message-ID: <20240509114212.4c8062b5@kernel.org>
In-Reply-To: <0bf4989c10917b2351636a2f19794e47f3d336e9.camel@redhat.com>
References: <20240509161952.3940476-1-kuba@kernel.org>
	<0bf4989c10917b2351636a2f19794e47f3d336e9.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 09 May 2024 19:39:36 +0200 Paolo Abeni wrote:
> Acked-by: Paolo Abeni<pabeni@redhat.com>

Thanks!

> As a minor note, shell variable expansion should already trim all the
> trailing/leading spaces from the socat command output, so it should not
> be necessary replace the string comparison with the grep command:
>=20
> 	RESULT6=3D$(ip netns exec "${LISTENER}" timeout 15 socat - UDP6-LISTEN:6=
000,readbytes=3D128 || true)
> 	if [ "$RESULT6" =3D=3D "2001:db8:3::2" ]; then

99% sure I tried that exact thing, but it wasn't enough.

$ msg=3D$(socat - UDP4-LISTEN:1234,readbytes=3D128)
$ echo ">$msg<"
>127.0.0.1                                                                 =
                                                      <
$ msg=3D$msg
$ echo ">$msg<"
>127.0.0.1                                                                 =
                                                      <
$ msg=3D$(echo $msg)
$ echo ">$msg<"
>127.0.0.1<


IOW we'd need to feed it thru an echo or some such.
Possibly something like: [ $(echo $msg) =3D=3D "127.0.0.1" ]
But I personally find that a touch too magical.
The grep works =F0=9F=A4=B7=EF=B8=8F

