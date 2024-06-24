Return-Path: <linux-kselftest+bounces-12569-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 432F09154D4
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Jun 2024 18:54:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65E3B1C213F7
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Jun 2024 16:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FA8019EEAE;
	Mon, 24 Jun 2024 16:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sk6FP6tx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D01619DFAC
	for <linux-kselftest@vger.kernel.org>; Mon, 24 Jun 2024 16:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719248044; cv=none; b=Sqo2upg4a3c+dDAiX1LUsHSkxG9vu0EbBz/u0W8yXxlUw3/59TuLch0DZnTh3vVZgqiLsEUk07L4NM25UiKSzZQKaVTHXDysJ2chz9dPM+fW97CBTzo1gK1wat0h6XXrwilOn06yfGmXFpbMYkgMLPCMOuaWczFK7zUiGVtdpck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719248044; c=relaxed/simple;
	bh=5bohiIQjuFlZ3MC0ytH3G+PZ787pPsJS6tdm3PoEEOI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kcnmTjWYfNxVKWBCpCJ58hkbxrX2oNpL16UfuosL2jfMBsUVK7DQvsA1zbU3gR5mBwFClWyEIy+BN3J3NIx6bKdpJcFO/C4WzrNKojsbwVNzxJUmlDBuMSNMicW8YOUPYcpeLjeQUmFl1Ye/7USv0VzSbs0iSXe1OiNj18MFIiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Sk6FP6tx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719248042;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FnHUA8KFPQfgKOFjau5SADjiwWEi99JYmDlhSDmtX0c=;
	b=Sk6FP6txuTNB/usSrRSuH5savxbeFbOB10ieX+2Z2SBSOQMs+6JncwyCrGeR57coIUdsG8
	rnrF3gNQUUJi41+yfRTNVdZA6thS+2KebSjUnKWPuFoXJzilcjN31VmZJfP+TN6Zikegrx
	rlVWtm3pmZhgM28UVD5OkqZ0atVW/fE=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-638-fE7PfUYeN4qMpNTNcuGP-g-1; Mon,
 24 Jun 2024 12:53:58 -0400
X-MC-Unique: fE7PfUYeN4qMpNTNcuGP-g-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7F49019560A7;
	Mon, 24 Jun 2024 16:53:52 +0000 (UTC)
Received: from RHTRH0061144 (unknown [10.22.9.58])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 74E201955D83;
	Mon, 24 Jun 2024 16:53:48 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org,  dev@openvswitch.org,
  linux-kselftest@vger.kernel.org,  linux-kernel@vger.kernel.org,  Pravin B
 Shelar <pshelar@ovn.org>,  "David S. Miller" <davem@davemloft.net>,  Eric
 Dumazet <edumazet@google.com>,  Paolo Abeni <pabeni@redhat.com>,  Shuah
 Khan <shuah@kernel.org>,  Stefano Brivio <sbrivio@redhat.com>,
  =?utf-8?Q?Adri=C3=A1n?=
 Moreno <amorenoz@redhat.com>,  Simon Horman <horms@kernel.org>
Subject: Re: [PATCH v2 net-next 0/7] selftests: net: Switch pmtu.sh to use
 the internal ovs script.
