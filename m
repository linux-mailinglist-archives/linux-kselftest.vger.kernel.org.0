Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB078767027
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Jul 2023 17:09:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237092AbjG1PJI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 Jul 2023 11:09:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231848AbjG1PI6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 Jul 2023 11:08:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E76D35A3
        for <linux-kselftest@vger.kernel.org>; Fri, 28 Jul 2023 08:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690556890;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gRr5BONVtbzWtpOSxfQuykokzlwKEf5LYOHHxadZPWA=;
        b=Wh6JB1/DOIXm5pnaO0Bvkdmtl5IYTTiwVe+3l7Ebgur7nRSkh296o2PW6Vv48aPq+X/xSi
        SycDtQjqdHlSt45JPBMdz0aqBEycDfGQAKRUEHWNK/aAIO5CNm4GT1JLYcuagYoUYE2WA/
        2QuY9eY5doBMit606ETi8x6jrai7nRY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-567-AB_e6RPFNc-wfFPpHHavRQ-1; Fri, 28 Jul 2023 11:08:09 -0400
X-MC-Unique: AB_e6RPFNc-wfFPpHHavRQ-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-30793c16c78so1385013f8f.3
        for <linux-kselftest@vger.kernel.org>; Fri, 28 Jul 2023 08:08:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690556888; x=1691161688;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gRr5BONVtbzWtpOSxfQuykokzlwKEf5LYOHHxadZPWA=;
        b=AaHJpOCA6c10DowTyQH9gTJZCYteGGKB0hkjYM6OrhuNw9te9UrKitrL83UXcw+V0O
         aQgGqpCrBpDZ0s6vJ06xKtW/9E0QZHxXPhnfegEOEkeTqXDVL4tKxq/uiSVXi1JaeAt4
         M8dSpfq1utfU0MhiHFVTKKb0ktS3/r9woV34zDuu3dJrGAe8hhCXCEwM4s6IJICeN/l/
         b88tiYohFGt8zUlSdEJjVSSIkc3+iD9ZN/8DwVlhralNLQTqbdIi325me8Blc3P5zay0
         HEM0xS6jaPgP5cLBT4a+M5nhPUqaAWgOCqJyvnce0GKr0dr7A0l5acnzBJ/4Vl54RFW0
         rgzw==
X-Gm-Message-State: ABy/qLaSyUHjurNfsT/JiXt9/M+gvyTpcDGsUSTb/YQKJB7ys/KcuivL
        HT3JBrEX1oPAC1broWC68n+dZJUIjfGiq609ZYGwGUTqUMRJpAKn/XTxf5n7o5ZCTlvNAEinP5g
        eCuhdh2oPi06eI+YKKdbomqZTgBCu
X-Received: by 2002:a5d:658a:0:b0:314:1416:3be3 with SMTP id q10-20020a5d658a000000b0031414163be3mr2119903wru.70.1690556887870;
        Fri, 28 Jul 2023 08:08:07 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHDQpKetLM+AJNeRN4DNiG6HRo9Vh1XlHIRHofIKZCzScYmXNlC46bR+kl3uHUWrSGWoAz78A==
X-Received: by 2002:a5d:658a:0:b0:314:1416:3be3 with SMTP id q10-20020a5d658a000000b0031414163be3mr2119878wru.70.1690556887518;
        Fri, 28 Jul 2023 08:08:07 -0700 (PDT)
Received: from [192.168.1.67] (198.red-88-3-59.dynamicip.rima-tde.net. [88.3.59.198])
        by smtp.gmail.com with ESMTPSA id l7-20020adfe587000000b00314172ba213sm4991169wrm.108.2023.07.28.08.08.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jul 2023 08:08:07 -0700 (PDT)
Message-ID: <88eff25c-0849-118d-de1e-6ac7f59c9fd4@redhat.com>
Date:   Fri, 28 Jul 2023 17:08:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [ovs-dev] [PATCH v2 net-next 4/5] selftests: openvswitch: add
 basic ct test case parsing
