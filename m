Return-Path: <linux-kselftest+bounces-30726-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 032A4A8849B
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 16:22:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BA12561F9E
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 14:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A1CC28B518;
	Mon, 14 Apr 2025 13:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="AcAkY3C0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE292472BF
	for <linux-kselftest@vger.kernel.org>; Mon, 14 Apr 2025 13:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744638405; cv=none; b=WwAIr54h85oKNZKmP6T7gCbCUFhfp4auUnzRoAFuprVyVgjMqpI6XJyFLDrpXJm8+PupZX3fn/qwSmxY8yyzc7U5zqrxiYQ4yebvPHvNiqeXykHlgwzuA8Oo0U2Bn1gSkUBxy+u1V/Kpn/Qq6xsTolxNhuFZ6kbNp35Xe8BpjKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744638405; c=relaxed/simple;
	bh=6BVbMy6ne3bXQ3Nsse03K7kAcJNhZ2VYPdNl5DfJUtM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KpRs367E97EEAoJJYxNF8ASzXxZSk2bPTQnpE0mjMOwmRQ8GfhekCW3YTFJjGcI4fW91gD4Bei1K0B2gTXp1RPzoxHNAASTzA4THCZVBpl1GB087EJNHeHXVUHqqnzR4+Nnhx0eri88dTIxFw6Nr5oeFwYDxPwp1Gzvgr6XFzn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=AcAkY3C0; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-39129fc51f8so3771695f8f.0
        for <linux-kselftest@vger.kernel.org>; Mon, 14 Apr 2025 06:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1744638401; x=1745243201; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bipg0yl7o2vbmSD7ioyhg09jh/3grPfbA4Z+1IQ6I64=;
        b=AcAkY3C0D9BktUI+vVnKlBdR7DSakpzPgcGz7DgqsCd1Jah4UqaIkBpOmb6kBqigCJ
         SWsCsCh047cd57pVRqygoaPX1woasrPTo/TlYs+h+/6x5lG5OdK6BhRd7dorwok9jucy
         mBM9OxQOsHB/5iG86bJqHYPDxBp6zBKwDRDryAevpm/dbRmG8nA5yofxkLD5hFEdY53I
         k5u7A3IvHplLdOMtPaxD23552FSSnvKVGKtJ9ZhVs3wVEh5gHQnOQd4szZ1ttR8QOWdr
         4bKZCsPAcaYJbNFGKRpZZV2e/miUJaVkLcQZ3hiWLCcmfmcUZFcceDXYo93cxfp8dAE4
         0PKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744638401; x=1745243201;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bipg0yl7o2vbmSD7ioyhg09jh/3grPfbA4Z+1IQ6I64=;
        b=tXjSZ5rFmaRyXQ2cHLavdgAXTQ3hG/3XlTDQWGPUsD20QVh2pNkKggQWB6QZhCM31m
         uVYiEkhQ5Za9LetekY4Fao9/j+wa98ApQeYmb9eNuV7xTgJoH/N3LcyGrWNYC4mpmcNv
         O6h8YfJ6sVAmiC41c1WjVHm+c0uQsLEGQGQtBymGH1lDOG0+799Utpqu5ur5+QCcaRF+
         V1DC5+eNd4HRONXZ4L8XptyBWSORuKoMZR3mIzgwfxoOuDhMRieuZEjUCMwLirZMN38u
         Is+X6QcS2wbOt2rJUdYa0qEnx5XzxaechTtWAh/P8DB6Yz6GjAx2NKOnVKufomg//UJJ
         jtFg==
X-Forwarded-Encrypted: i=1; AJvYcCVn6SgiUP+H0SRkRNBn52J0hUEAxwr2Zf67EyKDA/OtVL3SLAI46G799ME3RiKQBoobSdm4VaXyd4+QnF9gsoE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxK5M9dO9rd6Dx6WHO8FuS5GNkTa0AhP+aO06Q4fRh986SXxYxt
	Gs/snB0s/hc283+1AyHiYy/TzjHnrdHcsk434PUN6T01Bk+vR+zw/QONAgv1S3I=
