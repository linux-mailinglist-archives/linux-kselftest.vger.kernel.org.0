Return-Path: <linux-kselftest+bounces-32154-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 25D2AAA6E5C
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 May 2025 11:43:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CB331BA12E9
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 May 2025 09:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1E452309BD;
	Fri,  2 May 2025 09:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="FNh6wRok"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCFC2205AB9
	for <linux-kselftest@vger.kernel.org>; Fri,  2 May 2025 09:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746178988; cv=none; b=IZ/q+sDkEbli8jh4t6xRb8N2x7It5wKpxhg/s6Y9P0b0YDc1xJXGFriTiTQJgwT9O5p/QWiq9lMxoNBrobdOUXrwQr9OW0gNpBmqXqV53nZa9LRfzBhHbfcHrqPGL1aHABpijJ72zfe6bOfdeXAhxY52z0MkoPGtLqTIYH8vcy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746178988; c=relaxed/simple;
	bh=EOXqPqomDY5NAmOBb/66KqDnP+k/LNaa1HXt0xFQ2zI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U1Fmvo0nTGgQwGBtBN+L2GwuwGbMW6L3ARFMRo34IUzPTf6Jdp4l2jEvYwiyQOCBfTxTblPBTYKChMbO9EYokpk40qEa7llzuGdgSLq7l0Wkr8vh8qbaBBzUOz2A3DnF7NFyLdBJLo10QdL85Sn0Ajn57LdVVh3K9U0BqWHyZcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=FNh6wRok; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5e5e63162a0so2717335a12.3
        for <linux-kselftest@vger.kernel.org>; Fri, 02 May 2025 02:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1746178985; x=1746783785; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EOXqPqomDY5NAmOBb/66KqDnP+k/LNaa1HXt0xFQ2zI=;
        b=FNh6wRokeH/ZCOx305hS36t3HW2+EwT+Do9ehclCuwwr+qGSa/GJbRNbSo96uup9MA
         Li4bnKCQCRy9YIIS2e/lT7F5Gvo5WsQHmOrEwdXsx9PRplZHbrZLmQ/f6wAO5vEp1cNJ
         8S/hqtBxJal+gGXb3n+j43uZKENhG3bdnMCLV3jZdVEg5EnA4XlhkRCiiru3cHhfYQ66
         dbEnFUUUUZWDuLg87insbdA0X9C/eUAknM1kuac6oUV4uvlBKmQg148blv2+ACJknt8F
         KEU97tU08Nj4/daV5QVi/yMqlQcLcSAT24sTu92N9W+UkAQx8LDPOrGPie/NK8PFC2LI
         Je6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746178985; x=1746783785;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EOXqPqomDY5NAmOBb/66KqDnP+k/LNaa1HXt0xFQ2zI=;
        b=wyRyfC0PSbDGdY4UNGCbEEXp143+xQlacjGnMpphw+3liW7zJQB2bsa0eEQLmMR7WE
         0HUh//Rnav8JwJlEL2BFF4V0A/4XJF+HYqM39/QREdhQrIZE2fZhq6rttbyOkr7pmnDT
         uNTcII3jXBBEPvO1pWT4PrI6ZBFhE9Rbb05Tlb6iMpefNc1MY3EoK3tOwSIiciqbfFjW
         Z7j15aRfy8V5m2NO6SNcWP2sTRAnUljTQyE30MJI2WanwK0zbrW5gdXPiWIOyrGGAMRe
         rjVuL6tcFTYPuOeKyKYtJg9DFidewX8ByQ6XKtGXNpY7wTS8sMY3vOykJKysSWqLrhve
         xoCA==
X-Forwarded-Encrypted: i=1; AJvYcCVBcenQu3ZunSqW4GCDZiXw0ZPPXcCPpRhvQXzEkADWgguq50vgWVZfI48NPhsyNDtptxdRDBJ64Cv2dmx634U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUEDT3NHuEbA9f/yf2GATgxtyM/3sQFdHID+tStyU25mQw4NkU
	iV8xt0dEC/CxUk+qFBp1jLEvMuOgVjFre3ZIaIkzWUjqjX2KmshmMLhpmUE0YQI=
