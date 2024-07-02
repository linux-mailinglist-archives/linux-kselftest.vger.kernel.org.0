Return-Path: <linux-kselftest+bounces-13056-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12BEE923CC1
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Jul 2024 13:45:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC8C4289203
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Jul 2024 11:45:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B77C615B0FE;
	Tue,  2 Jul 2024 11:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AzyKRmfu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD1B2179AF
	for <linux-kselftest@vger.kernel.org>; Tue,  2 Jul 2024 11:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719920734; cv=none; b=rUg55S5ekd0fmPymY76r1gRyo81rG8HRVD8w0U7IbcXvcVWR3qnqN+cZGaeuuRwntgFoc40AhJIQ8sxxcOE/NOLdn3665cJspu+C2SNxxvRV/M+2Br+L4V3AjNg+9p7UHsnoJtUMiB3Q1PqmbY0vAwyd/k1/BcGxrhyjQOPFU30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719920734; c=relaxed/simple;
	bh=itu6pNVdyfoB76DotsYaSiqN7adMJczc3AiHky6OHEc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XSBF0SDdcZ8Jx+L28h70Y4j2PjbjQUv2N1lgWAGkBMKoHDdikOBbxe1tliHO7xknbZ7BLbfgeCbUqT0KjeuNDwfFWPp8HYBvfaZR9SieTr46X/+KIpXuQT+ZrBkWR1cHlLlWUsgPyKY4tdqkzPd1IHZPQNPQZOFzpZkZKJ5Stzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AzyKRmfu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719920731;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2ZSuG4jg6fN5yoroR9xZLM4JS/xKphek81wZ95P4CUI=;
	b=AzyKRmfuWgiKoryBY7NtsyC1G6jtyiXUxHk0WjAi/9ReslaR4vV9a/Whb+RRpCIqxok76W
	saCf3+3j78yCNecQre4zyiUkR44oE13BxWx6dyp5GKu4IDwIxoY5DCBCSDvGNSunybjDIx
	l54uDFzNjWoiasVHtTC2oyVuWA5yGyU=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-99-t9pzsh9oMdCjeV82ll5z8g-1; Tue,
 02 Jul 2024 07:45:28 -0400
X-MC-Unique: t9pzsh9oMdCjeV82ll5z8g-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D6B1F19560A7;
	Tue,  2 Jul 2024 11:45:26 +0000 (UTC)
Received: from RHTRH0061144 (unknown [10.22.8.184])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7ECAF1956089;
	Tue,  2 Jul 2024 11:45:23 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: =?utf-8?Q?Adri=C3=A1n?= Moreno <amorenoz@redhat.com>
Cc: netdev@vger.kernel.org,  echaudro@redhat.com,  horms@kernel.org,
  i.maximets@ovn.org,  dev@openvswitch.org,  Pravin B Shelar
 <pshelar@ovn.org>,  "David S. Miller" <davem@davemloft.net>,  Eric Dumazet
 <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>,  Paolo Abeni
 <pabeni@redhat.com>,  Shuah Khan <shuah@kernel.org>,
  linux-kselftest@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v7 10/10] selftests: openvswitch: add psample test
