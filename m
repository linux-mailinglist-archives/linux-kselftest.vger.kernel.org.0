Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD1DDC309F
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Oct 2019 11:52:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726461AbfJAJuj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 1 Oct 2019 05:50:39 -0400
Received: from kirsty.vergenet.net ([202.4.237.240]:34152 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725765AbfJAJuj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 1 Oct 2019 05:50:39 -0400
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
        by kirsty.vergenet.net (Postfix) with ESMTPA id 5E92D25B7D2;
        Tue,  1 Oct 2019 19:50:35 +1000 (AEST)
Received: by reginn.horms.nl (Postfix, from userid 7100)
        id 24F8094046A; Tue,  1 Oct 2019 11:50:33 +0200 (CEST)
Date:   Tue, 1 Oct 2019 11:50:33 +0200
From:   Simon Horman <horms@verge.net.au>
To:     Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
Cc:     Shuah Khan <shuah@kernel.org>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        "David S. Miller" <davem@davemloft.net>,
        Julian Anastasov <ja@ssi.bg>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, lvs-devel@vger.kernel.org,
        netfilter-devel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] selftests: netfilter: add ipvs test script
Message-ID: <20191001095032.4uxaw3k45afvyp4j@verge.net.au>
References: <1569565266-31566-1-git-send-email-yanhaishuang@cmss.chinamobile.com>
 <1569565266-31566-2-git-send-email-yanhaishuang@cmss.chinamobile.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1569565266-31566-2-git-send-email-yanhaishuang@cmss.chinamobile.com>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Sep 27, 2019 at 02:21:04PM +0800, Haishuang Yan wrote:
