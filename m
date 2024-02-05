Return-Path: <linux-kselftest+bounces-4129-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B40784979F
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Feb 2024 11:19:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8609E1C2030B
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Feb 2024 10:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D4BE14AA2;
	Mon,  5 Feb 2024 10:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gplZNXO6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C480F168A9
	for <linux-kselftest@vger.kernel.org>; Mon,  5 Feb 2024 10:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707128352; cv=none; b=iwCFmkw8aSNqrZs2hSLq8/IPM7TvHSGfcFtxv3bWXHoKrLRwzFvWQ90/UTn2VPjjeiFRIF8DV4e7WAkbZ6sR8IXlmArxWgjojSTVR3zxX87BElJgqN53DAhNyPNA0qUul+s0/xB8Y0k6+PBQBK4YfwFO2CpMQNkzYth4xxHzvzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707128352; c=relaxed/simple;
	bh=g3cGRfrRQfifaAzqu+6P17jzpgCcdn4yyTQIo/WzczM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lo/7LC075NKQstqwDpKdrx6/3y0LBQexGrHUHF4dwCas5xtIhe0cnQqH9lwrmZIpF5eYNSHMECFYnGHeJPpCOQ3sfVo6dgDzEvGG7hUHFNicT8QTBgjBlVpDS7gkkB+FwQAul7dUvBaO4xW2KInkyOeTN7OWQCj262gZGfkgoTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gplZNXO6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707128348;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vZiCSDOMQx0r+Y6ZIinTjg4xtwQtHmbUiaCU/bhqSTk=;
	b=gplZNXO633c5dClPuWP8rQ2M9Mpb/9VBZIoAzTYBnxmynVzYMp5DerxYXL2HxnkZ8FAJfM
	bApBGwDjGkJC8V43IRArsr9GQxu4u/o9Mgam6ZvpVdjNH/b394bR2qxtG+ugBH5NVJF3AI
	TE1n3+APFFFt63Yah4YeLvZ7GOuKxXo=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-oDxWcleBPSGBOaiM6uYXWA-1; Mon, 05 Feb 2024 05:19:07 -0500
X-MC-Unique: oDxWcleBPSGBOaiM6uYXWA-1
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-6dbd919aba8so1190965b3a.0
        for <linux-kselftest@vger.kernel.org>; Mon, 05 Feb 2024 02:19:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707128346; x=1707733146;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vZiCSDOMQx0r+Y6ZIinTjg4xtwQtHmbUiaCU/bhqSTk=;
        b=EOZw2aSUdSXhsCRRsyfygMGLap2qHQJj5uTASYPDdFnT9uLVAuI3hN9QzqWKRx7luX
         DIqzFmnUZpncL9KXZ0sUwt3PIvOYzX7mh0KGpDovTxLNaueYhE322NtXfKaRfw/3qWle
         R6qAz8/XFb3qlIgrurh8B0iUQAypAnAv/TEf6xRwi/lMAnaE3HabYZPOUgnPRIMh5Vu+
         nEhAvM+doJOMKp/XFRO5HnXYIYQzYaCKTHrPsjz+59A9Dh+ktiBqxoMQqWJcroGX2E/t
         NnJ4zgpkuKtvoe0PJazVeAs+xw5Z0Krb953v2W0fzUrXeX8PIxj1rIDIY/rmfXbz2a7w
         CqeQ==
X-Forwarded-Encrypted: i=0; AJvYcCVKrHr969bGFe5TL8xADsf1eh8QTMCSq/qrCLwMNnjgjQfD1TxxlO3Vs3O1DK0n0vVJ0LxvlCh0Yt3+PSJh4yqaNzUWYgI/g5mEihufqoKg
X-Gm-Message-State: AOJu0Yz/025JYY9m/R4wJUzUMAIRAGOWMb6bVwwAoveq4+Q0EfgD8+/P
	IJ5WgMLNTFEMlK5gYXzejQ9uowsVIgF95ZO7aZump0fVRBQK7KN4FhA2Mpu0x1Jl8AcsmeYVn6r
	LB+3IWFAxnAucX3B+lS2kL54sxKqeX9xUBd6L9fnWwGn/f5SzdIlvOYWwYkAS/7m0DA==
