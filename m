Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A23347657C2
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Jul 2023 17:35:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232001AbjG0Pe6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 27 Jul 2023 11:34:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231799AbjG0Pe5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 27 Jul 2023 11:34:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE95C211C
        for <linux-kselftest@vger.kernel.org>; Thu, 27 Jul 2023 08:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690472049;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FrZxwHP4S8NUkOKu182yLC6CoPV/jo8VZgoF1heo5gQ=;
        b=TOj9WiKVq5AdAFUinflLCAs1EC7kPvzTYj/PtSZ48+GqzgEOfiz5X0+zCDJPMFhUl/woi3
        7Vo5ST9ILks9DNP5fobrfO3BYvdEXmDErfjTi3RKdq79JtHC47VEO54hEyOBpUIRqGCQ88
        iesSYdGG75PG6hPDz8PFFpOvsmFsoZM=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-286-SX88gJ6nNg2CR7gNF588CA-1; Thu, 27 Jul 2023 11:34:05 -0400
X-MC-Unique: SX88gJ6nNg2CR7gNF588CA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A32FB1C04326;
        Thu, 27 Jul 2023 15:34:04 +0000 (UTC)
Received: from RHTPC1VM0NT (unknown [10.22.8.217])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 483484094DC0;
        Thu, 27 Jul 2023 15:34:03 +0000 (UTC)
From:   Aaron Conole <aconole@redhat.com>
To:     Adrian Moreno <amorenoz@redhat.com>
Cc:     netdev@vger.kernel.org, dev@openvswitch.org,
        Ilya Maximets <i.maximets@ovn.org>,
        Eric Dumazet <edumazet@google.com>,
        linux-kselftest@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, shuah@kernel.org,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [ovs-dev] [PATCH net-next 1/4] selftests: openvswitch: add an
 initial flow programming case
References: <20230628162714.392047-1-aconole@redhat.com>
        <20230628162714.392047-2-aconole@redhat.com>
        <9375ccbc-dd40-9998-dde5-c94e4e28f4f1@redhat.com>
