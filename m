Return-Path: <linux-kselftest+bounces-47594-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A061DCC1AF9
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Dec 2025 10:05:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D5CB53014A2E
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Dec 2025 09:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C37832D438;
	Tue, 16 Dec 2025 09:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="MLh7GXV9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out162-62-58-216.mail.qq.com (out162-62-58-216.mail.qq.com [162.62.58.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F67F2E413;
	Tue, 16 Dec 2025 09:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765875888; cv=none; b=Wvbu3kPKAp+xsoFm0KUvYIyrwTP9bXbio5kHSxxymZYXmS9D4iBj+gORIyD7l9hdn8cP9ewdr4+dcWLRnrB2OGdIt0NJFFxB9e6cXKmP67A+D4a9+Ct5vYafrFCm7UirIVSwTY2T+nj49xazi5hi2Raw3knt303AUr1CjQUPgfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765875888; c=relaxed/simple;
	bh=DpYor/n95bKNXncYwyUitkmS3Gyjvta7KmuvsgPFkF0=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=NoVQhFbFkUrR5SeodMYDXSvLryjHDX6CmIkobxmLEwXCXRxTCor44JCo/DWBuPz4dhO2n4mQJwIEoN2R39L+pIQkc4CKID2ZDr/1brqHYTSl2lyajkPJATpfqcW24aLPRujk4J1nrGngFHhZu9aLbgPO39LoiAoPM6k8sfcC3+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=MLh7GXV9; arc=none smtp.client-ip=162.62.58.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1765875875;
	bh=K86Uq8KZaWC4LlhtUxoFkn5oMJc+uHrb6mitTD6ysLg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MLh7GXV9b6jFa69geGL0nVCs6OTB3CV5d83Y957nZp8w/PYoF+FVQ5G7OIq9TRLnx
	 OLcNis2GF+sXdGNUgPm/XdSbt1BaueZPQmMhuIL6entUVCw5Y97FAd6dkFC52UrS5z
	 iKtkDXu5Qxek6SOJ+xlCOAvs8IMJ1bi8BJTU3Trg=
Received: from meizu-Precision-3660-casey.meizu.com ([14.21.33.152])
	by newxmesmtplogicsvrszb43-0.qq.com (NewEsmtp) with SMTP
	id 1123E48A; Tue, 16 Dec 2025 17:04:18 +0800
