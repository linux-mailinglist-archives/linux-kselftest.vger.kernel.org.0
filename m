Return-Path: <linux-kselftest+bounces-4183-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 359E284B0D9
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Feb 2024 10:18:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DBC41F234C3
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Feb 2024 09:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E94412CDBA;
	Tue,  6 Feb 2024 09:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NFAz1vTk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 565E212D760
	for <linux-kselftest@vger.kernel.org>; Tue,  6 Feb 2024 09:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707211126; cv=none; b=XQDwwVGKXOPeJ5xRuI6tm327lV8J/4+4/JKLtn6PVq23Ztj/+vW8I7o9BA3+vpDWePjzwBNDZydbZ2G/ozR7cVQvXzg4VMaPvnF5VB6DWAo5vnIDlOYoO3aoAwUh5DVkrPPB7KYQ6QBraNp5wWxIKTgP45+P4SACFxnXR4wnHhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707211126; c=relaxed/simple;
	bh=prvgldAFovoWiGl48QWXdApWHK3OM4MJDweZhU5SzvM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=a6SaJIHZqyaN6lNw+Uvq9Lxg6zzh0sv03uMA6l7Ttbfs1Ql/F6RdVcYEdudeU8QbwpqUI+X/WeKSueSEGF1961knTJFoslf4PB7x471YQNL3sUkDbPLpYB7+T5rxrN6lq6luuXPses/jqN3JzT4i6WOCyXL8jkYtNRfwfZ0liiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NFAz1vTk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707211118;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=lYCDyyKCoibbTmzDW+iu9CTx5VbMnBuVRMAnL0Yd85Q=;
	b=NFAz1vTkhZeYrvXXYz7indLci0ZyRQyOXotNBUS2aZQADMEWlZPGi/VyMgmh5JfcwgJOuw
	z13JHAmixElZ24eEZOencteWQOoD5grxBoPEdyhP6ALPwwILVNcn/Kd54TbYMMOt3mROIa
	sRGqqlAK/LeEWE9mrfJ1kSexocl6tJ8=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-67-F1Nihw4IMwi9oWpzeVL6tA-1; Tue, 06 Feb 2024 04:18:37 -0500
X-MC-Unique: F1Nihw4IMwi9oWpzeVL6tA-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2d05ff32cb3so7454801fa.0
        for <linux-kselftest@vger.kernel.org>; Tue, 06 Feb 2024 01:18:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707211115; x=1707815915;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lYCDyyKCoibbTmzDW+iu9CTx5VbMnBuVRMAnL0Yd85Q=;
        b=NVaYgU8D7B/5oPcWdr9GZcskh/z84VS6dt7Wpay/XXHEOlwfSsDImhXyJowASei3ZC
         Y860sI45IPRY3VDGyCWd5HbwkiZI81E7QQ/ljxBoU7P2xNiiPUarfoHAOfh7Md7f3veD
         FW2P0VuVQ8+98BwRVRkE7YtluNtsBVFk6/LyPt1UIfhUDFvN1eUroDqhxnEfNPxuZLUE
         TxlUYGSPr0y4Q0O776+2tDgxCPPg3z+hr2Xx6IVkSWkLt2HbdhJkB+SCO/E9TDSgX0hd
         en+ZGjGiv2Q+WDCEpk9Y9In6fLJ8zPc76n9yrg1M0WG3qbufWkOqzRLqRrggoUSDBzmy
         r7UA==
X-Gm-Message-State: AOJu0YwaqW0BgYyoyvfdIsDW5q4fqjov7962JRgQYiRVdZSnBbBwBGWp
	XlAMG6qK8DKQ5NoePzLjEWY0bkYNAwI8o010ndLSpyXCOFtSG8eq6iaXBwnv3id67LQEBioLCXG
	5mdl4bPDuLLNxza0OnhHyBCwG2SA0CMTry/2X/LPmAiX8V9USFs1e397uGUYv5f880QBQwTn1Xg
	==
X-Received: by 2002:a2e:91cb:0:b0:2d0:41df:70b7 with SMTP id u11-20020a2e91cb000000b002d041df70b7mr1502514ljg.1.1707211115585;
        Tue, 06 Feb 2024 01:18:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFLGUaWqyHmkWtfSmJrDaYgVadDC1w2N3jL4r7Y3Tr4TP4sTJ0IdTCp/mEFv+qjy2omL7xkVA==
