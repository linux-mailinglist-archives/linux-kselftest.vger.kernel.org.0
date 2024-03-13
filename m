Return-Path: <linux-kselftest+bounces-6302-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C48C187A9D8
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Mar 2024 15:58:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FFA1281DD3
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Mar 2024 14:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37D6D41744;
	Wed, 13 Mar 2024 14:58:21 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F248D3D3A0;
	Wed, 13 Mar 2024 14:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710341901; cv=none; b=GbbFmOAxm3RJ/BW8tQ/DJqQ4ia4zOMnkvitUhTxSGFMQ9Kd8/OVS1t6wjDfVXlobmIsecFxhebhVoBw897WJyVGzmA6W3OHqhf49M9D+2HlTMeiIwW0cm3AMZRG2Q03eZl5MfHTC97bwC6l11+F/PppyZVheeKIAwBCCLGcBvQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710341901; c=relaxed/simple;
	bh=QwvY0M4wqisbXnCkhZw0XjRtdAndOBgHcfzZ0EodrEQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MKi27qTngybxYCxanHsUWQ+8D2bf1YjYq1OuLgtFWYt1rj+kkJKCqQfY/RFh34G3+p8GDsukKLuqyWojv2XcHZLuXUCe1GWnc6pd/Qe5Ix1Zh08YMX32SHFILP0zTV2FzAhpO7F0M4oXWn8nwILgKaWkrGswFS3BT/K5AbdyI7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C98AF1007;
	Wed, 13 Mar 2024 07:58:54 -0700 (PDT)
Received: from e124191.cambridge.arm.com (e124191.cambridge.arm.com [10.1.197.45])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C6FFD3F73F;
	Wed, 13 Mar 2024 07:58:16 -0700 (PDT)
Date: Wed, 13 Mar 2024 14:58:11 +0000
From: Joey Gouly <joey.gouly@arm.com>
To: Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>, kernel@collabora.com,
	Ryan Roberts <ryan.roberts@arm.com>, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/5] selftests/mm: protection_keys: save/restore
 nr_hugepages settings
Message-ID: <20240313145811.GA2896554@e124191.cambridge.arm.com>
References: <20240125154608.720072-1-usama.anjum@collabora.com>
 <20240125154608.720072-5-usama.anjum@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240125154608.720072-5-usama.anjum@collabora.com>

Hi Muhammad,

On Thu, Jan 25, 2024 at 08:46:07PM +0500, Muhammad Usama Anjum wrote:
> Save and restore nr_hugepages before changing it during the test. A test
> should not change system wide settings.
> 
> Fixes: 5f23f6d082a9 ("x86/pkeys: Add self-tests")
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---
>  tools/testing/selftests/mm/protection_keys.c | 34 ++++++++++++++++++++
>  1 file changed, 34 insertions(+)
> 
> diff --git a/tools/testing/selftests/mm/protection_keys.c b/tools/testing/selftests/mm/protection_keys.c
> index 48dc151f8fca8..f822ae31af22e 100644
> --- a/tools/testing/selftests/mm/protection_keys.c
> +++ b/tools/testing/selftests/mm/protection_keys.c
> @@ -54,6 +54,7 @@ int test_nr;
>  u64 shadow_pkey_reg;
>  int dprint_in_signal;
>  char dprint_in_signal_buffer[DPRINT_IN_SIGNAL_BUF_SIZE];
> +char buf[256];
>  
>  void cat_into_file(char *str, char *file)
>  {
> @@ -1744,6 +1745,38 @@ void pkey_setup_shadow(void)
>  	shadow_pkey_reg = __read_pkey_reg();
>  }
>  
> +void restore_settings_atexit(void)
> +{
> +	cat_into_file(buf, "/proc/sys/vm/nr_hugepages");
> +}
> +
> +void save_settings(void)
> +{
> +	int fd;
> +	int err;
> +
> +	if (geteuid())
> +		return;
> +
> +	fd = open("/proc/sys/vm/nr_hugepages", O_RDONLY);
> +	if (fd < 0) {
> +		fprintf(stderr, "error opening\n");
> +		perror("error: ");
> +		exit(__LINE__);
> +	}
> +
> +	/* -1 to guarantee leaving the trailing \0 */
> +	err = read(fd, buf, sizeof(buf)-1);
> +	if (err < 0) {
> +		fprintf(stderr, "error reading\n");
> +		perror("error: ");
> +		exit(__LINE__);
> +	}
> +
> +	atexit(restore_settings_atexit);
> +	close(fd);
> +}
> +
>  int main(void)
>  {
>  	int nr_iterations = 22;
> @@ -1751,6 +1784,7 @@ int main(void)
>  
>  	srand((unsigned int)time(NULL));
>  
> +	save_settings();
>  	setup_handlers();
>  
>  	printf("has pkeys: %d\n", pkeys_supported);
> -- 
> 2.42.0
> 

This break the tests for me:

assert() at protection_keys.c::812 test_nr: 19 iteration: 1
running abort_hooks()...

This is because some of the tests fork, so on their atexit() they will set the
nr_hugepages back to the previous setting. Specifically the
test_pkey_alloc_exhaust() test.

Thanks,
Joey

