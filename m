Return-Path: <linux-kselftest+bounces-12137-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0495290C7A5
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jun 2024 12:49:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDDF2284D5C
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jun 2024 10:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 756F31BE232;
	Tue, 18 Jun 2024 09:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fIzWtSu5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A8F715538F
	for <linux-kselftest@vger.kernel.org>; Tue, 18 Jun 2024 09:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718701700; cv=none; b=HnoWel/ybjhctDC6RbrraCW4U3xSKcZy0reXCJJJwBx6++5QcMNI4Tm0EkQGMMx+nj8apl/fHJUBhWXb2RqmCKa1CHHPKAi/KiRJZALwHwk3QopZajVsScPB4cmgIxn+6Xj6nSe8Q7/LXJdcECyt/8pTsxS1U9Jk/3LaCAta1j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718701700; c=relaxed/simple;
	bh=CedmGa8cZ2BxtrlLmbeF2uubAoaL7BH6KJmCYay3qnc=;
	h=From:References:MIME-Version:In-Reply-To:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uLdxMgthWA87SW7EashZRtPlaDa0V20L2fIrVbsE11kbQ56jnWsKmQwsfBBbsNRTKDc9KT0wnW2ZOZ4VPUZ38TVxDSFDLuRRpEgwhHOH1b6ZI3w7ovwccR+B/Yyjo78vyVvo2vAwpKYz96ugCUy5819CEYVJP7Ed6H72Z6zo85Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fIzWtSu5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718701697;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lL7KZvqoxVX7mfVc2Z7x40SX7MdcEUbetSFvdcSCmVU=;
	b=fIzWtSu5DTY3lBrZBeeHs9sgv9LCSEMB9VuE+qhOPXCCjrJ75pUnn6y402vXWf3Ic0KqKa
	pjMHdAQ6flj74A4conqv52UkhCTG3Ms1uKBcw/2sX2HEC3000TxCaWEftLq7rsXEZ3HwIh
	eicT51ACWD/3xzQ47OQB2vh1+57zIG0=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-340-FPoZy5-DOQWuJMJ2fbezLw-1; Tue, 18 Jun 2024 05:08:16 -0400
X-MC-Unique: FPoZy5-DOQWuJMJ2fbezLw-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6b22e2dfa6cso76960816d6.1
        for <linux-kselftest@vger.kernel.org>; Tue, 18 Jun 2024 02:08:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718701695; x=1719306495;
        h=content-transfer-encoding:cc:to:subject:message-id:date:in-reply-to
         :mime-version:references:from:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lL7KZvqoxVX7mfVc2Z7x40SX7MdcEUbetSFvdcSCmVU=;
        b=R7qoGjc1+YRMaWMw5PqO4mryQ6gY2VJvEjSzTFC0ECiXoMwKXLd1tKTiSXPUVGo7Im
         dQdve0pn5D1eVF1uKZpppJMZpx0KVabZTHGSSBdR0LUgHaME2ajNlVcCJQveVcZ3DnAD
         mUESoSX4aWPOIq+hFZHsD6GZps7EyXvof51JVShPVM0pvIS9xhXdxCv15oT6/aB6L00p
         FvDRc+kbvZPaqcjpeaIGWEfeCrWdUBwuckogvlxUkYq4uRRZIlnnbQllJTCkMqLmPU08
         4wLrw9Wvy+MBayw8uJP1c/qFWFzcHdphlgM8LiB+ZevfLslPi81RWAJxhljDNo+kTILw
         gB6w==
X-Forwarded-Encrypted: i=1; AJvYcCVgm4NAkscW/60o60iGF4iL1cHHYfq1JhsNq/avv6iV/aPMyHkkAgNlbFbreCuUmkBYV7FlQHrz2Z2ZebynKhIxC6dReq6cYQLDxzWKDhNV
X-Gm-Message-State: AOJu0YzaD+zYlUiaE2Lz2/Ief+ol2Mb+ifS70sugmo2CEm888exVOzDJ
	XNlTjUihgbMjx0sUz0UAW7d9BRoOOfaaPA3VCcOnyDgm+T3jqm2gsKrOg7c3VL2XM/pf5CjtqnL
	43qnciFGLIt/uezSqxgGbxncxX4kqsps8eAbqXA24x4rVU3rhteSTYcabfLn0HWj8MvxgkORBpW
	FCBxPjEcJ7AzO1gipggmyC5gjOCRgXcJe0PrS9XdyL
X-Received: by 2002:a05:6214:411c:b0:6b0:7735:9eff with SMTP id 6a1803df08f44-6b2afd94d1fmr164611886d6.23.1718701695555;
        Tue, 18 Jun 2024 02:08:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEZ3YNztvrs6RyERGRWb7sKDNttLNS9hJBnK8l7r55jhtzC/1VIeAQT1yZHXLYxlP5LwBJWVLmiu01WlgMtb3c=
