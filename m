Return-Path: <linux-kselftest+bounces-10557-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 625338CB8A8
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 May 2024 03:48:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 803E71C20919
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 May 2024 01:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17C671FA1;
	Wed, 22 May 2024 01:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="ugs/WyKw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sonic317-39.consmr.mail.ne1.yahoo.com (sonic317-39.consmr.mail.ne1.yahoo.com [66.163.184.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 337F228EA
	for <linux-kselftest@vger.kernel.org>; Wed, 22 May 2024 01:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.184.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716342482; cv=none; b=nuhkafFXqraWgLhXRq9Rk2koEAO1RTTy4BtcSo/6wsWr/tb95mrpC0ka6sRZXS9sZ575LeTmKbIIMlKIIAA+bRElHFEq0mVKp0jp0a8orwgM39U+u45UXrs03aOKzrDAG0Q5qeGsW+l/FHn/sD9qM3S2uqitbfcJ0gjV7V6a7iA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716342482; c=relaxed/simple;
	bh=MZVe26BMPdvP8BLcp/KzGhheqUTEjkEcZE0Q5/XFoOo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fCY5++roxJkhr7yZeEOLkIO4XdujJWUxVA9d1RdEtRyELp/uTO8Onl6JA6o0W0mFgNRoP9tty00321eXapygjXcya20c8qTiPb7y8tc9VEgkpQ3Yc3LaoycB1pyQstUi1fR2d5UNoVH3byAQJHdx0yxlEMZbHCVroR7gYh3/inc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=ugs/WyKw; arc=none smtp.client-ip=66.163.184.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1716342479; bh=K4ceCAMUd3OOguRCiqyTBlmv17C7zQy/D1e8nEr4anQ=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=ugs/WyKwnOpUHhXMLlgaYGF0j9Lc6etHMvK28/YcxxZaAh4vUioLp424/d4wruW9j05DuLZ/nmVtANik5PHSIW8l0589Gb83jyH08j50hOOfcCOMKqhwhAZODJcZyjkoYBv62S1neqUBXUVLqFoXJJWO29noNpolg5+o2q878zNmDbgwJbZIbNqT+TXdZtpDWHnrwXetXgAeo4k4UTKTpZPpD+DpPcCJX7OHg4jT9pZWFFtLbH05UyZf63gWmurlmVzxqBGqWMqgygiXU3Vj7YcLsfyvKfvTEGTxXfOhX8CuAO4gd64HwsGB3lvgXUuL5UArQupglwyIrnb+8TM/kw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1716342479; bh=TN9BDkQWHsmEF7czjLiXFIjNqGuzdHZg7OvYbomuPZu=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=ciWRgxrVSFtGuP0FxAMzxsrKa3T3QAR/NlYGPUlurC8Ab1OLXsSjEpta9xEImUt8Sl4dye/0+MjDGTvnKaPJJrMqdBst1ego5rUR0HLHjOaFq3scPwdcs8IbWd2kAnuZK6ZhyYbt7dbChzENy/tszEyk7133vrbVXeizzTC8zJ3TH24l5Ew3TTwq1zkaCZgGopk8WyA4phpKPQHzNrjqkwrq/UoJcHocaybVwUPGFE3zndcssgtF7zr6Saz6rrZek9L55eHAUhdt7CvB2eYwg67eJA2OODD29ISir5JB/Ugqm/jQKCHDqq7hdd78GjoUmgys4c8FgInnvnb2a6QoPw==
