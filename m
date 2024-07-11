Return-Path: <linux-kselftest+bounces-13557-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 147FC92E39E
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jul 2024 11:41:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 852531F21BD6
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jul 2024 09:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 110B1156F39;
	Thu, 11 Jul 2024 09:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UPPwTj57"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE7271509B1
	for <linux-kselftest@vger.kernel.org>; Thu, 11 Jul 2024 09:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720690876; cv=none; b=h/8kUVR4LcSQMJTQahftQPgBzKiq3uAzQ15JRieW3GbugqVXLjKrqTUF+rLJLULEGTZHG/cbQn+qwzKPcO94VyP7Nb8nqtW5AjT/LSgDlcHLf/2d7SFgqgq67qCDLsLyD9cwET5LD5Gtooxjx/lQAxX+RvOGRT6joUyutG0OMak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720690876; c=relaxed/simple;
	bh=8RUZWpSSsIgoH4i40p6vT8jM5LG/7OmypIyPi6a/9F0=;
	h=From:References:MIME-Version:In-Reply-To:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MwEq9zfAE2zHJeBL59pHiPhdp45M5YuLlwDfmABPc+/AZNGvao6Oq/4GzQSXQZW1ioAR2kyqdzgCS1bejrZMm15dNL9VsNIVZYZqjTpAoqQCr/bXxob6TF1H09+TG2Hk1BB/6ZN4P8NzUDAldAyxioSvaXGZly/Q7+JracfWEjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UPPwTj57; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720690871;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=roMHuw+PALuns3vCWcdFi8XZN8Qqy8eFcMii4s+wTJk=;
	b=UPPwTj57L7e/oP4KdQQK19B94WuND8+mppKuEzcSv71CFhP/WPj6z0GPiznBGLki3jTDt0
	//LJSbutLiiT+KBRf6+2NvuS+wPNtJeferJR6mBSQzOXwgn2VN0xNpZKrC8tkpBvX+N4zI
	Xv/ti7tfrYqfWwf1XY9h2t7M///fP5g=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-88-SC30rRj4OKeSgdr9hrB0VA-1; Thu, 11 Jul 2024 05:41:10 -0400
X-MC-Unique: SC30rRj4OKeSgdr9hrB0VA-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6b603f67501so9822606d6.0
        for <linux-kselftest@vger.kernel.org>; Thu, 11 Jul 2024 02:41:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720690870; x=1721295670;
        h=content-transfer-encoding:cc:to:subject:message-id:date:in-reply-to
         :mime-version:references:from:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=roMHuw+PALuns3vCWcdFi8XZN8Qqy8eFcMii4s+wTJk=;
        b=pFUQT4hJb0de7F1f1KK0xSUhmpwR90Clgy4OkXVABRS0BfriyJUY2+ycApbu2tmmKB
         baYrMlNePNDKmw0bi2a/sUA7QVr5fq+17xxdMDdA+EhQ4a2W8RcMFekmCXi3EE0yNgTJ
         Zif4c3B43fSIP3RC9ueEiZvgaY9J4TcrVQNAov+BuHtxh5zhMbQj3ucoc/2qgfA9NOV8
         Kj9RN4hSwrH+mhBIbpa8hxQTQykQp9sJ+KzCJQ9DM8qebry/tIRoNpJ+l+qXOIKStOWo
         rqG+xYP72tBP90qKnngfLNFTGBeEvjIICwz1tdmav/RFmSUXUBlofyO+spGBXn7QTgDq
         mrdA==
X-Forwarded-Encrypted: i=1; AJvYcCXsBO8QyMS4LgOmChGxjMcMuOr68uanWDVReIetDTaTUvDfxC7YTiFCu0XFz3/jwQ18xbuH4ATH8gYwIWMDMk7nC8XAfjCjuToWRfWNRfxG
X-Gm-Message-State: AOJu0YyvU7tP/2z1CApuok1D9jAu+iH17gREATF2/VVzNVapk7ESgk1/
	5ab92XAEinH1Atog3Pt65eTSq2LYivO83/kk+gD6tsSDZdl7MmHuyqRfuNmxNkvfskAQMWn/8g8
	h4Bd9iNShpW7ECYEiD1nFHL17wHvuMY3FpzlDZQJOg5MQJPLZnsPdqFGBxAFnLgtydP0diE5tNk
	B9PMVgXkXeIhcq5FDTEdLkFajEvoAfOyrImNunFq1MDn+D/6EM
