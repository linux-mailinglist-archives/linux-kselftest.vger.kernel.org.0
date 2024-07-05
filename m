Return-Path: <linux-kselftest+bounces-13241-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7253C928A52
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Jul 2024 15:59:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0073D1F214C4
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Jul 2024 13:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52D8D15F406;
	Fri,  5 Jul 2024 13:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F6+AJlRB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33CCA15EFC6
	for <linux-kselftest@vger.kernel.org>; Fri,  5 Jul 2024 13:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720187945; cv=none; b=kVJd5jpypDSvQAMzxKa2mi+T9kyUoJoolc5o9k0GxJKCXIQKKwgM6xY0Ff3F0ahqCIZvHJSdVqgntCr/+r+RLgxQGtcKRFVATfGlwKHvML/1rS0LWe4ZXG8EoHI4E2DS6BLGhzetYN1X/jsrRDh29EvIPjmR5BWRtlGe7CnQdX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720187945; c=relaxed/simple;
	bh=RLXSKNHuBVf4L8Kp3ll82O5oP8sGTnsxz6d/cdxxx80=;
	h=From:References:MIME-Version:In-Reply-To:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GDDUnP6reSt58wM4WDTb4nMaRPVGBmnU0lvZRW2k89wbfn2OpKsA5Yur+y90CPMX9B36xOj267g6EWo5UAnPOnozWld5XkhRm/fLN4cmCajGwCyiuMsyWFO3BG3su5IgodLhEwK4QdCwzpgsgr5Bl/Mm3Yhczgs/xJy9RzZA8nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F6+AJlRB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720187941;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cNaOkePJhRVjo4IB8Lzm4YmySGjwEPGfiNUriyZhZvw=;
	b=F6+AJlRB6ks35Ms4sjMEcMLlZ30OPMWPHcKXWktNYlWzM9pWiSHtTUuhsMrv50KTksGR7T
	gURnaY+0tlfo7TRhDZzFIIBayu9oPgzBCpToyHcj/aSeNAdpornTT8t+Ofio7qenCwtCTc
	rZSkdx9JTEEGPauB6sdwxzbXhYeFLH0=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-257-y4xU2z36OM-cZpP7R22CBg-1; Fri, 05 Jul 2024 09:58:58 -0400
X-MC-Unique: y4xU2z36OM-cZpP7R22CBg-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6b5ebdd8109so21553706d6.0
        for <linux-kselftest@vger.kernel.org>; Fri, 05 Jul 2024 06:58:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720187937; x=1720792737;
        h=content-transfer-encoding:cc:to:subject:message-id:date:in-reply-to
         :mime-version:references:from:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cNaOkePJhRVjo4IB8Lzm4YmySGjwEPGfiNUriyZhZvw=;
        b=laJyEGMrIXBF/oLs1SZDPjMwCzrOFAy/FILaFhknx/I0Z8LEH3aknoHTT5ja6tc/iG
         hQzpBpdJ8PjbigySXRLiJoQBvK7frRYRxcWuUI6vxtwm2BteVcM91GbjJxpdbxwnGFHf
         YXDLt2EDxYxtyaPveFzzFULkRWGobNdt3EVPql3fDRqTukLaUEgk3vw0cOEyad0qzeXS
         Q017t/CM4hCsCVY16ai8jtCKjTzQKXd/C56eq5HUvB/viFxU1pVjFXy83lzbuXbfKqKl
         H4wBXV2dewk0I+uTglcBbZ6u3ZsbNUANuBKIo79r/fcQsJ9XmHgl/utYW6DImKpHGEm2
         /Fng==
X-Forwarded-Encrypted: i=1; AJvYcCUOBFZMPnGVvMj21sCvFt0XV/Co88vtta7AEUuZZwvMY7wyholMYHLdpuDiK3ifNMDqyOIFP/shTRySwuTFbaF9oXmNE/RcPIy04pJRLuR8
X-Gm-Message-State: AOJu0Yx+CUZOOwIhiZKuVK/Uqw/uVtQs68ORvjw89MjZAa4ogHueIHNV
	NRYNVVB3010nVsONPv2xf/rdWN4KDAUMbraNgIrh+XIS4Cpwok8gpVbry8Io2CBFMfdyUa8Mh0R
	mlw3CVoJAjPbQPA1lEjUi57jPEpMSVcfLhS33yBtINBlRU3HFs0nheon8s7yB26zSi+Q3rE6Gd6
	ESUer/yks/gMFl6AX5GRtwRS+IimGeM7/fr0s7NO5O