X-YMail-OSG: rb2W.CAVM1nn7ILuoqlSMVNWYt6G71IbQJ9C1HKd_egYmcdPyshvCQkau2uqHmg
 V3gDzX4MCvbm1s3h6dFstKiJHo0AzxprRnuQDGqR483yok1wJxyctaKFnTfm0G1M4mkfQ9MtlHs2
 kufxSKI0RMU6ZQoe4qnH.AKFJKZZa2j5pHTqs6fg1BHsCVmwJCSQVJcc2csAXuUIXrv4S9PrOzPy
 lY0h1fX9_UCOjjwOTwlp7k0RFzjHJ68s5Xn8SwQFuG7dBQS5zv3Jj7F_I3fgMO4GB1d7G3y_en4K
 LJjY7l7t1esBBF5EmWPkjJP_SzercipYtoBQEicP3BbaVoxj.muoG854TuB7sW77ujQsXY_bxAET
 rECUYPx_CAi8aRCZmQAv8UUuForZc5i2wG3_OCpysheSebAy.m0lEMecot8ONlajAC70zJyyImFa
 4eHazUYGu9LxQWkht1UJ4talEPeFlQkqHYQmfrI2l6Fw.5Mk8tTnslGtAXC1RY7mb63ZlMKgMCPc
 enELx11AEdl4KjqV58inLw4bKXi6IGG2g8kApCArEXNC3d8n0VedAcFEVFzD2RtXgOWhSQ4xEvoK
 qC3V74GmO8FxOyvaWtAwvof2CYFvK1uYvYrLDmRBUPmWkDC6hexAUKCMtY6L8spNW.q.5vveN.9E
 QAvp2CGyy3izc9wVa6CApmhNucVpKP2_UsQQU6ZhFXGff8d_ahQ.qwuvrV1yBhdGv9i7lShD34Hl
 JCmhyobP9uMtNmcHNyHnwBCfcaxi5q7JBz7XlyBkTFYSi.c8R4deeSgUbv4SJ728RrGHDFrs0McL
 w3tg4xv9cr32JOq3CVhooyneAwu6pdKP2e4EvrOAkq3cXYdt6c09klBaQAuzhGfUWRfxne_K9bT4
 TCAX4IXb2A7Fox.ZKLsg3U.NY.7_1Rd5udexmFFP60nuxfGak6MaoAzL0We06kJ9ZXOszkJ7H.r1
 kYeZ5UxHsU0vrDYAqYIML2q9xuLhvZkHQJ.5J9f43t8wjt4QROThQLxzTYAx6QykkKaT0ElOwQ83
 4HT42bO02OXfhvqDWBtq4XTUIxlI4x03ku8Bf8Q6VX0h9i5v_9UBOWlQ8_o.45KN.IJ52JX7u7qI
 q1T8_oR03xpxggBH1k4uUPLK_ZbyAcNIAStrSQbMGdx4VCM_g_FsFpmq3RBBNLa.QYrb142GelY8
 h27qRCIz8dL.CZQU0Kvfow5mPV8UKc54mdOZG9RLaynwuFgKG7EF5Gcldg3LgISLFH4cYR35YitR
 g2mhUEKgYpOauWAVQAN2wt03pxI_dFOUZwh5D2PN0Y62xh8.z8Uad_nZGZk3vsMCQQ7trvTyNWZG
 DJZd9jetcMZJRmhPoGWFH8QbA7Y_0mny4K88VoF1rrEl5nqtGIVqLPejPtMblyq8MLkAaVS_hVjo
 LPyJmrbjeUgJZTTPTi14kUmIBES9Q0HIpRbKoGnHiukGzLCtrunI5CRTkKBeK7e2CBth82UX_8mS
 WvvB_Hvgu3EBTLm9GJaVZUks4tpiXQ80ci1zVFtC8sOHXlSJreGDOvEnJl_jg2QLPEkgx9D36qox
 n19FmHxMmOnUlGWWkJFwRMLbhuYJTAsDVYDFVA69nPqXQ8ePmWDzRA_TgBQV7iL7P1.V_gk3o5Fs
 tvNkkhxECcdszebEhteGYlzYsh14.DIfNkYEppJ1TcEkzcHn6HRrJMZ10jOAGCJXQALPu_pWCExa
 rT7oIcsJV5sPD3C6hi3s34.mFwd0kVtnF00FrM2V49EiRKahMv5HSjNYFom66BHBUKhwWTDzEyl.
 hfKXEZAbrk0pLHvQwmEJWzRjeS8wCMTaXYJ.fKT5F_.q36xr_Q1fK5wmyg8nh6YxkuTqP2sVaQWe
 sOH9YFmIIftB156jy8tl_7C6N8d4ffx.q5JEkMgK7xLoZ1Ul6rd8hAJvNDxx3diEXVzUny1FpmJL
 rqLLJYx5vUdHrlk_j2aw_5LW8xM2Zwta29e0ilFkmZETh6un35X_ZaJD3cMNZZzaKCGGS1xrtdu.
 RDwOU8FqtbX9PNBSTHux7VPqC7w5cQRzJPnS9cvpMH8w0tMaNWLIxG5rtB1MFaU8rbeD50RtnATp
 4WJRrFDWcU0dBPRAUhBT4HmuK54i0CHcFBEdzRaqhlothLGEh_8GIPWP9k8jKz7tABormleib9Py
 Eeq6myb.haTs3APIir3NRVM1Vmnnh8aNvOq1pVq.tv.qWdUmreoDdRduI6ITot6zI3JfN.6w.g1G
 DMgP4TTiohcV8.SfNoFmh7yhU8MNRLlb4bYX9Z5GVYxQGZt9JIwCb..y.bdJ5Z8ZM
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 47ee3241-7a52-4eda-bec9-01823c7c6fd7
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.ne1.yahoo.com with HTTP; Wed, 22 May 2024 01:47:59 +0000
Received: by hermes--production-gq1-59c575df44-8sqjb (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 95637bea4982e23cda54aebcf40e6a2a;
          Wed, 22 May 2024 01:37:49 +0000 (UTC)
Message-ID: <ce499a0d-fc35-40cd-aa6e-c100551d137c@schaufler-ca.com>
Date: Tue, 21 May 2024 18:37:46 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 27/68] selftests/lsm: Drop define _GNU_SOURCE
To: Edward Liaw <edliaw@google.com>, shuah@kernel.org,
 =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
 =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>,
 Christian Brauner <brauner@kernel.org>,
 Richard Cochran <richardcochran@gmail.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, Paul Moore <paul@paul-moore.com>,
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 kernel-team@android.com, linux-security-module@vger.kernel.org,
 netdev@vger.kernel.org, linux-riscv@lists.infradead.org,
 bpf@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>,
 Muhammad Usama Anjum <usama.anjum@collabora.com>
