Return-Path: <linux-kselftest+bounces-3238-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67CB6832971
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Jan 2024 13:25:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C704D1F2270F
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Jan 2024 12:25:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D65A34F1F9;
	Fri, 19 Jan 2024 12:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nRIJi05e"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F784F1F7
	for <linux-kselftest@vger.kernel.org>; Fri, 19 Jan 2024 12:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705667119; cv=none; b=bX2nqFZcC6Vs0D4T5/Y9Dr5iwSEhTc4cmwcq24dqMY6KHztFW2gwimrntWwjAnLnqFZLMzogUIQudL8PerIgzlMzJeKAlrmItoiHghdERHu8cLGmxIayrezabX7QRxKzuaEROCB3vTOFuNiDJ/HdqusSY4G33tsRo5K5SCONQUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705667119; c=relaxed/simple;
	bh=ZS0ZTPOjGc6lI63HpJAJlldEv1yKly/eF/9Lh48ayGg=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Cc:Content-Type; b=TKj6blbG9ja5DinY45JpFsWa39eXZPF1IbHAdLNfT12LtGqBC3AADXjowBZLB+4/jeqj2W4E6l/c213GnvswlZA/dwLpq1DBwb5VNPcA/gouVBDE9T3L9IsEJKDGcOXj7wWgILsk30xOtP6DwKiy9oDYZs2lOngXVK0Th7HTh7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nRIJi05e; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-a26f2da3c7bso32468566b.0
        for <linux-kselftest@vger.kernel.org>; Fri, 19 Jan 2024 04:25:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705667116; x=1706271916; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rR3njcONhtC8J922vl6MVAIIW2xC/rVokflXfUhJWc0=;
        b=nRIJi05e360/9AGvLSolLDAl1/24P6LobIFPE8TmTyE3g7yxMVFd8p6QrdJpJhltfb
         puZ0tvvTAs7lnt2oJnAjRdMFAwEcZoRz3t2vXDOQYEEMHUIyNu2AZOn5cpvDiICIottT
         BSFZJ+NrrUItWfwWBWbBv/FhVSc53oxX728skFHcwFqa53bPN1iey0DmJJ4zFt04hIqo
         yUO/8AKhF6c+ZdbOzJdeBJd+F9obSQY7t+Bzwr/lb2v9Aq4AscdWaoTvE7zA5ek4SlTa
         uE63G/TQgI4QztS61HD7qR0lDS3vwUHsD9Yj+39RfJMYv/d/REjVKfdHYxpUuwmQcqdH
         VNSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705667116; x=1706271916;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rR3njcONhtC8J922vl6MVAIIW2xC/rVokflXfUhJWc0=;
        b=gXRaGmY36IEwzqPPUnVZ7qn6B/MQKh899bowe6tGYRSO018FtcYvBuMLg6+OmmPh3f
         8jH883zvcXIsjn2h6ga9xhtFnNZd3sCjXqfVs2mRZ68ApJ273f5oVwEr4BlUWiVNFdas
         rE/7ys1+QqVUFs/u2+GnWljMGo7QPN3w1BIhbsszz1nxKcnBhj14q3USL1SEakvzyeoq
         zcIPUCeVi+12Jeb8AKN42ggLvP+zjhaPPFazK3WATC3Yiy7f2rmL3kcT0TImvqJB7xM7
         E9NAN59ZZHfVYTMX8iNrnGo2V8m/sNP6/62VMrq5cE5a5ouBRa3OIw83WOOMbBp9zXwI
         pLYQ==
X-Gm-Message-State: AOJu0YzsE15ykyICFnFrXVEKh75RP6YgVdyDPT5K8TDh1c0dw45e2E8H
	vYg+4LvMSd/oZBotzB6UqiI67/NVre1frvOIxHm/GPxY63nGCGg5e+cu+TnSfuRs/DvlgnPnPxl
	R6w==
