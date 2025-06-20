Return-Path: <linux-kselftest+bounces-35409-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0577AE1537
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Jun 2025 09:49:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B35417C0CC
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Jun 2025 07:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A3FA22E40F;
	Fri, 20 Jun 2025 07:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yzl19JMI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F5222D4CE
	for <linux-kselftest@vger.kernel.org>; Fri, 20 Jun 2025 07:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750405767; cv=none; b=glO344hgl9Qlhw1JC6XDQEsmzJ2UokUKkpVuvZwz+cuMUa/1vwtQS9rIQgCCPurKUGCnUNlk0MjGKIMwdlOMGlz2wGeeHA4oHxVFNiCnI/oPVSz+o/8Na0tbX1OEdwGEJfZrCcSExP3YD2NBoGCEQ3/fkCsP08UlD1gBhVFr+zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750405767; c=relaxed/simple;
	bh=lPTn097d3RKmYQXcQJXHtz90CBTGa1mOLWU8ZI0qkp8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pJ144fJ23nIQIbCJ+ArdMEtKsgeiQFt2q71ZKqCXjsLk6xopR1GZekqHYFjJWSkygh4Q+GcpqzxvqKeIUTvhh1v1d4MyYR6yrVs0t8As0py3Zs/pdcL3oZAcB9I+P+Z01cyIZOo3O++qaJCGDLEdTAQwQ5883yu2yyKqeKdtbqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Yzl19JMI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750405764;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8/NfKHQF9oEI9qiwLXTW6bFDUNC1qeYOK5nIoYRGjPo=;
	b=Yzl19JMIY5R14RaRYubJV+78OEkgc0EwUAINugJyMGuDWanK89ac8gFMOd1mWQRdvGggA/
	hDN2eA21a2zwwAt+9Xrdp91M7hP3bf0C11Phu5ytWHKnd27FXIagXx+YsEHlMi80eAVx1V
	mW2ZkwsX4UwTJS34UszRG/z+s35ZBM4=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-346-riOtmTfFN1yg65hnfFIRIg-1; Fri, 20 Jun 2025 03:49:22 -0400
X-MC-Unique: riOtmTfFN1yg65hnfFIRIg-1
X-Mimecast-MFC-AGG-ID: riOtmTfFN1yg65hnfFIRIg_1750405761
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-553addbf0beso776659e87.2
        for <linux-kselftest@vger.kernel.org>; Fri, 20 Jun 2025 00:49:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750405761; x=1751010561;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8/NfKHQF9oEI9qiwLXTW6bFDUNC1qeYOK5nIoYRGjPo=;
        b=OMLDJySms7jh36lIyQvVFsbWUKhPLUR1xjyyM3oVoKeZaBXXMy5T1kBqtSFy7sN8PX
         /ReBQO/UTrnLGHh3AA4N6GWN45PZLcJ5bpcVo6SL4Thu4uw9p/pW78Vn+4sSAXgqtixO
         qhDbCfaU6/sq8Vo6jy5YcHzKVfDnjm88zYBqke3YLb9vtIzSrHfQ0MZBLXIoy9aC4wLE
         /O39lyP95G4/3U56x8gp+3xWzx4obeHNze01HtUA3Ab1iJmlbxYUu9s9ShBSfYQRIikZ
         +NljK4kq7Upe0Y1ZIG9ITcU1XAhqeYprLCkjtiHEnyqxFEAbC0V+B2VYAb/FymXezi4O
         NSUA==
X-Forwarded-Encrypted: i=1; AJvYcCVYarIln7j3G+cid8mqiFuH4uPpW4YqQX7g/3W5V9S5I0JFvg6auOVwGX9kX8U0QMbzJsL9cTn7x6AK0Tk1jd0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwczEG+srSHb0EQ+4pv51r6VxZ8qpwlenZn9iOyfLdwhJxIKsV4
	HYhG4Vcq/pq+X08KUASQ8cTNRlN8gi+NwC2f48+FDhorpz1ocQIRevlUZhZ90rVEBHz/aRPR6B8
	ozJDg6Lip73kJTAIAJj2Kl3I6g494OtsWSIBBAWIHk3gTnQ0+/imxwXtOjly5KYJMQ6tCpg==
X-Gm-Gg: ASbGnctK758h+tqcHBVSHzRTTU3Qtx1ClbhttzTAkCtIqafwnobkF76YObEiMTdTk8v
	LNDewBSvsLRAI1s01MxSWwePonAwCH9VZvm87WHctcMLz48FkjVW87eQnOWC/zYjR1RjbGZn5y8
	pZbe72nz6+RNfD1ci2hm+ttvdDWq9EoTN6sietDg2Q2ib+04xSZdYwDhE8rotT+NCJBDm8pOMO0
	6soFsLUmhOC3m9qXFw5T1EhFkwKW507OXytBiYzfW7i0zv8Q7bPue8q1nTUwu2Xq9Puufnex5NO
	j/aEWMVUlof1Mrzdr38=
