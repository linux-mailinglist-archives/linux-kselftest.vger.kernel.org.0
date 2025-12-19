Return-Path: <linux-kselftest+bounces-47735-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 35ED5CD0693
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Dec 2025 15:57:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7AADB300096E
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Dec 2025 14:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A288533B972;
	Fri, 19 Dec 2025 14:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="N6MmhXPP";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="SGGuQf64";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="LEcu8Cl4";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Vmc8luXD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C8D339713
	for <linux-kselftest@vger.kernel.org>; Fri, 19 Dec 2025 14:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766155937; cv=none; b=Mfnr0JAbjgHamQx/1KQb4lV9mEuEPLQtyfyffOI6KxgXO77EDfFdTFyQ3ETLxACK01uHd2l9AD3qyACkRq45IeU/Z9wzfHPh4EOXiklcWPZHYSrqkD1SO5P1k2srENvBTgZA+fkSDekjvhdCtGik2Ky6+QqIrALlPizuGBQKmto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766155937; c=relaxed/simple;
	bh=ImUUPMwAiw4KT2s5YfTK2bZEvXGjV1Z98li1PGQ6kp0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S0NKrRTX6n6OR0eyFAw8EqRBDzLJiX4Yp3QziXRzKOZ0iqimXpB2AdfMcadO1r/SD9ypqQeyfxMLimYYVV/VgBK1SZdZTPRyNTte7oyEkBYxG+Twg+w+lPN4H8bY3Cbx2vRanJ/RQBLck6+KFBVoQ20i81bcaxVI7l6KmtCi3io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=N6MmhXPP; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=SGGuQf64; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=LEcu8Cl4; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Vmc8luXD; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id EBD9333714;
	Fri, 19 Dec 2025 14:52:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1766155931; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EMdHZghCJaAoUjW3bhnhsD9W77RE+kIEL5WJG3veq0Y=;
	b=N6MmhXPPF7TwerBpBQ6s+1oarjFB6RJiff20kYQQvJTmSKHvhshqefzj8m+g6EsU27o22O
	add2yBdGtiOSB1EVd5YiYWQfZyexUPx5uZdwoDsnaqd2sQcH54cAOPf9bwDeSbzST7KBqq
	XRo4w0HHB/aq4JNIikgnchXOD334V9w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1766155931;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EMdHZghCJaAoUjW3bhnhsD9W77RE+kIEL5WJG3veq0Y=;
	b=SGGuQf64rP5ZW2lN+FRvdwXOGiVMMb9mFGjpFNjRczgWE0Fcb5psv9l1AMWwptnoCgHj2m
	XucDXlVi5GkSXyAg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=LEcu8Cl4;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Vmc8luXD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1766155929; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EMdHZghCJaAoUjW3bhnhsD9W77RE+kIEL5WJG3veq0Y=;
	b=LEcu8Cl4hnvP4f8Yz01rHmo2wSuHbjyCufUhA6y4QaIBsa3lwA9kLvwetZRTX79xhqg58Y
	nIVWmkshMpWokamuRMFvj14LIqsKpXgU9akEMuOxf3m1AO+ck9i1TM6BzdPo+t0s5AOtHR
	jm2sH0+ba9PrKyqPdJMNEwz37V+Jdi4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1766155929;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EMdHZghCJaAoUjW3bhnhsD9W77RE+kIEL5WJG3veq0Y=;
	b=Vmc8luXDAyRfvVer1KSeZNqN7mlir5pi+76WjkF7qebNq7ufSHw21xPgTj60raKttTdWhf
	/0E9eTVm2PNjmlDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5E0B63EA63;
	Fri, 19 Dec 2025 14:52:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id UQg+FJlmRWkJPwAAD6G6ig
	(envelope-from <fmancera@suse.de>); Fri, 19 Dec 2025 14:52:09 +0000
Message-ID: <9a3f7b60-37e3-470e-b9f7-8cda5ddccb59@suse.de>
Date: Fri, 19 Dec 2025 15:51:50 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: net: fib-onlink-tests: Set high metric for
 default IPv6 route
To: =?UTF-8?Q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
 David Ahern <dsahern@gmail.com>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251218-rbm-selftests-net-fib-onlink-v1-1-96302a5555c3@suse.com>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <20251218-rbm-selftests-net-fib-onlink-v1-1-96302a5555c3@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	FREEMAIL_TO(0.00)[suse.com,davemloft.net,google.com,kernel.org,redhat.com,gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email,suse.de:dkim,suse.de:mid]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Level: 
X-Rspamd-Queue-Id: EBD9333714
X-Spam-Flag: NO
X-Spam-Score: -4.51

On 12/18/25 1:20 PM, Ricardo B. Marlière wrote:
> Currently, the test breaks if the SUT already has a default route
> configured for IPv6. Fix by adding "metric 9999" to the `ip -6 ro add`
> command, so that multiple default routes can coexist.
> 
> Fixes: 4ed591c8ab44 ("net/ipv6: Allow onlink routes to have a device mismatch if it is the default route")
> Signed-off-by: Ricardo B. Marlière <rbm@suse.com>
> ---
>   tools/testing/selftests/net/fib-onlink-tests.sh | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/net/fib-onlink-tests.sh b/tools/testing/selftests/net/fib-onlink-tests.sh
> index ec2d6ceb1f08..acf6b0617373 100755
> --- a/tools/testing/selftests/net/fib-onlink-tests.sh
> +++ b/tools/testing/selftests/net/fib-onlink-tests.sh
> @@ -207,7 +207,7 @@ setup()
>   		ip -netns ${PEER_NS} addr add ${V6ADDRS[p${n}]}/64 dev ${NETIFS[p${n}]} nodad
>   	done
>   
> -	ip -6 ro add default via ${V6ADDRS[p3]/::[0-9]/::64}
> +	ip -6 ro add default via ${V6ADDRS[p3]/::[0-9]/::64} metric 9999
>   	ip -6 ro add table ${VRF_TABLE} default via ${V6ADDRS[p7]/::[0-9]/::64}
> 

It would probably require some work on the test but I think it could 
benefit from using two different network namespaces. Currently it is 
using PEER_NS and the default. I think avoiding the default one is 
beneficial for everyone as it ensures the state is clean and that the 
test won't interrupt the system connectivity.

Other tests already do that, e.g some tests in fib_tests.sh use ns1 and 
ns2 namespaces.

What do you all think?

>   	set +e
> 
> ---
> base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
> change-id: 20251218-rbm-selftests-net-fib-onlink-873ad01e6884
> 
> Best regards,


