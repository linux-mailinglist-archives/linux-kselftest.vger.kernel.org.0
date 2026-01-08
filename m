Return-Path: <linux-kselftest+bounces-48498-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AE72D040F9
	for <lists+linux-kselftest@lfdr.de>; Thu, 08 Jan 2026 16:54:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9F9F03127DF2
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Jan 2026 15:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A88113806B8;
	Thu,  8 Jan 2026 11:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ez5y9y1k";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="23j6UC6p";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ez5y9y1k";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="23j6UC6p"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3A9469228
	for <linux-kselftest@vger.kernel.org>; Thu,  8 Jan 2026 11:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767871655; cv=none; b=sWiYO+UsI4Nj/c4tJTd4ggs1gED32JCL6zXRHpiqbZbSz9fYOJdNzfVoEZclIB/xYewrwdqGWv8jAuhEEqrDj84pWOOp2Q6XfYrIGB0TLigP0r770ZFPZqWH+hMjOFpJldcP4yc0BgmiKpeUoFqnzHWjWs0BnfKrDxHfwe9XcTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767871655; c=relaxed/simple;
	bh=bzvOONiz/LrJGZ56bA5aDZ5W3+UC5VgEFzIfgk/o5sE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TVGED5JtnBloJra+pfVcE450wnL3UDJRUu9YmXUmhfLfTgOyLqanEQ+qBJjV8yctUVurcH8tMdBnTFXpgQcRRohFtjrbCj/u+lx4IPGSDl9dD+ftRzgWEnvk81JJUC448ww49GWdA5l5p3QFsFBPw7ClghU3SWd+NZWTNyGLqew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ez5y9y1k; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=23j6UC6p; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ez5y9y1k; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=23j6UC6p; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 689AA33E49;
	Thu,  8 Jan 2026 11:27:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1767871648; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cutGezCPFxLrAaEBktBpDaecXovQqIp/68fyppzQVxY=;
	b=ez5y9y1k5PJpJZBIY5kuWSSPaOP//kUTZfZU2haEA1oIegYrfsM78P2k/kTBcE9sfrPMos
	TUP8LL6+M5QG2ljvmkCsQNXNxaDfGcJp9MH9WXL1sSmGH5hh3v54+wpQLRCEg21tj8hxxG
	cksBCh3zF+NL2OQTOg2tjvdZ3GNMLWI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1767871648;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cutGezCPFxLrAaEBktBpDaecXovQqIp/68fyppzQVxY=;
	b=23j6UC6p8Gs/hgAi7WwLy8z7JKeGgdbEyEv30gyXaW67k9/uTyL37/aODGuxGOGA8uY5NM
	1pIHq517KItYaLBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1767871648; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cutGezCPFxLrAaEBktBpDaecXovQqIp/68fyppzQVxY=;
	b=ez5y9y1k5PJpJZBIY5kuWSSPaOP//kUTZfZU2haEA1oIegYrfsM78P2k/kTBcE9sfrPMos
	TUP8LL6+M5QG2ljvmkCsQNXNxaDfGcJp9MH9WXL1sSmGH5hh3v54+wpQLRCEg21tj8hxxG
	cksBCh3zF+NL2OQTOg2tjvdZ3GNMLWI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1767871648;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cutGezCPFxLrAaEBktBpDaecXovQqIp/68fyppzQVxY=;
	b=23j6UC6p8Gs/hgAi7WwLy8z7JKeGgdbEyEv30gyXaW67k9/uTyL37/aODGuxGOGA8uY5NM
	1pIHq517KItYaLBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E01533EA63;
	Thu,  8 Jan 2026 11:27:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id zdDNM5+UX2mKEAAAD6G6ig
	(envelope-from <fmancera@suse.de>); Thu, 08 Jan 2026 11:27:27 +0000
Message-ID: <f308ff67-5de1-452a-999c-e9230fc31e35@suse.de>
Date: Thu, 8 Jan 2026 12:27:23 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2 net-next v2] ipv6: use the right ifindex when replying
 to icmpv6 from localhost
To: Brian Haley <haleyb.dev@gmail.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, shuah@kernel.org,
 linux-kselftest@vger.kernel.org
References: <20260107153841.5030-1-fmancera@suse.de>
 <099019ee-05f4-457b-a82b-0fac55d8dd48@gmail.com>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <099019ee-05f4-457b-a82b-0fac55d8dd48@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	TAGGED_RCPT(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email]
X-Spam-Level: 
X-Spam-Flag: NO

On 1/7/26 6:05 PM, Brian Haley wrote:
> Hi Fernando,
> 
> On 1/7/26 10:38 AM, Fernando Fernandez Mancera wrote:
>> When replying to a ICMPv6 echo request that comes from localhost address
>> the right output ifindex is 1 (lo) and not rt6i_idev dev index. Use the
>> skb device ifindex instead. This fixes pinging to a local address from
>> localhost source address.
>>
>> $ ping6 -I ::1 2001:1:1::2 -c 3
>> PING 2001:1:1::2 (2001:1:1::2) from ::1 : 56 data bytes
>> 64 bytes from 2001:1:1::2: icmp_seq=1 ttl=64 time=0.037 ms
>> 64 bytes from 2001:1:1::2: icmp_seq=2 ttl=64 time=0.069 ms
>> 64 bytes from 2001:1:1::2: icmp_seq=3 ttl=64 time=0.122 ms
>>
>> 2001:1:1::2 ping statistics
>> 3 packets transmitted, 3 received, 0% packet loss, time 2032ms
>> rtt min/avg/max/mdev = 0.037/0.076/0.122/0.035 ms
>>
>> Fixes: 1b70d792cf67 ("ipv6: Use rt6i_idev index for echo replies to a 
>> local address")
>> Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
>> ---
>> v2: no changes
>> ---
>>   net/ipv6/icmp.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/net/ipv6/icmp.c b/net/ipv6/icmp.c
>> index 5d2f90babaa5..5de254043133 100644
>> --- a/net/ipv6/icmp.c
>> +++ b/net/ipv6/icmp.c
>> @@ -965,7 +965,9 @@ static enum skb_drop_reason 
>> icmpv6_echo_reply(struct sk_buff *skb)
>>       fl6.daddr = ipv6_hdr(skb)->saddr;
>>       if (saddr)
>>           fl6.saddr = *saddr;
>> -    fl6.flowi6_oif = icmp6_iif(skb);
>> +    fl6.flowi6_oif = ipv6_addr_type(&fl6.daddr) & IPV6_ADDR_LOOPBACK ?
>> +             skb->dev->ifindex :
>> +             icmp6_iif(skb);
>>       fl6.fl6_icmp_type = type;
>>       fl6.flowi6_mark = mark;
>>       fl6.flowi6_uid = sock_net_uid(net, NULL);
> 
> Using ipv6_addr_loopback(&fl6.daddr) might be more efficient as it does 
> a direct comparison of the address.
> 

Yes, I think you are right.

Thanks!
Fernando.

> -Brian
> 


