Return-Path: <linux-kselftest+bounces-28261-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C096BA4F2F0
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Mar 2025 01:48:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D720A3A8852
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Mar 2025 00:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AEA41EB36;
	Wed,  5 Mar 2025 00:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="REs0Iu2+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CDC7CA4E
	for <linux-kselftest@vger.kernel.org>; Wed,  5 Mar 2025 00:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741135706; cv=none; b=jA25b48d9+8ukSa270xCQdiZ4jYeKCX5lVUkDMfFlAtCrgvJkT0ncAgEVLpPb4ZFZdgeK0pGt3Y7UKoeroFYE9luLN5Zv7HqTrRtg7spUl/l4DNqNS5y3+ef8UHeWLpJsXdiSexjnlKvtR2GHkraNCCpQwhwnD1gsm9v47x1bTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741135706; c=relaxed/simple;
	bh=c3Yy3nw4QdMzjfWCvdWZuNUP/Ly1yxVElNCRZ8rDRfk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ebm/n90BvN98J82MNWRrBwrXu2DUB7oLGmZ78FAMcVVAAqlFQ/crlwwfpkGna1I4aj60fRuSrdwz3jnaQXXlr1+DzE4QJ7XI3B7iAlGECo5vTSRhp9BIMwdczjHsoL1fAfcl6gXu9bX6FffGJtdj3XoG3lj1KjOMK7r9X96HcQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=REs0Iu2+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741135702;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BGOBETMF1iYIsV9XCnrXXWNT5F0G1uXF7Z4J+GjajJs=;
	b=REs0Iu2+4JJeCJKE7dSC1c6w1rmYHumsporrR7r0+/iAm5mp/zL7jCUB1bUmr4eOAmP7m5
	uFghbYlm8Li1LmWqS93b8Z6vX7bdIEA2D3yIqg+71E+QFhyumyXp7E6tGL5aD7lPQYNU0N
	rC8pbv1cZZhebfcFzSWAInshbhKLcRg=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-290-x0OOr80VOrm1F5oNq6l8GA-1; Tue,
 04 Mar 2025 19:48:19 -0500
X-MC-Unique: x0OOr80VOrm1F5oNq6l8GA-1
X-Mimecast-MFC-AGG-ID: x0OOr80VOrm1F5oNq6l8GA_1741135698
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CFB93193578F;
	Wed,  5 Mar 2025 00:48:17 +0000 (UTC)
Received: from RHTRH0061144 (unknown [10.22.81.152])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DF9AC19560AA;
	Wed,  5 Mar 2025 00:48:14 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: Jakub Kicinski via dev <ovs-dev@openvswitch.org>
Cc: davem@davemloft.net,  Jakub Kicinski <kuba@kernel.org>,
  dev@openvswitch.org,  linux-kselftest@vger.kernel.org,
  netdev@vger.kernel.org,  andrew+netdev@lunn.ch,  edumazet@google.com,
  horms@kernel.org,  pabeni@redhat.com,  shuah@kernel.org
Subject: Re: [ovs-dev] [PATCH net-next] selftests: openvswitch: don't
 hardcode the drop reason subsys
