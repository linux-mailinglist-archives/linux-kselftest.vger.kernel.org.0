Return-Path: <linux-kselftest+bounces-21893-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97B4F9C60B9
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Nov 2024 19:47:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58666281B45
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Nov 2024 18:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9123218301;
	Tue, 12 Nov 2024 18:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="CGu3iysX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sonic305-27.consmr.mail.ne1.yahoo.com (sonic305-27.consmr.mail.ne1.yahoo.com [66.163.185.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 494E8217915
	for <linux-kselftest@vger.kernel.org>; Tue, 12 Nov 2024 18:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.185.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731437140; cv=none; b=SiEJ+Phk0KQlez5/Amze6rAHn/g1xuucDcSKqxFXI46lcMlKTh6UjVbELO3vlcoKEyDFrOY3TP7d3zR+PirlkG6o9tSd198UCuJtBvwY1YP9qq9CdrZZj77uqEPKEFKS1STCnHY/Rfx9ZTXiCV99GQqMSUaelSkvPr6tkOPlEUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731437140; c=relaxed/simple;
	bh=5AfxsiIGnThkCH9+gv4t/5YzNoha7tPyUzDonhfXsDI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TOKdKzQHwNyniG6/oqBz+3j0hVr6k4Mt7153n5ekzqzgq5ve/K0cD2urgc3/r/ANaGBJ+c9NRp/a8jR35siWgmQYgcVVGWpHrdnlT445jKuOGCSzaVEIx/6fITmtddqcd7QUppCqy9OPB6SnetypPoHroiw5vCe19lOy6fvkZ8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=CGu3iysX; arc=none smtp.client-ip=66.163.185.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1731437132; bh=44dFyDMdFWCMHOzhpZuUtqKywMz30N+fbraStaI1L/E=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=CGu3iysXr3o4XqYPqFYJhiFA0/kVDR7xydNpXZojXAg3ehSAgqo1KnngT/r2Kyw+VXseNysHTIWD2WYh6E0n0ACnFVIZUCh2XTPXrq4wAlcoelWJdiqmzs/Fes5JUJAftJbAPFDGIsp4vFvCNGlXc36AI+W8jgqCzdReWWyeA1ihJ45kkRcbyeQxJsnDR0cIvJU80Mu3xW/sIhuPgJM0ad1Ta3exJg0avI/+DMtJVSOZSGDQWj0Esi8M232av6cMZDAPjfOW7xGCMA8We/M0mCZvwkjF+LkZFNHb9ad0SVj37BBmtUhtEZUOkmqgx6oIog3fT5LZV9KrStoxSThzug==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1731437132; bh=stVwctm+rHDaZV5WnCWt/qR0FsE4RGRrgUsQjLDT+Ya=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=YE0YxkdhA4vuca5RHtFnxxJmgqbWcPjktb6/34U2+MxzQpSKikTnlOPDSNbRDYtqiFJcr58V8EEvhbrimRdOnezH+3FkgjPKBuyFjUroYVXKLnYud5iRRrLhPDet05Ef4LSbHnmogmeyYsLQBgSmRcZ0Qnkd2VxH2dt6nV8Bl8RvtGjdC2V4SfwtpS2Pbp53l3Rj68FpksOw0jwqetA7b9dR2DAjdwuYreDnZY2y9H9buE1MlJ80kf1cO6MllvFo99+b6PFaIjN+d+2FslTfYFMV/TOFf+5s8THnC3KbETD7jgBTx/wLxkjtfHWh8HlCM6NcqIrs/soMb/V8BvwUFw==
