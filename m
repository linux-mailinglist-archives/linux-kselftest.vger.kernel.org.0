Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5FEFABFA3D
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Sep 2019 21:43:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728487AbfIZTnY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 26 Sep 2019 15:43:24 -0400
Received: from ja.ssi.bg ([178.16.129.10]:36142 "EHLO ja.ssi.bg"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728454AbfIZTnY (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 26 Sep 2019 15:43:24 -0400
X-Greylist: delayed 498 seconds by postgrey-1.27 at vger.kernel.org; Thu, 26 Sep 2019 15:43:22 EDT
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
        by ja.ssi.bg (8.15.2/8.15.2) with ESMTP id x8QJYj1f004715;
        Thu, 26 Sep 2019 22:34:46 +0300
Date:   Thu, 26 Sep 2019 22:34:45 +0300 (EEST)
From:   Julian Anastasov <ja@ssi.bg>
To:     Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
cc:     Shuah Khan <shuah@kernel.org>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org, lvs-devel@vger.kernel.org
Subject: Re: [PATCH 3/3] selftests: netfilter: add ipvs tunnel test case
In-Reply-To: <1569516532-708-4-git-send-email-yanhaishuang@cmss.chinamobile.com>
Message-ID: <alpine.LFD.2.21.1909262154000.3599@ja.home.ssi.bg>
References: <1569516532-708-1-git-send-email-yanhaishuang@cmss.chinamobile.com> <1569516532-708-4-git-send-email-yanhaishuang@cmss.chinamobile.com>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


	Hello,

On Fri, 27 Sep 2019, Haishuang Yan wrote:

> Test virtual server via ipip tunnel.
> 
> Tested:
> # selftests: netfilter: ipvs.sh
> # Testing DR mode...
> # Testing NAT mode...
> # Testing Tunnel mode...
> # ipvs.sh: PASS
> ok 6 selftests: netfilter: ipvs.sh
> 
> Signed-off-by: Haishuang Yan <yanhaishuang@cmss.chinamobile.com>

	It is good to have IPVS selftests... This is a good start,
later we can add IPv6...

> ---
>  tools/testing/selftests/netfilter/ipvs.sh | 33 +++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
> 
> diff --git a/tools/testing/selftests/netfilter/ipvs.sh b/tools/testing/selftests/netfilter/ipvs.sh
> index 40058f9..2012cec 100755
> --- a/tools/testing/selftests/netfilter/ipvs.sh
> +++ b/tools/testing/selftests/netfilter/ipvs.sh
> @@ -167,6 +167,33 @@ test_nat() {
>      test_service
>  }
>  
> +test_tun() {
> +    ip netns exec ns0 ip route add ${vip_v4} via ${gip_v4} dev br0
> +
> +    ip netns exec ns1 modprobe ipip
> +    ip netns exec ns1 ip link set tunl0 up
> +    ip netns exec ns1 sysctl -qw net.ipv4.ip_forward=0
> +    ip netns exec ns1 sysctl -qw net.ipv4.conf.all.send_redirects=0
> +    ip netns exec ns1 sysctl -qw net.ipv4.conf.default.send_redirects=0
> +    ip netns exec ns1 ipvsadm -A -t ${vip_v4}:${port} -s rr
> +    ip netns exec ns1 ipvsadm -a -i -t ${vip_v4}:${port} -r ${rip_v4}:${port}
> +    ip netns exec ns1 ip addr add ${vip_v4}/32 dev lo:1
> +
> +    ip netns exec ns2 modprobe ipip
> +    ip netns exec ns2 ip link set tunl0 up
> +    ip netns exec ns2 sysctl -qw net.ipv4.conf.all.arp_ignore=1
> +    ip netns exec ns2 sysctl -qw net.ipv4.conf.all.arp_announce=2
> +    ip netns exec ns2 sysctl -qw net.ipv4.conf.all.rp_filter=0
> +    ip netns exec ns2 sysctl -qw net.ipv4.conf.lo.arp_ignore=1
> +    ip netns exec ns2 sysctl -qw net.ipv4.conf.lo.arp_announce=2

	arp_ignore and arp_announce are not used on "lo". And MAX
is used, i.e.

# for all interfaces use (suitable for our test setup):
all.arp_ignore=1
all.arp_announce=2

# or if above is not desired, for specific LAN interface use
veth21.arp_ignore=1
veth21.arp_announce=2

	BTW, the picture has ns2/veth12 while it should be veth21.
Also, should we check if IPVS module is loaded? Eg. depending
on present /proc/sys/net/ipv4/vs/ dir ?

> +    ip netns exec ns2 sysctl -qw net.ipv4.conf.lo.rp_filter=0

	IIRC, lo.rp_filter is never used, packets from "lo" always come
with attached output route, so source validation is not performed.

> +    ip netns exec ns2 sysctl -qw net.ipv4.conf.tunl0.rp_filter=0
> +    ip netns exec ns2 sysctl -qw net.ipv4.conf.veth21.rp_filter=0
> +    ip netns exec ns2 ip addr add ${vip_v4}/32 dev lo:1
> +
> +    test_service
> +}
> +
>  run_tests() {
>  	local errors=
>  
> @@ -182,6 +209,12 @@ run_tests() {
>  	test_nat
>  	errors=$(( $errors + $? ))
>  
> +	echo "Testing Tunnel mode..."
> +	cleanup
> +	setup
> +	test_tun
> +	errors=$(( $errors + $? ))
> +
>  	return $errors
>  }
>  
> -- 
> 1.8.3.1

Regards

--
Julian Anastasov <ja@ssi.bg>
