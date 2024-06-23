Return-Path: <linux-kselftest+bounces-12524-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90634913DB3
	for <lists+linux-kselftest@lfdr.de>; Sun, 23 Jun 2024 21:27:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC7571C21339
	for <lists+linux-kselftest@lfdr.de>; Sun, 23 Jun 2024 19:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B56118410F;
	Sun, 23 Jun 2024 19:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JxSBq6vE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F9C146008
	for <linux-kselftest@vger.kernel.org>; Sun, 23 Jun 2024 19:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719170836; cv=none; b=Dvp42mKUn7r2JHIL4xmJQJNt+w7Hi6NQ4x5Gek0vQAm8dmrBHMK2Fx1REhWB6H6iVboXsV8a+Q2/2gdqesWxaYLcGrG4BSlUsQW1hvYT4pNZlIs+UEmh9r4BczDFFq9IKM6nf2VBRzo51PM+zdrW+sFGyegQoy5B6Hm3Wjj0LS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719170836; c=relaxed/simple;
	bh=ERYHZ97S+lmOX7oNyXwq0MNbVQnJ7iDkrBT/LticVHo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PAD2tEjqMDJyfzn1BRlTPaon/HVmWP7+4mG7Tc8XuILzHjlVhTc5HxKRhRgmrm7rnr1bHyCqs6GtHTpzvNudMbUiaTZbiR89yHXXnPLiuonSB9qmVPIkdIcaN2Pczr/iItzXNwC1bcumDrU5+IHYuyh8uKcYH4NzSmp51AAhF64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JxSBq6vE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719170833;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7xKAWxytZSpfy+XyE1OWrhlcpej+DupFvRDHHykccng=;
	b=JxSBq6vEbV9w8i++1cWe9lhsjW9StnNPr6uqFLU93+7fnPNgabY3yFKV0qjn8/XHpgGYi9
	/kd/wJRJ9CvIP29lMMCCuifkZ/FbovSmWXKZBQUe5RVI4VL5OL2LFj/7ovn+SRbeyaijmN
	zjZbfQ6jN+IieuzwBO2RNjWE9C0BFpc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-31-cry_T-VbM62-nJpTY-n75Q-1; Sun,
 23 Jun 2024 15:27:08 -0400
X-MC-Unique: cry_T-VbM62-nJpTY-n75Q-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3AADC195608C;
	Sun, 23 Jun 2024 19:27:06 +0000 (UTC)
Received: from RHTRH0061144 (unknown [10.22.9.58])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1259419560AA;
	Sun, 23 Jun 2024 19:27:01 +0000 (UTC)
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
In-Reply-To: <20240621180126.3c40d245@kernel.org> (Jakub Kicinski's message of
	"Fri, 21 Jun 2024 18:01:26 -0700")
References: <20240620125601.15755-1-aconole@redhat.com>
	<20240621180126.3c40d245@kernel.org>
Date: Sun, 23 Jun 2024 15:26:59 -0400
Message-ID: <f7ttthjh33w.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Jakub Kicinski <kuba@kernel.org> writes:

> On Thu, 20 Jun 2024 08:55:54 -0400 Aaron Conole wrote:
>> This series enhances the ovs-dpctl utility to provide support for set()
>> and tunnel() flow specifiers, better ipv6 handling support, and the
>> ability to add tunnel vports, and LWT interfaces.  Finally, it modifies
>> the pmtu.sh script to call the ovs-dpctl.py utility rather than the
>> typical OVS userspace utilities.
>
> Thanks for the work! 
>
> Looks like the series no longer applies because of other changes
> to the kernel config. Before it stopped applying we got some runs,
> here's what I see:
>
> https://netdev-3.bots.linux.dev/vmksft-net/results/648440/3-pmtu-sh/stdout
>
> # Cannot find device "ovs_br0"
> # TEST: IPv4, OVS vxlan4: PMTU exceptions                             [FAIL]
> # Cannot find device "ovs_br0"
> # TEST: IPv4, OVS vxlan4: PMTU exceptions - nexthop objects           [FAIL]
> # Cannot find device "ovs_br0"
> # TEST: IPv6, OVS vxlan4: PMTU exceptions                             [FAIL]
> # Cannot find device "ovs_br0"
> # TEST: IPv6, OVS vxlan4: PMTU exceptions - nexthop objects           [FAIL]
> # Cannot find device "ovs_br0"
> # TEST: IPv4, OVS vxlan6: PMTU exceptions                             [FAIL]
> # Cannot find device "ovs_br0"
> # TEST: IPv4, OVS vxlan6: PMTU exceptions - nexthop objects           [FAIL]
> # Cannot find device "ovs_br0"
> # TEST: IPv6, OVS vxlan6: PMTU exceptions                             [FAIL]
> # Cannot find device "ovs_br0"
> # TEST: IPv6, OVS vxlan6: PMTU exceptions - nexthop objects           [FAIL]
> # Cannot find device "ovs_br0"
> # TEST: IPv4, OVS geneve4: PMTU exceptions                            [FAIL]
> # Cannot find device "ovs_br0"
> # TEST: IPv4, OVS geneve4: PMTU exceptions - nexthop objects          [FAIL]
> # Cannot find device "ovs_br0"
> # TEST: IPv6, OVS geneve4: PMTU exceptions                            [FAIL]
> # Cannot find device "ovs_br0"
> # TEST: IPv6, OVS geneve4: PMTU exceptions - nexthop objects          [FAIL]
> # Cannot find device "ovs_br0"
> # TEST: IPv4, OVS geneve6: PMTU exceptions                            [FAIL]
> # Cannot find device "ovs_br0"
> # TEST: IPv4, OVS geneve6: PMTU exceptions - nexthop objects          [FAIL]
> # Cannot find device "ovs_br0"
> # TEST: IPv6, OVS geneve6: PMTU exceptions                            [FAIL]
> # Cannot find device "ovs_br0"
>
> Any idea why? Looks like kernel config did include OVS, perhaps we need
> explicit modprobe now? I don't see any more details in the logs.

Strange.  I expected that the module should have automatically been
loaded when attempting to communicate with the OVS genetlink family
type.  At least, that is how it had been working previously.

I'll spend some time looking into it and resubmit a rebased version.
Thanks, Jakub!