X-Received: by 2002:a05:6214:19cc:b0:6b2:b340:1614 with SMTP id 6a1803df08f44-6b5ecfb8bafmr67254096d6.23.1720187937661;
        Fri, 05 Jul 2024 06:58:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFJsW3TO3iK+hq8UQyEes9HY+JOlLKSJmmHe60O3DDPtiBXhblESH69gg+ijLDag7g+Pf1hpYiQ5UJTse+hMv4=
X-Received: by 2002:a05:6214:19cc:b0:6b2:b340:1614 with SMTP id
 6a1803df08f44-6b5ecfb8bafmr67253886d6.23.1720187937308; Fri, 05 Jul 2024
 06:58:57 -0700 (PDT)
Received: from 311643009450 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 5 Jul 2024 13:58:56 +0000
From: =?UTF-8?Q?Adri=C3=A1n_Moreno?= <amorenoz@redhat.com>
References: <20240704085710.353845-1-amorenoz@redhat.com> <f73l6iiysjulc6eb2j3gm7ng4gkpe2uebnjiaun4fhhaogyp23@u3hi32mc4jvb>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <f73l6iiysjulc6eb2j3gm7ng4gkpe2uebnjiaun4fhhaogyp23@u3hi32mc4jvb>
Date: Fri, 5 Jul 2024 13:58:56 +0000
Message-ID: <CAG=2xmP0X2pYZN5OBsiPHzhC8fm_5A0SnHFaPuq3KjJdYU9Qng@mail.gmail.com>
Subject: Re: [PATCH net-next v9 00/10] net: openvswitch: Add sample multicasting.
To: netdev@vger.kernel.org
Cc: kuba@kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 05, 2024 at 11:49:28AM GMT, Adri=C3=A1n Moreno wrote:
> On Thu, Jul 04, 2024 at 10:56:51AM GMT, Adrian Moreno wrote:
> > ** Background **
> > Currently, OVS supports several packet sampling mechanisms (sFlow,
> > per-bridge IPFIX, per-flow IPFIX). These end up being translated into a
> > userspace action that needs to be handled by ovs-vswitchd's handler
> > threads only to be forwarded to some third party application that
> > will somehow process the sample and provide observability on the
> > datapath.
> >
> > A particularly interesting use-case is controller-driven
> > per-flow IPFIX sampling where the OpenFlow controller can add metadata
> > to samples (via two 32bit integers) and this metadata is then available
> > to the sample-collecting system for correlation.
> >
> > ** Problem **
> > The fact that sampled traffic share netlink sockets and handler thread
> > time with upcalls, apart from being a performance bottleneck in the
> > sample extraction itself, can severely compromise the datapath,
> > yielding this solution unfit for highly loaded production systems.
> >
> > Users are left with little options other than guessing what sampling
> > rate will be OK for their traffic pattern and system load and dealing
> > with the lost accuracy.
> >
> > Looking at available infrastructure, an obvious candidated would be
> > to use psample. However, it's current state does not help with the
> > use-case at stake because sampled packets do not contain user-defined
> > metadata.
> >
> > ** Proposal **
> > This series is an attempt to fix this situation by extending the
> > existing psample infrastructure to carry a variable length
> > user-defined cookie.
> >
> > The main existing user of psample is tc's act_sample. It is also
> > extended to forward the action's cookie to psample.
> >
> > Finally, a new OVS action (OVS_SAMPLE_ATTR_PSAMPLE) is created.
> > It accepts a group and an optional cookie and uses psample to
> > multicast the packet and the metadata.
> >
> > --
> > v8 -> v9:
> > - Rebased.
> >
> > v7 -> v8:
> > - Rebased
> > - Redirect flow insertion to /dev/null to avoid spat in test.
> > - Removed inline keyword in stub execute_psample_action function.
> >
> > v6 -> v7:
> > - Rebased
> > - Fixed typo in comment.
> >
> > v5 -> v6:
> > - Renamed emit_sample -> psample
> > - Addressed unused variable and conditionally compilation of function.
> >
> > v4 -> v5:
> > - Rebased.
> > - Removed lefover enum value and wrapped some long lines in selftests.
> >
> > v3 -> v4:
> > - Rebased.
> > - Addressed Jakub's comment on private and unused nla attributes.
> >
> > v2 -> v3:
> > - Addressed comments from Simon, Aaron and Ilya.
> > - Dropped probability propagation in nested sample actions.
> > - Dropped patch v2's 7/9 in favor of a userspace implementation and
> > consume skb if emit_sample is the last action, same as we do with
> > userspace.
> > - Split ovs-dpctl.py features in independent patches.
> >
> > v1 -> v2:
> > - Create a new action ("emit_sample") rather than reuse existing
> >   "sample" one.
> > - Add probability semantics to psample's sampling rate.
> > - Store sampling probability in skb's cb area and use it in emit_sample=
.
> > - Test combining "emit_sample" with "trunc"
> > - Drop group_id filtering and tracepoint in psample.
> >
> > rfc_v2 -> v1:
> > - Accommodate Ilya's comments.
> > - Split OVS's attribute in two attributes and simplify internal
> > handling of psample arguments.
> > - Extend psample and tc with a user-defined cookie.
> > - Add a tracepoint to psample to facilitate troubleshooting.
> >
> > rfc_v1 -> rfc_v2:
> > - Use psample instead of a new OVS-only multicast group.
> > - Extend psample and tc with a user-defined cookie.
> >
> > Adrian Moreno (10):
> >   net: psample: add user cookie
> >   net: sched: act_sample: add action cookie to sample
> >   net: psample: skip packet copy if no listeners
> >   net: psample: allow using rate as probability
> >   net: openvswitch: add psample action
> >   net: openvswitch: store sampling probability in cb.
> >   selftests: openvswitch: add psample action
> >   selftests: openvswitch: add userspace parsing
> >   selftests: openvswitch: parse trunc action
> >   selftests: openvswitch: add psample test
> >
> >  Documentation/netlink/specs/ovs_flow.yaml     |  17 ++
> >  include/net/psample.h                         |   5 +-
> >  include/uapi/linux/openvswitch.h              |  31 +-
> >  include/uapi/linux/psample.h                  |  11 +-
> >  net/openvswitch/Kconfig                       |   1 +
> >  net/openvswitch/actions.c                     |  66 ++++-
> >  net/openvswitch/datapath.h                    |   3 +
> >  net/openvswitch/flow_netlink.c                |  32 ++-
> >  net/openvswitch/vport.c                       |   1 +
> >  net/psample/psample.c                         |  16 +-
> >  net/sched/act_sample.c                        |  12 +
> >  .../selftests/net/openvswitch/openvswitch.sh  | 115 +++++++-
> >  .../selftests/net/openvswitch/ovs-dpctl.py    | 272 +++++++++++++++++-
> >  13 files changed, 566 insertions(+), 16 deletions(-)
> >
> > --
> > 2.45.2
> >
>
> Hi,
>
> Simon Horman has spotted that openvswitch.sh tests are failing in the
> debug executor:
>
> https://netdev.bots.linux.dev/contest.html?test=3Dopenvswitch-sh
>
> The failing tests are two: psample and upcall_interfaces. These two
> tests have a known source of instability (they use "sleep") that make
> them specially unreliable in slow systems.
>
> Aaron and I already discussed this and I'm working on a patch to make
> both tests more robust by adding a wait-and-retry mechanism.
>
> I hope this series can be considered regardless of this flaky tests.
>

Adding more context to explain our situation.

This series has a counterpart in OVS [1]. The state of this other series
is still RFC just because the kernel bits have not yet been merged.

OVS 3.4 "softfreeze" was declared last monday, which excludes from the
release any series that is stil in RFC state.
Given the kernel parts seemed very close to be merged, an exception was
given to the series so we can consider it for inclusion [2].

I hate to put any pressure on already busy maintainers but I would also
dislike missing this OVS release by just one or two days and having
to wait 6 months (OVS release cadence) for it to be available.

Again, I don't want to put pressure on maintainers. If it's not
possible, that's it. I just wanted to voice our timeline constraints.

Thanks for your understanding.
Adri=C3=A1n

[1] https://patchwork.ozlabs.org/project/openvswitch/cover/20240704085710.3=
53845-1-amorenoz@redhat.com/
[2] https://mail.openvswitch.org/pipermail/ovs-dev/2024-July/415261.html


