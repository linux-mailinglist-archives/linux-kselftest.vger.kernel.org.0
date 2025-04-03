Return-Path: <linux-kselftest+bounces-30062-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 74883A7A3E0
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Apr 2025 15:38:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBE1E18923FD
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Apr 2025 13:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EFBC25332D;
	Thu,  3 Apr 2025 13:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="LfzWIVBo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36B55252911
	for <linux-kselftest@vger.kernel.org>; Thu,  3 Apr 2025 13:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743687234; cv=none; b=fQXvgWWYCqrghsXQaQj/V7V7TQoQoCLe08vDsbwjnytuNq1qheSg4j7f8PLUNY7JnfwGJV/ce6UhtS/mXLGIhn1DeV97V999JjhDe1RVzTQLtrBPWIG0wtsQcpqKDKRZlIbmUIg058ciV0HRaksBegITn7X1na7/mNZeSIFefl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743687234; c=relaxed/simple;
	bh=Q07mWvgDiSZF+9VUo0WcTnHiHZHGL0kzb9D3hs8lea4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lj8SBDEePjNjReBq0lu5T6FK+7UkOXAxFIsIAf1whD4w4rOVC/OuUksGxtWlkXgwOh3wrfAHWgtUVsK1oRGkD/bWGjos4e8W/5+gXc6rbMQ7iAfereOozFqLEO/oo9mvsnEmJ2paUN7FG1yTP6AZiH6xJZ1en1+Ynjm60kz9+VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=LfzWIVBo; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-399749152b4so642577f8f.3
        for <linux-kselftest@vger.kernel.org>; Thu, 03 Apr 2025 06:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1743687230; x=1744292030; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Cb/KD7IWlOthI8ejHCX33gR2BZkT9SE1o2UTiT51BYM=;
        b=LfzWIVBohE3rdoNwFpKbYWfTxDM12NPk/H0nZWVO748r0S9rQn2wt5iW9p7d3G4xD5
         wXF1Z3QrQRGp20OtFnBIo6StQifkwHXX4+inBWfj9pSHtDrzkLabPUMsQHOCRPIkDe2+
         7USNC7AcRj5YzmxSFVs30DRZSLyOcM+DDYUoDLWgtCSEqalLCnXYU7+PyCZErbqn0/UQ
         jiqfQSoE8Or6XUiwdV+drlmQJByKNbCf8hpDnoMIE4GM5eahqvHBTeBvvK/vlnZ3yuH2
         QZYoZvG+Wa8l5/a1eOl5cyX3RPvH+3Wjbu8FJmXnnIksKoqwSxFx9yPCJYgLRwmhucD/
         Vigw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743687230; x=1744292030;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cb/KD7IWlOthI8ejHCX33gR2BZkT9SE1o2UTiT51BYM=;
        b=BOK8xgANSWlskH8n4mguxtgVz/6Dr6wfHZH/62vszhuVBBsM1bJO4eO+t2CQI1p+PL
         DO4GuKXcXyVPRfBSv2VnS84UglWIuXKQ7KaN4uepnru6synBCSQUR738AdJutzR6B3XH
         CniufR28PQ278i9vzYGgcaEn0RNQU8ZxmG3IZAFYyDsdaAC6KjfKj+40WJf7dDSiUUwO
         KsGu7xgt3M41NnvrB7EQ8aRWkIwScjCxIoppntbKYoALQhO4euTpUC+18tXKth76DRHQ
         td2HFJ6Do1xV/J2rdk6yb5b4U/a9+q0jFDo3rkJKiBbXUbKjIdUi61sRKqUCUCM+e+Lh
         qoLw==
X-Forwarded-Encrypted: i=1; AJvYcCWj8eGUdbzka/rC5QiYuAQDlZ7ax/QM9SSj7JyQ3TTP9yvhCHgtTmvUjAn7xt09gJQgZsu6srIQ3DawjwB2Olg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/mycxIT6/yAlBUPKDY67bOxmTYBm+DgD77aM+pNvLeTeqRxKz
	uTH66dZueZhLjAMonb9qOZZqE/XjLGeSBkDOu/3+KMaGnSnmIEhdIYPJI+0gLcY=
