Return-Path: <linux-kselftest+bounces-32196-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35C5FAA741E
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 May 2025 15:47:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24C109A863F
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 May 2025 13:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FA8824113D;
	Fri,  2 May 2025 13:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b="BOzJ76Fh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sender3-pp-f112.zoho.com (sender3-pp-f112.zoho.com [136.143.184.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4CBD3D76;
	Fri,  2 May 2025 13:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.184.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746193617; cv=pass; b=fxEZZcoAotCj8Vn+qITZtpQ7pfMuWMsNHKsY3HoNEXEobYKTmLfqPz2QMedMim29wOFSw7fEVflBLbblzCfgUyWwlvRkCTrXd6iAZHTakpLRruxlQNNk5mN8JINi0JZcGr/YUBoKbt7ff3jK1EoTBLExt40vdXbT3KvDX9kYJKs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746193617; c=relaxed/simple;
	bh=ZnMfTNF1LOJE1cNcrs5EEWUTINYMByvqGCUyFpS8zWc=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=XJn/EIMqhh++Pdw5yCH2Pgedve9STd9uE6V3KJB7V0AbmgMB0bI1fIcC2qvNBT5UO47bAXwPrUVgiopGjoOHivbS0qyS76FyAvrR5TV4uTRSpK5J5XyAdnNQiBUhmaEZuG4b8WBAzGnv1Wpnkyl+vLYozk+Vg8kHYu5dAzuHUls=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b=BOzJ76Fh; arc=pass smtp.client-ip=136.143.184.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1746193596; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=aK7KPpHdhK2zkDOQ9e6Ob7PKYOxehQfcpzzivOoDCyKl0qFi83RG4OMDQzjks4eVNkY9zbk7od87gIYHMZYpGtIc5ZdooN2X8jjuzVdA0rmGV5T3BFQ2Ctf81Z8OYsnaGaxfr5bZ9a90JvhoCmcaUcfS/hKIS7me2VNFSNkBSWo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1746193596; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=LLRgjMubAuzXAtYX6lwgNrby1MxnFRdxLDgTY5+1OdQ=; 
	b=H8DQ3sF2odxazbytio8NRKS+VHiysqBjCfHH1MXBnQIKuaTo6xszkmLPyO5jiwbGjNOUdrIuKaONKKh1t7SVi33UOhJP6vQMI09ly5F9CWjyv3p4BvGVa5wKlSLjcmDhZFRYJaJXlsLxFzHZfMjpZ4ncKGYDj+yGiz9xgTBvLvg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=usama.anjum@collabora.com;
	dmarc=pass header.from=<usama.anjum@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1746193596;
	s=zohomail; d=collabora.com; i=usama.anjum@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Cc:Cc:Subject:Subject:To:To:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=LLRgjMubAuzXAtYX6lwgNrby1MxnFRdxLDgTY5+1OdQ=;
	b=BOzJ76FhH16utcR4O0gE0FwxbjdgShAmqU20Ewdy7fD15IW3RVAVzW5c8X+9mfLK
	NHkhCTod3o4ET1P/Yq54bK7RTGtAYp7DTo27PBy8Kpf/tC6p1rw/rI1vjSwaT5WHgwJ
	PFcb1dFDco8g7S4x4yu84P2FTkWjMkFGyEuLIgwA=
Received: by mx.zohomail.com with SMTPS id 1746193594720979.2250250120471;
	Fri, 2 May 2025 06:46:34 -0700 (PDT)
Message-ID: <a7365a45-6064-4ace-81da-ce46ea5a6c91@collabora.com>
Date: Fri, 2 May 2025 18:46:28 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: usama.anjum@collabora.com, Shuah Khan <skhan@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 5/7] selftests: vDSO: vdso_test_getrandom: Drop some dead
 code
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>, Shuah Khan
 <shuah@kernel.org>, "Jason A. Donenfeld" <Jason@zx2c4.com>
References: <20250502-selftests-vdso-fixes-v1-0-fb5d640a4f78@linutronix.de>
 <20250502-selftests-vdso-fixes-v1-5-fb5d640a4f78@linutronix.de>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20250502-selftests-vdso-fixes-v1-5-fb5d640a4f78@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

On 5/2/25 5:40 PM, Thomas Weißschuh wrote:
> vgetrandom_put_state() and the variable ret in kselftest() are never used.
> 
> Drop the dead code.
> 
> Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

> ---
>  tools/testing/selftests/vDSO/vdso_test_getrandom.c | 11 +----------
>  1 file changed, 1 insertion(+), 10 deletions(-)
> 
> diff --git a/tools/testing/selftests/vDSO/vdso_test_getrandom.c b/tools/testing/selftests/vDSO/vdso_test_getrandom.c
> index f36e50f372f935e6d4da3175c81e210653bdce1d..b0e0d664508a38d6dde9df0a61ec8198ee928a17 100644
> --- a/tools/testing/selftests/vDSO/vdso_test_getrandom.c
> +++ b/tools/testing/selftests/vDSO/vdso_test_getrandom.c
> @@ -100,15 +100,6 @@ static void *vgetrandom_get_state(void)
>  	return state;
>  }
>  
> -static void vgetrandom_put_state(void *state)
> -{
> -	if (!state)
> -		return;
> -	pthread_mutex_lock(&vgrnd.lock);
> -	vgrnd.states[vgrnd.len++] = state;
> -	pthread_mutex_unlock(&vgrnd.lock);
> -}
> -
>  static void vgetrandom_init(void)
>  {
>  	const char *version = versions[VDSO_VERSION];
> @@ -264,7 +255,7 @@ static void kselftest(void)
>  	}
>  	for (;;) {
>  		struct ptrace_syscall_info info = { 0 };
> -		int status, ret;
> +		int status;
>  		ksft_assert(waitpid(child, &status, 0) >= 0);
>  		if (WIFEXITED(status)) {
>  			ksft_assert(WEXITSTATUS(status) == 0);
> 


-- 
Regards,
Usama

