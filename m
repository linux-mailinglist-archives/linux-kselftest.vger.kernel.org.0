Return-Path: <linux-kselftest+bounces-12153-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81EB090D2C0
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jun 2024 15:53:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76EBB285055
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jun 2024 13:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16E3114882B;
	Tue, 18 Jun 2024 13:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SKZIQl0O"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D95813F441
	for <linux-kselftest@vger.kernel.org>; Tue, 18 Jun 2024 13:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718717292; cv=none; b=Ua5r3jEBueT1cbya0hSA312FulzZmEiSBzYerezkmYzT03lnG4fmGeBaYTm/BnSpP0EIj9eZi0244tmVn32hnTI6VrG7XfldQI519528dZtCbscF09lKOosGrzrbe4qZxM73TNmxcCdmzIe/wcSuyoIDIZaddsTDFUy1Ee+YpXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718717292; c=relaxed/simple;
	bh=w7UA21E8727CURep6Q4a3EaARXcCZGoKJ2hh9jNwujU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RnBYB1EZQN9PknTkJyOZISUGXsJtWtikuJDbvuzQYh26ztlFS6gL81VhqwDN8qqQcCqDNsH34zJRCizXMb/lpJKEzFm09TNw8Hh6sj/Lcwd5hFYlCnhSP9JRqnx6hnP+2p+qJPaA8tOufHuJcsP456FFhFFU2oONcSUgvmGALPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SKZIQl0O; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718717289;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QHQZyI1Ki5OZBByzaWYPnHf52cOaMXF9qafettPp8bg=;
	b=SKZIQl0OXmHGUbhzQTlN2Wgw8AVCoHVKi6+lHJUluTwkaoPNvXUtTiZikI5sH9pv91vSRL
	f+Vg2yrjX2//SJAcoizvaps6BHvEg/2Y5RQ9EV2V5Dbw/5Ue3MnzlchR/fL1evxyMG9/am
	DL5Utz1FK0+gSdCvTjohIjmDrZcWdV4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-457-FFdFBcDHMtedj7fSzWijvQ-1; Tue,
 18 Jun 2024 09:28:04 -0400
X-MC-Unique: FFdFBcDHMtedj7fSzWijvQ-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4793F19560B9;
	Tue, 18 Jun 2024 13:28:02 +0000 (UTC)
Received: from RHTRH0061144 (dhcp-17-72.bos.redhat.com [10.18.17.72])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C73A619560AF;
	Tue, 18 Jun 2024 13:27:59 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: =?utf-8?Q?Adri=C3=A1n?= Moreno <amorenoz@redhat.com>
Cc: netdev@vger.kernel.org,  echaudro@redhat.com,  horms@kernel.org,
  i.maximets@ovn.org,  dev@openvswitch.org,  Pravin B Shelar
 <pshelar@ovn.org>,  "David S. Miller" <davem@davemloft.net>,  Eric Dumazet
 <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>,  Paolo Abeni
 <pabeni@redhat.com>,  Shuah Khan <shuah@kernel.org>,
  linux-kselftest@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 9/9] selftests: openvswitch: add emit_sample
 test