X-QQ-mid: xmsmtpt1765875858tsi2i1e64
Message-ID: <tencent_3E4E6D2AD8C21CCA18E9A4E7E1578C94EF06@qq.com>
X-QQ-XMAILINFO: OeJ9zRfntlNPS7UZpg7BSzty4ILY76Ml7FrmGzAEZEnZc+rclOfNDrYLcywdmQ
	 SPxqRizbxUlULi7+B3l43ChLwDGqqVh3z2otpy4GgchyOdon6cq8llVam75b5hRJs3qz7CU+NAN8
	 knSUJbBfY3fuOVcUvjNZyEUVk8Yp5DrnVT8tBrdoEyy3manOqCLl4TxEjp+V7XBm1rWVAS4sxFm+
	 +/TtJrz0MqqI/u1Wba4nPC99iIk6r97qcG6h03AARMyjVgpDEMu7QTvK51t3sljWV4BUbyQ5XdzT
	 +JjSFSICic2c+DWFlLQFwCdJH2k2rquItJY9MSe+STbXYTKqklxIwhr7QCkpJ60GAzFm551iDg5F
	 v925hXYvy1USYG4mrdUuVjr/FLcBcvho4PAvus5dmk2QWTPLuhztubLROjNa2oQuoRFoMJ+vXMU6
	 94Tbp7olrE7zK4AlxDXvB2lo5cJxbvI1+685D2Nh5zfd7U0WdHRjY56t161Ml0lT4FZOdrXAL828
	 bckw++J/pDIawf6VSQVQvyE8y/9Ti5YqrkXc2ejC0kbFmpwmHsPJic3bjeX0zomSsiHLha897aWe
	 GAS0+uaYxtDlAGt9sM3vqu7gOZT/mTC7XPV+05Nm8uhOURYhqV9IIsRgaCvrqus4wwwQuUKBo9nD
	 BGx42kGT8csip3JUqBLWYErQUuFCmIxMqSHfZ3bXGlDbz1RtwyQkbB5NnqHCDr9YmP7FtIDMtM+c
	 J3+mFcUOLUiTlb9VzsZ1DjVyQ+lmtpPeMaOdE2HpEYlGSBBD89EbzqdivKIkvbM+d102YMQI2xiX
	 x4FOqQTTeFCSWncRT0wcmfrbjSZrf9p+d+yAIibBDbjL/T8uZ3pPJNYl2aA3SYGdTsWwTH2ZLDp4
	 kmVh0hXo89TkoGtupzGX3+45i4Uc+MP3ANoGF8WVYThedmDDtO4jE1jnUfoTDIffX29v773f7Gbj
	 BIG3EkZLb9pJXzAfGMd2bRwIuFMEhZH7hTIaAeBbJujoHqsqziymCwCUcAUNneVZodioqTgDEbdi
	 VWXbLKFQSqfW1mUP5bZHpvF7GatDwh8+Lks6/Xtsc9LDWnT4jgYDJWrG4BrQRSV9x3w3CBq5EPhV
	 erPHh1yEMbEtNk39kiLu8gtMVhIQ==
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
From: Licay <licayy@foxmail.com>
To: ywen.chen@foxmail.com,
	akpm@linux-foundation.org
Cc: andrealmeid@igalia.com,
	bigeasy@linutronix.de,
	colin.i.king@gmail.com,
	dave@stgolabs.net,
	dvhart@infradead.org,
	justinstitt@google.com,
	kernel-team@android.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	luto@mit.edu,
	mingo@redhat.com,
	morbo@google.com,
	nathan@kernel.org,
	ndesaulniers@google.com,
	peterz@infradead.org,
	shuah@kernel.org,
	tglx@linutronix.de,
	usama.anjum@collabora.com,
	Licay <licayy@foxmail.com>
Subject: [PATCH v2 2/5] selftests/futex: use pthread_join to reclaim thread resources
Date: Tue, 16 Dec 2025 17:04:16 +0800
X-OQ-MSGID: <20251216090417.406722-1-licayy@foxmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <tencent_1C17775758511477F4F8A8ABDCB9461EC306@qq.com>
References: <tencent_1C17775758511477F4F8A8ABDCB9461EC306@qq.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> When creating a thread using pthread_create, you should use
> pthread_join to free its resources.
>
> Signed-off-by: Yuwen Chen <ywen.chen@foxmail.com>
Reviewed-by: Licay <licayy@foxmail.com>
> ---
>  tools/testing/selftests/futex/functional/futex_requeue.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/tools/testing/selftests/futex/functional/futex_requeue.c b/tools/testing/selftests/futex/functional/futex_requeue.c
> index 1807465de2144..7a22458c7fc96 100644
> --- a/tools/testing/selftests/futex/functional/futex_requeue.c
> +++ b/tools/testing/selftests/futex/functional/futex_requeue.c
> @@ -62,6 +62,8 @@ TEST(requeue_single)
>  	} else {
>  		ksft_test_result_pass("futex_requeue simple succeeds\n");
>  	}
> +
> +	pthread_join(waiter, NULL);
>  }
>
>  TEST(requeue_multiple)
> @@ -101,6 +103,9 @@ TEST(requeue_multiple)
>  	} else {
>  		ksft_test_result_pass("futex_requeue many succeeds\n");
>  	}
> +
> +	for (i = 0; i < 10; i++)
> +		pthread_join(waiter[i], NULL);
>  }
>
>  TEST_HARNESS_MAIN
> --
> 2.34.1
>


