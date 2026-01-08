Return-Path: <linux-kselftest+bounces-48497-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 90CB7D0276C
	for <lists+linux-kselftest@lfdr.de>; Thu, 08 Jan 2026 12:43:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 803CA315814F
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Jan 2026 11:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 004CD469203;
	Thu,  8 Jan 2026 11:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="zzeuYK4J";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="a4BjqOjY";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="zzeuYK4J";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="a4BjqOjY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D6346921A
	for <linux-kselftest@vger.kernel.org>; Thu,  8 Jan 2026 11:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767871505; cv=none; b=XA3X/nBmSQX5O9psux/8mvhqs2NKDd2pZasAp61FIstKww4BwI0fdAqWEe30TmjjvgJOwUavYMBcpBCyrpkK6CGH0O8pqHFifV+9AzbJI8T9aMHTU8kuHfNQaiOumQ3r96piGxgMoctC7bYhq+jiD+/XTXxrjP6ylN7BnFk2BVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767871505; c=relaxed/simple;
	bh=E+cxBL6iGJEaBuPkTGtHu82oHyV+Kg/WQo1e48kL0Q4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UqGqq++dPIWmgf0Lj4Qc4iK9XckKGRpUy+c6gMymDhqCuFRa+YrOBZdQYOJLqj0WZQawlmWU2iAyYdKTMNa+4MRq2PspFDD0djCxLvGL55Lf/1Khm15aYYwvUka3t4cXhyqkFwgxfNoxajydHEmP+Hc+oGBBFuVsb6Qz4U+ByNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=zzeuYK4J; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=a4BjqOjY; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=zzeuYK4J; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=a4BjqOjY; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5F82733E0F;
	Thu,  8 Jan 2026 11:25:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1767871500; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7c1/UMRLgd6OVjPFN55tLol9ENyLQiqdlzxLSOhEahA=;
	b=zzeuYK4JmvqpKb6T9z/uuaHIJr1np63drmqVzOReBPn1iF4ZFokHRksat8z5osSfr62d2a
	CkF3uPWlvoemv1K9g+lPmz4QIYD5SYPLDp4UVVS2y/AVB/kH5g+URSM85QmC/9RyelISos
	NorcAo2aqMKj3YLmEmYM/EH2PleO9us=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1767871500;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7c1/UMRLgd6OVjPFN55tLol9ENyLQiqdlzxLSOhEahA=;
	b=a4BjqOjY+rFIopZW9V2d0M7Et7r4PNvOLeijKtzJ3Vr7SQUSsSbmYlfzyBq5CcnC0H4pwy
	LDFGJnPi3dAZoMCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1767871500; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7c1/UMRLgd6OVjPFN55tLol9ENyLQiqdlzxLSOhEahA=;
	b=zzeuYK4JmvqpKb6T9z/uuaHIJr1np63drmqVzOReBPn1iF4ZFokHRksat8z5osSfr62d2a
	CkF3uPWlvoemv1K9g+lPmz4QIYD5SYPLDp4UVVS2y/AVB/kH5g+URSM85QmC/9RyelISos
	NorcAo2aqMKj3YLmEmYM/EH2PleO9us=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1767871500;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7c1/UMRLgd6OVjPFN55tLol9ENyLQiqdlzxLSOhEahA=;
	b=a4BjqOjY+rFIopZW9V2d0M7Et7r4PNvOLeijKtzJ3Vr7SQUSsSbmYlfzyBq5CcnC0H4pwy
	LDFGJnPi3dAZoMCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E21783EA63;
	Thu,  8 Jan 2026 11:24:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id BAJKNAuUX2m4DgAAD6G6ig
	(envelope-from <fmancera@suse.de>); Thu, 08 Jan 2026 11:24:59 +0000
Message-ID: <1660abed-e6ad-4657-8736-599ab9114f68@suse.de>
Date: Thu, 8 Jan 2026 12:24:47 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2 net-next v2] selftests: ipv6_icmp: add tests for
 ICMPv6 handling
To: David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, shuah@kernel.org, linux-kselftest@vger.kernel.org
References: <20260107153841.5030-1-fmancera@suse.de>
 <20260107153841.5030-2-fmancera@suse.de>
 <72d45fe9-c058-4944-b7a2-260b7259096f@kernel.org>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <72d45fe9-c058-4944-b7a2-260b7259096f@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spam-Level: 

On 1/7/26 5:41 PM, David Ahern wrote:
> On 1/7/26 8:38 AM, Fernando Fernandez Mancera wrote:
>> +icmpv6_to_vrf_based_local_address()
>> +{
>> +	local rc
>> +	local lldummy
>> +
>> +	echo
>> +	echo "ICMPv6 to VRF based local address"
>> +
>> +	setup
>> +
>> +	lldummy=$(get_linklocal dummy0)
>> +
>> +	if [ -z "$lldummy" ]; then
>> +		echo "Failed to get link local address for dummy0"
>> +		return 1
>> +	fi
>> +
>> +	run_cmd "$NS_EXEC sysctl -w net.ipv6.conf.all.keep_addr_on_down=1"
>> +
>> +	# create VRF and setup
>> +	run_cmd "$IP link add vrf0 type vrf table 10"
>> +	run_cmd "$IP link set vrf0 up"
>> +	run_cmd "$IP link set dummy0 master vrf0"
> 
> run_cmd "$IP -6 addr add ::1 dev vrf0 nodad"
> 
> makes the VRF device the loopback.
> 
>> +
>> +	# route to reach 2001:db8::1/128 on VRF device and back to ::1
>> +	run_cmd "$IP -6 route add 2001:db8:1::1/64 dev vrf0"
>> +	run_cmd "$IP -6 route add ::1/128 dev vrf0 table 10"
> 
> and then this route add should not be needed. This is how fcnal-test.sh
> works.
> 

Oh neat! Thanks.

>> +
>> +	# ping6 to link local address
>> +	run_cmd "$NS_EXEC ${ping6} -c 3 $lldummy%dummy0"
>> +	log_test $? 0 "Ping to link local address on VRF context"
>> +
>> +	# ping6 to link local address from localhost (::1)
>> +	run_cmd "$NS_EXEC ${ping6} -c 3 -I ::1 $lldummy%dummy0"
> 
> -I vrf0 should be needed for all VRF tests. I suspect your current
> passing tests are because you have a single setup step and then run
> non-VRF test followed by VRF test. Really you need to do the setup,
> run_test, cleanup for each test.
> 

You are right here about the cleanup, although the tests are passing 
even if the cleanup is properly done or if `-t 
icmpv6_to_vrf_based_local_address`. I don't see why they should not pass.

I am changing them to use `-I vrf0` because it makes more sense.

Thanks for the feedback!
Fernando.

>> +	log_test $? 0 "Ping to link local address from ::1 on VRF context"
>> +
>> +	# ping6 to local address
>> +	run_cmd "$NS_EXEC ${ping6} -c 3 2001:db8:1::1"
>> +	log_test $? 0 "Ping to local address on VRF context"
>> +
>> +	# ping6 to local address from localhost (::1)
>> +	run_cmd "$NS_EXEC ${ping6} -c 3 -I ::1 2001:db8:1::1"
>> +	log_test $? 0 "Ping to local address from ::1 on VRF context"
>> +}
>> +
> 


