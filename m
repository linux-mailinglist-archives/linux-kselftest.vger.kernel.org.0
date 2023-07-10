Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7573974DB08
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Jul 2023 18:26:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229451AbjGJQ03 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 10 Jul 2023 12:26:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjGJQ02 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 10 Jul 2023 12:26:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C29A711A
        for <linux-kselftest@vger.kernel.org>; Mon, 10 Jul 2023 09:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689006341;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vlCg2SSm75yxtKumR5JYgr4zWSOaVfzfrtKLYX8gmTU=;
        b=d5Lr9s2WH6x0LwtxClgH+vbWHv2vvpKgt5YKV78HRJevc6+tBJeMrrtDZN6XP82k1YsYiB
        H/D3QvisVz3Dh6qfEAzxtf998AWiq/nnqk65oZHI9Wcz0rc5PlqRHQlPl5GuOEQPYNy8TH
        dbS2Hc3V1j6aJkXSKs2HlEr+1YrBsEQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-121-jQ2ibSVZN5mGeWJJnhQ0hA-1; Mon, 10 Jul 2023 12:25:38 -0400
X-MC-Unique: jQ2ibSVZN5mGeWJJnhQ0hA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0F52F104458D;
        Mon, 10 Jul 2023 16:25:38 +0000 (UTC)
Received: from RHTPC1VM0NT (unknown [10.22.34.58])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 16291492B02;
        Mon, 10 Jul 2023 16:25:37 +0000 (UTC)
From:   Aaron Conole <aconole@redhat.com>
To:     Adrian Moreno <amorenoz@redhat.com>
Cc:     netdev@vger.kernel.org, dev@openvswitch.org,
        Ilya Maximets <i.maximets@ovn.org>,
        Eric Dumazet <edumazet@google.com>,
        linux-kselftest@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, shuah@kernel.org,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [ovs-dev] [PATCH net-next 4/4] selftests: openvswitch: add
 ct-nat test case with ipv4
References: <20230628162714.392047-1-aconole@redhat.com>
        <20230628162714.392047-5-aconole@redhat.com>
        <43015bcd-46a0-432c-a181-6d29c49f2513@redhat.com>