References: <20240522005913.3540131-1-edliaw@google.com>
 <20240522005913.3540131-28-edliaw@google.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20240522005913.3540131-28-edliaw@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.22356 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 5/21/2024 5:57 PM, Edward Liaw wrote:
> _GNU_SOURCE is provided by lib.mk, so it should be dropped to prevent
> redefinition warnings.
>
> Reviewed-by: John Hubbard <jhubbard@nvidia.com>
> Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> Signed-off-by: Edward Liaw <edliaw@google.com>

Acked-by: Casey Schaufler <casey@schaufler-ca.com>

> ---
>  tools/testing/selftests/lsm/common.c                 | 2 --
>  tools/testing/selftests/lsm/lsm_get_self_attr_test.c | 2 --
>  tools/testing/selftests/lsm/lsm_list_modules_test.c  | 2 --
>  tools/testing/selftests/lsm/lsm_set_self_attr_test.c | 2 --
>  4 files changed, 8 deletions(-)
>
> diff --git a/tools/testing/selftests/lsm/common.c b/tools/testing/selftests/lsm/common.c
> index 9ad258912646..1b18aac570f1 100644
> --- a/tools/testing/selftests/lsm/common.c
> +++ b/tools/testing/selftests/lsm/common.c
> @@ -4,8 +4,6 @@
>   *
>   * Copyright © 2023 Casey Schaufler <casey@schaufler-ca.com>
>   */
> -
> -#define _GNU_SOURCE
>  #include <linux/lsm.h>
>  #include <fcntl.h>
>  #include <string.h>
> diff --git a/tools/testing/selftests/lsm/lsm_get_self_attr_test.c b/tools/testing/selftests/lsm/lsm_get_self_attr_test.c
> index df215e4aa63f..7465bde3f922 100644
> --- a/tools/testing/selftests/lsm/lsm_get_self_attr_test.c
> +++ b/tools/testing/selftests/lsm/lsm_get_self_attr_test.c
> @@ -5,8 +5,6 @@
>   *
>   * Copyright © 2022 Casey Schaufler <casey@schaufler-ca.com>
>   */
> -
> -#define _GNU_SOURCE
>  #include <linux/lsm.h>
>  #include <fcntl.h>
>  #include <string.h>
> diff --git a/tools/testing/selftests/lsm/lsm_list_modules_test.c b/tools/testing/selftests/lsm/lsm_list_modules_test.c
> index 06d24d4679a6..a6b44e25c21f 100644
> --- a/tools/testing/selftests/lsm/lsm_list_modules_test.c
> +++ b/tools/testing/selftests/lsm/lsm_list_modules_test.c
> @@ -5,8 +5,6 @@
>   *
>   * Copyright © 2022 Casey Schaufler <casey@schaufler-ca.com>
>   */
> -
> -#define _GNU_SOURCE
>  #include <linux/lsm.h>
>  #include <string.h>
>  #include <stdio.h>
> diff --git a/tools/testing/selftests/lsm/lsm_set_self_attr_test.c b/tools/testing/selftests/lsm/lsm_set_self_attr_test.c
> index 66dec47e3ca3..110c6a07e74c 100644
> --- a/tools/testing/selftests/lsm/lsm_set_self_attr_test.c
> +++ b/tools/testing/selftests/lsm/lsm_set_self_attr_test.c
> @@ -5,8 +5,6 @@
>   *
>   * Copyright © 2022 Casey Schaufler <casey@schaufler-ca.com>
>   */
> -
> -#define _GNU_SOURCE
>  #include <linux/lsm.h>
>  #include <string.h>
>  #include <stdio.h>

