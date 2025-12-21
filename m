Return-Path: <linux-kselftest+bounces-47808-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B3200CD4640
	for <lists+linux-kselftest@lfdr.de>; Sun, 21 Dec 2025 23:11:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3FF5530057FD
	for <lists+linux-kselftest@lfdr.de>; Sun, 21 Dec 2025 22:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A2392153EA;
	Sun, 21 Dec 2025 22:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kPU1c/rd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D39194A6C
	for <linux-kselftest@vger.kernel.org>; Sun, 21 Dec 2025 22:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766355058; cv=none; b=kQLqaAyInMqaflMjULptDK0Yqxw/DmX4mGZP2k5Yn4SXMQnMAqo1zrkb54bkLwuem428phcPLzKUF72ID9pRU9EYH3BqtjPZ1+DstXHs7gp7lBn+e7+oF1QrU/BHAInK8y5HmmyfWuv4tXEZpX27Ew91Ibl71ClsCSpBUiB5H8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766355058; c=relaxed/simple;
	bh=Q9QAX8Mf/cfoa9lR27a4jqHDk3ycajbfkYnO5Pci9fQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VfAs9kPOkghWB4Au0QDD1dWgIviDQWBD4lt1ON0oKS2kVtLXfhHOwwvQabI18cAQokVpaV8HqRDcVU3vn4v2AM5TBRL2EWwrkykj50oTeof6beaMMfUGuNtP2aXf+xIiIOe9Rb/W4OIqSLgAjx3hm35ScMPXCkKvc5W3c7z3ivU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kPU1c/rd; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-47a95efd2ceso29233315e9.2
        for <linux-kselftest@vger.kernel.org>; Sun, 21 Dec 2025 14:10:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766355055; x=1766959855; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QiLm+p5h09BwQ/VgsJKq6TFAfcpGR1sZeDMEGJGH3ew=;
        b=kPU1c/rdG9uFW6nr+Hm6JGRu/EXzBHzEt0QgQ/PJaGg5Mpw8cCvsmdKMbUYcrH2e+z
         hy7UQByBCA6PwC7igiKzZIAN1+/iTTUl6JO2YFkMZq+S22PVqBSDYBU+NJNpr+NHwwMH
         A0kNcG/UT2YB+m7xEIQumZlD5c7jp2oZ9TvV1/jeQycyEw5YbXKK9+Bh+EKBNOJEzx82
         fMu7w5gcXnatH2EMQeS5o3jKdOphd4AET9zBCvFx9rww2HwafEMuXfTkPHByb7LZm7Rn
         CZnPtBRf7R6YyCfDE15mhSTvxmofGZchxpiunDmOPksV+GMYpZVQR1Wy8kXV1L/pDhdb
         6tqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766355055; x=1766959855;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QiLm+p5h09BwQ/VgsJKq6TFAfcpGR1sZeDMEGJGH3ew=;
        b=lfHVeumBCrSJtoviN8Bi2+/e1g0pf0BG3Qd9rHA/CqXt487PRI6XXPGt2/A6bvOrY+
         4GuIk3J3Kxe0zssJJ6vxVf8yR9PCfSfEpHiVmMJ8rHDdMaAcCxIACQUhGXZ5Fo2GWt5/
         NRayH9wr3yKhb+aAJk8nyJF34tsgztJ21UeqRwqAFpcxQKyYyRMtjxxOmAI3iMN/jMls
         VuP8Xqym8Z6tgO6BJJfAhSZmA7ldaJmVr7vcIOrlA4+QwGx9c+coJqNmH9yzIf2lDp0G
         WX/3iOIcUuUw+PgwyjiyDArgk9k70z6AjPKUtWgSO2K10AFf+Gu4OPAP7Oi1SnGFIFsF
         KRog==
X-Forwarded-Encrypted: i=1; AJvYcCW4AsHyLTfy2zFQLOUaxj0N5+lP5mfusqZeDQBwbweItbXPwE0BFS3AED/YOKjLY137ohcGBSYFhYvbQtTPya4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzZLpzyr6TSLKlR0Uc+MO1FhBgrt/3f2KbmXeFBOgfDHVdnfMs
	6gYDgyrQOT8bGMtjcgjvf/PhhPrVxipymFw1DA3bUJHKePWfHEuxkKO7
X-Gm-Gg: AY/fxX7b95rZ0NvahhCsF86FMH+isQQLZvfRUCg33nUYfQts5qvN88HaxfJjDjoY9Ss
	8MQKLtFpYArbszMFTk0F6pxiIeBEXrYaqc1JrEUos3ztvq+YTy6bGNxLRmjRpzvVgctxGxqfdi7
	M15/ZKZc4LUABHb/5G4mm97GmHbbnfD4rVHeAa2pk6Boa2RkGlAAd2evLDi1SAScqNXgH/GPDfA
	0C+h4gVp34hvJ8UC8oDzdLo+EZmx9fgHB/CbnYruqSuRhJfgeQ2xW/AQNX/1ddr9Z97knbrhqZ/
	7KrusanwRoWAGeipYA0YrzcigbLmj5B/7Ov7/ABWItIsuWN6GM5E79LKcAuHu8bR+zhBjmVifhf
	64aOXJk3bsiBMP/Har47AfctCkL3CFOeeypDUznupiQ4tlK/lqAlLfhd9XPcyzAeAAVBqU9a3g4
	PKbfMBbgsjLEtuhzDQ/WpoIfXCpLLmSQKlif+zAfM0IasC4RQxfts=