In-Reply-To: <f7ttthjh33w.fsf@redhat.com> (Aaron Conole's message of "Sun, 23
	Jun 2024 15:26:59 -0400")
References: <20240620125601.15755-1-aconole@redhat.com>
	<20240621180126.3c40d245@kernel.org> <f7ttthjh33w.fsf@redhat.com>
Date: Mon, 24 Jun 2024 12:53:45 -0400
Message-ID: <f7tpls6gu3q.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Aaron Conole <aconole@redhat.com> writes:

> Jakub Kicinski <kuba@kernel.org> writes:
>
>> On Thu, 20 Jun 2024 08:55:54 -0400 Aaron Conole wrote:
>>> This series enhances the ovs-dpctl utility to provide support for set()
>>> and tunnel() flow specifiers, better ipv6 handling support, and the
>>> ability to add tunnel vports, and LWT interfaces.  Finally, it modifies
>>> the pmtu.sh script to call the ovs-dpctl.py utility rather than the
>>> typical OVS userspace utilities.
>>
>> Thanks for the work! 
>>
>> Looks like the series no longer applies because of other changes
>> to the kernel config. Before it stopped applying we got some runs,
>> here's what I see:
>>
>> https://netdev-3.bots.linux.dev/vmksft-net/results/648440/3-pmtu-sh/stdout
>>
>> # Cannot find device "ovs_br0"
>> # TEST: IPv4, OVS vxlan4: PMTU exceptions                             [FAIL]
>> # Cannot find device "ovs_br0"
>> # TEST: IPv4, OVS vxlan4: PMTU exceptions - nexthop objects           [FAIL]
>> # Cannot find device "ovs_br0"
>> # TEST: IPv6, OVS vxlan4: PMTU exceptions                             [FAIL]
>> # Cannot find device "ovs_br0"
>> # TEST: IPv6, OVS vxlan4: PMTU exceptions - nexthop objects           [FAIL]
>> # Cannot find device "ovs_br0"
>> # TEST: IPv4, OVS vxlan6: PMTU exceptions                             [FAIL]
>> # Cannot find device "ovs_br0"
>> # TEST: IPv4, OVS vxlan6: PMTU exceptions - nexthop objects           [FAIL]
>> # Cannot find device "ovs_br0"
>> # TEST: IPv6, OVS vxlan6: PMTU exceptions                             [FAIL]
>> # Cannot find device "ovs_br0"
>> # TEST: IPv6, OVS vxlan6: PMTU exceptions - nexthop objects           [FAIL]
>> # Cannot find device "ovs_br0"
>> # TEST: IPv4, OVS geneve4: PMTU exceptions                            [FAIL]
>> # Cannot find device "ovs_br0"
>> # TEST: IPv4, OVS geneve4: PMTU exceptions - nexthop objects          [FAIL]
>> # Cannot find device "ovs_br0"
>> # TEST: IPv6, OVS geneve4: PMTU exceptions                            [FAIL]
>> # Cannot find device "ovs_br0"
>> # TEST: IPv6, OVS geneve4: PMTU exceptions - nexthop objects          [FAIL]
>> # Cannot find device "ovs_br0"
>> # TEST: IPv4, OVS geneve6: PMTU exceptions                            [FAIL]
>> # Cannot find device "ovs_br0"
>> # TEST: IPv4, OVS geneve6: PMTU exceptions - nexthop objects          [FAIL]
>> # Cannot find device "ovs_br0"
>> # TEST: IPv6, OVS geneve6: PMTU exceptions                            [FAIL]
>> # Cannot find device "ovs_br0"
>>
>> Any idea why? Looks like kernel config did include OVS, perhaps we need
>> explicit modprobe now? I don't see any more details in the logs.
>
> Strange.  I expected that the module should have automatically been
> loaded when attempting to communicate with the OVS genetlink family
> type.  At least, that is how it had been working previously.
>
> I'll spend some time looking into it and resubmit a rebased version.
> Thanks, Jakub!

If the ovs module isn't available, then I see:

#   ovs_bridge not supported
# TEST: IPv4, OVS vxlan4: PMTU exceptions                             [SKIP]

But if it is available, I haven't been able to reproduce such ovs_br0
setup failure - things work.

My branch is rebased on 568ebdaba6370c03360860f1524f646ddd5ca523

Additionally, the "Cannot find device ..." text comes from an iproute2
utility output.  The only place we actually interact with that is via
the call at pmtu.sh:973:

	run_cmd ip link set ovs_br0 up

Maybe it is possible that the link isn't up (could some port memory
allocation or message be delaying it?) yet in the virtual environment.
To confirm, is it possible to run in the constrained environment, but
put a 5s sleep or something?  I will add the following either as a
separate patch (ie 7/8), or I can fold it into 6/7 (and drop Stefano's
ACK waiting for another review):


wait_for_if() {
   if ip link show "$2" >/dev/null 2>&1; then return 0; fi

   for d in `seq 1 30`; do
      sleep 1
      if ip link show "$2" >/dev/null 2>&1; then return 0; fi
   done
   return 1
}

....
 	setup_ovs_br_internal || setup_ovs_br_vswitchd || return $ksft_skip
+	wait_for_if "ovs_br0"
 	run_cmd ip link set ovs_br0 up
....

Does it make sense or does it seem like I am way off base?


