Return-Path: <linux-kselftest+bounces-6319-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E59987BA75
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Mar 2024 10:32:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5963128230C
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Mar 2024 09:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E0AE6D1C6;
	Thu, 14 Mar 2024 09:32:13 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6D7D6CDC8;
	Thu, 14 Mar 2024 09:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710408733; cv=none; b=LhA+KKsPwLS4dfh+BdqBBieO21XxD6Z/XJDJOiLwuAEopqaps7yGHg0b9qOFtDKbbZXND2X73Zyr8emfasyeJaj7u3oQ2cMlPxEYKxvsH+1kE9MCrUW4NF703ctNuIn56cYQp/vW5ixmyyvV0+EvWTUWDSLN4tM/zUyUqoov7MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710408733; c=relaxed/simple;
	bh=IiRqSA1zOuDlbi4cvqhX+73KjmiiLkECrRVJMoOMrR8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RTM7dQJTguwInw2zmH/hmRvMl1kIVPTL+k84hIKytDCP2TeNytT2Fg569IQOifBzTuwbLIZ2HvvhkGI2B2JwoKAoYc4qsMtkvzyJ2dKvCdRa8LYlELYb65Nd42CBNEJLBXLmnwzTiay/DI5ue+onKEFJ2J8jcbdd/VOYyiEww/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C12621007;
	Thu, 14 Mar 2024 02:32:40 -0700 (PDT)
Received: from e124191.cambridge.arm.com (e124191.cambridge.arm.com [10.1.197.45])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5499F3F762;
	Thu, 14 Mar 2024 02:32:03 -0700 (PDT)
Date: Thu, 14 Mar 2024 09:31:55 +0000
From: Joey Gouly <joey.gouly@arm.com>
To: Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>, kernel@collabora.com,
	Ryan Roberts <ryan.roberts@arm.com>, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/5] selftests/mm: protection_keys: save/restore
 nr_hugepages settings
Message-ID: <20240314093155.GA3049647@e124191.cambridge.arm.com>
References: <20240125154608.720072-1-usama.anjum@collabora.com>
 <20240125154608.720072-5-usama.anjum@collabora.com>
 <20240313145811.GA2896554@e124191.cambridge.arm.com>
 <b7fb0e92-f74b-4e12-9eaa-0427901c2be5@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b7fb0e92-f74b-4e12-9eaa-0427901c2be5@collabora.com>

On Wed, Mar 13, 2024 at 11:12:58PM +0500, Muhammad Usama Anjum wrote:
> On 3/13/24 7:58 PM, Joey Gouly wrote:
> > Hi Muhammad,
> > 
> > On Thu, Jan 25, 2024 at 08:46:07PM +0500, Muhammad Usama Anjum wrote:
> >> Save and restore nr_hugepages before changing it during the test. A test
> >> should not change system wide settings.
> >>
> >> Fixes: 5f23f6d082a9 ("x86/pkeys: Add self-tests")
> >> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> >> ---
> >>  tools/testing/selftests/mm/protection_keys.c | 34 ++++++++++++++++++++
> >>  1 file changed, 34 insertions(+)
> >>
> >> diff --git a/tools/testing/selftests/mm/protection_keys.c b/tools/testing/selftests/mm/protection_keys.c
> >> index 48dc151f8fca8..f822ae31af22e 100644
> >> --- a/tools/testing/selftests/mm/protection_keys.c
> >> +++ b/tools/testing/selftests/mm/protection_keys.c
> >> @@ -54,6 +54,7 @@ int test_nr;
> >>  u64 shadow_pkey_reg;
> >>  int dprint_in_signal;
> >>  char dprint_in_signal_buffer[DPRINT_IN_SIGNAL_BUF_SIZE];
> >> +char buf[256];
> >>  
> >>  void cat_into_file(char *str, char *file)
> >>  {
> >> @@ -1744,6 +1745,38 @@ void pkey_setup_shadow(void)
> >>  	shadow_pkey_reg = __read_pkey_reg();
> >>  }
> >>  
> >> +void restore_settings_atexit(void)
> >> +{
> >> +	cat_into_file(buf, "/proc/sys/vm/nr_hugepages");
> >> +}
> >> +
> >> +void save_settings(void)
> >> +{
> >> +	int fd;
> >> +	int err;
> >> +
> >> +	if (geteuid())
> >> +		return;
> >> +
> >> +	fd = open("/proc/sys/vm/nr_hugepages", O_RDONLY);
> >> +	if (fd < 0) {
> >> +		fprintf(stderr, "error opening\n");
> >> +		perror("error: ");
> >> +		exit(__LINE__);
> >> +	}
> >> +
> >> +	/* -1 to guarantee leaving the trailing \0 */
> >> +	err = read(fd, buf, sizeof(buf)-1);
> >> +	if (err < 0) {
> >> +		fprintf(stderr, "error reading\n");
> >> +		perror("error: ");
> >> +		exit(__LINE__);
> >> +	}
> >> +
> >> +	atexit(restore_settings_atexit);
> >> +	close(fd);
> >> +}
> >> +
> >>  int main(void)
> >>  {
> >>  	int nr_iterations = 22;
> >> @@ -1751,6 +1784,7 @@ int main(void)
> >>  
> >>  	srand((unsigned int)time(NULL));
> >>  
> >> +	save_settings();
> >>  	setup_handlers();
> >>  
> >>  	printf("has pkeys: %d\n", pkeys_supported);
> >> -- 
> >> 2.42.0
> >>
> > 
> > This break the tests for me:
> > 
> > assert() at protection_keys.c::812 test_nr: 19 iteration: 1
> > running abort_hooks()...
> > 
> > This is because some of the tests fork, so on their atexit() they will set the
> > nr_hugepages back to the previous setting. Specifically the
> > test_pkey_alloc_exhaust() test.
> Thank you for reporting. Please can you test the following patch:
> 
> --- a/tools/testing/selftests/mm/protection_keys.c
> +++ b/tools/testing/selftests/mm/protection_keys.c
> @@ -1745,9 +1745,12 @@ void pkey_setup_shadow(void)
>  	shadow_pkey_reg = __read_pkey_reg();
>  }
> 
> +pid_t parent_pid;
> +
>  void restore_settings_atexit(void)
>  {
> -	cat_into_file(buf, "/proc/sys/vm/nr_hugepages");
> +	if (parent_pid == getpid())
> +		cat_into_file(buf, "/proc/sys/vm/nr_hugepages");
>  }
> 
>  void save_settings(void)
> @@ -1773,6 +1776,7 @@ void save_settings(void)
>  		exit(__LINE__);
>  	}
> 
> +	parent_pid = getpid();
>  	atexit(restore_settings_atexit);
>  	close(fd);
>  }
> 

Thanks, works for me:

Tested-by: Joey Gouly <joey.gouly@arm.com>

