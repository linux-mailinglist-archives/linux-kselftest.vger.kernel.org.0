Return-Path: <linux-kselftest+bounces-41054-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F16DB50071
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Sep 2025 16:59:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F47F1C6292C
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Sep 2025 14:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F14234F476;
	Tue,  9 Sep 2025 14:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jHzhVbGT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C61350D7B
	for <linux-kselftest@vger.kernel.org>; Tue,  9 Sep 2025 14:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757429949; cv=none; b=XMAbjPrE/cLcGUst3Sl2f1qieGYtK2gvKmf3w0RwiT2U2dWjjLjXWIdMgBHge52j26itS0na7w+bV9TTuVija25lP0yq3DQ4EBMM4ZFKQno9FxZuw74TjaVSMcZROfTavjpI4Vttw+P9QfLZuNPEJ2xzasYvLdlOoXbN5j+ay/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757429949; c=relaxed/simple;
	bh=kmgv9xqGS7OTGFpOzGWNFBB80NfoLzlhJ5EdO2cDkXI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UvB1NVvQsFnCT6Rtjr2DGW7BE3kGe176qhEekRGGJuUpt8mCUbhgmf+7k3pBogXb8f6+aCOq7fV4Zn0eHQYNpOePxb9G+0TVV5eGP3GPib2riP4uHT7nu75YmnOg+APQ6BAhYYg/KflPBq8Q5s/UTDEtrflsmt2utJPEKFtQvUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jHzhVbGT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757429945;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4dV2yfJTsR1DPUk73L2OuUXIAcYJU7bx4iuUy8FDIgM=;
	b=jHzhVbGTWwqW6cG2/cV3hhZkmc9SzAjfdo/y4ZUvJFL5jQL7eePD2trFhq/zQC25HX29G7
	WF5GVBvjgDX43AsUKc1dsPSj5uHwyRFJUrLQH9aBgyXDSxz5jaOyZqVkG7ePDSj3Oei1qp
	AdwdU7qbION9j0JZB3p6XEeS2NuD9/o=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-65-0eYToXeKMvGR-lT7DB6z6Q-1; Tue,
 09 Sep 2025 10:59:04 -0400
X-MC-Unique: 0eYToXeKMvGR-lT7DB6z6Q-1
X-Mimecast-MFC-AGG-ID: 0eYToXeKMvGR-lT7DB6z6Q_1757429942
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2815B18005A2;
	Tue,  9 Sep 2025 14:59:02 +0000 (UTC)
Received: from RHTRH0061144 (unknown [10.22.88.137])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6CE1D1956095;
	Tue,  9 Sep 2025 14:58:58 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: Ilya Maximets <i.maximets@ovn.org>
Cc: netdev@vger.kernel.org,  "David S. Miller" <davem@davemloft.net>,  Eric
 Dumazet <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>,  Paolo
 Abeni <pabeni@redhat.com>,  Simon Horman <horms@kernel.org>,
  linux-kernel@vger.kernel.org,  linux-kselftest@vger.kernel.org,
  dev@openvswitch.org,  Eelco Chaudron <echaudro@redhat.com>,  Shuah Khan
 <shuah@kernel.org>,  Jamal Hadi Salim <jhs@mojatatu.com>,  Davide Caratti
 <dcaratti@redhat.com>
Subject: Re: [PATCH net 2/2] selftests: openvswitch: add a simple test for
 tunnel metadata
In-Reply-To: <20250905133105.3940420-3-i.maximets@ovn.org> (Ilya Maximets's
	message of "Fri, 5 Sep 2025 15:30:56 +0200")
References: <20250905133105.3940420-1-i.maximets@ovn.org>
	<20250905133105.3940420-3-i.maximets@ovn.org>
Date: Tue, 09 Sep 2025 10:58:56 -0400
Message-ID: <f7tqzwfhdu7.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Ilya Maximets <i.maximets@ovn.org> writes:

