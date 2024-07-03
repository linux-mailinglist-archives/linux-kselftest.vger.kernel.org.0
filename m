Return-Path: <linux-kselftest+bounces-13102-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0CC6925264
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Jul 2024 06:34:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 002531C20A55
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Jul 2024 04:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EECCE28379;
	Wed,  3 Jul 2024 04:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SIpWIzdj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B8317996;
	Wed,  3 Jul 2024 04:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719981266; cv=none; b=Lyel44jaPczJrTGj3UUMcBC6MoKRFJaWiKLP+r3eZqzNan7rhGGmGMA4tJFmgFXcfPrtolUi6Okh9sZw85VqgaGjTp5p/39/QiQ+zMD8T0fqovBCsGna2qB2hpADHqWEzcmwfy5ispoWSDJuo9l+yH5Tw/5Fu38orawMxhROVVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719981266; c=relaxed/simple;
	bh=hA07BEY0wv1aUFCpoFEZd1Kg8iHj9zNGGJiu9YlVNvY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dJhrOcdGqnTxHBVAsSLy5lqFvNczesslncad+NNVDyimkZHMy5IZmICQSg6qinarnbu8AYfczBJfK8Zz20tBiATUTQxBKS3qLK25WxxCHp/1Cxrw/bIjBda3FhRZno85GFzLsWY5h6axz+o+C//QVs3bfVohU1zeEXTYlteAZUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SIpWIzdj; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719981265; x=1751517265;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=hA07BEY0wv1aUFCpoFEZd1Kg8iHj9zNGGJiu9YlVNvY=;
  b=SIpWIzdjlfpqSS6Zp6KjHxjTQrUARJkg1AlrnGgIP44EfR8QnY1LuHk0
   agzXCL4z2Elnjglbx8JdnmNPch3mPvuepfpo+3eJgbr/6oM0thJp6S9eH
   W9xlDn2u2otKsbDulH9e472d9EzBimkswbCMSLuH28PZ5SFR91Or0L26Q
   fUbNv3eDeLCVi/wT9v6BDlARAPR1rmDWwWZqNk85CSh6oeQo6sx6bChA4
   abslCnqhOxiyme9wz0NgNvgSQw0AKkrRrftAlSLMgmYd+N8RJB6kz8Nen
   LptziAabp6hyHmqpw8yi/zoTh68LcWiLODv/Bp6g3jdtWbxCdkW58TRfC
   A==;
X-CSE-ConnectionGUID: CqJycVz9SNy9twP37HxCuw==
X-CSE-MsgGUID: HMTSE2iBT0iAjHTC3OObbg==
X-IronPort-AV: E=McAfee;i="6700,10204,11121"; a="39706993"
X-IronPort-AV: E=Sophos;i="6.09,181,1716274800"; 
   d="scan'208";a="39706993"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2024 21:34:25 -0700
X-CSE-ConnectionGUID: xeFqXh3KSt2eLyOpxOevFQ==
X-CSE-MsgGUID: a8aTvO1KRdmMAuvJThKFKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,181,1716274800"; 
   d="scan'208";a="50729802"
Received: from unknown (HELO [10.247.172.64]) ([10.247.172.64])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2024 21:34:21 -0700
Message-ID: <24a4b3cfaf02ca3d68757bc6c198e35160605590.camel@linux.intel.com>
Subject: Re: [PATCH v2 1/2] selftests/thermel/intel: conform the test to TAP
 output
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: Muhammad Usama Anjum <usama.anjum@collabora.com>, "Rafael J . Wysocki"
	 <rafael.j.wysocki@intel.com>, Shuah Khan <shuah@kernel.org>
Cc: kernel@collabora.com, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Tue, 02 Jul 2024 21:34:17 -0700
In-Reply-To: <20240702101259.1251377-1-usama.anjum@collabora.com>
References: <20240702101259.1251377-1-usama.anjum@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.0-1 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-07-02 at 15:12 +0500, Muhammad Usama Anjum wrote:
> Conform the layout, informational and status messages to TAP. No
> functional change is intended other than the layout of output
> messages.
>=20
> The test has infitie
infinite

>  loop to read the value of index_str. Break the loop
> after successfully reading the value once and finished the test.
>=20
That is not correct. This loops till SIGINT | SIGTERM | SIGHUP

Anyway this comment is not relevant for what you are doing here.

> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>


Thanks,
Srinivas

