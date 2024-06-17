Return-Path: <linux-kselftest+bounces-12027-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C620390A706
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Jun 2024 09:26:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F15C1B209C6
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Jun 2024 07:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 352E618734A;
	Mon, 17 Jun 2024 07:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X0P1hxDG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D7369D31
	for <linux-kselftest@vger.kernel.org>; Mon, 17 Jun 2024 07:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718608694; cv=none; b=d9foN/bog4SCpWFQxBC7YVJ1Y645N/lMYeNTHG6WSLYxeWachM+1QhbKhogifbD/LCHCO356Mw/QMGsyjcmYwGHmCA67NBMGLKhJEVA1jQWYSlX5fzM/v5xbEql5AB9taFL0z2WbTN2eYeS6gzeu84fUPIRPmmG+GswrqtyBiYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718608694; c=relaxed/simple;
	bh=SJyhaGnDA08mnP1MMM6h9OeyFlXZif6yRXbO9wsbNh8=;
	h=From:References:MIME-Version:In-Reply-To:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GQngYPzAIHKEK4ZniYDF5iBmaQbp9NPK+7MpDCNo1ny11K0IA1CYxfEovMZq1OvT16yDxESJQ4Fg93XFy63iWigw4PQntfox0cWxeNHuCzvPNK96yk8XLa+lGIVW0+9qffFmvCuTYZuHikOaeHamKIyR9zmUKi5si8xr/uSMVrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X0P1hxDG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718608691;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yD6JQizGQVRbA8OpWq9GTRIuQp0PM1wvBpw2eom4+Tc=;
	b=X0P1hxDGFFPsDp8MHk6OIn+U3BYi4Fq7BKIbsig30ncIKz5SONv9br0UaCyRv412mdG70w
	+ourdbpaQf3BoyNOADEex47x2/OkdOI5dw5gdINaP49nh2sEnuqfp6MAD6OmaTDgiYRMTW
	OqvZUG0FhL/zsi6+K+nRRXOemaNbYYw=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-414-B7qmnB1ePlqymd9yyUYNNQ-1; Mon, 17 Jun 2024 03:18:08 -0400
X-MC-Unique: B7qmnB1ePlqymd9yyUYNNQ-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6b071669ebaso49428436d6.2
        for <linux-kselftest@vger.kernel.org>; Mon, 17 Jun 2024 00:18:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718608687; x=1719213487;
        h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yD6JQizGQVRbA8OpWq9GTRIuQp0PM1wvBpw2eom4+Tc=;
        b=bGIG9QFgS9fuTxN3td7JSc7IEB/kBzfGv8XbOh1LXiCnqrQ/zS9Hx/fdEJdYhSLX1s
         u5YoiWF/MMG22FRjY7QzjU7BfZ9ts2y2N7ad0MBupNa7heTaP1rnf6wA45ZWL9Uts7ft
         MR2V4h30TUrUzKdNGhUQIwrZAR18fvNYqdwra//nRtWdyAGSUX1LPBEIsGckOwq1RjNz
         qBEtv16gcLiNCTaUlmBaTNXgAfcZH64HYvXtM0lHOKvnJKcZWLQkyP9UF8hRmT9yC8ED
         e2kd37xwTNhzJn2gnyiKdABqWN1/Qs2SNCfIu5rdn99VnPeXIgn+1CXGV2Jn48m17ra4
         s2tA==
X-Forwarded-Encrypted: i=1; AJvYcCUaJjXraSLxh1AvEpbc3xB5UDDeKU1SduncQhhCH1u+OLRwONzWejoTCvtBgqYSdD3mYq60sXsCuNp5NcMjI67mY7xQs1MnOnwxXt9xhyKn
X-Gm-Message-State: AOJu0Yxj82XxQRUWq3QTYkl55xtdq7aR1ezqBbj9D00uxiFi0Mkca7pi
	e4WO86USC2Yh+TUcJA8+a0BP0im6lc5cUiilxSKpVzsHxAIH86hnYzkTha5g1+4ZIKRfSSJlEEc
	7nopmHt7utKORbL1RSE4nuko8DARQ12+TykuCXyUbIgcdbpkIp+0a8bhJ1tVwb91aSopw1qMwue
	gtX71PSDbS0Y2Z9OR+wsyS8oqqP3XHjrmM0xoaazz4
X-Received: by 2002:a0c:ac46:0:b0:6b2:dbef:aa8 with SMTP id 6a1803df08f44-6b2dbef0da4mr6167596d6.23.1718608687216;
        Mon, 17 Jun 2024 00:18:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHpcDQbHY9Nt9HHcnfhIyFvLLnwMq0rBAAwReFTFdfZw4EMj5Bi1RBV+q+UdlTydxJqRvtdPqnHNE+8mkBb6YU=