X-Received: by 2002:a2e:91cb:0:b0:2d0:41df:70b7 with SMTP id u11-20020a2e91cb000000b002d041df70b7mr1502502ljg.1.1707211115179;
        Tue, 06 Feb 2024 01:18:35 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVS3tiepR0IEf2Bvq3dNXA3UdP8rJ1JYSRY03l7kJGkJpcEe4B5FoDsQokSSz64Ebt3BVAFfu3KVO77Icz61RYuiEYElInmb9o4sBSNqsOA5m24IXkGPx/2Aa6zEmGWDwVdsvqNUVMp7i6IipSZWSMbpc1J8rVWlfnE/5vLBOUggXf0evNgYVn/azYupkbBj+ejIf4J98s9N857D+ucRV1vYtiWYy8Td1Ly28hXI6Hg4ri/
Received: from gerbillo.redhat.com (146-241-224-127.dyn.eolo.it. [146.241.224.127])
        by smtp.gmail.com with ESMTPSA id f6-20020a5d50c6000000b0033afcc069c3sm1562603wrt.84.2024.02.06.01.18.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 01:18:34 -0800 (PST)
Message-ID: <cc2ac7cb99e09a3898f033690fd0b7978d0b120d.camel@redhat.com>
Subject: Re: [PATCH net-next] selftests/net: ignore timing errors in
 so_txtime if KSFT_MACHINE_SLOW
From: Paolo Abeni <pabeni@redhat.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Jakub Kicinski
	 <kuba@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	linux-kselftest@vger.kernel.org, Willem de Bruijn <willemb@google.com>, 
	Matthieu Baerts <matttbe@kernel.org>
Date: Tue, 06 Feb 2024 10:18:33 +0100
In-Reply-To: <65bd894de7b93_38e921294a9@willemb.c.googlers.com.notmuch>
References: <20240201162130.2278240-1-willemdebruijn.kernel@gmail.com>
	 <20240202153909.79c08063@kernel.org>
	 <65bd894de7b93_38e921294a9@willemb.c.googlers.com.notmuch>
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

On Fri, 2024-02-02 at 19:31 -0500, Willem de Bruijn wrote:
> Jakub Kicinski wrote:
> > On Thu,  1 Feb 2024 11:21:19 -0500 Willem de Bruijn wrote:
> > > This test is time sensitive. It may fail on virtual machines and for
> > > debug builds.
> > >=20
> > > Continue to run in these environments to get code coverage. But
> > > optionally suppress failure for timing errors (only). This is
> > > controlled with environment variable KSFT_MACHINE_SLOW.
> > >=20
> > > The test continues to return 0 (KSFT_PASS), rather than KSFT_XFAIL
> > > as previously discussed. Because making so_txtime.c return that and
> > > then making so_txtime.sh capture runs that pass that vs KSFT_FAIL
> > > and pass it on added a bunch of (fragile bash) boilerplate, while the
> > > result is interpreted the same as KSFT_PASS anyway.
> >=20
> > FWIW another idea that came up when talking to Matthieu -
> > isolate the VMs which run time-sensitive tests to dedicated
> > CPUs. Right now we kick off around 70 4 CPU VMs and let them=20
> > battle for 72 cores. The machines don't look overloaded but
> > there can be some latency spikes (CPU use diagram attached).
> >=20
> > So the idea would be to have a handful of special VMs running=20
> > on dedicated CPUs without any CPU time competition. That could help=20
> > with latency spikes. But we'd probably need to annotate the tests
> > which need some special treatment.
> >=20
> > Probably too much work both to annotate tests and set up env,
> > but I thought I'd bring it up here in case you had an opinion.
>=20
> I'm not sure whether the issue with timing in VMs is CPU affinity.
> Variance may just come from expensive hypercalls, even with a
> dedicated CPU. Though tests can tell.

FTR, I think the CPU affinity setup is a bit too complex, and hard to
reproduce for 3rd parties willing to investigate eventual future CI
failures, I think the current env-variable-based approach would help
with reproducibility.

> There's still the debug builds, as well.

I understand/hope you are investigating it?=20

Cheers,

Paolo


