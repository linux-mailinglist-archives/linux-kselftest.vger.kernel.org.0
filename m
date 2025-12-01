Return-Path: <linux-kselftest+bounces-46782-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A7A0C964A3
	for <lists+linux-kselftest@lfdr.de>; Mon, 01 Dec 2025 09:58:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5D8F64E1387
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Dec 2025 08:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCAFD2FD7DA;
	Mon,  1 Dec 2025 08:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="YOM5Lr5d";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="v0HBoub+";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="YOM5Lr5d";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="v0HBoub+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E412D2FD68D
	for <linux-kselftest@vger.kernel.org>; Mon,  1 Dec 2025 08:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764579491; cv=none; b=JfC2Qnfebxi4vMlEwXw5Gp/y96IJ0uYp3hPGm0bvimbWWk7AlK6b02RvwOjLps8/FHbCPTcaMzVFe8SSl4ksYMIoPEONAV8PcOBM0XNe3fXzLoDKVW64SQL6p/MP4I+3dXAief/da52VGXb8K1n9N1ifZAFmwT0AnRrs/R7MpLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764579491; c=relaxed/simple;
	bh=X5wRJC7lZfI2JxXrlOHVkK8Dhcp5VBRZVeLW6lB6M00=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KL7qisNq1Ur1u3xV6NczkJBESUMOuQPwChTZda9ucmC3gA86AP4U1yQ8CdTnPmi2uv1HtP5mnxlavUuGjX5YCNqBTxbWfNHA42UE+/7T1ocIk8lZgevelrw5IeIyFbRvz9rRRZ1c/R4wpdeFFf8vucXDTo6W9NEwHLu0BF3ynM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=YOM5Lr5d; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=v0HBoub+; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=YOM5Lr5d; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=v0HBoub+; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1CADA5BD51;
	Mon,  1 Dec 2025 08:58:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1764579488; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8SiUpfX9M8LLIqmWf8iz9EvnoQHx9wwh9z4++DhczXg=;
	b=YOM5Lr5dxO2NFsFswzCU51zzS1qdtnJeDKu5HqEeXhHcokcFpHOT/YkSFTteG2ofDyp5ju
	b7wb7ewP1jiRifhUcozu2vUV7AJO3E9RqSPrkLSAsO0pG6VUooI+LX6olSeTMPYIKu2PN4
	pahFrNPO88p4q7bKyjIEVzztho88ALE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1764579488;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8SiUpfX9M8LLIqmWf8iz9EvnoQHx9wwh9z4++DhczXg=;
	b=v0HBoub+/l86Qc2eTq9Z2v25Szy1lPy4LVcsWTsNjpQlUCREwgmPIsKqxx1t0gtlaPBbfG
	gBVEqacIEikG/TDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1764579488; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8SiUpfX9M8LLIqmWf8iz9EvnoQHx9wwh9z4++DhczXg=;
	b=YOM5Lr5dxO2NFsFswzCU51zzS1qdtnJeDKu5HqEeXhHcokcFpHOT/YkSFTteG2ofDyp5ju
	b7wb7ewP1jiRifhUcozu2vUV7AJO3E9RqSPrkLSAsO0pG6VUooI+LX6olSeTMPYIKu2PN4
	pahFrNPO88p4q7bKyjIEVzztho88ALE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1764579488;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8SiUpfX9M8LLIqmWf8iz9EvnoQHx9wwh9z4++DhczXg=;
	b=v0HBoub+/l86Qc2eTq9Z2v25Szy1lPy4LVcsWTsNjpQlUCREwgmPIsKqxx1t0gtlaPBbfG
	gBVEqacIEikG/TDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 960073EA63;
	Mon,  1 Dec 2025 08:58:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OVbFIZ9YLWmCPAAAD6G6ig
	(envelope-from <fmancera@suse.de>); Mon, 01 Dec 2025 08:58:07 +0000
Message-ID: <30ee83e6-bed4-43c8-bbe2-ea19fbf17ce3@suse.de>
Date: Mon, 1 Dec 2025 09:58:00 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2 net-next] selftests: ipv6_icmp: add tests for ICMPv6
 handling
To: David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org, shuah@kernel.org, horms@kernel.org,
 pabeni@redhat.com, kuba@kernel.org, edumazet@google.com, davem@davemloft.net
References: <20251126201943.4480-1-fmancera@suse.de>
 <20251126201943.4480-2-fmancera@suse.de>
 <341a110e-7ba0-4846-abf4-5143042c8e80@kernel.org>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <341a110e-7ba0-4846-abf4-5143042c8e80@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	URIBL_BLOCKED(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Level: 
X-Spam-Score: -4.30
X-Spam-Flag: NO

On 11/29/25 4:56 PM, David Ahern wrote:
> On 11/26/25 12:19 PM, Fernando Fernandez Mancera wrote:
>> Test ICMPv6 to link local address and local address. In addition, this
>> test set could be extended to cover more situations in the future.
>>
>> ICMPv6 to local addresses
>>      TEST: Ping to link local address                                   [OK]
>>      TEST: Ping to link local address from ::1                          [OK]
>>      TEST: Ping to local address                                        [OK]
>>      TEST: Ping to local address from ::1                               [OK]
>>
> 
> VRF based tests are needed as well to ensure this change works properly
> with VRFs.
> 

Thank you David. I am reposting it with VRF based tests once net-next 
tree is open again.