> Test virutal server via directing routing for IPv4.
> 
> Tested:
> 
> # selftests: netfilter: ipvs.sh
> # Testing DR mode...
> # ipvs.sh: PASS
> ok 6 selftests: netfilter: ipvs.sh
> 
> Signed-off-by: Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
> ---
> v2: optimize test script
> ---
>  tools/testing/selftests/netfilter/Makefile |   2 +-
>  tools/testing/selftests/netfilter/ipvs.sh  | 184 +++++++++++++++++++++++++++++
>  2 files changed, 185 insertions(+), 1 deletion(-)
>  create mode 100755 tools/testing/selftests/netfilter/ipvs.sh
> 
> diff --git a/tools/testing/selftests/netfilter/Makefile b/tools/testing/selftests/netfilter/Makefile
> index 4144984..de1032b 100644
> --- a/tools/testing/selftests/netfilter/Makefile
> +++ b/tools/testing/selftests/netfilter/Makefile
> @@ -2,6 +2,6 @@
>  # Makefile for netfilter selftests
>  
>  TEST_PROGS := nft_trans_stress.sh nft_nat.sh bridge_brouter.sh \
> -	conntrack_icmp_related.sh nft_flowtable.sh
> +	conntrack_icmp_related.sh nft_flowtable.sh ipvs.sh
>  
>  include ../lib.mk
> diff --git a/tools/testing/selftests/netfilter/ipvs.sh b/tools/testing/selftests/netfilter/ipvs.sh
> new file mode 100755
> index 0000000..658c06b
> --- /dev/null
> +++ b/tools/testing/selftests/netfilter/ipvs.sh
> @@ -0,0 +1,184 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# End-to-end ipvs test suite
> +# Topology:
> +#--------------------------------------------------------------+
> +#                      |                                       |
> +#         ns0          |         ns1                           |
> +#      -----------     |     -----------    -----------        |
> +#      | veth01  | --------- | veth10  |    | veth12  |        |
> +#      -----------    peer   -----------    -----------        |
> +#           |          |                        |              |
> +#      -----------     |                        |              |
> +#      |  br0    |     |-----------------  peer |--------------|
> +#      -----------     |                        |              |
> +#           |          |                        |              |
> +#      ----------     peer   ----------      -----------       |
> +#      |  veth02 | --------- |  veth20 |     | veth21  |       |
> +#      ----------      |     ----------      -----------       |
> +#                      |         ns2                           |
> +#                      |                                       |
> +#--------------------------------------------------------------+
> +#
> +# We assume that all network driver are loaded
> +#
> +
> +# Kselftest framework requirement - SKIP code is 4.
> +ksft_skip=4
> +ret=0
> +GREEN='\033[0;92m'
> +RED='\033[0;31m'
> +NC='\033[0m' # No Color
> +
> +readonly port=8080
> +
> +readonly vip_v4=207.175.44.110
> +readonly cip_v4=10.0.0.2
> +readonly gip_v4=10.0.0.1
> +readonly dip_v4=172.16.0.1
> +readonly rip_v4=172.16.0.2
> +readonly sip_v4=10.0.0.3
> +
> +readonly infile="$(mktemp)"
> +readonly outfile="$(mktemp)"
> +
> +sysipvsnet=/proc/sys/net/ipv4/vs/
> +if [ ! -d /proc/sys/net/ipv4/vs/ ]; then
> +    modprobe -q ip_vs
> +    if [ $? -ne 0 ]; then
> +        echo "SKIP: Could not run test without ipvs module"
> +    	exit $ksft_skip
> +    fi
> +fi
> +
> +ip -Version > /dev/null 2>&1
> +if [ $? -ne 0 ]; then
> +	echo "SKIP: Could not run test without ip tool"
> +	exit $ksft_skip
> +fi
> +
> +ipvsadm -v > /dev/null 2>&1
> +if [ $? -ne 0 ]; then
> +	echo "SKIP: Could not run test without ipvsadm"
> +	exit $ksft_skip
> +fi
> +
> +nc --version > /dev/null 2>&1
> +if [ $? -ne 0 ]; then
> +	echo "SKIP: Could not run test without ncat"
> +	exit $ksft_skip
> +fi
> +
> +setup() {
> +    ip netns add ns0
> +    ip netns add ns1
> +    ip netns add ns2
> +
> +    ip link add veth01 netns ns0 type veth peer name veth10 netns ns1
> +    ip link add veth02 netns ns0 type veth peer name veth20 netns ns2
> +    ip link add veth12 netns ns1 type veth peer name veth21 netns ns2
> +
> +    ip netns exec ns0 ip link set veth01 up
> +    ip netns exec ns0 ip link set veth02 up
> +    ip netns exec ns0 ip link add br0 type bridge
> +    ip netns exec ns0 ip link set veth01 master br0
> +    ip netns exec ns0 ip link set veth02 master br0
> +    ip netns exec ns0 ip link set br0 up
> +    ip netns exec ns0 ip addr add ${cip_v4}/24 dev br0
> +
> +    ip netns exec ns1 ip link set lo up
> +    ip netns exec ns1 ip link set veth10 up
> +    ip netns exec ns1 ip addr add ${gip_v4}/24 dev veth10
> +    ip netns exec ns1 ip link set veth12 up
> +    ip netns exec ns1 ip addr add ${dip_v4}/24 dev veth12
> +
> +    ip netns exec ns2 ip link set lo up
> +    ip netns exec ns2 ip link set veth21 up
> +    ip netns exec ns2 ip addr add ${rip_v4}/24 dev veth21
> +    ip netns exec ns2 ip link set veth20 up
> +    ip netns exec ns2 ip addr add ${sip_v4}/24 dev veth20
> +}
> +
> +cleanup() {
> +    for i in 0 1 2
> +    do
> +	ip netns del ns$i > /dev/null 2>&1
> +    done
> +    pkill nc
> +}
> +
> +server_listen() {
> +	ip netns exec ns2 nc -l -p 8080 > "${outfile}" &
> +	server_pid=$!
> +	sleep 0.2
> +}
> +
> +client_connect() {
> +	ip netns exec ns0 timeout 2 nc -w 1 ${vip_v4} ${port} < "${infile}"
> +}
> +
> +verify_data() {
> +	wait "${server_pid}"
> +	# sha1sum returns two fields [sha1] [filepath]
> +	# convert to bash array and access first elem
> +	insum=($(sha1sum ${infile}))

When /bin/sh is dash the line above results in an error

./ipvs.sh: 125: ./ipvs.sh: Syntax error: "(" unexpected (expecting "}")

Could you work on making the script free of bashisms.
Or, if that proves to be an exceisive burden, use #!/bin/bash

Thanks!

> +	outsum=($(sha1sum ${outfile}))
> +	if [[ "${insum[0]}" != "${outsum[0]}" ]]; then
> +		echo "data mismatch"
> +		exit 1
> +	fi
> +}
> +
> +test_service() {
> +    server_listen
> +    client_connect
> +    ret=$?
> +    if [ $ret -ne 0 ]; then
> +	return $ret
> +    fi
> +    verify_data
> +}
> +
> +
> +test_dr() {
> +    ip netns exec ns0 ip route add ${vip_v4} via ${gip_v4} dev br0
> +
> +    ip netns exec ns1 sysctl -qw net.ipv4.ip_forward=1
> +    ip netns exec ns1 ipvsadm -A -t ${vip_v4}:${port} -s rr
> +    ip netns exec ns1 ipvsadm -a -t ${vip_v4}:${port} -r ${rip_v4}:${port}
> +    ip netns exec ns1 ip addr add ${vip_v4}/32 dev lo:1
> +
> +    # avoid incorrect arp response
> +    ip netns exec ns2 sysctl -qw net.ipv4.conf.all.arp_ignore=1
> +    ip netns exec ns2 sysctl -qw net.ipv4.conf.all.arp_announce=2
> +    # avoid reverse route lookup
> +    ip netns exec ns2 sysctl -qw  net.ipv4.conf.all.rp_filter=0
> +    ip netns exec ns2 sysctl -qw  net.ipv4.conf.veth21.rp_filter=0
> +    ip netns exec ns2 ip addr add ${vip_v4}/32 dev lo:1
> +
> +    test_service
> +}
> +
> +run_tests() {
> +	local errors=
> +
> +	echo "Testing DR mode..."
> +	setup
> +	test_dr
> +	errors=$(( $errors + $? ))
> +
> +	return $errors
> +}
> +
> +trap cleanup EXIT
> +
> +cleanup
> +run_tests
> +
> +if [ $? -ne 0 ]; then
> +	echo -e "$(basename $0): ${RED}FAIL${NC}"
> +	exit 1
> +fi
> +echo -e "$(basename $0): ${GREEN}PASS${NC}"
> +exit 0
> -- 
> 1.8.3.1
> 
> 
> 
