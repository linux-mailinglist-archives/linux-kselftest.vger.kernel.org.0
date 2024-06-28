Return-Path: <linux-kselftest+bounces-12940-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A855E91C509
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Jun 2024 19:38:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 582AE284BD0
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Jun 2024 17:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCB0A1CCCCE;
	Fri, 28 Jun 2024 17:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XQlmC1rR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D764CB37
	for <linux-kselftest@vger.kernel.org>; Fri, 28 Jun 2024 17:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719596293; cv=none; b=QqOBbQZE02KshYATjQdEHQfMatjYltrKiMTM5FxNYMWx0bGBnGWp78UtXEkL/gCr97iOX9Uy77FikanP5H8zDivpsQ9rAmUfnFuuV74NgA40yOcQobDwJh8EOumXBJTpSJUyKH9FpyG/kFHMbfyggqNbSUNGAaHKpNRvAGN3h6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719596293; c=relaxed/simple;
	bh=m4fUe9aaj4TOFlCepZRFIJXwB4CGuQ8OTm/7XSW9YaA=;
	h=From:References:MIME-Version:In-Reply-To:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uZahbwJlqM/zF260pKhMOZPAqkKyM4z7556+rEgQImAt+8xYmDOzaT7ufdN39ayJlQwv9bfdOWsCIvMcgEL1tAwCuq467QZxKu8NRVPf5B5Dgz/3MbYZ2qDULnhRhIDbQj6CedMH6prHFo9M7qWs+4aEWtdzRbuhN1J27W9wLtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XQlmC1rR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719596290;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FG7X97i4qW1z+GDWPEv3aIODEGnqEtsm7as7nCoOOqE=;
	b=XQlmC1rRY3UKLjNPd/l3CeOp3RRLHE3W2WmM5X4ck9cuocay0CaR5xSPe5mkK1oHnJRfH8
	GkKGHMEa/5b9p2NJc8ly+32+x21i8ktcivxpDzX3zDbcUnYbwCMa+dVAGesUnOgQxvNLFO
	e0LTSbk3eeYQvYPiLD4KY2DE+XiIki8=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-484-AWK2t8WCOgeZSbxVJMOjog-1; Fri, 28 Jun 2024 13:38:08 -0400
X-MC-Unique: AWK2t8WCOgeZSbxVJMOjog-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6b593236489so38781186d6.0
        for <linux-kselftest@vger.kernel.org>; Fri, 28 Jun 2024 10:38:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719596288; x=1720201088;
        h=content-transfer-encoding:cc:to:subject:message-id:date:in-reply-to
         :mime-version:references:from:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FG7X97i4qW1z+GDWPEv3aIODEGnqEtsm7as7nCoOOqE=;
        b=NeSZo92w7/c6msfPFOEmtcCxqnuZK2aYUjE6XIdwtWFNTcNXKFDMWgM5Wgrzu9D4RM
         Mm7z4ptTMDQIumnUbSOASCjUFmVHDF/21r/bv9KY72z2PSxtX3czsaNomQ8atfjgPTv1
         VR5zwfuIlcOsgzj0HsZKILTdrQGtCC4Noiov/m5BNYl5hlAmXB1CL3/K+qSMeUNL+YZk
         mnqss/1iljXWMrtJ9d2QGKRjnMF0cc99TJwbD7eK/taSySU9ELPsXaXELr9YBSSd4FuO
         4PAVwS2S2MzlJCwySgaC9DAWfjUYQOT7oos/lYSpAJy+p0dtGmA8fC2bdDNOOi1cLosb
         8jxQ==
X-Forwarded-Encrypted: i=1; AJvYcCWpxrtqvpsPEoWdAKdZbRYi6irsmURUJ0yQtYWnezEjtxAQzxQ3LyVVoejeYRqsmG60whsTny7nX9AyJggDqsiNxV2sHbEHFACW0y9kR/un
X-Gm-Message-State: AOJu0Yy3kmv3jGxX+12zfz7NjwvSkOBNTKBuDKw0/UCXHOBDafP13vmz
	9aTaqb+N5lkZdQcY6PAM+5SZaORmfloBitzlpy/Gtxdo5u/T+QeJ95m2kmpSTkRP/ALfNOMJnVB
	Q7JLkiVQtiRxvmaC1xvEaSPAZJf/m6f2NYVMXd+Kbfjs/84+zXCbsfJKiLiTe2nxgK7c8lQkHBd
	ODxQIXLLXysPlescFXPQqlwrCrAt4lR0aNvSPWw84e
X-Received: by 2002:a05:6214:2426:b0:6b5:81ac:6b84 with SMTP id 6a1803df08f44-6b5a543aecfmr33787606d6.14.1719596288440;
        Fri, 28 Jun 2024 10:38:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEWTYtV7gIpxyVZKHipinFNRKEVPmLzoCNCAXu+gjnA+zxXXpUvizyXL+8OfyBOweK9SgBFIISpcquha9V/fdo=
X-Received: by 2002:a05:6214:2426:b0:6b5:81ac:6b84 with SMTP id
 6a1803df08f44-6b5a543aecfmr33787376d6.14.1719596288113; Fri, 28 Jun 2024
 10:38:08 -0700 (PDT)