Content-Language: en-US
To:     Aaron Conole <aconole@redhat.com>, netdev@vger.kernel.org
Cc:     dev@openvswitch.org, linux-kernel@vger.kernel.org,
        Ilya Maximets <i.maximets@ovn.org>,
        Eric Dumazet <edumazet@google.com>,
        linux-kselftest@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>,
        "David S. Miller" <davem@davemloft.net>
References: <20230728115940.578658-1-aconole@redhat.com>
 <20230728115940.578658-5-aconole@redhat.com>
From:   Adrian Moreno <amorenoz@redhat.com>
In-Reply-To: <20230728115940.578658-5-aconole@redhat.com>
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



On 7/28/23 13:59, Aaron Conole wrote:
> Forwarding via ct() action is an important use case for openvswitch, but
> generally would require using a full ovs-vswitchd to get working. Add a
> ct action parser for basic ct test case.
> 
> Signed-off-by: Aaron Conole <aconole@redhat.com>

Reviewed-by: Adrian Moreno <amorenoz@redhat.com>

> ---
> NOTE: 3 lines flag the line-length checkpatch warning, but there didnt
>        seem to be a really good way of breaking the lines smaller.
> 
>   .../selftests/net/openvswitch/openvswitch.sh  | 68 +++++++++++++++++++
>   .../selftests/net/openvswitch/ovs-dpctl.py    | 39 +++++++++++
>   2 files changed, 107 insertions(+)
> 
> diff --git a/tools/testing/selftests/net/openvswitch/openvswitch.sh b/tools/testing/selftests/net/openvswitch/openvswitch.sh
> index 5d60a9466dab..40a66c72af0f 100755
> --- a/tools/testing/selftests/net/openvswitch/openvswitch.sh
> +++ b/tools/testing/selftests/net/openvswitch/openvswitch.sh
> @@ -12,6 +12,7 @@ TRACING=0
>   
>   tests="
>   	arp_ping				eth-arp: Basic arp ping between two NS
> +	ct_connect_v4				ip4-ct-xon: Basic ipv4 tcp connection using ct
>   	connect_v4				ip4-xon: Basic ipv4 ping between two NS
>   	netlink_checks				ovsnl: validate netlink attrs and settings
>   	upcall_interfaces			ovs: test the upcall interfaces"
> @@ -193,6 +194,73 @@ test_arp_ping () {
>   	return 0
>   }
>   
> +# ct_connect_v4 test
> +#  - client has 1500 byte MTU
> +#  - server has 1500 byte MTU
> +#  - use ICMP to ping in each direction
> +#  - only allow CT state stuff to pass through new in c -> s
> +test_ct_connect_v4 () {
> +
> +	which nc >/dev/null 2>/dev/null || return $ksft_skip
> +
> +	sbx_add "test_ct_connect_v4" || return $?
> +
> +	ovs_add_dp "test_ct_connect_v4" ct4 || return 1
> +	info "create namespaces"
> +	for ns in client server; do
> +		ovs_add_netns_and_veths "test_ct_connect_v4" "ct4" "$ns" \
> +		    "${ns:0:1}0" "${ns:0:1}1" || return 1
> +	done
> +
> +	ip netns exec client ip addr add 172.31.110.10/24 dev c1
> +	ip netns exec client ip link set c1 up
> +	ip netns exec server ip addr add 172.31.110.20/24 dev s1
> +	ip netns exec server ip link set s1 up
> +
> +	# Add forwarding for ARP and ip packets - completely wildcarded
> +	ovs_add_flow "test_ct_connect_v4" ct4 \
> +		'in_port(1),eth(),eth_type(0x0806),arp()' '2' || return 1
> +	ovs_add_flow "test_ct_connect_v4" ct4 \
> +		'in_port(2),eth(),eth_type(0x0806),arp()' '1' || return 1
> +	ovs_add_flow "test_ct_connect_v4" ct4 \
> +		     'ct_state(-trk),eth(),eth_type(0x0800),ipv4()' \
> +		     'ct(commit),recirc(0x1)' || return 1
> +	ovs_add_flow "test_ct_connect_v4" ct4 \
> +		     'recirc_id(0x1),ct_state(+trk+new),in_port(1),eth(),eth_type(0x0800),ipv4(src=172.31.110.10)' \
> +		     '2' || return 1
> +	ovs_add_flow "test_ct_connect_v4" ct4 \
> +		     'recirc_id(0x1),ct_state(+trk+est),in_port(1),eth(),eth_type(0x0800),ipv4(src=172.31.110.10)' \
> +		     '2' || return 1
> +	ovs_add_flow "test_ct_connect_v4" ct4 \
> +		     'recirc_id(0x1),ct_state(+trk+est),in_port(2),eth(),eth_type(0x0800),ipv4(dst=172.31.110.10)' \
> +		     '1' || return 1
> +	ovs_add_flow "test_ct_connect_v4" ct4 \
> +		     'recirc_id(0x1),ct_state(+trk+inv),eth(),eth_type(0x0800),ipv4()' 'drop' || \
> +		     return 1
> +
> +	# do a ping
> +	ovs_sbx "test_ct_connect_v4" ip netns exec client ping 172.31.110.20 -c 3 || return 1
> +
> +	# create an echo server in 'server'
> +	echo "server" | \
> +		ovs_netns_spawn_daemon "test_ct_connect_v4" "server" \
> +				nc -lvnp 4443
> +	ovs_sbx "test_ct_connect_v4" ip netns exec client nc -i 1 -zv 172.31.110.20 4443 || return 1
> +
> +	# Now test in the other direction (should fail)
> +	echo "client" | \
> +		ovs_netns_spawn_daemon "test_ct_connect_v4" "client" \
> +				nc -lvnp 4443
> +	ovs_sbx "test_ct_connect_v4" ip netns exec client nc -i 1 -zv 172.31.110.10 4443
> +	if [ $? == 0 ]; then
> +	   info "ct connect to client was successful"
> +	   return 1
> +	fi
> +
> +	info "done..."
> +	return 0
> +}
> +
>   # connect_v4 test
>   #  - client has 1500 byte MTU
>   #  - server has 1500 byte MTU
> diff --git a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
> index 2b869e89c51d..6e258ab9e635 100644
> --- a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
> +++ b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
> @@ -62,6 +62,15 @@ def macstr(mac):
>       return outstr
>   
>   
> +def strcspn(str1, str2):
> +    tot = 0
> +    for char in str1:
> +        if str2.find(char) != -1:
> +            return tot
> +        tot += 1
> +    return tot
> +
> +
>   def strspn(str1, str2):
>       tot = 0
>       for char in str1:
> @@ -496,6 +505,36 @@ class ovsactions(nla):
>                       actstr = actstr[strspn(actstr, ", ") :]
>                       parsed = True
>   
> +            if parse_starts_block(actstr, "ct(", False):
> +                actstr = actstr[len("ct(") :]
> +                ctact = ovsactions.ctact()
> +
> +                for scan in (
> +                    ("commit", "OVS_CT_ATTR_COMMIT", None),
> +                    ("force_commit", "OVS_CT_ATTR_FORCE_COMMIT", None),
> +                    ("zone", "OVS_CT_ATTR_ZONE", int),
> +                    ("mark", "OVS_CT_ATTR_MARK", int),
> +                    ("helper", "OVS_CT_ATTR_HELPER", lambda x, y: str(x)),
> +                    ("timeout", "OVS_CT_ATTR_TIMEOUT", lambda x, y: str(x)),
> +                ):
> +                    if actstr.startswith(scan[0]):
> +                        actstr = actstr[len(scan[0]) :]
> +                        if scan[2] is not None:
> +                            if actstr[0] != "=":
> +                                raise ValueError("Invalid ct attr")
> +                            actstr = actstr[1:]
> +                            pos = strcspn(actstr, ",)")
> +                            datum = scan[2](actstr[:pos], 0)
> +                            ctact["attrs"].append([scan[1], datum])
> +                            actstr = actstr[pos:]
> +                        else:
> +                            ctact["attrs"].append([scan[1], None])
> +                        actstr = actstr[strspn(actstr, ", ") :]
> +
> +                self["attrs"].append(["OVS_ACTION_ATTR_CT", ctact])
> +                parsed = True
> +
> +            actstr = actstr[strspn(actstr, "), ") :]
>               if not parsed:
>                   raise ValueError("Action str: '%s' not supported" % actstr)
>   

-- 
Adrián Moreno