X-YMail-OSG: mfFEfiUVM1k9jpYadsLcoTcNbR8iNtaf4VkGV3FO3GYWkqdmuAMN0KUv4b5D_yf
 SmRzqrPlp0x0Ifm2ZbHNi0do9nNiR57MOBSABtvcYKiOzoCjK_vf6vduQxttnHlt87HyUJICHhBr
 y6ZwRtUFuGy_woTRw2Ehd9AviLy5i8fSWwtrzfPv8Ks8B0QB7ufp_Mq2Ef5OIyG2dWCqHC1aooeO
 2P.L3FVRZL2NKuUWm.omnzE3V.CdnKxaF6NbarCHVfMu8HaBk6eDW5upk8bTf2zv0hdzYoJuHxZ5
 2e1TyeTfzfTlm3FRJo8lo_xLQtRdc603GpLTv41XtpUjMU3Egxgs5_19Ddz5F0E4YN.3OKcGCbeF
 2YqZMuSDXD6Wl07NbTCguFVS3M3359gNVQFl.fWrX29gsJ4luW9zgJ9yd2Ini4_xZR0MaFTNp4Qd
 TKi9YG3lCcPDANPNm7q5OrMQLDVgi3Exf5MkdodSL6GNw66BrrXETn4Kygr922IVPams9Y2wHMM7
 XMNQwHYNUotxUB8PkCZMpdD3zCCLtzRnAgXPiDW2WyJxmhE.ESfnlgc2tKb.AzNHPGHOHjEMDL12
 8IKEHtRsAp8vcCwxip0FS2fDZL36IHROl41wTAYzOg6JMesAsiyX4I9gP8lQfEK4vH7eY0Yb8Svv
 hjH49EX9UXozaWtIQCqXXI2VXgiHzeShT4ALI.2e469yoaSkDJ7Fw9_3G3oapARYbV1F96rMurk8
 7blTWv2kCx7RLSuJ6jJPst4KK0sqYG6pjFL_dH.jZJDRh875Vzs8GB7Wauh6XIeFPEpF8CsOi004
 V16Be6aa1DBWt6mxd49_MjzxO1jUIl6Hi8onJalDtiQ0Xt7bRPYIDQEnrzhtTbuCWRlANKnHWIgA
 eS9BQWHQKkD2dHXeztIrMv5GshTq2_FxLnVLwGuqfiCXdwxVuNlGWW7n2lRf886cuJ1klqtj.HkM
 .HuzKUWO2vi3GqHeQP6dz5PDkMsDrOJ20LgS0zq58gQoGu0pGU.k5ZhVwJ5tlAkWkREztxgMAFBI
 zwkYl14NrTju5K.XGBO0PBOK7lhtIlFbIZBjP5_c430GcfUXytmXWv2P3MaajvTl51lCFi8MyB12
 eQn.nLKAha9YzAts3T9rWcQMwHlNGLGKijUHGbWes.1hDElSTSTPGVyBm2VjejcL3uXyEcoFsXZ5
 s9VjllxBBypNAtcBGHNMTeCdq5AOvSCqbqdz7pkSfSJiwmOOhCl1zmabVkF84f4lm9d.DxnCaKeO
 Z5XAJH9GUws1iCcm11OgzUocNQaS_DlnxATvkDtx2vziaGU_l1yVSlpQTwQUNNBcIDm04ekuZN9X
 .vuNzqEIs0SLf8CwX_HUcGYhvLKFAEJ1ydgnk3UNJR2wbvmcaGgz1hamiO1.TsV687aw18YT4T4S
 tBNH3okxMY937vdy2IPKHMLQjwI_g1f9FMSpi5l9Vrytuv4sYInSxl0n4ubWPd7Lf3jhZk2x6aTR
 23pTuNdWjOUjV2LobHU96519JFW6SBTceNVybVqJjdqrXQjz3ADW0ZJrIS1A_9Uo1J7.fv8fiO7M
 tHIPBFy7gXIi8W9xcEzfS3Zpwr9P90jASsJSwGEQrJKs3b52HsS3Gv2qbZP_pd8I.0pMLq9qUUsu
 72jg8MBDJZJywIcTD2KyOAjpany4o4QspMAOyGsCoEb8SpgCK2rxaWtmeKM0baGgS.ZZm6ZEhlxx
 gEHPsqd.2wwuap3x7WQBDzpUChNOdKXdYuQxhHPmsErKyqwwyC.33vfL3HL4lfp4SoLcWYV_46YP
 fRIpsz_tJLlPC8JVR0fZ1dd7WekLDaxDiK6SB0M5hrqwJo7X.WDFL1GkF1ieaoFXiGHW57JVQc1J
 hgG6vNsQDTnrpLGUR6I5Y.Ofb4moLOgHrrIHADNW5QlQttKVgVCAOXlW1VGY4zwQsJWsMHvhC3gF
 nBFWGOcMk_BxXurJIB6MOMvyuOqY2VdlJSw0.q7SiOdodXBYIQw_MIr7LtyI_LXGnGXabfh39aOq
 RDMHTya1JVsA1wzpwgT3P91_dU95TXRNveFWIPAWhWTkRwejCCrzmIJLPs9d78fE_YrXA1ca.Ldn
 Kt9CDj8BfWP8VX_QUo7srmpNXFKNKfn1jDBfQEXGusTdwau_Gnwzyv1d5F3ZmhakPDb4bSLJoN1y
 lcjvSMd8DebRVusDDqUiOvCkN0OxLVsuYzIuIYbY6mYGjNp9l9Rn0E4RWpSOQUS7i5PlguDaMBkS
 WQgcoXjsDsHznjRbPZEOIbqsFKCjI5Qrxl1mvkO1_gWN6DbUi9mHm6irAIsaOf.w7Tgqi._T8Q2q
 OK2rnYejuLhIaRhzNogjjozekt3s-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: fd96ef61-f196-4ec9-90a5-cdea99300bc5
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.ne1.yahoo.com with HTTP; Tue, 12 Nov 2024 18:45:32 +0000
Received: by hermes--production-gq1-5dd4b47f46-pfhh2 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 8729408aad8f9c6002e94a5bf8721013;
          Tue, 12 Nov 2024 18:45:27 +0000 (UTC)
