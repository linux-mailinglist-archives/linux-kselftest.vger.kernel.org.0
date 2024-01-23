Return-Path: <linux-kselftest+bounces-3403-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B24F3838D50
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jan 2024 12:21:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 393251F29115
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jan 2024 11:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 055335D745;
	Tue, 23 Jan 2024 11:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B6cjB/2L"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C525D72F
	for <linux-kselftest@vger.kernel.org>; Tue, 23 Jan 2024 11:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706008847; cv=none; b=Iny7QXh9wCQcJ9nKn6HhWHqNKKsvAtODN7ktHkISYd6uDH2jJEj8zUTeo/AK103acl1Ba/uGPq4gITc1ilAlBQj2zIBD4BHzjdYOpMQu3kQjTsOcUXCoXYGvBkYVDNhTfPU+1x0xdBwNesfAkjegaIwW+2cTekyDxnIjr0GckBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706008847; c=relaxed/simple;
	bh=3WmOUGNWT+pIH3cj07dWCAKXanhkJc4EVblQcDQpCHI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=J/EimBtKTiJaeM2U9gxOMDNwiNlx2j/nYTIOMW+Cqr7pYAczRWv9Z6ietJwHiGkM8T3hn1pCGAjGv3Sag4FjXaN2uyC/bFNHrGWtsL7E3xUPXZebKXd71MB80bBf+uSWpz6hiTC9VWWnzfwpUInxkSJoskyhHGYFgCyk8LYdliM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B6cjB/2L; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706008845;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=3WmOUGNWT+pIH3cj07dWCAKXanhkJc4EVblQcDQpCHI=;
	b=B6cjB/2LpMskypf6/h69jSGlchax4rOTIUvWpGrthk9H51gFenXp+G875PFEKIGcwyl8f8
	mOJy7mSuo+98VX4qAMLmUq3HJj+Wt4Svr4xEuWZ/FeLGNt03MMcAmnMx3RVyebGMPYIUkc
	HYQD9pqo1NkR0Omw2cWrtclO3p6bc6g=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-OeT8NNWUO_-apSf0DF8W1g-1; Tue, 23 Jan 2024 06:20:44 -0500
X-MC-Unique: OeT8NNWUO_-apSf0DF8W1g-1
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-6df4fad9a6dso1322411a34.0
        for <linux-kselftest@vger.kernel.org>; Tue, 23 Jan 2024 03:20:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706008843; x=1706613643;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3WmOUGNWT+pIH3cj07dWCAKXanhkJc4EVblQcDQpCHI=;
        b=BqPo6iTprKHvdu/lQt0MaiE/PwWcI80H04mypMgxI5drJMIC0nE5r7kZJOtDVloAAJ
         RoS+HOq+vOMJ6xqUQthDVyj8TAZeABGw6NXGXsqiBqOimq6mmnwEllW14MwI5OngfoJL
         nna3bW0xUv1MO8Y590mpPkwIgpNEojG6CoQcR1/wWGmmFAM27sqinltVCFVrTFXi/BZZ
         bRkmW1jWw6TMJD0pFNUKkBCx7T+OROoCcb7kIfU6Z3Ol37cNp19THb3MacQM8iAT3UtO
         HxldvvI5LhL9+Mte+NMB6aSu2ET4jKKJxB32gEdwJ8+kAAGc0Bznr9ANQbSEDvTtCemW
         TmJg==
X-Gm-Message-State: AOJu0YwnbtyVqY3xkggK3BLynPzG8Hrvu0wVN80MEjU9X8UaYjBmMgfr
	Iwvq9K/vAkK6jgm74zqC5qV/Cx3rMhNzTOimkOutu+VwMs3aD2xxVwUKFAzQ27Pq+0pMWVOuzJ9
	cXi3RzPjbuwC6YE9Got3zAsc8Qf7txKxoSaooZ3/wkFsYAQ2gbcrrzCKwhWlHTtemDg==
X-Received: by 2002:a05:6830:34aa:b0:6dc:6a7:857d with SMTP id c42-20020a05683034aa00b006dc06a7857dmr11412889otu.1.1706008843463;
        Tue, 23 Jan 2024 03:20:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFhC0XJtyC1wujZZKiOikk7SUbsCYqJ34/Qhr6ckzRck2bhIAEJrmOiE0bPr12etnSABf6IOQ==
X-Received: by 2002:a05:6830:34aa:b0:6dc:6a7:857d with SMTP id c42-20020a05683034aa00b006dc06a7857dmr11412869otu.1.1706008843085;
        Tue, 23 Jan 2024 03:20:43 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-245-66.dyn.eolo.it. [146.241.245.66])
        by smtp.gmail.com with ESMTPSA id ka18-20020a05622a441200b0042994016b68sm3378750qtb.71.2024.01.23.03.20.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 03:20:42 -0800 (PST)
Message-ID: <bdca9e023993b56fef0a6bd1b0bf65b5cdeaa488.camel@redhat.com>
Subject: Re: [PATCH net] selftests/net/lib: update busywait timeout value
From: Paolo Abeni <pabeni@redhat.com>
To: Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>,  Eric Dumazet <edumazet@google.com>, Shuah Khan
 <shuah@kernel.org>, David Ahern <dsahern@kernel.org>, 
 linux-kselftest@vger.kernel.org
Date: Tue, 23 Jan 2024 12:20:39 +0100
In-Reply-To: <20240122090544.1202880-1-liuhangbin@gmail.com>
References: <20240122090544.1202880-1-liuhangbin@gmail.com>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-01-22 at 17:05 +0800, Hangbin Liu wrote:
> The busywait timeout value is a millisecond, not a second. So the
> current setting 2 is meaningless. Let's copy the WAIT_TIMEOUT from
> forwarding/lib.sh and set a BUSYWAIT_TIMEOUT here.
>=20
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> ---
> Not sure if the default WAIT_TIMEOUT 20s is too large. But since
> we usually don't need to wait for that long. I think it's OK to
> stay the same value with forwarding/lib.sh. Please tell me if you
> think we need to set a more proper value.
>=20
> BTW, This doesn't look like a fix. But also not a feature. So I just
> post it to net tree.

I think the 20s max timeout is fine.

I also think this is really a fix: on slow/busy host (or VMs) the
current timeout can expire even on "correct" execution, causing random
failures. We had a lot of similar case in the mptcp self-tests in the
past.

Could you please send a v2 with a suitable fixes tag and an update
changelog to point out the possible failures?

Thanks!

Paolo



