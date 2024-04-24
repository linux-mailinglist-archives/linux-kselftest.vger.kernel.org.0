Return-Path: <linux-kselftest+bounces-8808-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A9678B11CC
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Apr 2024 20:14:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C0FA1C228A4
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Apr 2024 18:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD9C816D9D0;
	Wed, 24 Apr 2024 18:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MX7Xeefy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4031A16D9AC
	for <linux-kselftest@vger.kernel.org>; Wed, 24 Apr 2024 18:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713982487; cv=none; b=prHWhjZ4ccb6dTwdeWxhFF6KBKNGOQtUP/qQFhrQ5oftf1mUI9Mu01Xq4yssFtd5H9UrR0lSE8wy2LupauKwG2ugM067t4NHbm/Yu20GX3OWdx+BhNR6216xNzHNQSq2DLpUVzavyh0xrRHt51PYyAT1Gb7xxhDZ95yinmC6nCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713982487; c=relaxed/simple;
	bh=+4r7iLFXraZgcoLPWgj6PnzEMXZRq0mxHwRIq9rZegk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tn7cJRre5GkcXTshJGKk8YYxeVqg0Obocy9ZNRv0gyUN8kaSszznOM/tW2HWiH5pNbO2S51TVJLJjFmBEg1KmpYKGcVv8a0S0Go66JPDDnoXbSE9Sg292VPmpVS23TiSBBhgtzVmQXyl3tzTXLKlkZfbc/35R7TsZCa/qZr1Dao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MX7Xeefy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713982485;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ll6LtsSB3IShWEfWe8TsPKTtwPqmZYYtwit4iQKiJxY=;
	b=MX7Xeefy/oMZupqCpXbaGlZLw0lOziaECcv/RNcATKnRl4CE7tzv83i++hE5gT7qHFjafx
	oGejA8DcDIc65KOkBGvqCPaIEu7ixhA/SCUHZRZ38fxzkkmjpHauwets4U2wtVeksTsWi6
	oCZAA2YJ40JNJSdKoCFQjPV5yqKjLno=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-403-5G_tJbtIN1SpBo_XTRU4Zg-1; Wed,
 24 Apr 2024 14:14:43 -0400
X-MC-Unique: 5G_tJbtIN1SpBo_XTRU4Zg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2DCF929AA3B0;
	Wed, 24 Apr 2024 18:14:43 +0000 (UTC)
Received: from RHTRH0061144 (dhcp-17-72.bos.redhat.com [10.18.17.72])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id EC6EF492BC6;
	Wed, 24 Apr 2024 18:14:42 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: Benjamin Poirier <benjamin.poirier@gmail.com>
Cc: Simon Horman <horms@kernel.org>,  Jakub Kicinski <kuba@kernel.org>,
  dev@openvswitch.org,  netdev@vger.kernel.org,
  linux-kselftest@vger.kernel.org,  Jiri Pirko <jiri@resnulli.us>
Subject: Re: [ovs-dev] selftests: openvswitch: Questions about possible
 enhancements
In-Reply-To: <ZilIgbIvB04iUal2@f4> (Benjamin Poirier's message of "Wed, 24 Apr
	2024 13:59:29 -0400")
References: <20240424164405.GN42092@kernel.org>
	<20240424173715.GP42092@kernel.org> <ZilIgbIvB04iUal2@f4>
Date: Wed, 24 Apr 2024 14:14:42 -0400
Message-ID: <f7th6fqaar1.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

Benjamin Poirier <benjamin.poirier@gmail.com> writes:

> On 2024-04-24 18:37 +0100, Simon Horman wrote:
>> On Wed, Apr 24, 2024 at 05:44:05PM +0100, Simon Horman wrote:
>> > Hi Aaron, Jakub, all,
>> > 
>> > I have recently been exercising the Open vSwitch kernel selftests,
>> > using vng, something like this:
>> > 
>> > 	TESTDIR="tools/testing/selftests/net/openvswitch"
>> > 
>> >         vng -v --run . --user root --cpus 2 \
>> >                 --overlay-rwdir "$PWD" -- \
>> >                 "modprobe openvswitch && \
>> > 		 echo \"timeout=90\" >> \"${TESTDIR}/settings\" && \
>> >                  make -C \"$TESTDIR\" run_tests"
>> > 
>> > And I have some observations that I'd like to ask about.
>> > 
>> > 1. Building the kernel using the following command does not
>> >    build the openvswitch kernel module.
>> > 
>> > 	vng -v --build \
>> > 		--config tools/testing/selftests/net/config
>> > 
>> >    All that seems to be missing is CONFIG_OPENVSWITCH=m
>> >    and I am wondering what the best way of resolving this is.
>> > 
>> >    Perhaps I am doing something wrong.
>> >    Or perhaps tools/testing/selftests/net/openvswitch/config
>> >    should be created? If so, should it include (most of?) what is in
>> >    tools/testing/selftests/net/config, or just CONFIG_OPENVSWITCH=m?
>
> I noticed something similar when testing Jiri's virtio_net selftests
> patchset [1].
>
> drivers/net/virtio_net/config includes virtio options but the
> test also needs at least CONFIG_NET_VRF=y which is part of net/config.
>
> Whatever the answer to your question, all config files should be
> coherent on this matter.
>
> [1] https://lore.kernel.org/netdev/20240424104049.3935572-1-jiri@resnulli.us/
>
> [...]
>> 
>>   5. openvswitch.sh starts with "#!/bin/sh".
>>      But substitutions such as "${ns:0:1}0"  fail if /bin/sh is dash.
>>      Perhaps we should change openvswitch.sh to use bash?
>
> I think so. A similar change was done in
> c2518da8e6b0 selftests: bonding: Change script interpreter (v6.8-rc1)

+1 - I'm okay with it.


