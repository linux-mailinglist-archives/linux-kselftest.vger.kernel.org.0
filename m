Return-Path: <linux-kselftest+bounces-30264-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77076A7E490
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Apr 2025 17:34:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2318E442BAC
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Apr 2025 15:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DA001FF1DE;
	Mon,  7 Apr 2025 15:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="YxrS4pTq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D99681FF1AB
	for <linux-kselftest@vger.kernel.org>; Mon,  7 Apr 2025 15:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744039522; cv=none; b=t2/u30K6gG6prMdJ/j2PtpXMoNaiWeMxQ0RC9gKjPMDQYgXYPcgVtUKo9MnDIFZ9HknxSFaVxN+9kJbncw89xHskcmdkF4enN2tQ+CgcTV5tWxA7K7/dLtdSzowTAHV1aztjauArqO9pPgYJrjQBEmj/ljCO9NaqHxVhGUFy8ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744039522; c=relaxed/simple;
	bh=P/Ks5ThkyG4NgbSPXxPyQOvCZo0EyEbEsiYV97hCPbY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BHF2rirUWX3IJhfCAHkdMQDhy5KL1EltIKnXeWv7/3ej4FidZLikbeLVfC2g9xKZRF1nJeFii/dKaS4LIMt7BxLmoI2AtIjhFSbrGB6kTUB2Q8xLgu6vE0UMFVpoMXUbG9qjwQKyzFEY3jWhHeo0TcDJgijvuPX8EH7oi8PnG5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=YxrS4pTq; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43cf06eabdaso42031145e9.2
        for <linux-kselftest@vger.kernel.org>; Mon, 07 Apr 2025 08:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1744039518; x=1744644318; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rBI/ctOg6rttQTImP8b9T2x38eCYUNV1RiePYdYKl88=;
        b=YxrS4pTqEbn8hx1OqpN7VI3d1itcVhX6fPAnLD2BmN5FbOSrp05YzUtKKTtt0zX1Sy
         O81POSo1wvCeLOaDXfoqaTymFaCvq07zPXoC8hFIQhAn9VCQ9v6JzRNjOaE84pozzT4y
         DpOHh+NnBi0sCgMJKfGhHDiVnxH30W5+gsZPkdMAW2e+dZrt2XNvDPuFo1s/7IRc5+7x
         neDmuBORgGlfMgXOb37Xc6piukpuXd79TShQsQYxOws3PspwPfvQZBiV/HJ/pFKRP9N4
         hI6BIJQA/d25Qp8iIj1iukTY9s1hKCy2ls1sxNLX3Z49to+40bDCy1QK0d9WVcbeOkw5
         /aYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744039518; x=1744644318;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rBI/ctOg6rttQTImP8b9T2x38eCYUNV1RiePYdYKl88=;
        b=FBVrbltbO+liEUpNzwyLSaBMpreqh+rgTKov8A0DnLS3vp+ffzwnaUJInfVrVtvmpJ
         UqP9B6QQ4eA1T8iYkQbPeVa4SnADQFeGyqev5O0/QLBAT5qB/WsoM+3NRarROJEAwzpN
         fuPqd3rOE+BkXp4uwTi+e7bAzIr8tEp4zRIzgwNMIH/XTs8+1ZqH4/EDp/CfMn+1M4TS
         iCn7yVbJs3orwQ8doTqj1KFQ+qPmfyw7nAo1q6eRvpRA2R0RegfwahkkYrho4SSUzcry
         oEq2HjMcQ095mTEcK1I9F74eNBVaZ+QPOWJcz/s+X0ZkMm+BT/dEOIS5GBJZOJDTVS7Z
         BR5g==
X-Forwarded-Encrypted: i=1; AJvYcCUxRj1MqvqOTCqWHcm5Uu+A94uHky2Rby7i4B+LlBtrNmHRC0v2s1t7Z+GXbIWIfXguuICkde7bLlSxJQxVBkY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKPUxBcKjd9EL1c2hMhWgaUMx9EYuSWokZLWpO6/gtNewnkIUY
	hGuNWHgd12Bz/QjtQa2wiPaMXeAPD4BV1Pm7m0jw1omxle28z/9JdH2PW10Fqzc=
