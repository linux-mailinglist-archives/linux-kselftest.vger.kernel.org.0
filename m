Return-Path: <linux-kselftest+bounces-30063-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD80EA7A3E8
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Apr 2025 15:38:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C926188825D
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Apr 2025 13:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E22E24EF67;
	Thu,  3 Apr 2025 13:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Me140abe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B0824EF63
	for <linux-kselftest@vger.kernel.org>; Thu,  3 Apr 2025 13:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743687251; cv=none; b=UsVAMdPQ7dMWJvI2YpUEX9tl8Spcol1KHtKjK4cMJ9ou73tiOBjVpSw1HUr9AtsrDZAvRvyE5T7Is3n8afHC9X56/wWoAoZzediWcfJlSgJCVr0OQ9iCtosAa8yj3SKc/ePbI/na+ANBeV1kNXpsdHc00SmFArtLGClg8AZoEJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743687251; c=relaxed/simple;
	bh=xiOlszo95RrZ3LIb1/U+HCnGNexFRuJJsuvLKrx+d6w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rwlNc/TQv3a9BITW3IK/3I+IvcEYLDCuRlZqb2/0hjVBsxwWYJEkTkjMy/U+KMY88Dmcuw+lfrNqsDDqBQiCtqEFS07ffwtt63wZMNHuwGtdS3ielbjZojE2u4k4HJYD5VDW/x+oyo+wBOwyGzGLUBA6zxObwIyLxIMPQ0DZ5wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Me140abe; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43690d4605dso6266575e9.0
        for <linux-kselftest@vger.kernel.org>; Thu, 03 Apr 2025 06:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1743687247; x=1744292047; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xiOlszo95RrZ3LIb1/U+HCnGNexFRuJJsuvLKrx+d6w=;
        b=Me140abeGqz+krODLLr2VPPxSqzreDTcOK6fbCInh9C9gS1jrylRb1GKX/TzI1kguq
         P7o1bEIRm8l95dmdr/VzopwtIA+dFnWG3gRABWKeHfNboEq3+Gtbz5hfe3o5LkHUbVa2
         LCiVUpUtNJFqfyTUX18/MC1wM84x43w0LCMCVBFr+vEnUWspAhGmCpmFf69SfMPjApCN
         VUSKe06cGX94zv3Vkg9vdtfIpAVqea7yD4OXYLjkg6ak3EKkbT9CbRh4R/nl4sIUUU90
         PsPmO1++sHH57//E+SkXMcN4u0Wh9TOpWSXRoolphHoIqtUTYT6sGeHdAT77S71Ss9Eu
         EINA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743687247; x=1744292047;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xiOlszo95RrZ3LIb1/U+HCnGNexFRuJJsuvLKrx+d6w=;
        b=YFccd6cRWLa60w3f7J5g4crKeL05FMPvxJCQteeFb5sQi2QogFLGAgca//x9MzjNzs
         d4MAqS7qABsegCwT5p5RqhC08bUZzaKO1NzDZUa7Pu1a9hY2mMJuCfnOw+HxNP2N1YMS
         TApBkSMWO2gBPDGXxdkekUs3Hc9Aav/yILUM+Rt2xHDo1yXiEesNv8S69wVG2uuDYues
         8x/TEe1XKrHPtbUfyJzUhwbSqzaMM4XIZJDVXjBu2mG3KdFWSVFUWf+BX/ufZQDPCmtJ
         rZtIVFxDNeIx7PD9iKSIaLveK7QmSbaaBoLAoCEk1IrlkEDQ/4rzxc6OPUj3F+v5NjEU
         +z6w==
X-Forwarded-Encrypted: i=1; AJvYcCXTjIP5nOgSqPWAsfwoeMzX+4g7AqekXaArwDkai/h2G6OnHKE9J9WGGQl2a0Yyhre6pThr+B0Q7+xluTKGKoA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxb7A6OoBlbXtMXtSZzjNmH5tEsXPbHGh0FRdTL6uCve+uZ/gsp
	S17KRjwxxTip2tN1aQ0M0RlLmjITgVKiZcf7F1fjYBB3OkLgz8HcsmdqNuhAuxI=
X-Gm-Gg: ASbGnct+kdxqU78cj0eiuYPdjCWCt+wOXiae2Qre0oLSZu+IrhDvytVfl4nKUrfz0TS
	xB2We3JCVkt6ZrM3lWnnngReDa0co4l2AzBVqTUYI3GZCPZiDZYX+YDxCRJ0+/NsyGizYnvTCW7
	w/G2e89cDESbHLJXezGLz3N+KPLNdBdpRcZtENtGF8zKEnaBMbOl7TNb77+q/cH95j18y1wKVMd
	Dfxac1RCMHangnkPz81JFHZpQK3EIN9QWhuKt3YDxhfpgzL2iV4wu4QiwhFGwXl/2gHWANA4fG1
	jlEfY9uSWKqpokVesjYPwZw7VvpK9wpWQCfSVmtZKRf1ipU=
X-Google-Smtp-Source: AGHT+IGP0oRY34V+cSf6iFZovfs1LwN6DYRliDiIlWREW6dwmZHpdy7zI1duz9gTK1+/IwIvLvwRsQ==
X-Received: by 2002:a05:600c:b89:b0:43d:fa5d:9314 with SMTP id 5b1f17b1804b1-43ec153677cmr30397905e9.32.1743687247482;
        Thu, 03 Apr 2025 06:34:07 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ec364a0c7sm18497875e9.29.2025.04.03.06.34.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Apr 2025 06:34:07 -0700 (PDT)
Date: Thu, 3 Apr 2025 15:34:05 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Tejun Heo <tj@kernel.org>
Cc: Waiman Long <longman@redhat.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Shuah Khan <shuah@kernel.org>, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 01/10] cgroup/cpuset: Fix race between newly created
 partition and dying one
Message-ID: <hsbn4pcb6gpipjfacn7tbutheolot6rfia2j6nyit3bpf4adys@mpaop37aps55>
References: <20250330215248.3620801-1-longman@redhat.com>
 <20250330215248.3620801-2-longman@redhat.com>
 <Z-zsGazxeHK9uaA6@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="t4fu4hgrvs64iwmt"
Content-Disposition: inline
In-Reply-To: <Z-zsGazxeHK9uaA6@slm.duckdns.org>


--t4fu4hgrvs64iwmt
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 01/10] cgroup/cpuset: Fix race between newly created
 partition and dying one
MIME-Version: 1.0

On Tue, Apr 01, 2025 at 09:49:45PM -1000, Tejun Heo <tj@kernel.org> wrote:
> On Sun, Mar 30, 2025 at 05:52:39PM -0400, Waiman Long wrote:
=2E..
> > Add a new cpuset_css_killed() function to reset the partition state of
> > a valid partition root if it is being killed.
=2E..
>=20
> Applied to cgroup/for-6.15-fixes.

To be on the same page -- Tejun, this is a mistaken message, right?
css_killed callback is unoptimal way to go.

Michal

--t4fu4hgrvs64iwmt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZ+6OSwAKCRAt3Wney77B
SSclAP4gqtAuLackFi5Nlj57z7Muu5PrIFLfK4zkKKF/gZ5yYQEA/gVGnVQa8Dcq
dIb6mJ6FOINsexbxmLhptB0vDt+lFAQ=
=eHQo
-----END PGP SIGNATURE-----

--t4fu4hgrvs64iwmt--

