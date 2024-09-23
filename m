Return-Path: <linux-kselftest+bounces-18216-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D152497EADF
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Sep 2024 13:39:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CE5E1F21F4C
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Sep 2024 11:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D27C197554;
	Mon, 23 Sep 2024 11:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RCiwubSp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E700F52F62;
	Mon, 23 Sep 2024 11:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727091565; cv=none; b=iKmYvBqbEAFkJD+nkDrhH76x+WGZPXyU6teINbOdlosDMIsBMjSjNeG1y2ZH7ZI9gbSWnulBZYKutXVfZQkbm+T6dgFz9fJFNEx0aMgKPDqyUtJQqQlpqQ7wsWyise+HLacY2MyGWdc67+chkmN53y5lVLOOQmzUR3f5wUcaiW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727091565; c=relaxed/simple;
	bh=aTRu5Zt18F0Vn58S0hvcQQ95NDimWRMH8Ql8FttBShc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LSQ8NWHylkFhW4a4lzopp+9HA8kVqGBJVur1tJTvw473EFQDdqv0YKOFsuJc4PW+66s/Y6k2nNUSndF+Z0U66E8bvrPNS1kopFTNVwMJVlhYNogpBo5WMEwVs8xk7Ac/+7KLRWySXVAgL7T7KKXatyhBMNWSrNs96p6TzQc5eAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RCiwubSp; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-7db90a28cf6so2333107a12.0;
        Mon, 23 Sep 2024 04:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727091563; x=1727696363; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2B2I+J6TxJmbnTjoxzqoH7+Kzts8oeJzZdCXJropM/k=;
        b=RCiwubSp5Rra3fPi19op7LbsJndTbmBz1ZK6+MPFhks02ELv/mqKr51nBjdqysGq4v
         mV1ppi4J0H9H0wNOmPfDnV1Z1i5PH/vO71Jv0Mdh512DVF1nHasrOd4+0Nvj/kU95s9t
         QyYlCe2Yw5sThLm0FbV87Z4HuUZbswaQbWz8SU4PxgIECJAO+S5vENNxOgJOeNXuq3bM
         /TB3U9TnKgyPiWd6MPV1pKM05lVH5RG+WT+WVbQIw9qxiG8U7j0BWAvGQc8dCxssv4Dj
         zRZ3if1B/xcqUxQ2GF7doKuiQbYRV+yUh6Yjev6D1caTpVCmX6Nxh1fDWuaOLEsy0z/d
         5EiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727091563; x=1727696363;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2B2I+J6TxJmbnTjoxzqoH7+Kzts8oeJzZdCXJropM/k=;
        b=WVTk3LsJ/eGn7XK4HNfNIRI3FShM+GmmtX+dslVgfL4iy/AM6Cg1kq3lMGGteSai2v
         b3xs1mFgBjmXudwavQdJWThQkYhyWQg9INvoL++1nUYk+Y/TQwPnHo3/pg1GMU/tjDUK
         L8Ynzen+5rBbSlx5vAyP6AbVEZ6TMD64kqo4e+ZTZ8laCWJUANCyR0Z9wpE8Q5zfxJyd
         DjWtxyTN6rSAKDh7MPMc4mof8nIK5i/dwhfS9cuDE16Fd9Um1zCp6qqHxNZUNOg0nvgJ
         qhJEYkPKuBUI6a+PaQU2NsGdPZmeJ6mMgV1bUghE9Kjm9ZJhJiyt+a4lqd55VWNfDKlo
         J2Wg==
X-Forwarded-Encrypted: i=1; AJvYcCV3F9kYD2bvh2+3zWOupubw75jeIHmGQq0E47PiAz7iBy7HTR5PGHBt1J/EIMRjJlx4eHuHi7ImEhLGMviPSuFf@vger.kernel.org, AJvYcCWP7BfFFQ8BoMRK+zvXsLnf+X8Aceqxnr0gx9xVPziP+vIUxbjgJ8bsQ4B40OMDPwb5VeE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPhGm4W8bV302MwWHKRKPgqqECZdkydtK2wTGQnZAvzlBCrZ5G
	T/8jmOYajCdWMbjiTNs9Tmgh9uLBV3nZJoVhH9v6OBjVmpyvhyJi
X-Google-Smtp-Source: AGHT+IERpx0sY92CPr+NcFRfeU+hBGPA25M9y7xFnkE23ijIMROqdJH+Bc7TWBIGGu7sHn6A2r9m4A==
X-Received: by 2002:a17:90a:8c96:b0:2d8:a943:87d1 with SMTP id 98e67ed59e1d1-2dd6ce9ae1cmr22286976a91.13.1727091563017;
        Mon, 23 Sep 2024 04:39:23 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dd6ef9858fsm9226312a91.52.2024.09.23.04.39.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2024 04:39:22 -0700 (PDT)
Message-ID: <24b280fe1c3bc9348b4b89a9b860827ed432a772.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 2/3] bpf: btf: Ensure natural alignment of
 .BTF_ids section
From: Eduard Zingerman <eddyz87@gmail.com>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Tony Ambardar <tony.ambardar@gmail.com>, bpf@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, John Fastabend
 <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Mykola Lysenko
 <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, Jean-Philippe Brucker
 <jean-philippe@linaro.org>, Viktor Malik <vmalik@redhat.com>
Date: Mon, 23 Sep 2024 04:39:17 -0700
In-Reply-To: <ZvFJAJdEdK3wnyXs@krava>
References: <cover.1726806756.git.tony.ambardar@gmail.com>
	 <714d7ab8a48172c67ddc027c85b2a0dad0312a74.1726806756.git.tony.ambardar@gmail.com>
	 <46d8d74883926245829f8aac3d1ab6dc5b5e4b98.camel@gmail.com>
	 <ZvFJAJdEdK3wnyXs@krava>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-09-23 at 12:54 +0200, Jiri Olsa wrote:

[...]

> > > diff --git a/include/linux/btf_ids.h b/include/linux/btf_ids.h
> > > index c0e3e1426a82..c10b163dc340 100644
> > > --- a/include/linux/btf_ids.h
> > > +++ b/include/linux/btf_ids.h
> > > @@ -89,6 +89,7 @@ word							\
> > >  #define __BTF_ID_LIST(name, scope)			\
> > >  asm(							\
> > >  ".pushsection " BTF_IDS_SECTION ",\"a\";       \n"	\
> > > +".balign 4, 0;                                 \n"	\
> > >  "." #scope " " #name ";                        \n"	\
> > >  #name ":;                                      \n"	\
> > >  ".popsection;                                  \n");
> >=20
> > This forces all id list symbols to be aligned on 4 bytes.
> > Should the same be done for __BTF_SET_START?
>=20
> it seems all the set macros use __BTF_ID_LIST, so it should be taken
> care of by that

Apologies, I don't know how I missed __BTF_ID_LIST invocation in
the __BTF_SET_START definition :(

> > Also, is it guaranteed that all btf ids are organized in lists and sets=
?
> > Grepping through the code it seems they are, but it looks like resolve_=
btfids
> > does not really enforce this, simply looking for symbols matching a spe=
cial name
> > __BTF_ID__<type>__<symbol>[__<id>] .
>=20
> yes, you need the BTF_ID to be part of list or set to be able to access i=
t
>=20
> resolve_btfids does not enforce some loose BTF_ID definition without list=
/set,
> but that does not seem to be a problem

Understood, thank you.