In-Reply-To: <CAG=2xmO-mtQOMABEAXNxEoa6NH5Hgae1x5+XWU5ZnLFg2n7b=g@mail.gmail.com>
	(=?utf-8?Q?=22Adri=C3=A1n?= Moreno"'s message of "Tue, 18 Jun 2024 09:08:14
 +0000")
References: <20240603185647.2310748-1-amorenoz@redhat.com>
	<20240603185647.2310748-10-amorenoz@redhat.com>
	<f7tzfrnmp0q.fsf@redhat.com>
	<CAG=2xmPvAfQx4jSFbBPTcEdo2Z6w93vo6-Uo5rVMLbu8qS1SOA@mail.gmail.com>
	<CAG=2xmO-mtQOMABEAXNxEoa6NH5Hgae1x5+XWU5ZnLFg2n7b=g@mail.gmail.com>
Date: Tue, 18 Jun 2024 09:27:58 -0400
Message-ID: <f7tplsel6sh.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Adri=C3=A1n Moreno <amorenoz@redhat.com> writes:

> On Mon, Jun 17, 2024 at 07:18:05AM GMT, Adri=C3=A1n Moreno wrote:
>> On Fri, Jun 14, 2024 at 01:07:33PM GMT, Aaron Conole wrote:
>> > Adrian Moreno <amorenoz@redhat.com> writes:
>> >
>> > > Add a test to verify sampling packets via psample works.
>> > >
>> > > In order to do that, create a subcommand in ovs-dpctl.py to listen to
>> > > on the psample multicast group and print samples.
>> > >
>> > > In order to also test simultaneous sFlow and psample actions and
>> > > packet truncation, add missing parsing support for "userspace" and
>> > > "trunc" actions.
>> >
>> > Maybe split that into a separate patch.  This has a bugfix and 3
>> > features being pushed in.  I know it's already getting long as a serie=
s,
>> > so maybe it's okay to fold the userspace attribute bugfix with the par=
se
>> > support (since it wasn't really usable before).
>> >
>>
>> OK. Sounds reasonable.
>>
>> > > Signed-off-by: Adrian Moreno <amorenoz@redhat.com>
>> > > ---
>> > >  .../selftests/net/openvswitch/openvswitch.sh  |  99 +++++++++++++++-
>> > >  .../selftests/net/openvswitch/ovs-dpctl.py    | 112 +++++++++++++++=
++-
>> > >  2 files changed, 204 insertions(+), 7 deletions(-)
>> > >
>> > > diff --git a/tools/testing/selftests/net/openvswitch/openvswitch.sh =
b/tools/testing/selftests/net/openvswitch/openvswitch.sh
>> > > index 5cae53543849..f6e0ae3f6424 100755
>> > > --- a/tools/testing/selftests/net/openvswitch/openvswitch.sh
>> > > +++ b/tools/testing/selftests/net/openvswitch/openvswitch.sh
>> > > @@ -20,7 +20,8 @@ tests=3D"
>> > >  	nat_related_v4				ip4-nat-related: ICMP related matches work with =
SNAT
>> > >  	netlink_checks				ovsnl: validate netlink attrs and settings
>> > >  	upcall_interfaces			ovs: test the upcall interfaces
>> > > -	drop_reason				drop: test drop reasons are emitted"
>> > > +	drop_reason				drop: test drop reasons are emitted
>> > > +	emit_sample 				emit_sample: Sampling packets with psample"
>> > >
>> > >  info() {
>> > >      [ $VERBOSE =3D 0 ] || echo $*
>> > > @@ -170,6 +171,19 @@ ovs_drop_reason_count()
>> > >  	return `echo "$perf_output" | grep "$pattern" | wc -l`
>> > >  }
>> > >
>> > > +ovs_test_flow_fails () {
>> > > +	ERR_MSG=3D"Flow actions may not be safe on all matching packets"
>> > > +
>> > > +	PRE_TEST=3D$(dmesg | grep -c "${ERR_MSG}")
>> > > +	ovs_add_flow $@ &> /dev/null $@ && return 1
>> > > +	POST_TEST=3D$(dmesg | grep -c "${ERR_MSG}")
>> > > +
>> > > +	if [ "$PRE_TEST" =3D=3D "$POST_TEST" ]; then
>> > > +		return 1
>> > > +	fi
>> > > +	return 0
>> > > +}
>> > > +
>> > >  usage() {
>> > >  	echo
>> > >  	echo "$0 [OPTIONS] [TEST]..."
>> > > @@ -184,6 +198,89 @@ usage() {
>> > >  	exit 1
>> > >  }
>> > >
>> > > +
>> > > +# emit_sample test
>> > > +# - use emit_sample to observe packets
>> > > +test_emit_sample() {
>> > > +	sbx_add "test_emit_sample" || return $?
>> > > +
>> > > +	# Add a datapath with per-vport dispatching.
>> > > +	ovs_add_dp "test_emit_sample" emit_sample -V 2:1 || return 1
>> > > +
>> > > +	info "create namespaces"
>> > > +	ovs_add_netns_and_veths "test_emit_sample" "emit_sample" \
>> > > +		client c0 c1 172.31.110.10/24 -u || return 1
>> > > +	ovs_add_netns_and_veths "test_emit_sample" "emit_sample" \
>> > > +		server s0 s1 172.31.110.20/24 -u || return 1
>> > > +
>> > > +	# Check if emit_sample actions can be configured.
>> > > +	ovs_add_flow "test_emit_sample" emit_sample \
>> > > +	'in_port(1),eth(),eth_type(0x0806),arp()' 'emit_sample(group=3D1)'
>> > > +	if [ $? =3D=3D 1 ]; then
>> > > +		info "no support for emit_sample - skipping"
>> > > +		ovs_exit_sig
>> > > +		return $ksft_skip
>> > > +	fi
>> > > +
>> > > +	ovs_del_flows "test_emit_sample" emit_sample
>> > > +
>> > > +	# Allow ARP
>> > > +	ovs_add_flow "test_emit_sample" emit_sample \
>> > > +		'in_port(1),eth(),eth_type(0x0806),arp()' '2' || return 1
>> > > +	ovs_add_flow "test_emit_sample" emit_sample \
>> > > +		'in_port(2),eth(),eth_type(0x0806),arp()' '1' || return 1
>> > > +
>> > > +	# Test action verification.
>> > > +	OLDIFS=3D$IFS
>> > > +	IFS=3D'*'
>> > > +	min_key=3D'in_port(1),eth(),eth_type(0x0800),ipv4()'
>> > > +	for testcase in \
>> > > +		"cookie to large"*"emit_sample(group=3D1,cookie=3D161514131211100=
9080706050403020100)" \
>> > > +		"no group with cookie"*"emit_sample(cookie=3Dabcd)" \
>> > > +		"no group"*"sample()";
>> > > +	do
>> > > +		set -- $testcase;
>> > > +		ovs_test_flow_fails "test_emit_sample" emit_sample $min_key $2
>> > > +		if [ $? =3D=3D 1 ]; then
>> > > +			info "failed - $1"
>> > > +			return 1
>> > > +		fi
>> > > +	done
>> > > +	IFS=3D$OLDIFS
>> > > +
>> > > +	# Sample first 14 bytes of all traffic.
>> > > +	ovs_add_flow "test_emit_sample" emit_sample \
>> > > +	"in_port(1),eth(),eth_type(0x0800),ipv4(src=3D172.31.110.10,proto=
=3D1),icmp()" "trunc(14),emit_sample(group=3D1,cookie=3Dc0ffee),2"
>> > > +
>> > > +	# Sample all traffic. In this case, use a sample() action with both
>> > > +	# emit_sample and an upcall emulating simultaneous local sampling =
and
>> > > +	# sFlow / IPFIX.
>> > > +	nlpid=3D$(grep -E "listening on upcall packet handler" $ovs_dir/s0=
.out | cut -d ":" -f 2 | tr -d ' ')
>> > > +	ovs_add_flow "test_emit_sample" emit_sample \
>> > > +	"in_port(2),eth(),eth_type(0x0800),ipv4(src=3D172.31.110.20,proto=
=3D1),icmp()" "sample(sample=3D100%,actions(emit_sample(group=3D2,cookie=3D=
eeff0c),userspace(pid=3D${nlpid},userdata=3Deeff0c))),1"
>> > > +
>> > > +	# Record emit_sample data.
>> > > +	python3 $ovs_base/ovs-dpctl.py psample >$ovs_dir/psample.out 2>$ov=
s_dir/psample.err &
>> > > +	pid=3D$!
>> > > +	on_exit "ovs_sbx test_emit_sample kill -TERM $pid 2>/dev/null"
>> >
>> >   Maybe ovs_netns_spawn_daemon ?
>> >
>>
>> I'll take a look at it, thanks.
>>
>
> I've looked into ovs_netns_spawn_daemon and I think it'll not be useful
> for this command since it needs to run in the default namespace. I can
> add a new "ovs_spawn_daemon" so it's reusable. WDYT?

Okay

>> [...]


