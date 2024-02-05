Return-Path: <linux-kselftest+bounces-4128-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69A4A84974D
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Feb 2024 11:05:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CB2B1C20AF1
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Feb 2024 10:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 747E4134BD;
	Mon,  5 Feb 2024 10:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OWeUTA+s"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7AB814A9D
	for <linux-kselftest@vger.kernel.org>; Mon,  5 Feb 2024 10:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707127522; cv=none; b=eHv8o0blHEQkkDRSdoMsWo7VHVh5Ql+9MgqJS7LSsehDrPFbiLseUjp/83Mk4nXRsNABEsfqTpgQOmthqCEbFVfbnRVUgRjCzSK0TuZ6PTtwv5byxGFAYTxtoOC7UE0Jm9feKCStuYUag/VhSU0dDh+Js9g1Pi64v1tAT92FYlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707127522; c=relaxed/simple;
	bh=FvTH7ce4HO+MqDVbYAWd4QDxi89r1l2keNPhU6hTSXw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oGRAps3MKbF3Y7jBNH2/nQho+zbDjGQBnHXvD8LGLy10FVuVZPX3EVDAzGO7Kegn6gZOPAU3KNuJ9YqQszw24aa3Ljh2dOXk8YqBkizhHse5+TDON7Eu4Qub0lliN1ljKnufzduZu6BaW51yGqGjinFXUDVNpB4PtvhAVwioXhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OWeUTA+s; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707127520;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jI4PbEn5bcHDGLMbu+52VQdT8MjOytUlCwJj0kXdfq0=;
	b=OWeUTA+slwMBVNLZKhxq7VU96lHv0+aiVGEPimDpfRxWBrPPt1wuDGPcWU/c1cWrOSG4EX
	fQufQm/3Dj++8pEGnQfjlaKGQ/b97ZJZRgkNiB++iEq+yj0kYR0sjR+eW+2dZ3ER5Uhbg+
	h3QuQ4F9UoUjh+7NS3DXfwIkTlIYh40=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-zpsbcRdYNxq423sMnKBJOw-1; Mon, 05 Feb 2024 05:05:18 -0500
X-MC-Unique: zpsbcRdYNxq423sMnKBJOw-1
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-59a5911a619so1143077eaf.0
        for <linux-kselftest@vger.kernel.org>; Mon, 05 Feb 2024 02:05:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707127517; x=1707732317;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jI4PbEn5bcHDGLMbu+52VQdT8MjOytUlCwJj0kXdfq0=;
        b=fLQ6o5rzOfA6VUgbw+Z57yqq5BsDdkILO+VUKzqrjf0plK2Yv3VhQ+51W7cit5PVeo
         oudM2lVBe60eAOqK2fbYkdbaGQRBP+wOV2ZXOt2EZyCG1Li5icycd2mOmecIfR4yYWcE
         K/2xA2XJmqUQarMHu3dEsAt50Nnd/z6xARGFCKoSVB4NBqGhhEqnezo4sRlW9BDAi2oi
         yuL0FEKaIwnw9yCAtVJdnlXcUQQfQTIJs6xmCCD2o4D0Uq0brNLUYy2uRF0pLVlhZH6T
         2vrK/I0ErmQnIlVyEHEW9xWBh0/ruUDUxwTUTEt0HERzO1vAZyOB+tx+6l1IVd2k/kmb
         bWmg==
X-Gm-Message-State: AOJu0YxkPiDgH8pADa5GiZaRsXoGN4JkIC1Npe+m/NWQwMvdgyiKz6zr
	x/8nAErjTQmUwAUwYosjmJ1VwUH8BjmYCZlNgskqk2YF209Vx83WZTUS/x2rOm8pC9yOuS4Gpil
	a6+MCw9HD44MbOSPZavvPJDWR3xcue4sIwPEenW9fhpbjKbkt7QeqcAtOdetd4imc/Q==
X-Received: by 2002:a05:6358:7f05:b0:178:8c44:aa8b with SMTP id p5-20020a0563587f0500b001788c44aa8bmr11609007rwn.3.1707127517662;
        Mon, 05 Feb 2024 02:05:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFiFWsiQYdb+lDxJj9dP1Ofli+cct1oipaMqfiulBEkAd5tnxRnsurpAwy4aMkIYd4YQ/WWQQ==
X-Received: by 2002:a05:6358:7f05:b0:178:8c44:aa8b with SMTP id p5-20020a0563587f0500b001788c44aa8bmr11608992rwn.3.1707127517378;
        Mon, 05 Feb 2024 02:05:17 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWoh+GzuRpjT9/ChYsEcK+q66hd4k8A3L/hx8CrGu0JVnDMkwpxykxZvzLQm56gLNHyyW2QTFnYegJxMsbcIVEXxSfXKKkWFO2nSjmi1/GPommUPYVDwDhPiiERdZpNku0MKXfJPD+LZq3Huot7R9CzYHxOgBN/+jWfnVymDFMMLyV3b2ftw/Z9fst/RoIahjBqxzjK59flIllJIPhksB8/CkqDPhUVsg==
Received: from x1n ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id r9-20020aa78449000000b006e050c8f22bsm230160pfn.207.2024.02.05.02.05.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 02:05:16 -0800 (PST)
Date: Mon, 5 Feb 2024 18:05:02 +0800
From: Peter Xu <peterx@redhat.com>
To: Shaoqin Huang <shahuang@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Shuah Khan <shuah@kernel.org>, kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] KVM: selftests: Fix the dirty_log_test semaphore
 imbalance
Message-ID: <ZcCyzrUhXSlhKyqC@x1n>
References: <20240202064332.9403-1-shahuang@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240202064332.9403-1-shahuang@redhat.com>

Shaoqin, Sean,

Apologies for a late comment.  I'm trying to remember what I wrote..

On Fri, Feb 02, 2024 at 01:43:32AM -0500, Shaoqin Huang wrote:
> Why sem_vcpu_cont and sem_vcpu_stop can be non-zero value? It's because
> the dirty_ring_before_vcpu_join() execute the sem_post(&sem_vcpu_cont)
> at the end of each dirty-ring test. It can cause two cases:

As a possible alternative, would it work if we simply reset all the sems
for each run?  Then we don't care about the leftovers.  E.g. sem_destroy()
at the end of run_test(), then always init to 0 at entry.

-- 
Peter Xu