> This test ensures that upon receiving decapsulated packets from a
> tunnel interface in openvswitch, the tunnel metadata fields are
> properly populated.  This partially covers interoperability of the
> kernel tunnel ports and openvswitch tunnels (LWT) and parsing and
> formatting of the tunnel metadata fields of the openvswitch netlink
> uAPI.  Doing so, this test also ensures that fields and flags are
> properly extracted during decapsulation by the tunnel core code,
> serving as a regression test for the previously fixed issue with the
> DF bit not being extracted from the outer IP header.
>
> The ovs-dpctl.py script already supports all that is necessary for
> the tunnel ports for this test, so we only need to adjust the
> ovs_add_if() function to pass the '-t' port type argument in order
> to be able to create tunnel ports in the openvswitch datapath.
>
> Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
> ---

Thanks for the test case - it looks good to me.  One thing I think would
be a useful future enhancement for us is to add json output so that we
can use something like 'jq' to parse the upcall output.  At the moment,
the grep will work, but doesn't let us change anything.  But that is
work for a future patch.

Reviewed-by: Aaron Conole <aconole@redhat.com>

>  .../selftests/net/openvswitch/openvswitch.sh  | 88 +++++++++++++++++--
>  1 file changed, 81 insertions(+), 7 deletions(-)
>
> diff --git a/tools/testing/selftests/net/openvswitch/openvswitch.sh b/tools/testing/selftests/net/openvswitch/openvswitch.sh
> index 3c8d3455d8e7..b327d3061ed5 100755
> --- a/tools/testing/selftests/net/openvswitch/openvswitch.sh
> +++ b/tools/testing/selftests/net/openvswitch/openvswitch.sh
> @@ -25,6 +25,7 @@ tests="
>  	nat_related_v4				ip4-nat-related: ICMP related matches work with SNAT
>  	netlink_checks				ovsnl: validate netlink attrs and settings
>  	upcall_interfaces			ovs: test the upcall interfaces
> +	tunnel_metadata				ovs: test extraction of tunnel metadata
>  	drop_reason				drop: test drop reasons are emitted
>  	psample					psample: Sampling packets with psample"
>  
> @@ -113,13 +114,13 @@ ovs_add_dp () {
>  }
>  
>  ovs_add_if () {
> -	info "Adding IF to DP: br:$2 if:$3"
> -	if [ "$4" != "-u" ]; then
> -		ovs_sbx "$1" python3 $ovs_base/ovs-dpctl.py add-if "$2" "$3" \
> -		    || return 1
> +	info "Adding IF to DP: br:$3 if:$4 ($2)"
> +	if [ "$5" != "-u" ]; then
> +		ovs_sbx "$1" python3 $ovs_base/ovs-dpctl.py add-if \
> +		    -t "$2" "$3" "$4" || return 1
>  	else
>  		python3 $ovs_base/ovs-dpctl.py add-if \
> -		    -u "$2" "$3" >$ovs_dir/$3.out 2>$ovs_dir/$3.err &
> +		    -u -t "$2" "$3" "$4" >$ovs_dir/$4.out 2>$ovs_dir/$4.err &
>  		pid=$!
>  		on_exit "ovs_sbx $1 kill -TERM $pid 2>/dev/null"
>  	fi
> @@ -166,9 +167,9 @@ ovs_add_netns_and_veths () {
>  	fi
>  
>  	if [ "$7" != "-u" ]; then
> -		ovs_add_if "$1" "$2" "$4" || return 1
> +		ovs_add_if "$1" "netdev" "$2" "$4" || return 1
>  	else
> -		ovs_add_if "$1" "$2" "$4" -u || return 1
> +		ovs_add_if "$1" "netdev" "$2" "$4" -u || return 1
>  	fi
>  
>  	if [ $TRACING -eq 1 ]; then
> @@ -756,6 +757,79 @@ test_upcall_interfaces() {
>  	return 0
>  }
>  
> +ovs_add_kernel_tunnel() {
> +	local sbxname=$1; shift
> +	local ns=$1; shift
> +	local tnl_type=$1; shift
> +	local name=$1; shift
> +	local addr=$1; shift
> +
> +	info "setting up kernel ${tnl_type} tunnel ${name}"
> +	ovs_sbx "${sbxname}" ip -netns ${ns} link add dev ${name} type ${tnl_type} $* || return 1
> +	on_exit "ovs_sbx ${sbxname} ip -netns ${ns} link del ${name} >/dev/null 2>&1"
> +	ovs_sbx "${sbxname}" ip -netns ${ns} addr add dev ${name} ${addr} || return 1
> +	ovs_sbx "${sbxname}" ip -netns ${ns} link set dev ${name} mtu 1450 up || return 1
> +}
> +
> +test_tunnel_metadata() {
> +	which arping >/dev/null 2>&1 || return $ksft_skip
> +
> +	sbxname="test_tunnel_metadata"
> +	sbx_add "${sbxname}" || return 1
> +
> +	info "setting up new DP"
> +	ovs_add_dp "${sbxname}" tdp0 -V 2:1 || return 1
> +
> +	ovs_add_netns_and_veths "${sbxname}" tdp0 tns left0 l0 \
> +		172.31.110.1/24 || return 1
> +
> +	info "removing veth interface from openvswitch and setting IP"
> +	ovs_del_if "${sbxname}" tdp0 left0 || return 1
> +	ovs_sbx "${sbxname}" ip addr add 172.31.110.2/24 dev left0 || return 1
> +	ovs_sbx "${sbxname}" ip link set left0 up || return 1
> +
> +	info "setting up tunnel port in openvswitch"
> +	ovs_add_if "${sbxname}" "vxlan" tdp0 ovs-vxlan0 -u || return 1
> +	on_exit "ovs_sbx ${sbxname} ip link del ovs-vxlan0"
> +	ovs_wait ip link show ovs-vxlan0 &>/dev/null || return 1
> +	ovs_sbx "${sbxname}" ip link set ovs-vxlan0 up || return 1
> +
> +	configs=$(echo '
> +	    1 172.31.221.1/24 1155332 32   set   udpcsum flags\(df\|csum\)
> +	    2 172.31.222.1/24 1234567 45   set noudpcsum flags\(df\)
> +	    3 172.31.223.1/24 1020304 23 unset   udpcsum flags\(csum\)
> +	    4 172.31.224.1/24 1357986 15 unset noudpcsum' | sed '/^$/d')
> +
> +	while read -r i addr id ttl df csum flags; do
> +		ovs_add_kernel_tunnel "${sbxname}" tns vxlan vxlan${i} ${addr} \
> +			remote 172.31.110.2 id ${id} dstport 4789 \
> +			ttl ${ttl} df ${df} ${csum} || return 1
> +	done <<< "${configs}"
> +
> +	ovs_wait grep -q 'listening on upcall packet handler' \
> +		${ovs_dir}/ovs-vxlan0.out || return 1
> +
> +	info "sending arping"
> +	for i in 1 2 3 4; do
> +		ovs_sbx "${sbxname}" ip netns exec tns \
> +			arping -I vxlan${i} 172.31.22${i}.2 -c 1 \
> +			>${ovs_dir}/arping.stdout 2>${ovs_dir}/arping.stderr
> +	done
> +
> +	info "checking that received decapsulated packets carry correct metadata"
> +	while read -r i addr id ttl df csum flags; do
> +		arp_hdr="arp\\(sip=172.31.22${i}.1,tip=172.31.22${i}.2,op=1,sha="
> +		addrs="src=172.31.110.1,dst=172.31.110.2"
> +		ports="tp_src=[0-9]*,tp_dst=4789"
> +		tnl_md="tunnel\\(tun_id=${id},${addrs},ttl=${ttl},${ports},${flags}\\)"
> +
> +		ovs_sbx "${sbxname}" grep -qE "MISS upcall.*${tnl_md}.*${arp_hdr}" \
> +			${ovs_dir}/ovs-vxlan0.out || return 1
> +	done <<< "${configs}"
> +
> +	return 0
> +}
> +
>  run_test() {
>  	(
>  	tname="$1"