X-Gm-Gg: ASbGncvEjh5vip7a5GvP257sgCIINL2GY+MXcsUkHEBHomO4lcDYHCnHBKEHAj6cC+9
	9sdariQvsV/6h96EIi3gqxczhB7ozIQv5aZRx8DK3csmukf7PLCTJu3FyMYB78K5yl/gMV9ajfw
	Kags/5sU6CdYj5nmXHv7BKg/hGPW7Yng1Oicbu7XbfsxChDVhnIW72y0eNOmcvpqQc1KCqEn20K
	Up8DsbSn3rHZY3xYBQoCQ+GHKljk7p/xHXxnjJQvl8sgUETOugTbCQXDK8Y555aj+YKshXmVgGn
	4LSye3yTr02b9SosHbUllEK3obKpo8DwBk+Gd/Pw16fC/bJOTKAhKhL8EA==
X-Google-Smtp-Source: AGHT+IEuUH3J67sjhqDoixk/QkJ0y0B2AA37FiOvvQzo5BNHB8IYmL/PuWEwjrbhfyj5yQcGP3H1UA==
X-Received: by 2002:a05:600c:3b08:b0:43d:b85:1831 with SMTP id 5b1f17b1804b1-43ecf585cacmr129997875e9.0.1744039518078;
        Mon, 07 Apr 2025 08:25:18 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ec34be2ffsm132570725e9.22.2025.04.07.08.25.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 08:25:17 -0700 (PDT)
Date: Mon, 7 Apr 2025 17:25:15 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Waiman Long <longman@redhat.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Tejun Heo <tj@kernel.org>, Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, 
	cgroups@vger.kernel.org, linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v4 1/2] mm/vmscan: Skip memcg with !usage in
 shrink_node_memcgs()
Message-ID: <awgbdn6gwnj4kfaezsorvopgsdyoty3yahdeanqvoxstz2w2ke@xc3sv43elkz5>
References: <20250407014159.1291785-1-longman@redhat.com>
 <20250407014159.1291785-2-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lu3xupyh5hd532gg"
Content-Disposition: inline
In-Reply-To: <20250407014159.1291785-2-longman@redhat.com>


--lu3xupyh5hd532gg
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH v4 1/2] mm/vmscan: Skip memcg with !usage in
 shrink_node_memcgs()
MIME-Version: 1.0

Hi Waiman.

On Sun, Apr 06, 2025 at 09:41:58PM -0400, Waiman Long <longman@redhat.com> wrote:
 ...
> diff --git a/tools/testing/selftests/cgroup/test_memcontrol.c b/tools/testing/selftests/cgroup/test_memcontrol.c
> index 16f5d74ae762..bab826b6b7b0 100644
> --- a/tools/testing/selftests/cgroup/test_memcontrol.c
> +++ b/tools/testing/selftests/cgroup/test_memcontrol.c

I'd suggest updating also the header of the test for clarity and then
exempt the Child 2 ('E') conditionally from comparisons, something like:

@@ -380,10 +380,10 @@ static bool reclaim_until(const char *memcg, long goal);
  *
  * Then it checks actual memory usages and expects that:
  * A/B    memory.current ~= 50M
- * A/B/C  memory.current ~= 29M
- * A/B/D  memory.current ~= 21M
- * A/B/E  memory.current ~= 0
- * A/B/F  memory.current  = 0
+ * A/B/C  memory.current ~= 29M, memory.events:low > 0
+ * A/B/D  memory.current ~= 21M, memory.events:low > 0
+ * A/B/E  memory.current ~= 0,   memory.events:low not specified (==0 w/out memory_recursiveprot)
+ * A/B/F  memory.current  = 0,   memory.events:low == 0
  * (for origin of the numbers, see model in memcg_protection.m.)
  *
  * After that it tries to allocate more than there is
@@ -527,6 +527,7 @@ static int test_memcg_protection(const char *root, bool min)

        for (i = 0; i < ARRAY_SIZE(children); i++) {
                int no_low_events_index = 1;
+               int ignore_low_events_index = has_recursiveprot ? 2 : -1;
                long low, oom;

                oom = cg_read_key_long(children[i], "memory.events", "oom ");
@@ -534,6 +535,8 @@ static int test_memcg_protection(const char *root, bool min)

                if (oom)
                        goto cleanup;
+               if (i == ignore_low_events_index)
+                       continue;
                if (i <= no_low_events_index && low <= 0)
                        goto cleanup;
                if (i > no_low_events_index && low)

--lu3xupyh5hd532gg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZ/PuWQAKCRAt3Wney77B
ScwcAP46No9qCK9KNhyaGyrJbha1L6AsoeFeO9BW0ZboeZ5NRAEAvEX67kbDxGFX
Obe817O6E0lDvyjPXo6bT4YSjrBk1AQ=
=yLF8
-----END PGP SIGNATURE-----

--lu3xupyh5hd532gg--