X-Gm-Gg: ASbGncu2VzaD7Siv5JxsOuE+s0l8HWv7n3jDxERutvxzl0IjjkMZ2xzcfRq9zkEIFtd
	txkhdnFTD5z7qsvWHpQb0Pu2bKjI4H1u9s8hf020ss7lW/9sC+iA84CtV3+g7gxXC9+JJgIXluK
	+Wy5sW13rIxbQojZZuaAqjD1H6uC3Hqqg8QUG2zOR6gCWahyfy0FcaM1ZTMTNyPAs7WGsyBLQYn
	/J/bZh0Ofw3+zItsBJ/cBSB/PK/JJw3McqwJGZIwI3X0Wpkt6h/5jRV9lTQjQW3xPlWWUMSb846
	so4a7Vi6EEDSVrYaGpU8Jrdzhs3KgWAtiy4v/V8XW07g2EA=
X-Google-Smtp-Source: AGHT+IGOeun1szqzJaIz2NJQIc9/iKO4ZbIcGfY69/y5m+JQZGEzXRK+PyNfyfrTvktlbhWekNevrQ==
X-Received: by 2002:a05:6000:2902:b0:391:3157:7717 with SMTP id ffacd0b85a97d-39c3033ae28mr2293896f8f.34.1743687230579;
        Thu, 03 Apr 2025 06:33:50 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c301a7225sm1816334f8f.26.2025.04.03.06.33.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Apr 2025 06:33:50 -0700 (PDT)
Date: Thu, 3 Apr 2025 15:33:48 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Waiman Long <longman@redhat.com>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Shuah Khan <shuah@kernel.org>, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 07/10] cgroup/cpuset: Remove unneeded goto in
 sched_partition_write() and rename it
Message-ID: <t5gojwcnwdb36ppkhq6hpujmyatckg5wd5eigsnmt2kndfofe7@ymc7tiury62o>
References: <20250330215248.3620801-1-longman@redhat.com>
 <20250330215248.3620801-8-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bgvd7fl2ji2twwup"
Content-Disposition: inline
In-Reply-To: <20250330215248.3620801-8-longman@redhat.com>


--bgvd7fl2ji2twwup
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 07/10] cgroup/cpuset: Remove unneeded goto in
 sched_partition_write() and rename it
MIME-Version: 1.0

On Sun, Mar 30, 2025 at 05:52:45PM -0400, Waiman Long <longman@redhat.com> =
wrote:
> The goto statement in sched_partition_write() is not needed. Remove
> it and rename sched_partition_write()/sched_partition_show() to
> cpuset_partition_write()/cpuset_partition_show().
>=20
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  kernel/cgroup/cpuset.c | 15 ++++++---------
>  1 file changed, 6 insertions(+), 9 deletions(-)
=2E..

Also noticed (here or for the preceding comments&cleanup patch):

--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -3525,8 +3525,8 @@ static int cpuset_css_online(struct cgroup_subsys_sta=
te *css)
  * in the default hierarchy where only changes in partition
  * will cause repartitioning.
  *
- * If the cpuset has the 'sched.partition' flag enabled, simulate
- * turning 'sched.partition" off.
+ * If the cpuset has the 'cpus.partition' flag enabled, simulate
+ * turning 'cpus.partition" off.
  */

 static void cpuset_css_offline(struct cgroup_subsys_state *css)


Next time...

--bgvd7fl2ji2twwup
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZ+6OOgAKCRAt3Wney77B
Se2AAQDOabbdX+KFiR+uz9cakVFtI5Fcv68ZnaABDprIt9e9ZQEAhpLShxYbiO8G
AVAavan6wMIIW9sN9bq1d6mXXD4Vjgk=
=JSS+
-----END PGP SIGNATURE-----

--bgvd7fl2ji2twwup--

