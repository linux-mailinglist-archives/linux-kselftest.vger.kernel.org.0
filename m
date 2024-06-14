Return-Path: <linux-kselftest+bounces-11972-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9459090910F
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Jun 2024 19:08:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 114CD1F2239F
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Jun 2024 17:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0E1D19CCE3;
	Fri, 14 Jun 2024 17:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gWIE6ZOM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D63D8190477
	for <linux-kselftest@vger.kernel.org>; Fri, 14 Jun 2024 17:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718384866; cv=none; b=eZkp/0WHefEJM+L/CM2DaQJu3RFXVihTneFVuP/fP7RLelKXFTVR6E+eUyZTuEh1mKEuEWK4Zgue8Bv6DD+NeCGDspPgv99JZd/0Y3+zQqY/o2cIMmfExeBwznd+f5jsqHbjkfTOXdoX8KXby5zLPwmbcbJEnoUSnM5eoMaq/28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718384866; c=relaxed/simple;
	bh=w8zXpPfRjGnqVYOzRj7CsYZ567HQZ6Q7Ki2Geyi/fBI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ewAcgo9lskHfKoyFJvDkw0GzDsma3CozsrKdf14Jw6LU3X3nMy6c9Z1Hw9Rua7ezHGHEI3Wu7N7qQGvCdOgbPIdpCZfr+x1FssItm4TOCEGOzEaBu4vQQD35LbfZ/imBVnZ7tB9oUCK7Euu2QdbNV4XXLdEgiamXWJzsuqaXemo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gWIE6ZOM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718384863;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TOiy624lebtLfN0iATPTnnljnrSx5UwVS99j9Kst+Io=;
	b=gWIE6ZOMXl2VHDsZX3+NJNnBVWjvU0k4VC9RXbJZJ/8z74ZOHDTzZz7cvOi6croD3WuEd7
	QV1J+9Rw8ZAbwadfnIt2wx/U2Ec0Kadk+wBQAl5eLdr2rYLjZVXSLoLO+HVYSqsZZcFOzE
	Urs+tpHMmcAFljVj8V97xqufMRstqis=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-627-602PIFO8N3S-_AnOkD9UEg-1; Fri,
 14 Jun 2024 13:07:42 -0400
X-MC-Unique: 602PIFO8N3S-_AnOkD9UEg-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 380251955F2C;
	Fri, 14 Jun 2024 17:07:39 +0000 (UTC)
Received: from RHTRH0061144 (unknown [10.22.16.41])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5F3291955E91;
	Fri, 14 Jun 2024 17:07:35 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: Adrian Moreno <amorenoz@redhat.com>
Cc: netdev@vger.kernel.org,  echaudro@redhat.com,  horms@kernel.org,
  i.maximets@ovn.org,  dev@openvswitch.org,  Pravin B Shelar
 <pshelar@ovn.org>,  "David S. Miller" <davem@davemloft.net>,  Eric Dumazet
 <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>,  Paolo Abeni
 <pabeni@redhat.com>,  Shuah Khan <shuah@kernel.org>,
  linux-kselftest@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 9/9] selftests: openvswitch: add emit_sample
 test
In-Reply-To: <20240603185647.2310748-10-amorenoz@redhat.com> (Adrian Moreno's
	message of "Mon, 3 Jun 2024 20:56:43 +0200")
References: <20240603185647.2310748-1-amorenoz@redhat.com>
	<20240603185647.2310748-10-amorenoz@redhat.com>
Date: Fri, 14 Jun 2024 13:07:33 -0400
Message-ID: <f7tzfrnmp0q.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Adrian Moreno <amorenoz@redhat.com> writes:

> Add a test to verify sampling packets via psample works.
>
> In order to do that, create a subcommand in ovs-dpctl.py to listen to
> on the psample multicast group and print samples.
>
> In order to also test simultaneous sFlow and psample actions and
> packet truncation, add missing parsing support for "userspace" and
> "trunc" actions.

