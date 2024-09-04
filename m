Return-Path: <linux-kselftest+bounces-17134-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8424A96C025
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Sep 2024 16:22:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A99C1F26820
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Sep 2024 14:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 883631DCB2B;
	Wed,  4 Sep 2024 14:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dvl+nSVt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEFD91DB948
	for <linux-kselftest@vger.kernel.org>; Wed,  4 Sep 2024 14:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725459595; cv=none; b=Svu+Qn4okXS1Qy2LZ7lqQkxp/XN6uQEOk9r+Kn+4cdMt5wuZ9JYcWvEjAuEvEHnus3rlE6yvC7GhKafTOmz3gH0ggJP5sEDIPMIzyMS2rCpdzwbcUsOpimILnhfXeEH1XM5RyLVZMw5a5EQMf18vkBQIopiP4M6Y92QEQLjSDS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725459595; c=relaxed/simple;
	bh=mD9f5S4DEuGg1jzc0Ldg5GumyZEVw/s2kOOHo3uEVpw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uyB4x2jhL+67imK1mTZWP+CfQqBAvDshxsNkt+usPGmYxrLwVWz98BQnAdSQ6qeIm7JyrWVP/sA7+AhON4TPnhksu3nONPvF6I36gRcrsaERuoAaLMn/U3sPimwDJU7Nlam+lm8koPHi9bWDK02umEoLBPbVfcyS4JOOWyY+wTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dvl+nSVt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725459592;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CuCkigoYy9EvKgW0pYC+K0vaMmgbR7ffC5hTK29y7rc=;
	b=dvl+nSVtKvo9dtaY5QwUNpR11mKhdZbnQwFtPs17CJ/yc0aaKIechIxTwwSjb6J5cPVwje
	pgoWfO1UB7FhZkzKjjVgUCow/wCy9Ebsyn4YuN1lfbWSv5KSm6nVMz+uHOqEA1mYlOLVI9
	W/nEPODst5tkx4LAJWrRiCq8F3kBcyE=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-663-9AcjDj96OiSr0bCDsnzdBQ-1; Wed, 04 Sep 2024 10:19:51 -0400
X-MC-Unique: 9AcjDj96OiSr0bCDsnzdBQ-1
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-6d3aa5a672dso23692947b3.2
        for <linux-kselftest@vger.kernel.org>; Wed, 04 Sep 2024 07:19:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725459590; x=1726064390;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CuCkigoYy9EvKgW0pYC+K0vaMmgbR7ffC5hTK29y7rc=;
        b=j1qPUWahJ3a41Pl0zr6GKw7PjFAFlcxI18hBVWPckgWQu32kpZOQDi8nub5YSC+0UY
         OfBsE9+M3S4rv5f5O76rF2WDNKmhRq69VqwYJ60L/NTt2cHWvLRH2cmH82B1s1b2oSHk
         Trn3lVepon2kVkCMwtwcd3nZwpS4TDs6wg1Rd98T+O8KW9+lMNjpeHZ6SzppnCpzJwyV
         Yh0wfYIvoVERai7MRsdncfRr0lPHpnh1egJ+wAKYS9xnVcyrIUbBG88NBx4TTR+gy7Zt
         OsbjZN5p/bC5/0Y3O6t6zzCmCYwSGKuZCHZJhJGRNoy7arcT6/rhsXqsHDass0NDjMRw
         Pliw==
X-Forwarded-Encrypted: i=1; AJvYcCVSE/WBMuti+VHlUdlo57Z3tW1ak93TArWiIoHZKMkqL9z+ENoQv5Y47JYi/CoBaWSl0TrI/TVtKy9Wcb8ACgQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpPE5BEIcIrHQAM38lvDxn3JOVxVSgu87mbTyKrQmRuGdg18D2
	dD505S7VzVWirskWNEs/i+MSvaDQPLad6BLsypWTKQC45poaqv2zTa2ib/4/4QJdh/tocIdOrK5
	h7y+BReC0EuWdFb8NG5QQCIEpEfGgiE2GdtOG1IIKsCWI4TluhXL+FwKzv31XjrbLxUzTSKZw0Z
	Wz4yg/Ul8pvBn4is4XJKCNv71H0t9moSy9jNyGb0I5
X-Received: by 2002:a05:6902:168e:b0:e11:698f:8843 with SMTP id 3f1490d57ef6-e1d0e9eb2e9mr3269411276.44.1725459590487;
        Wed, 04 Sep 2024 07:19:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEsnTbfou/A8LxL0fK6QJXDt09m8CtPZdb3+3imkX+k2RU4I4bqj44gQm96hRgWPBh0aaVGuUjc3PXGEU1/6fQ=
X-Received: by 2002:a05:6902:168e:b0:e11:698f:8843 with SMTP id
 3f1490d57ef6-e1d0e9eb2e9mr3269393276.44.1725459590233; Wed, 04 Sep 2024
 07:19:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+G9fYv=v713xAFCKvkwr_0qyaQWkmfeDC2=bO7KKkui+p+ZeQ@mail.gmail.com>
In-Reply-To: <CA+G9fYv=v713xAFCKvkwr_0qyaQWkmfeDC2=bO7KKkui+p+ZeQ@mail.gmail.com>
From: Miklos Szeredi <mszeredi@redhat.com>
Date: Wed, 4 Sep 2024 16:19:39 +0200
Message-ID: <CAOssrKdc4rcjJOqBnhbRa=R5yQY1erh+KuXr_2-nGTQ-qk3vOg@mail.gmail.com>
Subject: Re: next: rcu_preempt self-detected stall on CPU - queued_spin_lock_slowpath
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: open list <linux-kernel@vger.kernel.org>, rcu <rcu@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, lkft-triage@lists.linaro.org, 
	Linux Regressions <regressions@lists.linux.dev>, yangyun50@huawei.com, 
	"Paul E. McKenney" <paulmck@kernel.org>, Zhen Lei <thunder.leizhen@huawei.com>, 
	Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 4, 2024 at 2:06=E2=80=AFPM Naresh Kamboju <naresh.kamboju@linar=
o.org> wrote:
>
> The following kernel rcu info generated while running the test case
> selftests: memfd: run_fuse_test.sh on qemu-arm64 running Linux
> next-20240902. The qemu-arm64 did not recover.
>
> This build was created with kselftest merge configs.
>
> Anders bisected this to,
>   # first bad commit:
>     [5fb9c98e9d8ddf2abc645e2dcd9eb6703f77fdab]
>     fuse: add support for no forget requests

The bad commit was reverted from -next.

Thanks,
Miklos