Message-ID: <ccfb14f5-4efe-4958-962e-9542009352cc@schaufler-ca.com>
Date: Tue, 12 Nov 2024 10:45:25 -0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: lsm: Refactor
 `flags_overset_lsm_set_self_attr` test
To: Amit Vadhavana <av2082000@gmail.com>, paul@paul-moore.com,
 jmorris@namei.org, serge@hallyn.com, shuah@kernel.org
Cc: ricardo@marliere.net, skhan@linuxfoundation.org,
 linux-kernel-mentees@lists.linux.dev, linux-security-module@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Casey Schaufler <casey@schaufler-ca.com>
References: <20241112182810.24761-1-av2082000@gmail.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20241112182810.24761-1-av2082000@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.22876 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 11/12/2024 10:28 AM, Amit Vadhavana wrote:
> - Remove unnecessary `tctx` variable, use `ctx` directly.
> - Simplified code with no functional changes.
>
> Signed-off-by: Amit Vadhavana <av2082000@gmail.com>

Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>

> ---
>  tools/testing/selftests/lsm/lsm_set_self_attr_test.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/tools/testing/selftests/lsm/lsm_set_self_attr_test.c b/tools/testing/selftests/lsm/lsm_set_self_attr_test.c
> index 66dec47e3ca3..732e89fe99c0 100644
> --- a/tools/testing/selftests/lsm/lsm_set_self_attr_test.c
> +++ b/tools/testing/selftests/lsm/lsm_set_self_attr_test.c
> @@ -56,16 +56,15 @@ TEST(flags_zero_lsm_set_self_attr)
>  TEST(flags_overset_lsm_set_self_attr)
>  {
>  	const long page_size = sysconf(_SC_PAGESIZE);
> -	char *ctx = calloc(page_size, 1);
> +	struct lsm_ctx *ctx = calloc(page_size, 1);
>  	__u32 size = page_size;
> -	struct lsm_ctx *tctx = (struct lsm_ctx *)ctx;
>  
>  	ASSERT_NE(NULL, ctx);
>  	if (attr_lsm_count()) {
> -		ASSERT_LE(1, lsm_get_self_attr(LSM_ATTR_CURRENT, tctx, &size,
> +		ASSERT_LE(1, lsm_get_self_attr(LSM_ATTR_CURRENT, ctx, &size,
>  					       0));
>  	}
> -	ASSERT_EQ(-1, lsm_set_self_attr(LSM_ATTR_CURRENT | LSM_ATTR_PREV, tctx,
> +	ASSERT_EQ(-1, lsm_set_self_attr(LSM_ATTR_CURRENT | LSM_ATTR_PREV, ctx,
>  					size, 0));
>  
>  	free(ctx);