Date:   Mon, 10 Jul 2023 12:25:36 -0400
In-Reply-To: <43015bcd-46a0-432c-a181-6d29c49f2513@redhat.com> (Adrian
        Moreno's message of "Fri, 7 Jul 2023 12:12:51 +0200")
Message-ID: <f7tpm4zensv.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Adrian Moreno <amorenoz@redhat.com> writes:

> On 6/28/23 18:27, Aaron Conole wrote:
>> Building on the previous work, add a very simplistic NAT case
>> using ipv4.  This just tests dnat transformation
>> Signed-off-by: Aaron Conole <aconole@redhat.com>
>
> Hi Aaron,
>
> I know that the goal is not to support the full syntax, and that nat
> is a specially convoluted action, so I'm just commenting on the
> low-hanging fruits (see below).

Thanks, Adrian!

>> ---
>>   .../selftests/net/openvswitch/openvswitch.sh  | 64 +++++++++++++++++++
>>   .../selftests/net/openvswitch/ovs-dpctl.py    | 60 +++++++++++++++++
>>   2 files changed, 124 insertions(+)
>> diff --git a/tools/testing/selftests/net/openvswitch/openvswitch.sh
>> b/tools/testing/selftests/net/openvswitch/openvswitch.sh
>> index 40a66c72af0f0..dced4f612a78c 100755
>> --- a/tools/testing/selftests/net/openvswitch/openvswitch.sh
>> +++ b/tools/testing/selftests/net/openvswitch/openvswitch.sh
>> @@ -14,6 +14,7 @@ tests="
>>   	arp_ping				eth-arp: Basic arp ping between two NS
>>   	ct_connect_v4				ip4-ct-xon: Basic ipv4 tcp connection using ct
>>   	connect_v4				ip4-xon: Basic ipv4 ping between two NS
>> +	nat_connect_v4				ip4-nat-xon: Basic ipv4 tcp connection via NAT
>>   	netlink_checks				ovsnl: validate netlink attrs and settings
>>   	upcall_interfaces			ovs: test the upcall interfaces"
>>   @@ -300,6 +301,69 @@ test_connect_v4 () {
>>   	return 0
>>   }
>>   +# nat_connect_v4 test
>> +#  - client has 1500 byte MTU
>> +#  - server has 1500 byte MTU
>> +#  - use ICMP to ping in each direction
>> +#  - only allow CT state stuff to pass through new in c -> s
>> +test_nat_connect_v4 () {
>> +	which nc >/dev/null 2>/dev/null || return $ksft_skip
>> +
>> +	sbx_add "test_nat_connect_v4" || return $?
>> +
>> +	ovs_add_dp "test_nat_connect_v4" nat4 || return 1
>> +	info "create namespaces"
>> +	for ns in client server; do
>> +		ovs_add_netns_and_veths "test_nat_connect_v4" "nat4" "$ns" \
>> +		    "${ns:0:1}0" "${ns:0:1}1" || return 1
>> +	done
>> +
>> +	ip netns exec client ip addr add 172.31.110.10/24 dev c1
>> +	ip netns exec client ip link set c1 up
>> +	ip netns exec server ip addr add 172.31.110.20/24 dev s1
>> +	ip netns exec server ip link set s1 up
>> +
>> +	ip netns exec client ip route add default via 172.31.110.20
>> +
>> +	ovs_add_flow "test_nat_connect_v4" nat4 \
>> +		'in_port(1),eth(),eth_type(0x0806),arp()' '2' || return 1
>> +	ovs_add_flow "test_nat_connect_v4" nat4 \
>> +		'in_port(2),eth(),eth_type(0x0806),arp()' '1' || return 1
>> +	ovs_add_flow "test_nat_connect_v4" nat4 \
>> +		"ct_state(-trk),in_port(1),eth(),eth_type(0x0800),ipv4(dst=192.168.0.20)" \
>> +		"ct(commit,nat(dst=172.31.110.20)),recirc(0x1)"
>> +	ovs_add_flow "test_nat_connect_v4" nat4 \
>> +		"ct_state(-trk),in_port(2),eth(),eth_type(0x0800),ipv4()" \
>> +		"ct(commit,nat),recirc(0x2)"
>> +
>> +	ovs_add_flow "test_nat_connect_v4" nat4 \
>> +		"recirc_id(0x1),ct_state(+trk-inv),in_port(1),eth(),eth_type(0x0800),ipv4()" "2"
>> +	ovs_add_flow "test_nat_connect_v4" nat4 \
>> +		"recirc_id(0x2),ct_state(+trk-inv),in_port(2),eth(),eth_type(0x0800),ipv4()" "1"
>> +
>> +	# do a ping
>> +	ovs_sbx "test_nat_connect_v4" ip netns exec client ping 192.168.0.20 -c 3 || return 1
>> +
>> +	# create an echo server in 'server'
>> +	echo "server" | \
>> +		ovs_netns_spawn_daemon "test_nat_connect_v4" "server" \
>> +				nc -lvnp 4443
>> +	ovs_sbx "test_nat_connect_v4" ip netns exec client nc -i 1 -zv 192.168.0.20 4443 || return 1
>> +
>> +	# Now test in the other direction (should fail)
>> +	echo "client" | \
>> +		ovs_netns_spawn_daemon "test_nat_connect_v4" "client" \
>> +				nc -lvnp 4443
>> +	ovs_sbx "test_nat_connect_v4" ip netns exec client nc -i 1 -zv 172.31.110.10 4443
>> +	if [ $? == 0 ]; then
>> +	   info "connect to client was successful"
>> +	   return 1
>> +	fi
>> +
>> +	info "done..."
>> +	return 0
>> +}
>> +
>>   # netlink_validation
>>   # - Create a dp
>>   # - check no warning with "old version" simulation
>> diff --git a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
>> index 704cb4adf79a9..12ba5265b88fb 100644
>> --- a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
>> +++ b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
>> @@ -511,6 +511,66 @@ class ovsactions(nla):
>>                           else:
>>                               ctact["attrs"].append([scan[1], None])
>>                           actstr = actstr[strspn(actstr, ", ") :]
>> +                    # it seems strange to put this here, but nat() is a complex
>> +                    # sub-action and this lets it sit anywhere in the ct() action
>> +                    if actstr.startswith("nat"):
>> +                        actstr = actstr[3:]
>> +                        natact = ovsactions.ctact.natattr()
>> +
>> +                        if actstr.startswith("("):
>> +                            t = None
>> +                            actstr = actstr[1:]
>> +                            if actstr.startswith("src"):
>> +                                t = "OVS_NAT_ATTR_SRC"
>> +                                actstr = actstr[3:]
>> +                            elif actstr.startswith("dst"):
>> +                                t = "OVS_NAT_ATTR_DST"
>> +                                actstr = actstr[3:]
>> +
>> +                            actstr, ip_block_min = parse_extract_field(
>> +                                actstr, "=", "([0-9a-fA-F:\.]+)", str, False
>> +                            )
>> +                            actstr, ip_block_max = parse_extract_field(
>> +                                actstr, "-", "([0-9a-fA-F:\.]+)", str, False
>> +                            )
>
> Having the ":" character here makes this line parse the port as well
> (i.e: 1.1.1.1:6789 as ip_block_max) which then makes ip address
> parsing fail.

Ugh... good catch.  I'll re-work this section a bit.  I was trying to
keep it simple to catch both ipv4 and ipv6 syntax.

>> +                            actstr, proto_min = parse_extract_field(
>> +                                actstr, ":", "(\d+)", int, False
>> +                            )
>> +                            actstr, proto_max = parse_extract_field(
>> +                                actstr, "-", "(\d+)", int, False
>> +                            )
>> +                            if t is not None:
>> +                                natact["attrs"].append([t, None])
>> +
>> +                                if ip_block_min is not None:
>> +                                    natact["attrs"].append(
>> +                                        ["OVS_NAT_ATTR_IP_MIN", ip_block_min]
>> +                                    )
>> +                                if ip_block_max is not None:
>> +                                    natact["attrs"].append(
>> +                                        ["OVS_NAT_ATTR_IP_MAX", ip_block_max]
>> +                                    )
>> +                                if proto_min is not None:
>> +                                    natact["attrs"].append(
>> +                                        ["OVS_NAT_ATTR_PROTO_MIN", proto_min]
>> +                                    )
>> +                                if proto_max is not None:
>> +                                    natact["attrs"].append(
>> +                                        ["OVS_NAT_ATTR_PROTO_MAX", proto_max]
>> +                                    )
>> +
>> +                            for natscan in (
>> +                                ("persist", "OVS_NAT_ATTR_PERSISTENT"),
>> +                                ("hash", "OVS_NAT_ATTR_PROTO_HASH"),
>> +                                ("random", "OVS_NAT_ATTR_PROTO_RANDOM"),
>> +                            ):
>
> I think this is not taking into account the comma that separates
> ip:port from these keywords. A possible solution would be to add it to
> the natscan (e.g: s/persist/,persist/).

I'll double check it, thanks!

>> +                                if actstr.startswith(natscan[0]):
>> +                                    actstr = actstr[len(natscan[0]) :]
>> +                                    natact["attrs"].append([natscan[1], None])
>> +                                    actstr = actstr[strspn(actstr, ", ") :]
>> +
>> +                        ctact["attrs"].append(["OVS_CT_ATTR_NAT", natact])
>> +                        actstr = actstr[strspn(actstr, ",) ") :]
>>                     self["attrs"].append(["OVS_ACTION_ATTR_CT",
>> ctact])
>>                   actstr = actstr[strspn(actstr, "), ") :]

