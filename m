Return-Path: <linux-kselftest+bounces-44688-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10BC3C2EA90
	for <lists+linux-kselftest@lfdr.de>; Tue, 04 Nov 2025 01:48:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB3C93B6231
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Nov 2025 00:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E76E42CCC0;
	Tue,  4 Nov 2025 00:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y46HFNvk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7664917993
	for <linux-kselftest@vger.kernel.org>; Tue,  4 Nov 2025 00:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762217301; cv=none; b=J4uFBs5IfAZUcfpnlNkdyfeO814f1rj07zYmRB7dpEvukuD4sJKmxTEFRxQFRy1WJbLhiXMTrY5kwcZwF8lK1JQnZaPqB2oOMPZoDiytpTFsZE337M56gUhpSSC3fB1nxZE68b61nCZvAHRF45pj50pn8WlI3IaiUiAk1bkqPSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762217301; c=relaxed/simple;
	bh=4Dpf1kT47SVRDtpn/cSznt+bTK6v0hS72U9THCinuJw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jm98cscDrCnZOjQd+Jq/cyQ8PRjH3EfbtDg76wHf+WKM0l7GmsFoZUrfZJJWSYunwWYdyCrAKnrajNB6lN4J2CN1OsR2ZvVhuZqRDYpgfPWLT79FKG9rOdbn2SUW8Ozwwk2pFkFVN+S1BRxpP2HtTAbzbaGu/qlFGkplku5iXwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y46HFNvk; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-33ff5149ae8so3814860a91.3
        for <linux-kselftest@vger.kernel.org>; Mon, 03 Nov 2025 16:48:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762217300; x=1762822100; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=K3Zyvcg6HsP3kuXtclPYWjtOPlsZtk1ijNjr2zUai2Y=;
        b=Y46HFNvkTPBg5b97zhudNQihhbjaHqqC+xgZqT3JVSXieiwtvO0z9VjZrrRienSijr
         nJRTvUKm+aqA9LpQbOQlEyITV8WXG59sl1/DPm1u1131nKJvUCSZDbtnQRpfREW05mkf
         7Tzi/pFmVcRBjejo3MvQ/Uqa8EiIYGoQMM1siPuSDqvuiFKepKn7419qWYuXzxA2Jn2f
         LuhJ11ESFNgRbNi0CeAQWZggcGRdbBuQ2nkT3/BVSaPVmSw75l01rbpUUn1KZtyMVZKM
         93nn1S/ruTOatQVMNOEGxzrbNzyeuvsGg19RYUankThYaM1wx7H4YobIL1qpIlyEUdKO
         k/6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762217300; x=1762822100;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K3Zyvcg6HsP3kuXtclPYWjtOPlsZtk1ijNjr2zUai2Y=;
        b=glEBWzitl87BXvUJu6F8xpSCNlmUi/hAfJ5/UE68bJzSq6+1thQwRrRkVaw8j0r0zV
         C/S5qHIfW/bGiSlSL9lQuJsqLqMtRkZNqi5TohTplNhX4xtQ9XAPob2rWGQSPc0SBP7P
         KXnGn6wfD4JOONne1oxeFWvHRes3SOllS8jCMrbgAvSkyA97RMpjp0k2SRH3uueOwq7E
         PtGcinsYR393Xe/miehXqoqZZW6HZ6fR0VhV6JLW1Dvc9Z2Rrwpc+o1Sfa0dJYrrN52W
         EOe15zoTDJKjuxaw2/wUKzrn74q1pSzrVUp0sPki4Lfj/Dt+O8VTN0pdQJ5Z0K/MbivD
         BT5Q==
X-Forwarded-Encrypted: i=1; AJvYcCUxohDeeEa/SQghkUZbD9JCyTll+YcnK3bn2rh/OA9+ig9yXY0c+YI2p7487cKrb0ZjQbJadivCemJjeTKRGVo=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywrx9ADYG6+K4HHYrJrksz7j1f0UrliQDWGHdn8S2C34o3FrDcV
	xJupDbkXmWhgqPc41fOro13TrC9i6d/Zwha2sXOrPzOeMrotURndwjwY
