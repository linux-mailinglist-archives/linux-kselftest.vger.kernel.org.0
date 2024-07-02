Return-Path: <linux-kselftest+bounces-13039-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10CC091EFDC
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Jul 2024 09:17:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD006285E12
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Jul 2024 07:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7DFA1304AB;
	Tue,  2 Jul 2024 07:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J3VN050C"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F5512B83
	for <linux-kselftest@vger.kernel.org>; Tue,  2 Jul 2024 07:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719904616; cv=none; b=pQlnUJYLsvG3pqGAlUz6o2sRb/z64g1FtWEVuvhGT6OMFEGObK3S7Ax2L5rynk1Avkvs+zaJ0RvQVvSSL/JG2hQ5u6qCN3oAm6Orpb6syouoUfteAOAHIwSnhIRPqxD/JTcnqYxR0xPctyIsHs12wY7iArelfotEPRpAGbu+MIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719904616; c=relaxed/simple;
	bh=UZHLLYGzvUHUiJZOcGyQ4eSKm26ShzVO1YUThj8jvJE=;
	h=From:References:MIME-Version:In-Reply-To:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UUNZrxrfO1qrffLqGdX1DnWqkH5es3kZOK4j6QwIqrk2GutavwSRIsWEE4WcKtDzjZ8g5eci/XXCukKeKlEnZKM6vxxisHtE8ut+TGyCHtCmL7AqaZJnYMwhapREeiAw9NQQnwq8pe1gbTThLRvDF7i6C9CUG6Yd0vldKYowHt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J3VN050C; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719904614;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QcP/P2SMOKTCSPA788q4Z9zVnw3yOGHH+fjYT4/I7Zo=;
	b=J3VN050C1nbEA4TYHEzqGgG6cPqLhKU5Fy2jN7OA2MpC5kj3+uG3sZFx8qv7FPGakCsJ6J
	Xksr7+yXgEBpZcGWWC3Kaqerm5+IlJFP+afmqG/SeP4O0V2qD8ywtFjzaVEXjRjWD667Y4
	8x9zSIfbYQx0Wa915kY1lVtb+TXFqG0=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-314-YObWHpGGM3WqU5vkxzxNEQ-1; Tue, 02 Jul 2024 03:16:52 -0400
X-MC-Unique: YObWHpGGM3WqU5vkxzxNEQ-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2c8c1912a3bso2922622a91.1
        for <linux-kselftest@vger.kernel.org>; Tue, 02 Jul 2024 00:16:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719904611; x=1720509411;
        h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QcP/P2SMOKTCSPA788q4Z9zVnw3yOGHH+fjYT4/I7Zo=;
        b=ELGlt6Es/iN/EW4ngnEJdNEfX5fkGPGOrC+vEQa81iRvhI4q+Jkgb/+dnl3nHIPGXN
         j8xedC9r5ZGQrmmOwuhXADqOahdgiLjsympnMEsuopfXcfdcWojzUFrOCbPraz/gAs2B
         EQUMpcnrbicEw/a7/4bzi7voIBUSYGtd2NfDVDuha0BIlKA6WMUJuOxilD5YpzrQLUkb
         YpUmNYgIBEs+whp6vh7lssdaTbqGSIRmAD1HupibbJmhv/Dgw2Mf068tL7s7jdM5fj6N
         fFc+/uNwLO/hgimBaIMhP3oPnYeI+WpNYHttLio7hG0bn/0/fE9Xe+IefN81+x7Go1Zp
         zrPA==
X-Forwarded-Encrypted: i=1; AJvYcCWcgp59i37+/MmZ3rtDhK8SYh73SIvq7eR+Qnp82QynEt/fFeWxkBfaTeNmz38RmOlbhtHd5SQVvMtdL4xowWzlE4fRfFHfXX09UtV0/Q6I
X-Gm-Message-State: AOJu0YyTJKTN50YWc3soE9PGikvoRuF77Y+qEJh3PycCMpBpq9nWjnSI
	4PUcfgy1PgnTHEBPyC9hMMePXa8irtN6lapG74NmLgwuL5g/T+TrgN2YOQda7JlFXfjrWOveMM4
	2IuLUUPR3JTQPHd8O6oN7XdGXRBdag6/5x+iP9Nk67isJs3g7DBb2HfDmvw/DJOS57hfLaZeLwi
	6Amz+dPy0y/nAeYpPX2mKGjS5sm4nFWwO7QDu4L29s