In-Reply-To: <CAG=2xmNSe7TB0CBD9stYf8dDex6dPo_smr79rYGXZC0AXGEzWA@mail.gmail.com>
	(=?utf-8?Q?=22Adri=C3=A1n?= Moreno"'s message of "Tue, 2 Jul 2024 02:16:49
 -0500")
References: <20240630195740.1469727-1-amorenoz@redhat.com>
	<20240630195740.1469727-11-amorenoz@redhat.com>
	<f7tfrstvtxn.fsf@redhat.com>
	<CAG=2xmNSe7TB0CBD9stYf8dDex6dPo_smr79rYGXZC0AXGEzWA@mail.gmail.com>
Date: Tue, 02 Jul 2024 07:45:21 -0400
Message-ID: <f7to77gow4u.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Adri=C3=A1n Moreno <amorenoz@redhat.com> writes:

> On Mon, Jul 01, 2024 at 02:38:44PM GMT, Aaron Conole wrote:
>> Adrian Moreno <amorenoz@redhat.com> writes:
>>
>> > Add a test to verify sampling packets via psample works.
>> >
>> > In order to do that, create a subcommand in ovs-dpctl.py to listen to
>> > on the psample multicast group and print samples.
>> >
>> > Signed-off-by: Adrian Moreno <amorenoz@redhat.com>
>> > ---
>> >  .../selftests/net/openvswitch/openvswitch.sh  | 115 +++++++++++++++++-
>> >  .../selftests/net/openvswitch/ovs-dpctl.py    |  73 ++++++++++-
>> >  2 files changed, 182 insertions(+), 6 deletions(-)
>> >
>> > diff --git a/tools/testing/selftests/net/openvswitch/openvswitch.sh b/=
tools/testing/selftests/net/openvswitch/openvswitch.sh
>> > index 15bca0708717..02a366e01004 100755
>> > --- a/tools/testing/selftests/net/openvswitch/openvswitch.sh
>> > +++ b/tools/testing/selftests/net/openvswitch/openvswitch.sh
>> > @@ -20,7 +20,8 @@ tests=3D"
>> >  	nat_related_v4				ip4-nat-related: ICMP related matches work with SN=
AT
>> >  	netlink_checks				ovsnl: validate netlink attrs and settings
>> >  	upcall_interfaces			ovs: test the upcall interfaces
>> > -	drop_reason				drop: test drop reasons are emitted"
>> > +	drop_reason				drop: test drop reasons are emitted
>> > +	psample					psample: Sampling packets with psample"
>> >
>> >  info() {
>> >      [ $VERBOSE =3D 0 ] || echo $*
>> > @@ -102,12 +103,21 @@ ovs_netns_spawn_daemon() {
>> >  	shift
>> >  	netns=3D$1
>> >  	shift
>> > -	info "spawning cmd: $*"
>> > -	ip netns exec $netns $*  >> $ovs_dir/stdout  2>> $ovs_dir/stderr &
>> > +	if [ "$netns" =3D=3D "_default" ]; then
>> > +		$*  >> $ovs_dir/stdout  2>> $ovs_dir/stderr &
>> > +	else
>> > +		ip netns exec $netns $*  >> $ovs_dir/stdout  2>> $ovs_dir/stderr &
>> > +	fi
>> >  	pid=3D$!
>> >  	ovs_sbx "$sbx" on_exit "kill -TERM $pid 2>/dev/null"
>> >  }
>> >
>> > +ovs_spawn_daemon() {
>> > +	sbx=3D$1
>> > +	shift
>> > +	ovs_netns_spawn_daemon $sbx "_default" $*
>> > +}
>> > +
>> >  ovs_add_netns_and_veths () {
>> >  	info "Adding netns attached: sbx:$1 dp:$2 {$3, $4, $5}"
>> >  	ovs_sbx "$1" ip netns add "$3" || return 1
>> > @@ -170,6 +180,19 @@ ovs_drop_reason_count()
>> >  	return `echo "$perf_output" | grep "$pattern" | wc -l`
>> >  }
>> >
>> > +ovs_test_flow_fails () {
>> > +	ERR_MSG=3D"Flow actions may not be safe on all matching packets"
>> > +
>> > +	PRE_TEST=3D$(dmesg | grep -c "${ERR_MSG}")
>> > +	ovs_add_flow $@ &> /dev/null $@ && return 1
>> > +	POST_TEST=3D$(dmesg | grep -c "${ERR_MSG}")
>> > +
>> > +	if [ "$PRE_TEST" =3D=3D "$POST_TEST" ]; then
>> > +		return 1
>> > +	fi
>> > +	return 0
>> > +}
>> > +
>> >  usage() {
>> >  	echo
>> >  	echo "$0 [OPTIONS] [TEST]..."
>> > @@ -184,6 +207,92 @@ usage() {
>> >  	exit 1
>> >  }
>> >
>> > +
>> > +# psample test
>> > +# - use psample to observe packets
>> > +test_psample() {
>> > +	sbx_add "test_psample" || return $?
>> > +
>> > +	# Add a datapath with per-vport dispatching.
>> > +	ovs_add_dp "test_psample" psample -V 2:1 || return 1
>> > +
>> > +	info "create namespaces"
>> > +	ovs_add_netns_and_veths "test_psample" "psample" \
>> > +		client c0 c1 172.31.110.10/24 -u || return 1
>> > +	ovs_add_netns_and_veths "test_psample" "psample" \
>> > +		server s0 s1 172.31.110.20/24 -u || return 1
>> > +
>> > +	# Check if psample actions can be configured.
>> > +	ovs_add_flow "test_psample" psample \
>> > +	'in_port(1),eth(),eth_type(0x0806),arp()' 'psample(group=3D1)'
>>
>> Might be good to redirect this stdout/stderr line to /dev/null -
>> otherwise on an unsupported system there will be the following extra
>> splat:
>>
>>   Traceback (most recent call last):
>>     File "/home/aconole/git/linux/tools/testing/selftests/net/openvswitc=
h/ovs-dpctl.py", line 2774, in <module>
>>       sys.exit(main(sys.argv))
>>    ...
>>     File "/usr/lib/python3.12/site-packages/pyroute2/netlink/nlsocket.py=
", line 489, in get
>>       raise msg['header']['error']
>>   pyroute2.netlink.exceptions.NetlinkError: (22, 'Invalid argument')
>>
>
> I thought knowing the return value was kind of useful but sure, we can
> redirect it to /dev/null.
>
>> > +	if [ $? =3D=3D 1 ]; then
>> > +		info "no support for psample - skipping"
>> > +		ovs_exit_sig
>> > +		return $ksft_skip
>> > +	fi
>> > +
>> > +	ovs_del_flows "test_psample" psample
>> > +
>> > +	# Test action verification.
>> > +	OLDIFS=3D$IFS
>> > +	IFS=3D'*'
>> > +	min_key=3D'in_port(1),eth(),eth_type(0x0800),ipv4()'
>> > +	for testcase in \
>> > + "cookie to
>> > large"*"psample(group=3D1,cookie=3D1615141312111009080706050403020100)"
>> > \
>> > +		"no group with cookie"*"psample(cookie=3Dabcd)" \
>> > +		"no group"*"psample()";
>> > +	do
>> > +		set -- $testcase;
>> > +		ovs_test_flow_fails "test_psample" psample $min_key $2
>> > +		if [ $? =3D=3D 1 ]; then
>> > +			info "failed - $1"
>> > +			return 1
>> > +		fi
>> > +	done
>> > +	IFS=3D$OLDIFS
>> > +
>> > +	ovs_del_flows "test_psample" psample
>> > +	# Allow ARP
>> > +	ovs_add_flow "test_psample" psample \
>> > +		'in_port(1),eth(),eth_type(0x0806),arp()' '2' || return 1
>> > +	ovs_add_flow "test_psample" psample \
>> > +		'in_port(2),eth(),eth_type(0x0806),arp()' '1' || return 1
>> > +
>> > +	# Sample first 14 bytes of all traffic.
>> > +	ovs_add_flow "test_psample" psample \
>> > +	    "in_port(1),eth(),eth_type(0x0800),ipv4()" \
>> > +            "trunc(14),psample(group=3D1,cookie=3Dc0ffee),2"
>> > +
>> > +	# Sample all traffic. In this case, use a sample() action with both
>> > +	# psample and an upcall emulating simultaneous local sampling and
>> > +	# sFlow / IPFIX.
>> > +	nlpid=3D$(grep -E "listening on upcall packet handler" \
>> > +            $ovs_dir/s0.out | cut -d ":" -f 2 | tr -d ' ')
>> > +
>> > +	ovs_add_flow "test_psample" psample \
>> > +            "in_port(2),eth(),eth_type(0x0800),ipv4()" \
>> > +
>> > "sample(sample=3D100%,actions(psample(group=3D2,cookie=3Deeff0c),users=
pace(pid=3D${nlpid},userdata=3Deeff0c))),1"
>> > +
>> > +	# Record psample data.
>> > + ovs_spawn_daemon "test_psample" python3 $ovs_base/ovs-dpctl.py
>> > psample-events
>> > +
>> > +	# Send a single ping.
>> > +	sleep 1
>> > + ovs_sbx "test_psample" ip netns exec client ping -I c1
>> > 172.31.110.20 -c 1 || return 1
>> > +	sleep 1
>> > +
>> > + # We should have received one userspace action upcall and 2
>> > psample packets.
>> > + grep -E "userspace action command" $ovs_dir/s0.out >/dev/null
>> > 2>&1 || return 1
>>
>> I wonder if it would be better to check a few times instead of the one
>> shot sleep.  There are some constrained environments that may run this
>> test, and if you're worried about some kinds of races, maybe it makes
>> sense to check a few times?
>
> Yes. I thought about that. There are other sleeps in this file that I
> was planning to replace with a "wait_until()" function. Should we do
> this as a follow-up patch to also cover the other instances?

That makes sense to me.

>>
>> Outside of that:
>>
>> Reviewed-by: Aaron Conole <aconole@redhat.com>
>>
>> > +
>> > +	# client -> server samples should only contain the first 14 bytes of=
 the packet.
>> > +	grep -E "rate:4294967295,group:1,cookie:c0ffee data:[0-9a-f]{28}$" \
>> > +			 $ovs_dir/stdout >/dev/null 2>&1 || return 1
>> > +	grep -E "rate:4294967295,group:2,cookie:eeff0c" \
>> > +			 $ovs_dir/stdout >/dev/null 2>&1 || return 1
>> > +
>> > +	return 0
>> > +}
>> > +
>> >  # drop_reason test
>> >  # - drop packets and verify the right drop reason is reported
>> >  test_drop_reason() {
>> > diff --git a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py b/to=
ols/testing/selftests/net/openvswitch/ovs-dpctl.py
>> > index e8dc9af10d4d..1e15b0818074 100644
>> > --- a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
>> > +++ b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
>> > @@ -28,8 +28,10 @@ try:
>> >      from pyroute2.netlink import genlmsg
>> >      from pyroute2.netlink import nla
>> >      from pyroute2.netlink import nlmsg_atoms
>> > +    from pyroute2.netlink.event import EventSocket
>> >      from pyroute2.netlink.exceptions eimport NetlinkError
>> >      from pyroute2.netlink.generic import GenericNetlinkSocket
>> > +    from pyroute2.netlink.nlsocket import Marshal
>> >      import pyroute2
>> >      import pyroute2.iproute
>> >
>> > @@ -2460,10 +2462,70 @@ class OvsFlow(GenericNetlinkSocket):
>> >          print("MISS upcall[%d/%s]: %s" % (seq, pktpres, keystr), flus=
h=3DTrue)
>> >
>> >      def execute(self, packetmsg):
>> > -        print("userspace execute command")
>> > +        print("userspace execute command", flush=3DTrue)
>> >
>> >      def action(self, packetmsg):
>> > -        print("userspace action command")
>> > +        print("userspace action command", flush=3DTrue)
>> > +
>> > +
>> > +class psample_sample(genlmsg):
>> > +    nla_map =3D (
>> > +        ("PSAMPLE_ATTR_IIFINDEX", "none"),
>> > +        ("PSAMPLE_ATTR_OIFINDEX", "none"),
>> > +        ("PSAMPLE_ATTR_ORIGSIZE", "none"),
>> > +        ("PSAMPLE_ATTR_SAMPLE_GROUP", "uint32"),
>> > +        ("PSAMPLE_ATTR_GROUP_SEQ", "none"),
>> > +        ("PSAMPLE_ATTR_SAMPLE_RATE", "uint32"),
>> > +        ("PSAMPLE_ATTR_DATA", "array(uint8)"),
>> > +        ("PSAMPLE_ATTR_GROUP_REFCOUNT", "none"),
>> > +        ("PSAMPLE_ATTR_TUNNEL", "none"),
>> > +        ("PSAMPLE_ATTR_PAD", "none"),
>> > +        ("PSAMPLE_ATTR_OUT_TC", "none"),
>> > +        ("PSAMPLE_ATTR_OUT_TC_OCC", "none"),
>> > +        ("PSAMPLE_ATTR_LATENCY", "none"),
>> > +        ("PSAMPLE_ATTR_TIMESTAMP", "none"),
>> > +        ("PSAMPLE_ATTR_PROTO", "none"),
>> > +        ("PSAMPLE_ATTR_USER_COOKIE", "array(uint8)"),
>> > +    )
>> > +
>> > +    def dpstr(self):
>> > +        fields =3D []
>> > +        data =3D ""
>> > +        for (attr, value) in self["attrs"]:
>> > +            if attr =3D=3D "PSAMPLE_ATTR_SAMPLE_GROUP":
>> > +                fields.append("group:%d" % value)
>> > +            if attr =3D=3D "PSAMPLE_ATTR_SAMPLE_RATE":
>> > +                fields.append("rate:%d" % value)
>> > +            if attr =3D=3D "PSAMPLE_ATTR_USER_COOKIE":
>> > +                value =3D "".join(format(x, "02x") for x in value)
>> > +                fields.append("cookie:%s" % value)
>> > +            if attr =3D=3D "PSAMPLE_ATTR_DATA" and len(value) > 0:
>> > +                data =3D "data:%s" % "".join(format(x, "02x") for x i=
n value)
>> > +
>> > +        return ("%s %s" % (",".join(fields), data)).strip()
>> > +
>> > +
>> > +class psample_msg(Marshal):
>> > +    PSAMPLE_CMD_SAMPLE =3D 0
>> > +    PSAMPLE_CMD_GET_GROUP =3D 1
>> > +    PSAMPLE_CMD_NEW_GROUP =3D 2
>> > +    PSAMPLE_CMD_DEL_GROUP =3D 3
>> > +    PSAMPLE_CMD_SET_FILTER =3D 4
>> > +    msg_map =3D {PSAMPLE_CMD_SAMPLE: psample_sample}
>> > +
>> > +
>> > +class PsampleEvent(EventSocket):
>> > +    genl_family =3D "psample"
>> > +    mcast_groups =3D ["packets"]
>> > +    marshal_class =3D psample_msg
>> > +
>> > +    def read_samples(self):
>> > +        while True:
>> > +            try:
>> > +                for msg in self.get():
>> > +                    print(msg.dpstr(), flush=3DTrue)
>> > +            except NetlinkError as ne:
>> > +                raise ne
>> >
>> >
>> >  def print_ovsdp_full(dp_lookup_rep, ifindex, ndb=3DNDB(), vpl=3DOvsVp=
ort()):
>> > @@ -2530,7 +2592,7 @@ def main(argv):
>> >          help=3D"Increment 'verbose' output counter.",
>> >          default=3D0,
>> >      )
>> > -    subparsers =3D parser.add_subparsers()
>> > +    subparsers =3D parser.add_subparsers(dest=3D"subcommand")
>> >
>> >      showdpcmd =3D subparsers.add_parser("show")
>> >      showdpcmd.add_argument(
>> > @@ -2605,6 +2667,8 @@ def main(argv):
>> >      delfscmd =3D subparsers.add_parser("del-flows")
>> >      delfscmd.add_argument("flsbr", help=3D"Datapath name")
>> >
>> > +    subparsers.add_parser("psample-events")
>> > +
>> >      args =3D parser.parse_args()
>> >
>> >      if args.verbose > 0:
>> > @@ -2619,6 +2683,9 @@ def main(argv):
>> >
>> >      sys.setrecursionlimit(100000)
>> >
>> > +    if args.subcommand =3D=3D "psample-events":
>> > +        PsampleEvent().read_samples()
>> > +
>> >      if hasattr(args, "showdp"):
>> >          found =3D False
>> >          for iface in ndb.interfaces:
>>


