Return-Path: <linux-kselftest+bounces-12029-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E560990A7B0
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Jun 2024 09:51:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92F801F24685
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Jun 2024 07:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71FB81862B0;
	Mon, 17 Jun 2024 07:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Vts3//Kh";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="LYFCS2cO";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Vts3//Kh";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="LYFCS2cO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48165186289;
	Mon, 17 Jun 2024 07:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718610666; cv=none; b=qEpDwp+9QmNKt/68qxG04MUeTmGzx5jjkERdHux+sJV/lYo7EB88ofjDZLBX32ulqUnnAF1nbSggyNAIuCb0ll2AYID22sGHUW0EUxPruHqETC+nR/jCALd2XhEa3IL19shPXvC/9cMzdyrXlzxmFTZyJQM8q6knBjugT7LPWaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718610666; c=relaxed/simple;
	bh=lpEsqv3Iuh1v6vt2Pdjq+Ggr2dkRSrpQL2k4c9li7eg=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=qKMYExiyPCqnft2Q9wdk8p66HO8K7NHkakaXFd8Rpp7nv4zZZ4kCA08DQUWbotM7M0LhM2O+pLEyKyJBCSmYi8DORZ1jXhbC755G27ib8WxMo123nzSX4nznX/V4M4ApEHgs24QmFUHqG5xur6ZS2GxkoLxPnoM9BhPccMr8AOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Vts3//Kh; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=LYFCS2cO; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Vts3//Kh; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=LYFCS2cO; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5353A5FAE8;
	Mon, 17 Jun 2024 07:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718610661; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YB8qKAak6FbWzN+Q55abT6Qil3tIS9mK+/WBrQ5pDek=;
	b=Vts3//Khim+bi5OrQ/oXh/fnuJMuJooTbtwiVjAPIDchA/MuTm6AvqWzQIPi+zxuqoHSj4
	QH+8uo6Eds9MDtv1ViM2WLhvl2bWhyHr+xEeUkivODVt7NnCK6w1UMtjFJHay63GxSSt/j
	qUs0L20d0cWkIt4D4PYPk94ubUAwBNM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718610661;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YB8qKAak6FbWzN+Q55abT6Qil3tIS9mK+/WBrQ5pDek=;
	b=LYFCS2cOJ07VRiUI/brDhZyBgO6rZyqVUhcoezewVpk3rbilEunAZEMRl5hBRr3DW49QaF
	3MpvhaXrGVkvxwCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718610661; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YB8qKAak6FbWzN+Q55abT6Qil3tIS9mK+/WBrQ5pDek=;
	b=Vts3//Khim+bi5OrQ/oXh/fnuJMuJooTbtwiVjAPIDchA/MuTm6AvqWzQIPi+zxuqoHSj4
	QH+8uo6Eds9MDtv1ViM2WLhvl2bWhyHr+xEeUkivODVt7NnCK6w1UMtjFJHay63GxSSt/j
	qUs0L20d0cWkIt4D4PYPk94ubUAwBNM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718610661;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YB8qKAak6FbWzN+Q55abT6Qil3tIS9mK+/WBrQ5pDek=;
	b=LYFCS2cOJ07VRiUI/brDhZyBgO6rZyqVUhcoezewVpk3rbilEunAZEMRl5hBRr3DW49QaF
	3MpvhaXrGVkvxwCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3E98B139AB;
	Mon, 17 Jun 2024 07:51:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id fIY0D+Xqb2byVQAAD6G6ig
	(envelope-from <osalvador@suse.de>); Mon, 17 Jun 2024 07:51:01 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 17 Jun 2024 09:51:01 +0200
From: Oscar Salvador <osalvador@suse.de>
To: Miaohe Lin <linmiaohe@huawei.com>
Cc: Jiaqi Yan <jiaqiyan@google.com>, nao.horiguchi@gmail.com,
 jane.chu@oracle.com, muchun.song@linux.dev, akpm@linux-foundation.org,
 shuah@kernel.org, corbet@lwn.net, rientjes@google.com, duenwen@google.com,
 fvdl@google.com, linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 linux-doc@vger.kernel.org, Lance Yang <ioworker0@gmail.com>
Subject: Re: [PATCH v2 1/3] mm/memory-failure: userspace controls
 soft-offlining pages
In-Reply-To: <786a08ff-aa7e-49d5-f589-0a405c7e1a34@huawei.com>
References: <20240611215544.2105970-1-jiaqiyan@google.com>
 <20240611215544.2105970-2-jiaqiyan@google.com>
 <CABzRoyYGY2EgT5wC9o98Vn_auh59poQ-OOnKceCiWQAJrbZoBw@mail.gmail.com>
 <CACw3F5134NmmLNr4zXHV1h0sLMTGcAJLpApQ7Fv_-DtUieD7zw@mail.gmail.com>
 <786a08ff-aa7e-49d5-f589-0a405c7e1a34@huawei.com>
User-Agent: Roundcube Webmail
Message-ID: <ea8c5e390bd18c532b768dd9eeaa105a@suse.de>
X-Sender: osalvador@suse.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.79
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-2.79 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	RCVD_TLS_ALL(0.00)[];
	TAGGED_RCPT(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[google.com,gmail.com,oracle.com,linux.dev,linux-foundation.org,kernel.org,lwn.net,kvack.org,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[15];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[]

On 2024-06-17 09:31, Miaohe Lin wrote:

> IMHO, it might not be suitable to use EAGAIN. Because it means
> "Resource temporarily unavailable" and
> this can be solved by simply retry later without any further actions
> taken. But I might be wrong.

We usually use 'EOPNOTSUPP' when we fail due to a setting not being set.
EPERM is more for a capability matter.


-- 
Oscar Salvador
SUSE Labs