X-Google-Smtp-Source: AGHT+IFVkmIWyY3VovB0ooaWN16E7YNRegYvzVsw9beruXRg/cTnWuHr1PycSjbL8hQHJMwzwF/gYg==
X-Received: by 2002:a05:600d:6405:20b0:477:7a87:48d1 with SMTP id 5b1f17b1804b1-47d216bab2fmr44553095e9.30.1766355054444;
        Sun, 21 Dec 2025 14:10:54 -0800 (PST)
Received: from pumpkin (host-2-103-239-165.as13285.net. [2.103.239.165])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47be2723b2bsm207509845e9.3.2025.12.21.14.10.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Dec 2025 14:10:54 -0800 (PST)
Date: Sun, 21 Dec 2025 22:10:52 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Li Wang <liwang@redhat.com>
Cc: akpm@linux-foundation.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, David Hildenbrand
 <david@kernel.org>, Mark Brown <broonie@kernel.org>, Shuah Khan
 <shuah@kernel.org>, Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v3 1/3] selftests/mm/write_to_hugetlbfs: parse -s as
 size_t
Message-ID: <20251221221052.3b769fc2@pumpkin>
In-Reply-To: <20251221122639.3168038-2-liwang@redhat.com>
References: <20251221122639.3168038-1-liwang@redhat.com>
	<20251221122639.3168038-2-liwang@redhat.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 21 Dec 2025 20:26:37 +0800
Li Wang <liwang@redhat.com> wrote:

> write_to_hugetlbfs currently parses the -s size argument with atoi()
> into an int. This silently accepts malformed input, cannot report overflow,
> and can truncate large sizes.

And sscanf() will just ignore invalid trailing characters.
Probably much the same as atoi() apart from a leading '-'.

Maybe you could use "%zu%c" and check the count is 1 - but I bet
some static checker won't like that.

Using strtoul() and checking the terminating character is 'reasonable',
but won't detect overflow.

	David

> 
> --- Error log ---
>  # uname -r
>  6.12.0-xxx.el10.aarch64+64k
> 
>  # ls /sys/kernel/mm/hugepages/hugepages-*
>  hugepages-16777216kB/  hugepages-2048kB/  hugepages-524288kB/
> 
>  #./charge_reserved_hugetlb.sh -cgroup-v2
>  # -----------------------------------------
>  ...
>  # nr hugepages = 10
>  # writing cgroup limit: 5368709120
>  # writing reseravation limit: 5368709120
>  ...
>  # Writing to this path: /mnt/huge/test
>  # Writing this size: -1610612736        <--------
> 
> Switch the size variable to size_t and parse -s with sscanf("%zu", ...).
> Also print the size using %zu.
> 
> This avoids incorrect behavior with large -s values and makes the utility
> more robust.
> 
> Signed-off-by: Li Wang <liwang@redhat.com>
> Cc: David Hildenbrand <david@kernel.org>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Shuah Khan <shuah@kernel.org>
> Cc: Waiman Long <longman@redhat.com>
> Acked-by: David Hildenbrand (Red Hat) <david@kernel.org>
> ---
>  tools/testing/selftests/mm/write_to_hugetlbfs.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/mm/write_to_hugetlbfs.c b/tools/testing/selftests/mm/write_to_hugetlbfs.c
> index 34c91f7e6128..ecb5f7619960 100644
> --- a/tools/testing/selftests/mm/write_to_hugetlbfs.c
> +++ b/tools/testing/selftests/mm/write_to_hugetlbfs.c
> @@ -68,7 +68,7 @@ int main(int argc, char **argv)
>  	int key = 0;
>  	int *ptr = NULL;
>  	int c = 0;
> -	int size = 0;
> +	size_t size = 0;
>  	char path[256] = "";
>  	enum method method = MAX_METHOD;
>  	int want_sleep = 0, private = 0;
> @@ -86,7 +86,10 @@ int main(int argc, char **argv)
>  	while ((c = getopt(argc, argv, "s:p:m:owlrn")) != -1) {
>  		switch (c) {
>  		case 's':
> -			size = atoi(optarg);
> +			if (sscanf(optarg, "%zu", &size) != 1) {
> +				perror("Invalid -s.");
> +				exit_usage();
> +			}
>  			break;
>  		case 'p':
>  			strncpy(path, optarg, sizeof(path) - 1);
> @@ -131,7 +134,7 @@ int main(int argc, char **argv)
>  	}
>  
>  	if (size != 0) {
> -		printf("Writing this size: %d\n", size);
> +		printf("Writing this size: %zu\n", size);
>  	} else {
>  		errno = EINVAL;
>  		perror("size not found");