X-Gm-Gg: ASbGncueWwr9tvRjPr+y7hiFh01FG05EX/rtEuSS28QCvlRpqEK9PtPL7jFQIFloqHV
	qTis0UnxYHFUF3Ov2F6LE6HfUhvT5t2jVU+gaLwg9vIJShCXBN7Lvc1eHl3d8nAD7RDvHDpdchF
	qDFRRKXSquLYMaJCjdUPVofBya+Fizp0J4dDpPejtYddORbmSVY/NnIqfrKtG9v6f1IMqEYl85v
	+wLJNryMsw9G28Q21dg9KQzqMsmIuuB2xgIOwjD5dF0l3jb8g8apWBDMufYkjdyGMMY4HKd9Ihi
	5QgJzLzE5FSYaEYa/WD7E0hAaZ78Eblt5P/PqPxr2R4=
X-Google-Smtp-Source: AGHT+IFgoRhv9PuW/EWdVGOS2zvRloJtSnlLvctJGmfk/l9H9pNgE/zk8qe2KUDmO+lth2FLCAP8OA==
X-Received: by 2002:a05:6402:d08:b0:5ee:497:89fc with SMTP id 4fb4d7f45d1cf-5fa7891aae1mr1661907a12.33.1746178985017;
        Fri, 02 May 2025 02:43:05 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5fa7781bf5fsm942719a12.36.2025.05.02.02.43.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 May 2025 02:43:04 -0700 (PDT)
Date: Fri, 2 May 2025 11:43:02 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Waiman Long <longman@redhat.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Tejun Heo <tj@kernel.org>, Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, 
	cgroups@vger.kernel.org, linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v8 1/2] selftests: memcg: Allow low event with no
 memory.low and memory_recursiveprot on
Message-ID: <vki6asa3arxitfgio3goox6hiyzmytxskoje6e2z55j3xrskly@4jq4btqz5nwd>
References: <20250502010443.106022-1-longman@redhat.com>
 <20250502010443.106022-2-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="55lyjcmxpait3n53"
Content-Disposition: inline
In-Reply-To: <20250502010443.106022-2-longman@redhat.com>


--55lyjcmxpait3n53
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v8 1/2] selftests: memcg: Allow low event with no
 memory.low and memory_recursiveprot on
MIME-Version: 1.0

On Thu, May 01, 2025 at 09:04:42PM -0400, Waiman Long <longman@redhat.com> =
wrote:
> Modify the test_memcontrol.c to ignore low event in the 3rd child cgroup
> with memory_recursiveprot on.
>=20
> The 4th child cgroup has no memory usage and so has an effective
> low of 0. It has no low event count because the mem_cgroup_below_low()
> check in shrink_node_memcgs() is skipped as mem_cgroup_below_min()
> returns true. If we ever change mem_cgroup_below_min() in such a way
> that it no longer skips the no usage case, we will have to add code to
> explicitly skip it.
>=20
> With this patch applied, the test_memcg_low sub-test finishes
> successfully without failure in most cases. Though both test_memcg_low
> and test_memcg_min sub-tests may still fail occasionally if the
> memory.current values fall outside of the expected ranges.
>=20
> Suggested-by: Michal Koutn=FD <mkoutny@suse.com>
> Signed-off-by: Waiman Long <longman@redhat.com>

Acked-by: Michal Koutn=FD <mkoutny@suse.com>

(Thank you. Not sure if this can be both with Suggested-by, so either of
them alone is fine by me.)


--55lyjcmxpait3n53
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCaBSTpAAKCRAt3Wney77B
SclRAP4sVLHHxS41vhM1p+JYRz4x68kM1ToNUs7M3I1xd7X9XQEA9Lg0Obh9pUcU
RmcQibMDF9amuynS7EPQ0DQjGlQ+lQ0=
=iotP
-----END PGP SIGNATURE-----

--55lyjcmxpait3n53--