X-Received: by 2002:a05:6a00:1d0a:b0:6e0:289e:dff1 with SMTP id a10-20020a056a001d0a00b006e0289edff1mr5974089pfx.3.1707128346147;
        Mon, 05 Feb 2024 02:19:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEZQKDRl8o/1iGPsIhVGprocCxPa5Iz8Kku4Tx6ex7yJJMOtqiMdEBAu3Ka9koR2yblb65raQ==
X-Received: by 2002:a05:6a00:1d0a:b0:6e0:289e:dff1 with SMTP id a10-20020a056a001d0a00b006e0289edff1mr5974078pfx.3.1707128345807;
        Mon, 05 Feb 2024 02:19:05 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWcOyW7mMT4wB0Jt5DexfvWge30XrJlhInrF+qP5V+8o0oxx0d7VYCrBOqMPA6WH87JS/grX1xKzzyu85Lfeai2+3Gso0RN5IKzCdXvG7crSX6WyfwNScbtmJat4fp8eIHrhcmR4T/zr1n+S+Q+GFSnSrVsoG132/o9wXxT3eyXMHuMeC18Jmfi5dTBEGFwBf9Kn+YciP/UoIfnkTTYoyx+pUbzBr8maQ==
Received: from x1n ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id n56-20020a056a000d7800b006e02f4bb4e4sm3753931pfv.18.2024.02.05.02.19.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 02:19:05 -0800 (PST)
Date: Mon, 5 Feb 2024 18:18:56 +0800
From: Peter Xu <peterx@redhat.com>
To: Shaoqin Huang <shahuang@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Shuah Khan <shuah@kernel.org>, kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] KVM: selftests: Fix the dirty_log_test semaphore
 imbalance
Message-ID: <ZcC2EJEh9lGG-WyK@x1n>
References: <20240202064332.9403-1-shahuang@redhat.com>
 <ZcCyzrUhXSlhKyqC@x1n>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZcCyzrUhXSlhKyqC@x1n>

On Mon, Feb 05, 2024 at 06:05:02PM +0800, Peter Xu wrote:
> Shaoqin, Sean,
> 
> Apologies for a late comment.  I'm trying to remember what I wrote..
> 
> On Fri, Feb 02, 2024 at 01:43:32AM -0500, Shaoqin Huang wrote:
> > Why sem_vcpu_cont and sem_vcpu_stop can be non-zero value? It's because
> > the dirty_ring_before_vcpu_join() execute the sem_post(&sem_vcpu_cont)
> > at the end of each dirty-ring test. It can cause two cases:
> 
> As a possible alternative, would it work if we simply reset all the sems
> for each run?  Then we don't care about the leftovers.  E.g. sem_destroy()
> at the end of run_test(), then always init to 0 at entry.

One more thing when I was reading the code again: I had a feeling that I
missed one call to vcpu_handle_sync_stop() for the dirty ring case:

======
@@ -395,8 +395,7 @@ static void dirty_ring_after_vcpu_run(struct kvm_vcpu *vcpu, int ret, int err)
 
        /* A ucall-sync or ring-full event is allowed */
        if (get_ucall(vcpu, NULL) == UCALL_SYNC) {
-               /* We should allow this to continue */
-               ;
+               vcpu_handle_sync_stop();
        } else if (run->exit_reason == KVM_EXIT_DIRTY_RING_FULL ||
                   (ret == -1 && err == EINTR)) {
                /* Update the flag first before pause */
======

Otherwise it'll be meaningless for run_test() to set
vcpu_sync_stop_requested for the ring test, if the ring test never reads
it..

Without about change, the test will still work (and I assume that's why
nobody noticed including myself..), but IIUC the vcpu can stop later,
e.g. until the ring fulls, or there's some leftover SIGUSR1 around.

With this change, the vcpu can stop earlier, as soon as the main thread
requested a stop, which should be what the code wanted to do.

Shaoqin, feel free to have a look there too if you're working on the test.

Thanks,

-- 
Peter Xu


