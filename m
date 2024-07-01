Return-Path: <linux-kselftest+bounces-12990-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3587791DA14
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Jul 2024 10:36:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 521A8B21057
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Jul 2024 08:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15333824AF;
	Mon,  1 Jul 2024 08:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="qsMRnmYW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6314A2C6BB;
	Mon,  1 Jul 2024 08:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719822975; cv=none; b=u+7F7Efs3viacgEXxO+RyEmpRdXNUXhLEVzDpXRBa9GFkpTA1WzY46z4qqIQhz9z/o2Oq2wl8IH4MMbk1Bz7hDxlJglxMJ8rt0ASutu+S5nMr9EKZ2xfNuwXK4hTbtYmZBO5gPmGO6vlKWf99RIleYP3HL2pi7t2YF37YK+0Gcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719822975; c=relaxed/simple;
	bh=AFa6/dHvt/LhM6hWXPrziFT3MNJVVyrpYxI3m0LYqZo=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=i3HkWSygBuTpOsklE/s3s25C+M4YrQmi0hLFT7Sjh6Tbrfcr7zluIHa7b8GRiQWMaBZ8fy+TSWFm5xyiDak+kJ8+5pbedKKktSiaQf9IC0I1aqHJogDDF90uOV1XmyYnYu6CM7otCg4UADpaW4xJ585JQkSUEYntZnW4+aUmgtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=qsMRnmYW; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1719822971;
	bh=AFa6/dHvt/LhM6hWXPrziFT3MNJVVyrpYxI3m0LYqZo=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=qsMRnmYWMw9or/yBep2eEJg7uPEAhAxhgsqelAqsscj2r4YqRUfhj+JBonM0rdLIV
	 1iLblzGNsFT8hiP+psYAx9Hu50LiJKFRPDYM60jv+1GEyrb5qquZPnw8g3716yCMzI
	 KAwFnwHQzK8hJlUhpNmVBVc05ez6VGO21FsQO+W/zMw6voggZ1LE/BqB1h7z/sqjtG
	 GMvt2IPX26Uo7/8a0sdbwFdjQ4LvwruwnB5C+dimfYHEFHaZ4BoX1JLySMJ86mUKKO
	 ljpw+WdEww3lj3d3xir9TVn6oEI/jTf1rrfLxi6pYuZoJYYcFlCvBc42G2Bf60wdUG
	 Vr6al4c9Aehfg==
Received: from [100.113.15.66] (ec2-34-240-57-77.eu-west-1.compute.amazonaws.com [34.240.57.77])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 160E63782109;
	Mon,  1 Jul 2024 08:36:07 +0000 (UTC)
Message-ID: <175ac98f-481f-46e2-a3f7-206b64d8b0e9@collabora.com>
Date: Mon, 1 Jul 2024 13:36:04 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>, kernel@collabora.com,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] selftests/thermel/intel: conform the test to TAP
 output
To: Shuah Khan <shuah@kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
References: <20240522170655.2879712-1-usama.anjum@collabora.com>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20240522170655.2879712-1-usama.anjum@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Soft reminder

