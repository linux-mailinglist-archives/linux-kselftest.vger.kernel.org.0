Return-Path: <linux-kselftest+bounces-12645-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 064D69168B4
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jun 2024 15:19:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36C661C22733
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jun 2024 13:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 608A415F406;
	Tue, 25 Jun 2024 13:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LDqKap9B"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C72D715A87A
	for <linux-kselftest@vger.kernel.org>; Tue, 25 Jun 2024 13:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719321529; cv=none; b=ZnZT78z+6UdB4a/inUfkebY1SEg1+w4iU7iidzj6lGDQDm2WvQcnMZ5ZaOF4GbVH7dmtZOc+Hp7QW+sG4s/HPrlon3+O9aiurFZ3EcCat6Tz9vOrXr9C0dlmy9XR6in36zj+GTv/WYHjFHHFweBLzcuyLHRG56/HpHAQgEYe5Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719321529; c=relaxed/simple;
	bh=hyBB6vBrNihLA68lQ1HJE9hCNJBLHhKrl6tOhM7ZdMA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nQ26NCz235H3E/Bt3LylNrFVyCcQvTvwN0QcPQu24W7fLVSjdI/wN7PCdx5mOLLG3YNYOodmdAI+8hxwpxdxUAgXD1LIcbrfos9i1xjE1brdjf6ZJ/9BCtLNkWIBtYHEcnAamO+rRWX9HtdnqUbwidsEZnUcVaeqJOQN796Ns14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LDqKap9B; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719321526;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DvYqY+fCd4ATNyzlRN/MbCN6GKhU5kwtb/V7+EMg3zg=;
	b=LDqKap9Bj+7dKXmheLtVx0PDdgNdoey2Zc7OSpQTbB7m51Xhu43cHxnXCWjA5Txh1t9nJf
	I6wwQDgMi021VNES5+RAimEcIN4UnH9E0K7AMXi4tH3a81S+wtEIwVoqvFHIvolAYt2sad
	vQk6VtFUXEDY+L7us+B79CeDgzusXDk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-659-E6boga1yNS-2FUioIakVlA-1; Tue,
 25 Jun 2024 09:18:42 -0400
X-MC-Unique: E6boga1yNS-2FUioIakVlA-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 42D411956059;
	Tue, 25 Jun 2024 13:18:40 +0000 (UTC)
Received: from RHTRH0061144 (dhcp-17-72.bos.redhat.com [10.18.17.72])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F253A3000225;
	Tue, 25 Jun 2024 13:18:37 +0000 (UTC)
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
In-Reply-To: <20240624153023.6fabd9f1@kernel.org> (Jakub Kicinski's message of
	"Mon, 24 Jun 2024 15:30:23 -0700")
References: <20240620125601.15755-1-aconole@redhat.com>
	<20240621180126.3c40d245@kernel.org> <f7ttthjh33w.fsf@redhat.com>
	<f7tpls6gu3q.fsf@redhat.com> <20240624153023.6fabd9f1@kernel.org>
Date: Tue, 25 Jun 2024 09:18:36 -0400
Message-ID: <f7tle2tgnyr.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Jakub Kicinski <kuba@kernel.org> writes:

> On Mon, 24 Jun 2024 12:53:45 -0400 Aaron Conole wrote:
>> Additionally, the "Cannot find device ..." text comes from an iproute2
>> utility output.  The only place we actually interact with that is via
>> the call at pmtu.sh:973:
>> 
>> 	run_cmd ip link set ovs_br0 up
>> 
>> Maybe it is possible that the link isn't up (could some port memory
>> allocation or message be delaying it?) yet in the virtual environment.
>
> Depends on how the creation is implemented, normally device creation
> over netlink is synchronous. Just to be sure have you tried to repro
> with vng:
>
> https://github.com/linux-netdev/nipa/wiki/How-to-run-netdev-selftests-CI-style
>
> ? It could be the base OS difference, too, but that's harder to confirm.

Yes - that's the way I run it.  But I didn't try to use any of the
stress inducing options.  I'll work on it with that.

>> To confirm, is it possible to run in the constrained environment, but
>> put a 5s sleep or something?  I will add the following either as a
>> separate patch (ie 7/8), or I can fold it into 6/7 (and drop Stefano's
>> ACK waiting for another review):
>> 
>> 
>> wait_for_if() {
>>    if ip link show "$2" >/dev/null 2>&1; then return 0; fi
>> 
>>    for d in `seq 1 30`; do
>>       sleep 1
>>       if ip link show "$2" >/dev/null 2>&1; then return 0; fi
>>    done
>>    return 1
>> }
>> 
>> ....
>>  	setup_ovs_br_internal || setup_ovs_br_vswitchd || return $ksft_skip
>> +	wait_for_if "ovs_br0"
>>  	run_cmd ip link set ovs_br0 up
>> ....
>> 
>> Does it make sense or does it seem like I am way off base?
>
> sleep 1 is a bit high (sleep does accept fractional numbers!)
> but otherwise worth trying, if you can't repro locally.

Ack.