X-Gm-Gg: ASbGncuDe3iKAuVGaYruLhon6+wp2/A9fqczJGaTZ3LJAQb9hUgFShRvwlM+gvJDHYt
	NX1i7B97fCYvuFfP+h65yk+XMZVv6Wxt6DBBorbuTO7CSf1wZ4C4L2y7z60PhLpeJFLjODsZ4xv
	lImXMj6ZBMczRT9jRS1gldhGfXGcawXFEgZbkJ2pvfCnoJBOqLYczGhWhjj23wy19z3O9qdfdHx
	LFARqAmiMHfJx2scPCP+fMo5v3KwwXKZdPdu7qtyeeThLqhWOQjGv5kMl2SuGMFKUbhIR6u4pwL
	BS4u71DvSM4Qq1dWvndxgNEuzI3c4ibpcBk4a8Q9UnPtnlkWYhgb1bgDRbmFyhB3ehH5o7YBlY2
	Uue8ZYIx7bqiIhU5OpPFVaNvKVPgiI6TZW+7e95IWMgBHSwZMC8lRh0yd2SFJVat+bjXbBc+n0X
	Lhe3TXxK84UWHMtqk=
X-Google-Smtp-Source: AGHT+IFrD3Dj5D8+I2H1WbW5AULK93SPkl4SYUCS4JiL0AXyHtpWOTY9OaOZmnvJEPJswkxWa0+Zwg==
X-Received: by 2002:a17:90b:3c06:b0:330:7ff5:2c58 with SMTP id 98e67ed59e1d1-34082fc413dmr19660243a91.7.1762217299693;
        Mon, 03 Nov 2025 16:48:19 -0800 (PST)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34159fc0e19sm2400662a91.4.2025.11.03.16.48.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 16:48:19 -0800 (PST)
Date: Tue, 4 Nov 2025 00:48:10 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Donald Hunter <donald.hunter@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jan Stancek <jstancek@redhat.com>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	=?iso-8859-1?Q?Asbj=F8rn_Sloth_T=F8nnesen?= <ast@fiberby.net>,
	Stanislav Fomichev <sdf@fomichev.me>, Shuah Khan <shuah@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Guillaume Nault <gnault@redhat.com>,
	Petr Machata <petrm@nvidia.com>, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next 3/3] selftests: net: add YNL test framework
Message-ID: <aQlNSkaJQLnd-RQM@fedora>
References: <20251029082245.128675-1-liuhangbin@gmail.com>
 <20251029082245.128675-4-liuhangbin@gmail.com>
 <20251029164159.2dbc615a@kernel.org>
 <aQL--I9z19zRJ4vo@fedora>
 <20251030083944.722833ac@kernel.org>
 <aQQVYU1u3CCyH8lQ@fedora>
 <20251031112406.403d1971@kernel.org>
 <aQg5y_Feg6YQ7Odl@fedora>
 <20251103160527.2813b61c@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251103160527.2813b61c@kernel.org>

On Mon, Nov 03, 2025 at 04:05:27PM -0800, Jakub Kicinski wrote:
> On Mon, 3 Nov 2025 05:12:43 +0000 Hangbin Liu wrote:
> > 
> > Hmm, how should we execute the script under `tools/net/ynl`? Use the cli.py
> > like:
> > 
> > ./cli.py --spec ../../../Documentation/netlink/specs/xxx.yaml
> > 
> > Or use the installed name `ynl`
> > 
> > ynl --family xxx ...
> 
> I think under tools/net we don't have the kernel selftest infra.
> This is not great because we lose the integration benefits,
> but it gives us the ability to.. do whatever want..

Yep.

> 
> I think relative paths would be fine? I believe that if you run cli
> from its directory you can use --family and it will refer to the
> in-tree specs automagically ?

OK, let me try it.

Thanks
Hangbin