X-Received: by 2002:a05:6512:1323:b0:553:accf:d75 with SMTP id 2adb3069b0e04-553e3cfdb6bmr549357e87.26.1750405761124;
        Fri, 20 Jun 2025 00:49:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGLy5SMi0UipUNre443G7f4CTQNRiybWOKExd4GM5/+BAIumn05sVzdmmKiq+TDs10cab3gRg==
X-Received: by 2002:a05:6512:1323:b0:553:accf:d75 with SMTP id 2adb3069b0e04-553e3cfdb6bmr549341e87.26.1750405760660;
        Fri, 20 Jun 2025 00:49:20 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-553e41bbdcesm187600e87.116.2025.06.20.00.49.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jun 2025 00:49:19 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id A6FAA1B372DF; Fri, 20 Jun 2025 09:49:18 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Mina Almasry <almasrymina@google.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Mina Almasry <almasrymina@google.com>
Subject: Re: [PATCH net-next v5] page_pool: import Jesper's page_pool benchmark
In-Reply-To: <20250619181519.3102426-1-almasrymina@google.com>
References: <20250619181519.3102426-1-almasrymina@google.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Fri, 20 Jun 2025 09:49:18 +0200
Message-ID: <87ecvezwch.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Mina Almasry <almasrymina@google.com> writes:

> From: Jesper Dangaard Brouer <hawk@kernel.org>
>
> We frequently consult with Jesper's out-of-tree page_pool benchmark to
> evaluate page_pool changes.
>
> Import the benchmark into the upstream linux kernel tree so that (a)
> we're all running the same version, (b) pave the way for shared
> improvements, and (c) maybe one day integrate it with nipa, if possible.
>
> Import bench_page_pool_simple from commit 35b1716d0c30 ("Add
> page_bench06_walk_all"), from this repository:
> https://github.com/netoptimizer/prototype-kernel.git
>
> Changes done during upstreaming:
> - Fix checkpatch issues.
> - Remove the tasklet logic not needed.
> - Move under tools/testing
> - Create ksft for the benchmark.
> - Changed slightly how the benchmark gets build. Out of tree, time_bench
>   is built as an independent .ko. Here it is included in
>   bench_page_pool.ko
>
> Steps to run:
>
> ```
> mkdir -p /tmp/run-pp-bench
> make -C ./tools/testing/selftests/net/bench
> make -C ./tools/testing/selftests/net/bench install INSTALL_PATH=3D/tmp/r=
un-pp-bench
> rsync --delete -avz --progress /tmp/run-pp-bench mina@$SERVER:~/
> ssh mina@$SERVER << EOF
>   cd ~/run-pp-bench && sudo ./test_bench_page_pool.sh
> EOF
> ```
>
> Note that by default, the Makefile will build the benchmark for the
> currently installed kernel in /lib/modules/$(shell uname -r)/build. To
> build against the current tree, do:
>
> make KDIR=3D$(pwd) -C ./tools/testing/selftests/net/bench
>
> Output (from Jesper):
>
> ```
> sudo ./test_bench_page_pool.sh
> (benchmark dmesg logs snipped)
>
> Fast path results:
> no-softirq-page_pool01 Per elem: 23 cycles(tsc) 6.571 ns
>
> ptr_ring results:
> no-softirq-page_pool02 Per elem: 60 cycles(tsc) 16.862 ns
>
> slow path results:
> no-softirq-page_pool03 Per elem: 265 cycles(tsc) 73.739 ns
> ```
>
> Output (from me):
>
> ```
> sudo ./test_bench_page_pool.sh
> (benchmark dmesg logs snipped)
>
> Fast path results:
> no-softirq-page_pool01 Per elem: 11 cycles(tsc) 4.177 ns
>
> ptr_ring results:
> no-softirq-page_pool02 Per elem: 51 cycles(tsc) 19.117 ns
>
> slow path results:
> no-softirq-page_pool03 Per elem: 168 cycles(tsc) 62.469 ns
> ```
>
> Results of course will vary based on hardware/kernel/configs, and some
> variance may be there from run to run due to some noise.
>
> Cc: Jesper Dangaard Brouer <hawk@kernel.org>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk>
>
> Signed-off-by: Mina Almasry <almasrymina@google.com>
> Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>


