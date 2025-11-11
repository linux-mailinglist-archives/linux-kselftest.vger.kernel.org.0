Return-Path: <linux-kselftest+bounces-45318-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61D05C4E4F2
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Nov 2025 15:11:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E32C61881AFA
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Nov 2025 14:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84257307ACF;
	Tue, 11 Nov 2025 14:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LLwXHnXW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6CF42EBBA8
	for <linux-kselftest@vger.kernel.org>; Tue, 11 Nov 2025 14:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762870201; cv=none; b=q049nkcYq94DOZcXgiiuFKfC9t6g0Q8KBqbBpU5Gc15FwMCrLsY7+fVjXmrjwRHfMN48TXz0QSkMX7slKztQ78OzdJYo3PfsecDhuNqNzLoF14CBdbqE6PRGEraWu+sixLbWZbH9pzcojsF+p7Xew0wlQWlVM3ETUeX1gyWynJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762870201; c=relaxed/simple;
	bh=L8iD7ISPG2fGHbO2n2GzUqN8VPD4vbOEio6K+3ptYII=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gdTaNUD5Ly1WEDNp2YO4oQmlVhYLpyDefsG3OiBZ5lNfDa6F5l25zIG3wbxaPn07TIHSAaAX6/13J+KCnXX0C7/DW8cO88mxMJJVCKHqJE77woOMdGx/BQE+gl+bp7AEtOOZYIQe8ntUt23FFE+XXQj2NaJPDauHIJyPzwR+oYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LLwXHnXW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762870198;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z0jAePqN6TOEf6jTJjCEwq53g6vGvq/lRpJXMiEpVl8=;
	b=LLwXHnXWSoeqvkf0XZIdfcvAn/EEp3TT/0eeUPIAPl0CoYScSEaO2DImR1gioo3Nn84woR
	ZZFplSC1Y7/7DHxAkPvp4rw2ImYNGxE0ZYfMN+gsOoGoilG4S0p/h2awQjQfR02zBsNeAW
	QDUUxSxCPIKW5qkS0FhoDTFjlI6AmqE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-650-vw-lvJJNOaevRjFJJf1SIA-1; Tue,
 11 Nov 2025 09:09:55 -0500
X-MC-Unique: vw-lvJJNOaevRjFJJf1SIA-1
X-Mimecast-MFC-AGG-ID: vw-lvJJNOaevRjFJJf1SIA_1762870193
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8E8DA195607F;
	Tue, 11 Nov 2025 14:09:53 +0000 (UTC)
Received: from fedora (unknown [10.44.33.247])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 19CF31800576;
	Tue, 11 Nov 2025 14:09:50 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue, 11 Nov 2025 15:09:53 +0100 (CET)
Date: Tue, 11 Nov 2025 15:09:49 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Cyrill Gorcunov <gorcunov@gmail.com>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
	linux-security-module@vger.kernel.org
Subject: Re: [RFC PATCH 2/3] exec: don't wait for zombie threads with
 cred_guard_mutex held
Message-ID: <aRNDrfjKQJpPNIUo@redhat.com>
References: <AS8P193MB12851AC1F862B97FCE9B3F4FE4AAA@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
 <AS8P193MB1285FF445694F149B70B21D0E46C2@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
 <AS8P193MB1285937F9831CECAF2A9EEE2E4752@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
 <GV2PPF74270EBEEEDE0B9742310DE91E9A7E431A@GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM>
 <GV2PPF74270EBEE9EF78827D73D3D7212F7E432A@GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM>
 <aRDL3HOB21pMVMWC@redhat.com>
 <aRDMNWx-69fL_gf-@redhat.com>
 <aRHFSrTxYSOkFic7@grain>
 <aRIAEYH2iLLN-Fjg@redhat.com>
 <aRJd8Z-DrYrjRt4r@grain>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aRJd8Z-DrYrjRt4r@grain>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On 11/11, Cyrill Gorcunov wrote:
>
> Anyway while looking into patch I got wonder why
>
> +static int wait_for_notify_count(struct task_struct *tsk)
> +{
> +	for (;;) {
> +			return -EINTR;
> +		set_current_state(TASK_KILLABLE);
> +		if (!tsk->signal->notify_count)
> +			break;
>
> We have no any barrier here in fetching @notify_count? I mean updating
> this value is done under locks (spin or read/write) in turn condition
> test is a raw one. Not a big deal since set_current_state() and schedule()

Yes, so I think that, correctness-wise, this doesn't need additional barriers.

> but I've
> been a bit confused that we don't use some read_once here or something.

Yes, this needs READ_ONCE() to avoid the warnings from KCSAN. And in fact
this code was written with READ_ONCE() but I removed it before sending this
RFC.

I was going to do this later. I always forget how KCSAN works, IIUC I also
need to add WRITE_ONCE() into exit_notify() and __exit_signal() to make
KCSAN happy, even if ->notify_count is always updated under the lock.

Same for the "if (me->signal->group_exec_task == me)" check in begin_new_exec().

Right now I would like to know if this RFC (approach) makes any sense,
especially because 3/3 adds a user-visible change.

Oleg.