X-Google-Smtp-Source: AGHT+IHVIT55Mt5VgtIJNsN64bdg7wrUhBEIuOEoxI+kZxG2c4JHW1zm9YIhS9sfxBy1EYcyi85eGaPLzCU=
X-Received: from sport.zrh.corp.google.com ([2a00:79e0:9d:4:7db4:85cd:a87c:3b15])
 (user=gnoack job=sendgmr) by 2002:a17:906:588:b0:a2c:4f84:13ab with SMTP id
 8-20020a170906058800b00a2c4f8413abmr6665ejn.7.1705667115922; Fri, 19 Jan 2024
 04:25:15 -0800 (PST)
Date: Fri, 19 Jan 2024 13:25:06 +0100
In-Reply-To: <20240118113632.1948478-1-mic@digikod.net>
Message-Id: <Zapp7vIrAaNmCsS7@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240118113632.1948478-1-mic@digikod.net>
Subject: Re: [PATCH v1] landlock: Add support for KUnit tests
From: "=?iso-8859-1?Q?G=FCnther?= Noack" <gnoack@google.com>
To: "=?iso-8859-1?Q?Micka=EBl_Sala=FCn?=" <mic@digikod.net>
Cc: Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, James Morris <jmorris@namei.org>, 
	Jeff Xu <jeffxu@google.com>, Paul Moore <paul@paul-moore.com>, 
	"Serge E . Hallyn" <serge@hallyn.com>, kunit-dev@googlegroups.com, 
	linux-kselftest@vger.kernel.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Thank you, this is really nice!

Only tiny style nitpicks here.

Reviewed-by: G=EF=BF=BDnther Noack <gnoack@google.com>

