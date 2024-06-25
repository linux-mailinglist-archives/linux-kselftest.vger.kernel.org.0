Return-Path: <linux-kselftest+bounces-12698-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8C31916CDF
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jun 2024 17:24:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 101FEB28F8B
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jun 2024 15:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21AAF17C9F0;
	Tue, 25 Jun 2024 15:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JLymxE1w"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FBF616F8F4
	for <linux-kselftest@vger.kernel.org>; Tue, 25 Jun 2024 15:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719328646; cv=none; b=BsriIYLz7D/2Aumt2zLOwHgNYpH1VQ+Z6PVE2eKdOJjRGuLeGG0kohsKCYpbr9gISw8/TatxeLMNK1NQDbQaFR69Do+FPHbdnhbS9EI8B2U5lX4B0rTa3L1pdUa/jsuur0hVNxFBIwKL94AeWa4sDHvoILpGNkq2tPPOsQcifa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719328646; c=relaxed/simple;
	bh=tX7m3fbagW+Xu7Gov5fW024aDM7tXtp/CEdtBqu2uo0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qCtj0lQaed+tnjdHJMgl8IV8v6hSIxqfxee3eCktuukL7P6Aws3180tqNirsqq4JCVNoUXJxBZk9r/2cmJceGBwjveAPBGObsamsvkaCf4+ohqxKdsqd4BYyjUk32gLv2btllNQIUkyw5bba+D1yNH+kIwBPf9P9ihaPk+xqxis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JLymxE1w; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719328643;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W1pWUcsCbDz/QzTtn1KclW1Fnze6TwCApU6kqlWKFYE=;
	b=JLymxE1wVSHTdExhF2C6c1eiIMVuVQdHyaw7SgW2c4NuKfaWgqlOzkUdO86qzRh7xNDTYX
	1aB1WgHyyW7FKVrrbCC+B/GUXo1DyFBv5nzsUHVfmbe5grWRl/Whhx8Om6y3Nwtkata9BU
	abRmDa9z4IyGJrPJFoQwGWtTxeD50dU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-42-gWiis1akMt6uaXVEmPltRA-1; Tue,
 25 Jun 2024 11:17:20 -0400
X-MC-Unique: gWiis1akMt6uaXVEmPltRA-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2B8EA19560B2;
	Tue, 25 Jun 2024 15:17:18 +0000 (UTC)
Received: from RHTRH0061144 (dhcp-17-72.bos.redhat.com [10.18.17.72])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9C30E1954AC1;
	Tue, 25 Jun 2024 15:17:15 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>,  netdev@vger.kernel.org,
  dev@openvswitch.org,  linux-kselftest@vger.kernel.org,
  linux-kernel@vger.kernel.org,  Pravin B Shelar <pshelar@ovn.org>,  "David
 S. Miller" <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>,
  Shuah Khan <shuah@kernel.org>,  Stefano Brivio <sbrivio@redhat.com>,
  =?utf-8?Q?Adri=C3=A1n?= Moreno <amorenoz@redhat.com>,  Simon Horman
 <horms@kernel.org>
Subject: Re: [PATCH v2 net-next 0/7] selftests: net: Switch pmtu.sh to use
 the internal ovs script.
In-Reply-To: <20240625074145.69fc9d9f@kernel.org> (Jakub Kicinski's message of
	"Tue, 25 Jun 2024 07:41:45 -0700")
References: <20240620125601.15755-1-aconole@redhat.com>
	<20240621180126.3c40d245@kernel.org> <f7ttthjh33w.fsf@redhat.com>
	<f7tpls6gu3q.fsf@redhat.com>
	<e4f69335f90aae3f1daa47ba8f69b24ea15ed3b7.camel@redhat.com>
	<f7th6dhgnvm.fsf@redhat.com> <20240625070654.6a00efef@kernel.org>
	<f7t1q4lgldr.fsf@redhat.com> <20240625074145.69fc9d9f@kernel.org>
Date: Tue, 25 Jun 2024 11:17:14 -0400
Message-ID: <f7tsex1f3wl.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Jakub Kicinski <kuba@kernel.org> writes:

> On Tue, 25 Jun 2024 10:14:24 -0400 Aaron Conole wrote:
>> > Sorry for not checking it earlier, looks like the runner was missing
>> > pyroute:
>> >
>> > # python3 ./tools/testing/selftests/net/openvswitch/ovs-dpctl.py
>> > Need to install the python pyroute2 package >=3D 0.6.
>> >
>> > I guess run_cmd counter-productively eats the stderr output ? :(=20=20
>>=20
>> Awesome :)  I will add a patch to ovs-dpctl that will turn the
>> sys.exit(0) into sys.exit(1) - that way it should do the skip.
>>=20
>> When I previously tested, I put an error in the `try` without reading
>> the except being specifically for a ModuleNotFound error.
>>=20
>> I'll make sure pyroute2 isn't installed when I run it again.
>>=20
>> Thanks for your help Jakub and Paolo!
>
> BTW I popped the v2 back into the queue, so the next run (in 20min)
> will tell us if that's the only thing we were missing =F0=9F=A4=9E=EF=B8=
=8F

:)  I'll wait to post the v3 then.  So far, the only change I have is:

--- a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
+++ b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
@@ -34,7 +34,7 @@ try:
=20
 except ModuleNotFoundError:
     print("Need to install the python pyroute2 package >=3D 0.6.")
-    sys.exit(0)
+    sys.exit(1)
=20
=20
 OVS_DATAPATH_FAMILY =3D "ovs_datapath"
---