Maybe split that into a separate patch.  This has a bugfix and 3
features being pushed in.  I know it's already getting long as a series,
so maybe it's okay to fold the userspace attribute bugfix with the parse
support (since it wasn't really usable before).

> Signed-off-by: Adrian Moreno <amorenoz@redhat.com>
> ---
>  .../selftests/net/openvswitch/openvswitch.sh  |  99 +++++++++++++++-
>  .../selftests/net/openvswitch/ovs-dpctl.py    | 112 +++++++++++++++++-
>  2 files changed, 204 insertions(+), 7 deletions(-)
>
> diff --git a/tools/testing/selftests/net/openvswitch/openvswitch.sh b/tools/testing/selftests/net/openvswitch/openvswitch.sh
> index 5cae53543849..f6e0ae3f6424 100755
> --- a/tools/testing/selftests/net/openvswitch/openvswitch.sh
> +++ b/tools/testing/selftests/net/openvswitch/openvswitch.sh
> @@ -20,7 +20,8 @@ tests="
>  	nat_related_v4				ip4-nat-related: ICMP related matches work with SNAT
>  	netlink_checks				ovsnl: validate netlink attrs and settings
>  	upcall_interfaces			ovs: test the upcall interfaces
> -	drop_reason				drop: test drop reasons are emitted"
> +	drop_reason				drop: test drop reasons are emitted
> +	emit_sample 				emit_sample: Sampling packets with psample"
>  
>  info() {
>      [ $VERBOSE = 0 ] || echo $*
> @@ -170,6 +171,19 @@ ovs_drop_reason_count()
>  	return `echo "$perf_output" | grep "$pattern" | wc -l`
>  }
>  
> +ovs_test_flow_fails () {
> +	ERR_MSG="Flow actions may not be safe on all matching packets"
> +
> +	PRE_TEST=$(dmesg | grep -c "${ERR_MSG}")
> +	ovs_add_flow $@ &> /dev/null $@ && return 1
> +	POST_TEST=$(dmesg | grep -c "${ERR_MSG}")
> +
> +	if [ "$PRE_TEST" == "$POST_TEST" ]; then
> +		return 1
> +	fi
> +	return 0
> +}
> +
>  usage() {
>  	echo
>  	echo "$0 [OPTIONS] [TEST]..."
> @@ -184,6 +198,89 @@ usage() {
>  	exit 1
>  }
>  
> +
> +# emit_sample test
> +# - use emit_sample to observe packets
> +test_emit_sample() {
> +	sbx_add "test_emit_sample" || return $?
> +
> +	# Add a datapath with per-vport dispatching.
> +	ovs_add_dp "test_emit_sample" emit_sample -V 2:1 || return 1
> +
> +	info "create namespaces"
> +	ovs_add_netns_and_veths "test_emit_sample" "emit_sample" \
> +		client c0 c1 172.31.110.10/24 -u || return 1
> +	ovs_add_netns_and_veths "test_emit_sample" "emit_sample" \
> +		server s0 s1 172.31.110.20/24 -u || return 1
> +
> +	# Check if emit_sample actions can be configured.
> +	ovs_add_flow "test_emit_sample" emit_sample \
> +	'in_port(1),eth(),eth_type(0x0806),arp()' 'emit_sample(group=1)'
> +	if [ $? == 1 ]; then
> +		info "no support for emit_sample - skipping"
> +		ovs_exit_sig
> +		return $ksft_skip
> +	fi
> +
> +	ovs_del_flows "test_emit_sample" emit_sample
> +
> +	# Allow ARP
> +	ovs_add_flow "test_emit_sample" emit_sample \
> +		'in_port(1),eth(),eth_type(0x0806),arp()' '2' || return 1
> +	ovs_add_flow "test_emit_sample" emit_sample \
> +		'in_port(2),eth(),eth_type(0x0806),arp()' '1' || return 1
> +
> +	# Test action verification.
> +	OLDIFS=$IFS
> +	IFS='*'
> +	min_key='in_port(1),eth(),eth_type(0x0800),ipv4()'
> +	for testcase in \
> +		"cookie to large"*"emit_sample(group=1,cookie=1615141312111009080706050403020100)" \
> +		"no group with cookie"*"emit_sample(cookie=abcd)" \
> +		"no group"*"sample()";
> +	do
> +		set -- $testcase;
> +		ovs_test_flow_fails "test_emit_sample" emit_sample $min_key $2
> +		if [ $? == 1 ]; then
> +			info "failed - $1"
> +			return 1
> +		fi
> +	done
> +	IFS=$OLDIFS
> +
> +	# Sample first 14 bytes of all traffic.
> +	ovs_add_flow "test_emit_sample" emit_sample \
> +	"in_port(1),eth(),eth_type(0x0800),ipv4(src=172.31.110.10,proto=1),icmp()" "trunc(14),emit_sample(group=1,cookie=c0ffee),2"
> +
> +	# Sample all traffic. In this case, use a sample() action with both
> +	# emit_sample and an upcall emulating simultaneous local sampling and
> +	# sFlow / IPFIX.
> +	nlpid=$(grep -E "listening on upcall packet handler" $ovs_dir/s0.out | cut -d ":" -f 2 | tr -d ' ')
> +	ovs_add_flow "test_emit_sample" emit_sample \
> +	"in_port(2),eth(),eth_type(0x0800),ipv4(src=172.31.110.20,proto=1),icmp()" "sample(sample=100%,actions(emit_sample(group=2,cookie=eeff0c),userspace(pid=${nlpid},userdata=eeff0c))),1"
> +
> +	# Record emit_sample data.
> +	python3 $ovs_base/ovs-dpctl.py psample >$ovs_dir/psample.out 2>$ovs_dir/psample.err &
> +	pid=$!
> +	on_exit "ovs_sbx test_emit_sample kill -TERM $pid 2>/dev/null"

  Maybe ovs_netns_spawn_daemon ?

> +
> +	# Send a single ping.
> +	sleep 1
> +	ovs_sbx "test_emit_sample" ip netns exec client ping -I c1 172.31.110.20 -c 1 || return 1
> +	sleep 1
> +
> +	# We should have received one userspace action upcall and 2 psample packets.
> +	grep -E "userspace action command" $ovs_dir/s0.out >/dev/null 2>&1 || return 1
> +
> +	# client -> server samples should only contain the first 14 bytes of the packet.
> +	grep -E "rate:4294967295,group:1,cookie:c0ffee data:[0-9a-f]{28}$" \
> +			 $ovs_dir/psample.out >/dev/null 2>&1 || return 1
> +	grep -E "rate:4294967295,group:2,cookie:eeff0c" \
> +			 $ovs_dir/psample.out >/dev/null 2>&1 || return 1
> +
> +	return 0
> +}
> +
>  # drop_reason test
>  # - drop packets and verify the right drop reason is reported
>  test_drop_reason() {
> diff --git a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
> index f8b5362aac8c..44fdeb9491a2 100644
> --- a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
> +++ b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
> @@ -27,8 +27,10 @@ try:
>      from pyroute2.netlink import genlmsg
>      from pyroute2.netlink import nla
>      from pyroute2.netlink import nlmsg_atoms
> -    from pyroute2.netlink.exceptions import NetlinkError
> +    from pyroute2.netlink.event import EventSocket
>      from pyroute2.netlink.generic import GenericNetlinkSocket
> +    from pyroute2.netlink.nlsocket import Marshal
> +    from pyroute2.netlink.exceptions import NetlinkError

Why did this get moved?

>      import pyroute2
>  
>  except ModuleNotFoundError:
> @@ -575,13 +577,27 @@ class ovsactions(nla):
>                  print_str += "userdata="
>                  for f in self.get_attr("OVS_USERSPACE_ATTR_USERDATA"):
>                      print_str += "%x." % f
> -            if self.get_attr("OVS_USERSPACE_ATTR_TUN_PORT") is not None:
> +            if self.get_attr("OVS_USERSPACE_ATTR_EGRESS_TUN_PORT") is not None:
>                  print_str += "egress_tun_port=%d" % self.get_attr(
> -                    "OVS_USERSPACE_ATTR_TUN_PORT"
> +                    "OVS_USERSPACE_ATTR_EGRESS_TUN_PORT"

Looks like a bugfix here.

>                  )
>              print_str += ")"
>              return print_str
>  
> +        def parse(self, actstr):
> +            attrs_desc = (
> +                ("pid", "OVS_USERSPACE_ATTR_PID", int),
> +                ("userdata", "OVS_USERSPACE_ATTR_USERDATA",
> +                    lambda x: list(bytearray.fromhex(x))),
> +                ("egress_tun_port", "OVS_USERSPACE_ATTR_EGRESS_TUN_PORT", int)
> +            )
> +
> +            attrs, actstr = parse_attrs(actstr, attrs_desc)
> +            for attr in attrs:
> +                self["attrs"].append(attr)
> +
> +            return actstr
> +
>      def dpstr(self, more=False):
>          print_str = ""
>  
> @@ -803,6 +819,25 @@ class ovsactions(nla):
>                  self["attrs"].append(["OVS_ACTION_ATTR_EMIT_SAMPLE", emitact])
>                  parsed = True
>  
> +            elif parse_starts_block(actstr, "userspace(", False):
> +                uact = self.userspace()
> +                actstr = uact.parse(actstr[len("userpsace(") : ])
> +                self["attrs"].append(["OVS_ACTION_ATTR_USERSPACE", uact])
> +                parsed = True
> +
> +            elif parse_starts_block(actstr, "trunc", False):

This should be "trunc("

> +                parencount += 1
> +                actstr, val = parse_extract_field(
> +                    actstr,
> +                    "trunc(",
> +                    r"([0-9]+)",
> +                    int,
> +                    False,
> +                    None,
> +                )
> +                self["attrs"].append(["OVS_ACTION_ATTR_TRUNC", val])
> +                parsed = True
> +
>              actstr = actstr[strspn(actstr, ", ") :]
>              while parencount > 0:
>                  parencount -= 1
> @@ -2184,10 +2219,70 @@ class OvsFlow(GenericNetlinkSocket):
>          print("MISS upcall[%d/%s]: %s" % (seq, pktpres, keystr), flush=True)
>  
>      def execute(self, packetmsg):
> -        print("userspace execute command")
> +        print("userspace execute command", flush=True)
>  
>      def action(self, packetmsg):
> -        print("userspace action command")
> +        print("userspace action command", flush=True)
> +
> +
> +class psample_sample(genlmsg):
> +    nla_map = (
> +        ("PSAMPLE_ATTR_IIFINDEX", "none"),
> +        ("PSAMPLE_ATTR_OIFINDEX", "none"),
> +        ("PSAMPLE_ATTR_ORIGSIZE", "none"),
> +        ("PSAMPLE_ATTR_SAMPLE_GROUP", "uint32"),
> +        ("PSAMPLE_ATTR_GROUP_SEQ", "none"),
> +        ("PSAMPLE_ATTR_SAMPLE_RATE", "uint32"),
> +        ("PSAMPLE_ATTR_DATA", "array(uint8)"),
> +        ("PSAMPLE_ATTR_GROUP_REFCOUNT", "none"),
> +        ("PSAMPLE_ATTR_TUNNEL", "none"),
> +        ("PSAMPLE_ATTR_PAD", "none"),
> +        ("PSAMPLE_ATTR_OUT_TC", "none"),
> +        ("PSAMPLE_ATTR_OUT_TC_OCC", "none"),
> +        ("PSAMPLE_ATTR_LATENCY", "none"),
> +        ("PSAMPLE_ATTR_TIMESTAMP", "none"),
> +        ("PSAMPLE_ATTR_PROTO", "none"),
> +        ("PSAMPLE_ATTR_USER_COOKIE", "array(uint8)"),
> +    )
> +
> +    def dpstr(self):
> +        fields = []
> +        data = ""
> +        for (attr, value) in self["attrs"]:
> +            if attr == "PSAMPLE_ATTR_SAMPLE_GROUP":
> +                fields.append("group:%d" % value)
> +            if attr == "PSAMPLE_ATTR_SAMPLE_RATE":
> +                fields.append("rate:%d" % value)
> +            if attr == "PSAMPLE_ATTR_USER_COOKIE":
> +                value = "".join(format(x, "02x") for x in value)
> +                fields.append("cookie:%s" % value)
> +            if attr == "PSAMPLE_ATTR_DATA" and len(value) > 0:
> +                data = "data:%s" % "".join(format(x, "02x") for x in value)
> +
> +        return ("%s %s" % (",".join(fields), data)).strip()
> +
> +
> +class psample_msg(Marshal):
> +    PSAMPLE_CMD_SAMPLE = 0
> +    PSAMPLE_CMD_GET_GROUP = 1
> +    PSAMPLE_CMD_NEW_GROUP = 2
> +    PSAMPLE_CMD_DEL_GROUP = 3
> +    PSAMPLE_CMD_SET_FILTER = 4
> +    msg_map = {PSAMPLE_CMD_SAMPLE: psample_sample}
> +
> +
> +class Psample(EventSocket):
> +    genl_family = "psample"
> +    mcast_groups = ["packets"]
> +    marshal_class = psample_msg
> +
> +    def read_samples(self):
> +        while True:
> +            try:
> +                for msg in self.get():
> +                    print(msg.dpstr(), flush=True)
> +            except NetlinkError as ne:
> +                raise ne
>  
>  
>  def print_ovsdp_full(dp_lookup_rep, ifindex, ndb=NDB(), vpl=OvsVport()):
> @@ -2247,7 +2342,7 @@ def main(argv):
>          help="Increment 'verbose' output counter.",
>          default=0,
>      )
> -    subparsers = parser.add_subparsers()
> +    subparsers = parser.add_subparsers(dest="subcommand")
>  
>      showdpcmd = subparsers.add_parser("show")
>      showdpcmd.add_argument(
> @@ -2304,6 +2399,8 @@ def main(argv):
>      delfscmd = subparsers.add_parser("del-flows")
>      delfscmd.add_argument("flsbr", help="Datapath name")
>  
> +    subparsers.add_parser("psample")
> +
>      args = parser.parse_args()
>  
>      if args.verbose > 0:
> @@ -2318,6 +2415,9 @@ def main(argv):
>  
>      sys.setrecursionlimit(100000)
>  
> +    if args.subcommand == "psample":
> +        Psample().read_samples()
> +
>      if hasattr(args, "showdp"):
>          found = False
>          for iface in ndb.interfaces:


