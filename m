Return-Path: <linux-kselftest+bounces-18183-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DD0E97D9A4
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Sep 2024 20:45:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E156D284DAB
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Sep 2024 18:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D1EE17E44A;
	Fri, 20 Sep 2024 18:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fkU15YLr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA0733997
	for <linux-kselftest@vger.kernel.org>; Fri, 20 Sep 2024 18:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726857900; cv=none; b=FyU4TiVYSK8/6UpjZn96UYl1jNd5Wn/KBs3FkMlJddEqSpi+kanGaYbiZW5VnV1YqWrLn455Wg42Q+MZMeuEI8v9+D8r7TjhCEv1KBERr47z/3l8uUKCz7EfpSIb9KA+JnFkKjP/pAoUEY8O+LAORO8ZjHhc4xzee9kwJemWNjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726857900; c=relaxed/simple;
	bh=OtF6VKrg03zgPhVwWw7oJZrm/D8p5dfiYhMJYMK9XQA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HGMj4Lhs++NxJczuMHo3/MkTG0OnjoZDZAsXHairZoGRuXPDIk2XR9wTHdCe/f5Fd+vrglnenZ7p8GJRNJDhOy3fbOudyhubYD6Mkg/OqgOpAUiE+GRMwS+qF6GvnV3cs2xehGFMzUhSu2aeufSuyxL/n1IG4mxNPiaa2XmF7m0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fkU15YLr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726857897;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OtF6VKrg03zgPhVwWw7oJZrm/D8p5dfiYhMJYMK9XQA=;
	b=fkU15YLrGsaeSFl0WneTFtMMLbCANwfsb/2Yd1UOsA+b8yCW0uCPHuh7zN9++k1QQiU2R/
	UDW81XZSNyPTOUVE4+ZZR7nGGRyUg8Pv7kdV6eBxzoNTTXooEbjCgotDcU8HjEwfNUxq+s
	pldhQZMBGnC50Q7cBA9JYecIY2KwwLg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-103--qs-qLPXNyyFv5sqglakNw-1; Fri,
 20 Sep 2024 14:44:54 -0400
X-MC-Unique: -qs-qLPXNyyFv5sqglakNw-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (unknown [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1972F1933B79;
	Fri, 20 Sep 2024 18:44:52 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.115])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 829671956086;
	Fri, 20 Sep 2024 18:44:44 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri, 20 Sep 2024 20:44:39 +0200 (CEST)
Date: Fri, 20 Sep 2024 20:44:31 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Anjali Kulkarni <anjali.k.kulkarni@oracle.com>
Cc: "davem@davemloft.net" <davem@davemloft.net>,
	Liam Howlett <liam.howlett@oracle.com>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>,
	"brauner@kernel.org" <brauner@kernel.org>,
	"mhocko@suse.com" <mhocko@suse.com>,
	"alexjlzheng@tencent.com" <alexjlzheng@tencent.com>,
	"willy@infradead.org" <willy@infradead.org>,
	Michael Christie <michael.christie@oracle.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"shuah@kernel.org" <shuah@kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	Pei Li <peili.io@oracle.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH net-next 1/2] connector/cn_proc: Handle threads for proc
 connector
Message-ID: <20240920184430.GB20847@redhat.com>
References: <20240920000933.185090-1-anjali.k.kulkarni@oracle.com>
 <20240920000933.185090-2-anjali.k.kulkarni@oracle.com>
 <20240920110022.GA15795@redhat.com>
 <72426AB7-DAF9-4779-A29E-EA5FF8816695@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <72426AB7-DAF9-4779-A29E-EA5FF8816695@oracle.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On 09/20, Anjali Kulkarni wrote:
>
> > On Sep 20, 2024, at 4:00 AM, Oleg Nesterov <oleg@redhat.com> wrote:
> >
> > I don't think you can use task_struct->exit_code. If this task is ptraced,
> > it can be changed/cleared in, say, ptrace_stop() after PROC_CN_MCAST_NOTIFY.
> >
>
> Thank you, that’s a good point! However, the use case of ptrace, which I assume
> is for mostly debug and tracing, is exclusive of the use case I am using it for

Well. I don't understand your use-case. Or any other use-case for drivers/connector/
that I know nothing about. But this is irrelevant.

The new PROC_CN_MCAST_NOTIFY functionality you propose should work regardless of
whether this task is ptraced or not. But it doesn't because the usage of ->exit_code
in your patch conflicts with the current usage of this field.

So, NACK, sorry.

Oleg.


