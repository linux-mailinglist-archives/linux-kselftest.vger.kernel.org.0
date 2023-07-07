Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3748674AE9C
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jul 2023 12:15:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232055AbjGGKO7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 7 Jul 2023 06:14:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232820AbjGGKOg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 7 Jul 2023 06:14:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8261268C
        for <linux-kselftest@vger.kernel.org>; Fri,  7 Jul 2023 03:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688724776;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q0BiGIj/vOnPlIoZUpDP1153XdGlvd4F5wc78L4ppkE=;
        b=it4oJJyo0MbEeK8UMkUoGOGSOWZIaPwG8JqT7hRFZJ2z4tJl7KmmIhnWQBZDWy/nHZiCeA
        97sq8/moMYinfKnRjLtFipM0b21PjLARFQrP2P0aBMKv/TARSWclj7uGottVRSD79A28Ju
        l5WJ9w3DFqF0zRqXOBPejH1ZuaeCbLs=
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-gQUwpuzIPMOuN7K_W8swQQ-1; Fri, 07 Jul 2023 06:12:54 -0400
X-MC-Unique: gQUwpuzIPMOuN7K_W8swQQ-1
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-4438b8499ffso302660137.1
        for <linux-kselftest@vger.kernel.org>; Fri, 07 Jul 2023 03:12:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688724774; x=1691316774;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q0BiGIj/vOnPlIoZUpDP1153XdGlvd4F5wc78L4ppkE=;
        b=QvUJj30XKPKaTTs0xLlu6aHh9K4GHViRzcZGNALVtdkzrBLHO1aDKwOx7pScQzed5P
         dkbG7rebXpsZZf7lw4OZf6ae1IQTeU8PGfzql2odd5oioqNZ1RS1ZUryxANOiTejiZXT
         3m/0FwJ0jFkofznmX+me4WfMlXrdnMLG7JU3afBOXWpjgu/r/sFTAogIaz7yPXGrbniG
         sjE4fOar7jBjwj7YLxAZTDEDtr3Kmswec/ncsWd5/16XYO0SrWTefOZsQWe1Cb7cHz2E
         zEAQxZ/T7dsfVdlmAoOqrDSmQPhNO/3WRThjgZUdgZw1oJ7+kEtYtrp6TiyD5/h1Qn1P
         AYGQ==
X-Gm-Message-State: ABy/qLYCr91e3I8UMi/g2ZQe0rEmPALw2/427tyfjRupKGAsJgUroUvr
        wQeb2wggsE7Ux7OGHjugnTC4Z//L7Y7X3hcc06Raad1WV+kzuNkmrZshvc7cvqS3b6CqgyMncC1
        frCPEyOzXTYF54w/sNkxOzEIerVTA
X-Received: by 2002:a67:f7ca:0:b0:443:6afe:902b with SMTP id a10-20020a67f7ca000000b004436afe902bmr2491152vsp.24.1688724774268;
        Fri, 07 Jul 2023 03:12:54 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFmyHu68CqaecsSfpulT3FPFhmvTkYR/gPf8w8gCLr6dxZvGJH8O3NYxGMAY5RArCHWk4IcoQ==
X-Received: by 2002:a67:f7ca:0:b0:443:6afe:902b with SMTP id a10-20020a67f7ca000000b004436afe902bmr2491137vsp.24.1688724773943;
        Fri, 07 Jul 2023 03:12:53 -0700 (PDT)
Received: from [192.168.0.136] ([139.47.72.15])
        by smtp.gmail.com with ESMTPSA id e16-20020a05620a12d000b007339c5114a9sm1669120qkl.103.2023.07.07.03.12.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Jul 2023 03:12:53 -0700 (PDT)
Message-ID: <43015bcd-46a0-432c-a181-6d29c49f2513@redhat.com>
Date:   Fri, 7 Jul 2023 12:12:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [ovs-dev] [PATCH net-next 4/4] selftests: openvswitch: add ct-nat
 test case with ipv4
Content-Language: en-US
To:     Aaron Conole <aconole@redhat.com>, netdev@vger.kernel.org
Cc:     dev@openvswitch.org, Ilya Maximets <i.maximets@ovn.org>,
        Eric Dumazet <edumazet@google.com>,
        linux-kselftest@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, shuah@kernel.org,
        "David S. Miller" <davem@davemloft.net>
References: <20230628162714.392047-1-aconole@redhat.com>
 <20230628162714.392047-5-aconole@redhat.com>