On Thu, Jan 18, 2024 at 12:36:32PM +0100, Micka=EF=BF=BDl Sala=EF=BF=BDn wr=
ote:
> Add the SECURITY_LANDLOCK_KUNIT_TEST option to enable KUnit tests for
> Landlock.  The minimal required configuration is listed in the
> security/landlock/.kunitconfig file.
>=20
> Add an initial landlock_fs KUnit test suite with 7 test cases for
> filesystem helpers.  These are related to the LANDLOCK_ACCESS_FS_REFER
> right.
>=20
> There is one KUnit test case per:
> * mutated state (e.g. test_scope_to_request_*) or,
> * shared state between tests (e.g. test_is_eaccess_*).
>=20
> Add macros to improve readability of tests (i.e. one per line).  Test
> cases are collocated with the tested functions to help maintenance and
> improve documentation.  This is why SECURITY_LANDLOCK_KUNIT_TEST cannot
> be set as module.
>=20
> This is a nice complement to Landlock's user space kselftests.  We
> expect new Landlock features to come with KUnit tests as well.
>=20
> Thanks to UML support, we can run all KUnit tests for Landlock with:
> ./tools/testing/kunit/kunit.py run --kunitconfig security/landlock
>=20
> [00:00:00] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D landlock_fs  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> [00:00:00] [PASSED] test_no_more_access
> [00:00:00] [PASSED] test_scope_to_request_with_exec_none
> [00:00:00] [PASSED] test_scope_to_request_with_exec_some
> [00:00:00] [PASSED] test_scope_to_request_without_access
> [00:00:00] [PASSED] test_is_eacces_with_none
> [00:00:00] [PASSED] test_is_eacces_with_refer
> [00:00:00] [PASSED] test_is_eacces_with_write
> [00:00:00] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D [PAS=
SED] landlock_fs =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [00:00:00] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [00:00:00] Testing complete. Ran 7 tests: passed: 7
>=20
> Cc: G=EF=BF=BDnther Noack <gnoack@google.com>
> Cc: Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
> Signed-off-by: Micka=EF=BF=BDl Sala=EF=BF=BDn <mic@digikod.net>
> ---
>  security/landlock/.kunitconfig               |   4 +
>  security/landlock/Kconfig                    |  15 ++
>  security/landlock/common.h                   |   2 +
>  security/landlock/fs.c                       | 234 +++++++++++++++++++
>  tools/testing/kunit/configs/all_tests.config |   1 +
>  5 files changed, 256 insertions(+)
>  create mode 100644 security/landlock/.kunitconfig
>=20
> diff --git a/security/landlock/.kunitconfig b/security/landlock/.kunitcon=
fig
> new file mode 100644
> index 000000000000..03e119466604
> --- /dev/null
> +++ b/security/landlock/.kunitconfig
> @@ -0,0 +1,4 @@
> +CONFIG_KUNIT=3Dy
> +CONFIG_SECURITY=3Dy
> +CONFIG_SECURITY_LANDLOCK=3Dy
> +CONFIG_SECURITY_LANDLOCK_KUNIT_TEST=3Dy
> diff --git a/security/landlock/Kconfig b/security/landlock/Kconfig
> index c4bf0d5eff39..3f1493402052 100644
> --- a/security/landlock/Kconfig
> +++ b/security/landlock/Kconfig
> @@ -20,3 +20,18 @@ config SECURITY_LANDLOCK
>  	  If you are unsure how to answer this question, answer N.  Otherwise,
>  	  you should also prepend "landlock," to the content of CONFIG_LSM to
>  	  enable Landlock at boot time.
> +
> +config SECURITY_LANDLOCK_KUNIT_TEST
> +	bool "KUnit tests for Landlock" if !KUNIT_ALL_TESTS
> +	depends on KUNIT=3Dy
> +	depends on SECURITY_LANDLOCK
> +	default KUNIT_ALL_TESTS
> +	help
> +	  Build KUnit tests for Landlock.
> +
> +	  See the KUnit documentation in Documentation/dev-tools/kunit
> +
> +	  Run all KUnit tests for Landlock with:
> +	  ./tools/testing/kunit/kunit.py run --kunitconfig security/landlock
> +
> +	  If you are unsure how to answer this question, answer N.
> diff --git a/security/landlock/common.h b/security/landlock/common.h
> index 5dc0fe15707d..0eb1d34c2eae 100644
> --- a/security/landlock/common.h
> +++ b/security/landlock/common.h
> @@ -17,4 +17,6 @@
> =20
>  #define pr_fmt(fmt) LANDLOCK_NAME ": " fmt
> =20
> +#define BIT_INDEX(bit) HWEIGHT(bit - 1)
> +
>  #endif /* _SECURITY_LANDLOCK_COMMON_H */
> diff --git a/security/landlock/fs.c b/security/landlock/fs.c
> index 9ba989ef46a5..a2fdbd560105 100644
> --- a/security/landlock/fs.c
> +++ b/security/landlock/fs.c
> @@ -7,6 +7,7 @@
>   * Copyright =EF=BF=BD 2021-2022 Microsoft Corporation
>   */
> =20
> +#include <kunit/test.h>
>  #include <linux/atomic.h>
>  #include <linux/bitops.h>
>  #include <linux/bits.h>
> @@ -311,6 +312,119 @@ static bool no_more_access(
>  	return true;
>  }
> =20
> +#define NMA_TRUE(...) KUNIT_EXPECT_TRUE(test, no_more_access(__VA_ARGS__=
))
> +#define NMA_FALSE(...) KUNIT_EXPECT_FALSE(test, no_more_access(__VA_ARGS=
__))
> +
> +#ifdef CONFIG_SECURITY_LANDLOCK_KUNIT_TEST
> +
> +static void test_no_more_access(struct kunit *const test)
> +{
> +	const layer_mask_t rx0[LANDLOCK_NUM_ACCESS_FS] =3D {
> +		[BIT_INDEX(LANDLOCK_ACCESS_FS_EXECUTE)] =3D BIT_ULL(0),
> +		[BIT_INDEX(LANDLOCK_ACCESS_FS_READ_FILE)] =3D BIT_ULL(0),
> +	};
> +	const layer_mask_t mx0[LANDLOCK_NUM_ACCESS_FS] =3D {
> +		[BIT_INDEX(LANDLOCK_ACCESS_FS_EXECUTE)] =3D BIT_ULL(0),
> +		[BIT_INDEX(LANDLOCK_ACCESS_FS_MAKE_REG)] =3D BIT_ULL(0),
> +	};
> +	const layer_mask_t x0[LANDLOCK_NUM_ACCESS_FS] =3D {
> +		[BIT_INDEX(LANDLOCK_ACCESS_FS_EXECUTE)] =3D BIT_ULL(0),
> +	};
> +	const layer_mask_t x1[LANDLOCK_NUM_ACCESS_FS] =3D {
> +		[BIT_INDEX(LANDLOCK_ACCESS_FS_EXECUTE)] =3D BIT_ULL(1),
> +	};
> +	const layer_mask_t x01[LANDLOCK_NUM_ACCESS_FS] =3D {
> +		[BIT_INDEX(LANDLOCK_ACCESS_FS_EXECUTE)] =3D BIT_ULL(0) |
> +							  BIT_ULL(1),
> +	};
> +	const layer_mask_t allows_all[LANDLOCK_NUM_ACCESS_FS] =3D {};
> +
> +	/* Checks without restriction. */
> +	NMA_TRUE(&x0, &allows_all, false, &allows_all, NULL, false);
> +	NMA_TRUE(&allows_all, &x0, false, &allows_all, NULL, false);
> +	NMA_FALSE(&x0, &x0, false, &allows_all, NULL, false);
> +
> +	/*
> +	 * Checks that we can only refer a file if no more access could be
> +	 * inherited.
> +	 */
> +	NMA_TRUE(&x0, &x0, false, &rx0, NULL, false);
> +	NMA_TRUE(&rx0, &rx0, false, &rx0, NULL, false);
> +	NMA_FALSE(&rx0, &rx0, false, &x0, NULL, false);
> +	NMA_FALSE(&rx0, &rx0, false, &x1, NULL, false);
> +
> +	/* Checks allowed referring with different nested domains. */
> +	NMA_TRUE(&x0, &x1, false, &x0, NULL, false);
> +	NMA_TRUE(&x1, &x0, false, &x0, NULL, false);
> +	NMA_TRUE(&x0, &x01, false, &x0, NULL, false);
> +	NMA_TRUE(&x0, &x01, false, &rx0, NULL, false);
> +	NMA_TRUE(&x01, &x0, false, &x0, NULL, false);
> +	NMA_TRUE(&x01, &x0, false, &rx0, NULL, false);
> +	NMA_FALSE(&x01, &x01, false, &x0, NULL, false);
> +
> +	/* Checks that file access rights are also enforced for a directory. */
> +	NMA_FALSE(&rx0, &rx0, true, &x0, NULL, false);
> +
> +	/* Checks that directory access rights don't impact file referring... *=
/
> +	NMA_TRUE(&mx0, &mx0, false, &x0, NULL, false);
> +	/* ...but only directory referring. */
> +	NMA_FALSE(&mx0, &mx0, true, &x0, NULL, false);
> +
> +	/* Checks directory exchange. */
> +	NMA_TRUE(&mx0, &mx0, true, &mx0, &mx0, true);
> +	NMA_TRUE(&mx0, &mx0, true, &mx0, &x0, true);
> +	NMA_FALSE(&mx0, &mx0, true, &x0, &mx0, true);
> +	NMA_FALSE(&mx0, &mx0, true, &x0, &x0, true);
> +	NMA_FALSE(&mx0, &mx0, true, &x1, &x1, true);
> +
> +	/* Checks file exchange with directory access rights... */
> +	NMA_TRUE(&mx0, &mx0, false, &mx0, &mx0, false);
> +	NMA_TRUE(&mx0, &mx0, false, &mx0, &x0, false);
> +	NMA_TRUE(&mx0, &mx0, false, &x0, &mx0, false);
> +	NMA_TRUE(&mx0, &mx0, false, &x0, &x0, false);
> +	/* ...and with file access rights. */
> +	NMA_TRUE(&rx0, &rx0, false, &rx0, &rx0, false);
> +	NMA_TRUE(&rx0, &rx0, false, &rx0, &x0, false);
> +	NMA_FALSE(&rx0, &rx0, false, &x0, &rx0, false);
> +	NMA_FALSE(&rx0, &rx0, false, &x0, &x0, false);
> +	NMA_FALSE(&rx0, &rx0, false, &x1, &x1, false);
> +
> +	/*
> +	 * Allowing the following requests should not be a security risk
> +	 * because domain 0 denies execute access, and domain 1 is always
> +	 * nested with domain 0.  However, adding an exception for this case
> +	 * would mean to check all nested domains to make sure none can get
> +	 * more privileges (e.g. processes only sandboxed by domain 0).
> +	 * Moreover, this behavior (i.e. composition of N domains) could then
> +	 * be inconsistent compared to domain 1's ruleset alone (e.g. it might
> +	 * be denied to link/rename with domain 1's ruleset, whereas it would
> +	 * be allowed if nested on top of domain 0).  Another drawback would be
> +	 * to create a cover channel that could enable sandboxed processes to
> +	 * infer most of the filesystem restrictions from their domain.  To
> +	 * make it simple, efficient, safe, and more consistent, this case is
> +	 * always denied.
> +	 */
> +	NMA_FALSE(&x1, &x1, false, &x0, NULL, false);
> +	NMA_FALSE(&x1, &x1, false, &rx0, NULL, false);
> +	NMA_FALSE(&x1, &x1, true, &x0, NULL, false);
> +	NMA_FALSE(&x1, &x1, true, &rx0, NULL, false);
> +
> +	/* Checks the same case of exclusive domains with a file... */
> +	NMA_TRUE(&x1, &x1, false, &x01, NULL, false);
> +	NMA_FALSE(&x1, &x1, false, &x01, &x0, false);
> +	NMA_FALSE(&x1, &x1, false, &x01, &x01, false);
> +	NMA_FALSE(&x1, &x1, false, &x0, &x0, false);
> +	/* ...and with a directory. */
> +	NMA_FALSE(&x1, &x1, false, &x0, &x0, true);
> +	NMA_FALSE(&x1, &x1, true, &x0, &x0, false);
> +	NMA_FALSE(&x1, &x1, true, &x0, &x0, true);
> +}
> +
> +#endif /* CONFIG_SECURITY_LANDLOCK_KUNIT_TEST */
> +
> +#undef NMA_TRUE
> +#undef NMA_FALSE
> +
>  /*
>   * Removes @layer_masks accesses that are not requested.
>   *
> @@ -331,6 +445,57 @@ scope_to_request(const access_mask_t access_request,
>  	return !memchr_inv(layer_masks, 0, sizeof(*layer_masks));
>  }
> =20
> +#ifdef CONFIG_SECURITY_LANDLOCK_KUNIT_TEST
> +
> +static void test_scope_to_request_with_exec_none(struct kunit *const tes=
t)
> +{
> +	/* Allows everything. */
> +	layer_mask_t layer_masks[LANDLOCK_NUM_ACCESS_FS] =3D {};
> +
> +	/* Checks and scopes with execute. */
> +	KUNIT_EXPECT_TRUE(test, scope_to_request(LANDLOCK_ACCESS_FS_EXECUTE,
> +						 &layer_masks));
> +	KUNIT_EXPECT_EQ(test, 0,
> +			layer_masks[BIT_INDEX(LANDLOCK_ACCESS_FS_EXECUTE)]);
> +	KUNIT_EXPECT_EQ(test, 0,
> +			layer_masks[BIT_INDEX(LANDLOCK_ACCESS_FS_WRITE_FILE)]);
> +}
> +
> +static void test_scope_to_request_with_exec_some(struct kunit *const tes=
t)
> +{
> +	/* Denies execute and write. */
> +	layer_mask_t layer_masks[LANDLOCK_NUM_ACCESS_FS] =3D {
> +		[BIT_INDEX(LANDLOCK_ACCESS_FS_EXECUTE)] =3D BIT_ULL(0),
> +		[BIT_INDEX(LANDLOCK_ACCESS_FS_WRITE_FILE)] =3D BIT_ULL(1),
> +	};
> +
> +	/* Checks and scopes with execute. */
> +	KUNIT_EXPECT_FALSE(test, scope_to_request(LANDLOCK_ACCESS_FS_EXECUTE,
> +						  &layer_masks));
> +	KUNIT_EXPECT_EQ(test, BIT_ULL(0),
> +			layer_masks[BIT_INDEX(LANDLOCK_ACCESS_FS_EXECUTE)]);
> +	KUNIT_EXPECT_EQ(test, 0,
> +			layer_masks[BIT_INDEX(LANDLOCK_ACCESS_FS_WRITE_FILE)]);
> +}
> +
> +static void test_scope_to_request_without_access(struct kunit *const tes=
t)
> +{
> +	/* Denies execute and write. */
> +	layer_mask_t layer_masks[LANDLOCK_NUM_ACCESS_FS] =3D {
> +		[BIT_INDEX(LANDLOCK_ACCESS_FS_EXECUTE)] =3D BIT_ULL(0),
> +		[BIT_INDEX(LANDLOCK_ACCESS_FS_WRITE_FILE)] =3D BIT_ULL(1),
> +	};
> +
> +	/* Checks and scopes without access request. */
> +	KUNIT_EXPECT_TRUE(test, scope_to_request(0, &layer_masks));
> +	KUNIT_EXPECT_EQ(test, 0,
> +			layer_masks[BIT_INDEX(LANDLOCK_ACCESS_FS_EXECUTE)]);
> +	KUNIT_EXPECT_EQ(test, 0,
> +			layer_masks[BIT_INDEX(LANDLOCK_ACCESS_FS_WRITE_FILE)]);
> +}
> +
> +#endif /* CONFIG_SECURITY_LANDLOCK_KUNIT_TEST */
> +
>  /*
>   * Returns true if there is at least one access right different than
>   * LANDLOCK_ACCESS_FS_REFER.
> @@ -354,6 +519,51 @@ is_eacces(const layer_mask_t (*const layer_masks)[LA=
NDLOCK_NUM_ACCESS_FS],
>  	return false;
>  }
> =20
> +#define IE_TRUE(...) KUNIT_EXPECT_TRUE(test, is_eacces(__VA_ARGS__))
> +#define IE_FALSE(...) KUNIT_EXPECT_FALSE(test, is_eacces(__VA_ARGS__))

is_eacces() only has one argument anyway, so __VA_ARGS__ is not as useful a=
s it
was in the other case, IMHO.  But works either way.

> +
> +#ifdef CONFIG_SECURITY_LANDLOCK_KUNIT_TEST
> +
> +static void test_is_eacces_with_none(struct kunit *const test)
> +{
> +	const layer_mask_t layer_masks[LANDLOCK_NUM_ACCESS_FS] =3D {};
> +
> +	IE_FALSE(&layer_masks, 0);
> +	IE_FALSE(&layer_masks, LANDLOCK_ACCESS_FS_REFER);
> +	IE_FALSE(&layer_masks, LANDLOCK_ACCESS_FS_EXECUTE);
> +	IE_FALSE(&layer_masks, LANDLOCK_ACCESS_FS_WRITE_FILE);
> +}
> +
> +static void test_is_eacces_with_refer(struct kunit *const test)
> +{
> +	const layer_mask_t layer_masks[LANDLOCK_NUM_ACCESS_FS] =3D {
> +		[BIT_INDEX(LANDLOCK_ACCESS_FS_REFER)] =3D BIT_ULL(0),
> +	};
> +
> +	IE_FALSE(&layer_masks, 0);
> +	IE_FALSE(&layer_masks, LANDLOCK_ACCESS_FS_REFER);
> +	IE_FALSE(&layer_masks, LANDLOCK_ACCESS_FS_EXECUTE);
> +	IE_FALSE(&layer_masks, LANDLOCK_ACCESS_FS_WRITE_FILE);
> +}
> +
> +static void test_is_eacces_with_write(struct kunit *const test)
> +{
> +	const layer_mask_t layer_masks[LANDLOCK_NUM_ACCESS_FS] =3D {
> +		[BIT_INDEX(LANDLOCK_ACCESS_FS_WRITE_FILE)] =3D BIT_ULL(0),
> +	};
> +
> +	IE_FALSE(&layer_masks, 0);
> +	IE_FALSE(&layer_masks, LANDLOCK_ACCESS_FS_REFER);
> +	IE_FALSE(&layer_masks, LANDLOCK_ACCESS_FS_EXECUTE);
> +
> +	IE_TRUE(&layer_masks, LANDLOCK_ACCESS_FS_WRITE_FILE);
> +}
> +
> +#endif /* CONFIG_SECURITY_LANDLOCK_KUNIT_TEST */
> +
> +#undef IE_TRUE
> +#undef IE_FALSE
> +
>  /**
>   * is_access_to_paths_allowed - Check accesses for requests with a commo=
n path
>   *
> @@ -1225,3 +1435,27 @@ __init void landlock_add_fs_hooks(void)
>  	security_add_hooks(landlock_hooks, ARRAY_SIZE(landlock_hooks),
>  			   LANDLOCK_NAME);
>  }
> +
> +#ifdef CONFIG_SECURITY_LANDLOCK_KUNIT_TEST
> +
> +/* clang-format off */
> +static struct kunit_case test_cases[] =3D {
> +	KUNIT_CASE(test_no_more_access),
> +	KUNIT_CASE(test_scope_to_request_with_exec_none),
> +	KUNIT_CASE(test_scope_to_request_with_exec_some),
> +	KUNIT_CASE(test_scope_to_request_without_access),
> +	KUNIT_CASE(test_is_eacces_with_none),
> +	KUNIT_CASE(test_is_eacces_with_refer),
> +	KUNIT_CASE(test_is_eacces_with_write),
> +	{}
> +};
> +/* clang-format on */
> +
> +static struct kunit_suite test_suite =3D {
> +	.name =3D "landlock_fs",
> +	.test_cases =3D test_cases,
> +};
> +
> +kunit_test_suite(test_suite);
> +
> +#endif /* CONFIG_SECURITY_LANDLOCK_KUNIT_TEST */
> diff --git a/tools/testing/kunit/configs/all_tests.config b/tools/testing=
/kunit/configs/all_tests.config
> index 3bf506d4a63c..1b8f1abfedf0 100644
> --- a/tools/testing/kunit/configs/all_tests.config
> +++ b/tools/testing/kunit/configs/all_tests.config
> @@ -37,6 +37,7 @@ CONFIG_REGMAP_BUILD=3Dy
> =20
>  CONFIG_SECURITY=3Dy
>  CONFIG_SECURITY_APPARMOR=3Dy
> +CONFIG_SECURITY_LANDLOCK=3Dy
> =20
>  CONFIG_SOUND=3Dy
>  CONFIG_SND=3Dy
>=20
> base-commit: 0daaa610c8e033cdfb420db728c2b40eb3a75134
> --=20
> 2.43.0
>=20