X-Received: by 2002:a0c:ac46:0:b0:6b2:dbef:aa8 with SMTP id
 6a1803df08f44-6b2dbef0da4mr6167216d6.23.1718608686660; Mon, 17 Jun 2024
 00:18:06 -0700 (PDT)
Received: from 311643009450 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 17 Jun 2024 07:18:06 +0000
From: =?UTF-8?Q?Adri=C3=A1n_Moreno?= <amorenoz@redhat.com>
References: <20240603185647.2310748-1-amorenoz@redhat.com> <20240603185647.2310748-10-amorenoz@redhat.com>
 <f7tzfrnmp0q.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <f7tzfrnmp0q.fsf@redhat.com>
Date: Mon, 17 Jun 2024 07:18:05 +0000
Message-ID: <CAG=2xmPvAfQx4jSFbBPTcEdo2Z6w93vo6-Uo5rVMLbu8qS1SOA@mail.gmail.com>
Subject: Re: [PATCH net-next v2 9/9] selftests: openvswitch: add emit_sample test
To: Aaron Conole <aconole@redhat.com>
Cc: netdev@vger.kernel.org, echaudro@redhat.com, horms@kernel.org, 
	i.maximets@ovn.org, dev@openvswitch.org, Pravin B Shelar <pshelar@ovn.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, Jun 14, 2024 at 01:07:33PM GMT, Aaron Conole wrote:
> Adrian Moreno <amorenoz@redhat.com> writes:
>
> > Add a test to verify sampling packets via psample works.
> >
> > In order to do that, create a subcommand in ovs-dpctl.py to listen to
> > on the psample multicast group and print samples.
> >
> > In order to also test simultaneous sFlow and psample actions and
> > packet truncation, add missing parsing support for "userspace" and
> > "trunc" actions.
>
> Maybe split that into a separate patch.  This has a bugfix and 3
> features being pushed in.  I know it's already getting long as a series,
> so maybe it's okay to fold the userspace attribute bugfix with the parse
> support (since it wasn't really usable before).
>

OK. Sounds reasonable.

> > Signed-off-by: Adrian Moreno <amorenoz@redhat.com>
> > ---
> >  .../selftests/net/openvswitch/openvswitch.sh  |  99 +++++++++++++++-
> >  .../selftests/net/openvswitch/ovs-dpctl.py    | 112 +++++++++++++++++-
> >  2 files changed, 204 insertions(+), 7 deletions(-)
> >
> > diff --git a/tools/testing/selftests/net/openvswitch/openvswitch.sh b/tools/testing/selftests/net/openvswitch/openvswitch.sh
> > index 5cae53543849..f6e0ae3f6424 100755
> > --- a/tools/testing/selftests/net/openvswitch/openvswitch.sh
> > +++ b/tools/testing/selftests/net/openvswitch/openvswitch.sh
> > @@ -20,7 +20,8 @@ tests="
> >  	nat_related_v4				ip4-nat-related: ICMP related matches work with SNAT
> >  	netlink_checks				ovsnl: validate netlink attrs and settings
> >  	upcall_interfaces			ovs: test the upcall interfaces
> > -	drop_reason				drop: test drop reasons are emitted"
> > +	drop_reason				drop: test drop reasons are emitted
> > +	emit_sample 				emit_sample: Sampling packets with psample"
> >
> >  info() {
> >      [ $VERBOSE = 0 ] || echo $*
> > @@ -170,6 +171,19 @@ ovs_drop_reason_count()
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
> > @@ -184,6 +198,89 @@ usage() {
> >  	exit 1
> >  }
> >
> > +
> > +# emit_sample test
> > +# - use emit_sample to observe packets
> > +test_emit_sample() {
> > +	sbx_add "test_emit_sample" || return $?
> > +
> > +	# Add a datapath with per-vport dispatching.
> > +	ovs_add_dp "test_emit_sample" emit_sample -V 2:1 || return 1
> > +
> > +	info "create namespaces"
> > +	ovs_add_netns_and_veths "test_emit_sample" "emit_sample" \
> > +		client c0 c1 172.31.110.10/24 -u || return 1
> > +	ovs_add_netns_and_veths "test_emit_sample" "emit_sample" \
> > +		server s0 s1 172.31.110.20/24 -u || return 1
> > +
> > +	# Check if emit_sample actions can be configured.
> > +	ovs_add_flow "test_emit_sample" emit_sample \
> > +	'in_port(1),eth(),eth_type(0x0806),arp()' 'emit_sample(group=1)'
> > +	if [ $? == 1 ]; then
> > +		info "no support for emit_sample - skipping"
> > +		ovs_exit_sig
> > +		return $ksft_skip
> > +	fi
> > +
> > +	ovs_del_flows "test_emit_sample" emit_sample
> > +
> > +	# Allow ARP
> > +	ovs_add_flow "test_emit_sample" emit_sample \
> > +		'in_port(1),eth(),eth_type(0x0806),arp()' '2' || return 1
> > +	ovs_add_flow "test_emit_sample" emit_sample \
> > +		'in_port(2),eth(),eth_type(0x0806),arp()' '1' || return 1
> > +
> > +	# Test action verification.
> > +	OLDIFS=$IFS
> > +	IFS='*'
> > +	min_key='in_port(1),eth(),eth_type(0x0800),ipv4()'
> > +	for testcase in \
> > +		"cookie to large"*"emit_sample(group=1,cookie=1615141312111009080706050403020100)" \
> > +		"no group with cookie"*"emit_sample(cookie=abcd)" \
> > +		"no group"*"sample()";
> > +	do
> > +		set -- $testcase;
> > +		ovs_test_flow_fails "test_emit_sample" emit_sample $min_key $2
> > +		if [ $? == 1 ]; then
> > +			info "failed - $1"
> > +			return 1
> > +		fi
> > +	done
> > +	IFS=$OLDIFS
> > +
> > +	# Sample first 14 bytes of all traffic.
> > +	ovs_add_flow "test_emit_sample" emit_sample \
> > +	"in_port(1),eth(),eth_type(0x0800),ipv4(src=172.31.110.10,proto=1),icmp()" "trunc(14),emit_sample(group=1,cookie=c0ffee),2"
> > +
> > +	# Sample all traffic. In this case, use a sample() action with both
> > +	# emit_sample and an upcall emulating simultaneous local sampling and
> > +	# sFlow / IPFIX.
> > +	nlpid=$(grep -E "listening on upcall packet handler" $ovs_dir/s0.out | cut -d ":" -f 2 | tr -d ' ')
> > +	ovs_add_flow "test_emit_sample" emit_sample \
> > +	"in_port(2),eth(),eth_type(0x0800),ipv4(src=172.31.110.20,proto=1),icmp()" "sample(sample=100%,actions(emit_sample(group=2,cookie=eeff0c),userspace(pid=${nlpid},userdata=eeff0c))),1"
> > +
> > +	# Record emit_sample data.
> > +	python3 $ovs_base/ovs-dpctl.py psample >$ovs_dir/psample.out 2>$ovs_dir/psample.err &
> > +	pid=$!
> > +	on_exit "ovs_sbx test_emit_sample kill -TERM $pid 2>/dev/null"
>
>   Maybe ovs_netns_spawn_daemon ?
>

I'll take a look at it, thanks.

> > +
> > +	# Send a single ping.
> > +	sleep 1
> > +	ovs_sbx "test_emit_sample" ip netns exec client ping -I c1 172.31.110.20 -c 1 || return 1
> > +	sleep 1
> > +
> > +	# We should have received one userspace action upcall and 2 psample packets.
> > +	grep -E "userspace action command" $ovs_dir/s0.out >/dev/null 2>&1 || return 1
> > +
> > +	# client -> server samples should only contain the first 14 bytes of the packet.
> > +	grep -E "rate:4294967295,group:1,cookie:c0ffee data:[0-9a-f]{28}$" \
> > +			 $ovs_dir/psample.out >/dev/null 2>&1 || return 1
> > +	grep -E "rate:4294967295,group:2,cookie:eeff0c" \
> > +			 $ovs_dir/psample.out >/dev/null 2>&1 || return 1
> > +
> > +	return 0
> > +}
> > +
> >  # drop_reason test
> >  # - drop packets and verify the right drop reason is reported
> >  test_drop_reason() {
> > diff --git a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
> > index f8b5362aac8c..44fdeb9491a2 100644
> > --- a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
> > +++ b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
> > @@ -27,8 +27,10 @@ try:
> >      from pyroute2.netlink import genlmsg
> >      from pyroute2.netlink import nla
> >      from pyroute2.netlink import nlmsg_atoms
> > -    from pyroute2.netlink.exceptions import NetlinkError
> > +    from pyroute2.netlink.event import EventSocket
> >      from pyroute2.netlink.generic import GenericNetlinkSocket
> > +    from pyroute2.netlink.nlsocket import Marshal
> > +    from pyroute2.netlink.exceptions import NetlinkError
>
> Why did this get moved?
>

I guess I first removed it and then added it in the wrong order. I'll
restore it, thanks.

> >      import pyroute2
> >
> >  except ModuleNotFoundError:
> > @@ -575,13 +577,27 @@ class ovsactions(nla):
> >                  print_str += "userdata="
> >                  for f in self.get_attr("OVS_USERSPACE_ATTR_USERDATA"):
> >                      print_str += "%x." % f
> > -            if self.get_attr("OVS_USERSPACE_ATTR_TUN_PORT") is not None:
> > +            if self.get_attr("OVS_USERSPACE_ATTR_EGRESS_TUN_PORT") is not None:
> >                  print_str += "egress_tun_port=%d" % self.get_attr(
> > -                    "OVS_USERSPACE_ATTR_TUN_PORT"
> > +                    "OVS_USERSPACE_ATTR_EGRESS_TUN_PORT"
>
> Looks like a bugfix here.
>

Yep. I'll fold it in with the rest of the usersapce action support into
an independent patch.

> >                  )
> >              print_str += ")"
> >              return print_str
> >
> > +        def parse(self, actstr):
> > +            attrs_desc = (
> > +                ("pid", "OVS_USERSPACE_ATTR_PID", int),
> > +                ("userdata", "OVS_USERSPACE_ATTR_USERDATA",
> > +                    lambda x: list(bytearray.fromhex(x))),
> > +                ("egress_tun_port", "OVS_USERSPACE_ATTR_EGRESS_TUN_PORT", int)
> > +            )
> > +
> > +            attrs, actstr = parse_attrs(actstr, attrs_desc)
> > +            for attr in attrs:
> > +                self["attrs"].append(attr)
> > +
> > +            return actstr
> > +
> >      def dpstr(self, more=False):
> >          print_str = ""
> >
> > @@ -803,6 +819,25 @@ class ovsactions(nla):
> >                  self["attrs"].append(["OVS_ACTION_ATTR_EMIT_SAMPLE", emitact])
> >                  parsed = True
> >
> > +            elif parse_starts_block(actstr, "userspace(", False):
> > +                uact = self.userspace()
> > +                actstr = uact.parse(actstr[len("userpsace(") : ])
> > +                self["attrs"].append(["OVS_ACTION_ATTR_USERSPACE", uact])
> > +                parsed = True
> > +
> > +            elif parse_starts_block(actstr, "trunc", False):
>
> This should be "trunc("
>

Probably, yes. The rest of the actions do look for the initial "(".
Thinking in a generalization of the action parsing, could we just look
for the action name, i.e: "trunc" and let errors be raised inside each
parsing logic? In this case, check if "val is not None" after
"parse_extract_field".

> > +                parencount += 1
> > +                actstr, val = parse_extract_field(
> > +                    actstr,
> > +                    "trunc(",
> > +                    r"([0-9]+)",
> > +                    int,
> > +                    False,
> > +                    None,
> > +                )
> > +                self["attrs"].append(["OVS_ACTION_ATTR_TRUNC", val])
> > +                parsed = True
> > +
> >              actstr = actstr[strspn(actstr, ", ") :]
> >              while parencount > 0:
> >                  parencount -= 1
> > @@ -2184,10 +2219,70 @@ class OvsFlow(GenericNetlinkSocket):
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
> > +class Psample(EventSocket):
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
> > @@ -2247,7 +2342,7 @@ def main(argv):
> >          help="Increment 'verbose' output counter.",
> >          default=0,
> >      )
> > -    subparsers = parser.add_subparsers()
> > +    subparsers = parser.add_subparsers(dest="subcommand")
> >
> >      showdpcmd = subparsers.add_parser("show")
> >      showdpcmd.add_argument(
> > @@ -2304,6 +2399,8 @@ def main(argv):
> >      delfscmd = subparsers.add_parser("del-flows")
> >      delfscmd.add_argument("flsbr", help="Datapath name")
> >
> > +    subparsers.add_parser("psample")
> > +
> >      args = parser.parse_args()
> >
> >      if args.verbose > 0:
> > @@ -2318,6 +2415,9 @@ def main(argv):
> >
> >      sys.setrecursionlimit(100000)
> >
> > +    if args.subcommand == "psample":
> > +        Psample().read_samples()
> > +
> >      if hasattr(args, "showdp"):
> >          found = False
> >          for iface in ndb.interfaces:
>


