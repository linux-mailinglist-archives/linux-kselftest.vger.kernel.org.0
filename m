Return-Path: <linux-kselftest+bounces-13122-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 999E6925391
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Jul 2024 08:19:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B2E91F237F6
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Jul 2024 06:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBCD985934;
	Wed,  3 Jul 2024 06:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="N6BB8wre"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D18F04501E;
	Wed,  3 Jul 2024 06:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719987554; cv=none; b=VgSi1is1wGekhrSRJxkhVNRIHwc0nT0rGfWoPvytTb+kQ9sbwqq7PRe9emU7pvc4V6BXj+SIQbkQhk8N4JW+9aU4pAdM2Z8XIZ+KOVOI2IqiujvfG/MDDUPImGbtd6nZV3RR79Qm4JDlBvubCCc5Jh7/9zM06m0/StsbYzj8eok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719987554; c=relaxed/simple;
	bh=zMYpqvd0DDBLcnkZqDMLheHzOxiRWgeFrQ7fSfz/+Z4=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=GVgpO4Xc2KVfxhIB+Q6fIO58GZpY/F+5JqyTgHe81cjMrdeZWXRig8uBFREN2ihQqHrmM97fX6IMN5wg4FQKMQrMUFzNqTyzkGz3S7BkE8iuVirHOlzqD2Xq8V4PkqR0hO0mNADt8CzBMICEZ5M+2iHNkVWas8TWsdWogH3F+Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=N6BB8wre; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1719987550;
	bh=zMYpqvd0DDBLcnkZqDMLheHzOxiRWgeFrQ7fSfz/+Z4=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=N6BB8wrefrxzNZ7Ak3OI7zH9CfE3Ebz6K8L1veRE6MdsMhN8z4DOzEIuNeOUNCXao
	 K10/n+LtcWA515x+uwiRD5yt3PQuy7W7sluZ4+05pseNjnp6Qasjj09f0gZvmhl9LC
	 eeqhGRsA+fPnT8QlfxE/9e84HqaN49i2WEhyMrvvVKroxjG4CETFyCN7EtnM0+a170
	 3DAnVtyE4/UFEILVhduKYo+fHa/f9kciJUK9a/ah9ARjB4TcIdqnUdC1LBBx9Cuu66
	 3RZTG/KEoWYixKzQVtDioC0cw9yJHPoNPqqghbRxZiXwDS9+f9/2aM6s+WVu46LzSn
	 HGRCIVCYAwuYA==
Received: from [100.113.15.66] (ec2-34-240-57-77.eu-west-1.compute.amazonaws.com [34.240.57.77])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 72BD8378202D;
	Wed,  3 Jul 2024 06:19:07 +0000 (UTC)
Message-ID: <81fe07bb-8980-4fca-950a-7945b6f8563a@collabora.com>
Date: Wed, 3 Jul 2024 11:19:03 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>, kernel@collabora.com,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] selftests/thermel/intel: conform the test to TAP
 output
To: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>,
 "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
 Shuah Khan <shuah@kernel.org>
References: <20240702101259.1251377-1-usama.anjum@collabora.com>
 <20240702101259.1251377-2-usama.anjum@collabora.com>
 <7142312c6a9e2aa96134031be435448c56d1897e.camel@linux.intel.com>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <7142312c6a9e2aa96134031be435448c56d1897e.camel@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/3/24 9:40 AM, srinivas pandruvada wrote:
> On Tue, 2024-07-02 at 15:12 +0500, Muhammad Usama Anjum wrote:
>> Conform the layout, informational and status messages to TAP. No
>> functional change is intended other than the layout of output
>> messages.
>>
> Not true. You did functional change by adding a break in the loop.
> The purpose here to wait for these message continuously till ctrl-c or
> similar.
I'll correct the description.

> 
>> The test has infinite loop to read the value of status_str. Break the
>> loop after getting the value once and finish the test.
>>
> No, that is not the purpose.
We want to finish the test after some iterations as in CIs we cannot abort
the test by sending signals. Would 10 or 100 iterations be enough for this
test? Or it is the kind of test which wouldn't get events until some other
process is using the same driver files?