X-Received: by 2002:a17:90a:fd8e:b0:2c7:ad5e:8162 with SMTP id 98e67ed59e1d1-2c93d6f3b6bmr4130172a91.16.1719904611441;
        Tue, 02 Jul 2024 00:16:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGqNE1Kwa3fc2ZPMWoH3gKh3xdu+gKOZfhgn7ZdZazJB5k9mUwJkpJNooUk4FRB9cEdmVU8y9pDMuNuw+YMFUE=
X-Received: by 2002:a17:90a:fd8e:b0:2c7:ad5e:8162 with SMTP id
 98e67ed59e1d1-2c93d6f3b6bmr4130155a91.16.1719904611006; Tue, 02 Jul 2024
 00:16:51 -0700 (PDT)
Received: from 311643009450 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 2 Jul 2024 02:16:49 -0500
From: =?UTF-8?Q?Adri=C3=A1n_Moreno?= <amorenoz@redhat.com>
References: <20240630195740.1469727-1-amorenoz@redhat.com> <20240630195740.1469727-11-amorenoz@redhat.com>
 <f7tfrstvtxn.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <f7tfrstvtxn.fsf@redhat.com>
Date: Tue, 2 Jul 2024 02:16:49 -0500
Message-ID: <CAG=2xmNSe7TB0CBD9stYf8dDex6dPo_smr79rYGXZC0AXGEzWA@mail.gmail.com>
Subject: Re: [PATCH net-next v7 10/10] selftests: openvswitch: add psample test
To: Aaron Conole <aconole@redhat.com>
Cc: netdev@vger.kernel.org, echaudro@redhat.com, horms@kernel.org, 
	i.maximets@ovn.org, dev@openvswitch.org, Pravin B Shelar <pshelar@ovn.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, Jul 01, 2024 at 02:38:44PM GMT, Aaron Conole wrote:
