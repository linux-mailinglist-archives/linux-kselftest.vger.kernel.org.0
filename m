Return-Path: <linux-kselftest+bounces-3447-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D96183A6D8
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jan 2024 11:32:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50F58B253B0
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jan 2024 10:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52FE11FBE;
	Wed, 24 Jan 2024 10:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gGFG5q7m"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B5353BA
	for <linux-kselftest@vger.kernel.org>; Wed, 24 Jan 2024 10:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706092321; cv=none; b=QzYYndS93UwHKYmJxCU7pDJhaSPlxCPQTAtY4cG9VmMeqk5siJfT+XaYnkdim8uiCkxK2LWoboSZjLYebcuKn55tTVJcujXNRLscFplvlWaN9i12elLdsCGI6PV6yKTqxa0H+/Hw2ARWQQizPfQgEzw088Zd0qMlKpASHoB2orE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706092321; c=relaxed/simple;
	bh=GHdfNJvzHjTnwM7jDAPjCZrXhElTb8flfgKGEP3WWYI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lkBSGT5rvq9+BGQ4PVJJkW5m85bqJ2BEe7N1jHSbAHxZghOt/ByFXx4Ar4Vl4tJjbTEdW6LDwWRaC+gB1tXO8BMj5ZBrtFV5RcPyV0w9uGT2540gvd/kYJdmGvHj7Jy3wfh4ockfNL8WII9iyYiF1qa/r341Mnt1sNBwOBAqB00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gGFG5q7m; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706092318;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qCe/8IPSG8wVS4DFIRLbtt63xL0H0bGljwmkzhEiv+0=;
	b=gGFG5q7mkVrDE4Qf0VcRCH+jAHqwJv7qO4tNg8LMnxUHEoI4xoYwlemxbj3i2fX9q8UoxD
	GZcE4eK4WVx0lWggfFNWuMfPBWa+q8+Stbpy591N/sbHZDDjJCMg6ZZuaWGtxaN0le41tb
	JfGON4+R/9ofwv1fpynrT18xgNo7T60=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-401-NLJGTF8UOJynom9YQYePXg-1; Wed, 24 Jan 2024 05:31:56 -0500
X-MC-Unique: NLJGTF8UOJynom9YQYePXg-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2ccc7c01bd7so38755511fa.0
        for <linux-kselftest@vger.kernel.org>; Wed, 24 Jan 2024 02:31:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706092315; x=1706697115;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qCe/8IPSG8wVS4DFIRLbtt63xL0H0bGljwmkzhEiv+0=;
        b=fBsknHj6mR77l9KiCbUjq3mV3aGZFW6J9gSRF0aIvsbiiuPMEeXphzOAPDOaj8xrQz
         D3j/rqmhucl8l6MdZiCh5s/swr2737dO59N0BXvlbfY59+7oc7tfrVDoL/dZIqRQcW1Y
         GYlBoaTQeZfDcRif69rssi/CkWUgf+wtqCMHR1pPKvVcFyftMfIqO8HZhelKCSaHXWQ1
         k37Diks2rVmdk/aKEuOnXjDPB3g/Rk36ErgyzyTAzm+xJU5M9vNgA37VBn/wbVpACU4n
         0ikCLDXbGcCPSsdyHxaFCq5pTlNRkCwetzH4rQvQp5SX2viVomCL+OKSPvf60P938l/L
         vfAg==
X-Gm-Message-State: AOJu0Yx9V0uRlZWdv0WX9CC2lxEKMw5lnTfw6oaRTP79NXsv9avT4Uff
	SPOIvBdsuQ1DTWmz4zuUx/+2xJGcBAbjTB1pqo/CRJoHpZo0HhJAXcN6LOlcfKRHjujV9lGc4+R
	FTe1gZxz6w23VZlgMrQWvz9YsrgmtAOPqVmzJi7fwz8fVs1CKF8vKybEqG2zJdvqfTlQtU44M/6
	Zu76SRbFTCk9zjsBBGWGAaWKDCsiMfzDgjLOgVXKyU
X-Received: by 2002:a05:651c:2117:b0:2cd:f914:bba7 with SMTP id a23-20020a05651c211700b002cdf914bba7mr898807ljq.34.1706092315285;
        Wed, 24 Jan 2024 02:31:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGTEUYC06RcgAw2TEdVmo8Mj1HI6Jfg1lu6NZRvL7qVAFiKge1AjNQTG9AkNhszwBBAdRhy0LAY1idh/+vhjpw=