From:   Adrian Moreno <amorenoz@redhat.com>
In-Reply-To: <20230628162714.392047-5-aconole@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 6/28/23 18:27, Aaron Conole wrote:
> Building on the previous work, add a very simplistic NAT case
> using ipv4.  This just tests dnat transformation
> 
> Signed-off-by: Aaron Conole <aconole@redhat.com>

Hi Aaron,

I know that the goal is not to support the full syntax, and that nat is a 
specially convoluted action, so I'm just commenting on the low-hanging fruits 
(see below).

> ---
>   .../selftests/net/openvswitch/openvswitch.sh  | 64 +++++++++++++++++++
>   .../selftests/net/openvswitch/ovs-dpctl.py    | 60 +++++++++++++++++
>   2 files changed, 124 insertions(+)
> 
> diff --git a/tools/testing/selftests/net/openvswitch/openvswitch.sh b/tools/testing/selftests/net/openvswitch/openvswitch.sh
> index 40a66c72af0f0..dced4f612a78c 100755
> --- a/tools/testing/selftests/net/openvswitch/openvswitch.sh
> +++ b/tools/testing/selftests/net/openvswitch/openvswitch.sh
> @@ -14,6 +14,7 @@ tests="
>   	arp_ping				eth-arp: Basic arp ping between two NS
>   	ct_connect_v4				ip4-ct-xon: Basic ipv4 tcp connection using ct
>   	connect_v4				ip4-xon: Basic ipv4 ping between two NS
> +	nat_connect_v4				ip4-nat-xon: Basic ipv4 tcp connection via NAT
>   	netlink_checks				ovsnl: validate netlink attrs and settings
>   	upcall_interfaces			ovs: test the upcall interfaces"
>   
> @@ -300,6 +301,69 @@ test_connect_v4 () {
>   	return 0
>   }
>   
> +# nat_connect_v4 test
> +#  - client has 1500 byte MTU
> +#  - server has 1500 byte MTU
> +#  - use ICMP to ping in each direction
> +#  - only allow CT state stuff to pass through new in c -> s
> +test_nat_connect_v4 () {
> +	which nc >/dev/null 2>/dev/null || return $ksft_skip
> +
> +	sbx_add "test_nat_connect_v4" || return $?
> +
> +	ovs_add_dp "test_nat_connect_v4" nat4 || return 1
> +	info "create namespaces"
> +	for ns in client server; do
> +		ovs_add_netns_and_veths "test_nat_connect_v4" "nat4" "$ns" \
> +		    "${ns:0:1}0" "${ns:0:1}1" || return 1
> +	done
> +
> +	ip netns exec client ip addr add 172.31.110.10/24 dev c1
> +	ip netns exec client ip link set c1 up
> +	ip netns exec server ip addr add 172.31.110.20/24 dev s1
> +	ip netns exec server ip link set s1 up
> +
> +	ip netns exec client ip route add default via 172.31.110.20
> +
> +	ovs_add_flow "test_nat_connect_v4" nat4 \
> +		'in_port(1),eth(),eth_type(0x0806),arp()' '2' || return 1
> +	ovs_add_flow "test_nat_connect_v4" nat4 \
> +		'in_port(2),eth(),eth_type(0x0806),arp()' '1' || return 1
> +	ovs_add_flow "test_nat_connect_v4" nat4 \
> +		"ct_state(-trk),in_port(1),eth(),eth_type(0x0800),ipv4(dst=192.168.0.20)" \
> +		"ct(commit,nat(dst=172.31.110.20)),recirc(0x1)"
> +	ovs_add_flow "test_nat_connect_v4" nat4 \
> +		"ct_state(-trk),in_port(2),eth(),eth_type(0x0800),ipv4()" \
> +		"ct(commit,nat),recirc(0x2)"
> +
> +	ovs_add_flow "test_nat_connect_v4" nat4 \
> +		"recirc_id(0x1),ct_state(+trk-inv),in_port(1),eth(),eth_type(0x0800),ipv4()" "2"
> +	ovs_add_flow "test_nat_connect_v4" nat4 \
> +		"recirc_id(0x2),ct_state(+trk-inv),in_port(2),eth(),eth_type(0x0800),ipv4()" "1"
> +
> +	# do a ping
> +	ovs_sbx "test_nat_connect_v4" ip netns exec client ping 192.168.0.20 -c 3 || return 1
> +
> +	# create an echo server in 'server'
> +	echo "server" | \
> +		ovs_netns_spawn_daemon "test_nat_connect_v4" "server" \
> +				nc -lvnp 4443
> +	ovs_sbx "test_nat_connect_v4" ip netns exec client nc -i 1 -zv 192.168.0.20 4443 || return 1
> +
> +	# Now test in the other direction (should fail)
> +	echo "client" | \
> +		ovs_netns_spawn_daemon "test_nat_connect_v4" "client" \
> +				nc -lvnp 4443
> +	ovs_sbx "test_nat_connect_v4" ip netns exec client nc -i 1 -zv 172.31.110.10 4443
> +	if [ $? == 0 ]; then
> +	   info "connect to client was successful"
> +	   return 1
> +	fi
> +
> +	info "done..."
> +	return 0
> +}
> +
>   # netlink_validation
>   # - Create a dp
>   # - check no warning with "old version" simulation
> diff --git a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
> index 704cb4adf79a9..12ba5265b88fb 100644
> --- a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
> +++ b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
> @@ -511,6 +511,66 @@ class ovsactions(nla):
>                           else:
>                               ctact["attrs"].append([scan[1], None])
>                           actstr = actstr[strspn(actstr, ", ") :]
> +                    # it seems strange to put this here, but nat() is a complex
> +                    # sub-action and this lets it sit anywhere in the ct() action
> +                    if actstr.startswith("nat"):
> +                        actstr = actstr[3:]
> +                        natact = ovsactions.ctact.natattr()
> +
> +                        if actstr.startswith("("):
> +                            t = None
> +                            actstr = actstr[1:]
> +                            if actstr.startswith("src"):
> +                                t = "OVS_NAT_ATTR_SRC"
> +                                actstr = actstr[3:]
> +                            elif actstr.startswith("dst"):
> +                                t = "OVS_NAT_ATTR_DST"
> +                                actstr = actstr[3:]
> +
> +                            actstr, ip_block_min = parse_extract_field(
> +                                actstr, "=", "([0-9a-fA-F:\.]+)", str, False
> +                            )
> +                            actstr, ip_block_max = parse_extract_field(
> +                                actstr, "-", "([0-9a-fA-F:\.]+)", str, False
> +                            )