X-Received: by 2002:a05:6214:411c:b0:6b0:7735:9eff with SMTP id
 6a1803df08f44-6b2afd94d1fmr164611726d6.23.1718701695240; Tue, 18 Jun 2024
 02:08:15 -0700 (PDT)
Received: from 311643009450 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 18 Jun 2024 09:08:14 +0000
From: =?UTF-8?Q?Adri=C3=A1n_Moreno?= <amorenoz@redhat.com>
References: <20240603185647.2310748-1-amorenoz@redhat.com> <20240603185647.2310748-10-amorenoz@redhat.com>
 <f7tzfrnmp0q.fsf@redhat.com> <CAG=2xmPvAfQx4jSFbBPTcEdo2Z6w93vo6-Uo5rVMLbu8qS1SOA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAG=2xmPvAfQx4jSFbBPTcEdo2Z6w93vo6-Uo5rVMLbu8qS1SOA@mail.gmail.com>
Date: Tue, 18 Jun 2024 09:08:14 +0000
Message-ID: <CAG=2xmO-mtQOMABEAXNxEoa6NH5Hgae1x5+XWU5ZnLFg2n7b=g@mail.gmail.com>
Subject: Re: [PATCH net-next v2 9/9] selftests: openvswitch: add emit_sample test
To: Aaron Conole <aconole@redhat.com>
Cc: netdev@vger.kernel.org, echaudro@redhat.com, horms@kernel.org, 
	i.maximets@ovn.org, dev@openvswitch.org, Pravin B Shelar <pshelar@ovn.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 17, 2024 at 07:18:05AM GMT, Adri=C3=A1n Moreno wrote:
> On Fri, Jun 14, 2024 at 01:07:33PM GMT, Aaron Conole wrote:
> > Adrian Moreno <amorenoz@redhat.com> writes:
> >
> > > Add a test to verify sampling packets via psample works.
> > >
> > > In order to do that, create a subcommand in ovs-dpctl.py to listen to
> > > on the psample multicast group and print samples.
> > >
> > > In order to also test simultaneous sFlow and psample actions and
> > > packet truncation, add missing parsing support for "userspace" and
> > > "trunc" actions.
> >
> > Maybe split that into a separate patch.  This has a bugfix and 3
> > features being pushed in.  I know it's already getting long as a series=
,
> > so maybe it's okay to fold the userspace attribute bugfix with the pars=
e
> > support (since it wasn't really usable before).
> >
>
> OK. Sounds reasonable.
>
> > > Signed-off-by: Adrian Moreno <amorenoz@redhat.com>
> > > ---
> > >  .../selftests/net/openvswitch/openvswitch.sh  |  99 +++++++++++++++-
> > >  .../selftests/net/openvswitch/ovs-dpctl.py    | 112 ++++++++++++++++=
+-
> > >  2 files changed, 204 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/tools/testing/selftests/net/openvswitch/openvswitch.sh b=
/tools/testing/selftests/net/openvswitch/openvswitch.sh
> > > index 5cae53543849..f6e0ae3f6424 100755
> > > --- a/tools/testing/selftests/net/openvswitch/openvswitch.sh
> > > +++ b/tools/testing/selftests/net/openvswitch/openvswitch.sh
> > > @@ -20,7 +20,8 @@ tests=3D"
> > >  	nat_related_v4				ip4-nat-related: ICMP related matches work with S=
NAT
> > >  	netlink_checks				ovsnl: validate netlink attrs and settings
> > >  	upcall_interfaces			ovs: test the upcall interfaces
> > > -	drop_reason				drop: test drop reasons are emitted"
> > > +	drop_reason				drop: test drop reasons are emitted
> > > +	emit_sample 				emit_sample: Sampling packets with psample"
> > >
> > >  info() {
> > >      [ $VERBOSE =3D 0 ] || echo $*
> > > @@ -170,6 +171,19 @@ ovs_drop_reason_count()
> > >  	return `echo "$perf_output" | grep "$pattern" | wc -l`
> > >  }
> > >
> > > +ovs_test_flow_fails () {
> > > +	ERR_MSG=3D"Flow actions may not be safe on all matching packets"
> > > +
> > > +	PRE_TEST=3D$(dmesg | grep -c "${ERR_MSG}")
> > > +	ovs_add_flow $@ &> /dev/null $@ && return 1
> > > +	POST_TEST=3D$(dmesg | grep -c "${ERR_MSG}")
> > > +
> > > +	if [ "$PRE_TEST" =3D=3D "$POST_TEST" ]; then
> > > +		return 1
> > > +	fi
> > > +	return 0
> > > +}
> > > +
> > >  usage() {
> > >  	echo
> > >  	echo "$0 [OPTIONS] [TEST]..."
> > > @@ -184,6 +198,89 @@ usage() {
> > >  	exit 1
> > >  }
> > >
> > > +
> > > +# emit_sample test
> > > +# - use emit_sample to observe packets
> > > +test_emit_sample() {
> > > +	sbx_add "test_emit_sample" || return $?
> > > +
> > > +	# Add a datapath with per-vport dispatching.
> > > +	ovs_add_dp "test_emit_sample" emit_sample -V 2:1 || return 1
> > > +
> > > +	info "create namespaces"
> > > +	ovs_add_netns_and_veths "test_emit_sample" "emit_sample" \
> > > +		client c0 c1 172.31.110.10/24 -u || return 1
> > > +	ovs_add_netns_and_veths "test_emit_sample" "emit_sample" \
> > > +		server s0 s1 172.31.110.20/24 -u || return 1
> > > +
> > > +	# Check if emit_sample actions can be configured.
> > > +	ovs_add_flow "test_emit_sample" emit_sample \
> > > +	'in_port(1),eth(),eth_type(0x0806),arp()' 'emit_sample(group=3D1)'
> > > +	if [ $? =3D=3D 1 ]; then
> > > +		info "no support for emit_sample - skipping"
> > > +		ovs_exit_sig
> > > +		return $ksft_skip
> > > +	fi
> > > +
> > > +	ovs_del_flows "test_emit_sample" emit_sample
> > > +
> > > +	# Allow ARP
> > > +	ovs_add_flow "test_emit_sample" emit_sample \
> > > +		'in_port(1),eth(),eth_type(0x0806),arp()' '2' || return 1
> > > +	ovs_add_flow "test_emit_sample" emit_sample \
> > > +		'in_port(2),eth(),eth_type(0x0806),arp()' '1' || return 1
> > > +
> > > +	# Test action verification.
> > > +	OLDIFS=3D$IFS
> > > +	IFS=3D'*'
> > > +	min_key=3D'in_port(1),eth(),eth_type(0x0800),ipv4()'
> > > +	for testcase in \
> > > +		"cookie to large"*"emit_sample(group=3D1,cookie=3D1615141312111009=
080706050403020100)" \
> > > +		"no group with cookie"*"emit_sample(cookie=3Dabcd)" \
> > > +		"no group"*"sample()";
> > > +	do
> > > +		set -- $testcase;
> > > +		ovs_test_flow_fails "test_emit_sample" emit_sample $min_key $2
> > > +		if [ $? =3D=3D 1 ]; then
> > > +			info "failed - $1"
> > > +			return 1
> > > +		fi
> > > +	done
> > > +	IFS=3D$OLDIFS
> > > +
> > > +	# Sample first 14 bytes of all traffic.
> > > +	ovs_add_flow "test_emit_sample" emit_sample \
> > > +	"in_port(1),eth(),eth_type(0x0800),ipv4(src=3D172.31.110.10,proto=
=3D1),icmp()" "trunc(14),emit_sample(group=3D1,cookie=3Dc0ffee),2"
> > > +
> > > +	# Sample all traffic. In this case, use a sample() action with both
> > > +	# emit_sample and an upcall emulating simultaneous local sampling a=
nd
> > > +	# sFlow / IPFIX.
> > > +	nlpid=3D$(grep -E "listening on upcall packet handler" $ovs_dir/s0.=
out | cut -d ":" -f 2 | tr -d ' ')
> > > +	ovs_add_flow "test_emit_sample" emit_sample \
> > > +	"in_port(2),eth(),eth_type(0x0800),ipv4(src=3D172.31.110.20,proto=
=3D1),icmp()" "sample(sample=3D100%,actions(emit_sample(group=3D2,cookie=3D=
eeff0c),userspace(pid=3D${nlpid},userdata=3Deeff0c))),1"
> > > +
> > > +	# Record emit_sample data.
> > > +	python3 $ovs_base/ovs-dpctl.py psample >$ovs_dir/psample.out 2>$ovs=
_dir/psample.err &
> > > +	pid=3D$!
> > > +	on_exit "ovs_sbx test_emit_sample kill -TERM $pid 2>/dev/null"
> >
> >   Maybe ovs_netns_spawn_daemon ?
> >
>
> I'll take a look at it, thanks.
>

I've looked into ovs_netns_spawn_daemon and I think it'll not be useful
for this command since it needs to run in the default namespace. I can
add a new "ovs_spawn_daemon" so it's reusable. WDYT?

> [...]