On 5/22/24 10:06 PM, Muhammad Usama Anjum wrote:
> Conform the layout, informational and status messages to TAP. No
> functional change is intended other than the layout of output messages.
> 
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---
>  .../intel/workload_hint/workload_hint_test.c  | 98 ++++++++-----------
>  1 file changed, 39 insertions(+), 59 deletions(-)
> 
> diff --git a/tools/testing/selftests/thermal/intel/workload_hint/workload_hint_test.c b/tools/testing/selftests/thermal/intel/workload_hint/workload_hint_test.c
> index 217c3a641c537..d107c2d6f3a22 100644
> --- a/tools/testing/selftests/thermal/intel/workload_hint/workload_hint_test.c
> +++ b/tools/testing/selftests/thermal/intel/workload_hint/workload_hint_test.c
> @@ -9,6 +9,7 @@
>  #include <fcntl.h>
>  #include <poll.h>
>  #include <signal.h>
> +#include "../../../kselftest.h"
>  
>  #define WORKLOAD_NOTIFICATION_DELAY_ATTRIBUTE "/sys/bus/pci/devices/0000:00:04.0/workload_hint/notification_delay_ms"
>  #define WORKLOAD_ENABLE_ATTRIBUTE "/sys/bus/pci/devices/0000:00:04.0/workload_hint/workload_hint_enable"
> @@ -31,17 +32,13 @@ void workload_hint_exit(int signum)
>  	/* Disable feature via sysfs knob */
>  
>  	fd = open(WORKLOAD_ENABLE_ATTRIBUTE, O_RDWR);
> -	if (fd < 0) {
> -		perror("Unable to open workload type feature enable file\n");
> -		exit(1);
> -	}
> +	if (fd < 0)
> +		ksft_exit_fail_perror("Unable to open workload type feature enable file");
>  
> -	if (write(fd, "0\n", 2) < 0) {
> -		perror("Can' disable workload hints\n");
> -		exit(1);
> -	}
> +	if (write(fd, "0\n", 2) < 0)
> +		ksft_exit_fail_perror("Can' disable workload hints");
>  
> -	printf("Disabled workload type prediction\n");
> +	ksft_print_msg("Disabled workload type prediction\n");
>  
>  	close(fd);
>  }
> @@ -54,32 +51,27 @@ int main(int argc, char **argv)
>  	char delay_str[64];
>  	int delay = 0;
>  
> -	printf("Usage: workload_hint_test [notification delay in milli seconds]\n");
> +	ksft_print_header();
> +	ksft_set_plan(1);
> +
> +	ksft_print_msg("Usage: workload_hint_test [notification delay in milli seconds]\n");
>  
>  	if (argc > 1) {
>  		ret = sscanf(argv[1], "%d", &delay);
> -		if (ret < 0) {
> -			printf("Invalid delay\n");
> -			exit(1);
> -		}
> +		if (ret < 0)
> +			ksft_exit_fail_perror("Invalid delay");
>  
> -		printf("Setting notification delay to %d ms\n", delay);
> +		ksft_print_msg("Setting notification delay to %d ms\n", delay);
>  		if (delay < 0)
> -			exit(1);
> -
> -		sprintf(delay_str, "%s\n", argv[1]);
> +			ksft_exit_fail_msg("delay can never be negative\n");
>  
>  		sprintf(delay_str, "%s\n", argv[1]);
>  		fd = open(WORKLOAD_NOTIFICATION_DELAY_ATTRIBUTE, O_RDWR);
> -		if (fd < 0) {
> -			perror("Unable to open workload notification delay\n");
> -			exit(1);
> -		}
> +		if (fd < 0)
> +			ksft_exit_fail_perror("Unable to open workload notification delay");
>  
> -		if (write(fd, delay_str, strlen(delay_str)) < 0) {
> -			perror("Can't set delay\n");
> -			exit(1);
> -		}
> +		if (write(fd, delay_str, strlen(delay_str)) < 0)
> +			ksft_exit_fail_perror("Can't set delay");
>  
>  		close(fd);
>  	}
> @@ -93,63 +85,51 @@ int main(int argc, char **argv)
>  
>  	/* Enable feature via sysfs knob */
>  	fd = open(WORKLOAD_ENABLE_ATTRIBUTE, O_RDWR);
> -	if (fd < 0) {
> -		perror("Unable to open workload type feature enable file\n");
> -		exit(1);
> -	}
> +	if (fd < 0)
> +		ksft_exit_fail_perror("Unable to open workload type feature enable file");
>  
> -	if (write(fd, "1\n", 2) < 0) {
> -		perror("Can' enable workload hints\n");
> -		exit(1);
> -	}
> +	if (write(fd, "1\n", 2) < 0)
> +		ksft_exit_fail_perror("Can' enable workload hints");
>  
>  	close(fd);
>  
> -	printf("Enabled workload type prediction\n");
> +	ksft_print_msg("Enabled workload type prediction\n");
>  
>  	while (1) {
>  		fd = open(WORKLOAD_TYPE_INDEX_ATTRIBUTE, O_RDONLY);
> -		if (fd < 0) {
> -			perror("Unable to open workload type file\n");
> -			exit(1);
> -		}
> +		if (fd < 0)
> +			ksft_exit_fail_perror("Unable to open workload type file");
>  
> -		if ((lseek(fd, 0L, SEEK_SET)) < 0) {
> -			fprintf(stderr, "Failed to set pointer to beginning\n");
> -			exit(1);
> -		}
> +		if ((lseek(fd, 0L, SEEK_SET)) < 0)
> +			ksft_exit_fail_perror("Failed to set pointer to beginning");
>  
> -		if (read(fd, index_str, sizeof(index_str)) < 0) {
> -			fprintf(stderr, "Failed to read from:%s\n",
> -			WORKLOAD_TYPE_INDEX_ATTRIBUTE);
> -			exit(1);
> -		}
> +		if (read(fd, index_str, sizeof(index_str)) < 0)
> +			ksft_exit_fail_perror("Failed to read from: workload_type_index");
>  
>  		ufd.fd = fd;
>  		ufd.events = POLLPRI;
>  
>  		ret = poll(&ufd, 1, -1);
>  		if (ret < 0) {
> -			perror("poll error");
> -			exit(1);
> +			ksft_exit_fail_perror("poll error");
>  		} else if (ret == 0) {
> -			printf("Poll Timeout\n");
> +			ksft_print_msg("Poll Timeout\n");
>  		} else {
> -			if ((lseek(fd, 0L, SEEK_SET)) < 0) {
> -				fprintf(stderr, "Failed to set pointer to beginning\n");
> -				exit(1);
> -			}
> +			if ((lseek(fd, 0L, SEEK_SET)) < 0)
> +				ksft_exit_fail_perror("Failed to set pointer to beginning");
>  
> -			if (read(fd, index_str, sizeof(index_str)) < 0)
> -				exit(0);
> +			if (read(fd, index_str, sizeof(index_str)) < 0) {
> +				ksft_test_result_pass("Successfully read\n");
> +				ksft_finished();
> +			}
>  
>  			ret = sscanf(index_str, "%d", &index);
>  			if (ret < 0)
>  				break;
>  			if (index > WORKLOAD_TYPE_MAX_INDEX)
> -				printf("Invalid workload type index\n");
> +				ksft_print_msg("Invalid workload type index\n");
>  			else
> -				printf("workload type:%s\n", workload_types[index]);
> +				ksft_print_msg("workload type:%s\n", workload_types[index]);
>  		}
>  
>  		close(fd);

-- 
BR,
Muhammad Usama Anjum