> Adrian Moreno <amorenoz@redhat.com> writes:
>
> > Add a test to verify sampling packets via psample works.
> >
> > In order to do that, create a subcommand in ovs-dpctl.py to listen to
> > on the psample multicast group and print samples.
> >
> > Signed-off-by: Adrian Moreno <amorenoz@redhat.com>
> > ---
> >  .../selftests/net/openvswitch/openvswitch.sh  | 115 +++++++++++++++++-
> >  .../selftests/net/openvswitch/ovs-dpctl.py    |  73 ++++++++++-
> >  2 files changed, 182 insertions(+), 6 deletions(-)
> >
> > diff --git a/tools/testing/selftests/net/openvswitch/openvswitch.sh b/tools/testing/selftests/net/openvswitch/openvswitch.sh
> > index 15bca0708717..02a366e01004 100755
> > --- a/tools/testing/selftests/net/openvswitch/openvswitch.sh
> > +++ b/tools/testing/selftests/net/openvswitch/openvswitch.sh
> > @@ -20,7 +20,8 @@ tests="
> >  	nat_related_v4				ip4-nat-related: ICMP related matches work with SNAT
> >  	netlink_checks				ovsnl: validate netlink attrs and settings
> >  	upcall_interfaces			ovs: test the upcall interfaces
> > -	drop_reason				drop: test drop reasons are emitted"
> > +	drop_reason				drop: test drop reasons are emitted
> > +	psample					psample: Sampling packets with psample"
> >
> >  info() {
> >      [ $VERBOSE = 0 ] || echo $*
> > @@ -102,12 +103,21 @@ ovs_netns_spawn_daemon() {
> >  	shift
> >  	netns=$1
> >  	shift
> > -	info "spawning cmd: $*"
> > -	ip netns exec $netns $*  >> $ovs_dir/stdout  2>> $ovs_dir/stderr &
> > +	if [ "$netns" == "_default" ]; then
> > +		$*  >> $ovs_dir/stdout  2>> $ovs_dir/stderr &
> > +	else
> > +		ip netns exec $netns $*  >> $ovs_dir/stdout  2>> $ovs_dir/stderr &
> > +	fi
> >  	pid=$!
> >  	ovs_sbx "$sbx" on_exit "kill -TERM $pid 2>/dev/null"
> >  }
> >
> > +ovs_spawn_daemon() {
> > +	sbx=$1
> > +	shift
> > +	ovs_netns_spawn_daemon $sbx "_default" $*
> > +}
> > +
> >  ovs_add_netns_and_veths () {
> >  	info "Adding netns attached: sbx:$1 dp:$2 {$3, $4, $5}"
> >  	ovs_sbx "$1" ip netns add "$3" || return 1
> > @@ -170,6 +180,19 @@ ovs_drop_reason_count()
> >  	return `echo "$perf_output" | grep "$pattern" | wc -l`
> >  }
> >
> > +ovs_test_flow_fails () {
> > +	ERR_MSG="Flow actions may not be safe on all matching packets"
> > +
> > +	PRE_TEST=$(dmesg | grep -c "${ERR_MSG}")
> > +	ovs_add_flow $@ &> /dev/null $@ && return 1
> > +	POST_TEST=$(dmesg | grep -c "${ERR_MSG}")
> > +
> > +	if [ "$PRE_TEST" == "$POST_TEST" ]; then
> > +		return 1
> > +	fi
> > +	return 0
> > +}
> > +
> >  usage() {
> >  	echo
> >  	echo "$0 [OPTIONS] [TEST]..."
> > @@ -184,6 +207,92 @@ usage() {
> >  	exit 1
> >  }
> >
> > +
> > +# psample test
> > +# - use psample to observe packets
> > +test_psample() {
> > +	sbx_add "test_psample" || return $?
> > +
> > +	# Add a datapath with per-vport dispatching.
> > +	ovs_add_dp "test_psample" psample -V 2:1 || return 1
> > +
> > +	info "create namespaces"
> > +	ovs_add_netns_and_veths "test_psample" "psample" \
> > +		client c0 c1 172.31.110.10/24 -u || return 1
> > +	ovs_add_netns_and_veths "test_psample" "psample" \
> > +		server s0 s1 172.31.110.20/24 -u || return 1
> > +
> > +	# Check if psample actions can be configured.
> > +	ovs_add_flow "test_psample" psample \
> > +	'in_port(1),eth(),eth_type(0x0806),arp()' 'psample(group=1)'
>
> Might be good to redirect this stdout/stderr line to /dev/null -
> otherwise on an unsupported system there will be the following extra
> splat:
>
>   Traceback (most recent call last):
>     File "/home/aconole/git/linux/tools/testing/selftests/net/openvswitch/ovs-dpctl.py", line 2774, in <module>
>       sys.exit(main(sys.argv))
>    ...
>     File "/usr/lib/python3.12/site-packages/pyroute2/netlink/nlsocket.py", line 489, in get
>       raise msg['header']['error']
>   pyroute2.netlink.exceptions.NetlinkError: (22, 'Invalid argument')
>

I thought knowing the return value was kind of useful but sure, we can
redirect it to /dev/null.

> > +	if [ $? == 1 ]; then
> > +		info "no support for psample - skipping"
> > +		ovs_exit_sig
> > +		return $ksft_skip
> > +	fi
> > +
> > +	ovs_del_flows "test_psample" psample
> > +
> > +	# Test action verification.
> > +	OLDIFS=$IFS
> > +	IFS='*'
> > +	min_key='in_port(1),eth(),eth_type(0x0800),ipv4()'
> > +	for testcase in \
> > +		"cookie to large"*"psample(group=1,cookie=1615141312111009080706050403020100)" \
> > +		"no group with cookie"*"psample(cookie=abcd)" \
> > +		"no group"*"psample()";
> > +	do
> > +		set -- $testcase;
> > +		ovs_test_flow_fails "test_psample" psample $min_key $2
> > +		if [ $? == 1 ]; then
> > +			info "failed - $1"
> > +			return 1
> > +		fi
> > +	done
> > +	IFS=$OLDIFS
> > +
> > +	ovs_del_flows "test_psample" psample
> > +	# Allow ARP
> > +	ovs_add_flow "test_psample" psample \
> > +		'in_port(1),eth(),eth_type(0x0806),arp()' '2' || return 1
> > +	ovs_add_flow "test_psample" psample \
> > +		'in_port(2),eth(),eth_type(0x0806),arp()' '1' || return 1
> > +
> > +	# Sample first 14 bytes of all traffic.
> > +	ovs_add_flow "test_psample" psample \
> > +	    "in_port(1),eth(),eth_type(0x0800),ipv4()" \
> > +            "trunc(14),psample(group=1,cookie=c0ffee),2"
> > +
> > +	# Sample all traffic. In this case, use a sample() action with both
> > +	# psample and an upcall emulating simultaneous local sampling and
> > +	# sFlow / IPFIX.
> > +	nlpid=$(grep -E "listening on upcall packet handler" \
> > +            $ovs_dir/s0.out | cut -d ":" -f 2 | tr -d ' ')
> > +
> > +	ovs_add_flow "test_psample" psample \
> > +            "in_port(2),eth(),eth_type(0x0800),ipv4()" \
> > +            "sample(sample=100%,actions(psample(group=2,cookie=eeff0c),userspace(pid=${nlpid},userdata=eeff0c))),1"
> > +
> > +	# Record psample data.
> > +	ovs_spawn_daemon "test_psample" python3 $ovs_base/ovs-dpctl.py psample-events
> > +
> > +	# Send a single ping.
> > +	sleep 1
> > +	ovs_sbx "test_psample" ip netns exec client ping -I c1 172.31.110.20 -c 1 || return 1
> > +	sleep 1
> > +
> > +	# We should have received one userspace action upcall and 2 psample packets.
> > +	grep -E "userspace action command" $ovs_dir/s0.out >/dev/null 2>&1 || return 1
>
> I wonder if it would be better to check a few times instead of the one
> shot sleep.  There are some constrained environments that may run this
> test, and if you're worried about some kinds of races, maybe it makes
> sense to check a few times?

Yes. I thought about that. There are other sleeps in this file that I
was planning to replace with a "wait_until()" function. Should we do
this as a follow-up patch to also cover the other instances?

>
> Outside of that:
>
> Reviewed-by: Aaron Conole <aconole@redhat.com>
>
> > +
> > +	# client -> server samples should only contain the first 14 bytes of the packet.
> > +	grep -E "rate:4294967295,group:1,cookie:c0ffee data:[0-9a-f]{28}$" \
> > +			 $ovs_dir/stdout >/dev/null 2>&1 || return 1
> > +	grep -E "rate:4294967295,group:2,cookie:eeff0c" \
> > +			 $ovs_dir/stdout >/dev/null 2>&1 || return 1
> > +
> > +	return 0
> > +}
> > +
> >  # drop_reason test
> >  # - drop packets and verify the right drop reason is reported
> >  test_drop_reason() {
> > diff --git a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
> > index e8dc9af10d4d..1e15b0818074 100644
> > --- a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
> > +++ b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
> > @@ -28,8 +28,10 @@ try:
> >      from pyroute2.netlink import genlmsg
> >      from pyroute2.netlink import nla
> >      from pyroute2.netlink import nlmsg_atoms
> > +    from pyroute2.netlink.event import EventSocket
> >      from pyroute2.netlink.exceptions eimport NetlinkError
> >      from pyroute2.netlink.generic import GenericNetlinkSocket
> > +    from pyroute2.netlink.nlsocket import Marshal
> >      import pyroute2
> >      import pyroute2.iproute
> >
> > @@ -2460,10 +2462,70 @@ class OvsFlow(GenericNetlinkSocket):
> >          print("MISS upcall[%d/%s]: %s" % (seq, pktpres, keystr), flush=True)
> >
> >      def execute(self, packetmsg):
> > -        print("userspace execute command")
> > +        print("userspace execute command", flush=True)
> >
> >      def action(self, packetmsg):
> > -        print("userspace action command")
> > +        print("userspace action command", flush=True)
> > +
> > +
> > +class psample_sample(genlmsg):
> > +    nla_map = (
> > +        ("PSAMPLE_ATTR_IIFINDEX", "none"),
> > +        ("PSAMPLE_ATTR_OIFINDEX", "none"),
> > +        ("PSAMPLE_ATTR_ORIGSIZE", "none"),
> > +        ("PSAMPLE_ATTR_SAMPLE_GROUP", "uint32"),
> > +        ("PSAMPLE_ATTR_GROUP_SEQ", "none"),
> > +        ("PSAMPLE_ATTR_SAMPLE_RATE", "uint32"),
> > +        ("PSAMPLE_ATTR_DATA", "array(uint8)"),
> > +        ("PSAMPLE_ATTR_GROUP_REFCOUNT", "none"),
> > +        ("PSAMPLE_ATTR_TUNNEL", "none"),
> > +        ("PSAMPLE_ATTR_PAD", "none"),
> > +        ("PSAMPLE_ATTR_OUT_TC", "none"),
> > +        ("PSAMPLE_ATTR_OUT_TC_OCC", "none"),
> > +        ("PSAMPLE_ATTR_LATENCY", "none"),
> > +        ("PSAMPLE_ATTR_TIMESTAMP", "none"),
> > +        ("PSAMPLE_ATTR_PROTO", "none"),
> > +        ("PSAMPLE_ATTR_USER_COOKIE", "array(uint8)"),
> > +    )
> > +
> > +    def dpstr(self):
> > +        fields = []
> > +        data = ""
> > +        for (attr, value) in self["attrs"]:
> > +            if attr == "PSAMPLE_ATTR_SAMPLE_GROUP":
> > +                fields.append("group:%d" % value)
> > +            if attr == "PSAMPLE_ATTR_SAMPLE_RATE":
> > +                fields.append("rate:%d" % value)
> > +            if attr == "PSAMPLE_ATTR_USER_COOKIE":
> > +                value = "".join(format(x, "02x") for x in value)
> > +                fields.append("cookie:%s" % value)
> > +            if attr == "PSAMPLE_ATTR_DATA" and len(value) > 0:
> > +                data = "data:%s" % "".join(format(x, "02x") for x in value)
> > +
> > +        return ("%s %s" % (",".join(fields), data)).strip()
> > +
> > +
> > +class psample_msg(Marshal):
> > +    PSAMPLE_CMD_SAMPLE = 0
> > +    PSAMPLE_CMD_GET_GROUP = 1
> > +    PSAMPLE_CMD_NEW_GROUP = 2
> > +    PSAMPLE_CMD_DEL_GROUP = 3
> > +    PSAMPLE_CMD_SET_FILTER = 4
> > +    msg_map = {PSAMPLE_CMD_SAMPLE: psample_sample}
> > +
> > +
> > +class PsampleEvent(EventSocket):
> > +    genl_family = "psample"
> > +    mcast_groups = ["packets"]
> > +    marshal_class = psample_msg
> > +
> > +    def read_samples(self):
> > +        while True:
> > +            try:
> > +                for msg in self.get():
> > +                    print(msg.dpstr(), flush=True)
> > +            except NetlinkError as ne:
> > +                raise ne
> >
> >
> >  def print_ovsdp_full(dp_lookup_rep, ifindex, ndb=NDB(), vpl=OvsVport()):
> > @@ -2530,7 +2592,7 @@ def main(argv):
> >          help="Increment 'verbose' output counter.",
> >          default=0,
> >      )
> > -    subparsers = parser.add_subparsers()
> > +    subparsers = parser.add_subparsers(dest="subcommand")
> >
> >      showdpcmd = subparsers.add_parser("show")
> >      showdpcmd.add_argument(
> > @@ -2605,6 +2667,8 @@ def main(argv):
> >      delfscmd = subparsers.add_parser("del-flows")
> >      delfscmd.add_argument("flsbr", help="Datapath name")
> >
> > +    subparsers.add_parser("psample-events")
> > +
> >      args = parser.parse_args()
> >
> >      if args.verbose > 0:
> > @@ -2619,6 +2683,9 @@ def main(argv):
> >
> >      sys.setrecursionlimit(100000)
> >
> > +    if args.subcommand == "psample-events":
> > +        PsampleEvent().read_samples()
> > +
> >      if hasattr(args, "showdp"):
> >          found = False
> >          for iface in ndb.interfaces:
>