X-Received: by 2002:a05:651c:2117:b0:2cd:f914:bba7 with SMTP id
 a23-20020a05651c211700b002cdf914bba7mr898798ljq.34.1706092315005; Wed, 24 Jan
 2024 02:31:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240123122736.9915-1-pctammela@mojatatu.com> <20240123122736.9915-3-pctammela@mojatatu.com>
 <CAKa-r6s_DO1tfcZdsQNBCwjbE0ytJKnZWnvcKqTR+5epdNq4YQ@mail.gmail.com> <7d92788b-13c5-4f53-8b58-9b6ece26310d@mojatatu.com>
In-Reply-To: <7d92788b-13c5-4f53-8b58-9b6ece26310d@mojatatu.com>
From: Davide Caratti <dcaratti@redhat.com>
Date: Wed, 24 Jan 2024 11:31:43 +0100
Message-ID: <CAKa-r6vJPGQjE4YAtofa-=Pog8a_2Tu5mGcxLjhkoGCqu0JENQ@mail.gmail.com>
Subject: Re: [PATCH net-next 2/4] selftests: tc-testing: check if 'jq' is
 available in taprio script
To: Pedro Tammela <pctammela@mojatatu.com>
Cc: netdev@vger.kernel.org, jhs@mojatatu.com, xiyou.wangcong@gmail.com, 
	jiri@resnulli.us, shuah@kernel.org, kuba@kernel.org, vladimir.oltean@nxp.com, 
	edumazet@google.com, pabeni@redhat.com, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

hello Pedro, thanks for your answer!

On Tue, Jan 23, 2024 at 5:47=E2=80=AFPM Pedro Tammela <pctammela@mojatatu.c=
om> wrote:
>
> On 23/01/2024 10:17, Davide Caratti wrote:
> > hi Pedro,
> >
> > On Tue, Jan 23, 2024 at 1:28=E2=80=AFPM Pedro Tammela <pctammela@mojata=
tu.com> wrote:
> >>
> >> If 'jq' is not available the taprio tests that use this script will
> >> run forever. Check if it exists before entering the while loop.

[...]

> > nit: what about returning $KSFT_SKIP (that is 4) if jq is not there?
> > so the test does not fail.
> > thanks!
>
> Since these scripts are run in the setup phase, it has a special treatmen=
t.
>
> Take for example this run:
> ok 1 ba39 - Add taprio Qdisc to multi-queue device (8 queues)
> ok 2 9462 - Add taprio Qdisc with multiple sched-entry
> ok 3 8d92 - Add taprio Qdisc with txtime-delay
> ok 4 d092 - Delete taprio Qdisc with valid handle
> ok 5 8471 - Show taprio class
> ok 6 0a85 - Add taprio Qdisc to single-queue device
> ok 7 3e1e - Add taprio Qdisc with an invalid cycle-time
> ok 8 39b4 - Reject grafting taprio as child qdisc of software taprio #
> skipped - "-----> prepare stage" did not complete successfully
>
> ok 9 e8a1 - Reject grafting taprio as child qdisc of offloaded taprio #
> skipped - skipped - previous setup failed 9 39b4

[...]

> As of today it returns 0, success in ksft, even though it clearly
> wasn't. Looking at the code any failures in the setup/teardown phase
> will stop the run, skip all the remaining tests but still return success.
>
> About returning skip from the script, aside from marking it as skip and
> continuing the suite, we would need to run a silent teardown, one that
> executes all commands in the specified teardown but
> ignores errors. In this case we are assuming all setup steps follow KSFT
> return codes. Not sure if it it's reasonable or not...

wouldn't this be fixed by adding this line:

"dependsOn" : "command -v jq >/dev/null"

to test scenarios 39b4 and e8a1 ? I'm asking this because jq is used
also in verifyCmd after the script, to parse results.
Background for this question: I see tdc skipping both setup and
teardown stages for each test case in taprio.json where this line:

     "dependsOn": "command -v ciao >/dev/null",

is present. Rather than doing a setup +  silent teardown, just do
nothing and go to the next test.

> As your suggestion is not a blocker, I would rather address the above
> problems in a follow up series since they will require some refactoring.
> WDYT?

no objections, but I'm curious to see if "dependsOn" would fix this case :)
thanks!
--=20
davide