> ---
> Changes since v1:
> - Use ksft_exit_fail_perror if read() returns error
> - Break the infinite loop after printing index_str
> ---
> =C2=A0.../intel/workload_hint/workload_hint_test.c=C2=A0 | 103 ++++++++--=
------
> --
> =C2=A01 file changed, 43 insertions(+), 60 deletions(-)
>=20
> diff --git
> a/tools/testing/selftests/thermal/intel/workload_hint/workload_hint_t
> est.c
> b/tools/testing/selftests/thermal/intel/workload_hint/workload_hint_t
> est.c
> index 217c3a641c537..0e5f07efc8a2b 100644
> ---
> a/tools/testing/selftests/thermal/intel/workload_hint/workload_hint_t
> est.c
> +++
> b/tools/testing/selftests/thermal/intel/workload_hint/workload_hint_t
> est.c
> @@ -9,6 +9,7 @@
> =C2=A0#include <fcntl.h>
> =C2=A0#include <poll.h>
> =C2=A0#include <signal.h>
> +#include "../../../kselftest.h"
> =C2=A0
> =C2=A0#define WORKLOAD_NOTIFICATION_DELAY_ATTRIBUTE
> "/sys/bus/pci/devices/0000:00:04.0/workload_hint/notification_delay_m
> s"
> =C2=A0#define WORKLOAD_ENABLE_ATTRIBUTE
> "/sys/bus/pci/devices/0000:00:04.0/workload_hint/workload_hint_enable
> "
> @@ -31,17 +32,13 @@ void workload_hint_exit(int signum)
> =C2=A0	/* Disable feature via sysfs knob */
> =C2=A0
> =C2=A0	fd =3D open(WORKLOAD_ENABLE_ATTRIBUTE, O_RDWR);
> -	if (fd < 0) {
> -		perror("Unable to open workload type feature enable
> file\n");
> -		exit(1);
> -	}
> +	if (fd < 0)
> +		ksft_exit_fail_perror("Unable to open workload type
> feature enable file");
> =C2=A0
> -	if (write(fd, "0\n", 2) < 0) {
> -		perror("Can' disable workload hints\n");
> -		exit(1);
> -	}
> +	if (write(fd, "0\n", 2) < 0)
> +		ksft_exit_fail_perror("Can' disable workload
> hints");
> =C2=A0
> -	printf("Disabled workload type prediction\n");
> +	ksft_print_msg("Disabled workload type prediction\n");
> =C2=A0
> =C2=A0	close(fd);
> =C2=A0}
> @@ -54,32 +51,27 @@ int main(int argc, char **argv)
> =C2=A0	char delay_str[64];
> =C2=A0	int delay =3D 0;
> =C2=A0
> -	printf("Usage: workload_hint_test [notification delay in
> milli seconds]\n");
> +	ksft_print_header();
> +	ksft_set_plan(1);
> +
> +	ksft_print_msg("Usage: workload_hint_test [notification
> delay in milli seconds]\n");
> =C2=A0
> =C2=A0	if (argc > 1) {
> =C2=A0		ret =3D sscanf(argv[1], "%d", &delay);
> -		if (ret < 0) {
> -			printf("Invalid delay\n");
> -			exit(1);
> -		}
> +		if (ret < 0)
> +			ksft_exit_fail_perror("Invalid delay");
> =C2=A0
> -		printf("Setting notification delay to %d ms\n",
> delay);
> +		ksft_print_msg("Setting notification delay to %d
> ms\n", delay);
> =C2=A0		if (delay < 0)
> -			exit(1);
> -
> -		sprintf(delay_str, "%s\n", argv[1]);
> +			ksft_exit_fail_msg("delay can never be
> negative\n");
> =C2=A0
> =C2=A0		sprintf(delay_str, "%s\n", argv[1]);
> =C2=A0		fd =3D open(WORKLOAD_NOTIFICATION_DELAY_ATTRIBUTE,
> O_RDWR);
> -		if (fd < 0) {
> -			perror("Unable to open workload notification
> delay\n");
> -			exit(1);
> -		}
> +		if (fd < 0)
> +			ksft_exit_fail_perror("Unable to open
> workload notification delay");
> =C2=A0
> -		if (write(fd, delay_str, strlen(delay_str)) < 0) {
> -			perror("Can't set delay\n");
> -			exit(1);
> -		}
> +		if (write(fd, delay_str, strlen(delay_str)) < 0)
> +			ksft_exit_fail_perror("Can't set delay");
> =C2=A0
> =C2=A0		close(fd);
> =C2=A0	}
> @@ -93,65 +85,56 @@ int main(int argc, char **argv)
> =C2=A0
> =C2=A0	/* Enable feature via sysfs knob */
> =C2=A0	fd =3D open(WORKLOAD_ENABLE_ATTRIBUTE, O_RDWR);
> -	if (fd < 0) {
> -		perror("Unable to open workload type feature enable
> file\n");
> -		exit(1);
> -	}
> +	if (fd < 0)
> +		ksft_exit_fail_perror("Unable to open workload type
> feature enable file");
> =C2=A0
> -	if (write(fd, "1\n", 2) < 0) {
> -		perror("Can' enable workload hints\n");
> -		exit(1);
> -	}
> +	if (write(fd, "1\n", 2) < 0)
> +		ksft_exit_fail_perror("Can' enable workload hints");
> =C2=A0
> =C2=A0	close(fd);
> =C2=A0
> -	printf("Enabled workload type prediction\n");
> +	ksft_print_msg("Enabled workload type prediction\n");
> =C2=A0
> =C2=A0	while (1) {
> =C2=A0		fd =3D open(WORKLOAD_TYPE_INDEX_ATTRIBUTE, O_RDONLY);
> -		if (fd < 0) {
> -			perror("Unable to open workload type
> file\n");
> -			exit(1);
> -		}
> +		if (fd < 0)
> +			ksft_exit_fail_perror("Unable to open
> workload type file");
> =C2=A0
> -		if ((lseek(fd, 0L, SEEK_SET)) < 0) {
> -			fprintf(stderr, "Failed to set pointer to
> beginning\n");
> -			exit(1);
> -		}
> +		if ((lseek(fd, 0L, SEEK_SET)) < 0)
> +			ksft_exit_fail_perror("Failed to set pointer
> to beginning");
> =C2=A0
> -		if (read(fd, index_str, sizeof(index_str)) < 0) {
> -			fprintf(stderr, "Failed to read from:%s\n",
> -			WORKLOAD_TYPE_INDEX_ATTRIBUTE);
> -			exit(1);
> -		}
> +		if (read(fd, index_str, sizeof(index_str)) < 0)
> +			ksft_exit_fail_perror("Failed to read from:
> workload_type_index");
> =C2=A0
> =C2=A0		ufd.fd =3D fd;
> =C2=A0		ufd.events =3D POLLPRI;
> =C2=A0
> =C2=A0		ret =3D poll(&ufd, 1, -1);
> =C2=A0		if (ret < 0) {
> -			perror("poll error");
> -			exit(1);
> +			ksft_exit_fail_perror("poll error");
> =C2=A0		} else if (ret =3D=3D 0) {
> -			printf("Poll Timeout\n");
> +			ksft_print_msg("Poll Timeout\n");
> =C2=A0		} else {
> -			if ((lseek(fd, 0L, SEEK_SET)) < 0) {
> -				fprintf(stderr, "Failed to set
> pointer to beginning\n");
> -				exit(1);
> -			}
> +			if ((lseek(fd, 0L, SEEK_SET)) < 0)
> +				ksft_exit_fail_perror("Failed to set
> pointer to beginning");
> =C2=A0
> =C2=A0			if (read(fd, index_str, sizeof(index_str)) <
> 0)
> -				exit(0);
> +				ksft_exit_fail_perror("Failed to
> read");
> =C2=A0
> =C2=A0			ret =3D sscanf(index_str, "%d", &index);
> =C2=A0			if (ret < 0)
> +				ksft_exit_fail_msg("Read negative
> value unexpectedly\n");
> +			if (index > WORKLOAD_TYPE_MAX_INDEX) {
> +				ksft_print_msg("Invalid workload
> type index\n");
> +			} else {
> +				ksft_print_msg("workload type:%s\n",
> workload_types[index]);
> =C2=A0				break;
> -			if (index > WORKLOAD_TYPE_MAX_INDEX)
> -				printf("Invalid workload type
> index\n");
> -			else
> -				printf("workload type:%s\n",
> workload_types[index]);
> +			}
> =C2=A0		}
> =C2=A0
> =C2=A0		close(fd);
> =C2=A0	}
> +
> +	ksft_test_result_pass("Successfully read\n");
> +	ksft_finished();
> =C2=A0}