Date:   Thu, 27 Jul 2023 11:34:02 -0400
In-Reply-To: <9375ccbc-dd40-9998-dde5-c94e4e28f4f1@redhat.com> (Adrian
        Moreno's message of "Fri, 7 Jul 2023 17:40:14 +0200")
Message-ID: <f7tfs59cqs5.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Adrian Moreno <amorenoz@redhat.com> writes:

> On 6/28/23 18:27, Aaron Conole wrote:
>> The openvswitch self-tests can test much of the control side of
>> the module (ie: what a vswitchd implementation would process),
>> but the actual packet forwarding cases aren't supported, making
>> the testing of limited value.
>> Add some flow parsing and an initial ARP based test case using
>> arping utility.  This lets us display flows, add some basic
>> output flows with simple matches, and test against a known good
>> forwarding case.
>> Signed-off-by: Aaron Conole <aconole@redhat.com>
>> ---
>> NOTE: 3 lines flag the line-length checkpatch warning, but there didn't
>>        seem to bea good way of breaking the lines smaller for 2 of them.
>>        The third would still flag, even if broken at what looks like a
>>        good point to break it.
>>   .../selftests/net/openvswitch/openvswitch.sh  |  51 +++
>>   .../selftests/net/openvswitch/ovs-dpctl.py    | 408 ++++++++++++++++++
>>   2 files changed, 459 insertions(+)
>> diff --git a/tools/testing/selftests/net/openvswitch/openvswitch.sh
>> b/tools/testing/selftests/net/openvswitch/openvswitch.sh
>> index 3117a4be0cd04..5cdacb3c8c925 100755
>> --- a/tools/testing/selftests/net/openvswitch/openvswitch.sh
>> +++ b/tools/testing/selftests/net/openvswitch/openvswitch.sh
>> @@ -11,6 +11,7 @@ VERBOSE=0
>>   TRACING=0
>>     tests="
>> +	arp_ping				eth-arp: Basic arp ping between two NS
>>   	netlink_checks				ovsnl: validate netlink attrs and settings
>>   	upcall_interfaces			ovs: test the upcall interfaces"
>>   @@ -127,6 +128,16 @@ ovs_add_netns_and_veths () {
>>   	return 0
>>   }
>>   +ovs_add_flow () {
>> +	info "Adding flow to DP: sbx:$1 br:$2 flow:$3 act:$4"
>> +	ovs_sbx "$1" python3 $ovs_base/ovs-dpctl.py add-flow "$2" "$3" "$4"
>> +	if [ $? -ne 0 ]; then
>> +		echo "Flow [ $3 : $4 ] failed" >> ${ovs_dir}/debug.log
>> +		return 1
>> +	fi
>> +	return 0
>> +}
>> +
>>   usage() {
>>   	echo
>>   	echo "$0 [OPTIONS] [TEST]..."
>> @@ -141,6 +152,46 @@ usage() {
>>   	exit 1
>>   }
>>   +# arp_ping test
>> +# - client has 1500 byte MTU
>> +# - server has 1500 byte MTU
>> +# - send ARP ping between two ns
>> +test_arp_ping () {
>> +
>> +	which arping >/dev/null 2>&1 || return $ksft_skip
>> +
>> +	sbx_add "test_arp_ping" || return $?
>> +
>> +	ovs_add_dp "test_arp_ping" arpping || return 1
>> +
>> +	info "create namespaces"
>> +	for ns in client server; do
>> +		ovs_add_netns_and_veths "test_arp_ping" "arpping" "$ns" \
>> +		    "${ns:0:1}0" "${ns:0:1}1" || return 1
>> +	done
>> +
>> +	# Setup client namespace
>> +	ip netns exec client ip addr add 172.31.110.10/24 dev c1
>> +	ip netns exec client ip link set c1 up
>> + HW_CLIENT=`ip netns exec client ip link show dev c1 | grep -E
> 'link/ether [0-9a-f:]+' | awk '{print $2;}'`
>> +	info "Client hwaddr: $HW_CLIENT"
>> +
>> +	# Setup server namespace
>> +	ip netns exec server ip addr add 172.31.110.20/24 dev s1
>> +	ip netns exec server ip link set s1 up
>> + HW_SERVER=`ip netns exec server ip link show dev s1 | grep -E
> 'link/ether [0-9a-f:]+' | awk '{print $2;}'`
>> +	info "Server hwaddr: $HW_SERVER"
>> +
>> +	ovs_add_flow "test_arp_ping" arpping \
>> +
> "in_port(1),eth(),eth_type(0x0806),arp(sip=172.31.110.10,tip=172.31.110.20,sha=$HW_CLIENT,tha=ff:ff:ff:ff:ff:ff)"
> '2' || return 1
>> +	ovs_add_flow "test_arp_ping" arpping \
>> +		"in_port(2),eth(),eth_type(0x0806),arp()" '1' || return 1
>> +
>> +	ovs_sbx "test_arp_ping" ip netns exec client arping -I c1 172.31.110.20 -c 1 || return 1
>> +
>> +	return 0
>> +}
>> +
>>   # netlink_validation
>>   # - Create a dp
>>   # - check no warning with "old version" simulation
>> diff --git a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
> b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
>> index 1c8b36bc15d48..799bfb3064b90 100644
>> --- a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
>> +++ b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
>> @@ -9,9 +9,12 @@ import errno
>>   import ipaddress
>>   import logging
>>   import multiprocessing
>> +import re
>>   import struct
>>   import sys
>>   import time
>> +import types
>> +import uuid
>>     try:
>>       from pyroute2 import NDB
>> @@ -59,6 +62,104 @@ def macstr(mac):
>>       return outstr
>>     +def strspn(str1, str2):
>> +    tot = 0
>> +    for char in str1:
>> +        if str2.find(char) == -1:
>> +            return tot
>> +        tot += 1
>> +    return tot
>> +
>> +
>> +def intparse(statestr, defmask="0xffffffff"):
>> +    totalparse = strspn(statestr, "0123456789abcdefABCDEFx/")
>> +    # scan until "/"
>> +    count = strspn(statestr, "x0123456789abcdefABCDEF")
>> +
>> +    firstnum = statestr[:count]
>> +    if firstnum[-1] == "/":
>> +        firstnum = firstnum[:-1]
>> +    k = int(firstnum, 0)
>> +
>> +    m = None
>> +    if defmask is not None:
>> +        secondnum = defmask
>> +        if statestr[count] == "/":
>> +            secondnum = statestr[count + 1 :]  # this is wrong...
>> +        m = int(secondnum, 0)
>> +
>> +    return statestr[totalparse + 1 :], k, m
>> +
>> +
>> +def parse_flags(flag_str, flag_vals):
>> +    bitResult = 0
>> +    maskResult = 0
>> +
>> +    if len(flag_str) == 0:
>> +        return flag_str, bitResult, maskResult
>> +
>> +    if flag_str[0].isdigit():
>> +        idx = 0
>> +        while flag_str[idx].isdigit() or flag_str[idx] == "x":
>> +            idx += 1
>> +        digits = flag_str[:idx]
>> +        flag_str = flag_str[idx:]
>> +
>> +        bitResult = int(digits, 0)
>> +        maskResult = int(digits, 0)
>> +
>> +    while len(flag_str) > 0 and (flag_str[0] == "+" or flag_str[0] == "-"):
>> +        if flag_str[0] == "+":
>> +            setFlag = True
>> +        elif flag_str[0] == "-":
>> +            setFlag = False
>> +
>> +        flag_str = flag_str[1:]
>> +
>> +        flag_len = 0
>> +        while (
>> +            flag_str[flag_len] != "+"
>> +            and flag_str[flag_len] != "-"
>> +            and flag_str[flag_len] != ","
>> +            and flag_str[flag_len] != ")"
>> +        ):
>> +            flag_len += 1
>> +
>> +        flag = flag_str[0:flag_len]
>> +
>> +        if flag in flag_vals:
>> +            if maskResult & flag_vals[flag]:
>> +                raise KeyError(
>> +                    "Flag %s set once, cannot be set in multiples" % flag
>> +                )
>> +
>> +            if setFlag:
>> +                bitResult |= flag_vals[flag]
>> +
>> +            maskResult |= flag_vals[flag]
>> +        else:
>> +            raise KeyError("Missing flag value: %s" % flag)
>> +
>> +        flag_str = flag_str[flag_len:]
>> +
>> +    return flag_str, bitResult, maskResult
>> +
>> +
>> +def parse_ct_state(statestr):
>> +    ct_flags = {
>> +        "new": 1 << 0,
>> +        "est": 1 << 1,
>> +        "rel": 1 << 2,
>> +        "rpl": 1 << 3,
>> +        "inv": 1 << 4,
>> +        "trk": 1 << 5,
>> +        "snat": 1 << 6,
>> +        "dnat": 1 << 7,
>> +    }
>> +
>> +    return parse_flags(statestr, ct_flags)
>> +
>> +
>>   def convert_mac(mac_str, mask=False):
>>       if mac_str is None or mac_str == "":
>>           mac_str = "00:00:00:00:00:00"
>> @@ -79,6 +180,61 @@ def convert_ipv4(ip, mask=False):
>>       return int(ipaddress.IPv4Address(ip))
>>     +def parse_starts_block(block_str, scanstr, returnskipped,
>> scanregex=False):
>> +    if scanregex:
>> +        m = re.search(scanstr, block_str)
>> +        if m is None:
>> +            if returnskipped:
>> +                return block_str
>> +            return False
>> +        if returnskipped:
>> +            block_str = block_str[len(m.group(0)) :]
>> +            return block_str
>> +        return True
>> +
>> +    if block_str.startswith(scanstr):
>> +        if returnskipped:
>> +            block_str = block_str[len(scanstr) :]
>> +        else:
>> +            return True
>> +
>> +    if returnskipped:
>> +        return block_str
>> +
>> +    return False
>> +
>> +
>> +def parse_extract_field(
>> +    block_str, fieldstr, scanfmt, convert, masked=False, defval=None
>> +):
>> +    if fieldstr and not block_str.startswith(fieldstr):
>> +        return block_str, defval
>> +
>> +    if fieldstr:
>> +        str_skiplen = len(fieldstr)
>> +        str_skipped = block_str[str_skiplen:]
>> +        if str_skiplen == 0:
>> +            return str_skipped, defval
>> +    else:
>> +        str_skiplen = 0
>> +        str_skipped = block_str
>> +
>> +    m = re.search(scanfmt, str_skipped)
>> +    if m is None:
>> +        raise ValueError("Bad fmt string")
>> +
>> +    data = m.group(0)
>> +    if convert:
>> +        data = convert(m.group(0))
>> +
>> +    str_skipped = str_skipped[len(m.group(0)) :]
>> +    if masked:
>> +        if str_skipped[0] == "/":
>> +            raise ValueError("Masking support TBD...")
>> +
>> +    return str_skipped, data
>> +
>> +
>>   class ovs_dp_msg(genlmsg):
>>       # include the OVS version
>>       # We need a custom header rather than just being able to rely on
>> @@ -278,6 +434,52 @@ class ovsactions(nla):
>>             return print_str
>>   +    def parse(self, actstr):
>> +        parsed = False
>> +        while len(actstr) != 0:
>> +            if actstr.startswith("drop"):
>> +                # for now, drops have no explicit action, so we
>> +                # don't need to set any attributes.  The final
>> +                # act of the processing chain will just drop the packet
>> +                return
>> +
>> +            elif parse_starts_block(actstr, "^(\d+)", False, True):
>> +                actstr, output = parse_extract_field(
>> +                    actstr, None, "(\d+)", lambda x: int(x), False, "0"
>> +                )
>> +                actstr = actstr[strspn(actstr, ", ") :]
>> +                self["attrs"].append(["OVS_ACTION_ATTR_OUTPUT", output])
>> +                parsed = True
>> +            elif parse_starts_block(actstr, "recirc(", False):
>> +                actstr, recircid = parse_extract_field(
>> +                    actstr,
>> +                    "recirc(",
>> +                    "([0-9a-fA-Fx]+)",
>> +                    lambda x: int(x, 0),
>> +                    False,
>> +                    0,
>> +                )
>> +                actstr = actstr[strspn(actstr, "), ") :]
>> +                self["attrs"].append(["OVS_ACTION_ATTR_RECIRC", recircid])
>> +                parsed = True
>> +
>> +            parse_flat_map = (
>> +                ("ct_clear", "OVS_ACTION_ATTR_CT_CLEAR"),
>> +                ("pop_vlan", "OVS_ACTION_ATTR_POP_VLAN"),
>> +                ("pop_eth", "OVS_ACTION_ATTR_POP_ETH"),
>> +                ("pop_nsh", "OVS_ACTION_ATTR_POP_NSH"),
>> +            )
>> +
>> +            for flat_act in parse_flat_map:
>> +                if parse_starts_block(actstr, flat_act[0], False):
>> +                    actstr += len(flat_act[0])
>> +                    self["attrs"].append([flat_act[1]])
>> +                    actstr = actstr[strspn(actstr, ", ") :]
>> +                    parsed = True
>> +
>> +            if not parsed:
>> +                raise ValueError("Action str: '%s' not supported" % actstr)
>> +
>>     class ovskey(nla):
>>       nla_flags = NLA_F_NESTED
>> @@ -347,6 +549,53 @@ class ovskey(nla):
>>                   init=init,
>>               )
>>   +        def parse(self, flowstr, typeInst):
>> +            if not flowstr.startswith(self.proto_str):
>> +                return None, None
>> +
>> +            k = typeInst()
>> +            m = typeInst()
>> +
>> +            flowstr = flowstr[len(self.proto_str) :]
>> +            if flowstr.startswith("("):
>> +                flowstr = flowstr[1:]
>> +
>> +            keybits = b""
>> +            maskbits = b""
>> +            for f in self.fields_map:
>> +                if flowstr.startswith(f[1]):
>> +                    # the following assumes that the field looks
>> +                    # something like 'field.' where '.' is a
>> +                    # character that we don't exactly care about.
>> +                    flowstr = flowstr[len(f[1]) + 1 :]
>> +                    splitchar = 0
>> +                    for c in flowstr:
>> +                        if c == "," or c == ")":
>> +                            break
>> +                        splitchar += 1
>> +                    data = flowstr[:splitchar]
>> +                    flowstr = flowstr[splitchar:]
>> +                else:
>> +                    data = None
>> +
>> +                if len(f) > 4:
>> +                    func = f[4]
>> +                else:
>> +                    func = f[3]
>> +                k[f[0]] = func(data)
>> +                if len(f) > 4:
>> +                    m[f[0]] = func(data, True)
>> +                else:
>> +                    m[f[0]] = func(data)
>> +
>> +                flowstr = flowstr[strspn(flowstr, ", ") :]
>> +                if len(flowstr) == 0:
>> +                    return flowstr, k, m
>> +
>> +            flowstr = flowstr[strspn(flowstr, "), ") :]
>> +
>> +            return flowstr, k, m
>> +
>>           def dpstr(self, masked=None, more=False):
>>               outstr = self.proto_str + "("
>>               first = False
>> @@ -810,6 +1059,71 @@ class ovskey(nla):
>>       class ovs_key_mpls(nla):
>>           fields = (("lse", ">I"),)
>>   +    def parse(self, flowstr, mask=None):
>> +        for field in (
>> +            ("OVS_KEY_ATTR_PRIORITY", "skb_priority", intparse),
>> +            ("OVS_KEY_ATTR_SKB_MARK", "skb_mark", intparse),
>> +            ("OVS_KEY_ATTR_RECIRC_ID", "recirc_id", intparse),
>> +            ("OVS_KEY_ATTR_DP_HASH", "dp_hash", intparse),
>> +            ("OVS_KEY_ATTR_CT_STATE", "ct_state", parse_ct_state),
>> +            ("OVS_KEY_ATTR_CT_ZONE", "ct_zone", intparse),
>> +            ("OVS_KEY_ATTR_CT_MARK", "ct_mark", intparse),
>> +            ("OVS_KEY_ATTR_IN_PORT", "in_port", intparse),
>> +            (
>> +                "OVS_KEY_ATTR_ETHERNET",
>> +                "eth",
>> +                ovskey.ethaddr,
>> +            ),
>> +            (
>> +                "OVS_KEY_ATTR_ETHERTYPE",
>> +                "eth_type",
>> +                lambda x: intparse(x, "0xffff"),
>> +            ),
>> +            (
>> +                "OVS_KEY_ATTR_IPV4",
>> +                "ipv4",
>> +                ovskey.ovs_key_ipv4,
>> +            ),
>> +            (
>> +                "OVS_KEY_ATTR_IPV6",
>> +                "ipv6",
>> +                ovskey.ovs_key_ipv6,
>> +            ),
>> +            (
>> +                "OVS_KEY_ATTR_ARP",
>> +                "arp",
>> +                ovskey.ovs_key_arp,
>> +            ),
>> +            (
>> +                "OVS_KEY_ATTR_TCP",
>> +                "tcp",
>> +                ovskey.ovs_key_tcp,
>> +            ),
>> +            (
>> +                "OVS_KEY_ATTR_TCP_FLAGS",
>> +                "tcp_flags",
>> +                lambda x: parse_flags(x, None),
>> +            ),
>> +        ):
>> +            fld = field[1] + "("
>> +            if not flowstr.startswith(fld):
>> +                continue
>> +
>> +            if not isinstance(field[2], types.FunctionType):
>> +                nk = field[2]()
>> +                flowstr, k, m = nk.parse(flowstr, field[2])
>> +            else:
>> +                flowstr = flowstr[len(fld) :]
>> +                flowstr, k, m = field[2](flowstr)
>> +
>> +            if m and mask is not None:
>> +                mask["attrs"].append([field[0], m])
>> +            self["attrs"].append([field[0], k])
>> +
>> +            flowstr = flowstr[strspn(flowstr, "),") :]
>> +
>> +        return flowstr
>> +
>>       def dpstr(self, mask=None, more=False):
>>           print_str = ""
>>   @@ -1358,11 +1672,92 @@ class OvsFlow(GenericNetlinkSocket):
>>                 return print_str
>>   +        def parse(self, flowstr, actstr, dpidx=0):
>> +            OVS_UFID_F_OMIT_KEY = 1 << 0
>> +            OVS_UFID_F_OMIT_MASK = 1 << 1
>> +            OVS_UFID_F_OMIT_ACTIONS = 1 << 2
>> +
>> +            self["cmd"] = 0
>> +            self["version"] = 0
>> +            self["reserved"] = 0
>> +            self["dpifindex"] = 0
>> +
>> +            if flowstr.startswith("ufid:"):
>> +                count = 5
>> +                while flowstr[count] != ",":
>> +                    count += 1
>> +                ufidstr = flowstr[5:count]
>> +                flowstr = flowstr[count + 1 :]
>> +            else:
>> +                ufidstr = str(uuid.uuid4())
>> +            uuidRawObj = uuid.UUID(ufidstr).fields
>> +
>> +            self["attrs"].append(
>> +                [
>> +                    "OVS_FLOW_ATTR_UFID",
>> +                    [
>> +                        uuidRawObj[0],
>> +                        uuidRawObj[1] << 16 | uuidRawObj[2],
>> +                        uuidRawObj[3] << 24
>> +                        | uuidRawObj[4] << 16
>> +                        | uuidRawObj[5] & (0xFF << 32) >> 32,
>> +                        uuidRawObj[5] & (0xFFFFFFFF),
>> +                    ],
>> +                ]
>> +            )
>> +            self["attrs"].append(
>> +                [
>> +                    "OVS_FLOW_ATTR_UFID_FLAGS",
>> +                    int(
>> +                        OVS_UFID_F_OMIT_KEY
>> +                        | OVS_UFID_F_OMIT_MASK
>> +                        | OVS_UFID_F_OMIT_ACTIONS
>> +                    ),
>> +                ]
>> +            )
>> +
>> +            k = ovskey()
>> +            m = ovskey()
>> +            k.parse(flowstr, m)
>> +            self["attrs"].append(["OVS_FLOW_ATTR_KEY", k])
>> +            self["attrs"].append(["OVS_FLOW_ATTR_MASK", m])
>> +
>> +            a = ovsactions()
>> +            a.parse(actstr)
>> +            self["attrs"].append(["OVS_FLOW_ATTR_ACTIONS", a])
>> +
>>       def __init__(self):
>>           GenericNetlinkSocket.__init__(self)
>>             self.bind(OVS_FLOW_FAMILY, OvsFlow.ovs_flow_msg)
>>   +    def add_flow(self, dpifindex, flowmsg):
>> +        """
>> +        Send a new flow message to the kernel.
>> +
>> +        dpifindex should be a valid datapath obtained by calling
>> +        into the OvsDatapath lookup
>> +
>> +        flowmsg is a flow object obtained by calling a dpparse
>> +        """
>> +
>> +        flowmsg["cmd"] = OVS_FLOW_CMD_NEW
>> +        flowmsg["version"] = OVS_DATAPATH_VERSION
>> +        flowmsg["reserved"] = 0
>> +        flowmsg["dpifindex"] = dpifindex
>> +
>> +        try:
>> +            reply = self.nlm_request(
>> +                flowmsg,
>> +                msg_type=self.prid,
>> +                msg_flags=NLM_F_REQUEST | NLM_F_ACK,
>> +            )
>> +            reply = reply[0]
>> +        except NetlinkError as ne:
>> +            print(flowmsg)
>> +            raise ne
>> +        return reply
>> +
>>       def dump(self, dpifindex, flowspec=None):
>>           """
>>           Returns a list of messages containing flows.
>> @@ -1514,6 +1909,11 @@ def main(argv):
>>       dumpflcmd = subparsers.add_parser("dump-flows")
>>       dumpflcmd.add_argument("dumpdp", help="Datapath Name")
>>   +    addflcmd = subparsers.add_parser("add-flow")
>> +    addflcmd.add_argument("flbr", help="Datapath name")
>> +    addflcmd.add_argument("flow", help="Flow specification")
>> +    addflcmd.add_argument("acts", help="Flow actions")
>> +
>>       args = parser.parse_args()
>>         if args.verbose > 0:
>> @@ -1589,6 +1989,14 @@ def main(argv):
>>           rep = ovsflow.dump(rep["dpifindex"])
>>           for flow in rep:
>>               print(flow.dpstr(True if args.verbose > 0 else False))
>> +    elif hasattr(args, "flbr"):
>
> These checks on the attributes means every command must have
> attributes with different names. So if we then add del-br it must not
> have an attribute called "flbr". We could rename it to "fladdbr"
> (following the other commands) or match on the subcommand name, which
> would be cleaner imho and less error, e.g: all the datapath attributes
> can be called the same (see below).

I agree we can adjust this to use the subparser dest= and just check for
the specific command passed.  I will do that in a different series, just
to keep it as a separate thing.

>> +        rep = ovsdp.info(args.flbr, 0)
>> +        if rep is None:
>> +            print("DP '%s' not found." % args.dumpdp)
>
> "dumpdp" is not an attribute of this subcommand.

I'll fix this.

>> +            return 1
>> +        flow = OvsFlow.ovs_flow_msg()
>> +        flow.parse(args.flow, args.acts, rep["dpifindex"])
>> +        ovsflow.add_flow(rep["dpifindex"], flow)
>>         return 0
>>   