Received: from 311643009450 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 28 Jun 2024 17:38:07 +0000
From: =?UTF-8?Q?Adri=C3=A1n_Moreno?= <amorenoz@redhat.com>
References: <20240628110559.3893562-1-amorenoz@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240628110559.3893562-1-amorenoz@redhat.com>
Date: Fri, 28 Jun 2024 17:38:07 +0000
Message-ID: <CAG=2xmPnqMJzoPuzBRGfjqVRwispcsuPo32hKoko4=hwYZrFTg@mail.gmail.com>
Subject: Re: [PATCH net-next v6 00/10] net: openvswitch: Add sample multicasting.
To: netdev@vger.kernel.org
Cc: aconole@redhat.com, echaudro@redhat.com, horms@kernel.org, 
	i.maximets@ovn.org, dev@openvswitch.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 28, 2024 at 01:05:36PM GMT, Adrian Moreno wrote:
> ** Background **
> Currently, OVS supports several packet sampling mechanisms (sFlow,
> per-bridge IPFIX, per-flow IPFIX). These end up being translated into a
> userspace action that needs to be handled by ovs-vswitchd's handler
> threads only to be forwarded to some third party application that
> will somehow process the sample and provide observability on the
> datapath.
>
> A particularly interesting use-case is controller-driven
> per-flow IPFIX sampling where the OpenFlow controller can add metadata
> to samples (via two 32bit integers) and this metadata is then available
> to the sample-collecting system for correlation.
>
> ** Problem **
> The fact that sampled traffic share netlink sockets and handler thread
> time with upcalls, apart from being a performance bottleneck in the
> sample extraction itself, can severely compromise the datapath,
> yielding this solution unfit for highly loaded production systems.
>
> Users are left with little options other than guessing what sampling
> rate will be OK for their traffic pattern and system load and dealing
> with the lost accuracy.
>
> Looking at available infrastructure, an obvious candidated would be
> to use psample. However, it's current state does not help with the
> use-case at stake because sampled packets do not contain user-defined
> metadata.
>
> ** Proposal **
> This series is an attempt to fix this situation by extending the
> existing psample infrastructure to carry a variable length
> user-defined cookie.
>
> The main existing user of psample is tc's act_sample. It is also
> extended to forward the action's cookie to psample.
>
> Finally, a new OVS action (OVS_SAMPLE_ATTR_EMIT_SAMPLE) is created.
> It accepts a group and an optional cookie and uses psample to
> multicast the packet and the metadata.
>
> --
> v5 -> v6:
> - Renamed emit_sample -> psample
> - Addressed unused variable and conditionally compilation of function.
>
> v4 -> v5:
> - Rebased.
> - Removed lefover enum value and wrapped some long lines in selftests.
>
> v3 -> v4:
> - Rebased.
> - Addressed Jakub's comment on private and unused nla attributes.
>
> v2 -> v3:
> - Addressed comments from Simon, Aaron and Ilya.
> - Dropped probability propagation in nested sample actions.
> - Dropped patch v2's 7/9 in favor of a userspace implementation and
> consume skb if emit_sample is the last action, same as we do with
> userspace.
> - Split ovs-dpctl.py features in independent patches.
>
> v1 -> v2:
> - Create a new action ("emit_sample") rather than reuse existing
>   "sample" one.
> - Add probability semantics to psample's sampling rate.
> - Store sampling probability in skb's cb area and use it in emit_sample.
> - Test combining "emit_sample" with "trunc"
> - Drop group_id filtering and tracepoint in psample.
>
> rfc_v2 -> v1:
> - Accommodate Ilya's comments.
> - Split OVS's attribute in two attributes and simplify internal
> handling of psample arguments.
> - Extend psample and tc with a user-defined cookie.
> - Add a tracepoint to psample to facilitate troubleshooting.
>
> rfc_v1 -> rfc_v2:
> - Use psample instead of a new OVS-only multicast group.
> - Extend psample and tc with a user-defined cookie.
>
>
> Adrian Moreno (10):
>   net: psample: add user cookie
>   net: sched: act_sample: add action cookie to sample
>   net: psample: skip packet copy if no listeners
>   net: psample: allow using rate as probability
>   net: openvswitch: add psample action
>   net: openvswitch: store sampling probability in cb.
>   selftests: openvswitch: add psample action
>   selftests: openvswitch: add userspace parsing
>   selftests: openvswitch: parse trunc action
>   selftests: openvswitch: add psample test
>
>  Documentation/netlink/specs/ovs_flow.yaml     |  17 ++
>  include/net/psample.h                         |   5 +-
>  include/uapi/linux/openvswitch.h              |  31 +-
>  include/uapi/linux/psample.h                  |  11 +-
>  net/openvswitch/Kconfig                       |   1 +
>  net/openvswitch/actions.c                     |  65 ++++-
>  net/openvswitch/datapath.h                    |   3 +
>  net/openvswitch/flow_netlink.c                |  32 ++-
>  net/openvswitch/vport.c                       |   1 +
>  net/psample/psample.c                         |  16 +-
>  net/sched/act_sample.c                        |  12 +
>  .../selftests/net/openvswitch/openvswitch.sh  | 115 +++++++-
>  .../selftests/net/openvswitch/ovs-dpctl.py    | 272 +++++++++++++++++-
>  13 files changed, 565 insertions(+), 16 deletions(-)
>
> --
> 2.45.2
>

Patchwork says this patch is not applying on net-next. I'll wait for
some reviews and rebase+resubmit it later tonight or tomorrow.

Thanks.
Adri=C3=A1n