X-Received: by 2002:ad4:4ea6:0:b0:6b5:e006:11b0 with SMTP id 6a1803df08f44-6b61bca384fmr99044746d6.20.1720690869708;
        Thu, 11 Jul 2024 02:41:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGSRxmewcxMQ/3BL81YZjQF3O+LHKdXdzsEe8HRIH22wz9sWJC8rn/QEPgJD7oQUldO/x36Y6ZPMZhiH0ZPSGE=
X-Received: by 2002:ad4:4ea6:0:b0:6b5:e006:11b0 with SMTP id
 6a1803df08f44-6b61bca384fmr99044606d6.20.1720690869382; Thu, 11 Jul 2024
 02:41:09 -0700 (PDT)
Received: from 311643009450 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 11 Jul 2024 09:41:08 +0000
From: =?UTF-8?Q?Adri=C3=A1n_Moreno?= <amorenoz@redhat.com>
References: <20240710090500.1655212-1-amorenoz@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240710090500.1655212-1-amorenoz@redhat.com>
Date: Thu, 11 Jul 2024 09:41:08 +0000
Message-ID: <CAG=2xmMsgmZosNvuVC-uGjkKGQfSq0kjwpMSgS46jpd5Zbpp7A@mail.gmail.com>
Subject: Re: [PATCH net-next v2] selftests: openvswitch: retry instead of sleep
To: netdev@vger.kernel.org
Cc: Pravin B Shelar <pshelar@ovn.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, dev@openvswitch.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, horms@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 10, 2024 at 11:04:59AM GMT, Adrian Moreno wrote:
> There are a couple of places where the test script "sleep"s to wait for
> some external condition to be met.
>
> This is error prone, specially in slow systems (identified in CI by
> "KSFT_MACHINE_SLOW=3Dyes").
>
> To fix this, add a "ovs_wait" function that tries to execute a command
> a few times until it succeeds. The timeout used is set to 5s for
> "normal" systems and doubled if a slow CI machine is detected.
>
> This should make the following work:
>
> $ vng --build  \
>     --config tools/testing/selftests/net/config \
>     --config kernel/configs/debug.config
>
> $ vng --run . --user root -- "make -C tools/testing/selftests/ \
>     KSFT_MACHINE_SLOW=3Dyes TARGETS=3Dnet/openvswitch run_tests"
>
> Signed-off-by: Adrian Moreno <amorenoz@redhat.com>
> ---
>  .../selftests/net/openvswitch/openvswitch.sh  | 45 +++++++++++++++----
>  .../selftests/net/openvswitch/ovs-dpctl.py    |  1 +
>  2 files changed, 38 insertions(+), 8 deletions(-)
>
> diff --git a/tools/testing/selftests/net/openvswitch/openvswitch.sh b/too=
ls/testing/selftests/net/openvswitch/openvswitch.sh
> index bc71dbc18b21..cc0bfae2bafa 100755
> --- a/tools/testing/selftests/net/openvswitch/openvswitch.sh
> +++ b/tools/testing/selftests/net/openvswitch/openvswitch.sh
> @@ -11,6 +11,11 @@ ksft_skip=3D4
>  PAUSE_ON_FAIL=3Dno
>  VERBOSE=3D0
>  TRACING=3D0
> +WAIT_TIMEOUT=3D5
> +
> +if test "X$KSFT_MACHINE_SLOW" =3D=3D "Xyes"; then
> +	WAIT_TIMEOUT=3D10
> +fi
>
>  tests=3D"
>  	arp_ping				eth-arp: Basic arp ping between two NS
> @@ -29,6 +34,30 @@ info() {
>  	[ $VERBOSE =3D 0 ] || echo $*
>  }
>
> +ovs_wait() {
> +	info "waiting $WAIT_TIMEOUT s for: $@"
> +
> +	if "$@" ; then
> +		info "wait succeeded immediately"
> +		return 0
> +	fi
> +
> +	# A quick re-check helps speed up small races in fast systems.
> +	# However, fractional sleeps might not necessarily work.
> +	local start=3D0
> +	sleep 0.1 || { sleep 1; start=3D1; }
> +
> +	for (( i=3Dstart; i<WAIT_TIMEOUT; i++ )); do
> +		if "$@" ; then
> +			info "wait succeeded after $i seconds"
> +			return 0
> +		fi
> +		sleep 1
> +	done
> +	info "wait failed after $i seconds"
> +	return 1
> +}
> +
>  ovs_base=3D`pwd`
>  sbxs=3D
>  sbx_add () {
> @@ -278,20 +307,19 @@ test_psample() {
>
>  	# Record psample data.
>  	ovs_spawn_daemon "test_psample" python3 $ovs_base/ovs-dpctl.py psample-=
events
> +	ovs_wait grep -q "listening for psample events" ${ovs_dir}/stdout
>
>  	# Send a single ping.
> -	sleep 1
>  	ovs_sbx "test_psample" ip netns exec client ping -I c1 172.31.110.20 -c=
 1 || return 1
> -	sleep 1
>
>  	# We should have received one userspace action upcall and 2 psample pac=
kets.
> -	grep -E "userspace action command" $ovs_dir/s0.out >/dev/null 2>&1 || r=
eturn 1
> +	ovs_wait grep -q "userspace action command" $ovs_dir/s0.out || return 1
>
>  	# client -> server samples should only contain the first 14 bytes of th=
e packet.
> -	grep -E "rate:4294967295,group:1,cookie:c0ffee data:[0-9a-f]{28}$" \
> -			 $ovs_dir/stdout >/dev/null 2>&1 || return 1
> -	grep -E "rate:4294967295,group:2,cookie:eeff0c" \
> -			 $ovs_dir/stdout >/dev/null 2>&1 || return 1
> +	ovs_wait grep -qE "rate:4294967295,group:1,cookie:c0ffee data:[0-9a-f]{=
28}$" \
> +		$ovs_dir/stdout || return 1
> +
> +	ovs_wait grep -q "rate:4294967295,group:2,cookie:eeff0c" $ovs_dir/stdou=
t || return 1
>
>  	return 0
>  }
> @@ -711,7 +739,8 @@ test_upcall_interfaces() {
>  	ovs_add_netns_and_veths "test_upcall_interfaces" ui0 upc left0 l0 \
>  	    172.31.110.1/24 -u || return 1
>
> -	sleep 1
> +	ovs_wait grep -q "listening on upcall packet handler" ${ovs_dir}/left0.=
out
> +
>  	info "sending arping"
>  	ip netns exec upc arping -I l0 172.31.110.20 -c 1 \
>  	    >$ovs_dir/arping.stdout 2>$ovs_dir/arping.stderr
> diff --git a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py b/tools=
/testing/selftests/net/openvswitch/ovs-dpctl.py
> index 1e15b0818074..8a0396bfaf99 100644
> --- a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
> +++ b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
> @@ -2520,6 +2520,7 @@ class PsampleEvent(EventSocket):
>      marshal_class =3D psample_msg
>
>      def read_samples(self):
> +        print("listening for psample events", flush=3DTrue)
>          while True:
>              try:
>                  for msg in self.get():
> --
> 2.45.2
>


This patch is supposed to fix openvswitch selftests on "-dbg" machines.
However, as Simon points out, all recent rounds are failing [1]. I don't
see this patch being included in the batches and I was wondering why.

Also I see a (presumably unrelated) build error netdev/build_32bit.
Is there anything I can do?

[1]
https://netdev.bots.linux.dev/contest.html?executor=3Dvmksft-net-dbg&test=
=3Dopenvswitch-sh

Thanks.
Adri=C3=A1n