X-Gm-Gg: ASbGnculPk54NtgBu6bSQD1p4q1TlFwbdRxR9YHS23qVtCPuhwpxRWKt/VOS49/HQ5g
	ZemHOOGlE0HBseOvkxZs3NckMdom6laHaqjLP4X30gSbevAxHujelstXhG9i3RMiEZjR+Sxk76c
	XnkruUn/Ek8oMu+hvNuBu2zC12zUHm1A5gRtAA6cpbQzIJ5A8b69XhkNgIG5yJPFxz3zbK7Vffp
	82m0Ozp09n3+j2fGlj2nqocTvScW7Hdb0Qm8Yf7fighCys9AwiqK9sftoeUwe6CES5HMbsB3JM+
	95tDcoVG+XajQ5slFRfNfkFRktMMIeHTyrMX3Fp6TGU=
X-Google-Smtp-Source: AGHT+IFM3rTpzndvyNyLfnaHZQL7RBtVvV714aLrExyrq7wBBqRjHQLyzYiHBZ1lxloKwtAEBSxsuQ==
X-Received: by 2002:a5d:5f92:0:b0:391:12a5:3cb3 with SMTP id ffacd0b85a97d-39ea51ecc2emr10505643f8f.3.1744638401365;
        Mon, 14 Apr 2025 06:46:41 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39eae964073sm11003797f8f.9.2025.04.14.06.46.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Apr 2025 06:46:40 -0700 (PDT)
Date: Mon, 14 Apr 2025 15:46:39 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: Cgroups <cgroups@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: selftests: cgroup: Failures =?utf-8?B?4oCTIFRpbWVvdXQ=?=
 =?utf-8?Q?s?= & OOM Issues Analysis
Message-ID: <twi33lxboes5lvflguqik23dlehvwczee2gvsbllrz3gbtb7wl@w23lqyocl6p3>
References: <CA+G9fYsrfM62=kr=q1nu_Nx9-sTHQw-6A-3OWkiqgs4JiKzvgA@mail.gmail.com>
 <exfgzrx7u3s77gsoxqzm4zhb6mr7aysc2vzus5ob3zeadkm7ut@3dzkywk3jfqr>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fizx46gpbadiqwbn"
Content-Disposition: inline
In-Reply-To: <exfgzrx7u3s77gsoxqzm4zhb6mr7aysc2vzus5ob3zeadkm7ut@3dzkywk3jfqr>


--fizx46gpbadiqwbn
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: selftests: cgroup: Failures =?utf-8?B?4oCTIFRpbWVvdXQ=?=
 =?utf-8?Q?s?= & OOM Issues Analysis
MIME-Version: 1.0

-Cc: non-lists

On Tue, Mar 04, 2025 at 03:20:58PM +0100, Michal Koutn=FD <mkoutny@suse.com=
> wrote:
> Actually, I noticed test_memcontrol failure yesterday (with ~mainline
> kernel) but I remember they used to work also rather recently. I haven't
> got time to look into that but at least that one may be a regression (in
> code or test).

So I'm seeing (with v6.15-rc1):

| not ok 1 test_kmem_basic
| ok 2 test_kmem_memcg_deletion
| ok 3 test_kmem_proc_kpagecgroup
| ok 4 test_kmem_kernel_stacks
| not ok 5 test_kmem_dead_cgroups
| memory.current 8130560 [ <- 1 vCPU ] 13168640
| percpu         5040000 [ 4 vCPUs ->] 10080000
| not ok 6 test_percpu_basic

not ok 1
By a quick look I suspect that negative dentries that are used to boost
memory consumption aren't enough (since some kernel changes, test
assumes at least 10B/dentry) -- presumably inappropriate test in new
dentry environment, not memcg bug proper.


not ok 5
A dying memcg pinned by something indefinitely, didn't look deeper into
that. Little suspicious.

not ok 6
That looks like the test doesn't take into account non-percpu
allocations of memcg (e.g. struct memcg alone is a ~2KiB + struct
mem_cgroup_per_node). The test needs better boundaries, not a memcg bug.

HTH,
Michal

--fizx46gpbadiqwbn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZ/0RuwAKCRAt3Wney77B
Sc+pAP412kL5nkQoVTj/EjRpsQ3CL25ZXx8zZHkVMnZ7lD/g3wD9EHcWYJeFLZb6
r0VcjFMxyJImX15b+E8/MMBxAw9JMwA=
=f7Jk
-----END PGP SIGNATURE-----

--fizx46gpbadiqwbn--

