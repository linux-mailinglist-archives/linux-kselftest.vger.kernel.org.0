Return-Path: <linux-kselftest+bounces-5238-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A570A85E9A4
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Feb 2024 22:12:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A0FF1F22DB9
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Feb 2024 21:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6BAF126F0F;
	Wed, 21 Feb 2024 21:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OQRyKaGu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 355C2127B56
	for <linux-kselftest@vger.kernel.org>; Wed, 21 Feb 2024 21:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708549909; cv=none; b=dDdNHMdtbh2j2NT8QpavsglquB7v4d9rSKaciHctiqeLkfYDclkwRVeZtPt44Q2ZOG1W1Kdu67Ds/mm+1vaEZkvMhCFEUhr5hHEuRu9HZIz9T/y7dJFUOWsHcELzyi0mSO0iTAXS58osYOpNDP2xrA/phbOnX4Udb83yjGaHT94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708549909; c=relaxed/simple;
	bh=y+g4VH4HMHJMPwYqfkuWM1sbJWzR6l6Zg/DAzzWWQHo=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=jcwq3jbvUu7IA0l8Lfth5/11b9exwiw/sjcSwXWnSMjIPF8bD+yJCm/xE3+I2VqBIN9UtHFpfqfOFMr8nRK/7fp8hftPsTSQiW827yCIn6of3Y0qL+CP9MTc33dZ1Awi8/Let0b+oPjYg/ACZ+aZVAaQR1y5RiaLteY2n+CzxBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OQRyKaGu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708549907;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p1nPCOPYuN2D6G3cZ3RkXJnq6kH4M+WIo6+EDqyiqg0=;
	b=OQRyKaGuAOoz8U3iWAiLXyk/ABwL9wsSgpck5AMgBTlY/Tr2YSUhYrCjTkceXlNML++P9a
	NX4kqZAF1rtY0+ySVnSD+he2ZP5nXFAA/2D3FEeWGc8pvuO2r0msD4IBzedPD3/41Nps2V
	ct/KaObkUSTV1RMODlGlJT1PfiKqpxE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-596-SKUCSznuMk2StBfzkeMRSQ-1; Wed, 21 Feb 2024 16:11:43 -0500
X-MC-Unique: SKUCSznuMk2StBfzkeMRSQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 28655811E79;
	Wed, 21 Feb 2024 21:11:43 +0000 (UTC)
Received: from RHTPC1VM0NT (dhcp-17-72.bos.redhat.com [10.18.17.72])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id D306D492BD7;
	Wed, 21 Feb 2024 21:11:42 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: Adrian Moreno <amorenoz@redhat.com>
Cc: netdev@vger.kernel.org,  dev@openvswitch.org,  Ilya Maximets
 <i.maximets@ovn.org>,  Eric Dumazet <edumazet@google.com>,
  linux-kselftest@vger.kernel.org,  Jakub Kicinski <kuba@kernel.org>,
  Paolo Abeni <pabeni@redhat.com>,  Shuah Khan <shuah@kernel.org>,  "David
 S. Miller" <davem@davemloft.net>
Subject: Re: [ovs-dev] [RFC 3/7] selftests: openvswitch: use non-graceful
 kills when needed
References: <20240216152846.1850120-1-aconole@redhat.com>
	<20240216152846.1850120-4-aconole@redhat.com>
	<4bba621b-3680-4c70-b10c-39787c7c0ce1@redhat.com>
Date: Wed, 21 Feb 2024 16:11:42 -0500
In-Reply-To: <4bba621b-3680-4c70-b10c-39787c7c0ce1@redhat.com> (Adrian
	Moreno's message of "Wed, 21 Feb 2024 18:32:27 +0100")
Message-ID: <f7ty1bd8qup.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

Adrian Moreno <amorenoz@redhat.com> writes:

> On 2/16/24 16:28, Aaron Conole wrote:
>> Normally a spawned process under OVS is given a SIGTERM when the test
>> ends as part of cleanup.  However, in case the process is still lingering
>> for some reason, we also send a SIGKILL to force it down faster.
>> Signed-off-by: Aaron Conole <aconole@redhat.com>
>> ---
>>   tools/testing/selftests/net/openvswitch/openvswitch.sh | 6 ++++--
>>   1 file changed, 4 insertions(+), 2 deletions(-)
>> diff --git a/tools/testing/selftests/net/openvswitch/openvswitch.sh
>> b/tools/testing/selftests/net/openvswitch/openvswitch.sh
>> index a5dbde482ba4..678a72ad47c1 100755
>> --- a/tools/testing/selftests/net/openvswitch/openvswitch.sh
>> +++ b/tools/testing/selftests/net/openvswitch/openvswitch.sh
>> @@ -91,7 +91,8 @@ ovs_add_if () {
>>   		python3 $ovs_base/ovs-dpctl.py add-if \
>>   		    -u "$2" "$3" >$ovs_dir/$3.out 2>$ovs_dir/$3.err &
>>   		pid=3D$!
>> -		on_exit "ovs_sbx $1 kill -TERM $pid 2>/dev/null"
>> +		on_exit "ovs_sbx $1 kill --timeout 1000 TERM \
>> +                                        --timeout 1000 KILL $pid 2>/dev=
/null"
>>   	fi
>>   }
>>=20=20=20
>
> AFAIK, this will immediately send TERM, then wait 1s, send TERM again,
> wait 1s then send KILL. Is that what you intended? To avoid the double
> TERM you could:

Okay, I'll adjust it.

> --
> Adri=C3=A1n Moreno
>
>> @@ -108,7 +109,8 @@ ovs_netns_spawn_daemon() {
>>   	info "spawning cmd: $*"
>>   	ip netns exec $netns $*  >> $ovs_dir/stdout  2>> $ovs_dir/stderr &
>>   	pid=3D$!
>> -	ovs_sbx "$sbx" on_exit "kill -TERM $pid 2>/dev/null"
>> +	ovs_sbx "$sbx" on_exit "kill --timeout 1000 TERM \
>> +                                    --timeout 1000 KILL $pid 2>/dev/nul=
l"
>>   }
>>     ovs_add_netns_and_veths () {


