Return-Path: <linux-kselftest+bounces-4876-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45C8E8585C9
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Feb 2024 19:51:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77D531C236C8
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Feb 2024 18:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1306135414;
	Fri, 16 Feb 2024 18:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AbYulZUm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0331353EA
	for <linux-kselftest@vger.kernel.org>; Fri, 16 Feb 2024 18:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708109443; cv=none; b=YVRG6KCOJadVmmfcVtOx2fCg8bE4pyVTxibOFTffV+bf+j+okeeq+jD4URXWgRNQ7xyYm/y6FxuG5Up7Xa5Gd4rH0d3JUWUuZXEMyPqC/aywJkPsP2TJX6j7lcURzyNERhRM7Ya849hp7PrZFR7Op+ubMZks1Yzo5l9xBj6joY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708109443; c=relaxed/simple;
	bh=5K5in29s2ilrU1P9jDQ0b6DBfBDJkEiiMKGFmnHWvWM=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=cKac1UoMO8NmkPZsCFsiLlaU0WEmj+UUz7wEH2IeuLewlNwwgZq1/oCHevdD7LczjLYHRAnDcqWDaE3SuSqa0lM0eNtDE6ze104kbVbg4HnqB9d+fZA+/crGQii604wjxsuPrT+WnoLHAks3CCz+jpwoRThlhDIpGW83pJB/XUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AbYulZUm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708109439;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cG/xi4a8F8EewDkwJevk3BPCAWziD77wFZSl7GoN0rI=;
	b=AbYulZUmDw2XIL5XZcoHzt1ObCrp/ckcczG5TnrrVOpNIUBTiJ7HjHPpOBStIYTitvP3LY
	gBkIpRfU35pGrEz9dAaF/Vt1hVk5N+zUZ/AgmwRDYz5pWrCTu2cUYNaTbj7VoLsIDlDo4I
	/sy34cMCkEOBGt1qanma6XucH4OX2Cc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-260-TXmcfDuNNSy8g6qnevYRSw-1; Fri, 16 Feb 2024 13:50:36 -0500
X-MC-Unique: TXmcfDuNNSy8g6qnevYRSw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A839B84C65E;
	Fri, 16 Feb 2024 18:50:35 +0000 (UTC)
Received: from RHTPC1VM0NT (unknown [10.22.33.57])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id A58932166AE7;
	Fri, 16 Feb 2024 18:50:34 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,  "David S. Miller" <davem@davemloft.net>,  Eric
 Dumazet <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>,  Pravin
 B Shelar <pshelar@ovn.org>,  dev@openvswitch.org,  Ilya Maximets
 <i.maximets@ovn.org>,  Simon Horman <horms@ovn.org>,  Eelco Chaudron
 <echaudro@redhat.com>,  Shuah Khan <shuah@kernel.org>,
  linux-kselftest@vger.kernel.org
Subject: Re: [RFC 4/7] selftests: openvswitch: delete previously allocated
 netns
References: <20240216152846.1850120-1-aconole@redhat.com>
	<20240216152846.1850120-5-aconole@redhat.com>
	<7f51a2e2bfe1e3ee15f12f655e6d7ab5d9d73b5a.camel@redhat.com>
Date: Fri, 16 Feb 2024 13:50:34 -0500
In-Reply-To: <7f51a2e2bfe1e3ee15f12f655e6d7ab5d9d73b5a.camel@redhat.com>
	(Paolo Abeni's message of "Fri, 16 Feb 2024 17:31:53 +0100")
Message-ID: <f7tmss0fdl1.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

Paolo Abeni <pabeni@redhat.com> writes:

> On Fri, 2024-02-16 at 10:28 -0500, Aaron Conole wrote:
>> Many openvswitch test cases reused netns and interface names.  This works
>> fine as long as the test case cleans up gracefully.  However, if there is
>> some kind of ungraceful termination (such as an external signal) the net=
ns
>> or interfaces can be left lingering. =C2=A0
>
> It looks the openvswitch.sh test script is already trying quite hard to
> delete the allocated resources on ungraceful termination via "trap...".
>
> That is usually enough for other self-tests, could you please detail
> when it fails here?

I thought it should work - but at least what I observed is that when the
vng spawned VM was running the tests, it would TERM portions of the
subshell, but not the running openvswitch.sh script.  That left these
namespaces and interfaces lingering.

>> This happens when the selftest
>> timeout gets exceeded, while running under very slow debugging condition=
s.
>
> 'timeout' should send SIG_TERM, and the script already handle that
> gracefully?

At least, I didn't observe that to be the case when it got terminated.
I'll remove the timeout setting and try to reproduce it.

>> The solution here is to cleanup the netns on executing the next test.
>
> I suggest avoiding this, it could end up killing innocent alias netns.
>
> You could consider using the 'setup_ns' helper from the
> tools/testing/selftests/net/lib.sh library to always generate unique
> netns names.

Okay - I will look into that.

>> Signed-off-by: Aaron Conole <aconole@redhat.com>
>> ---
>>  tools/testing/selftests/net/openvswitch/openvswitch.sh | 4 ++++
>>  1 file changed, 4 insertions(+)
>>=20
>> diff --git a/tools/testing/selftests/net/openvswitch/openvswitch.sh b/to=
ols/testing/selftests/net/openvswitch/openvswitch.sh
>> index 678a72ad47c1..8dc315585710 100755
>> --- a/tools/testing/selftests/net/openvswitch/openvswitch.sh
>> +++ b/tools/testing/selftests/net/openvswitch/openvswitch.sh
>> @@ -115,6 +115,10 @@ ovs_netns_spawn_daemon() {
>>=20=20
>>  ovs_add_netns_and_veths () {
>>  	info "Adding netns attached: sbx:$1 dp:$2 {$3, $4, $5}"
>> +	ntns_e=3D`ip netns list | grep $3`
>> +	[ "$ntns_e" !=3D "" ] && ip netns del "$3"
>> +	if4_e=3D`ip link show $4 2>/dev/null`
>
> Minor unrelated note: $() is preferable to `` for sub-shells, as it's
> more friendly to nesting, string expansing, quotes, etc.

Okay - I'll prefer it in future.  I didn't know how much I should be
worrying about non-POSIX shells (I seem to remember that `` is accepted
in more shells).

> Cheers,
>
> Paolo


