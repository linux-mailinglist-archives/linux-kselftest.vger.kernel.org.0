Return-Path: <linux-kselftest+bounces-49005-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 832BBD2404A
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Jan 2026 11:51:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CA4A2300BF97
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Jan 2026 10:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79FB93644D7;
	Thu, 15 Jan 2026 10:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="hIaDRcUd";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="SLHsF7FP";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="hIaDRcUd";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="SLHsF7FP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B8E34405E
	for <linux-kselftest@vger.kernel.org>; Thu, 15 Jan 2026 10:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768474282; cv=none; b=S6CCryRWjFOdNm6A8WNw+KWdeKiKgAL3rNNohqRDfdLuSlgGa5aMpnw5acn4ujeGGkY2p8nVQdlWGTNDn3yABfitlrcf49xODyDU61eaWURzJ58O/VItV/Nr/ytCDjCNv9i6OxvkAh+Mkw0YhqzFhBY03BbLdO7OI50yUTlNyOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768474282; c=relaxed/simple;
	bh=Ynky0MjTOODqPEwH/P+iqh1HX8BUY1Q7fYbVIx0jXu8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hGF2Up6Ua3kxBDR3U1wniZ60jeVYB8QXLKgOZykMaIn9Lr7K9bR7i1F6w9YmcyF0MT/Z+sJh2iUpDRNOFG5+uxqgMRQM2eUP6W39+Dp72WuH14ajFMmB0F1e4MjKXavoyWaRT66+rqe2LcGm0yPwmbzgJCN7vkx8IT4/j1r8IRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=hIaDRcUd; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=SLHsF7FP; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=hIaDRcUd; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=SLHsF7FP; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5D93D5BD36;
	Thu, 15 Jan 2026 10:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1768474279; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FtNPBaSDIhguHIE1ckOYMIBRyOsivCBDjwWC6EqcEdg=;
	b=hIaDRcUdkA1Xf37sr0Tk78l8heCChPPS7FZtVIAhXQ1ea3lGYjrsEFQgOSx+H/SHBUNU5h
	guiPhnJV/BnoMX0xiFqMVbZl3IxFFt+90Rq+YBj3Ru1DJWdgt5xu4RXQZeZyBztJXmDV08
	UUQCfoCiJULCT2H1uYIft2ZJp9aOjjI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1768474279;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FtNPBaSDIhguHIE1ckOYMIBRyOsivCBDjwWC6EqcEdg=;
	b=SLHsF7FPEx480Uxv9UkonxIleL4WOR/HahW24r1foGQWd6VV+z9VRvYkgow9h8r1tMdMGk
	AfRJU+2ZcbEoYYDw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=hIaDRcUd;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=SLHsF7FP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1768474279; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FtNPBaSDIhguHIE1ckOYMIBRyOsivCBDjwWC6EqcEdg=;
	b=hIaDRcUdkA1Xf37sr0Tk78l8heCChPPS7FZtVIAhXQ1ea3lGYjrsEFQgOSx+H/SHBUNU5h
	guiPhnJV/BnoMX0xiFqMVbZl3IxFFt+90Rq+YBj3Ru1DJWdgt5xu4RXQZeZyBztJXmDV08
	UUQCfoCiJULCT2H1uYIft2ZJp9aOjjI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1768474279;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FtNPBaSDIhguHIE1ckOYMIBRyOsivCBDjwWC6EqcEdg=;
	b=SLHsF7FPEx480Uxv9UkonxIleL4WOR/HahW24r1foGQWd6VV+z9VRvYkgow9h8r1tMdMGk
	AfRJU+2ZcbEoYYDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B867C3EA63;
	Thu, 15 Jan 2026 10:51:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MU39KabGaGkJGwAAD6G6ig
	(envelope-from <fmancera@suse.de>); Thu, 15 Jan 2026 10:51:18 +0000
Message-ID: <4e1ce741-12a7-42af-8a7d-d384d3f13c33@suse.de>
Date: Thu, 15 Jan 2026 11:51:08 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] selftests: net: fib-onlink-tests: Convert to use
 namespaces by default
To: =?UTF-8?Q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
 David Ahern <dsahern@gmail.com>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260113-selftests-net-fib-onlink-v2-1-89de2b931389@suse.com>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <20260113-selftests-net-fib-onlink-v2-1-89de2b931389@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[suse.com,davemloft.net,google.com,kernel.org,redhat.com,gmail.com];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_TRACE(0.00)[suse.de:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:mid,suse.de:dkim,suse.de:email]
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Rspamd-Queue-Id: 5D93D5BD36
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Level: 

On 1/13/26 4:37 PM, Ricardo B. Marlière wrote:
> Currently, the test breaks if the SUT already has a default route
> configured for IPv6. Fix by avoiding the use of the default namespace.
> 
> Fixes: 4ed591c8ab44 ("net/ipv6: Allow onlink routes to have a device mismatch if it is the default route")
> Suggested-by: Fernando Fernandez Mancera <fmancera@suse.de>
> Signed-off-by: Ricardo B. Marlière <rbm@suse.com>

Reviewed-by: Fernando Fernandez Mancera <fmancera@suse.de>

LGTM and passes on my side. Thanks.