Having the ":" character here makes this line parse the port as well (i.e: 
1.1.1.1:6789 as ip_block_max) which then makes ip address parsing fail.


> +                            actstr, proto_min = parse_extract_field(
> +                                actstr, ":", "(\d+)", int, False
> +                            )
> +                            actstr, proto_max = parse_extract_field(
> +                                actstr, "-", "(\d+)", int, False
> +                            )
> +                            if t is not None:
> +                                natact["attrs"].append([t, None])
> +
> +                                if ip_block_min is not None:
> +                                    natact["attrs"].append(
> +                                        ["OVS_NAT_ATTR_IP_MIN", ip_block_min]
> +                                    )
> +                                if ip_block_max is not None:
> +                                    natact["attrs"].append(
> +                                        ["OVS_NAT_ATTR_IP_MAX", ip_block_max]
> +                                    )
> +                                if proto_min is not None:
> +                                    natact["attrs"].append(
> +                                        ["OVS_NAT_ATTR_PROTO_MIN", proto_min]
> +                                    )
> +                                if proto_max is not None:
> +                                    natact["attrs"].append(
> +                                        ["OVS_NAT_ATTR_PROTO_MAX", proto_max]
> +                                    )
> +
> +                            for natscan in (
> +                                ("persist", "OVS_NAT_ATTR_PERSISTENT"),
> +                                ("hash", "OVS_NAT_ATTR_PROTO_HASH"),
> +                                ("random", "OVS_NAT_ATTR_PROTO_RANDOM"),
> +                            ):

I think this is not taking into account the comma that separates ip:port from 
these keywords. A possible solution would be to add it to the natscan (e.g: 
s/persist/,persist/).

> +                                if actstr.startswith(natscan[0]):
> +                                    actstr = actstr[len(natscan[0]) :]
> +                                    natact["attrs"].append([natscan[1], None])
> +                                    actstr = actstr[strspn(actstr, ", ") :]
> +
> +                        ctact["attrs"].append(["OVS_CT_ATTR_NAT", natact])
> +                        actstr = actstr[strspn(actstr, ",) ") :]
>   
>                   self["attrs"].append(["OVS_ACTION_ATTR_CT", ctact])
>                   actstr = actstr[strspn(actstr, "), ") :]

-- 
Adrián Moreno