In-Reply-To: <20250304180615.945945-1-kuba@kernel.org> (Jakub Kicinski via
	dev's message of "Tue, 4 Mar 2025 10:06:15 -0800")
References: <20250304180615.945945-1-kuba@kernel.org>
Date: Tue, 04 Mar 2025 19:48:12 -0500
Message-ID: <f7tikoo716b.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Jakub Kicinski via dev <ovs-dev@openvswitch.org> writes:

> WiFi removed one of their subsys entries from drop reasons, in
> commit 286e69677065 ("wifi: mac80211: Drop cooked monitor support")
> SKB_DROP_REASON_SUBSYS_OPENVSWITCH is now 2 not 3.
> The drop reasons are not uAPI, read the correct value
> from debug info.
>
> We need to enable vmlinux BTF, otherwise pahole needs
> a few GB of memory to decode the enum name.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: shuah@kernel.org
> CC: pshelar@ovn.org
> CC: aconole@redhat.com
> CC: amorenoz@redhat.com
> CC: linux-kselftest@vger.kernel.org
> CC: dev@openvswitch.org
> ---

Acked-by: Aaron Conole <aconole@redhat.com>

Thanks for the fix!

>  tools/testing/selftests/net/config                    |  2 ++
>  .../testing/selftests/net/openvswitch/openvswitch.sh  | 11 ++++++++---
>  2 files changed, 10 insertions(+), 3 deletions(-)
>
> diff --git a/tools/testing/selftests/net/config b/tools/testing/selftests/net/config
> index 5b9baf708950..3365bcc35304 100644
> --- a/tools/testing/selftests/net/config
> +++ b/tools/testing/selftests/net/config
> @@ -18,6 +18,8 @@ CONFIG_DUMMY=y
>  CONFIG_BRIDGE_VLAN_FILTERING=y
>  CONFIG_BRIDGE=y
>  CONFIG_CRYPTO_CHACHA20POLY1305=m
> +CONFIG_DEBUG_INFO_BTF=y
> +CONFIG_DEBUG_INFO_BTF_MODULES=n
>  CONFIG_VLAN_8021Q=y
>  CONFIG_GENEVE=m
>  CONFIG_IFB=y
> diff --git a/tools/testing/selftests/net/openvswitch/openvswitch.sh b/tools/testing/selftests/net/openvswitch/openvswitch.sh
> index 960e1ab4dd04..3c8d3455d8e7 100755
> --- a/tools/testing/selftests/net/openvswitch/openvswitch.sh
> +++ b/tools/testing/selftests/net/openvswitch/openvswitch.sh
> @@ -330,6 +330,11 @@ test_psample() {
>  # - drop packets and verify the right drop reason is reported
>  test_drop_reason() {
>  	which perf >/dev/null 2>&1 || return $ksft_skip
> +	which pahole >/dev/null 2>&1 || return $ksft_skip
> +
> +	ovs_drop_subsys=$(pahole -C skb_drop_reason_subsys |
> +			      awk '/OPENVSWITCH/ { print $3; }' |
> +			      tr -d ,)
>  
>  	sbx_add "test_drop_reason" || return $?
>  
> @@ -373,7 +378,7 @@ test_drop_reason() {
>  		"in_port(2),eth(),eth_type(0x0800),ipv4(src=172.31.110.20,proto=1),icmp()" 'drop'
>  
>  	ovs_drop_record_and_run "test_drop_reason" ip netns exec client ping -c 2 172.31.110.20
> -	ovs_drop_reason_count 0x30001 # OVS_DROP_FLOW_ACTION
> +	ovs_drop_reason_count 0x${ovs_drop_subsys}0001 # OVS_DROP_FLOW_ACTION
>  	if [[ "$?" -ne "2" ]]; then
>  		info "Did not detect expected drops: $?"
>  		return 1
> @@ -390,7 +395,7 @@ test_drop_reason() {
>  
>  	ovs_drop_record_and_run \
>              "test_drop_reason" ip netns exec client nc -i 1 -zuv 172.31.110.20 6000
> -	ovs_drop_reason_count 0x30004 # OVS_DROP_EXPLICIT_ACTION_ERROR
> +	ovs_drop_reason_count 0x${ovs_drop_subsys}0004 # OVS_DROP_EXPLICIT_ACTION_ERROR
>  	if [[ "$?" -ne "1" ]]; then
>  		info "Did not detect expected explicit error drops: $?"
>  		return 1
> @@ -398,7 +403,7 @@ test_drop_reason() {
>  
>  	ovs_drop_record_and_run \
>              "test_drop_reason" ip netns exec client nc -i 1 -zuv 172.31.110.20 7000
> -	ovs_drop_reason_count 0x30003 # OVS_DROP_EXPLICIT_ACTION
> +	ovs_drop_reason_count 0x${ovs_drop_subsys}0003 # OVS_DROP_EXPLICIT_ACTION
>  	if [[ "$?" -ne "1" ]]; then
>  		info "Did not detect expected explicit drops: $?"
>  		return 1