> 
>> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
>> ---
>> Changes since v1:
>> - Use ksft_exit_fail_perror if read() returns error
>> - Break the infinite loop after printing status_str
>> ---
>>  .../intel/power_floor/power_floor_test.c      | 70 ++++++++---------
>> --
>>  1 file changed, 30 insertions(+), 40 deletions(-)
>>
>> diff --git
>> a/tools/testing/selftests/thermal/intel/power_floor/power_floor_test.
>> c
>> b/tools/testing/selftests/thermal/intel/power_floor/power_floor_test.
>> c
>> index 0326b39a11b91..c06b275acd36b 100644
>> ---
>> a/tools/testing/selftests/thermal/intel/power_floor/power_floor_test.
>> c
>> +++
>> b/tools/testing/selftests/thermal/intel/power_floor/power_floor_test.
>> c
>> @@ -9,6 +9,7 @@
>>  #include <fcntl.h>
>>  #include <poll.h>
>>  #include <signal.h>
>> +#include "../../../kselftest.h"
>>  
>>  #define POWER_FLOOR_ENABLE_ATTRIBUTE
>> "/sys/bus/pci/devices/0000:00:04.0/power_limits/power_floor_enable"
>>  #define POWER_FLOOR_STATUS_ATTRIBUTE 
>> "/sys/bus/pci/devices/0000:00:04.0/power_limits/power_floor_status"
>> @@ -20,17 +21,13 @@ void power_floor_exit(int signum)
>>  	/* Disable feature via sysfs knob */
>>  
>>  	fd = open(POWER_FLOOR_ENABLE_ATTRIBUTE, O_RDWR);
>> -	if (fd < 0) {
>> -		perror("Unable to open power floor enable file\n");
>> -		exit(1);
>> -	}
>> +	if (fd < 0)
>> +		ksft_exit_fail_perror("Unable to open power floor
>> enable file");
>>  
>> -	if (write(fd, "0\n", 2) < 0) {
>> -		perror("Can' disable power floor notifications\n");
>> -		exit(1);
>> -	}
>> +	if (write(fd, "0\n", 2) < 0)
>> +		ksft_exit_fail_perror("Can' disable power floor
>> notifications");
>>  
>> -	printf("Disabled power floor notifications\n");
>> +	ksft_print_msg("Disabled power floor notifications\n");
>>  
>>  	close(fd);
>>  }
>> @@ -41,6 +38,9 @@ int main(int argc, char **argv)
>>  	char status_str[3];
>>  	int fd, ret;
>>  
>> +	ksft_print_header();
>> +	ksft_set_plan(1);
>> +
>>  	if (signal(SIGINT, power_floor_exit) == SIG_IGN)
>>  		signal(SIGINT, SIG_IGN);
>>  	if (signal(SIGHUP, power_floor_exit) == SIG_IGN)
>> @@ -50,59 +50,49 @@ int main(int argc, char **argv)
>>  
>>  	/* Enable feature via sysfs knob */
>>  	fd = open(POWER_FLOOR_ENABLE_ATTRIBUTE, O_RDWR);
>> -	if (fd < 0) {
>> -		perror("Unable to open power floor enable file\n");
>> -		exit(1);
>> -	}
>> +	if (fd < 0)
>> +		ksft_exit_fail_perror("Unable to open power floor
>> enable file");
>>  
>> -	if (write(fd, "1\n", 2) < 0) {
>> -		perror("Can' enable power floor notifications\n");
>> -		exit(1);
>> -	}
>> +	if (write(fd, "1\n", 2) < 0)
>> +		ksft_exit_fail_perror("Can' enable power floor
>> notifications");
>>  
>>  	close(fd);
>>  
>> -	printf("Enabled power floor notifications\n");
>> +	ksft_print_msg("Enabled power floor notifications\n");
>>  
>>  	while (1) {
>>  		fd = open(POWER_FLOOR_STATUS_ATTRIBUTE, O_RDONLY);
>> -		if (fd < 0) {
>> -			perror("Unable to power floor status
>> file\n");
>> -			exit(1);
>> -		}
>> +		if (fd < 0)
>> +			ksft_exit_fail_perror("Unable to power floor
>> status file");
>>  
>> -		if ((lseek(fd, 0L, SEEK_SET)) < 0) {
>> -			fprintf(stderr, "Failed to set pointer to
>> beginning\n");
>> -			exit(1);
>> -		}
>> +		if ((lseek(fd, 0L, SEEK_SET)) < 0)
>> +			ksft_exit_fail_perror("Failed to set pointer
>> to beginning\n");
>>  
>> -		if (read(fd, status_str, sizeof(status_str)) < 0) {
>> -			fprintf(stderr, "Failed to read from:%s\n",
>> -			POWER_FLOOR_STATUS_ATTRIBUTE);
>> -			exit(1);
>> -		}
>> +		if (read(fd, status_str, sizeof(status_str)) < 0)
>> +			ksft_exit_fail_perror("Failed to read from:
>> power_floor_status");
>>  
>>  		ufd.fd = fd;
>>  		ufd.events = POLLPRI;
>>  
>>  		ret = poll(&ufd, 1, -1);
>>  		if (ret < 0) {
>> -			perror("poll error");
>> -			exit(1);
>> +			ksft_exit_fail_msg("Poll error\n");
>>  		} else if (ret == 0) {
>> -			printf("Poll Timeout\n");
>> +			ksft_print_msg("Poll Timeout\n");
>>  		} else {
>> -			if ((lseek(fd, 0L, SEEK_SET)) < 0) {
>> -				fprintf(stderr, "Failed to set
>> pointer to beginning\n");
>> -				exit(1);
>> -			}
>> +			if ((lseek(fd, 0L, SEEK_SET)) < 0)
>> +				ksft_exit_fail_msg("Failed to set
>> pointer to beginning\n");
>>  
>>  			if (read(fd, status_str, sizeof(status_str))
>> < 0)
>> -				exit(0);
>> +				ksft_exit_fail_perror("Failed to
>> read");
>>  
>> -			printf("power floor status: %s\n",
>> status_str);
>> +			ksft_print_msg("power floor status: %s\n",
>> status_str);
>> +			break;
>>  		}
>>  
>>  		close(fd);
>>  	}
>> +
>> +	ksft_test_result_pass("Successfully read\n");
>> +	ksft_finished();
>>  }
> 
> 

-- 
BR,
Muhammad Usama Anjum

